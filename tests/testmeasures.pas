{ TestMeasures - Norms, error measures and acceptance ratios.

  Residuals are computed with independent loops accumulated in
  double-double arithmetic, never with the ADimMath operators under test.
  The normalized ratios are those of the LAPACK test programs:

    DGET02/ZGET02  ||b - A*x||_1 / (||A||_1 * ||x||_1 * eps)
    DGET03/ZGET03  ||I - inv(A)*A||_1 / (n * ||A||_1 * ||inv(A)||_1 * eps)
    DGET04/ZGET04  ||x - x_true|| / (||x_true|| * cond(A) * eps)
    ZGET22         ||A*V - V*D||_1 / (||A||_1 * ||V||_1 * ulp)
    ZHET21         ||A - V*D*V^H||_1 / (n * ||A||_1 * ulp)
    ZUNT01         ||I - V^H*V||_1 / (m * ulp)
    ZSTT22         ||V^H*A*V - D||_1 / (m * ||A||_1 * ulp)

  with eps = 2^-53 (DLAMCH('E')) and ulp = 2^-52 (DLAMCH('P')). The matrix
  one-norm is the maximum column sum of moduli (ZLANGE); the vector
  one-norm of a complex vector sums |Re| + |Im| (DZASUM). }
unit TestMeasures;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}

interface

uses
  Math, ADimMath, TestDoubleDouble, TestGenerators;

const
  UnitRoundoff = 1.1102230246251565E-16;  { eps = 2^-53 }
  Ulp = 2.2204460492503131E-16;           { 2^-52 }
  SafeMinimum = 2.2250738585072014E-308;

  { LAPACK test-input thresholds (dtest.in/ztest.in, sep.in, nep.in,
    svd.in). }
  LAPACKLinearThreshold = 30;
  LAPACKSymmetricEigenThreshold = 50;
  LAPACKGeneralEigenThreshold = 20;
  LAPACKSVDThreshold = 50;
  { Threshold defined by this project where no external one applies. }
  ProjectThreshold = 20;

{ gamma_n = n*u / (1 - n*u) (Higham, Accuracy and Stability, 3.1). }
function Gamma(N: Integer): Double;

function MatrixOneNorm(const A: TRealMatrix): Double; overload;
function MatrixOneNorm(const A: TComplexMatrix): Double; overload;
function VectorOneNorm(const X: TRealVector): Double; overload;
function VectorOneNorm(const X: TComplexVector): Double; overload;
function VectorTwoNorm(const X: TRealVector): Double; overload;
function VectorTwoNorm(const X: TComplexVector): Double; overload;
{ Frobenius norm, an upper bound of the 2-norm. }
function FrobeniusNorm(const A: TRealMatrix): Double; overload;
function FrobeniusNorm(const A: TComplexMatrix): Double; overload;

function SolveRatio(const A: TRealMatrix; const X, B: TRealVector): Double; overload;
function SolveRatio(const A: TComplexMatrix; const X, B: TComplexVector): Double; overload;
function InverseRatio(const A, AInverse: TRealMatrix): Double; overload;
function InverseRatio(const A, AInverse: TComplexMatrix): Double; overload;
function ForwardRatio(const X, XTrue: TRealVector; ACond: Double): Double; overload;
function ForwardRatio(const X, XTrue: TComplexVector; ACond: Double): Double; overload;

function GeneralEigenRatio(const A: TComplexMatrix; const AValues: TComplexVector;
  const AVectors: TComplexMatrix): Double;
function SymmetricDecompositionRatio(const A: TRealMatrix;
  const AValues: TRealVector; const AVectors: TRealMatrix): Double;
function HermitianDecompositionRatio(const A: TComplexMatrix;
  const AValues: TRealVector; const AVectors: TComplexMatrix): Double;
function OrthogonalityRatio(const V: TRealMatrix): Double; overload;
function OrthogonalityRatio(const V: TComplexMatrix): Double; overload;
function OrthogonalityRatio(const V: TArrayOfRealVector): Double; overload;
function OrthogonalityRatio(const V: TArrayOfComplexVector): Double; overload;
function ProjectedRatio(const A: TRealMatrix; const AValues: TRealVector;
  const AVectors: TArrayOfRealVector): Double; overload;
function ProjectedRatio(const A: TComplexMatrix; const AValues: TRealVector;
  const AVectors: TArrayOfComplexVector): Double; overload;

{ Converts between the ADimMath containers and plain matrices. }
function RealToComplexMatrix(const A: TRealMatrix): TComplexMatrix;

implementation

function Gamma(N: Integer): Double;
begin
  result := N * UnitRoundoff / (1 - N * UnitRoundoff);
end;

function Abs1(const AValue: TComplex): Double; inline;
begin
  result := System.Abs(AValue.Re) + System.Abs(AValue.Im);
end;

function MatrixOneNorm(const A: TRealMatrix): Double;
var
  I, J: Integer;
  LSum: Double;
begin
  result := 0;
  for J := 0 to A.Order - 1 do
  begin
    LSum := 0;
    for I := 0 to A.Order - 1 do LSum := LSum + System.Abs(A[I, J]);
    result := Max(result, LSum);
  end;
end;

function MatrixOneNorm(const A: TComplexMatrix): Double;
var
  I, J: Integer;
  LSum: Double;
begin
  result := 0;
  for J := 0 to A.Order - 1 do
  begin
    LSum := 0;
    for I := 0 to A.Order - 1 do LSum := LSum + A[I, J].Norm;
    result := Max(result, LSum);
  end;
end;

function VectorOneNorm(const X: TRealVector): Double;
var
  I: Integer;
begin
  result := 0;
  for I := 0 to X.Size - 1 do result := result + System.Abs(X[I]);
end;

function VectorOneNorm(const X: TComplexVector): Double;
var
  I: Integer;
begin
  result := 0;
  for I := 0 to X.Size - 1 do result := result + Abs1(X[I]);
end;

function VectorTwoNorm(const X: TRealVector): Double;
var
  I: Integer;
begin
  result := 0;
  for I := 0 to X.Size - 1 do result := Hypot(result, X[I]);
end;

function VectorTwoNorm(const X: TComplexVector): Double;
var
  I: Integer;
begin
  result := 0;
  for I := 0 to X.Size - 1 do result := Hypot(result, X[I].Norm);
end;

function FrobeniusNorm(const A: TRealMatrix): Double;
var
  I, J: Integer;
begin
  result := 0;
  for I := 0 to A.Order - 1 do
    for J := 0 to A.Order - 1 do result := Hypot(result, A[I, J]);
end;

function FrobeniusNorm(const A: TComplexMatrix): Double;
var
  I, J: Integer;
begin
  result := 0;
  for I := 0 to A.Order - 1 do
    for J := 0 to A.Order - 1 do result := Hypot(result, A[I, J].Norm);
end;

function SafeRatio(ANumerator, ADenominator: Double): Double;
begin
  if ANumerator = 0 then Exit(0);
  if ADenominator < SafeMinimum then ADenominator := SafeMinimum;
  result := ANumerator / ADenominator;
end;

function RealToComplexMatrix(const A: TRealMatrix): TComplexMatrix;
var
  I, J: Integer;
begin
  result := NewComplexMatrix(A.Order);
  for I := 0 to A.Order - 1 do
    for J := 0 to A.Order - 1 do result[I, J] := A[I, J];
end;

function SolveRatio(const A: TRealMatrix; const X, B: TRealVector): Double;
var
  I, J: Integer;
  LSum: TDD;
  LResidual: Double;
begin
  LResidual := 0;
  for I := 0 to A.Order - 1 do
  begin
    LSum := B[I];
    for J := 0 to A.Order - 1 do LSum := LSum - TwoProd(A[I, J], X[J]);
    LResidual := LResidual + System.Abs(LSum.ToDouble);
  end;
  result := SafeRatio(LResidual,
    MatrixOneNorm(A) * VectorOneNorm(X) * UnitRoundoff);
end;

function SolveRatio(const A: TComplexMatrix; const X, B: TComplexVector): Double;
var
  I, J: Integer;
  LSum: TDDComplex;
  LResidual: Double;
begin
  LResidual := 0;
  for I := 0 to A.Order - 1 do
  begin
    LSum := TDDComplex(B[I]);
    for J := 0 to A.Order - 1 do
      LSum := LSum - TDDComplex(A[I, J]) * TDDComplex(X[J]);
    LResidual := LResidual + Abs1(LSum.ToComplex);
  end;
  result := SafeRatio(LResidual,
    MatrixOneNorm(A) * VectorOneNorm(X) * UnitRoundoff);
end;

function InverseRatio(const A, AInverse: TRealMatrix): Double;
var
  N, I, J, K: Integer;
  LSum: TDD;
  LColumn, LNorm: Double;
begin
  N := A.Order;
  LNorm := 0;
  for J := 0 to N - 1 do
  begin
    LColumn := 0;
    for I := 0 to N - 1 do
    begin
      if I = J then LSum := -1 else LSum := 0;
      for K := 0 to N - 1 do LSum := LSum + TwoProd(AInverse[I, K], A[K, J]);
      LColumn := LColumn + System.Abs(LSum.ToDouble);
    end;
    LNorm := Max(LNorm, LColumn);
  end;
  result := SafeRatio(LNorm, N * MatrixOneNorm(A) * MatrixOneNorm(AInverse) *
    UnitRoundoff);
end;

function InverseRatio(const A, AInverse: TComplexMatrix): Double;
var
  N, I, J, K: Integer;
  LSum: TDDComplex;
  LColumn, LNorm: Double;
begin
  N := A.Order;
  LNorm := 0;
  for J := 0 to N - 1 do
  begin
    LColumn := 0;
    for I := 0 to N - 1 do
    begin
      if I = J then LSum := DDComplex(-1, 0) else LSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
        LSum := LSum + TDDComplex(AInverse[I, K]) * TDDComplex(A[K, J]);
      LColumn := LColumn + LSum.ToComplex.Norm;
    end;
    LNorm := Max(LNorm, LColumn);
  end;
  result := SafeRatio(LNorm, N * MatrixOneNorm(A) * MatrixOneNorm(AInverse) *
    UnitRoundoff);
end;

function ForwardRatio(const X, XTrue: TRealVector; ACond: Double): Double;
var
  I: Integer;
  LError: Double;
begin
  LError := 0;
  for I := 0 to X.Size - 1 do LError := Hypot(LError, X[I] - XTrue[I]);
  result := SafeRatio(LError, VectorTwoNorm(XTrue) * ACond * UnitRoundoff);
end;

function ForwardRatio(const X, XTrue: TComplexVector; ACond: Double): Double;
var
  I: Integer;
  LError: Double;
begin
  LError := 0;
  for I := 0 to X.Size - 1 do LError := Hypot(LError, (X[I] - XTrue[I]).Norm);
  result := SafeRatio(LError, VectorTwoNorm(XTrue) * ACond * UnitRoundoff);
end;

function GeneralEigenRatio(const A: TComplexMatrix; const AValues: TComplexVector;
  const AVectors: TComplexMatrix): Double;
var
  N, I, J, K: Integer;
  LSum: TDDComplex;
  LColumn, LNorm: Double;
begin
  N := A.Order;
  LNorm := 0;
  for J := 0 to N - 1 do
  begin
    LColumn := 0;
    for I := 0 to N - 1 do
    begin
      LSum := DDComplex(0, 0) - TDDComplex(AVectors[I, J]) *
        TDDComplex(AValues[J]);
      for K := 0 to N - 1 do
        LSum := LSum + TDDComplex(A[I, K]) * TDDComplex(AVectors[K, J]);
      LColumn := LColumn + LSum.ToComplex.Norm;
    end;
    LNorm := Max(LNorm, LColumn);
  end;
  result := SafeRatio(LNorm, MatrixOneNorm(A) * MatrixOneNorm(AVectors) * Ulp);
end;

function SymmetricDecompositionRatio(const A: TRealMatrix;
  const AValues: TRealVector; const AVectors: TRealMatrix): Double;
var
  N, I, J, K: Integer;
  LSum: TDD;
  LColumn, LNorm: Double;
begin
  N := A.Order;
  LNorm := 0;
  for J := 0 to N - 1 do
  begin
    LColumn := 0;
    for I := 0 to N - 1 do
    begin
      LSum := A[I, J];
      for K := 0 to N - 1 do
        LSum := LSum - TwoProd(AVectors[I, K] * AValues[K], AVectors[J, K]);
      LColumn := LColumn + System.Abs(LSum.ToDouble);
    end;
    LNorm := Max(LNorm, LColumn);
  end;
  result := SafeRatio(LNorm, N * MatrixOneNorm(A) * Ulp);
end;

function HermitianDecompositionRatio(const A: TComplexMatrix;
  const AValues: TRealVector; const AVectors: TComplexMatrix): Double;
var
  N, I, J, K: Integer;
  LSum: TDDComplex;
  LColumn, LNorm: Double;
begin
  N := A.Order;
  LNorm := 0;
  for J := 0 to N - 1 do
  begin
    LColumn := 0;
    for I := 0 to N - 1 do
    begin
      LSum := TDDComplex(A[I, J]);
      for K := 0 to N - 1 do
        LSum := LSum - TDDComplex(AVectors[I, K] * AValues[K]) *
          TDDComplex(AVectors[J, K].Conjugate);
      LColumn := LColumn + LSum.ToComplex.Norm;
    end;
    LNorm := Max(LNorm, LColumn);
  end;
  result := SafeRatio(LNorm, N * MatrixOneNorm(A) * Ulp);
end;

function OrthogonalityRatio(const V: TRealMatrix): Double;
var
  N, I, J, K: Integer;
  LSum: TDD;
  LColumn, LNorm: Double;
begin
  N := V.Order;
  LNorm := 0;
  for J := 0 to N - 1 do
  begin
    LColumn := 0;
    for I := 0 to N - 1 do
    begin
      if I = J then LSum := -1 else LSum := 0;
      for K := 0 to N - 1 do LSum := LSum + TwoProd(V[K, I], V[K, J]);
      LColumn := LColumn + System.Abs(LSum.ToDouble);
    end;
    LNorm := Max(LNorm, LColumn);
  end;
  result := SafeRatio(LNorm, N * Ulp);
end;

function OrthogonalityRatio(const V: TComplexMatrix): Double;
var
  N, I, J, K: Integer;
  LSum: TDDComplex;
  LColumn, LNorm: Double;
begin
  N := V.Order;
  LNorm := 0;
  for J := 0 to N - 1 do
  begin
    LColumn := 0;
    for I := 0 to N - 1 do
    begin
      if I = J then LSum := DDComplex(-1, 0) else LSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
        LSum := LSum + TDDComplex(V[K, I].Conjugate) * TDDComplex(V[K, J]);
      LColumn := LColumn + LSum.ToComplex.Norm;
    end;
    LNorm := Max(LNorm, LColumn);
  end;
  result := SafeRatio(LNorm, N * Ulp);
end;

function OrthogonalityRatio(const V: TArrayOfRealVector): Double;
var
  M, I, J, K: Integer;
  LSum: TDD;
  LColumn, LNorm: Double;
begin
  M := Length(V);
  LNorm := 0;
  for J := 0 to M - 1 do
  begin
    LColumn := 0;
    for I := 0 to M - 1 do
    begin
      if I = J then LSum := -1 else LSum := 0;
      for K := 0 to V[I].Size - 1 do LSum := LSum + TwoProd(V[I][K], V[J][K]);
      LColumn := LColumn + System.Abs(LSum.ToDouble);
    end;
    LNorm := Max(LNorm, LColumn);
  end;
  result := SafeRatio(LNorm, M * Ulp);
end;

function OrthogonalityRatio(const V: TArrayOfComplexVector): Double;
var
  M, I, J, K: Integer;
  LSum: TDDComplex;
  LColumn, LNorm: Double;
begin
  M := Length(V);
  LNorm := 0;
  for J := 0 to M - 1 do
  begin
    LColumn := 0;
    for I := 0 to M - 1 do
    begin
      if I = J then LSum := DDComplex(-1, 0) else LSum := DDComplex(0, 0);
      for K := 0 to V[I].Size - 1 do
        LSum := LSum + TDDComplex(V[I][K].Conjugate) * TDDComplex(V[J][K]);
      LColumn := LColumn + LSum.ToComplex.Norm;
    end;
    LNorm := Max(LNorm, LColumn);
  end;
  result := SafeRatio(LNorm, M * Ulp);
end;

function ProjectedRatio(const A: TRealMatrix; const AValues: TRealVector;
  const AVectors: TArrayOfRealVector): Double;
var
  M, N, I, J, K, L: Integer;
  LSum, LInner: TDD;
  LColumn, LNorm: Double;
  LProduct: array of TDD;
begin
  M := Length(AVectors);
  N := A.Order;
  SetLength(LProduct, N);
  LNorm := 0;
  for J := 0 to M - 1 do
  begin
    { A * v_j in double-double. }
    for K := 0 to N - 1 do
    begin
      LInner := 0;
      for L := 0 to N - 1 do
        if A[K, L] <> 0 then LInner := LInner + TwoProd(A[K, L], AVectors[J][L]);
      LProduct[K] := LInner;
    end;
    LColumn := 0;
    for I := 0 to M - 1 do
    begin
      if I = J then LSum := -AValues[J] else LSum := 0;
      for K := 0 to N - 1 do
        LSum := LSum + TDD(AVectors[I][K]) * LProduct[K];
      LColumn := LColumn + System.Abs(LSum.ToDouble);
    end;
    LNorm := Max(LNorm, LColumn);
  end;
  result := SafeRatio(LNorm, M * MatrixOneNorm(A) * Ulp);
end;

function ProjectedRatio(const A: TComplexMatrix; const AValues: TRealVector;
  const AVectors: TArrayOfComplexVector): Double;
var
  M, N, I, J, K, L: Integer;
  LSum, LInner: TDDComplex;
  LColumn, LNorm: Double;
  LProduct: array of TDDComplex;
begin
  M := Length(AVectors);
  N := A.Order;
  SetLength(LProduct, N);
  LNorm := 0;
  for J := 0 to M - 1 do
  begin
    for K := 0 to N - 1 do
    begin
      LInner := DDComplex(0, 0);
      for L := 0 to N - 1 do
        if A[K, L].Norm <> 0 then
          LInner := LInner + TDDComplex(A[K, L]) * TDDComplex(AVectors[J][L]);
      LProduct[K] := LInner;
    end;
    LColumn := 0;
    for I := 0 to M - 1 do
    begin
      if I = J then LSum := DDComplex(-AValues[J], 0)
      else LSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
        LSum := LSum + TDDComplex(AVectors[I][K].Conjugate) * LProduct[K];
      LColumn := LColumn + LSum.ToComplex.Norm;
    end;
    LNorm := Max(LNorm, LColumn);
  end;
  result := SafeRatio(LNorm, M * MatrixOneNorm(A) * Ulp);
end;

end.
