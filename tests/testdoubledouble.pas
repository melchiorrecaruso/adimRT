{ TestDoubleDouble - Double-double arithmetic used as the reference oracle.

  A TDD value is the unevaluated sum Hi + Lo of two binary64 numbers with
  |Lo| <= ulp(Hi)/2, giving about 106 significant bits. The algorithms are
  the error-free transformations of Knuth (TwoSum) and Dekker (Split,
  TwoProd), as described in:

    T. J. Dekker, "A floating-point technique for extending the available
    precision", Numer. Math. 18 (1971).
    Y. Hida, X. S. Li, D. H. Bailey, "Library for double-double and
    quad-double arithmetic", LBNL report (2007).

  They need every operation rounded to binary64; on i386 the runner sets the
  x87 precision control accordingly. `Extended` is not used because it is an
  alias of `Double` on Win64 and other targets. }
unit TestDoubleDouble;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}

interface

uses
  Math, ADimMath;

type
  TDD = record
    Hi, Lo: Double;
    class operator :=(const AValue: Double): TDD;
    class operator +(const ALeft, ARight: TDD): TDD;
    class operator -(const ALeft, ARight: TDD): TDD;
    class operator -(const AValue: TDD): TDD;
    class operator *(const ALeft, ARight: TDD): TDD;
    class operator /(const ALeft, ARight: TDD): TDD;
    class operator <(const ALeft, ARight: TDD): Boolean;
    class operator >(const ALeft, ARight: TDD): Boolean;
    function ToDouble: Double;
  end;

  TDDComplex = record
    Re, Im: TDD;
    class operator :=(const AValue: TComplex): TDDComplex;
    class operator +(const ALeft, ARight: TDDComplex): TDDComplex;
    class operator -(const ALeft, ARight: TDDComplex): TDDComplex;
    class operator *(const ALeft, ARight: TDDComplex): TDDComplex;
    class operator /(const ALeft, ARight: TDDComplex): TDDComplex;
    function ToComplex: TComplex;
  end;

{ Exact sum and product of two doubles as a double-double. }
function TwoSum(A, B: Double): TDD;
function TwoProd(A, B: Double): TDD;

function DDAbs(const AValue: TDD): TDD;
function DDSqrt(const AValue: TDD): TDD;
function DDHypot(const ARe, AIm: TDD): TDD;
function DDComplex(const ARe, AIm: TDD): TDDComplex;
function DDModulus(const AValue: TDDComplex): TDD;
{ Principal square root. }
function DDComplexSqrt(const AValue: TDDComplex): TDDComplex;

implementation

const
  SplitFactor = 134217729.0; { 2^27 + 1 }
  SplitLimit = 6.69692879491417E+299; { 2^996 }

function QuickTwoSum(A, B: Double): TDD; inline;
begin
  result.Hi := A + B;
  result.Lo := B - (result.Hi - A);
end;

function TwoSum(A, B: Double): TDD;
var
  LVirtual: Double;
begin
  result.Hi := A + B;
  LVirtual := result.Hi - A;
  result.Lo := (A - (result.Hi - LVirtual)) + (B - LVirtual);
end;

procedure Split(A: Double; out AHi, ALo: Double);
var
  LTemp: Double;
begin
  if System.Abs(A) > SplitLimit then
  begin
    { Scale to avoid overflow of SplitFactor*A; exact for powers of two. }
    A := A * 3.7252902984619140625E-09; { 2^-28 }
    LTemp := SplitFactor * A;
    AHi := LTemp - (LTemp - A);
    ALo := A - AHi;
    AHi := AHi * 268435456.0; { 2^28 }
    ALo := ALo * 268435456.0;
  end else
  begin
    LTemp := SplitFactor * A;
    AHi := LTemp - (LTemp - A);
    ALo := A - AHi;
  end;
end;

function TwoProd(A, B: Double): TDD;
var
  LAHi, LALo, LBHi, LBLo: Double;
begin
  result.Hi := A * B;
  if (result.Hi = 0) or IsInfinite(result.Hi) or IsNan(result.Hi) then
  begin
    result.Lo := 0;
    Exit;
  end;
  Split(A, LAHi, LALo);
  Split(B, LBHi, LBLo);
  result.Lo := ((LAHi * LBHi - result.Hi) + LAHi * LBLo + LALo * LBHi) +
    LALo * LBLo;
end;

class operator TDD.:=(const AValue: Double): TDD;
begin
  result.Hi := AValue;
  result.Lo := 0;
end;

class operator TDD.+(const ALeft, ARight: TDD): TDD;
var
  LS, LT: TDD;
begin
  LS := TwoSum(ALeft.Hi, ARight.Hi);
  LT := TwoSum(ALeft.Lo, ARight.Lo);
  LS.Lo := LS.Lo + LT.Hi;
  LS := QuickTwoSum(LS.Hi, LS.Lo);
  LS.Lo := LS.Lo + LT.Lo;
  result := QuickTwoSum(LS.Hi, LS.Lo);
end;

class operator TDD.-(const AValue: TDD): TDD;
begin
  result.Hi := -AValue.Hi;
  result.Lo := -AValue.Lo;
end;

class operator TDD.-(const ALeft, ARight: TDD): TDD;
begin
  result := ALeft + (-ARight);
end;

class operator TDD.*(const ALeft, ARight: TDD): TDD;
var
  LP: TDD;
begin
  LP := TwoProd(ALeft.Hi, ARight.Hi);
  LP.Lo := LP.Lo + (ALeft.Hi * ARight.Lo + ALeft.Lo * ARight.Hi);
  result := QuickTwoSum(LP.Hi, LP.Lo);
end;

class operator TDD./(const ALeft, ARight: TDD): TDD;
var
  LQ1, LQ2, LQ3: Double;
  LR: TDD;
begin
  LQ1 := ALeft.Hi / ARight.Hi;
  LR := ALeft - ARight * TDD(LQ1);
  LQ2 := LR.Hi / ARight.Hi;
  LR := LR - ARight * TDD(LQ2);
  LQ3 := LR.Hi / ARight.Hi;
  result := QuickTwoSum(LQ1, LQ2);
  result := result + TDD(LQ3);
end;

class operator TDD.<(const ALeft, ARight: TDD): Boolean;
begin
  result := (ALeft.Hi < ARight.Hi) or
    ((ALeft.Hi = ARight.Hi) and (ALeft.Lo < ARight.Lo));
end;

class operator TDD.>(const ALeft, ARight: TDD): Boolean;
begin
  result := ARight < ALeft;
end;

function TDD.ToDouble: Double;
begin
  result := Hi + Lo;
end;

function DDAbs(const AValue: TDD): TDD;
begin
  if AValue.Hi < 0 then result := -AValue else result := AValue;
end;

function DDSqrt(const AValue: TDD): TDD;
var
  LX: Double;
begin
  if AValue.Hi <= 0 then Exit(TDD(0));
  LX := Sqrt(AValue.Hi);
  { One Newton step doubles the number of correct bits. }
  result := TDD(LX) + (AValue - TwoProd(LX, LX)) / TDD(2 * LX);
end;

function DDHypot(const ARe, AIm: TDD): TDD;
var
  LScale: Double;
  LRe, LIm: TDD;
begin
  LScale := Max(System.Abs(ARe.Hi), System.Abs(AIm.Hi));
  if LScale = 0 then Exit(TDD(0));
  { Power-of-two scaling keeps the squares in range and is exact. }
  LScale := IntPower(2, Math.Floor(Math.Log2(LScale)));
  LRe := ARe / TDD(LScale);
  LIm := AIm / TDD(LScale);
  result := DDSqrt(LRe * LRe + LIm * LIm) * TDD(LScale);
end;

function DDComplex(const ARe, AIm: TDD): TDDComplex;
begin
  result.Re := ARe;
  result.Im := AIm;
end;

function DDModulus(const AValue: TDDComplex): TDD;
begin
  result := DDHypot(AValue.Re, AValue.Im);
end;

{ AValue * 2^AExponent, exact unless the result is subnormal. }
function DDScale(const AValue: TDD; AExponent: Integer): TDD;
begin
  result.Hi := Ldexp(AValue.Hi, AExponent);
  result.Lo := Ldexp(AValue.Lo, AExponent);
end;

function DDComplexSqrt(const AValue: TDDComplex): TDDComplex;
var
  LModulus, LLarge, LSmall: TDD;
  LScaled: TDDComplex;
  LExponent: Integer;
  LMax: Double;
begin
  LMax := Max(System.Abs(AValue.Re.Hi), System.Abs(AValue.Im.Hi));
  if LMax = 0 then Exit(DDComplex(0, 0));
  { Scale by an even power of two so that the modulus stays in range;
    sqrt(z) = 2^e * sqrt(z / 4^e). }
  LExponent := Math.Floor(Math.Log2(LMax)) div 2;
  if LExponent <> 0 then
  begin
    LScaled.Re := DDScale(AValue.Re, -2 * LExponent);
    LScaled.Im := DDScale(AValue.Im, -2 * LExponent);
    result := DDComplexSqrt(LScaled);
    result.Re := DDScale(result.Re, LExponent);
    result.Im := DDScale(result.Im, LExponent);
    Exit;
  end;
  LModulus := DDModulus(AValue);
  LLarge := DDSqrt((DDAbs(AValue.Re) + LModulus) / TDD(2));
  LSmall := DDAbs(AValue.Im) / (TDD(2) * LLarge);
  if AValue.Re.Hi >= 0 then
    result := DDComplex(LLarge, LSmall)
  else
    result := DDComplex(LSmall, LLarge);
  if AValue.Im.Hi < 0 then result.Im := -result.Im;
end;

class operator TDDComplex.:=(const AValue: TComplex): TDDComplex;
begin
  result.Re := AValue.Re;
  result.Im := AValue.Im;
end;

class operator TDDComplex.+(const ALeft, ARight: TDDComplex): TDDComplex;
begin
  result.Re := ALeft.Re + ARight.Re;
  result.Im := ALeft.Im + ARight.Im;
end;

class operator TDDComplex.-(const ALeft, ARight: TDDComplex): TDDComplex;
begin
  result.Re := ALeft.Re - ARight.Re;
  result.Im := ALeft.Im - ARight.Im;
end;

class operator TDDComplex.*(const ALeft, ARight: TDDComplex): TDDComplex;
begin
  result.Re := ALeft.Re * ARight.Re - ALeft.Im * ARight.Im;
  result.Im := ALeft.Re * ARight.Im + ALeft.Im * ARight.Re;
end;

class operator TDDComplex./(const ALeft, ARight: TDDComplex): TDDComplex;
var
  LScale: Double;
  LRe, LIm, LDenominator: TDD;
begin
  { Scale the divisor by a power of two (exact) so that its squared
    modulus neither underflows nor overflows. }
  LScale := Max(System.Abs(ARight.Re.Hi), System.Abs(ARight.Im.Hi));
  LScale := IntPower(2, -Math.Floor(Math.Log2(LScale)));
  LRe := ARight.Re * TDD(LScale);
  LIm := ARight.Im * TDD(LScale);
  LDenominator := LRe * LRe + LIm * LIm;
  result.Re := (ALeft.Re * LRe + ALeft.Im * LIm) / LDenominator * TDD(LScale);
  result.Im := (ALeft.Im * LRe - ALeft.Re * LIm) / LDenominator * TDD(LScale);
end;

function TDDComplex.ToComplex: TComplex;
begin
  result := Complex(Re.ToDouble, Im.ToDouble);
end;

end.
