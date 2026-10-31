{ ADim mathematical types and operations.

  Defines real and complex scalar types, dynamically sized vectors and square
  matrices, and the related algebraic operations used throughout the ADimPas
  library. Vector sizes and matrix orders are inferred from the values passed
  to Init.

  @author Melchiorre Caruso (melchiorrecaruso@@gmail.com)
  @copyright 2025-2026 Melchiorre Caruso
  @license MIT License, see the file LICENSE.

  This unit is part of the ADim library, distributed under the MIT License
  (see the file LICENSE).
}

unit ADimMath;

{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function's return value.
{$WARN 6058 OFF} // Suppress warning for function marked as inline that cannot be inlined.

interface

uses
  Math, SysUtils;

type
  { Represents a real number. }
  TReal = double;

  { Dynamic array of @code(TReal) values. }
  TArrayOfReal = array of TReal;

  { Represents a complex number in Cartesian form: @code(z = Re + i·Im).

    A complex number consists of:
    @unorderedList(
      @item(@bold(Re): the real part)
      @item(@bold(Im): the imaginary part)
    )
    The imaginary unit @code(i) is defined by @code(i² = -1).
    All arithmetic operations follow standard complex number algebra.
  }
  TComplex = record
  private
    fRe, fIm: TReal;
  public
    { Returns the argument (phase angle) of the complex number, in radians.
      The angle is measured from the positive real axis with the quadrant
      determined from both @link(Re) and @link(Im).
    }
    function Arg: TReal;

    { Returns the complex conjugate of the number.
      If @code(z = a + i·b), the conjugate is @code(z* = a - i·b).
    }
    function Conjugate: TComplex;

    { Returns @true if both @code(|Re|) and @code(|Im|) are at most
      @link(DefaultEpsilon). The tolerance is absolute: it does not scale
      with the magnitude of the operands, so it is meant for values of order
      one and not as a numerical zero test. }
    function IsNull: boolean;

    { Returns @code(not IsNull). }
    function IsNotNull: boolean;

    { Returns the modulus (magnitude) of the complex number:
      @code(|z| = √(Re² + Im²)).
    }
    function Norm: TReal;

    { Returns the squared modulus of the complex number:
      @code(|z|² = Re² + Im²).
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: TReal;

    { Returns @true if this value and AValue differ by no more than
      @link(DefaultEpsilon) in both components (absolute tolerance). }
    function SameValue(const AValue: TComplex): boolean;

    { Returns the reciprocal of the complex number: @code(1 / z). }
    function Reciprocal: TComplex;

    { Converts the complex number to its default string representation. }
    function ToString: string;

    { Converts the complex number to a formatted string with controlled precision.
      @param(APrecision Number of significant digits for floating point formatting.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Sets the complex number to zero. }
    procedure Zero;

    { Implicit conversion from a real value to a complex number. }
    class operator :=(const AValue: TReal): TComplex;

    { Returns @true if the real or imaginary parts of the two operands differ. }
    class operator <>(const ALeft, ARight: TComplex): boolean; inline;

    { Returns @true if both the real and imaginary parts of the two operands are equal. }
    class operator =(const ALeft, ARight: TComplex): boolean; inline;

    { Unary plus. Returns the complex number unchanged. }
    class operator +(const AValue: TComplex): TComplex; inline;

    { Returns the sum of two complex numbers. }
    class operator +(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the sum of a real number and a complex number. }
    class operator +(const ALeft: TReal; const ARight: TComplex): TComplex; inline;

    { Returns the sum of a complex number and a real number. }
    class operator +(const ALeft: TComplex; const ARight: TReal): TComplex; inline;

    { Unary minus. Returns the negation of the complex number. }
    class operator -(const AValue: TComplex): TComplex; inline;

    { Returns the difference of two complex numbers. }
    class operator -(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the difference of a real number and a complex number. }
    class operator -(const ALeft: TReal; const ARight: TComplex): TComplex; inline;

    { Returns the difference of a complex number and a real number. }
    class operator -(const ALeft: TComplex; const ARight: TReal): TComplex; inline;

    { Returns the product of two complex numbers. }
    class operator *(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the product of a real number and a complex number. }
    class operator *(const ALeft: TReal; const ARight: TComplex): TComplex; inline;

    { Returns the product of a complex number and a real number. }
    class operator *(const ALeft: TComplex; const ARight: TReal): TComplex; inline;

    { Returns the quotient of two complex numbers. }
    class operator /(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the quotient of a real number divided by a complex number. }
    class operator /(const ALeft: TReal; const ARight: TComplex): TComplex; inline;

    { Returns the quotient of a complex number divided by a real number. }
    class operator /(const ALeft: TComplex; const ARight: TReal): TComplex; inline;

  public
    { Real part of the complex number. }
    property Re: TReal read fRe write fRe;

    { Imaginary part of the complex number. }
    property Im: TReal read fIm write fIm;
  end;

  { Dynamic array of @link(TComplex) values. }
  TArrayOfComplex = array of TComplex;

  { Represents the imaginary unit @code(i), defined by @code(i² = -1).

    This record has no fields: it acts as a compile-time constant used to
    construct @link(TComplex) numbers naturally via operator overloading.
    A global variable of this type (conventionally named @code(img)) should be
    declared to allow idiomatic use such as @code(3.0 + 2.0*img).
  }
  TImaginaryUnit = record
  public
    { Implicit conversion of the imaginary unit to a @link(TComplex) number. }
    class operator :=(const ASelf: TImaginaryUnit): TComplex;

    { Returns @code(i·i = -1). }
    class operator *(const ALeft, ARight: TImaginaryUnit): TReal;

    { Returns @code(i/i = 1). }
    class operator /(const ALeft, ARight: TImaginaryUnit): TReal;

    { Returns @code(-i) as a @link(TComplex). }
    class operator -(const AValue: TImaginaryUnit): TComplex;

    { Returns @code(+i) as a @link(TComplex). }
    class operator +(const AValue: TImaginaryUnit): TComplex;

    { Returns @code(a + i) as a @link(TComplex). }
    class operator +(const ALeft: TReal; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i + a) as a @link(TComplex). }
    class operator +(const ALeft: TImaginaryUnit; const ARight: TReal): TComplex;

    { Returns @code(a - i) as a @link(TComplex). }
    class operator -(const ALeft: TReal; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i - a) as a @link(TComplex). }
    class operator -(const ALeft: TImaginaryUnit; const ARight: TReal): TComplex;

    { Returns @code((a+bi) + i). }
    class operator +(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i + (a+bi)). }
    class operator +(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    { Returns @code((a+bi) - i). }
    class operator -(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i - (a+bi)). }
    class operator -(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    { Returns @code(a·i) as a @link(TComplex). }
    class operator *(const ALeft: TReal; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i·a) as a @link(TComplex). }
    class operator *(const ALeft: TImaginaryUnit; const ARight: TReal): TComplex;

    { Returns @code((a+bi)·i = -b + ai). }
    class operator *(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i·(a+bi) = -b + ai). }
    class operator *(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    { Returns @code(a/i = -ai). }
    class operator /(const ALeft: TReal; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i/a). }
    class operator /(const ALeft: TImaginaryUnit; const ARight: TReal): TComplex;

    { Returns @code((a+bi)/i = b - ai). }
    class operator /(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i/(a+bi)). }
    class operator /(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
  end;

function Abs(const AValue: TComplex): TReal; overload;

type
  TRealHelper = type helper for TReal
    function Conjugate: TReal; inline;
    function Norm: TReal; inline;
    function Reciprocal: TReal; inline;
    function SameValue(const AValue: TReal): boolean; inline;
    function SquaredNorm: TReal; inline;
    function ToString: string; overload; inline;
    function ToString(APrecision, ADigits: integer): string; overload; inline;
  end;

  EDimensionError = class(EArgumentException);

  generic TVector<T> = record
  private
    FData: array of T;
    function Get(AIndex: longint): T; inline;
    procedure Put(AIndex: longint; const AValue: T); inline;
    procedure RequireSameSize(const AVector: TVector); inline;
    procedure SetSize(ASize: longint);
  public
    procedure Init(const AValues: array of T);
    function Size: longint; inline;
    function Dot(const AVector: TVector): T;
    function IsNull: boolean;
    function IsNotNull: boolean;
    function SameValue(const AVector: TVector): boolean;
    function Norm: TReal;
    function SquaredNorm: TReal;
    function Normalize: TVector;
    function Reciprocal: TVector;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;

    class operator Initialize(var ASelf: TVector);
    class operator Finalize(var ASelf: TVector);
    class operator Copy(constref ASrc: TVector; var ADst: TVector);
    class operator =(const ALeft, ARight: TVector): boolean;
    class operator <>(const ALeft, ARight: TVector): boolean;
    class operator +(const ASelf: TVector): TVector;
    class operator +(const ALeft, ARight: TVector): TVector;
    class operator -(const ASelf: TVector): TVector;
    class operator -(const ALeft, ARight: TVector): TVector;
    class operator *(const ALeft, ARight: TVector): T;
    class operator *(const ALeft: T; const ARight: TVector): TVector;
    class operator *(const ALeft: TVector; const ARight: T): TVector;
    class operator /(const ALeft: TVector; const ARight: T): TVector;

    property A[AIndex: longint]: T read Get write Put; default;
  end;

  TRealVector = specialize TVector<TReal>;
  TComplexVector = specialize TVector<TComplex>;
  TArrayOfRealVector = array of TRealVector;
  TArrayOfComplexVector = array of TComplexVector;

  TRealVectorHelper = type helper for TRealVector
    function Cross(const AVector: TRealVector): TRealVector;
    function ToComplex: TComplexVector;
  end;

  TComplexVectorHelper = type helper for TComplexVector
    function Conjugate: TComplexVector;
  end;

  generic TMatrix<T> = record
  type
    TVectorType = specialize TVector<T>;
    TValues = array of T;
    TPivots = array of longint;
  private
    FData: array of T;
    FOrder: longint;
    function Get(ARow, ACol: longint): T; inline;
    procedure Put(ARow, ACol: longint; const AValue: T); inline;
    procedure RequireSameOrder(const AMatrix: TMatrix); inline;
    procedure SetOrder(AOrder: longint);
    function OneNorm: TReal;
    function FactorizeNonsingular(out APivots: TPivots): TMatrix;
    function Multiply(const AMatrix: TMatrix): TMatrix;
  public
    procedure Init(const AValues: array of T);
    function Order: longint; inline;
    { Solves @code(A*x = AData) by LU factorization with partial pivoting.
      Raises @code(EZeroDivide) when the matrix is singular to working
      precision, that is when the estimated reciprocal condition number in
      the 1-norm is below the unit roundoff (as LAPACK xGESVX): the
      solution would then have no correct digits. }
    function SolveLinear(const AData: TVectorType): TVectorType;
    function Identity: TMatrix;
    function Null: TMatrix;
    function Diagonalize(const ADiagonal: TVectorType): TMatrix;
    function IsNull: boolean;
    function IsNotNull: boolean;
    function SameValue(const AMatrix: TMatrix): boolean;
    function Determinant: T;
    function Norm: TReal;
    function Rank: longint;
    function Trace: T;
    function Clone: TMatrix;
    function Transpose: TMatrix;
    { Inverse matrix from the LU factorization; raises @code(EZeroDivide)
      under the same condition as @link(SolveLinear). }
    function Inverse: TMatrix;
    procedure Swap(ARow1, ARow2: longint);
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;

    class operator Initialize(var ASelf: TMatrix);
    class operator Finalize(var ASelf: TMatrix);
    class operator Copy(constref ASrc: TMatrix; var ADst: TMatrix);
    class operator =(const ALeft, ARight: TMatrix): boolean;
    class operator <>(const ALeft, ARight: TMatrix): boolean;
    class operator +(const ASelf: TMatrix): TMatrix;
    class operator +(const ALeft, ARight: TMatrix): TMatrix;
    class operator -(const ASelf: TMatrix): TMatrix;
    class operator -(const ALeft, ARight: TMatrix): TMatrix;
    class operator *(const ALeft, ARight: TMatrix): TMatrix;
    class operator *(const ALeft: T; const ARight: TMatrix): TMatrix;
    class operator *(const ALeft: TMatrix; const ARight: T): TMatrix;
    class operator *(const ALeft: TVectorType; const ARight: TMatrix): TVectorType;
    class operator *(const ALeft: TMatrix; const ARight: TVectorType): TVectorType;
    class operator /(const ALeft: TMatrix; const ARight: T): TMatrix;

    property A[ARow, ACol: longint]: T read Get write Put; default;
  end;

  TRealMatrix = specialize TMatrix<TReal>;
  TComplexMatrix = specialize TMatrix<TComplex>;

  TRealMatrixHelper = type helper for TRealMatrix
    function IsOrthogonal: boolean;
    function ToComplex: TComplexMatrix;
    procedure Eigenpairs(out AValues: TComplexVector;
      out AVectors: TComplexMatrix);
    procedure SymmetricEigenpairs(out AValues: TRealVector;
      out AVectors: TRealMatrix);
  end;

  TComplexMatrixHelper = type helper for TComplexMatrix
    function Conjugate: TComplexMatrix;
    procedure Eigenpairs(out AValues: TComplexVector;
      out AVectors: TComplexMatrix);
    procedure HermitianEigenpairs(out AValues: TRealVector;
      out AVectors: TComplexMatrix);
    function IsHermitian: boolean;
    function IsUnitary: boolean;
    function TransposeConjugate: TComplexMatrix;
  end;

{ Returns the ACount lowest eigenpairs of a real symmetric tridiagonal matrix.
  The diagonal has N elements and the off-diagonal has N-1 elements. }
procedure TridiagonalLowestEigenpairs(
  const ADiagonal, AOffDiagonal: TRealVector; ACount: longint;
  out AValues: TRealVector; out AVectors: TArrayOfRealVector);

{ Returns the ACount lowest eigenpairs of a complex Hermitian tridiagonal
  matrix. AOffDiagonal contains the lower subdiagonal. }
procedure HermitianTridiagonalLowestEigenpairs(
  const ADiagonal: TRealVector; const AOffDiagonal: TComplexVector;
  ACount: longint; out AValues: TRealVector;
  out AVectors: TArrayOfComplexVector);


{ Constructs a @link(TComplex) from real and imaginary parts. }
function Complex(const ARe, AIm: TReal): TComplex;

{ Returns @true if two real numbers are equal within @link(DefaultEpsilon). }
function SameValueEx(const AValue1, AValue2: TReal): boolean; overload;

{ Returns @true if two complex numbers are equal within @link(DefaultEpsilon). }
function SameValueEx(const AValue1, AValue2: TComplex): boolean; overload;

{ Returns the square of a real number: @code(x²). }
function SquareNorm(const AValue: TReal): TReal;
{ Returns the squared modulus of a complex number: @code(|z|² = Re² + Im²). }
function SquareNorm(const AValue: TComplex): TReal;

{ Returns the absolute value of a real number: @code(|x|). }
function Norm(const AValue: TReal): TReal;
{ Returns the modulus of a complex number: @code(|z| = √(Re² + Im²)). }
function Norm(const AValue: TComplex): TReal;

{ Converts a real number to its default string representation. }
function FloatToStrF(const AValue: TReal): string;

{ Converts a complex number to its default string representation. }
function FloatToStrF(const AValue: TComplex): string;

{ Converts a real number to a string with controlled precision.
  @param(APrecision Number of significant digits.)
  @param(ADigits    Minimum number of digits in the output.)
}
function FloatToStrF(const AValue: TReal; APrecision, ADigits: longint): string;
{ Converts a complex number to a string with controlled precision.
  @param(APrecision Number of significant digits.)
  @param(ADigits    Minimum number of digits in the output.)
}
function FloatToStrF(const AValue: TComplex; APrecision, ADigits: longint): string;

{ Returns @code(z²). }
function SquarePower(const AValue: TComplex): TComplex; overload;

{ Returns @code(z³). }
function CubicPower(const AValue: TComplex): TComplex; overload;

{ Returns @code(z⁴). }
function QuarticPower(const AValue: TComplex): TComplex; overload;

{ Returns @code(z⁵). }
function QuinticPower(const AValue: TComplex): TComplex; overload;

{ Returns @code(z⁶). }
function SexticPower(const AValue: TComplex): TComplex; overload;

{ Returns the two square roots of @code(AValue) as a 2-element array.
  @code(result[0]) is the principal root; @code(result[1] = -result[0]).
}
function SquareRoot(const AValue: TComplex): TArrayOfComplex; overload;

{ Returns the three cube roots of @code(AValue) as a 3-element array,
  at arguments @code(θ/3), @code((θ+2π)/3), and @code((θ+4π)/3).
}
function CubicRoot(const AValue: TComplex): TArrayOfComplex; overload;

{ Returns the four fourth roots of @code(AValue) as a 4-element array,
  at arguments @code(θ/4), @code((θ+2π)/4), @code((θ+4π)/4), and @code((θ+6π)/4).
}
function QuarticRoot(const AValue: TComplex): TArrayOfComplex; overload;

{ @exclude }
function Fmt(const AValue: TReal): string;

{ @exclude }
function Fmt(const AValue: TReal; APrecision, ADigits: longint): string;

const
  { Binary64 spacing between 1 and the next representable value. }
  Precision = 2.2204460492503131E-16;

var
  { The imaginary unit @code(i), defined by @code(i² = -1).
    Use in expressions: @code(z := 3.0 + 2.0*img;)
  }
  img: TImaginaryUnit;

  { Default epsilon for floating point comparisons. }
  DefaultEpsilon: TReal = 1E-12;

implementation

uses
  ADimLapack;

function Fmt(const AValue: TReal): string;
begin
  if AValue < 0.0 then
    result := FloatToStr(AValue)
  else
    result := '+' + FloatToStr(AValue);
end;

function Fmt(const AValue: TReal; APrecision, ADigits: longint): string;
begin
  if AValue < 0.0 then
    result := SysUtils.FloatToStrF(AValue, ffGeneral, APrecision, ADigits)
  else
    result := '+' + SysUtils.FloatToStrF(AValue, ffGeneral, APrecision, ADigits);
end;

function Fmt(const AValue: TComplex): string;
begin
  result := AValue.ToString;
end;

function Fmt(const AValue: TComplex; APrecision, ADigits: longint): string;
begin
  result := AValue.ToString(APrecision, ADigits)
end;

{ Robust complex division (a + ib)/(c + id) = e + if (M. Baudin,
  R. L. Smith, "A Robust Complex Division in Scilab", 2012): Smith's
  formula with the operands prescaled by powers of two, so that no
  intermediate overflows or underflows unless the quotient itself does. }
procedure ComplexDivide(a, b, c, d: TReal; out e, f: TReal);
const
  Overflow = 1.7976931348623157E+308;  { largest finite double }
  Underflow = 2.2250738585072014E-308; { smallest normal double }
  Boost = 8.1129638414606682E+031;     { 2/eps^2 = 2^105 }
var
  LScale, LRatio, LInverse: TReal;
  LSwap: boolean;

  function Component(const AX, AY: TReal): TReal;
  var
    LProduct: TReal;
  begin
    { (AX + AY*r)/(c + d*r) without spurious underflow of AY*r. }
    if LRatio <> 0 then
    begin
      LProduct := AY * LRatio;
      if LProduct <> 0 then
        result := (AX + LProduct) * LInverse
      else
        result := AX * LInverse + (AY * LInverse) * LRatio;
    end else
      result := (AX + d * (AY / c)) * LInverse;
  end;

begin
  if (c = 0) and (d = 0) then
    raise EZeroDivide.Create('TComplex: division by zero.');
  LScale := 1;
  if Max(System.Abs(a), System.Abs(b)) >= Overflow / 2 then
  begin
    a := a / 2;
    b := b / 2;
    LScale := LScale * 2;
  end;
  if Max(System.Abs(c), System.Abs(d)) >= Overflow / 2 then
  begin
    c := c / 2;
    d := d / 2;
    LScale := LScale / 2;
  end;
  if Max(System.Abs(a), System.Abs(b)) <= Underflow * 2 / Precision then
  begin
    a := a * Boost;
    b := b * Boost;
    LScale := LScale / Boost;
  end;
  if Max(System.Abs(c), System.Abs(d)) <= Underflow * 2 / Precision then
  begin
    c := c * Boost;
    d := d * Boost;
    LScale := LScale * Boost;
  end;
  { Divide by the larger component of the divisor: for |d| > |c| the
    quotient is obtained from (b + ia)/(d + ic) = f - ie. }
  LSwap := System.Abs(d) > System.Abs(c);
  if LSwap then
  begin
    LRatio := a; a := b; b := LRatio;
    LRatio := c; c := d; d := LRatio;
  end;
  LRatio := d / c;
  LInverse := 1 / (c + d * LRatio);
  e := Component(a, b) * LScale;
  f := Component(b, -a) * LScale;
  if LSwap then f := -f;
end;

// TComplex

function TComplex.Arg: TReal;
begin
  result := Math.ArcTan2(fIm, fRe);
end;

function TComplex.Conjugate: TComplex;
begin
  result.fRe :=  fRe;
  result.fIm := -fIm;
end;

function TComplex.IsNull: boolean;
begin
  result := SameValueEx(fRe, 0) and SameValueEx(fIm, 0);
end;

function TComplex.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TComplex.Norm: TReal;
begin
  result := hypot(fRe, fIm);
end;

function TComplex.SquaredNorm: TReal;
begin
  result := sqr(fRe) + sqr(fIm);
end;

function TComplex.SameValue(const AValue: TComplex): boolean;
begin
  result := SameValueEx(Self, AValue);
end;

function TComplex.Reciprocal: TComplex;
begin
  ComplexDivide(1, 0, fRe, fIm, result.fRe, result.fIm);
end;

{ A component is printed when it is not negligible relative to the larger
  one, so the output does not depend on the absolute scale of the number. }
function FormatComplex(const AValue: TComplex; AFormat: boolean;
  APrecision, ADigits: integer): string;
const
  Sign: array[boolean] of string = ('+', '-');
var
  LTiny: TReal;
  LShowRe, LShowIm: boolean;

  function Text(const AReal: TReal): string;
  begin
    if AFormat then
      result := SysUtils.FloatToStrF(AReal, ffGeneral, APrecision, ADigits)
    else
      result := FloatToStr(AReal);
  end;

begin
  LTiny := DefaultEpsilon *
    Max(System.Abs(AValue.fRe), System.Abs(AValue.fIm));
  LShowRe := System.Abs(AValue.fRe) > LTiny;
  LShowIm := System.Abs(AValue.fIm) > LTiny;
  if LShowRe and LShowIm then
  begin
    if SameValueEx(System.Abs(AValue.fIm), 1) then
      result := Format('%s %si', [Text(AValue.fRe), Sign[AValue.fIm < 0]])
    else
      result := Format('%s %s%s∙i', [Text(AValue.fRe), Sign[AValue.fIm < 0],
        Text(System.Abs(AValue.fIm))]);
  end else
    if LShowRe then
      result := Text(AValue.fRe)
    else
      if LShowIm then
      begin
        if SameValueEx(AValue.fIm, 1) then result := 'i'
        else if SameValueEx(AValue.fIm, -1) then result := '-i'
        else result := Format('%s∙i', [Text(AValue.fIm)])
      end else
        result := '0';
end;

function TComplex.ToString: string;
begin
  result := FormatComplex(Self, False, 0, 0);
end;

function TComplex.ToString(APrecision, ADigits: integer): string;
begin
  result := FormatComplex(Self, True, APrecision, ADigits);
end;

procedure TComplex.Zero;
begin
  fRe := 0;
  fIm := 0;
end;

class operator TComplex.:=(const AValue: TReal): TComplex;
begin
  result.fRe := AValue;
  result.fIm := 0;
end;

class operator TComplex.=(const ALeft, ARight: TComplex): boolean;
begin
  result := (ALeft.fRe = ARight.fRe) and (ALeft.fIm = ARight.fIm);
end;

class operator TComplex.<>(const ALeft, ARight: TComplex): boolean;
begin
  result := (ALeft.fRe <> ARight.fRe) or (ALeft.fIm <> ARight.fIm);
end;

class operator TComplex.+(const AValue: TComplex): TComplex;
begin
  result.fRe := AValue.fRe;
  result.fIm := AValue.fIm;
end;

class operator TComplex.+(const ALeft, ARight: TComplex): TComplex;
begin
  result.fRe := ALeft.fRe + ARight.fRe;
  result.fIm := ALeft.fIm + ARight.fIm;
end;

class operator TComplex.+(const ALeft: TReal; const ARight: TComplex): TComplex;
begin
  result.fRe := ALeft + ARight.fRe;
  result.fIm :=         ARight.fIm;
end;

class operator TComplex.+(const ALeft: TComplex; const ARight: TReal): TComplex;
begin
  result.fRe := ALeft.fRe + ARight;
  result.fIm := ALeft.fIm;
end;

class operator TComplex.-(const AValue: TComplex): TComplex;
begin
  result.fRe := -AValue.fRe;
  result.fIm := -AValue.fIm;
end;

class operator TComplex.-(const ALeft, ARight: TComplex): TComplex;
begin
  result.fRe := ALeft.fRe - ARight.fRe;
  result.fIm := ALeft.fIm - ARight.fIm;
end;

class operator TComplex.-(const ALeft: TReal; const ARight: TComplex): TComplex;
begin
  result.fRe := ALeft - ARight.fRe;
  result.fIm :=       - ARight.fIm;
end;

class operator TComplex.-(const ALeft: TComplex; const ARight: TReal): TComplex;
begin
  result.fRe := ALeft.fRe - ARight;
  result.fIm := ALeft.fIm;
end;

class operator TComplex.*(const ALeft, ARight: TComplex): TComplex;
begin
  result.fRe := ALeft.fRe * ARight.fRe - ALeft.fIm * ARight.fIm;
  result.fIm := ALeft.fRe * ARight.fIm + ALeft.fIm * ARight.fRe;
end;

class operator TComplex.*(const ALeft: TReal; const ARight: TComplex): TComplex;
begin
  result.fRe := ALeft * ARight.fRe;
  result.fIm := ALeft * ARight.fIm;
end;

class operator TComplex.*(const ALeft: TComplex; const ARight: TReal): TComplex;
begin
  result.fRe := ALeft.fRe * ARight;
  result.fIm := ALeft.fIm * ARight;
end;

class operator TComplex./(const ALeft, ARight: TComplex): TComplex;
begin
  ComplexDivide(ALeft.fRe, ALeft.fIm, ARight.fRe, ARight.fIm,
    result.fRe, result.fIm);
end;

class operator TComplex./(const ALeft: TReal; const ARight: TComplex): TComplex;
begin
  ComplexDivide(ALeft, 0, ARight.fRe, ARight.fIm, result.fRe, result.fIm);
end;

class operator TComplex./(const ALeft: TComplex; const ARight: TReal): TComplex;
begin
  result.fRe := ALeft.fRe / ARight;
  result.fIm := ALeft.fIm / ARight;
end;

// TImaginaryUnit

class operator TImaginaryUnit.:=(const ASelf: TImaginaryUnit): TComplex;
begin
  result.fRe := 0;
  result.fIm := 1;
end;

class operator TImaginaryUnit.*(const ALeft, ARight: TImaginaryUnit): TReal;
begin
  result := -1;
end;

class operator TImaginaryUnit./(const ALeft, ARight: TImaginaryUnit): TReal;
begin
  result := 1;
end;

class operator TImaginaryUnit.-(const AValue: TImaginaryUnit): TComplex;
begin
  result.fRe :=  0;
  result.fIm := -1;
end;

class operator TImaginaryUnit.+(const AValue: TImaginaryUnit): TComplex;
begin
  result.fRe := 0;
  result.fIm := 1;
end;

class operator TImaginaryUnit.+(const ALeft: TReal; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe := ALeft;
  result.fIm := 1;
end;

class operator TImaginaryUnit.+(const ALeft: TImaginaryUnit; const ARight: TReal): TComplex;
begin
  result.fRe := ARight;
  result.fIm := 1;
end;

class operator TImaginaryUnit.-(const ALeft: TReal; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe :=  ALeft;
  result.fIm := -1;
end;

class operator TImaginaryUnit.-(const ALeft: TImaginaryUnit; const ARight: TReal): TComplex;
begin
  result.fRe := -ARight;
  result.fIm :=  1;
end;

class operator TImaginaryUnit.+(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe := ALeft.fRe;
  result.fIm := ALeft.fIm + 1;
end;

class operator TImaginaryUnit.+(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
begin
  result.fRe := ARight.fRe;
  result.fIm := ARight.fIm + 1;
end;

class operator TImaginaryUnit.-(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe := ALeft.fRe;
  result.fIm := ALeft.fIm - 1;
end;

class operator TImaginaryUnit.-(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
begin
  result.fRe :=  -ARight.fRe;
  result.fIm := 1 - ARight.fIm;
end;

class operator TImaginaryUnit.*(const ALeft: TReal; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe := 0;
  result.fIm := ALeft;
end;

class operator TImaginaryUnit.*(const ALeft: TImaginaryUnit; const ARight: TReal): TComplex;
begin
  result.fRe := 0;
  result.fIm := ARight;
end;

class operator TImaginaryUnit.*(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe := -ALeft.fIm;
  result.fIm :=  ALeft.fRe;
end;

class operator TImaginaryUnit.*(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
begin
  result.fRe := -ARight.fIm;
  result.fIm :=  ARight.fRe;
end;

class operator TImaginaryUnit./(const ALeft: TReal; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe :=  0;
  result.fIm := -ALeft;
end;

class operator TImaginaryUnit./(const ALeft: TImaginaryUnit; const ARight: TReal): TComplex;
begin
  result.fRe := 0;
  result.fIm := 1 / ARight;
end;

class operator TImaginaryUnit./(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe :=  ALeft.fIm;
  result.fIm := -ALeft.fRe;
end;

class operator TImaginaryUnit./(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
var
  LReciprocal: TComplex;
begin
  LReciprocal := ARight.Reciprocal;
  result.fRe := -LReciprocal.fIm;
  result.fIm :=  LReciprocal.fRe;
end;

function TRealHelper.Conjugate: TReal;
begin
  result := Self;
end;

function TRealHelper.Norm: TReal;
begin
  result := System.Abs(Self);
end;

function TRealHelper.Reciprocal: TReal;
begin
  result := 1 / Self;
end;

function TRealHelper.SameValue(const AValue: TReal): boolean;
begin
  result := SameValueEx(Self, AValue);
end;

function TRealHelper.SquaredNorm: TReal;
begin
  result := Sqr(Self);
end;

function TRealHelper.ToString: string;
begin
  result := SysUtils.FloatToStr(Self);
end;

function TRealHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := SysUtils.FloatToStrF(Self, ffGeneral, APrecision, ADigits);
end;

function TVector.Get(AIndex: longint): T;
begin
  result := FData[AIndex];
end;

procedure TVector.Put(AIndex: longint; const AValue: T);
begin
  FData[AIndex] := AValue;
end;

procedure TVector.RequireSameSize(const AVector: TVector);
begin
  if Length(FData) <> Length(AVector.FData) then
    raise EDimensionError.CreateFmt(
      'Incompatible vector dimensions: %d and %d.',
      [Length(FData), Length(AVector.FData)]);
end;

procedure TVector.SetSize(ASize: longint);
begin
  if ASize < 0 then
    raise EDimensionError.Create('Vector dimension cannot be negative.');
  SetLength(FData, ASize);
end;

procedure TVector.Init(const AValues: array of T);
var
  LIndex: longint;
begin
  SetSize(Length(AValues));
  for LIndex := 0 to High(AValues) do
    FData[LIndex] := AValues[LIndex];
end;

function TVector.Size: longint;
begin
  result := Length(FData);
end;

function TRealVectorHelper.Cross(
  const AVector: TRealVector): TRealVector;
begin
  Self.RequireSameSize(AVector);
  if Self.Size <> 3 then
    raise EDimensionError.CreateFmt(
      'Cross product requires dimension 3, received %d.', [Self.Size]);
  result.SetSize(3);
  result.FData[0] := Self.FData[1] * AVector.FData[2] -
    Self.FData[2] * AVector.FData[1];
  result.FData[1] := Self.FData[2] * AVector.FData[0] -
    Self.FData[0] * AVector.FData[2];
  result.FData[2] := Self.FData[0] * AVector.FData[1] -
    Self.FData[1] * AVector.FData[0];
end;

{ DDOT or ZDOTU of the reference BLAS. }
function TVector.Dot(const AVector: TVector): T;
begin
  RequireSameSize(AVector);
  if Size = 0 then
    raise EDimensionError.Create('Dot product is undefined for empty vectors.');
  result := XDOT(Size, FData, 0, 1, AVector.FData, 0, 1);
end;

function TVector.IsNull: boolean;
var
  LIndex: longint;
begin
  for LIndex := 0 to Size - 1 do
    if not FData[LIndex].SameValue(0) then Exit(False);
  result := True;
end;

function TVector.IsNotNull: boolean;
begin
  result := not IsNull;
end;

{ DNRM2 or DZNRM2 of the reference BLAS (Blue's scaled sums). }
function TVector.Norm: TReal;
begin
  result := XNRM2(Size, FData, 0, 1);
end;

function TVector.SquaredNorm: TReal;
var
  LIndex: longint;
begin
  result := 0;
  for LIndex := 0 to Size - 1 do
    result := result + FData[LIndex].SquaredNorm;
end;

function TVector.Normalize: TVector;
var
  LIndex: longint;
  LNorm: TReal;
begin
  LNorm := Norm;
  if LNorm = 0 then
    raise EZeroDivide.Create('Cannot normalize a null vector.');
  result.SetSize(Size);
  for LIndex := 0 to Size - 1 do
    result.FData[LIndex] := FData[LIndex] / LNorm;
end;

function TVector.Reciprocal: TVector;
var
  LIndex: longint;
  LNorm: TReal;
begin
  LNorm := Norm;
  if LNorm = 0 then
    raise EZeroDivide.Create('Cannot invert a null vector.');
  result.SetSize(Size);
  for LIndex := 0 to Size - 1 do
    result.FData[LIndex] := (FData[LIndex] / LNorm) / LNorm;
end;

function TComplexVectorHelper.Conjugate: TComplexVector;
var
  LIndex: longint;
begin
  result.SetSize(Self.Size);
  for LIndex := 0 to Self.Size - 1 do
    result.FData[LIndex] := Self.FData[LIndex].Conjugate;
end;

function TVector.SameValue(const AVector: TVector): boolean;
var
  LIndex: longint;
begin
  if Size <> AVector.Size then Exit(False);
  for LIndex := 0 to Size - 1 do
    if not FData[LIndex].SameValue(AVector.FData[LIndex]) then
      Exit(False);
  result := True;
end;

function TVector.ToString: string;
var
  LIndex: longint;
begin
  result := '(';
  for LIndex := 0 to Size - 1 do
  begin
    if LIndex > 0 then result := result + ',';
    result := result + FData[LIndex].ToString;
  end;
  result := result + ')';
end;

function TVector.ToString(APrecision, ADigits: integer): string;
var
  LIndex: longint;
begin
  result := '(';
  for LIndex := 0 to Size - 1 do
  begin
    if LIndex > 0 then result := result + ',';
    result := result + FData[LIndex].ToString(APrecision, ADigits);
  end;
  result := result + ')';
end;

class operator TVector.Initialize(var ASelf: TVector);
begin
  ASelf.FData := nil;
end;

class operator TVector.Finalize(var ASelf: TVector);
begin
  ASelf.FData := nil;
end;

class operator TVector.Copy(constref ASrc: TVector; var ADst: TVector);
begin
  if @ASrc = @ADst then Exit;
  ADst.FData := System.Copy(ASrc.FData);
end;

class operator TVector.=(const ALeft, ARight: TVector): boolean;
var
  LIndex: longint;
begin
  if ALeft.Size <> ARight.Size then Exit(False);
  for LIndex := 0 to ALeft.Size - 1 do
    if ALeft.FData[LIndex] <> ARight.FData[LIndex] then Exit(False);
  result := True;
end;

class operator TVector.<>(const ALeft, ARight: TVector): boolean;
begin
  result := not (ALeft = ARight);
end;

class operator TVector.+(const ASelf: TVector): TVector;
begin
  result := ASelf;
end;

class operator TVector.+(const ALeft, ARight: TVector): TVector;
var
  LIndex: longint;
begin
  ALeft.RequireSameSize(ARight);
  result.SetSize(ALeft.Size);
  for LIndex := 0 to ALeft.Size - 1 do
    result.FData[LIndex] := ALeft.FData[LIndex] + ARight.FData[LIndex];
end;

class operator TVector.-(const ASelf: TVector): TVector;
var
  LIndex: longint;
begin
  result.SetSize(ASelf.Size);
  for LIndex := 0 to ASelf.Size - 1 do
    result.FData[LIndex] := -ASelf.FData[LIndex];
end;

class operator TVector.-(const ALeft, ARight: TVector): TVector;
var
  LIndex: longint;
begin
  ALeft.RequireSameSize(ARight);
  result.SetSize(ALeft.Size);
  for LIndex := 0 to ALeft.Size - 1 do
    result.FData[LIndex] := ALeft.FData[LIndex] - ARight.FData[LIndex];
end;

class operator TVector.*(const ALeft, ARight: TVector): T;
begin
  result := ALeft.Dot(ARight);
end;

class operator TVector.*(const ALeft: T; const ARight: TVector): TVector;
var
  LIndex: longint;
begin
  result.SetSize(ARight.Size);
  for LIndex := 0 to ARight.Size - 1 do
    result.FData[LIndex] := ALeft * ARight.FData[LIndex];
end;

class operator TVector.*(const ALeft: TVector; const ARight: T): TVector;
begin
  result := ARight * ALeft;
end;

class operator TVector./(const ALeft: TVector; const ARight: T): TVector;
var
  LIndex: longint;
begin
  result.SetSize(ALeft.Size);
  for LIndex := 0 to ALeft.Size - 1 do
    result.FData[LIndex] := ALeft.FData[LIndex] / ARight;
end;

function TRealVectorHelper.ToComplex: TComplexVector;
var
  LIndex: longint;
begin
  result.SetSize(Self.Size);
  for LIndex := 0 to Self.Size - 1 do
    result.FData[LIndex] := Self.FData[LIndex];
end;

// TMatrix<T>

function TMatrix.Get(ARow, ACol: longint): T;
begin
  result := FData[ARow * FOrder + ACol];
end;

procedure TMatrix.Put(ARow, ACol: longint; const AValue: T);
begin
  FData[ARow * FOrder + ACol] := AValue;
end;

procedure TMatrix.RequireSameOrder(const AMatrix: TMatrix);
begin
  if FOrder <> AMatrix.FOrder then
    raise EDimensionError.CreateFmt(
      'Incompatible matrix orders: %d and %d.', [FOrder, AMatrix.FOrder]);
end;

procedure TMatrix.SetOrder(AOrder: longint);
var
  LCount: int64;
begin
  if AOrder < 0 then
    raise EDimensionError.Create('Matrix order cannot be negative.');
  LCount := int64(AOrder) * AOrder;
  if LCount > MaxLongint then
    raise EDimensionError.Create('Matrix order exceeds addressable storage.');
  FOrder := AOrder;
  FData := nil;
  SetLength(FData, longint(LCount));
end;

procedure TMatrix.Init(const AValues: array of T);
var
  LIndex, LOrder: longint;
begin
  LOrder := Trunc(Sqrt(Length(AValues)));
  if LOrder * LOrder <> Length(AValues) then
    raise EDimensionError.CreateFmt(
      'A square matrix cannot be initialized with %d values.',
      [Length(AValues)]);
  SetOrder(LOrder);
  for LIndex := 0 to High(AValues) do
    FData[LIndex] := AValues[LIndex];
end;

function TMatrix.Order: longint;
begin
  result := FOrder;
end;

{ Maximum absolute column sum (xLANGE). }
function TMatrix.OneNorm: TReal;
begin
  result := XLANGE('1', FOrder, FOrder, FData, 0, FOrder);
end;

{ LU factors (xGETRF) of a matrix that is nonsingular to working
  precision: raises EZeroDivide when a pivot is exactly zero or when the
  reciprocal condition number estimated by xGECON is below the unit
  roundoff 2^-53, as for INFO = N+1 in LAPACK xGESVX. }
function TMatrix.FactorizeNonsingular(out APivots: TPivots): TMatrix;
const
  UnitRoundoff = Precision / 2;
var
  LInfo: longint;
  LRcond: TReal;
begin
  result := Clone;
  APivots := nil;
  SetLength(APivots, FOrder);
  XGETRF(FOrder, result.FData, APivots, LInfo);
  if LInfo > 0 then
    raise EZeroDivide.Create('Matrix is singular.');
  XGECON(FOrder, result.FData, OneNorm, LRcond, LInfo);
  if LRcond < UnitRoundoff then
    raise EZeroDivide.Create('Matrix is singular to working precision.');
end;

function TMatrix.SolveLinear(const AData: TVectorType): TVectorType;
var
  LFactors: TMatrix;
  LPivots: TPivots;
  LData: TValues;
  LIndex: longint;
begin
  if AData.Size <> FOrder then
    raise EDimensionError.CreateFmt(
      'Matrix order %d and vector dimension %d are incompatible.',
      [FOrder, AData.Size]);
  LFactors := FactorizeNonsingular(LPivots);
  SetLength(LData, FOrder);
  for LIndex := 0 to FOrder - 1 do LData[LIndex] := AData[LIndex];
  XGETRS('N', FOrder, 1, LFactors.FData, LPivots, LData);
  result.SetSize(FOrder);
  for LIndex := 0 to FOrder - 1 do result[LIndex] := LData[LIndex];
end;

function TMatrix.Identity: TMatrix;
var
  LIndex: longint;
begin
  result.SetOrder(FOrder);
  for LIndex := 0 to FOrder - 1 do result[LIndex, LIndex] := 1;
end;

function TMatrix.Null: TMatrix;
begin
  result.SetOrder(FOrder);
end;

function TMatrix.Diagonalize(const ADiagonal: TVectorType): TMatrix;
var
  LIndex: longint;
begin
  if ADiagonal.Size <> FOrder then
    raise EDimensionError.CreateFmt(
      'Matrix order %d and diagonal dimension %d are incompatible.',
      [FOrder, ADiagonal.Size]);
  result.SetOrder(FOrder);
  for LIndex := 0 to FOrder - 1 do
    result[LIndex, LIndex] := ADiagonal[LIndex];
end;

function TMatrix.IsNull: boolean;
var
  LIndex: longint;
begin
  for LIndex := 0 to High(FData) do
    if not FData[LIndex].SameValue(0) then Exit(False);
  result := True;
end;

function TMatrix.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TMatrix.SameValue(const AMatrix: TMatrix): boolean;
var
  LIndex: longint;
begin
  if FOrder <> AMatrix.FOrder then Exit(False);
  for LIndex := 0 to High(FData) do
    if not FData[LIndex].SameValue(AMatrix.FData[LIndex]) then
      Exit(False);
  result := True;
end;

function TMatrix.Determinant: T;
var
  LUpper: TMatrix;
  LPivots: TPivots;
  LInfo, LSwapCount, LIndex: longint;
begin
  if FOrder = 0 then
    raise EDimensionError.Create('Determinant is undefined for an empty matrix.');
  LUpper := Clone;
  SetLength(LPivots, FOrder);
  XGETRF(FOrder, LUpper.FData, LPivots, LInfo);
  result := LUpper[0, 0];
  LSwapCount := 0;
  for LIndex := 1 to FOrder - 1 do
    result := result * LUpper[LIndex, LIndex];
  for LIndex := 0 to FOrder - 1 do
    if LPivots[LIndex] <> LIndex then Inc(LSwapCount);
  if Odd(LSwapCount) then result := -result;
end;

{ Frobenius norm (xLANGE). }
function TMatrix.Norm: TReal;
begin
  result := XLANGE('F', FOrder, FOrder, FData, 0, FOrder);
end;

{ Number of singular values (xGESVD) above S_max * n * eps, the default
  tolerance of numpy.linalg.matrix_rank. }
function TMatrix.Rank: longint;
var
  LWork: array of T;
  LSigma: array of TReal;
  LTolerance: TReal;
  LIndex, LInfo: longint;
begin
  result := 0;
  if FOrder = 0 then Exit;
  LWork := Copy(FData);
  LSigma := nil;
  SetLength(LSigma, FOrder);
  XGESVD(FOrder, LWork, LSigma, LInfo);
  if LInfo <> 0 then
    raise EInvalidOp.Create('xGESVD: bidiagonal QR iteration did not converge.');
  LTolerance := LSigma[0] * FOrder * Precision;
  for LIndex := 0 to FOrder - 1 do
    if LSigma[LIndex] > LTolerance then Inc(result);
end;

function TMatrix.Trace: T;
var
  LIndex: longint;
begin
  if FOrder = 0 then
    raise EDimensionError.Create('Trace is undefined for an empty matrix.');
  result := Self[0, 0];
  for LIndex := 1 to FOrder - 1 do
    result := result + Self[LIndex, LIndex];
end;

function TMatrix.Clone: TMatrix;
begin
  result.FOrder := FOrder;
  result.FData := System.Copy(FData);
end;

function TMatrix.Transpose: TMatrix;
var
  LRow, LCol: longint;
begin
  result.SetOrder(FOrder);
  for LRow := 0 to FOrder - 1 do
    for LCol := 0 to FOrder - 1 do
      result[LCol, LRow] := Self[LRow, LCol];
end;

function TMatrix.Inverse: TMatrix;
var
  LPivots: TPivots;
  LInfo: longint;
begin
  result := FactorizeNonsingular(LPivots);
  XGETRI(FOrder, result.FData, LPivots, LInfo);
end;

function TComplexMatrixHelper.Conjugate: TComplexMatrix;
var
  LIndex: longint;
begin
  result.SetOrder(Self.FOrder);
  for LIndex := 0 to High(Self.FData) do
    result.FData[LIndex] := Self.FData[LIndex].Conjugate;
end;

function TComplexMatrixHelper.TransposeConjugate: TComplexMatrix;
begin
  result := Self.Conjugate.Transpose;
end;

function TComplexMatrixHelper.IsHermitian: boolean;
var
  LRow, LColumn: longint;
begin
  for LRow := 0 to Self.FOrder - 1 do
    for LColumn := LRow to Self.FOrder - 1 do
      if not Self[LRow, LColumn].SameValue(Self[LColumn, LRow].Conjugate) then
        Exit(False);
  result := True;
end;

function TComplexMatrixHelper.IsUnitary: boolean;
var
  LAdjoint, LProduct, LIdentity: TComplexMatrix;
begin
  LAdjoint := Self.TransposeConjugate;
  LProduct := LAdjoint * Self;
  LIdentity := Self.Identity;
  result := LProduct.SameValue(LIdentity);
end;

procedure TMatrix.Swap(ARow1, ARow2: longint);
var
  LColumn: longint;
  LValue: T;
begin
  for LColumn := 0 to FOrder - 1 do
  begin
    LValue := Self[ARow1, LColumn];
    Self[ARow1, LColumn] := Self[ARow2, LColumn];
    Self[ARow2, LColumn] := LValue;
  end;
end;

function TMatrix.ToString: string;
var
  LRow, LCol: longint;
begin
  result := '(';
  for LRow := 0 to FOrder - 1 do
  begin
    if LRow > 0 then result := result + ', ';
    result := result + '(';
    for LCol := 0 to FOrder - 1 do
    begin
      if LCol > 0 then result := result + ', ';
      result := result + Self[LRow, LCol].ToString;
    end;
    result := result + ')';
  end;
  result := result + ')';
end;

function TMatrix.ToString(APrecision, ADigits: integer): string;
var
  LRow, LCol: longint;
begin
  result := '(';
  for LRow := 0 to FOrder - 1 do
  begin
    if LRow > 0 then result := result + ', ';
    result := result + '(';
    for LCol := 0 to FOrder - 1 do
    begin
      if LCol > 0 then result := result + ', ';
      result := result + Self[LRow, LCol].ToString(APrecision, ADigits);
    end;
    result := result + ')';
  end;
  result := result + ')';
end;

class operator TMatrix.Initialize(var ASelf: TMatrix);
begin
  ASelf.FOrder := 0;
  ASelf.FData := nil;
end;

class operator TMatrix.Finalize(var ASelf: TMatrix);
begin
  ASelf.FOrder := 0;
  ASelf.FData := nil;
end;

class operator TMatrix.Copy(constref ASrc: TMatrix; var ADst: TMatrix);
begin
  if @ASrc = @ADst then Exit;
  ADst.FOrder := ASrc.FOrder;
  ADst.FData := System.Copy(ASrc.FData);
end;

class operator TMatrix.=(const ALeft, ARight: TMatrix): boolean;
var
  LIndex: longint;
begin
  if ALeft.FOrder <> ARight.FOrder then Exit(False);
  for LIndex := 0 to High(ALeft.FData) do
    if ALeft.FData[LIndex] <> ARight.FData[LIndex] then Exit(False);
  result := True;
end;

class operator TMatrix.<>(const ALeft, ARight: TMatrix): boolean;
begin
  result := not (ALeft = ARight);
end;

class operator TMatrix.+(const ASelf: TMatrix): TMatrix;
begin
  result := ASelf;
end;

class operator TMatrix.-(const ASelf: TMatrix): TMatrix;
var
  LIndex: longint;
begin
  result.SetOrder(ASelf.FOrder);
  for LIndex := 0 to High(ASelf.FData) do
    result.FData[LIndex] := -ASelf.FData[LIndex];
end;

class operator TMatrix.+(const ALeft, ARight: TMatrix): TMatrix;
var
  LIndex: longint;
begin
  ALeft.RequireSameOrder(ARight);
  result.SetOrder(ALeft.FOrder);
  for LIndex := 0 to High(ALeft.FData) do
    result.FData[LIndex] := ALeft.FData[LIndex] + ARight.FData[LIndex];
end;

class operator TMatrix.-(const ALeft, ARight: TMatrix): TMatrix;
var
  LIndex: longint;
begin
  ALeft.RequireSameOrder(ARight);
  result.SetOrder(ALeft.FOrder);
  for LIndex := 0 to High(ALeft.FData) do
    result.FData[LIndex] := ALeft.FData[LIndex] - ARight.FData[LIndex];
end;

{ DGEMM or ZGEMM of the reference BLAS. }
function TMatrix.Multiply(const AMatrix: TMatrix): TMatrix;
begin
  RequireSameOrder(AMatrix);
  result.SetOrder(FOrder);
  XGEMM('N', 'N', FOrder, FOrder, FOrder, FData, 0, FOrder, AMatrix.FData, 0,
    FOrder, result.FData, 0, FOrder);
end;

class operator TMatrix.*(const ALeft, ARight: TMatrix): TMatrix;
begin
  result := ALeft.Multiply(ARight);
end;

class operator TMatrix.*(const ALeft: T; const ARight: TMatrix): TMatrix;
var
  LIndex: longint;
begin
  result.SetOrder(ARight.FOrder);
  for LIndex := 0 to High(ARight.FData) do
    result.FData[LIndex] := ALeft * ARight.FData[LIndex];
end;

class operator TMatrix.*(const ALeft: TMatrix; const ARight: T): TMatrix;
begin
  result := ARight * ALeft;
end;

{ x^T*A by DGEMV or ZGEMV of the reference BLAS (TRANS = 'T'). }
class operator TMatrix.*(const ALeft: TVectorType;
  const ARight: TMatrix): TVectorType;
begin
  if ALeft.Size <> ARight.FOrder then
    raise EDimensionError.CreateFmt(
      'Vector dimension %d and matrix order %d are incompatible.',
      [ALeft.Size, ARight.FOrder]);
  result.SetSize(ARight.FOrder);
  XGEMV('T', ARight.FOrder, ARight.FOrder, ARight.FData, 0, ARight.FOrder,
    ALeft.FData, 0, 1, result.FData, 0, 1);
end;

{ A*x by DGEMV or ZGEMV of the reference BLAS. }
class operator TMatrix.*(const ALeft: TMatrix;
  const ARight: TVectorType): TVectorType;
begin
  if ALeft.FOrder <> ARight.Size then
    raise EDimensionError.CreateFmt(
      'Matrix order %d and vector dimension %d are incompatible.',
      [ALeft.FOrder, ARight.Size]);
  result.SetSize(ALeft.FOrder);
  XGEMV('N', ALeft.FOrder, ALeft.FOrder, ALeft.FData, 0, ALeft.FOrder,
    ARight.FData, 0, 1, result.FData, 0, 1);
end;

class operator TMatrix./(const ALeft: TMatrix; const ARight: T): TMatrix;
var
  LIndex: longint;
begin
  result.SetOrder(ALeft.FOrder);
  for LIndex := 0 to High(ALeft.FData) do
    result.FData[LIndex] := ALeft.FData[LIndex] / ARight;
end;

{ DSTEVX with RANGE = 'I' (eigenvalues 1 to ACount) and the absolute
  tolerance 2*safe minimum that LAPACK recommends for the highest
  accuracy: bisection (DSTEBZ) and inverse iteration (DSTEIN). }
procedure TridiagonalLowestEigenpairs(
  const ADiagonal, AOffDiagonal: TRealVector; ACount: longint;
  out AValues: TRealVector; out AVectors: TArrayOfRealVector);
const
  ABSTOL: TReal = 2 * 2.2250738585072014E-308;
var
  D, E, W, Z, Column: TArrayOfReal;
  IFAIL: array of longint;
  N, I, J, M, LInfo: longint;
begin
  N := ADiagonal.Size;
  if (N = 0) or (AOffDiagonal.Size <> N - 1) or
     (ACount < 1) or (ACount > N) then
    raise EDimensionError.Create(
      'Require N diagonal, N-1 off-diagonal, and 1..N eigenpairs.');
  SetLength(D, N);
  SetLength(E, N - 1);
  for I := 0 to N - 1 do
  begin
    D[I] := ADiagonal[I];
    if IsNan(D[I]) or IsInfinite(D[I]) then
      raise EInvalidOp.Create('Tridiagonal entries must be finite.');
    if I < N - 1 then
    begin
      E[I] := AOffDiagonal[I];
      if IsNan(E[I]) or IsInfinite(E[I]) then
        raise EInvalidOp.Create('Tridiagonal entries must be finite.');
    end;
  end;
  SetLength(W, N);
  SetLength(Z, N * ACount);
  SetLength(IFAIL, N);
  DSTEVX('I', N, D, E, 0, 0, 1, ACount, ABSTOL, M, W, Z, 0, ACount, IFAIL,
    LInfo);
  if (LInfo <> 0) or (M <> ACount) then
    raise EInvalidOp.Create('DSTEVX: inverse iteration did not converge.');
  SetLength(W, ACount);
  AValues.Init(W);
  SetLength(AVectors, ACount);
  SetLength(Column, N);
  for J := 0 to ACount - 1 do
  begin
    for I := 0 to N - 1 do Column[I] := Z[I * ACount + J];
    AVectors[J].Init(Column);
  end;
end;

{ A diagonal unitary change of basis removes the off-diagonal phases. }
procedure HermitianTridiagonalLowestEigenpairs(
  const ADiagonal: TRealVector; const AOffDiagonal: TComplexVector;
  ACount: longint; out AValues: TRealVector;
  out AVectors: TArrayOfComplexVector);
var
  OffMagnitudes: TRealVector;
  RealVectors: TArrayOfRealVector;
  Phase: TArrayOfComplex;
  Magnitudes: TArrayOfReal;
  ComplexData: TArrayOfComplex;
  Magnitude: TReal;
  I, J, N: longint;
begin
  N := ADiagonal.Size;
  if (N = 0) or (AOffDiagonal.Size <> N - 1) then
    raise EDimensionError.Create(
      'A Hermitian tridiagonal matrix needs N diagonal and N-1 lower values.');
  SetLength(Phase, N);
  SetLength(Magnitudes, N - 1);
  Phase[0] := 1;
  for I := 0 to N - 2 do
  begin
    Magnitude := AOffDiagonal[I].Norm;
    Magnitudes[I] := Magnitude;
    if Magnitude = 0 then
      Phase[I + 1] := Phase[I]
    else
      Phase[I + 1] := Phase[I] * (AOffDiagonal[I] / Magnitude);
  end;
  OffMagnitudes.Init(Magnitudes);
  TridiagonalLowestEigenpairs(ADiagonal, OffMagnitudes, ACount,
    AValues, RealVectors);
  SetLength(AVectors, ACount);
  SetLength(ComplexData, N);
  for J := 0 to ACount - 1 do
  begin
    for I := 0 to N - 1 do
      ComplexData[I] := Phase[I] * RealVectors[J][I];
    AVectors[J].Init(ComplexData);
  end;
end;

function TRealMatrixHelper.IsOrthogonal: boolean;
var
  LProduct: TRealMatrix;
begin
  LProduct := Self.Transpose * Self;
  result := LProduct.SameValue(Self.Identity);
end;

function TRealMatrixHelper.ToComplex: TComplexMatrix;
var
  LIndex: longint;
begin
  result.SetOrder(Self.FOrder);
  for LIndex := 0 to High(Self.FData) do
    result.FData[LIndex] := Self.FData[LIndex];
end;

{ Unit 2-norm columns whose largest component is real and positive. For
  the eigenvectors of a real matrix, AImaginary holds the imaginary parts
  of the eigenvalues: the column of an eigenvalue with positive imaginary
  part is normalized and the next one, its conjugate pair, is set to its
  conjugate, so that the pairs stay exactly conjugate. }
procedure NormalizeEigenvectors(var AVectors: TComplexMatrix;
  const AImaginary: TArrayOfReal);
var
  N, Row, Col, Largest: longint;
  VectorNorm, Modulus, LargestModulus: TReal;
  Phase: TComplex;
begin
  N := AVectors.Order;
  Col := 0;
  while Col < N do
  begin
    VectorNorm := 0;
    LargestModulus := 0;
    Largest := 0;
    for Row := 0 to N - 1 do
    begin
      Modulus := AVectors[Row, Col].Norm;
      VectorNorm := Hypot(VectorNorm, Modulus);
      if Modulus > LargestModulus then
      begin
        LargestModulus := Modulus;
        Largest := Row;
      end;
    end;
    if VectorNorm > 0 then
    begin
      Phase := AVectors[Largest, Col].Conjugate / (LargestModulus * VectorNorm);
      for Row := 0 to N - 1 do
        AVectors[Row, Col] := Phase * AVectors[Row, Col];
      AVectors[Largest, Col] := AVectors[Largest, Col].Re;
    end;
    if (AImaginary <> nil) and (AImaginary[Col] > 0) then
    begin
      for Row := 0 to N - 1 do
        AVectors[Row, Col + 1] := AVectors[Row, Col].Conjugate;
      Inc(Col, 2);
    end else
      Inc(Col);
  end;
end;

{ Eigenvalues and eigenvectors by DGEEV (internal LAPACK layer), with the
  eigenvectors normalized as for complex input. Real arithmetic keeps the
  structure of the result exact: real eigenvalues have real eigenvectors,
  complex eigenvalues come in exactly conjugate pairs with conjugate
  eigenvectors. Diagonal input is returned directly and symmetric input
  uses SymmetricEigenpairs. }
procedure TRealMatrixHelper.Eigenpairs(out AValues: TComplexVector;
  out AVectors: TComplexMatrix);
var
  N, I, J: longint;
  A, WR, WI, VR: TArrayOfReal;
  SymmetricValues: TRealVector;
  SymmetricVectors: TRealMatrix;
  Scale, Tolerance: TReal;
  IsSymmetric, IsDiagonal: boolean;
begin
  N := Self.FOrder;
  AValues.SetSize(N);
  AVectors.SetOrder(N);
  if N = 0 then Exit;

  Scale := 0;
  for I := 0 to High(Self.FData) do
  begin
    if IsNan(Self.FData[I]) or IsInfinite(Self.FData[I]) then
      raise EInvalidOp.Create('Matrix entries must be finite.');
    Scale := Max(Scale, System.Abs(Self.FData[I]));
  end;
  IsDiagonal := True;
  IsSymmetric := True;
  Tolerance := 32 * Precision * Scale;
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
      if J <> I then
      begin
        if Self.FData[I * N + J] <> 0 then IsDiagonal := False;
        if System.Abs(Self.FData[I * N + J] - Self.FData[J * N + I]) >
           Tolerance then IsSymmetric := False;
      end;
  if IsDiagonal then
  begin
    for I := 0 to N - 1 do
    begin
      AValues[I] := Self.FData[I * N + I];
      AVectors[I, I] := 1;
    end;
    Exit;
  end;

  if IsSymmetric then
  begin
    Self.SymmetricEigenpairs(SymmetricValues, SymmetricVectors);
    for I := 0 to N - 1 do
    begin
      AValues[I] := SymmetricValues[I];
      for J := 0 to N - 1 do AVectors[I, J] := SymmetricVectors[I, J];
    end;
    NormalizeEigenvectors(AVectors, nil);
    Exit;
  end;

  A := System.Copy(Self.FData);
  DGEEV(N, A, WR, WI, VR);
  { DGEEV stores a complex pair as the real and imaginary parts of the
    eigenvector of the eigenvalue with positive imaginary part. }
  J := 0;
  while J < N do
    if WI[J] = 0 then
    begin
      AValues[J] := WR[J];
      for I := 0 to N - 1 do AVectors[I, J] := VR[I * N + J];
      Inc(J);
    end else
    begin
      AValues[J] := Complex(WR[J], WI[J]);
      AValues[J + 1] := AValues[J].Conjugate;
      for I := 0 to N - 1 do
        AVectors[I, J] := Complex(VR[I * N + J], VR[I * N + J + 1]);
      Inc(J, 2);
    end;
  NormalizeEigenvectors(AVectors, WI);
end;

{ DSYEV on the lower triangle (as numpy.linalg.eigh): eigenvalues in
  ascending order, orthonormal eigenvectors in the columns. }
procedure TRealMatrixHelper.SymmetricEigenpairs(out AValues: TRealVector;
  out AVectors: TRealMatrix);
var
  W: TArrayOfReal;
  Scale, Tolerance: TReal;
  N, I, J, LInfo: longint;
begin
  N := Self.Order;
  if N = 0 then
    raise EDimensionError.Create('Eigenpairs are undefined for an empty matrix.');
  Scale := 0;
  for I := 0 to N * N - 1 do
  begin
    if IsNan(Self.FData[I]) or IsInfinite(Self.FData[I]) then
      raise EInvalidOp.Create('Matrix entries must be finite.');
    Scale := Max(Scale, System.Abs(Self.FData[I]));
  end;
  Tolerance := 32 * Precision * Scale;
  for I := 0 to N - 1 do
    for J := I + 1 to N - 1 do
      if System.Abs(Self.FData[I * N + J] - Self.FData[J * N + I]) > Tolerance then
        raise EInvalidOp.Create('Matrix must be real symmetric.');
  AVectors := Self.Clone;
  SetLength(W, N);
  XSYEV('L', N, AVectors.FData, W, LInfo);
  if LInfo > 0 then
    raise EInvalidOp.Create('DSYEV: QL iteration did not converge.');
  AValues.Init(W);
end;

{ Eigenvalues and eigenvectors by ZGEEV (internal LAPACK layer).
  Diagonal input is returned directly and Hermitian input uses
  HermitianEigenpairs, which returns orthonormal eigenvectors. }
procedure TComplexMatrixHelper.Eigenpairs(out AValues: TComplexVector;
  out AVectors: TComplexMatrix);
var
  N, I, J: longint;
  A, W, VR: TArrayOfComplex;
  HermitianValues: TRealVector;
  Scale, Tolerance: TReal;
  HermitianInput, IsDiagonal: boolean;
begin
  N := Self.FOrder;
  AValues.SetSize(N);
  AVectors.SetOrder(N);
  if N = 0 then Exit;

  Scale := 0;
  for I := 0 to High(Self.FData) do
  begin
    if IsNan(Self.FData[I].fRe) or IsInfinite(Self.FData[I].fRe) or
       IsNan(Self.FData[I].fIm) or IsInfinite(Self.FData[I].fIm) then
      raise EInvalidOp.Create('Matrix entries must be finite.');
    Scale := Max(Scale, Self.FData[I].Norm);
  end;
  IsDiagonal := True;
  HermitianInput := True;
  Tolerance := 32 * Precision * Scale;
  for I := 0 to N - 1 do
  begin
    if System.Abs(Self.FData[I * N + I].fIm) > Tolerance then
      HermitianInput := False;
    for J := 0 to N - 1 do
      if J <> I then
      begin
        if Self.FData[I * N + J].Norm <> 0 then IsDiagonal := False;
        if (Self.FData[I * N + J] - Self.FData[J * N + I].Conjugate).Norm >
           Tolerance then HermitianInput := False;
      end;
  end;
  if IsDiagonal then
  begin
    for I := 0 to N - 1 do
    begin
      AValues[I] := Self.FData[I * N + I];
      AVectors[I, I] := 1;
    end;
    Exit;
  end;

  if HermitianInput then
  begin
    Self.HermitianEigenpairs(HermitianValues, AVectors);
    for I := 0 to N - 1 do AValues[I] := HermitianValues[I];
  end else
  begin
    A := System.Copy(Self.FData);
    ZGEEV(N, A, W, VR);
    for I := 0 to N - 1 do AValues[I] := W[I];
    AVectors.FData := VR;
  end;
  NormalizeEigenvectors(AVectors, nil);
end;

{ ZHEEV on the lower triangle (as numpy.linalg.eigh). }
procedure TComplexMatrixHelper.HermitianEigenpairs(out AValues: TRealVector;
  out AVectors: TComplexMatrix);
var
  W: TArrayOfReal;
  Scale, Tolerance: TReal;
  N, I, J, LInfo: longint;
begin
  N := Self.Order;
  if N = 0 then
    raise EDimensionError.Create('Eigenpairs are undefined for an empty matrix.');
  Scale := 0;
  for I := 0 to N * N - 1 do
  begin
    if IsNan(Self.FData[I].Re) or IsInfinite(Self.FData[I].Re) or
       IsNan(Self.FData[I].Im) or IsInfinite(Self.FData[I].Im) then
      raise EInvalidOp.Create('Matrix entries must be finite.');
    Scale := Max(Scale, Self.FData[I].Norm);
  end;
  Tolerance := 32 * Precision * Scale;
  for I := 0 to N - 1 do
  begin
    if System.Abs(Self.FData[I * N + I].Im) > Tolerance then
      raise EInvalidOp.Create('Matrix must be Hermitian.');
    for J := I + 1 to N - 1 do
      if (Self.FData[I * N + J] - Self.FData[J * N + I].Conjugate).Norm >
         Tolerance then
        raise EInvalidOp.Create('Matrix must be Hermitian.');
  end;
  AVectors := Self.Clone;
  SetLength(W, N);
  XSYEV('L', N, AVectors.FData, W, LInfo);
  if LInfo > 0 then
    raise EInvalidOp.Create('ZHEEV: QL iteration did not converge.');
  AValues.Init(W);
end;


function Complex(const ARe, AIm: TReal): TComplex;
begin
  result.Re := ARe;
  result.Im := AIm;
end;

function Abs(const AValue: TComplex): TReal;
begin
  result := AValue.Norm;
end;

function SameValueEx(const AValue1, AValue2: TReal): boolean;
begin
  result := Math.SameValue(AValue1, AValue2, DefaultEpsilon);
end;

function SameValueEx(const AValue1, AValue2: TComplex): boolean;
begin
  result := SameValueEx(AValue1.fRe, AValue2.fRe) and
            SameValueEx(AValue1.fIm, AValue2.fIm);
end;

function SquarePower(const AValue: TComplex): TComplex;
begin
  result := AValue * AValue;
end;

function CubicPower(const AValue: TComplex): TComplex;
begin
  result := AValue * AValue * AValue;
end;

function QuarticPower(const AValue: TComplex): TComplex;
begin
  result := AValue * AValue * AValue * AValue;
end;

function QuinticPower(const AValue: TComplex): TComplex;
begin
  result := AValue * AValue * AValue * AValue * AValue;
end;

function SexticPower(const AValue: TComplex): TComplex;
begin
  result := AValue * AValue * AValue * AValue * AValue * AValue;
end;

{ Scales AValue by an exact power of two when its larger component is
  outside [1e-300, 1e300], so that the modulus can be formed without
  overflow or loss of precision. 2^600 is a perfect square, cube and fourth
  power: the k-th root of the scaled value is multiplied by AFactor^(600/k)
  with AFactor = 2 or 1/2 to undo the scaling. }
function ScaleForRoot(const AValue: TComplex; out AFactor: TReal): TComplex;
const
  Down = 2.4099198651028841E-181; { 2^-600 }
  Up = 4.1495155688809929E+180;   { 2^600 }
var
  LMax: TReal;
begin
  LMax := Max(System.Abs(AValue.fRe), System.Abs(AValue.fIm));
  if LMax > 1E300 then
  begin
    result := AValue * Down;
    AFactor := 2;
  end else if (LMax < 1E-300) and (LMax > 0) then
  begin
    result := AValue * Up;
    AFactor := 0.5;
  end else
  begin
    result := AValue;
    AFactor := 1;
  end;
end;

function SquareRoot(const AValue: TComplex): TArrayOfComplex;
var
  LScaled: TComplex;
  LFactor, LLarge, LSmall: TReal;
begin
  result := nil;
  SetLength(result, 2);
  if (AValue.fRe = 0) and (AValue.fIm = 0) then
  begin
    result[0] := 0;
    result[1] := 0;
    Exit;
  end;
  LScaled := ScaleForRoot(AValue, LFactor);
  { The larger component is formed without cancellation as
    sqrt((|Re| + |z|)/2); the smaller one follows from Im = 2*x*y. }
  LLarge := Sqrt(0.5 * (System.Abs(LScaled.fRe) +
    Hypot(LScaled.fRe, LScaled.fIm)));
  LSmall := (System.Abs(LScaled.fIm) / LLarge) / 2;
  if LScaled.fRe >= 0 then
  begin
    result[0].fRe := LLarge;
    result[0].fIm := LSmall;
  end else
  begin
    result[0].fRe := LSmall;
    result[0].fIm := LLarge;
  end;
  if AValue.fIm < 0 then result[0].fIm := -result[0].fIm;
  if LFactor <> 1 then
    result[0] := result[0] * IntPower(LFactor, 300);
  result[1] := -result[0];
end;

{ The k roots of AValue at arguments (theta + 2*pi*j)/k. }
function KthRoots(const AValue: TComplex; K: longint): TArrayOfComplex;
var
  LScaled: TComplex;
  LFactor, LModulus, LRoot, LTheta, LArgument: TReal;
  LIndex: longint;
begin
  result := nil;
  SetLength(result, K);
  LScaled := ScaleForRoot(AValue, LFactor);
  LModulus := LScaled.Norm;
  if K = 4 then
    { Two correctly rounded square roots. }
    LRoot := Sqrt(Sqrt(LModulus))
  else
  begin
    { Power(x, 1/3) uses a rounded exponent whose error is amplified by
      ln(x); one Newton step restores full accuracy. }
    LRoot := Power(LModulus, 1 / 3);
    if LRoot > 0 then
      LRoot := LRoot + (LModulus / (LRoot * LRoot) - LRoot) / 3;
  end;
  if LFactor <> 1 then
    LRoot := LRoot * IntPower(LFactor, 600 div K);
  LTheta := Math.ArcTan2(AValue.fIm, AValue.fRe);
  for LIndex := 0 to K - 1 do
  begin
    LArgument := (LTheta + 2 * LIndex * Pi) / K;
    result[LIndex].fRe := LRoot * Cos(LArgument);
    result[LIndex].fIm := LRoot * Sin(LArgument);
  end;
end;

function CubicRoot(const AValue: TComplex): TArrayOfComplex;
begin
  result := KthRoots(AValue, 3);
end;

function QuarticRoot(const AValue: TComplex): TArrayOfComplex;
begin
  result := KthRoots(AValue, 4);
end;

function SquareNorm(const AValue: TReal): TReal;
begin
  result := sqr(Avalue);
end;

function SquareNorm(const AValue: TComplex): TReal;
begin
  result := AValue.SquaredNorm;
end;

function Norm(const AValue: TReal): TReal;
begin
  result := System.Abs(AValue);
end;

function Norm(const AValue: TComplex): TReal;
begin
  result := AValue.Norm;
end;

function FloatToStrF(const AValue: TReal): string;
begin
  result := AValue.ToString;
end;

function FloatToStrF(const AValue: TComplex): string;
begin
  result := AValue.ToString;
end;

function FloatToStrF(const AValue: TReal; APrecision, ADigits: longint): string;
begin
  result := SysUtils.FloatToStrF(AValue, ffGeneral, APrecision, ADigits);
end;

function FloatToStrF(const AValue: TComplex; APrecision, ADigits: longint): string;
begin
  result := AValue.ToString(APrecision, ADigits);
end;

end.
