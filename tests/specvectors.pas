{ SpecVectors - TRealVector and TComplexVector.

  Dot computes the products with the scalar operator and adds them with
  Neumaier's compensated summation, which is algorithm Sum2 of T. Ogita,
  S. M. Rump, S. Oishi, "Accurate sum and dot product", SIAM J. Sci.
  Comput. 26 (2005). For the products p_i as rounded by the scalar
  operator, with s = sum p_i (computed exactly in double-double here), the
  proved bound (Proposition 4.5) is

      |Dot - s| <= u*|s| + gamma(n-1)^2 * sum |p_i|,

  applied to each component of a complex result. The naive bound
  gamma(n)*sum|p_i| would accept a broken compensation.

  Norm uses a scaled sum of squares; the bound gamma(n+2)*||x|| is the
  forward-error bound of recursive summation of n non-negative terms
  followed by a square root (Higham, Accuracy and Stability, ch. 3-4). }
unit SpecVectors;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}
{$modeswitch nestedprocvars}

interface

{ Ratio of the error of a compensated sum of AProducts to the Sum2 bound;
  shared with the matrix product checks. }
function CompensatedSumRatio(AComputed: Double; const AProducts: array of Double): Double;

implementation

uses
  SysUtils, Math, ADimMath, TestRunner, TestDoubleDouble, TestGenerators,
  TestMeasures;

function CompensatedSumRatio(AComputed: Double; const AProducts: array of Double): Double;
var
  LSum: TDD;
  LAbsolute, LBound, LExact: Double;
  I: Integer;
begin
  LSum := 0;
  LAbsolute := 0;
  for I := 0 to High(AProducts) do
  begin
    LSum := LSum + TDD(AProducts[I]);
    LAbsolute := LAbsolute + System.Abs(AProducts[I]);
  end;
  LExact := LSum.ToDouble;
  LBound := UnitRoundoff * System.Abs(LExact) +
    Sqr(Gamma(Max(Length(AProducts) - 1, 1))) * LAbsolute;
  if AComputed = LExact then Exit(0);
  if LBound = 0 then Exit(Infinity);
  { The exact error, evaluated in double-double. }
  result := DDAbs(TDD(AComputed) - LSum).ToDouble / LBound;
end;

procedure CheckRealDot(const ALabel: string; const X, Y: TRealVector);
var
  LProducts: array of Double;
  I: Integer;
begin
  SetLength(LProducts, X.Size);
  for I := 0 to X.Size - 1 do LProducts[I] := X[I] * Y[I];
  CheckRatio(ALabel, CompensatedSumRatio(X * Y, LProducts));
end;

procedure CheckComplexDot(const ALabel: string; const X, Y: TComplexVector);
var
  LRe, LIm: array of Double;
  LProduct, LDot: TComplex;
  I: Integer;
begin
  SetLength(LRe, X.Size);
  SetLength(LIm, X.Size);
  for I := 0 to X.Size - 1 do
  begin
    LProduct := X[I] * Y[I];
    LRe[I] := LProduct.Re;
    LIm[I] := LProduct.Im;
  end;
  LDot := X * Y;
  CheckRatio(ALabel + ' Re', CompensatedSumRatio(LDot.Re, LRe));
  CheckRatio(ALabel + ' Im', CompensatedSumRatio(LDot.Im, LIm));
end;

{ A vector whose products with the all-ones vector cancel: large values
  of both signs plus a few of order one. }
function CancellingRealVector(N: Integer; ABig: Double): TRealVector;
var
  I: Integer;
begin
  result := NewRealVector(N);
  for I := 0 to N - 1 do
    if I mod 3 = 2 then result[I] := RandomUniform
    else result[I] := ABig * RandomUniform;
  { Make the large part sum to (nearly) zero. }
  if N >= 2 then
  begin
    result[N - 1] := 0;
    for I := 0 to N - 2 do
      if I mod 3 <> 2 then result[N - 1] := result[N - 1] - result[I];
  end;
end;

procedure ContractChecks;
var
  X, Y, Z: TRealVector;
  CX: TComplexVector;
  LValue: TComplex;
  LNorm: Double;
  LMask: TFPUExceptionMask;

  procedure MismatchedSum;
  begin
    Z := X + Y;
  end;

  procedure MismatchedDot;
  begin
    LValue := X * Y;
  end;

  procedure NormOfX;
  begin
    LNorm := X.Norm;
  end;

  procedure EmptyDot;
  begin
    X.Init([]);
    LValue := X * X;
  end;

  procedure NormalizeNull;
  begin
    Z := NewRealVector(3).Normalize;
  end;

  procedure ReciprocalNull;
  begin
    Z := NewRealVector(3).Reciprocal;
  end;

  procedure CrossOfTwo;
  begin
    X.Init([1, 2]);
    Z := X.Cross(X);
  end;

begin
  Group('Construction, size and value semantics', ckContract);
  X.Init([1, 2, 3]);
  CheckEqual('Size', X.Size, 3);
  CheckEqual('index', X[1], 2);
  Y := X;
  Y[0] := 10;
  CheckEqual('assignment copies (original unchanged)', X[0], 1);
  X.Init([1, 2, 3]);
  Y.Init([1, 2, 3]);
  Check('= exact', X = Y);
  Y[2] := 3 + 4 * Ulp;
  Check('<> exact', X <> Y);
  Y.Init([1, 2]);
  Check('= different sizes', not (X = Y));
  CX := X.ToComplex;
  CheckEqual('ToComplex', CX[2], Complex(3, 0));
  CX.Init([Complex(1, 2), Complex(-3, 4)]);
  CheckEqual('Conjugate', CX.Conjugate[1], Complex(-3, -4));

  Group('Exceptions', ckContract);
  X.Init([1, 2, 3]);
  Y.Init([1, 2]);
  CheckRaises('x + y with different sizes', EDimensionError, @MismatchedSum);
  CheckRaises('x . y with different sizes', EDimensionError, @MismatchedDot);
  CheckRaises('dot of empty vectors', EDimensionError, @EmptyDot);
  CheckRaises('Normalize of null vector raises EZeroDivide', EZeroDivide, @NormalizeNull);
  CheckRaises('Reciprocal of null vector raises EZeroDivide', EZeroDivide, @ReciprocalNull);
  CheckRaises('Cross needs size 3', EDimensionError, @CrossOfTwo);

  Group('IsNull (absolute DefaultEpsilon tolerance)', ckContract);
  X.Init([1E-13, -1E-13]);
  Check('IsNull small', X.IsNull);
  X.Init([1E-11, 0]);
  Check('IsNotNull', X.IsNotNull);

  { With the default FPC exception mask a NaN operand raises EInvalidOp;
    with masked exceptions it propagates. Infinity propagates in both. }
  Group('Non-finite input in Norm', ckContract);
  X.Init([1, NaN, 2]);
  CheckRaises('NaN raises EInvalidOp (default FPU mask)', EInvalidOp, @NormOfX);
  LMask := GetExceptionMask;
  SetExceptionMask(LMask + [exInvalidOp]);
  try
    Check('NaN propagates (masked)', IsNan(X.Norm));
  finally
    SetExceptionMask(LMask);
  end;
  X.Init([1, Infinity, 2]);
  Check('Norm with Inf is Inf', IsInfinite(X.Norm));
end;

procedure ExactChecks;
var
  X, Y: TRealVector;
  CX, CY: TComplexVector;
  N, I, K: Integer;
  LS: TComplex;
  LOk: Boolean;
begin
  Group('Elementwise operations equal the scalar operations', ckExact);
  SetSeed(501);
  for K := 1 to 40 do
  begin
    N := K mod 9 + 1;
    X := RandomRealVector(N);
    Y := RandomRealVector(N);
    CX := RandomComplexVector(N);
    CY := RandomComplexVector(N);
    LS := RandomComplex;
    LOk := True;
    for I := 0 to N - 1 do
      LOk := LOk and ((X + Y)[I] = X[I] + Y[I]) and ((X - Y)[I] = X[I] - Y[I]) and
        ((-X)[I] = -X[I]) and ((2.5 * X)[I] = 2.5 * X[I]) and
        ((X / 3.0)[I] = X[I] / 3) and
        ((CX + CY)[I] = CX[I] + CY[I]) and ((CX - CY)[I] = CX[I] - CY[I]) and
        ((LS * CX)[I] = LS * CX[I]) and ((CX * LS)[I] = CX[I] * LS) and
        ((CX / LS)[I] = CX[I] / LS) and ((+CX)[I] = CX[I]);
    Check(Format('n=%d #%d', [N, K]), LOk);
  end;

  Group('Cross product of integer vectors', ckExact);
  X.Init([1, 2, 3]);
  Y.Init([-4, 5, -2]);
  Check('(1,2,3) x (-4,5,-2) = (-19,-10,13)',
    (X.Cross(Y)[0] = -19) and (X.Cross(Y)[1] = -10) and (X.Cross(Y)[2] = 13));
  Check('x cross x = 0', X.Cross(X).Norm = 0);
end;

procedure DotAccuracy;
const
  Sizes: array[0..6] of Integer = (1, 2, 3, 7, 16, 64, 257);
var
  S, K, I: Integer;
  X, Y: TRealVector;
  CX, CY: TComplexVector;
begin
  Group('Dot, compensated-sum bound per component', ckAccuracy, 1, tsProved,
    'Ogita-Rump-Oishi 2005, Prop. 4.5');
  SetSeed(511);
  for S := Low(Sizes) to High(Sizes) do
    for K := 1 to 20 do
    begin
      X := RandomRealVector(Sizes[S]);
      Y := RandomRealVector(Sizes[S]);
      CheckRealDot(Format('random real n=%d #%d', [Sizes[S], K]), X, Y);
      CX := RandomComplexVector(Sizes[S]);
      CY := RandomComplexVector(Sizes[S]);
      CheckComplexDot(Format('random complex n=%d #%d', [Sizes[S], K]), CX, CY);
      { Heavy cancellation with the all-ones vector. }
      X := CancellingRealVector(Sizes[S], 1E16);
      Y := NewRealVector(Sizes[S]);
      for I := 0 to Sizes[S] - 1 do Y[I] := 1;
      CheckRealDot(Format('cancelling real n=%d #%d', [Sizes[S], K]), X, Y);
      { Complex: real and imaginary parts cancel in different elements. }
      CX := NewComplexVector(Sizes[S]);
      CY := NewComplexVector(Sizes[S]);
      for I := 0 to Sizes[S] - 1 do
      begin
        CX[I] := Complex(X[I], CancellingRealVector(Sizes[S], 1E16)[I]);
        CY[I] := 1;
      end;
      CheckComplexDot(Format('cancelling complex n=%d #%d', [Sizes[S], K]), CX, CY);
    end;
  CX.Init([Complex(1E16, 1), Complex(1, 1E16), Complex(-1E16, -1E16)]);
  CY.Init([1, 1, 1]);
  CheckComplexDot('parts dominated by different elements', CX, CY);
end;

procedure NormAccuracy;
const
  Sizes: array[0..5] of Integer = (1, 2, 5, 16, 100, 1000);
  Scales: array[0..6] of Double = (1E-300, 1E-150, 1E-20, 1, 1E20, 1E150, 1E300);
var
  S, T, K, I: Integer;
  X, R: TRealVector;
  CX: TComplexVector;
  LSum: TDD;
  LReference: Double;
begin
  Group('Norm, relative error', ckAccuracy, 1, tsProject,
    'gamma(n+2) forward-error bound');
  SetSeed(521);
  for S := Low(Sizes) to High(Sizes) do
    for T := Low(Scales) to High(Scales) do
      for K := 1 to 5 do
      begin
        X := RandomRealVector(Sizes[S]);
        LSum := 0;
        for I := 0 to X.Size - 1 do LSum := LSum + TwoProd(X[I], X[I]);
        LReference := DDSqrt(LSum).ToDouble * Scales[T];
        for I := 0 to X.Size - 1 do X[I] := X[I] * Scales[T];
        CheckRatio(Format('real n=%d scale %g #%d', [Sizes[S], Scales[T], K]),
          System.Abs(X.Norm - LReference) / (Gamma(Sizes[S] + 2) * LReference));
        CX := RandomComplexVector(Sizes[S]);
        LSum := 0;
        for I := 0 to CX.Size - 1 do
          LSum := LSum + TwoProd(CX[I].Re, CX[I].Re) + TwoProd(CX[I].Im, CX[I].Im);
        LReference := DDSqrt(LSum).ToDouble * Scales[T];
        for I := 0 to CX.Size - 1 do CX[I] := CX[I] * Scales[T];
        CheckRatio(Format('complex n=%d scale %g #%d', [Sizes[S], Scales[T], K]),
          System.Abs(CX.Norm - LReference) / (Gamma(2 * Sizes[S] + 2) * LReference));
      end;
  X.Init([1E308, 1E308]);
  CheckRatio('[1e308, 1e308] stays finite',
    System.Abs(X.Norm - 1E308 * Sqrt(2)) / (Gamma(4) * 1E308 * Sqrt(2)));
  X.Init([1E300, 1E-300]);
  CheckRatio('[1e300, 1e-300]', System.Abs(X.Norm - 1E300) / (Gamma(4) * 1E300));
  X.Init([3E-320, 4E-320]);
  Check('subnormal components give a positive norm', X.Norm > 0);

  Group('Normalize and Reciprocal, relative error', ckAccuracy, 1, tsProject,
    'gamma(n+4) forward-error bound');
  SetSeed(522);
  for S := Low(Sizes) to High(Sizes) do
    for T := 1 to 5 do
    begin
      X := RandomRealVector(Sizes[S]) * Scales[T];
      CheckRatio(Format('||normalize(x)|| n=%d scale %g', [Sizes[S], Scales[T]]),
        System.Abs(X.Normalize.Norm - 1) / Gamma(Sizes[S] + 4));
      R := X.Reciprocal;
      CheckRatio(Format('x . reciprocal(x) n=%d scale %g', [Sizes[S], Scales[T]]),
        System.Abs(X * R - 1) / Gamma(2 * Sizes[S] + 4));
    end;
end;

procedure PropertyChecks;
var
  K: Integer;
  X, Y, Z: TRealVector;
begin
  Group('Cross product orthogonality', ckProperty, 1, tsProject,
    'gamma(6) per component');
  SetSeed(531);
  for K := 1 to 100 do
  begin
    X := RandomRealVector(3);
    Y := RandomRealVector(3);
    Z := X.Cross(Y);
    CheckRatio(Format('(x cross y) . x #%d', [K]),
      System.Abs(Z * X) / (Gamma(6) * Z.Norm * X.Norm * 3));
    CheckRatio(Format('(x cross y) . y #%d', [K]),
      System.Abs(Z * Y) / (Gamma(6) * Z.Norm * Y.Norm * 3));
  end;
end;

procedure Run;
begin
  Guard(@ContractChecks);
  Guard(@ExactChecks);
  Guard(@DotAccuracy);
  Guard(@NormAccuracy);
  Guard(@PropertyChecks);
end;

initialization
  RegisterSpec('Vectors (TRealVector, TComplexVector)', @Run);
end.
