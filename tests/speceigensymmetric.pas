{ SpecEigenSymmetric - SymmetricEigenpairs and HermitianEigenpairs.

  Test spectra follow the LAPACK symmetric eigenproblem tests (xCHKST,
  xDRVST): zero, identity, diagonal, arithmetic and geometric spectra with
  cond = 1/eps and sqrt(1/eps), one large or one small eigenvalue
  (clusters), mixed signs, repeated eigenvalues, scaling near underflow and
  overflow, plus classical tridiagonal matrices. Ratios (sep.in, threshold
  50):

    ZHET21  ||A - V*D*V^H||_1 / (n ||A||_1 ulp)
    ZUNT01  ||I - V^H*V||_1 / (n ulp)

  Eigenvalues of a Hermitian matrix are perfectly conditioned (Weyl:
  |lambda_i(A+E) - lambda_i(A)| <= ||E||_2), so the computed ones are
  compared with the prescribed spectrum relative to n*||A||_2*ulp. }
unit SpecEigenSymmetric;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}
{$modeswitch nestedprocvars}

interface

implementation

uses
  SysUtils, Math, ADimMath, TestRunner, TestDoubleDouble, TestGenerators,
  TestMeasures;

type
  TSpectrum = (spZero, spIdentity, spArithmetic, spGeometric, spSqrtGeometric,
    spOneLarge, spOneSmall, spMixedSigns, spRepeated, spTiny, spHuge);

const
  SpectrumNames: array[TSpectrum] of string = ('zero', 'identity',
    'arithmetic', 'geometric cond 1/eps', 'geometric cond sqrt(1/eps)',
    'one large', 'one small', 'mixed signs', 'repeated', 'scaled 1e-290',
    'scaled 1e290');

function MakeSpectrum(ASpectrum: TSpectrum; N: Integer): TArrayOfReal;
var
  I: Integer;
  LSigma: TArrayOfReal;
begin
  result := nil;
  SetLength(result, N);
  case ASpectrum of
    spZero: ;
    spIdentity: for I := 0 to N - 1 do result[I] := 1;
    spArithmetic: for I := 0 to N - 1 do result[I] := I + 1;
    spGeometric, spSqrtGeometric, spOneLarge, spOneSmall, spTiny, spHuge:
      begin
        case ASpectrum of
          spGeometric: LSigma := SigmaValues(N, smGeometric, 1 / UnitRoundoff);
          spSqrtGeometric: LSigma := SigmaValues(N, smGeometric, Sqrt(1 / UnitRoundoff));
          spOneLarge: LSigma := SigmaValues(N, smOneLarge, 1E6);
          spOneSmall: LSigma := SigmaValues(N, smOneSmall, 1E6);
        else
          LSigma := SigmaValues(N, smRandomLog, 1E3);
        end;
        for I := 0 to N - 1 do result[I] := LSigma[I];
        if ASpectrum = spTiny then for I := 0 to N - 1 do result[I] := result[I] * 1E-290;
        if ASpectrum = spHuge then for I := 0 to N - 1 do result[I] := result[I] * 1E290;
      end;
    spMixedSigns: for I := 0 to N - 1 do result[I] := RandomUniform * 10;
    spRepeated:
      for I := 0 to N - 1 do
        if I < N div 2 then result[I] := 2 else result[I] := -1;
  end;
end;

procedure SortValues(var AValues: TArrayOfReal);
var
  I, J: Integer;
  T: Double;
begin
  for I := 1 to High(AValues) do
  begin
    T := AValues[I];
    J := I - 1;
    while (J >= 0) and (AValues[J] > T) do
    begin
      AValues[J + 1] := AValues[J];
      Dec(J);
    end;
    AValues[J + 1] := T;
  end;
end;

function SpectrumRatio(const AComputed: TRealVector; AExpected: TArrayOfReal): Double;
var
  I: Integer;
  LNorm: Double;
begin
  SortValues(AExpected);
  LNorm := 0;
  for I := 0 to High(AExpected) do LNorm := Max(LNorm, System.Abs(AExpected[I]));
  result := 0;
  for I := 0 to High(AExpected) do
    if AComputed[I] <> AExpected[I] then
      result := Max(result, System.Abs(AComputed[I] - AExpected[I]) /
        Max(Length(AExpected) * LNorm * Ulp, SafeMinimum));
end;

function IsAscending(const AValues: TRealVector): Boolean;
var
  I: Integer;
begin
  result := True;
  for I := 1 to AValues.Size - 1 do
    if AValues[I] < AValues[I - 1] then Exit(False);
end;

procedure DenseChecks;
const
  Orders: array[0..6] of Integer = (1, 2, 3, 5, 8, 16, 32);
  ExtendedOrders: array[0..1] of Integer = (64, 128);
var
  LSpectrum: TSpectrum;
  S, LCount: Integer;
  LOrders: array of Integer;
  LValues: TArrayOfReal;
  A, V: TRealMatrix;
  CA, CV: TComplexMatrix;
  D: TRealVector;
  LLabel: string;
begin
  SetLength(LOrders, Length(Orders));
  for S := 0 to High(Orders) do LOrders[S] := Orders[S];
  if ExtendedMode then
  begin
    LCount := Length(LOrders);
    SetLength(LOrders, LCount + Length(ExtendedOrders));
    for S := 0 to High(ExtendedOrders) do LOrders[LCount + S] := ExtendedOrders[S];
  end;

  Group('Decomposition residual (ZHET21)', ckStability,
    LAPACKSymmetricEigenThreshold, tsLAPACK, 'sep.in');
  SetSeed(801);
  for S := 0 to High(LOrders) do
    for LSpectrum := Low(TSpectrum) to High(TSpectrum) do
    begin
      LLabel := Format('n=%d %s', [LOrders[S], SpectrumNames[LSpectrum]]);
      LValues := MakeSpectrum(LSpectrum, LOrders[S]);
      A := SymmetricWithSpectrum(LValues);
      A.SymmetricEigenpairs(D, V);
      CheckRatio('real ' + LLabel, SymmetricDecompositionRatio(A, D, V));
      CA := HermitianWithSpectrum(LValues);
      CA.HermitianEigenpairs(D, CV);
      CheckRatio('complex ' + LLabel, HermitianDecompositionRatio(CA, D, CV));
    end;

  Group('Eigenvector orthogonality (ZUNT01)', ckStability,
    LAPACKSymmetricEigenThreshold, tsLAPACK, 'sep.in');
  SetSeed(801);
  for S := 0 to High(LOrders) do
    for LSpectrum := Low(TSpectrum) to High(TSpectrum) do
    begin
      LLabel := Format('n=%d %s', [LOrders[S], SpectrumNames[LSpectrum]]);
      LValues := MakeSpectrum(LSpectrum, LOrders[S]);
      A := SymmetricWithSpectrum(LValues);
      A.SymmetricEigenpairs(D, V);
      CheckRatio('real ' + LLabel, OrthogonalityRatio(V));
      CA := HermitianWithSpectrum(LValues);
      CA.HermitianEigenpairs(D, CV);
      CheckRatio('complex ' + LLabel, OrthogonalityRatio(CV));
    end;

  Group('Eigenvalues against the prescribed spectrum (Weyl)', ckAccuracy,
    ProjectThreshold, tsProject, '|error| / (n ||A||_2 ulp)');
  SetSeed(801);
  for S := 0 to High(LOrders) do
    for LSpectrum := Low(TSpectrum) to High(TSpectrum) do
    begin
      LLabel := Format('n=%d %s', [LOrders[S], SpectrumNames[LSpectrum]]);
      LValues := MakeSpectrum(LSpectrum, LOrders[S]);
      A := SymmetricWithSpectrum(LValues);
      A.SymmetricEigenpairs(D, V);
      CheckRatio('real ' + LLabel, SpectrumRatio(D, Copy(LValues)));
      CA := HermitianWithSpectrum(LValues);
      CA.HermitianEigenpairs(D, CV);
      CheckRatio('complex ' + LLabel, SpectrumRatio(D, Copy(LValues)));
    end;
end;

procedure ClassicalChecks;
var
  A, V: TRealMatrix;
  CA, CV: TComplexMatrix;
  D, Diagonal, OffDiagonal: TRealVector;
  N, I: Integer;
  LExpected: TArrayOfReal;
begin
  Group('Classical matrices, decomposition and orthogonality', ckStability,
    LAPACKSymmetricEigenThreshold, tsLAPACK, 'sep.in');
  for N in [2, 7, 21, 40] do
  begin
    WilkinsonTridiagonal(N, Diagonal, OffDiagonal);
    A := TridiagonalToMatrix(Diagonal, OffDiagonal);
    A.SymmetricEigenpairs(D, V);
    CheckRatio(Format('Wilkinson W%d decomposition', [N]),
      SymmetricDecompositionRatio(A, D, V));
    CheckRatio(Format('Wilkinson W%d orthogonality', [N]), OrthogonalityRatio(V));
  end;
  A := HilbertMatrix(10);
  A.SymmetricEigenpairs(D, V);
  CheckRatio('Hilbert 10 decomposition', SymmetricDecompositionRatio(A, D, V));
  CheckRatio('Hilbert 10 orthogonality', OrthogonalityRatio(V));
  SetSeed(811);
  CA := RandomComplexMatrix(12);
  CA := CA + CA.TransposeConjugate;
  CA.HermitianEigenpairs(D, CV);
  CheckRatio('random Hermitian 12 decomposition', HermitianDecompositionRatio(CA, D, CV));
  CheckRatio('random Hermitian 12 orthogonality', OrthogonalityRatio(CV));

  Group('1D Laplacian, analytic eigenvalues', ckAccuracy, ProjectThreshold,
    tsProject, '|error| / (n ||A||_2 ulp)');
  for N in [1, 2, 10, 50, 100] do
  begin
    LaplacianTridiagonal(N, Diagonal, OffDiagonal);
    A := TridiagonalToMatrix(Diagonal, OffDiagonal);
    A.SymmetricEigenpairs(D, V);
    SetLength(LExpected, N);
    for I := 0 to N - 1 do
      LExpected[I] := 2 - 2 * Cos((I + 1) * Pi / (N + 1));
    CheckRatio(Format('n=%d', [N]), SpectrumRatio(D, LExpected));
  end;
end;

procedure ContractChecks;
var
  A, V: TRealMatrix;
  CA, CV: TComplexMatrix;
  D: TRealVector;
  K: Integer;

  procedure NonSymmetric;
  begin
    A.SymmetricEigenpairs(D, V);
  end;

  procedure NonHermitian;
  begin
    CA.HermitianEigenpairs(D, CV);
  end;

begin
  Group('Ordering, input validation and exceptions', ckContract);
  SetSeed(821);
  for K := 1 to 20 do
  begin
    A := SymmetricWithSpectrum(MakeSpectrum(spMixedSigns, K mod 9 + 1));
    A.SymmetricEigenpairs(D, V);
    Check(Format('ascending eigenvalues #%d', [K]), IsAscending(D));
    CheckEqual(Format('vector matrix order #%d', [K]), V.Order, A.Order);
  end;
  A.Init([1, 2, 3, 4]);
  CheckRaises('non-symmetric real raises EInvalidOp', EInvalidOp, @NonSymmetric);
  A.Init([1, NaN, NaN, 1]);
  CheckRaises('NaN entry raises EInvalidOp', EInvalidOp, @NonSymmetric);
  A.Init([1, Infinity, Infinity, 1]);
  CheckRaises('infinite entry raises EInvalidOp', EInvalidOp, @NonSymmetric);
  A.Init([]);
  CheckRaises('empty matrix raises EDimensionError', EDimensionError, @NonSymmetric);
  A.Init([2, 1, 1 + 1E-17, 2]);
  CheckNoRaise('rounding-level asymmetry is accepted', @NonSymmetric);
  CA.Init([Complex(1, 0), Complex(2, 1), Complex(2, 1), Complex(1, 0)]);
  CheckRaises('non-Hermitian raises EInvalidOp', EInvalidOp, @NonHermitian);
  CA.Init([Complex(1, 0.5), Complex(0, 0), Complex(0, 0), Complex(1, 0)]);
  CheckRaises('non-real diagonal raises EInvalidOp', EInvalidOp, @NonHermitian);
end;

procedure ScalingProperty;
var
  A, V, V2: TRealMatrix;
  D, D2: TRealVector;
  K, I, N: Integer;
  LOk: Boolean;
begin
  Group('Exact equivariance under A -> 2^e A', ckExact);
  SetSeed(831);
  for K := 1 to 20 do
  begin
    N := K mod 10 + 1;
    A := SymmetricWithSpectrum(MakeSpectrum(spMixedSigns, N));
    A.SymmetricEigenpairs(D, V);
    (A * Ldexp(Double(1), 300)).SymmetricEigenpairs(D2, V2);
    LOk := True;
    for I := 0 to N - 1 do LOk := LOk and (D2[I] = Ldexp(D[I], 300));
    Check(Format('eigenvalues scale exactly n=%d #%d', [N, K]), LOk);
  end;
end;

procedure Run;
begin
  Guard(@DenseChecks);
  Guard(@ClassicalChecks);
  Guard(@ContractChecks);
  Guard(@ScalingProperty);
end;

initialization
  RegisterSpec('Symmetric and Hermitian eigenpairs', @Run);
end.
