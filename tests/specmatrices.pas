{ SpecMatrices - TRealMatrix and TComplexMatrix: construction, elementwise
  operations, products, norms and structural predicates.

  The products are DGEMM, ZGEMM, DGEMV and ZGEMV of the reference BLAS;
  every entry is checked with the error ratio of the reference BLAS tests
  (xMMCH, xMVCH) described in SpecVectors. }
unit SpecMatrices;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}
{$modeswitch nestedprocvars}

interface

implementation

uses
  SysUtils, Math, ADimMath, TestRunner, TestDoubleDouble, TestGenerators,
  TestMeasures, SpecVectors;

procedure ContractChecks;
var
  A, B, R: TRealMatrix;
  CA: TComplexMatrix;
  V: TRealVector;
  LValue: Double;

  procedure NonSquare;
  begin
    A.Init([1, 2, 3]);
  end;

  procedure MismatchedSum;
  begin
    R := NewRealMatrix(2) + NewRealMatrix(3);
  end;

  procedure MismatchedProduct;
  begin
    R := NewRealMatrix(2) * NewRealMatrix(3);
  end;

  procedure MismatchedMatVec;
  begin
    V := NewRealMatrix(2) * NewRealVector(3);
  end;

  procedure MismatchedVecMat;
  begin
    V := NewRealVector(3) * NewRealMatrix(2);
  end;

  procedure MismatchedDiagonal;
  begin
    R := NewRealMatrix(2).Diagonalize(NewRealVector(3));
  end;

  procedure EmptyTrace;
  begin
    R.Init([]);
    LValue := R.Trace;
  end;

  procedure EmptyDeterminant;
  begin
    R.Init([]);
    LValue := R.Determinant;
  end;

begin
  Group('Construction, order and value semantics', ckContract);
  A.Init([1, 2, 3, 4]);
  CheckEqual('Order', A.Order, 2);
  CheckEqual('row-major [0,1]', A[0, 1], 2);
  CheckEqual('row-major [1,0]', A[1, 0], 3);
  B := A;
  B[0, 0] := 10;
  CheckEqual('assignment copies', A[0, 0], 1);
  B := A.Clone;
  B[1, 1] := 10;
  CheckEqual('Clone is independent', A[1, 1], 4);
  Check('Identity', A.Identity = NewRealMatrix(2) + A.Identity);
  CheckEqual('Identity diagonal', A.Identity[1, 1], 1);
  CheckEqual('Identity off-diagonal', A.Identity[0, 1], 0);
  Check('Null', A.Null.Norm = 0);
  V.Init([5, 6]);
  R := A.Diagonalize(V);
  Check('Diagonalize', (R[0, 0] = 5) and (R[1, 1] = 6) and (R[0, 1] = 0));
  B := A.Clone;
  B.Swap(0, 1);
  Check('Swap rows', (B[0, 0] = 3) and (B[1, 1] = 2));
  Check('= exact', A = A.Clone);
  B := A.Clone;
  B[0, 0] := 1 + Ulp;
  Check('<> exact', A <> B);
  CA := A.ToComplex;
  CheckEqual('ToComplex', CA[1, 0], Complex(3, 0));
  CA.Init([Complex(1, 2), Complex(3, 4), Complex(5, 6), Complex(7, 8)]);
  CheckEqual('Conjugate', CA.Conjugate[0, 1], Complex(3, -4));
  CheckEqual('TransposeConjugate', CA.TransposeConjugate[0, 1], Complex(5, -6));
  CheckEqual('Transpose', CA.Transpose[0, 1], Complex(5, 6));
  CheckEqual('Trace', A.Trace, 5);

  Group('Exceptions', ckContract);
  CheckRaises('Init with a non-square count', EDimensionError, @NonSquare);
  CheckRaises('A + B with different orders', EDimensionError, @MismatchedSum);
  CheckRaises('A * B with different orders', EDimensionError, @MismatchedProduct);
  CheckRaises('A * x with incompatible size', EDimensionError, @MismatchedMatVec);
  CheckRaises('x * A with incompatible size', EDimensionError, @MismatchedVecMat);
  CheckRaises('Diagonalize with wrong size', EDimensionError, @MismatchedDiagonal);
  CheckRaises('Trace of empty matrix', EDimensionError, @EmptyTrace);
  CheckRaises('Determinant of empty matrix', EDimensionError, @EmptyDeterminant);

  { IsNull, SameValue, IsOrthogonal and IsUnitary use the absolute
    DefaultEpsilon tolerance of the scalar predicates. }
  Group('Predicates (absolute DefaultEpsilon tolerance)', ckContract);
  A.Init([Cos(0.3), -Sin(0.3), Sin(0.3), Cos(0.3)]);
  Check('rotation IsOrthogonal', A.IsOrthogonal);
  Check('2*rotation is not orthogonal', not (2.0 * A).IsOrthogonal);
  CA := A.ToComplex * Complex(0, 1);
  Check('i*rotation IsUnitary', CA.IsUnitary);
  Check('IsNull small', (NewRealMatrix(2) + 1E-13 * A).IsNull);
  Check('SameValue', A.SameValue(A + 1E-13 * A.Identity));
  Check('IsNotNull', A.IsNotNull);
end;

procedure ExactChecks;
var
  A, B: TRealMatrix;
  CA, CB: TComplexMatrix;
  N, I, J, K: Integer;
  LS: TComplex;
  LOk: Boolean;
begin
  Group('Elementwise operations, transposes and conjugates', ckExact);
  SetSeed(601);
  for K := 1 to 30 do
  begin
    N := K mod 7 + 1;
    A := RandomRealMatrix(N);
    B := RandomRealMatrix(N);
    CA := RandomComplexMatrix(N);
    CB := RandomComplexMatrix(N);
    LS := RandomComplex;
    LOk := True;
    for I := 0 to N - 1 do
      for J := 0 to N - 1 do
        LOk := LOk and ((A + B)[I, J] = A[I, J] + B[I, J]) and
          ((A - B)[I, J] = A[I, J] - B[I, J]) and
          ((3.5 * A)[I, J] = 3.5 * A[I, J]) and ((A / 3.0)[I, J] = A[I, J] / 3) and
          (A.Transpose[I, J] = A[J, I]) and
          ((CA * LS)[I, J] = CA[I, J] * LS) and ((CA / LS)[I, J] = CA[I, J] / LS) and
          (CA.TransposeConjugate[I, J] = CA[J, I].Conjugate) and
          (CA.Conjugate[I, J] = CA[I, J].Conjugate) and
          ((CA + CB)[I, J] = CA[I, J] + CB[I, J]);
    Check(Format('n=%d #%d', [N, K]), LOk);
  end;
end;

procedure CheckRealProduct(const ALabel: string; const A, B: TRealMatrix);
var
  P: TRealMatrix;
  LX, LY: array of Double;
  N, I, J, K: Integer;
  LWorst: Double;
begin
  N := A.Order;
  P := A * B;
  SetLength(LX, N);
  SetLength(LY, N);
  LWorst := 0;
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      for K := 0 to N - 1 do
      begin
        LX[K] := A[I, K];
        LY[K] := B[K, J];
      end;
      LWorst := Max(LWorst, BlasRatio(P[I, J], LX, LY));
    end;
  CheckRatio(ALabel, LWorst);
end;

procedure CheckComplexProduct(const ALabel: string; const A, B: TComplexMatrix);
var
  P: TComplexMatrix;
  LX, LY: array of TComplex;
  N, I, J, K: Integer;
  LWorst: Double;
begin
  N := A.Order;
  P := A * B;
  SetLength(LX, N);
  SetLength(LY, N);
  LWorst := 0;
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      for K := 0 to N - 1 do
      begin
        LX[K] := A[I, K];
        LY[K] := B[K, J];
      end;
      LWorst := Max(LWorst, BlasRatio(P[I, J], LX, LY));
    end;
  CheckRatio(ALabel, LWorst);
end;

{ A*x and x^T*A. }
procedure CheckComplexMatVec(const ALabel: string; const A: TComplexMatrix;
  const X: TComplexVector);
var
  Y, Z: TComplexVector;
  LX, LY: array of TComplex;
  N, I, K: Integer;
  LWorst: Double;
begin
  N := A.Order;
  Y := A * X;
  Z := X * A;
  SetLength(LX, N);
  SetLength(LY, N);
  LWorst := 0;
  for I := 0 to N - 1 do
  begin
    for K := 0 to N - 1 do
    begin
      LX[K] := A[I, K];
      LY[K] := X[K];
    end;
    LWorst := Max(LWorst, BlasRatio(Y[I], LX, LY));
    for K := 0 to N - 1 do LX[K] := A[K, I];
    LWorst := Max(LWorst, BlasRatio(Z[I], LX, LY));
  end;
  CheckRatio(ALabel, LWorst);
end;

procedure CheckRealMatVec(const ALabel: string; const A: TRealMatrix;
  const X: TRealVector);
var
  Y, Z: TRealVector;
  LX, LY: array of Double;
  N, I, K: Integer;
  LWorst: Double;
begin
  N := A.Order;
  Y := A * X;
  Z := X * A;
  SetLength(LX, N);
  SetLength(LY, N);
  LWorst := 0;
  for I := 0 to N - 1 do
  begin
    for K := 0 to N - 1 do
    begin
      LX[K] := A[I, K];
      LY[K] := X[K];
    end;
    LWorst := Max(LWorst, BlasRatio(Y[I], LX, LY));
    for K := 0 to N - 1 do LX[K] := A[K, I];
    LWorst := Max(LWorst, BlasRatio(Z[I], LX, LY));
  end;
  CheckRatio(ALabel, LWorst);
end;

function CancellingComplexMatrix(N: Integer): TComplexMatrix;
var
  I, J: Integer;
begin
  result := NewComplexMatrix(N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
      case (I + J) mod 3 of
        0: result[I, J] := Complex(1E16 * RandomUniform, RandomUniform);
        1: result[I, J] := Complex(RandomUniform, 1E16 * RandomUniform);
      else
        result[I, J] := RandomComplex;
      end;
end;

procedure ProductAccuracy;
const
  Orders: array[0..5] of Integer = (1, 2, 3, 8, 17, 40);
  Scales: array[0..2] of Double = (1E-100, 1, 1E100);
var
  S, T, K: Integer;
  A, B: TRealMatrix;
  CA, CB: TComplexMatrix;
begin
  Group('Matrix products, error ratio of the reference BLAS tests',
    ckAccuracy, 16, tsLAPACK, 'dblat2/dblat3 xMVCH, xMMCH');
  SetSeed(611);
  for S := Low(Orders) to High(Orders) do
    for T := Low(Scales) to High(Scales) do
      for K := 1 to 3 do
      begin
        A := RandomRealMatrix(Orders[S]) * Scales[T];
        B := RandomRealMatrix(Orders[S]) / Scales[T];
        CheckRealProduct(Format('real n=%d scale %g #%d', [Orders[S], Scales[T], K]), A, B);
        CheckRealMatVec(Format('real mat-vec n=%d scale %g #%d',
          [Orders[S], Scales[T], K]), A, RandomRealVector(Orders[S]));
        CA := RandomComplexMatrix(Orders[S]) * Scales[T];
        CB := RandomComplexMatrix(Orders[S]) / Scales[T];
        CheckComplexProduct(Format('complex n=%d scale %g #%d',
          [Orders[S], Scales[T], K]), CA, CB);
        CheckComplexMatVec(Format('complex mat-vec n=%d scale %g #%d',
          [Orders[S], Scales[T], K]), CA, RandomComplexVector(Orders[S]));
        CA := CancellingComplexMatrix(Orders[S]);
        CheckComplexProduct(Format('cancelling complex n=%d #%d', [Orders[S], K]),
          CA, CancellingComplexMatrix(Orders[S]));
        CheckComplexMatVec(Format('cancelling complex mat-vec n=%d #%d',
          [Orders[S], K]), CA, RandomComplexVector(Orders[S]));
      end;
  A.Init([1E16, 1, -1E16, 0, 1, 0, 0, 0, 1]);
  B := A.Identity + A.Identity;
  CheckRealProduct('row [1e16, 1, -1e16]', A, B);
end;

procedure NormAndTraceAccuracy;
var
  K, N, I, J: Integer;
  A: TRealMatrix;
  CA: TComplexMatrix;
  LSum: TDD;
  LAbsolute, LReference: Double;
begin
  Group('Frobenius norm and trace, relative error', ckAccuracy, 1, tsProject,
    'gamma forward-error bounds of summation');
  SetSeed(621);
  for K := 1 to 40 do
  begin
    N := K mod 12 + 1;
    A := RandomRealMatrix(N) * Power(10, 50 * RandomUniform);
    LSum := 0;
    for I := 0 to N - 1 do
      for J := 0 to N - 1 do LSum := LSum + TwoProd(A[I, J], A[I, J]);
    LReference := DDSqrt(LSum).ToDouble;
    CheckRatio(Format('||A||_F n=%d #%d', [N, K]),
      System.Abs(A.Norm - LReference) / (Gamma(N * N + 2) * LReference));
    LSum := 0;
    LAbsolute := 0;
    for I := 0 to N - 1 do
    begin
      LSum := LSum + TDD(A[I, I]);
      LAbsolute := LAbsolute + System.Abs(A[I, I]);
    end;
    CheckRatio(Format('trace n=%d #%d', [N, K]),
      DDAbs(TDD(A.Trace) - LSum).ToDouble / (Gamma(Max(N - 1, 1)) * LAbsolute));
    CA := RandomComplexMatrix(N);
    LSum := 0;
    for I := 0 to N - 1 do
      for J := 0 to N - 1 do
        LSum := LSum + TwoProd(CA[I, J].Re, CA[I, J].Re) +
          TwoProd(CA[I, J].Im, CA[I, J].Im);
    LReference := DDSqrt(LSum).ToDouble;
    CheckRatio(Format('complex ||A||_F n=%d #%d', [N, K]),
      System.Abs(CA.Norm - LReference) / (Gamma(2 * N * N + 2) * LReference));
  end;
end;

procedure Run;
begin
  Guard(@ContractChecks);
  Guard(@ExactChecks);
  Guard(@ProductAccuracy);
  Guard(@NormAndTraceAccuracy);
end;

initialization
  RegisterSpec('Matrices (construction, operations, products)', @Run);
end.
