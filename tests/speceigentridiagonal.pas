{ SpecEigenTridiagonal - TridiagonalLowestEigenpairs and
  HermitianTridiagonalLowestEigenpairs.

  Orders cover both the partial solver (N > 32 and few requested pairs)
  and its documented fall-back to the full QL solver. Inputs: the 1D
  Laplacian (analytic eigenpairs), Wilkinson matrices (pairs that agree to
  many digits, which trigger the cluster fall-back), random, graded,
  disconnected and zero tridiagonals, and complex Hermitian tridiagonals
  with arbitrary phases. Ratios for m selected pairs (sep.in, threshold 50):

    ZSTT22  ||V^H*A*V - D||_1 / (m ||A||_1 ulp)
    ZUNT01  ||I - V^H*V||_1 / (m ulp)

  Eigenvalues are compared with the analytic values (Laplacian) or with
  the full dense solver, relative to n*||A||_2*ulp (Weyl). }
unit SpecEigenTridiagonal;

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
  TTridiagonalKind = (tkLaplacian, tkWilkinson, tkRandom, tkGraded,
    tkDisconnected, tkZero);

const
  KindNames: array[TTridiagonalKind] of string = ('Laplacian', 'Wilkinson',
    'random', 'graded', 'disconnected', 'zero');

procedure MakeTridiagonal(AKind: TTridiagonalKind; N: Integer;
  out ADiagonal, AOffDiagonal: TRealVector);
var
  I: Integer;
begin
  case AKind of
    tkLaplacian: LaplacianTridiagonal(N, ADiagonal, AOffDiagonal);
    tkWilkinson: WilkinsonTridiagonal(N, ADiagonal, AOffDiagonal);
  else
    RandomTridiagonal(N, ADiagonal, AOffDiagonal);
  end;
  case AKind of
    tkGraded:
      for I := 0 to N - 1 do
      begin
        ADiagonal[I] := ADiagonal[I] * Power(10, -8 * I / N);
        if I < N - 1 then AOffDiagonal[I] := AOffDiagonal[I] * Power(10, -8 * I / N);
      end;
    tkDisconnected:
      for I := 0 to N - 2 do
        if I mod 7 = 6 then AOffDiagonal[I] := 0;
    tkZero:
      begin
        for I := 0 to N - 1 do ADiagonal[I] := 0;
        for I := 0 to N - 2 do AOffDiagonal[I] := 0;
      end;
  end;
end;

{ Sparse product helpers are not needed: the measures accept the dense
  matrix, which is affordable for the orders used here. }
procedure CheckReal(const ALabel: string; const ADiagonal, AOffDiagonal: TRealVector;
  ACount: Integer; const A: TRealMatrix; const FullD: TRealVector);
var
  D: TRealVector;
  V: TArrayOfRealVector;
  I: Integer;
  LNorm, LWorst: Double;
begin
  TridiagonalLowestEigenpairs(ADiagonal, AOffDiagonal, ACount, D, V);
  Group('Real: projected residual (ZSTT22)', ckStability,
    LAPACKSymmetricEigenThreshold, tsLAPACK, 'sep.in');
  CheckRatio(ALabel, ProjectedRatio(A, D, V));
  Group('Real: orthogonality (ZUNT01)', ckStability,
    LAPACKSymmetricEigenThreshold, tsLAPACK, 'sep.in');
  CheckRatio(ALabel, OrthogonalityRatio(V));
  Group('Real: eigenvalues against the dense solver (Weyl)', ckAccuracy,
    ProjectThreshold, tsProject, '|error| / (n ||A||_2 ulp)');
  LNorm := Max(System.Abs(FullD[0]), System.Abs(FullD[FullD.Size - 1]));
  LWorst := 0;
  for I := 0 to ACount - 1 do
    if D[I] <> FullD[I] then
      LWorst := Max(LWorst, System.Abs(D[I] - FullD[I]) /
        Max(ADiagonal.Size * LNorm * Ulp, SafeMinimum));
  CheckRatio(ALabel, LWorst);
  Group('Real: output layout', ckContract);
  Check(ALabel + ' sizes', (D.Size = ACount) and (Length(V) = ACount) and
    (V[0].Size = ADiagonal.Size));
  for I := 1 to ACount - 1 do
    if D[I] < D[I - 1] then
    begin
      Check(ALabel + ' ascending', False);
      Exit;
    end;
  Check(ALabel + ' ascending', True);
end;

procedure RealChecks;
const
  Orders: array[0..5] of Integer = (1, 2, 10, 33, 100, 400);
  Counts: array[0..3] of Integer = (1, 3, 10, 0);
var
  LKind: TTridiagonalKind;
  S, C, LCount: Integer;
  D, E, FullD: TRealVector;
  A, FullV: TRealMatrix;
begin
  SetSeed(1001);
  for S := Low(Orders) to High(Orders) do
    for LKind := Low(TTridiagonalKind) to High(TTridiagonalKind) do
    begin
      MakeTridiagonal(LKind, Orders[S], D, E);
      A := TridiagonalToMatrix(D, E);
      A.SymmetricEigenpairs(FullD, FullV);
      for C := Low(Counts) to High(Counts) do
      begin
        LCount := Counts[C];
        { k = n/2 exercises the full-solver path; at the largest order
          its O(k*n^2) double-double residual is too slow for the default
          run, and the path is already covered at n = 33 and n = 100. }
        if (LCount = 0) and (Orders[S] > 100) and not ExtendedMode then Continue;
        if LCount = 0 then LCount := Max(1, Orders[S] div 2);
        if LCount > Orders[S] then Continue;
        CheckReal(Format('n=%d %s k=%d', [Orders[S], KindNames[LKind], LCount]),
          D, E, LCount, A, FullD);
      end;
    end;
end;

procedure AnalyticChecks;
const
  AnalyticOrders: array[0..2] of Integer = (40, 200, 1000);
var
  D, E, Values: TRealVector;
  V: TArrayOfRealVector;
  N, K, I, J, S: Integer;
  LWorst, LExpected, LDot, LNorm, LDistance, LGap: Double;
begin
  Group('1D Laplacian: analytic eigenvalues and eigenvectors', ckAccuracy,
    ProjectThreshold, tsProject, '|error| / (n ||A||_2 ulp)');
  for S := Low(AnalyticOrders) to High(AnalyticOrders) do
  begin
    N := AnalyticOrders[S];
    LaplacianTridiagonal(N, D, E);
    K := 8;
    TridiagonalLowestEigenpairs(D, E, K, Values, V);
    LWorst := 0;
    for I := 0 to K - 1 do
    begin
      LExpected := 2 - 2 * Cos((I + 1) * Pi / (N + 1));
      LWorst := Max(LWorst, System.Abs(Values[I] - LExpected) / (N * 4 * Ulp));
    end;
    CheckRatio(Format('eigenvalues n=%d', [N]), LWorst);
    { Angle to the analytic eigenvector s_i, measured as min ||v -+ s||,
      against the Davis-Kahan bound theta <= ||r|| / gap with
      ||r|| ~ n ||A|| ulp. }
    LWorst := 0;
    for I := 0 to K - 1 do
    begin
      LNorm := 0;
      for J := 0 to N - 1 do
        LNorm := LNorm + Sqr(Sin((J + 1) * (I + 1) * Pi / (N + 1)));
      LNorm := Sqrt(LNorm);
      LDot := 0;
      LDistance := 0;
      for J := 0 to N - 1 do
      begin
        LExpected := Sin((J + 1) * (I + 1) * Pi / (N + 1)) / LNorm;
        LDot := Hypot(LDot, V[I][J] - LExpected);
        LDistance := Hypot(LDistance, V[I][J] + LExpected);
      end;
      LGap := 2 * Cos((I + 1) * Pi / (N + 1)) - 2 * Cos((I + 2) * Pi / (N + 1));
      if I > 0 then
        LGap := Min(LGap, 2 * Cos(I * Pi / (N + 1)) - 2 * Cos((I + 1) * Pi / (N + 1)));
      LWorst := Max(LWorst, Min(LDot, LDistance) / (N * 4 * Ulp / LGap));
    end;
    CheckRatio(Format('eigenvector angle n=%d (Davis-Kahan)', [N]), LWorst);
  end;
end;

procedure HermitianChecks;
const
  Orders: array[0..3] of Integer = (4, 33, 120, 300);
var
  S, I, K: Integer;
  D: TRealVector;
  E: TComplexVector;
  Values: TRealVector;
  V: TArrayOfComplexVector;
  A: TComplexMatrix;
begin
  Group('Hermitian: projected residual and orthogonality (ZSTT22, ZUNT01)',
    ckStability, LAPACKSymmetricEigenThreshold, tsLAPACK, 'sep.in');
  SetSeed(1011);
  for S := Low(Orders) to High(Orders) do
    for K in [1, 5] do
    begin
      if K > Orders[S] then Continue;
      D := RandomRealVector(Orders[S]);
      E := NewComplexVector(Orders[S] - 1);
      for I := 0 to Orders[S] - 2 do
        E[I] := Complex(Cos(3 * I + 0.4), Sin(3 * I + 0.4)) * RandomUniform;
      HermitianTridiagonalLowestEigenpairs(D, E, K, Values, V);
      A := HermitianTridiagonalToMatrix(D, E);
      CheckRatio(Format('residual n=%d k=%d', [Orders[S], K]), ProjectedRatio(A, Values, V));
      CheckRatio(Format('orthogonality n=%d k=%d', [Orders[S], K]), OrthogonalityRatio(V));
    end;
end;

procedure ContractChecks;
var
  D, E, Values: TRealVector;
  V: TArrayOfRealVector;
  LCount: Integer;

  procedure Solve;
  begin
    TridiagonalLowestEigenpairs(D, E, LCount, Values, V);
  end;

begin
  Group('Input validation', ckContract);
  D := NewRealVector(5);
  E := NewRealVector(4);
  LCount := 0;
  CheckRaises('count 0 raises EDimensionError', EDimensionError, @Solve);
  LCount := 6;
  CheckRaises('count > N raises EDimensionError', EDimensionError, @Solve);
  LCount := 2;
  E := NewRealVector(5);
  CheckRaises('off-diagonal of size N raises EDimensionError', EDimensionError, @Solve);
  D := NewRealVector(0);
  E := NewRealVector(0);
  LCount := 1;
  CheckRaises('empty diagonal raises EDimensionError', EDimensionError, @Solve);
  D := NewRealVector(3);
  E := NewRealVector(2);
  D[1] := NaN;
  CheckRaises('NaN entry raises EInvalidOp', EInvalidOp, @Solve);
  D[1] := Infinity;
  CheckRaises('infinite entry raises EInvalidOp', EInvalidOp, @Solve);
end;

procedure Run;
begin
  Guard(@RealChecks);
  Guard(@AnalyticChecks);
  Guard(@HermitianChecks);
  Guard(@ContractChecks);
end;

initialization
  RegisterSpec('Tridiagonal lowest eigenpairs', @Run);
end.
