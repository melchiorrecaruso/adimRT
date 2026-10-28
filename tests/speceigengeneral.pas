{ SpecEigenGeneral - Eigenpairs of general real and complex matrices.

  Test matrices follow the LAPACK nonsymmetric eigenproblem tests (xCHKHS,
  xDRVEV): prescribed spectra with eigenvector matrices of condition 1,
  1e3 and 1e6 (xLATME), real matrices with complex-conjugate pairs,
  triangular, graded and scaled matrices, and classical difficult cases:
  cyclic permutations (shifted QR stalls without exceptional shifts),
  Jordan blocks (defective), Grcar, Frank, Kahan and companion matrices.

    ZGET22  ||A*V - V*D||_1 / (||A||_1 ||V||_1 ulp) < 20   (nep.in)

  For generated matrices the eigenvalues are known, together with their
  condition numbers kappa_i = ||x_i|| ||y_i|| / |y_i^H x_i|; the first
  order bound |delta lambda_i| <= kappa_i ||E||_2 gives the ratio
  |error| / (n kappa_i ||A||_F ulp). }
unit SpecEigenGeneral;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}
{$modeswitch nestedprocvars}

interface

implementation

uses
  SysUtils, Math, ADimMath, TestRunner, TestDoubleDouble, TestGenerators,
  TestMeasures;

procedure CheckResidual(const ALabel: string; const A: TComplexMatrix);
var
  D: TComplexVector;
  V: TComplexMatrix;
begin
  A.Eigenpairs(D, V);
  CheckRatio(ALabel, GeneralEigenRatio(A, D, V));
end;

procedure CheckRealResidual(const ALabel: string; const A: TRealMatrix);
var
  D: TComplexVector;
  V: TComplexMatrix;
begin
  A.Eigenpairs(D, V);
  CheckRatio(ALabel, GeneralEigenRatio(RealToComplexMatrix(A), D, V));
end;

{ Matches computed eigenvalues to the prescribed ones (greedy nearest,
  each computed value used once) and returns the worst ratio. }
function EigenvalueRatio(const AComputed: TComplexVector;
  const AExpected: array of TComplex; const ACondition: TArrayOfReal;
  ANorm: Double): Double;
var
  N, I, J, LBest: Integer;
  LUsed: array of Boolean;
  LDistance, LBestDistance: Double;
begin
  N := Length(AExpected);
  SetLength(LUsed, N);
  result := 0;
  for I := 0 to N - 1 do
  begin
    LBest := -1;
    LBestDistance := Infinity;
    for J := 0 to N - 1 do
      if not LUsed[J] then
      begin
        LDistance := (AComputed[J] - AExpected[I]).Norm;
        if LDistance < LBestDistance then
        begin
          LBestDistance := LDistance;
          LBest := J;
        end;
      end;
    LUsed[LBest] := True;
    result := Max(result, LBestDistance / (N * ACondition[I] * ANorm * Ulp));
  end;
end;

procedure GeneratedChecks;
const
  Orders: array[0..5] of Integer = (2, 3, 5, 8, 16, 32);
  Conditions: array[0..2] of Double = (1, 1E3, 1E6);
var
  S, C, K, I: Integer;
  LValues: array of TComplex;
  LCondition: TArrayOfReal;
  A: TComplexMatrix;
  D: TComplexVector;
  V: TComplexMatrix;
begin
  Group('Prescribed spectra: residual (ZGET22)', ckStability,
    LAPACKGeneralEigenThreshold, tsLAPACK, 'nep.in');
  SetSeed(901);
  for S := Low(Orders) to High(Orders) do
    for C := Low(Conditions) to High(Conditions) do
      for K := 1 to 3 do
      begin
        SetLength(LValues, Orders[S]);
        for I := 0 to Orders[S] - 1 do LValues[I] := RandomComplex;
        A := GeneralWithSpectrum(LValues, Conditions[C], LCondition);
        CheckResidual(Format('n=%d cond(X)=%g #%d', [Orders[S], Conditions[C], K]), A);
      end;

  Group('Prescribed spectra: eigenvalue error / condition', ckAccuracy,
    ProjectThreshold, tsProject, '|error| / (n kappa_i ||A||_F ulp)');
  SetSeed(901);
  for S := Low(Orders) to High(Orders) do
    for C := Low(Conditions) to High(Conditions) do
      for K := 1 to 3 do
      begin
        SetLength(LValues, Orders[S]);
        for I := 0 to Orders[S] - 1 do LValues[I] := RandomComplex;
        A := GeneralWithSpectrum(LValues, Conditions[C], LCondition);
        A.Eigenpairs(D, V);
        CheckRatio(Format('n=%d cond(X)=%g #%d', [Orders[S], Conditions[C], K]),
          EigenvalueRatio(D, LValues, LCondition, FrobeniusNorm(A)));
      end;
end;

{ D*A*D^-1 with D = diag(g^i) has the spectrum of A, but entries spread
  over up to g^(2(n-1)). Balancing (ZGEBAL) must recover a scaling close to
  D^-1, so the eigenvalues keep the accuracy they have for A. }
procedure BalancingChecks;
const
  Orders: array[0..2] of Integer = (3, 5, 8);
  Gradings: array[0..2] of Double = (1E2, 1E4, 1E8);
var
  S, G, K, I, J, N: Integer;
  LValues: array of TComplex;
  LCondition: TArrayOfReal;
  LPermutation: array of Integer;
  A, B: TComplexMatrix;
  R: TRealMatrix;
  D: TComplexVector;
  V: TComplexMatrix;
  LDiagonal: array of Double;
  LUsed: array of Boolean;
  LOk: Boolean;
begin
  Group('Graded similarity D*A*D^-1: eigenvalue error / condition of A',
    ckAccuracy, ProjectThreshold, tsProject, '|error| / (n kappa_i ||A||_F ulp)');
  SetSeed(941);
  for S := Low(Orders) to High(Orders) do
    for G := Low(Gradings) to High(Gradings) do
      for K := 1 to 3 do
      begin
        N := Orders[S];
        SetLength(LValues, N);
        for I := 0 to N - 1 do LValues[I] := RandomComplex;
        A := GeneralWithSpectrum(LValues, 1, LCondition);
        B := A.Clone;
        for I := 0 to N - 1 do
          for J := 0 to N - 1 do
            B[I, J] := A[I, J] * Power(Gradings[G], I - J);
        B.Eigenpairs(D, V);
        CheckRatio(Format('n=%d g=%g #%d', [N, Gradings[G], K]),
          EigenvalueRatio(D, LValues, LCondition, FrobeniusNorm(A)));
      end;

  Group('Graded similarity D*A*D^-1: residual (ZGET22)', ckStability,
    LAPACKGeneralEigenThreshold, tsLAPACK, 'nep.in');
  SetSeed(941);
  for S := Low(Orders) to High(Orders) do
    for G := Low(Gradings) to High(Gradings) do
      for K := 1 to 3 do
      begin
        N := Orders[S];
        SetLength(LValues, N);
        for I := 0 to N - 1 do LValues[I] := RandomComplex;
        A := GeneralWithSpectrum(LValues, 1, LCondition);
        B := A.Clone;
        for I := 0 to N - 1 do
          for J := 0 to N - 1 do
            B[I, J] := A[I, J] * Power(Gradings[G], I - J);
        CheckResidual(Format('n=%d g=%g #%d', [N, Gradings[G], K]), B);
      end;

  { P*T*P^T with T upper triangular: the balancing permutations isolate
    every eigenvalue, which is then returned exactly. }
  Group('Permuted triangular matrices: exact eigenvalues', ckExact);
  SetSeed(942);
  for N in [2, 3, 6, 12] do
    for K := 1 to 3 do
    begin
      SetLength(LPermutation, N);
      for I := 0 to N - 1 do LPermutation[I] := I;
      for I := N - 1 downto 1 do
      begin
        J := Trunc((RandomUniform + 1) / 2 * (I + 1));
        if J > I then J := I;
        S := LPermutation[I];
        LPermutation[I] := LPermutation[J];
        LPermutation[J] := S;
      end;
      R := RandomRealMatrix(N);
      SetLength(LDiagonal, N);
      for I := 0 to N - 1 do
      begin
        for J := 0 to I - 1 do R[I, J] := 0;
        LDiagonal[I] := R[I, I];
      end;
      B := NewComplexMatrix(N);
      for I := 0 to N - 1 do
        for J := 0 to N - 1 do
          B[LPermutation[I], LPermutation[J]] := R[I, J];
      B.Eigenpairs(D, V);
      SetLength(LUsed, N);
      for I := 0 to N - 1 do LUsed[I] := False;
      LOk := True;
      for I := 0 to N - 1 do
      begin
        J := 0;
        while (J < N) and (LUsed[J] or (D[J] <> Complex(LDiagonal[I], 0))) do
          Inc(J);
        if J = N then LOk := False else LUsed[J] := True;
      end;
      Check(Format('n=%d #%d', [N, K]), LOk);
    end;
end;

procedure RealChecks;
const
  Orders: array[0..6] of Integer = (1, 2, 3, 5, 10, 20, 40);
var
  S, K: Integer;
  A: TRealMatrix;
begin
  Group('Random real and complex matrices: residual (ZGET22)', ckStability,
    LAPACKGeneralEigenThreshold, tsLAPACK, 'nep.in');
  SetSeed(911);
  for S := Low(Orders) to High(Orders) do
    for K := 1 to 3 do
    begin
      CheckRealResidual(Format('real n=%d #%d', [Orders[S], K]), RandomRealMatrix(Orders[S]));
      CheckResidual(Format('complex n=%d #%d', [Orders[S], K]),
        RandomComplexMatrix(Orders[S]));
      CheckRealResidual(Format('real n=%d scale 1e-150 #%d', [Orders[S], K]),
        RandomRealMatrix(Orders[S]) * 1E-150);
      CheckResidual(Format('complex n=%d scale 1e150 #%d', [Orders[S], K]),
        RandomComplexMatrix(Orders[S]) * 1E150);
    end;
  if ExtendedMode then
    for S in [64, 100] do
      CheckRealResidual(Format('real n=%d', [S]), RandomRealMatrix(S));
end;

procedure ClassicalChecks;
var
  N, I, J: Integer;
  A: TRealMatrix;
begin
  Group('Classical difficult matrices: residual (ZGET22)', ckStability,
    LAPACKGeneralEigenThreshold, tsLAPACK, 'nep.in');
  for N in [2, 3, 4, 7, 16, 40] do
    CheckRealResidual(Format('cyclic permutation n=%d', [N]), CyclicPermutation(N));
  for N in [2, 5, 10, 40] do
    CheckRealResidual(Format('Jordan block n=%d', [N]), JordanBlock(N, 2));
  for N in [5, 10, 20, 40] do
    CheckRealResidual(Format('Grcar n=%d', [N]), GrcarMatrix(N));
  for N in [5, 10, 12] do
    CheckRealResidual(Format('Frank n=%d', [N]), FrankMatrix(N));
  for N in [5, 20] do
    CheckRealResidual(Format('Kahan n=%d', [N]), KahanMatrix(N, 1.2));
  CheckRealResidual('companion of (x-1)...(x-8)',
    CompanionMatrix([-36, 546, -4536, 22449, -67284, 118124, -109584, 40320]));
  CheckRealResidual('companion x^10 - 1',
    CompanionMatrix([0, 0, 0, 0, 0, 0, 0, 0, 0, -1]));
  SetSeed(921);
  for N in [5, 20, 40] do
  begin
    A := RandomRealMatrix(N);
    for I := 0 to N - 1 do
      for J := 0 to N - 1 do A[I, J] := A[I, J] * Power(10, (I - J) / 4);
    CheckRealResidual(Format('graded 10^((i-j)/4) n=%d', [N]), A);
    A := RandomRealMatrix(N);
    for I := 0 to N - 1 do
      for J := 0 to I - 1 do A[I, J] := 0;
    CheckRealResidual(Format('upper triangular n=%d', [N]), A);
  end;
  A := RandomRealMatrix(10);
  A := A + A.Transpose;
  CheckRealResidual('symmetric (Hermitian path) n=10', A);
end;

procedure ContractChecks;
var
  A: TRealMatrix;
  CA: TComplexMatrix;
  D: TComplexVector;
  V: TComplexMatrix;
  K, N, I, J, LLargest: Integer;
  LOk: Boolean;
  LNorm: Double;

  procedure Solve;
  begin
    CA.Eigenpairs(D, V);
  end;

begin
  Group('Output layout, normalization and input validation', ckContract);
  SetSeed(931);
  for K := 1 to 20 do
  begin
    N := K mod 8 + 1;
    RandomComplexMatrix(N).Eigenpairs(D, V);
    LOk := (D.Size = N) and (V.Order = N);
    for J := 0 to N - 1 do
    begin
      LNorm := 0;
      LLargest := 0;
      for I := 0 to N - 1 do
      begin
        LNorm := Hypot(LNorm, V[I, J].Norm);
        if V[I, J].Norm > V[LLargest, J].Norm then LLargest := I;
      end;
      LOk := LOk and (System.Abs(LNorm - 1) < 8 * N * Ulp) and
        (V[LLargest, J].Im = 0) and (V[LLargest, J].Re > 0);
    end;
    Check(Format('unit columns, largest component real positive n=%d #%d', [N, K]), LOk);
  end;
  A.Init([3, 0, 0, 0, -1, 0, 0, 0, 2]);
  A.Eigenpairs(D, V);
  Check('diagonal matrix: values in place', (D[0] = 3) and (D[1] = -1) and (D[2] = 2));
  Check('diagonal matrix: canonical basis',
    (V[0, 0] = 1) and (V[1, 1] = 1) and (V[2, 2] = 1) and (V[0, 1] = 0));
  CA := NewComplexMatrix(0);
  CheckNoRaise('empty matrix', @Solve);
  CheckEqual('empty matrix gives no values', D.Size, 0);
  CA := NewComplexMatrix(2);
  CA[0, 1] := Complex(NaN, 0);
  CheckRaises('NaN entry raises EInvalidOp', EInvalidOp, @Solve);
  CA[0, 1] := Complex(Infinity, 0);
  CheckRaises('infinite entry raises EInvalidOp', EInvalidOp, @Solve);
end;

procedure Run;
begin
  Guard(@GeneratedChecks);
  Guard(@BalancingChecks);
  Guard(@RealChecks);
  Guard(@ClassicalChecks);
  Guard(@ContractChecks);
end;

initialization
  RegisterSpec('General eigenpairs (Eigenpairs)', @Run);
end.
