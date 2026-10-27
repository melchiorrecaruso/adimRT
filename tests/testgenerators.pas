{ TestGenerators - Deterministic input generators for the ADimMath suite.

  The matrix generators follow the LAPACK test-matrix generators:

    xLATMS  A = U * diag(sigma) * V^H with Haar-like random orthogonal or
            unitary U, V and a prescribed singular-value distribution
            (mode) and condition number;
    xLATME  matrices with a prescribed spectrum, built as X * D * inv(X)
            with an eigenvector matrix X of prescribed condition, or as
            Q * T * Q^H from an upper-triangular Schur factor T.

  All random values come from SplitMix64 with an explicit seed, so every
  case is reproducible on every platform.

  Array parameters are copied into local dynamic arrays before the loops
  that fill a matrix: with FPC 3.2.3 at -O2, reading an open-array
  parameter inside such a loop (which writes through the inlined indexed
  property) raised access violations. }
unit TestGenerators;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}

interface

uses
  Math, ADimMath, TestDoubleDouble;

type
  { Singular-value distributions of xLATMS (MODE 1..5); the largest value
    is 1 and the smallest is 1/cond. }
  TSigmaMode = (smOneLarge, smOneSmall, smGeometric, smArithmetic,
    smRandomLog);

  TArrayOfInteger = array of Integer;

procedure SetSeed(ASeed: QWord);
function RandomUniform: Double;      { uniform in [-1, 1) }
function RandomNormal: Double;
function RandomComplex: TComplex;    { components uniform in [-1, 1) }
function RandomComplexNormal: TComplex;

function NewRealMatrix(N: Integer): TRealMatrix;
function NewComplexMatrix(N: Integer): TComplexMatrix;
function NewRealVector(N: Integer): TRealVector;
function NewComplexVector(N: Integer): TComplexVector;
function RandomRealMatrix(N: Integer): TRealMatrix;
function RandomComplexMatrix(N: Integer): TComplexMatrix;
function RandomRealVector(N: Integer): TRealVector;
function RandomComplexVector(N: Integer): TComplexVector;

function RandomOrthogonal(N: Integer): TRealMatrix;
function RandomUnitary(N: Integer): TComplexMatrix;
function SigmaValues(N: Integer; AMode: TSigmaMode; ACond: Double): TArrayOfReal;
{ xLATMS: U*diag(sigma)*V^H multiplied by AScale; ||A||_2 = AScale and
  cond_2(A) = ACond up to rounding. }
function GenerateRealMatrix(N: Integer; AMode: TSigmaMode;
  ACond, AScale: Double): TRealMatrix;
function GenerateComplexMatrix(N: Integer; AMode: TSigmaMode;
  ACond, AScale: Double): TComplexMatrix;
{ U*diag(ASigma)*V^T * AScale for given singular values. }
function RealMatrixWithSigma(const ASigma: array of Double; AScale: Double): TRealMatrix;

{ Q*diag(AValues)*Q^H, made exactly symmetric/Hermitian. }
function SymmetricWithSpectrum(const AValues: array of Double): TRealMatrix;
function HermitianWithSpectrum(const AValues: array of Double): TComplexMatrix;
{ X*diag(AValues)*inv(X) with cond_2(X) = ACondX. AEigenCondition[i]
  receives ||x_i||_2 * ||y_i||_2 / |y_i^H x_i|, the condition number of
  eigenvalue i (x_i column of X, y_i^H row of inv(X)). }
function GeneralWithSpectrum(const AValues: array of TComplex;
  ACondX: Double; out AEigenCondition: TArrayOfReal): TComplexMatrix;

{ Classical test matrices. }
function JordanBlock(N: Integer; ALambda: Double): TRealMatrix;
function CyclicPermutation(N: Integer): TRealMatrix;
function GrcarMatrix(N: Integer): TRealMatrix;
function FrankMatrix(N: Integer): TRealMatrix;
function KahanMatrix(N: Integer; ATheta: Double): TRealMatrix;
function HilbertMatrix(N: Integer): TRealMatrix;
{ Companion matrix of x^n + c[0]*x^(n-1) + ... + c[n-1]. }
function CompanionMatrix(const ACoefficients: array of Double): TRealMatrix;

{ Tridiagonal inputs (diagonal N, off-diagonal N-1). }
procedure LaplacianTridiagonal(N: Integer; out ADiagonal, AOffDiagonal: TRealVector);
procedure WilkinsonTridiagonal(N: Integer; out ADiagonal, AOffDiagonal: TRealVector);
procedure RandomTridiagonal(N: Integer; out ADiagonal, AOffDiagonal: TRealVector);
function TridiagonalToMatrix(const ADiagonal, AOffDiagonal: TRealVector): TRealMatrix;
function HermitianTridiagonalToMatrix(const ADiagonal: TRealVector;
  const AOffDiagonal: TComplexVector): TComplexMatrix;

{ Monic polynomial coefficients [a, b, ...] of prod (x - r_i), computed in
  double-double and rounded once. }
function CoefficientsFromRoots(const ARoots: array of TComplex): TArrayOfComplex;

implementation

var
  State: QWord = 1;
  HaveSpareNormal: Boolean = False;
  SpareNormal: Double;

procedure SetSeed(ASeed: QWord);
begin
  State := ASeed;
  HaveSpareNormal := False;
end;

function NextBits: QWord;
var
  Z: QWord;
begin
  {$push}{$Q-}{$R-}
  State := State + QWord($9E3779B97F4A7C15);
  Z := State;
  Z := (Z xor (Z shr 30)) * QWord($BF58476D1CE4E5B9);
  Z := (Z xor (Z shr 27)) * QWord($94D049BB133111EB);
  {$pop}
  result := Z xor (Z shr 31);
end;

function RandomUniform: Double;
begin
  { 53 random bits mapped to [0, 1), then to [-1, 1). }
  result := (NextBits shr 11) * 1.1102230246251565E-16 * 2 - 1;
end;

function RandomNormal: Double;
var
  LU, LV, LS: Double;
begin
  if HaveSpareNormal then
  begin
    HaveSpareNormal := False;
    Exit(SpareNormal);
  end;
  { Marsaglia polar method. }
  repeat
    LU := RandomUniform;
    LV := RandomUniform;
    LS := LU * LU + LV * LV;
  until (LS > 0) and (LS < 1);
  LS := Sqrt(-2 * Ln(LS) / LS);
  SpareNormal := LV * LS;
  HaveSpareNormal := True;
  result := LU * LS;
end;

function RandomComplex: TComplex;
begin
  result := Complex(RandomUniform, RandomUniform);
end;

function RandomComplexNormal: TComplex;
begin
  result := Complex(RandomNormal, RandomNormal);
end;

function NewRealMatrix(N: Integer): TRealMatrix;
var
  LData: TArrayOfReal;
begin
  LData := nil;
  SetLength(LData, N * N);
  result.Init(LData);
end;

function NewComplexMatrix(N: Integer): TComplexMatrix;
var
  LData: TArrayOfComplex;
begin
  LData := nil;
  SetLength(LData, N * N);
  result.Init(LData);
end;

function NewRealVector(N: Integer): TRealVector;
var
  LData: TArrayOfReal;
begin
  LData := nil;
  SetLength(LData, N);
  result.Init(LData);
end;

function NewComplexVector(N: Integer): TComplexVector;
var
  LData: TArrayOfComplex;
begin
  LData := nil;
  SetLength(LData, N);
  result.Init(LData);
end;

function RandomRealMatrix(N: Integer): TRealMatrix;
var
  I, J: Integer;
begin
  result := NewRealMatrix(N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do result[I, J] := RandomUniform;
end;

function RandomComplexMatrix(N: Integer): TComplexMatrix;
var
  I, J: Integer;
begin
  result := NewComplexMatrix(N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do result[I, J] := RandomComplex;
end;

function RandomRealVector(N: Integer): TRealVector;
var
  I: Integer;
begin
  result := NewRealVector(N);
  for I := 0 to N - 1 do result[I] := RandomUniform;
end;

function RandomComplexVector(N: Integer): TComplexVector;
var
  I: Integer;
begin
  result := NewComplexVector(N);
  for I := 0 to N - 1 do result[I] := RandomComplex;
end;

{ Product of N Householder reflectors with Gaussian vectors, applied to the
  identity (Stewart's construction of Haar-distributed matrices). }
function RandomOrthogonal(N: Integer): TRealMatrix;
var
  V: TArrayOfReal;
  K, I, J: Integer;
  LNorm, LDot: Double;
begin
  result := NewRealMatrix(N);
  for I := 0 to N - 1 do result[I, I] := 1;
  SetLength(V, N);
  for K := 0 to N - 1 do
  begin
    LNorm := 0;
    for I := K to N - 1 do
    begin
      V[I] := RandomNormal;
      LNorm := Hypot(LNorm, V[I]);
    end;
    if LNorm = 0 then Continue;
    for I := K to N - 1 do V[I] := V[I] / LNorm;
    for I := 0 to N - 1 do
    begin
      LDot := 0;
      for J := K to N - 1 do LDot := LDot + result[I, J] * V[J];
      for J := K to N - 1 do
        result[I, J] := result[I, J] - 2 * LDot * V[J];
    end;
  end;
end;

function RandomUnitary(N: Integer): TComplexMatrix;
var
  V: TArrayOfComplex;
  K, I, J: Integer;
  LNorm: Double;
  LDot: TComplex;
begin
  result := NewComplexMatrix(N);
  for I := 0 to N - 1 do result[I, I] := 1;
  SetLength(V, N);
  for K := 0 to N - 1 do
  begin
    LNorm := 0;
    for I := K to N - 1 do
    begin
      V[I] := RandomComplexNormal;
      LNorm := Hypot(LNorm, V[I].Norm);
    end;
    if LNorm = 0 then Continue;
    for I := K to N - 1 do V[I] := V[I] / LNorm;
    for I := 0 to N - 1 do
    begin
      LDot := 0;
      for J := K to N - 1 do LDot := LDot + result[I, J] * V[J];
      for J := K to N - 1 do
        result[I, J] := result[I, J] - 2 * LDot * V[J].Conjugate;
    end;
  end;
end;

function SigmaValues(N: Integer; AMode: TSigmaMode; ACond: Double): TArrayOfReal;
var
  I: Integer;
begin
  result := nil;
  SetLength(result, N);
  for I := 0 to N - 1 do
    case AMode of
      smOneLarge:
        if I = 0 then result[I] := 1 else result[I] := 1 / ACond;
      smOneSmall:
        if I = N - 1 then result[I] := 1 / ACond else result[I] := 1;
      smGeometric:
        if N = 1 then result[I] := 1
        else result[I] := Power(ACond, -I / (N - 1));
      smArithmetic:
        if N = 1 then result[I] := 1
        else result[I] := 1 - (I / (N - 1)) * (1 - 1 / ACond);
      smRandomLog:
        result[I] := Power(ACond, -(RandomUniform + 1) / 2);
    end;
  if (AMode = smRandomLog) and (N > 1) then
  begin
    { Pin the extremes so that the condition number is exact. }
    result[0] := 1;
    result[N - 1] := 1 / ACond;
  end;
end;

function RealMatrixWithSigma(const ASigma: array of Double; AScale: Double): TRealMatrix;
var
  U, V, LResult: TRealMatrix;
  LSigma: TArrayOfReal;
  N, I, J, K: Integer;
  LSum: TDD;
begin
  N := Length(ASigma);
  SetLength(LSigma, N);
  for I := 0 to N - 1 do LSigma[I] := ASigma[I];
  U := RandomOrthogonal(N);
  V := RandomOrthogonal(N);
  LResult := NewRealMatrix(N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := 0;
      for K := 0 to N - 1 do
        LSum := LSum + TwoProd(U[I, K] * LSigma[K], V[J, K]);
      LResult[I, J] := LSum.ToDouble * AScale;
    end;
  result := LResult;
end;

function GenerateRealMatrix(N: Integer; AMode: TSigmaMode;
  ACond, AScale: Double): TRealMatrix;
begin
  result := RealMatrixWithSigma(SigmaValues(N, AMode, ACond), AScale);
end;

function GenerateComplexMatrix(N: Integer; AMode: TSigmaMode;
  ACond, AScale: Double): TComplexMatrix;
var
  U, V: TComplexMatrix;
  Sigma: TArrayOfReal;
  I, J, K: Integer;
  LSum: TDDComplex;
begin
  Sigma := SigmaValues(N, AMode, ACond);
  U := RandomUnitary(N);
  V := RandomUnitary(N);
  result := NewComplexMatrix(N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
        LSum := LSum + TDDComplex(U[I, K] * Sigma[K]) *
          TDDComplex(V[J, K].Conjugate);
      result[I, J] := LSum.ToComplex * AScale;
    end;
end;

function SymmetricWithSpectrum(const AValues: array of Double): TRealMatrix;
var
  Q: TRealMatrix;
  LValues: TArrayOfReal;
  N, I, J, K: Integer;
  LSum: TDD;
begin
  N := Length(AValues);
  SetLength(LValues, N);
  for I := 0 to N - 1 do LValues[I] := AValues[I];
  Q := RandomOrthogonal(N);
  result := NewRealMatrix(N);
  for I := 0 to N - 1 do
    for J := I to N - 1 do
    begin
      LSum := 0;
      for K := 0 to N - 1 do
        LSum := LSum + TwoProd(Q[I, K] * LValues[K], Q[J, K]);
      result[I, J] := LSum.ToDouble;
      result[J, I] := result[I, J];
    end;
end;

function HermitianWithSpectrum(const AValues: array of Double): TComplexMatrix;
var
  Q: TComplexMatrix;
  LValues: TArrayOfReal;
  N, I, J, K: Integer;
  LSum: TDDComplex;
begin
  N := Length(AValues);
  SetLength(LValues, N);
  for I := 0 to N - 1 do LValues[I] := AValues[I];
  Q := RandomUnitary(N);
  result := NewComplexMatrix(N);
  for I := 0 to N - 1 do
    for J := I to N - 1 do
    begin
      LSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
        LSum := LSum + TDDComplex(Q[I, K] * LValues[K]) *
          TDDComplex(Q[J, K].Conjugate);
      if I = J then
        result[I, I] := Complex(LSum.Re.ToDouble, 0)
      else
      begin
        result[I, J] := LSum.ToComplex;
        result[J, I] := result[I, J].Conjugate;
      end;
    end;
end;

function GeneralWithSpectrum(const AValues: array of TComplex;
  ACondX: Double; out AEigenCondition: TArrayOfReal): TComplexMatrix;
var
  U, V, X, XInverse: TComplexMatrix;
  Sigma: TArrayOfReal;
  LValues: TArrayOfComplex;
  N, I, J, K: Integer;
  LSum: TDDComplex;
  LColumn, LRow: Double;
begin
  N := Length(AValues);
  SetLength(LValues, N);
  for I := 0 to N - 1 do LValues[I] := AValues[I];
  Sigma := SigmaValues(N, smRandomLog, ACondX);
  U := RandomUnitary(N);
  V := RandomUnitary(N);
  X := NewComplexMatrix(N);
  XInverse := NewComplexMatrix(N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
        LSum := LSum + TDDComplex(U[I, K] * Sigma[K]) *
          TDDComplex(V[J, K].Conjugate);
      X[I, J] := LSum.ToComplex;
      LSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
        LSum := LSum + TDDComplex(V[I, K] / Sigma[K]) *
          TDDComplex(U[J, K].Conjugate);
      XInverse[I, J] := LSum.ToComplex;
    end;
  result := NewComplexMatrix(N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      LSum := DDComplex(0, 0);
      for K := 0 to N - 1 do
        LSum := LSum + TDDComplex(X[I, K]) * TDDComplex(LValues[K]) *
          TDDComplex(XInverse[K, J]);
      result[I, J] := LSum.ToComplex;
    end;
  AEigenCondition := nil;
  SetLength(AEigenCondition, N);
  for K := 0 to N - 1 do
  begin
    LColumn := 0;
    LRow := 0;
    for I := 0 to N - 1 do
    begin
      LColumn := Hypot(LColumn, X[I, K].Norm);
      LRow := Hypot(LRow, XInverse[K, I].Norm);
    end;
    AEigenCondition[K] := LColumn * LRow;
  end;
end;

function JordanBlock(N: Integer; ALambda: Double): TRealMatrix;
var
  I: Integer;
begin
  result := NewRealMatrix(N);
  for I := 0 to N - 1 do
  begin
    result[I, I] := ALambda;
    if I < N - 1 then result[I, I + 1] := 1;
  end;
end;

function CyclicPermutation(N: Integer): TRealMatrix;
var
  I: Integer;
begin
  result := NewRealMatrix(N);
  for I := 0 to N - 1 do result[(I + 1) mod N, I] := 1;
end;

{ Grcar matrix: -1 on the subdiagonal, 1 on the diagonal and on the first
  three superdiagonals; strongly non-normal. }
function GrcarMatrix(N: Integer): TRealMatrix;
var
  I, K: Integer;
begin
  result := NewRealMatrix(N);
  for I := 0 to N - 1 do
  begin
    if I > 0 then result[I, I - 1] := -1;
    for K := 0 to 3 do
      if I + K < N then result[I, I + K] := 1;
  end;
end;

{ Frank matrix: ill-conditioned eigenvalues, the smallest ones most. }
function FrankMatrix(N: Integer): TRealMatrix;
var
  I, J: Integer;
begin
  result := NewRealMatrix(N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
      if J >= I - 1 then result[I, J] := N - Max(I, J);
end;

{ Kahan matrix: upper triangular, diag s^i, entries -c*s^i above it. }
function KahanMatrix(N: Integer; ATheta: Double): TRealMatrix;
var
  I, J: Integer;
  LS, LC, LPower: Double;
begin
  result := NewRealMatrix(N);
  LS := Sin(ATheta);
  LC := Cos(ATheta);
  LPower := 1;
  for I := 0 to N - 1 do
  begin
    result[I, I] := LPower;
    for J := I + 1 to N - 1 do result[I, J] := -LC * LPower;
    LPower := LPower * LS;
  end;
end;

function HilbertMatrix(N: Integer): TRealMatrix;
var
  I, J: Integer;
begin
  result := NewRealMatrix(N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do result[I, J] := 1 / (I + J + 1);
end;

function CompanionMatrix(const ACoefficients: array of Double): TRealMatrix;
var
  LCoefficients: TArrayOfReal;
  N, I: Integer;
begin
  N := Length(ACoefficients);
  SetLength(LCoefficients, N);
  for I := 0 to N - 1 do LCoefficients[I] := ACoefficients[I];
  result := NewRealMatrix(N);
  for I := 0 to N - 1 do
  begin
    result[0, I] := -LCoefficients[I];
    if I > 0 then result[I, I - 1] := 1;
  end;
end;

procedure LaplacianTridiagonal(N: Integer; out ADiagonal, AOffDiagonal: TRealVector);
var
  I: Integer;
begin
  ADiagonal := NewRealVector(N);
  AOffDiagonal := NewRealVector(N - 1);
  for I := 0 to N - 1 do ADiagonal[I] := 2;
  for I := 0 to N - 2 do AOffDiagonal[I] := -1;
end;

{ Wilkinson W_N^+: diagonal |i - (N-1)/2|, unit off-diagonal; its largest
  eigenvalues come in pairs that agree to many digits. }
procedure WilkinsonTridiagonal(N: Integer; out ADiagonal, AOffDiagonal: TRealVector);
var
  I: Integer;
begin
  ADiagonal := NewRealVector(N);
  AOffDiagonal := NewRealVector(N - 1);
  for I := 0 to N - 1 do ADiagonal[I] := System.Abs(I - (N - 1) / 2);
  for I := 0 to N - 2 do AOffDiagonal[I] := 1;
end;

procedure RandomTridiagonal(N: Integer; out ADiagonal, AOffDiagonal: TRealVector);
var
  I: Integer;
begin
  ADiagonal := NewRealVector(N);
  AOffDiagonal := NewRealVector(N - 1);
  for I := 0 to N - 1 do ADiagonal[I] := RandomUniform;
  for I := 0 to N - 2 do AOffDiagonal[I] := RandomUniform;
end;

function TridiagonalToMatrix(const ADiagonal, AOffDiagonal: TRealVector): TRealMatrix;
var
  I: Integer;
begin
  result := NewRealMatrix(ADiagonal.Size);
  for I := 0 to ADiagonal.Size - 1 do
  begin
    result[I, I] := ADiagonal[I];
    if I < ADiagonal.Size - 1 then
    begin
      result[I + 1, I] := AOffDiagonal[I];
      result[I, I + 1] := AOffDiagonal[I];
    end;
  end;
end;

function HermitianTridiagonalToMatrix(const ADiagonal: TRealVector;
  const AOffDiagonal: TComplexVector): TComplexMatrix;
var
  I: Integer;
begin
  result := NewComplexMatrix(ADiagonal.Size);
  for I := 0 to ADiagonal.Size - 1 do
  begin
    result[I, I] := ADiagonal[I];
    if I < ADiagonal.Size - 1 then
    begin
      result[I + 1, I] := AOffDiagonal[I];
      result[I, I + 1] := AOffDiagonal[I].Conjugate;
    end;
  end;
end;

function CoefficientsFromRoots(const ARoots: array of TComplex): TArrayOfComplex;
var
  LCoefficients: array of TDDComplex;
  N, I, K: Integer;
begin
  N := Length(ARoots);
  SetLength(LCoefficients, N + 1);
  LCoefficients[0] := DDComplex(1, 0);
  for I := 1 to N do LCoefficients[I] := DDComplex(0, 0);
  { Multiply by (x - r) for each root; LCoefficients[k] multiplies x^(n-k). }
  for I := 0 to N - 1 do
    for K := I + 1 downto 1 do
      LCoefficients[K] := LCoefficients[K] -
        TDDComplex(ARoots[I]) * LCoefficients[K - 1];
  result := nil;
  SetLength(result, N);
  for K := 1 to N do result[K - 1] := LCoefficients[K].ToComplex;
end;

end.
