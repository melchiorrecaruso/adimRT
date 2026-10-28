{ ADim mathematical types and operations.

  Defines real and complex scalar types, dynamically sized vectors and square
  matrices, and the related algebraic operations used throughout the ADimPas
  library. Vector sizes and matrix orders are inferred from the values passed
  to Init.

  @author Melchiorre Caruso (melchiorrecaruso@@gmail.com)
  @copyright 2025-2026 Melchiorre Caruso
  @license GNU Lesser General Public License v3 with modified LGPL exception.

  This unit is part of the ADim library, distributed under the
  GNU Lesser General Public License v3 (LGPL v3) with the following
  special exception:

  As a special exception, the copyright holders of this library give you
  permission to link this library with independent modules to produce an
  executable, regardless of the license terms of these independent modules,
  and to copy and distribute the resulting executable under terms of your
  choice, provided that you also meet, for each linked independent module,
  the terms and conditions of the license of that module. An independent
  module is a module which is not derived from or based on this library.
  If you modify this library, you may extend this exception to your version
  of the library, but you are not obligated to do so. If you do not wish
  to do so, delete this exception statement from your version.
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

{ @exclude Neumaier compensated summation step used by the generic
  containers; the complex overload compensates each component. }
procedure CompensatedAdd(var ASum, ACompensation: TReal;
  const AValue: TReal); overload; inline;

{ @exclude }
procedure CompensatedAdd(var ASum, ACompensation: TComplex;
  const AValue: TComplex); overload; inline;

type
  TRealHelper = type helper for TReal
    function Conjugate: TReal; inline;
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
    function Norm: TReal;
    function SquaredNorm: TReal;
    function Normalize: TVector;
    function Reciprocal: TVector;
    function ToString: string;

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
    function Factorize(out APivots: TPivots; out ASwapCount: integer): TMatrix;
    function SolveFactored(const APivots: TPivots; var AData: TValues;
      AAdjoint: boolean; ALimit: TReal): boolean;
    function OneNorm: TReal;
    function InverseOneNormEstimate(const APivots: TPivots;
      AMatrixNorm: TReal): TReal;
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
    function RowReduction: TMatrix;
    procedure Swap(ARow1, ARow2: longint);
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;

    class operator Initialize(var ASelf: TMatrix);
    class operator Finalize(var ASelf: TMatrix);
    class operator Copy(constref ASrc: TMatrix; var ADst: TMatrix);
    class operator =(const ALeft, ARight: TMatrix): boolean;
    class operator <>(const ALeft, ARight: TMatrix): boolean;
    class operator +(const ALeft, ARight: TMatrix): TMatrix;
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
function SameValueEx(const AValue1, AValue2: TReal): boolean;

{ Returns @true if two complex numbers are equal within @link(DefaultEpsilon). }
function SameValueEx(const AValue1, AValue2: TComplex): boolean;

{ Solves @code(x + a = 0) over the real numbers. Returns @code(-a). }
function SolveEquation(const a: TReal): TReal;

{ Solves @code(x + a = 0) over the complex numbers. Returns @code(-a). }
function SolveEquation(const a: TComplex): TComplex;

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
function SquarePower(const AValue: TComplex): TComplex;

{ Returns @code(z³). }
function CubicPower(const AValue: TComplex): TComplex;

{ Returns @code(z⁴). }
function QuarticPower(const AValue: TComplex): TComplex;

{ Returns the two square roots of @code(AValue) as a 2-element array.
  @code(result[0]) is the principal root; @code(result[1] = -result[0]).
}
function SquareRoot(const AValue: TComplex): TArrayOfComplex;

{ Returns the three cube roots of @code(AValue) as a 3-element array,
  at arguments @code(θ/3), @code((θ+2π)/3), and @code((θ+4π)/3).
}
function CubicRoot(const AValue: TComplex): TArrayOfComplex;

{ Returns the four fourth roots of @code(AValue) as a 4-element array,
  at arguments @code(θ/4), @code((θ+2π)/4), @code((θ+4π)/4), and @code((θ+6π)/4).
}
function QuarticRoot(const AValue: TComplex): TArrayOfComplex;

{ Solves @code(x² + a·x + b = 0) over the complex numbers.
  Returns a 2-element array containing both roots.
}
function SolveEquation(const a, b: TComplex): TArrayOfComplex;

{ Solves @code(x³ + a·x² + b·x + c = 0) over the complex numbers.
  Returns a 3-element array containing all three roots.
}
function SolveEquation(const a, b, c: TComplex): TArrayOfComplex;

{ Solves @code(x⁴ + a·x³ + b·x² + c·x + d = 0) over the complex numbers.
  Returns a 4-element array containing all four roots.
}
function SolveEquation(const a, b, c, d: TComplex): TArrayOfComplex;

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

{ Neumaier compensated summation step. The complex overload compensates
  the real and imaginary parts independently: a branch chosen from the
  complex modulus is wrong when the parts have different magnitudes. }
procedure CompensatedAdd(var ASum, ACompensation: TReal;
  const AValue: TReal);
var
  LUpdated: TReal;
begin
  LUpdated := ASum + AValue;
  if System.Abs(ASum) >= System.Abs(AValue) then
    ACompensation := ACompensation + ((ASum - LUpdated) + AValue)
  else
    ACompensation := ACompensation + ((AValue - LUpdated) + ASum);
  ASum := LUpdated;
end;

procedure CompensatedAdd(var ASum, ACompensation: TComplex;
  const AValue: TComplex);
begin
  CompensatedAdd(ASum.fRe, ACompensation.fRe, AValue.fRe);
  CompensatedAdd(ASum.fIm, ACompensation.fIm, AValue.fIm);
end;

// TVector<T>

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

function TVector.Dot(const AVector: TVector): T;
var
  LIndex: longint;
  LCompensation: T;
begin
  RequireSameSize(AVector);
  if Size = 0 then
    raise EDimensionError.Create('Dot product is undefined for empty vectors.');
  result := FData[0] * AVector.FData[0];
  LCompensation := result - result;
  for LIndex := 1 to Size - 1 do
    CompensatedAdd(result, LCompensation,
      FData[LIndex] * AVector.FData[LIndex]);
  result := result + LCompensation;
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

function TVector.Norm: TReal;
var
  LIndex: longint;
  LAbsolute, LRatio, LScale, LSumSquares: TReal;
begin
  { Scaled sum of squares avoids intermediate overflow/underflow and needs
    only one square root, independently of the vector length. }
  LScale := 0;
  LSumSquares := 0;
  for LIndex := 0 to Size - 1 do
  begin
    LAbsolute := Abs(FData[LIndex]);
    if LAbsolute = 0 then Continue;
    if Math.IsNan(LAbsolute) then Exit(NaN);
    if Math.IsInfinite(LAbsolute) then Exit(Infinity);
    if LScale < LAbsolute then
    begin
      if LScale = 0 then
        LSumSquares := 1
      else
      begin
        LRatio := LScale / LAbsolute;
        LSumSquares := 1 + LSumSquares * Sqr(LRatio);
      end;
      LScale := LAbsolute;
    end
    else
    begin
      LRatio := LAbsolute / LScale;
      LSumSquares := LSumSquares + Sqr(LRatio);
    end;
  end;
  result := LScale * Sqrt(LSumSquares);
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

{ LU factorization with partial pivoting, P*A = L*U (LAPACK xGETF2). The
  result holds U on and above the diagonal and the multipliers of L below
  it; APivots[k] is the row exchanged with row k at step k. A column with
  no nonzero pivot candidate is skipped and leaves a zero on the diagonal. }
function TMatrix.Factorize(out APivots: TPivots;
  out ASwapCount: integer): TMatrix;
var
  LPivot, LFactor: T;
  LMaxValue: TReal;
  LRow, LCol, LIndex, LMaxRow: longint;
begin
  result := Clone;
  APivots := nil;
  SetLength(APivots, FOrder);
  ASwapCount := 0;
  for LCol := 0 to FOrder - 1 do
  begin
    LMaxRow := LCol;
    LMaxValue := Abs(result[LCol, LCol]);
    for LRow := LCol + 1 to FOrder - 1 do
      if Abs(result[LRow, LCol]) > LMaxValue then
      begin
        LMaxValue := Abs(result[LRow, LCol]);
        LMaxRow := LRow;
      end;
    APivots[LCol] := LMaxRow;
    if LMaxValue = 0 then Continue;
    if LMaxRow <> LCol then
    begin
      result.Swap(LCol, LMaxRow);
      Inc(ASwapCount);
    end;
    LPivot := result[LCol, LCol];
    for LRow := LCol + 1 to FOrder - 1 do
    begin
      if Abs(result[LRow, LCol]) = 0 then Continue;
      LFactor := result[LRow, LCol] / LPivot;
      result[LRow, LCol] := LFactor;
      for LIndex := LCol + 1 to FOrder - 1 do
        result[LRow, LIndex] := result[LRow, LIndex] -
          LFactor * result[LCol, LIndex];
    end;
  end;
end;

{ Solves A*x = b, or A^H*x = b when AAdjoint, with Self holding the LU
  factors of A (LAPACK xGETRS). AData holds b on entry and x on exit.
  Returns @false, leaving AData undefined, when a component would exceed
  ALimit in modulus; the condition estimator uses this to stop before an
  overflow. }
function TMatrix.SolveFactored(const APivots: TPivots; var AData: TValues;
  AAdjoint: boolean; ALimit: TReal): boolean;
var
  LRow, LIndex: longint;
  LValue, LPivot, LTemp: T;
begin
  result := False;
  if not AAdjoint then
  begin
    { P*b, then L*y = P*b and U*x = y. }
    for LRow := 0 to FOrder - 1 do
      if APivots[LRow] <> LRow then
      begin
        LTemp := AData[LRow];
        AData[LRow] := AData[APivots[LRow]];
        AData[APivots[LRow]] := LTemp;
      end;
    for LRow := 1 to FOrder - 1 do
    begin
      LValue := AData[LRow];
      for LIndex := 0 to LRow - 1 do
        LValue := LValue - Self[LRow, LIndex] * AData[LIndex];
      AData[LRow] := LValue;
    end;
    for LRow := FOrder - 1 downto 0 do
    begin
      LValue := AData[LRow];
      for LIndex := LRow + 1 to FOrder - 1 do
        LValue := LValue - Self[LRow, LIndex] * AData[LIndex];
      LPivot := Self[LRow, LRow];
      if (Abs(LPivot) < 1) and (Abs(LValue) > ALimit * Abs(LPivot)) then Exit;
      AData[LRow] := LValue / LPivot;
    end;
  end else
  begin
    { A^H = U^H*L^H*P: U^H*y = b, L^H*z = y, then x = P^T*z. }
    for LRow := 0 to FOrder - 1 do
    begin
      LValue := AData[LRow];
      for LIndex := 0 to LRow - 1 do
        LValue := LValue - Self[LIndex, LRow].Conjugate * AData[LIndex];
      LPivot := Self[LRow, LRow].Conjugate;
      if (Abs(LPivot) < 1) and (Abs(LValue) > ALimit * Abs(LPivot)) then Exit;
      AData[LRow] := LValue / LPivot;
    end;
    for LRow := FOrder - 2 downto 0 do
    begin
      LValue := AData[LRow];
      for LIndex := LRow + 1 to FOrder - 1 do
        LValue := LValue - Self[LIndex, LRow].Conjugate * AData[LIndex];
      AData[LRow] := LValue;
    end;
    for LRow := FOrder - 1 downto 0 do
      if APivots[LRow] <> LRow then
      begin
        LTemp := AData[LRow];
        AData[LRow] := AData[APivots[LRow]];
        AData[APivots[LRow]] := LTemp;
      end;
  end;
  result := True;
end;

{ Maximum absolute column sum. }
function TMatrix.OneNorm: TReal;
var
  LRow, LCol: longint;
  LSum: TReal;
begin
  result := 0;
  for LCol := 0 to FOrder - 1 do
  begin
    LSum := 0;
    for LRow := 0 to FOrder - 1 do LSum := LSum + Abs(Self[LRow, LCol]);
    result := Max(result, LSum);
  end;
end;

{ Lower estimate of ||A^-1||_1 from the LU factors held in Self, by the
  method of Hager and Higham (LAPACK xLACN2, as used by xGECON): a few
  solves with A and A^H, then the alternative estimate of Higham (1988).
  Every estimate is ||A^-1*x||_1 for some ||x||_1 = 1, so it never exceeds
  the true norm. Returns Infinity when a solve would overflow, which
  happens only when the reciprocal condition number is far below the unit
  roundoff. }
function TMatrix.InverseOneNormEstimate(const APivots: TPivots;
  AMatrixNorm: TReal): TReal;
const
  MaxIterations = 5;
var
  X, Z: TValues;
  LLimit, LEstimate, LPrevious, LLargest, LAbsolute: TReal;
  LIndex, LColumn, LPreviousColumn, LIteration: longint;

  function NormOf(const AValues: TValues): TReal;
  var
    LPosition: longint;
  begin
    result := 0;
    for LPosition := 0 to High(AValues) do
      result := result + Abs(AValues[LPosition]);
  end;

begin
  { The right-hand sides have 1-norm at most 1 and the entries of U are
    bounded by the growth of the factorization, so components below
    LLimit cannot make the next solve overflow. }
  LLimit := 1E300 / (FOrder * Max(OneNorm, TReal(1)));
  SetLength(X, FOrder);
  SetLength(Z, FOrder);
  for LIndex := 0 to FOrder - 1 do X[LIndex] := 1 / FOrder;
  if not SolveFactored(APivots, X, False, LLimit) then Exit(Infinity);
  LEstimate := NormOf(X);
  if FOrder = 1 then Exit(LEstimate);
  LColumn := -1;
  for LIteration := 1 to MaxIterations do
  begin
    { Z := A^-H * sign(X), a subgradient of ||A^-1*x||_1. }
    for LIndex := 0 to FOrder - 1 do
    begin
      LAbsolute := Abs(X[LIndex]);
      if LAbsolute = 0 then Z[LIndex] := 1
      else Z[LIndex] := X[LIndex] / LAbsolute;
    end;
    if not SolveFactored(APivots, Z, True, LLimit) then Exit(Infinity);
    LPreviousColumn := LColumn;
    LColumn := 0;
    LLargest := Abs(Z[0]);
    for LIndex := 1 to FOrder - 1 do
      if Abs(Z[LIndex]) > LLargest then
      begin
        LLargest := Abs(Z[LIndex]);
        LColumn := LIndex;
      end;
    if LColumn = LPreviousColumn then Break;
    for LIndex := 0 to FOrder - 1 do X[LIndex] := 0;
    X[LColumn] := 1;
    if not SolveFactored(APivots, X, False, LLimit) then Exit(Infinity);
    LPrevious := LEstimate;
    LEstimate := Max(LEstimate, NormOf(X));
    if LEstimate <= LPrevious then Break;
  end;
  { Alternative estimate, which catches the rare matrices that mislead the
    iteration. }
  for LIndex := 0 to FOrder - 1 do
  begin
    X[LIndex] := 1 + LIndex / (FOrder - 1);
    if Odd(LIndex) then X[LIndex] := -X[LIndex];
  end;
  if not SolveFactored(APivots, X, False, LLimit) then Exit(Infinity);
  result := Max(LEstimate, 2 * NormOf(X) / (3 * FOrder));
end;

{ LU factors of a matrix that is nonsingular to working precision. The
  threshold is the unit roundoff 2^-53, as for INFO = N+1 in LAPACK
  xGESVX. }
function TMatrix.FactorizeNonsingular(out APivots: TPivots): TMatrix;
const
  UnitRoundoff = Precision / 2;
var
  LSwapCount, LIndex: integer;
  LNorm: TReal;
begin
  result := Factorize(APivots, LSwapCount);
  if FOrder = 0 then Exit;
  for LIndex := 0 to FOrder - 1 do
    if Abs(result[LIndex, LIndex]) = 0 then
      raise EZeroDivide.Create('Matrix is singular.');
  LNorm := OneNorm;
  if 1 / (LNorm * result.InverseOneNormEstimate(APivots, LNorm)) <
     UnitRoundoff then
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
  LFactors.SolveFactored(LPivots, LData, False, Infinity);
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
  LSwapCount: integer;
  LIndex: longint;
begin
  if FOrder = 0 then
    raise EDimensionError.Create('Determinant is undefined for an empty matrix.');
  LUpper := Factorize(LPivots, LSwapCount);
  result := LUpper[0, 0];
  for LIndex := 1 to FOrder - 1 do
    result := result * LUpper[LIndex, LIndex];
  if Odd(LSwapCount) then result := -result;
end;

function TMatrix.Norm: TReal;
var
  LIndex: longint;
  LAbsolute, LRatio, LScale, LSumSquares: TReal;
begin
  LScale := 0;
  LSumSquares := 0;
  for LIndex := 0 to High(FData) do
  begin
    LAbsolute := Abs(FData[LIndex]);
    if LAbsolute = 0 then Continue;
    if Math.IsNan(LAbsolute) then Exit(NaN);
    if Math.IsInfinite(LAbsolute) then Exit(Infinity);
    if LScale < LAbsolute then
    begin
      if LScale = 0 then
        LSumSquares := 1
      else
      begin
        LRatio := LScale / LAbsolute;
        LSumSquares := 1 + LSumSquares * Sqr(LRatio);
      end;
      LScale := LAbsolute;
    end
    else
    begin
      LRatio := LAbsolute / LScale;
      LSumSquares := LSumSquares + Sqr(LRatio);
    end;
  end;
  result := LScale * Sqrt(LSumSquares);
end;

{ Gaussian elimination with complete pivoting, which reveals the rank
  reliably in practice; partial pivoting can leave rounding residuals above
  the tolerance in the trailing block. }
function TMatrix.Rank: longint;
var
  LWork: TMatrix;
  LPivot, LFactor, LTemp: T;
  LMaxValue, LTolerance: TReal;
  LStep, LRow, LCol, LIndex, LMaxRow, LMaxCol: longint;
begin
  LWork := Clone;
  LTolerance := FOrder * Precision * Norm;
  result := 0;
  for LStep := 0 to FOrder - 1 do
  begin
    LMaxRow := LStep;
    LMaxCol := LStep;
    LMaxValue := 0;
    for LRow := LStep to FOrder - 1 do
      for LCol := LStep to FOrder - 1 do
        if Abs(LWork[LRow, LCol]) > LMaxValue then
        begin
          LMaxValue := Abs(LWork[LRow, LCol]);
          LMaxRow := LRow;
          LMaxCol := LCol;
        end;
    if LMaxValue <= LTolerance then Break;
    if LMaxRow <> LStep then LWork.Swap(LStep, LMaxRow);
    if LMaxCol <> LStep then
      for LRow := 0 to FOrder - 1 do
      begin
        LTemp := LWork[LRow, LStep];
        LWork[LRow, LStep] := LWork[LRow, LMaxCol];
        LWork[LRow, LMaxCol] := LTemp;
      end;
    LPivot := LWork[LStep, LStep];
    for LRow := LStep + 1 to FOrder - 1 do
    begin
      LFactor := LWork[LRow, LStep] / LPivot;
      LWork[LRow, LStep] := 0;
      for LIndex := LStep + 1 to FOrder - 1 do
        LWork[LRow, LIndex] := LWork[LRow, LIndex] -
          LFactor * LWork[LStep, LIndex];
    end;
    Inc(result);
  end;
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
  LFactors: TMatrix;
  LPivots: TPivots;
  LColumn: TValues;
  LRow, LCol: longint;
begin
  LFactors := FactorizeNonsingular(LPivots);
  result.SetOrder(FOrder);
  SetLength(LColumn, FOrder);
  for LCol := 0 to FOrder - 1 do
  begin
    for LRow := 0 to FOrder - 1 do LColumn[LRow] := Default(T);
    LColumn[LCol] := 1;
    LFactors.SolveFactored(LPivots, LColumn, False, Infinity);
    for LRow := 0 to FOrder - 1 do result[LRow, LCol] := LColumn[LRow];
  end;
end;

function TMatrix.RowReduction: TMatrix;
var
  LPivot, LFactor: T;
  LMaxValue: TReal;
  LPivotRow, LColumn, LRow, LIndex, LMaxRow: longint;
begin
  result := Clone;
  LPivotRow := 0;
  for LColumn := 0 to FOrder - 1 do
  begin
    if LPivotRow >= FOrder then Break;
    LMaxRow := LPivotRow;
    LMaxValue := Abs(result[LPivotRow, LColumn]);
    for LRow := LPivotRow + 1 to FOrder - 1 do
      if Abs(result[LRow, LColumn]) > LMaxValue then
      begin
        LMaxValue := Abs(result[LRow, LColumn]);
        LMaxRow := LRow;
      end;
    if LMaxValue = 0 then Continue;
    if LMaxRow <> LPivotRow then result.Swap(LPivotRow, LMaxRow);
    LPivot := result[LPivotRow, LColumn];
    for LIndex := LColumn to FOrder - 1 do
      result[LPivotRow, LIndex] := result[LPivotRow, LIndex] / LPivot;
    for LRow := 0 to FOrder - 1 do
    begin
      if LRow = LPivotRow then Continue;
      LFactor := result[LRow, LColumn];
      if Abs(LFactor) = 0 then Continue;
      result[LRow, LColumn] := 0;
      for LIndex := LColumn + 1 to FOrder - 1 do
        result[LRow, LIndex] := result[LRow, LIndex] -
          LFactor * result[LPivotRow, LIndex];
    end;
    Inc(LPivotRow);
  end;
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

{ Row-oriented (i-k-j) loop: each entry keeps its own compensated
  accumulator and receives its products in the same order as an inner
  product would, so the result is unchanged while every access to the
  right operand is contiguous. }
function TMatrix.Multiply(const AMatrix: TMatrix): TMatrix;
var
  LRow, LCol, LIndex, LLeftOffset, LRightOffset: longint;
  LFactor: T;
  LCompensation: array of T;
begin
  RequireSameOrder(AMatrix);
  result.SetOrder(FOrder);
  if FOrder = 0 then Exit;
  SetLength(LCompensation, FOrder);
  for LRow := 0 to FOrder - 1 do
  begin
    LLeftOffset := LRow * FOrder;
    LFactor := FData[LLeftOffset];
    for LCol := 0 to FOrder - 1 do
    begin
      result.FData[LLeftOffset + LCol] := LFactor * AMatrix.FData[LCol];
      LCompensation[LCol] := LFactor - LFactor;
    end;
    for LIndex := 1 to FOrder - 1 do
    begin
      LFactor := FData[LLeftOffset + LIndex];
      LRightOffset := LIndex * FOrder;
      for LCol := 0 to FOrder - 1 do
        CompensatedAdd(result.FData[LLeftOffset + LCol], LCompensation[LCol],
          LFactor * AMatrix.FData[LRightOffset + LCol]);
    end;
    for LCol := 0 to FOrder - 1 do
      result.FData[LLeftOffset + LCol] :=
        result.FData[LLeftOffset + LCol] + LCompensation[LCol];
  end;
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

class operator TMatrix.*(const ALeft: TVectorType;
  const ARight: TMatrix): TVectorType;
var
  LRow, LCol, LOffset: longint;
  LFactor: T;
  LCompensation: array of T;
begin
  if ALeft.Size <> ARight.FOrder then
    raise EDimensionError.CreateFmt(
      'Vector dimension %d and matrix order %d are incompatible.',
      [ALeft.Size, ARight.FOrder]);
  result.SetSize(ARight.FOrder);
  if ARight.FOrder = 0 then Exit;
  { Row-oriented loop with one accumulator per column, as in Multiply. }
  SetLength(LCompensation, ARight.FOrder);
  LFactor := ALeft.FData[0];
  for LCol := 0 to ARight.FOrder - 1 do
  begin
    result.FData[LCol] := LFactor * ARight.FData[LCol];
    LCompensation[LCol] := LFactor - LFactor;
  end;
  for LRow := 1 to ARight.FOrder - 1 do
  begin
    LFactor := ALeft.FData[LRow];
    LOffset := LRow * ARight.FOrder;
    for LCol := 0 to ARight.FOrder - 1 do
      CompensatedAdd(result.FData[LCol], LCompensation[LCol],
        LFactor * ARight.FData[LOffset + LCol]);
  end;
  for LCol := 0 to ARight.FOrder - 1 do
    result.FData[LCol] := result.FData[LCol] + LCompensation[LCol];
end;

class operator TMatrix.*(const ALeft: TMatrix;
  const ARight: TVectorType): TVectorType;
var
  LRow, LCol, LOffset: longint;
  LValue, LProduct, LCompensation: T;
begin
  if ALeft.FOrder <> ARight.Size then
    raise EDimensionError.CreateFmt(
      'Matrix order %d and vector dimension %d are incompatible.',
      [ALeft.FOrder, ARight.Size]);
  result.SetSize(ALeft.FOrder);
  if ALeft.FOrder = 0 then Exit;
  for LRow := 0 to ALeft.FOrder - 1 do
  begin
    LOffset := LRow * ALeft.FOrder;
    LValue := ALeft.FData[LOffset] * ARight[0];
    LCompensation := LValue - LValue;
    for LCol := 1 to ALeft.FOrder - 1 do
    begin
      LProduct := ALeft.FData[LOffset + LCol] * ARight[LCol];
      CompensatedAdd(LValue, LCompensation, LProduct);
    end;
    result[LRow] := LValue + LCompensation;
  end;
end;

class operator TMatrix./(const ALeft: TMatrix; const ARight: T): TMatrix;
var
  LIndex: longint;
begin
  result.SetOrder(ALeft.FOrder);
  for LIndex := 0 to High(ALeft.FData) do
    result.FData[LIndex] := ALeft.FData[LIndex] / ARight;
end;

{ Implicit-shift QL iteration on a real symmetric tridiagonal matrix.
  ARows holds N contiguous rows of ARowLength reals: row i is the i-th
  column of the transformation that reduced the original matrix to
  tridiagonal form (the identity when there was none), possibly stored as
  interleaved real/imaginary parts. Each rotation updates two contiguous
  rows, so on exit row i is the eigenvector of ADiagonal[i]. Eigenvalues
  are sorted in ascending order together with their rows. }
procedure TridiagonalQL(var ADiagonal, AOffDiagonal: TArrayOfReal;
  var ARows: TArrayOfReal; ARowLength: longint);
const
  MaxIterations = 100;
var
  N, L, M, I, J, K, Iteration, Row0, Row1: longint;
  B, C, F, G, P, R, S, Temporary: TReal;
begin
  N := Length(ADiagonal);

  for L := 0 to N - 1 do
  begin
    Iteration := 0;
    repeat
      M := L;
      while M < N - 1 do
      begin
        if (AOffDiagonal[M] = 0) or
           (Abs(AOffDiagonal[M]) <= Precision *
            (Abs(ADiagonal[M]) + Abs(ADiagonal[M + 1]))) then Break;
        Inc(M);
      end;
      if M = L then Break;
      Inc(Iteration);
      if Iteration > MaxIterations then
        raise EInvalidOp.Create('Symmetric tridiagonal QL did not converge.');

      G := (ADiagonal[L + 1] - ADiagonal[L]) /
        (2 * AOffDiagonal[L]);
      R := Hypot(G, 1);
      if G < 0 then R := -R;
      G := ADiagonal[M] - ADiagonal[L] + AOffDiagonal[L] / (G + R);
      S := 1;
      C := 1;
      P := 0;
      for I := M - 1 downto L do
      begin
        F := S * AOffDiagonal[I];
        B := C * AOffDiagonal[I];
        if (F = 0) and (G = 0) then
        begin
          AOffDiagonal[I + 1] := 0;
          S := 0;
          C := 1;
        end else if Abs(F) >= Abs(G) then
        begin
          C := G / F;
          R := Hypot(C, 1);
          AOffDiagonal[I + 1] := F * R;
          S := 1 / R;
          C := C * S;
        end else
        begin
          S := F / G;
          R := Hypot(S, 1);
          AOffDiagonal[I + 1] := G * R;
          C := 1 / R;
          S := S * C;
        end;
        G := ADiagonal[I + 1] - P;
        R := (ADiagonal[I] - G) * S + 2 * C * B;
        P := S * R;
        ADiagonal[I + 1] := G + P;
        G := C * R - B;
        Row0 := I * ARowLength;
        Row1 := Row0 + ARowLength;
        for K := 0 to ARowLength - 1 do
        begin
          F := ARows[Row1 + K];
          ARows[Row1 + K] := S * ARows[Row0 + K] + C * F;
          ARows[Row0 + K] := C * ARows[Row0 + K] - S * F;
        end;
      end;
      ADiagonal[L] := ADiagonal[L] - P;
      AOffDiagonal[L] := G;
      AOffDiagonal[M] := 0;
    until False;
  end;

  for I := 0 to N - 2 do
  begin
    K := I;
    for J := I + 1 to N - 1 do
      if ADiagonal[J] < ADiagonal[K] then K := J;
    if K <> I then
    begin
      Temporary := ADiagonal[I];
      ADiagonal[I] := ADiagonal[K];
      ADiagonal[K] := Temporary;
      for J := 0 to ARowLength - 1 do
      begin
        Temporary := ARows[I * ARowLength + J];
        ARows[I * ARowLength + J] := ARows[K * ARowLength + J];
        ARows[K * ARowLength + J] := Temporary;
      end;
    end;
  end;
end;

{ Sturm bisection for the eigenvalues, then inverse iteration with each
  eigenvalue as its own shift (as in LAPACK DSTEIN). Each shifted matrix is
  factored once by tridiagonal LU with partial pivoting. Clustered or
  unconverged cases use the full QL solver. }
procedure TridiagonalLowestEigenpairs(
  const ADiagonal, AOffDiagonal: TRealVector; ACount: longint;
  out AValues: TRealVector; out AVectors: TArrayOfRealVector);
const
  PivotFloor: TReal = 1E-300;
  MaxBisectionSteps = 120;
  MaxInverseSteps = 8;
var
  D, E, Eigenvalues, Raw, Multipliers, U0, U1, U2: TArrayOfReal;
  Swapped: array of boolean;
  X, Y, ProductVector, ResidualVector: TRealVector;
  Scale, LowerBound, UpperBound, Radius, Low, High, Mid,
    Projection, VectorNorm, Rayleigh, ResidualNorm, Tolerance,
    PivotTolerance: TReal;
  N, I, J, K, Pass, Iteration: longint;
  Seed: longword;
  Converged: boolean;

  function SturmCount(const AX: TReal): longint;
  var
    Index: longint;
    Quotient: TReal;
  begin
    result := 0;
    Quotient := D[0] - AX;
    if Quotient <= 0 then Inc(result);
    for Index := 1 to N - 1 do
    begin
      if System.Abs(Quotient) < PivotFloor then Quotient := -PivotFloor;
      Quotient := D[Index] - AX - Sqr(E[Index - 1]) / Quotient;
      if Quotient <= 0 then Inc(result);
    end;
  end;

  procedure UseFullSolver;
  var
    State, Row: longint;
    FullD, FullE, Rows, VectorData, ValueData: TArrayOfReal;
  begin
    FullD := System.Copy(D);
    FullE := System.Copy(E);
    SetLength(Rows, N * N);
    for Row := 0 to N - 1 do Rows[Row * N + Row] := 1;
    TridiagonalQL(FullD, FullE, Rows, N);
    SetLength(ValueData, ACount);
    SetLength(VectorData, N);
    SetLength(AVectors, ACount);
    for State := 0 to ACount - 1 do
    begin
      ValueData[State] := FullD[State] * Scale;
      for Row := 0 to N - 1 do
        VectorData[Row] := Rows[State * N + Row];
      AVectors[State].Init(VectorData);
    end;
    AValues.Init(ValueData);
  end;

  { LU factorization with partial pivoting of T - AShift*I. U has the main
    diagonal U0 and two superdiagonals U1, U2. }
  procedure FactorShifted(const AShift: TReal);
  var
    Index: longint;
    Next0, Next1: TReal;
  begin
    for Index := 0 to N - 1 do
    begin
      U0[Index] := D[Index] - AShift;
      if Index < N - 1 then U1[Index] := E[Index] else U1[Index] := 0;
      U2[Index] := 0;
    end;
    for Index := 0 to N - 2 do
    begin
      if System.Abs(E[Index]) <= System.Abs(U0[Index]) then
      begin
        Swapped[Index] := False;
        if U0[Index] = 0 then U0[Index] := PivotTolerance;
        Multipliers[Index] := E[Index] / U0[Index];
        U0[Index + 1] := U0[Index + 1] - Multipliers[Index] * U1[Index];
      end else
      begin
        Swapped[Index] := True;
        Multipliers[Index] := U0[Index] / E[Index];
        Next0 := U0[Index + 1];
        Next1 := U1[Index + 1];
        U0[Index] := E[Index];
        U0[Index + 1] := U1[Index] - Multipliers[Index] * Next0;
        U1[Index + 1] := -Multipliers[Index] * Next1;
        U1[Index] := Next0;
        U2[Index] := Next1;
      end;
    end;
    for Index := 0 to N - 1 do
      if System.Abs(U0[Index]) < PivotTolerance then
        if U0[Index] < 0 then U0[Index] := -PivotTolerance
        else U0[Index] := PivotTolerance;
  end;

  procedure SolveShifted(var AData: TArrayOfReal);
  var
    Index: longint;
    Temporary: TReal;
  begin
    for Index := 0 to N - 2 do
    begin
      if Swapped[Index] then
      begin
        Temporary := AData[Index];
        AData[Index] := AData[Index + 1];
        AData[Index + 1] := Temporary;
      end;
      AData[Index + 1] := AData[Index + 1] - Multipliers[Index] * AData[Index];
    end;
    AData[N - 1] := AData[N - 1] / U0[N - 1];
    if N > 1 then
      AData[N - 2] := (AData[N - 2] - U1[N - 2] * AData[N - 1]) / U0[N - 2];
    for Index := N - 3 downto 0 do
      AData[Index] := (AData[Index] - U1[Index] * AData[Index + 1] -
        U2[Index] * AData[Index + 2]) / U0[Index];
  end;

begin
  N := ADiagonal.Size;
  if (N = 0) or (AOffDiagonal.Size <> N - 1) or
     (ACount < 1) or (ACount > N) then
    raise EDimensionError.Create(
      'Require N diagonal, N-1 off-diagonal, and 1..N eigenpairs.');

  Scale := 0;
  for I := 0 to N - 1 do
  begin
    if IsNan(ADiagonal[I]) or IsInfinite(ADiagonal[I]) then
      raise EInvalidOp.Create('Tridiagonal entries must be finite.');
    Scale := Max(Scale, System.Abs(ADiagonal[I]));
    if I < N - 1 then
    begin
      if IsNan(AOffDiagonal[I]) or IsInfinite(AOffDiagonal[I]) then
        raise EInvalidOp.Create('Tridiagonal entries must be finite.');
      Scale := Max(Scale, System.Abs(AOffDiagonal[I]));
    end;
  end;
  if Scale = 0 then Scale := 1;
  SetLength(D, N);
  SetLength(E, N);
  for I := 0 to N - 1 do
  begin
    D[I] := ADiagonal[I] / Scale;
    if I < N - 1 then E[I] := AOffDiagonal[I] / Scale;
  end;
  if (N <= 32) or (ACount * 3 >= N) then
  begin
    UseFullSolver;
    Exit;
  end;

  LowerBound := Infinity;
  UpperBound := -Infinity;
  for I := 0 to N - 1 do
  begin
    Radius := 0;
    if I > 0 then Radius := Radius + System.Abs(E[I - 1]);
    if I < N - 1 then Radius := Radius + System.Abs(E[I]);
    LowerBound := Min(LowerBound, D[I] - Radius);
    UpperBound := Max(UpperBound, D[I] + Radius);
  end;
  LowerBound := LowerBound - 32 * Precision *
    Max(1.0, System.Abs(LowerBound));
  UpperBound := UpperBound + 32 * Precision *
    Max(1.0, System.Abs(UpperBound));

  SetLength(Eigenvalues, ACount);
  for J := 0 to ACount - 1 do
  begin
    Low := LowerBound;
    High := UpperBound;
    for Iteration := 1 to MaxBisectionSteps do
    begin
      Mid := Low + (High - Low) / 2;
      if (Mid = Low) or (Mid = High) then Break;
      if SturmCount(Mid) <= J then Low := Mid else High := Mid;
      if High - Low <= Precision *
        Max(1.0, Max(System.Abs(Low), System.Abs(High))) then Break;
    end;
    Eigenvalues[J] := Low + (High - Low) / 2;
    if (J > 0) and
       (Eigenvalues[J] - Eigenvalues[J - 1] <= 64 * Precision) then
    begin
      UseFullSolver;
      Exit;
    end;
  end;

  { The matrix is scaled to unit max-norm, so this is a relative floor. }
  PivotTolerance := Precision;
  SetLength(Multipliers, N);
  SetLength(Swapped, N);
  SetLength(U0, N);
  SetLength(U1, N);
  SetLength(U2, N);
  SetLength(AVectors, ACount);
  SetLength(Raw, N);
  Seed := 123456789;
  for J := 0 to ACount - 1 do
  begin
    FactorShifted(Eigenvalues[J]);
    for I := 0 to N - 1 do
    begin
      {$push}{$Q-}{$R-}
      Seed := Seed * 1664525 + 1013904223;
      {$pop}
      Raw[I] := (Seed / 4294967295.0) * 2 - 1;
    end;
    X.Init(Raw);
    Converged := False;
    for Iteration := 1 to MaxInverseSteps do
    begin
      for I := 0 to N - 1 do Raw[I] := X[I];
      SolveShifted(Raw);
      Y.Init(Raw);
      VectorNorm := Y.Norm;
      if (VectorNorm = 0) or IsNan(VectorNorm) or
         IsInfinite(VectorNorm) then Break;
      Y := Y / VectorNorm;

      for Pass := 1 to 2 do
        for K := 0 to J - 1 do
        begin
          Projection := Y.Dot(AVectors[K]);
          for I := 0 to N - 1 do
            Y[I] := Y[I] - Projection * AVectors[K][I];
        end;
      VectorNorm := Y.Norm;
      if (VectorNorm = 0) or IsNan(VectorNorm) then Break;
      Y := Y / VectorNorm;

      for I := 0 to N - 1 do
      begin
        Raw[I] := D[I] * Y[I];
        if I > 0 then Raw[I] := Raw[I] + E[I - 1] * Y[I - 1];
        if I < N - 1 then Raw[I] := Raw[I] + E[I] * Y[I + 1];
      end;
      ProductVector.Init(Raw);
      Rayleigh := Y.Dot(ProductVector);
      for I := 0 to N - 1 do
        Raw[I] := Raw[I] - Rayleigh * Y[I];
      ResidualVector.Init(Raw);
      ResidualNorm := ResidualVector.Norm;
      Tolerance := 32 * Precision * Max(1.0, System.Abs(Rayleigh));
      if ResidualNorm <= Tolerance then
      begin
        AVectors[J] := Y;
        Eigenvalues[J] := Rayleigh;
        Converged := True;
        Break;
      end;
      X := Y;
    end;
    if not Converged then
    begin
      UseFullSolver;
      Exit;
    end;
  end;
  for J := 1 to ACount - 1 do
    if Eigenvalues[J] < Eigenvalues[J - 1] then
    begin
      UseFullSolver;
      Exit;
    end;
  for J := 0 to ACount - 1 do
    Eigenvalues[J] := Eigenvalues[J] * Scale;
  AValues.Init(Eigenvalues);
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

procedure TRealMatrixHelper.Eigenpairs(out AValues: TComplexVector;
  out AVectors: TComplexMatrix);
var
  LComplexMatrix: TComplexMatrix;
begin
  LComplexMatrix := ToComplex;
  LComplexMatrix.Eigenpairs(AValues, AVectors);
end;

procedure TRealMatrixHelper.SymmetricEigenpairs(out AValues: TRealVector;
  out AVectors: TRealMatrix);
var
  Work, Q: TRealMatrix;
  D, E, U, W, Rows: TArrayOfReal;
  Scale, Tolerance, VectorNorm, Alpha, Beta, Value, Projection: TReal;
  N, I, J, K: longint;
  IsTridiagonal: boolean;
begin
  N := Self.Order;
  if N = 0 then
    raise EDimensionError.Create('Eigenpairs are undefined for an empty matrix.');
  Work := Self.Clone;
  Scale := 0;
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      if IsNan(Work[I, J]) or IsInfinite(Work[I, J]) then
        raise EInvalidOp.Create('Matrix entries must be finite.');
      Scale := Max(Scale, Abs(Work[I, J]));
    end;
  Tolerance := 32 * Precision * Scale;
  IsTridiagonal := True;
  for I := 0 to N - 1 do
    for J := I + 1 to N - 1 do
    begin
      if Abs(Work[I, J] - Work[J, I]) > Tolerance then
        raise EInvalidOp.Create('Matrix must be real symmetric.');
      Value := (Work[I, J] + Work[J, I]) / 2;
      Work[I, J] := Value;
      Work[J, I] := Value;
      if (J > I + 1) and (Value <> 0) then IsTridiagonal := False;
    end;

  Q.Init([]);
  if not IsTridiagonal then
  begin
    Q := Self.Identity;
    SetLength(U, N);
    SetLength(W, N);
    for K := 0 to N - 3 do
    begin
      VectorNorm := 0;
      for I := K + 1 to N - 1 do
        VectorNorm := Hypot(VectorNorm, Work[I, K]);
      if VectorNorm = 0 then Continue;
      if Work[K + 1, K] >= 0 then
        Alpha := -VectorNorm
      else
        Alpha := VectorNorm;
      U[K + 1] := Work[K + 1, K] - Alpha;
      for I := K + 2 to N - 1 do U[I] := Work[I, K];
      VectorNorm := 0;
      for I := K + 1 to N - 1 do
        VectorNorm := Hypot(VectorNorm, U[I]);
      for I := K + 1 to N - 1 do U[I] := U[I] / VectorNorm;

      for I := K + 1 to N - 1 do
      begin
        W[I] := 0;
        for J := K + 1 to N - 1 do
          W[I] := W[I] + Work[I, J] * U[J];
        W[I] := 2 * W[I];
      end;
      Beta := 0;
      for I := K + 1 to N - 1 do Beta := Beta + U[I] * W[I];
      for I := K + 1 to N - 1 do W[I] := W[I] - Beta * U[I];
      for I := K + 1 to N - 1 do
        for J := I to N - 1 do
        begin
          Value := Work[I, J] - U[I] * W[J] - W[I] * U[J];
          Work[I, J] := Value;
          Work[J, I] := Value;
        end;
      Work[K + 1, K] := Alpha;
      Work[K, K + 1] := Alpha;
      for I := K + 2 to N - 1 do
      begin
        Work[I, K] := 0;
        Work[K, I] := 0;
      end;

      for I := 0 to N - 1 do
      begin
        Projection := 0;
        for J := K + 1 to N - 1 do
          Projection := Projection + Q[I, J] * U[J];
        for J := K + 1 to N - 1 do
          Q[I, J] := Q[I, J] - 2 * Projection * U[J];
      end;
    end;
  end;

  SetLength(D, N);
  SetLength(E, N);
  for I := 0 to N - 1 do
  begin
    D[I] := Work[I, I];
    if I < N - 1 then E[I] := Work[I + 1, I];
  end;
  { The QL rotations are accumulated directly into Q, stored by columns. }
  SetLength(Rows, N * N);
  if IsTridiagonal then
    for I := 0 to N - 1 do Rows[I * N + I] := 1
  else
    for I := 0 to N - 1 do
      for J := 0 to N - 1 do
        Rows[J * N + I] := Q[I, J];
  TridiagonalQL(D, E, Rows, N);
  AValues.Init(D);
  AVectors.SetOrder(N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
      AVectors[I, J] := Rows[J * N + I];
end;

{ Complex Schur decomposition A = Z*T*Z^H followed by eigenvectors of the
  triangular factor, as in LAPACK ZGEEV: balancing (ZGEBAL), Householder
  reduction to upper Hessenberg form, single-shift QR iteration with
  Wilkinson and exceptional shifts and the Ahues-Tisseur deflation test
  (ZLAHQR), then triangular back substitution (ZTREVC) and back
  transformation of the balancing (ZGEBAK). The cost is O(N^3). Hermitian
  input uses HermitianEigenpairs, which returns orthonormal eigenvectors. }
procedure TComplexMatrixHelper.Eigenpairs(out AValues: TComplexVector;
  out AVectors: TComplexMatrix);
const
  SafeMinimum = 2.2250738585072014E-308;
  BigValue = 1E100;
  ExceptionalFactor = 0.75;
  { Limits and convergence factor of the ZGEBAL scaling loop. }
  SafeMinimum1 = SafeMinimum / Precision;
  SafeMaximum1 = 1 / SafeMinimum1;
  SafeMinimum2 = SafeMinimum1 * 2;
  SafeMaximum2 = 1 / SafeMinimum2;
  BalanceFactor = 0.95;
var
  N, I, J, K, L, Row, Iteration, MaxIterations, Last, BalanceLow,
    BalanceHigh: longint;
  H, Z, V, X: TArrayOfComplex;
  W: TArrayOfComplex;
  Balance: TArrayOfReal;
  Swaps: array of longint;
  HermitianValues: TRealVector;
  Alpha, Sum, Shift, U, XShift, Y, C2, S, R, Temporary, Diagonal: TComplex;
  Scale, Tolerance, VectorNorm, FirstNorm, SmallNumber, Test, AB, BA, AA,
    BB, Total, C, Largest, MinPivot, ColumnNorm, RowNorm, ColumnMax, RowMax,
    Factor, Ratio, Before: TReal;
  IsHermitian, IsDiagonal, Changed, CanSwap: boolean;

  function Abs1(const AValue: TComplex): TReal; inline;
  begin
    result := System.Abs(AValue.fRe) + System.Abs(AValue.fIm);
  end;

  { Rotation [c s; -conj(s) c], c real, mapping (AX, AY) to (ARadius, 0). }
  procedure Rotation(const AX, AY: TComplex; out ACos: TReal;
    out ASin, ARadius: TComplex);
  var
    LNormX, LNorm: TReal;
    LPhase: TComplex;
  begin
    LNormX := AX.Norm;
    LNorm := Hypot(LNormX, AY.Norm);
    if LNorm = 0 then
    begin
      ACos := 1;
      ASin := 0;
      ARadius := 0;
    end else if LNormX = 0 then
    begin
      ACos := 0;
      ASin := AY.Conjugate / LNorm;
      ARadius := LNorm;
    end else
    begin
      LPhase := AX / LNormX;
      ACos := LNormX / LNorm;
      ASin := LPhase * (AY.Conjugate / LNorm);
      ARadius := LPhase * LNorm;
    end;
  end;

  { Applies the permutation similarity exchanging indices AFirst and
    ASecond to H and records it for the back transformation. }
  procedure SwapRowsAndColumns(AFirst, ASecond: longint);
  var
    LIndex: longint;
    LValue: TComplex;
  begin
    SetLength(Swaps, Length(Swaps) + 2);
    Swaps[High(Swaps) - 1] := AFirst;
    Swaps[High(Swaps)] := ASecond;
    if AFirst = ASecond then Exit;
    for LIndex := 0 to N - 1 do
    begin
      LValue := H[LIndex * N + AFirst];
      H[LIndex * N + AFirst] := H[LIndex * N + ASecond];
      H[LIndex * N + ASecond] := LValue;
    end;
    for LIndex := 0 to N - 1 do
    begin
      LValue := H[AFirst * N + LIndex];
      H[AFirst * N + LIndex] := H[ASecond * N + LIndex];
      H[ASecond * N + LIndex] := LValue;
    end;
  end;

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
  IsHermitian := True;
  Tolerance := 32 * Precision * Scale;
  for I := 0 to N - 1 do
  begin
    if System.Abs(Self.FData[I * N + I].fIm) > Tolerance then
      IsHermitian := False;
    for J := 0 to N - 1 do
      if J <> I then
      begin
        if Self.FData[I * N + J].Norm <> 0 then IsDiagonal := False;
        if (Self.FData[I * N + J] - Self.FData[J * N + I].Conjugate).Norm >
           Tolerance then IsHermitian := False;
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

  if IsHermitian then
  begin
    Self.HermitianEigenpairs(HermitianValues, AVectors);
    for I := 0 to N - 1 do AValues[I] := HermitianValues[I];
  end else
  begin
    H := System.Copy(Self.FData);

    { Balancing, as in LAPACK ZGEBAL. Symmetric permutations first move
      rows and columns that isolate an eigenvalue to the bottom and to the
      top; a diagonal similarity D^-1*A*D by powers of two then makes the
      2-norms of corresponding rows and columns comparable. Without it the
      eigenvalues of a badly scaled matrix carry errors relative to its
      largest entries. }
    SetLength(Balance, N);
    for I := 0 to N - 1 do Balance[I] := 1;
    Swaps := nil;
    BalanceLow := 0;
    BalanceHigh := N - 1;
    Changed := True;
    while Changed and (BalanceHigh > 0) do
    begin
      Changed := False;
      for I := BalanceHigh downto 0 do
      begin
        CanSwap := True;
        for J := 0 to BalanceHigh do
          if (J <> I) and ((H[I * N + J].fRe <> 0) or
             (H[I * N + J].fIm <> 0)) then
          begin
            CanSwap := False;
            Break;
          end;
        if not CanSwap then Continue;
        SwapRowsAndColumns(I, BalanceHigh);
        Changed := True;
        Dec(BalanceHigh);
        if BalanceHigh = 0 then Break;
      end;
    end;
    Changed := BalanceHigh > 0;
    while Changed do
    begin
      Changed := False;
      for J := BalanceLow to BalanceHigh do
      begin
        CanSwap := True;
        for I := BalanceLow to BalanceHigh do
          if (I <> J) and ((H[I * N + J].fRe <> 0) or
             (H[I * N + J].fIm <> 0)) then
          begin
            CanSwap := False;
            Break;
          end;
        if not CanSwap then Continue;
        SwapRowsAndColumns(J, BalanceLow);
        Changed := True;
        Inc(BalanceLow);
      end;
    end;
    Changed := BalanceLow < BalanceHigh;
    while Changed do
    begin
      Changed := False;
      for I := BalanceLow to BalanceHigh do
      begin
        ColumnNorm := 0;
        RowNorm := 0;
        for J := BalanceLow to BalanceHigh do
        begin
          ColumnNorm := Hypot(ColumnNorm, H[J * N + I].Norm);
          RowNorm := Hypot(RowNorm, H[I * N + J].Norm);
        end;
        ColumnMax := 0;
        RowMax := 0;
        for J := 0 to N - 1 do
        begin
          ColumnMax := Max(ColumnMax, H[J * N + I].Norm);
          RowMax := Max(RowMax, H[I * N + J].Norm);
        end;
        if (ColumnNorm = 0) or (RowNorm = 0) then Continue;
        Factor := 1;
        Before := ColumnNorm + RowNorm;
        Ratio := RowNorm / 2;
        while (ColumnNorm < Ratio) and
          (Max(Factor, Max(ColumnNorm, ColumnMax)) < SafeMaximum2) and
          (Min(RowNorm, Min(Ratio, RowMax)) > SafeMinimum2) do
        begin
          Factor := Factor * 2;
          ColumnNorm := ColumnNorm * 2;
          ColumnMax := ColumnMax * 2;
          RowNorm := RowNorm / 2;
          Ratio := Ratio / 2;
          RowMax := RowMax / 2;
        end;
        Ratio := ColumnNorm / 2;
        while (Ratio >= RowNorm) and (Max(RowNorm, RowMax) < SafeMaximum2) and
          (Min(Min(Factor, ColumnNorm), Min(Ratio, ColumnMax)) > SafeMinimum2) do
        begin
          Factor := Factor / 2;
          ColumnNorm := ColumnNorm / 2;
          Ratio := Ratio / 2;
          ColumnMax := ColumnMax / 2;
          RowNorm := RowNorm * 2;
          RowMax := RowMax * 2;
        end;
        if ColumnNorm + RowNorm >= BalanceFactor * Before then Continue;
        if (Factor < 1) and (Balance[I] < 1) and
           (Factor * Balance[I] <= SafeMinimum1) then Continue;
        if (Factor > 1) and (Balance[I] > 1) and
           (Balance[I] >= SafeMaximum1 / Factor) then Continue;
        Balance[I] := Balance[I] * Factor;
        Changed := True;
        for J := 0 to N - 1 do
        begin
          H[I * N + J] := H[I * N + J] / Factor;
          H[J * N + I] := H[J * N + I] * Factor;
        end;
      end;
    end;

    SetLength(Z, N * N);
    for I := 0 to N - 1 do Z[I * N + I] := 1;
    SetLength(V, N);
    SetLength(W, N);

    { Householder reduction to upper Hessenberg form, accumulating Z. }
    for K := 0 to N - 3 do
    begin
      VectorNorm := 0;
      for I := K + 1 to N - 1 do
        VectorNorm := Hypot(VectorNorm, H[I * N + K].Norm);
      if VectorNorm = 0 then Continue;
      FirstNorm := H[(K + 1) * N + K].Norm;
      if FirstNorm = 0 then
        Alpha := -VectorNorm
      else
        Alpha := -VectorNorm * (H[(K + 1) * N + K] / FirstNorm);
      for I := K + 1 to N - 1 do V[I] := H[I * N + K];
      V[K + 1] := V[K + 1] - Alpha;
      VectorNorm := 0;
      for I := K + 1 to N - 1 do
        VectorNorm := Hypot(VectorNorm, V[I].Norm);
      for I := K + 1 to N - 1 do V[I] := V[I] / VectorNorm;
      { H := (I - 2vv^H) H, row by row for contiguous access. }
      for J := K to N - 1 do W[J] := 0;
      for I := K + 1 to N - 1 do
        for J := K to N - 1 do
          W[J] := W[J] + V[I].Conjugate * H[I * N + J];
      for I := K + 1 to N - 1 do
        for J := K to N - 1 do
          H[I * N + J] := H[I * N + J] - 2 * V[I] * W[J];
      { H := H (I - 2vv^H) and Z := Z (I - 2vv^H). }
      for Row := 0 to N - 1 do
      begin
        Sum := 0;
        for J := K + 1 to N - 1 do Sum := Sum + H[Row * N + J] * V[J];
        Sum := 2 * Sum;
        for J := K + 1 to N - 1 do
          H[Row * N + J] := H[Row * N + J] - Sum * V[J].Conjugate;
        Sum := 0;
        for J := K + 1 to N - 1 do Sum := Sum + Z[Row * N + J] * V[J];
        Sum := 2 * Sum;
        for J := K + 1 to N - 1 do
          Z[Row * N + J] := Z[Row * N + J] - Sum * V[J].Conjugate;
      end;
      H[(K + 1) * N + K] := Alpha;
      for I := K + 2 to N - 1 do H[I * N + K] := 0;
    end;

    { Single-shift QR iteration to the complex Schur form T, kept in H. }
    SmallNumber := SafeMinimum * (N / Precision);
    MaxIterations := 30 * Max(10, N);
    Last := N - 1;
    while Last >= 0 do
    begin
      Iteration := 0;
      repeat
        { Look for a negligible subdiagonal element. }
        K := Last;
        while K > 0 do
        begin
          if Abs1(H[K * N + K - 1]) <= SmallNumber then Break;
          Test := Abs1(H[(K - 1) * N + K - 1]) + Abs1(H[K * N + K]);
          if Test = 0 then
          begin
            if K - 2 >= 0 then Test := Test + Abs1(H[(K - 1) * N + K - 2]);
            if K + 1 <= N - 1 then Test := Test + Abs1(H[(K + 1) * N + K]);
          end;
          if Abs1(H[K * N + K - 1]) <= Precision * Test then
          begin
            AB := Max(Abs1(H[K * N + K - 1]), Abs1(H[(K - 1) * N + K]));
            BA := Min(Abs1(H[K * N + K - 1]), Abs1(H[(K - 1) * N + K]));
            AA := Max(Abs1(H[K * N + K]),
              Abs1(H[(K - 1) * N + K - 1] - H[K * N + K]));
            BB := Min(Abs1(H[K * N + K]),
              Abs1(H[(K - 1) * N + K - 1] - H[K * N + K]));
            Total := AA + AB;
            if BA * (AB / Total) <=
               Max(SmallNumber, Precision * (BB * (AA / Total))) then Break;
          end;
          Dec(K);
        end;
        L := K;
        if L > 0 then H[L * N + L - 1] := 0;
        if L >= Last then Break;

        Inc(Iteration);
        if Iteration > MaxIterations then
          raise EInvalidOp.Create(
            'TComplexMatrix.Eigenpairs: QR iteration did not converge.');

        if Iteration mod 30 = 10 then
          Shift := ExceptionalFactor * System.Abs(H[(L + 1) * N + L].fRe) +
            H[L * N + L]
        else if Iteration mod 30 = 20 then
          Shift := ExceptionalFactor *
            System.Abs(H[Last * N + Last - 1].fRe) + H[Last * N + Last]
        else
        begin
          { Wilkinson shift: eigenvalue of the trailing 2x2 block closer to
            its last diagonal entry, in the form used by ZLAHQR. }
          Shift := H[Last * N + Last];
          U := SquareRoot(H[(Last - 1) * N + Last])[0] *
            SquareRoot(H[Last * N + Last - 1])[0];
          Total := Abs1(U);
          if Total <> 0 then
          begin
            XShift := (H[(Last - 1) * N + Last - 1] - Shift) / 2;
            C := Abs1(XShift);
            Total := Max(Total, C);
            Y := Total * SquareRoot(SquarePower(XShift / Total) +
              SquarePower(U / Total))[0];
            if (C > 0) and
               ((XShift.fRe / C) * Y.fRe + (XShift.fIm / C) * Y.fIm < 0) then
              Y := -Y;
            Shift := Shift - U * (U / (XShift + Y));
          end;
        end;

        { Implicit QR sweep on rows and columns L..Last. }
        for K := L to Last - 1 do
        begin
          if K = L then
            Rotation(H[L * N + L] - Shift, H[(L + 1) * N + L], C, S, R)
          else
          begin
            Rotation(H[K * N + K - 1], H[(K + 1) * N + K - 1], C, S, R);
            H[K * N + K - 1] := R;
            H[(K + 1) * N + K - 1] := 0;
          end;
          C2 := S.Conjugate;
          for J := K to N - 1 do
          begin
            Temporary := H[K * N + J];
            H[K * N + J] := C * Temporary + S * H[(K + 1) * N + J];
            H[(K + 1) * N + J] := C * H[(K + 1) * N + J] - C2 * Temporary;
          end;
          for Row := 0 to Min(K + 2, Last) do
          begin
            Temporary := H[Row * N + K];
            H[Row * N + K] := C * Temporary + H[Row * N + K + 1] * C2;
            H[Row * N + K + 1] := C * H[Row * N + K + 1] - Temporary * S;
          end;
          for Row := 0 to N - 1 do
          begin
            Temporary := Z[Row * N + K];
            Z[Row * N + K] := C * Temporary + Z[Row * N + K + 1] * C2;
            Z[Row * N + K + 1] := C * Z[Row * N + K + 1] - Temporary * S;
          end;
        end;
      until False;
      Dec(Last);
    end;

    { Eigenvectors of T by back substitution, then back-transformed by Z. }
    SetLength(X, N);
    for K := 0 to N - 1 do
    begin
      AValues[K] := H[K * N + K];
      Diagonal := H[K * N + K];
      MinPivot := Max(Precision * Abs1(Diagonal), SmallNumber);
      X[K] := 1;
      for I := K - 1 downto 0 do
      begin
        Sum := 0;
        for J := I + 1 to K do Sum := Sum + H[I * N + J] * X[J];
        Temporary := H[I * N + I] - Diagonal;
        if Abs1(Temporary) < MinPivot then Temporary := MinPivot;
        X[I] := -Sum / Temporary;
        if Abs1(X[I]) > BigValue then
        begin
          C := 1 / Abs1(X[I]);
          for J := I to K do X[J] := C * X[J];
        end;
      end;
      for Row := 0 to N - 1 do
      begin
        Sum := 0;
        for J := 0 to K do Sum := Sum + Z[Row * N + J] * X[J];
        V[Row] := Sum;
      end;
      for Row := 0 to N - 1 do AVectors.FData[Row * N + K] := V[Row];
    end;

    { Undo the balancing (ZGEBAK): the eigenvectors of A are P*D*x. }
    for Row := 0 to N - 1 do
      if Balance[Row] <> 1 then
        for K := 0 to N - 1 do
          AVectors.FData[Row * N + K] :=
            Balance[Row] * AVectors.FData[Row * N + K];
    for I := Length(Swaps) div 2 - 1 downto 0 do
      AVectors.Swap(Swaps[2 * I], Swaps[2 * I + 1]);
  end;

  { Unit 2-norm columns; the largest component is made real and positive. }
  for K := 0 to N - 1 do
  begin
    VectorNorm := 0;
    Largest := 0;
    J := 0;
    for Row := 0 to N - 1 do
    begin
      C := AVectors.FData[Row * N + K].Norm;
      VectorNorm := Hypot(VectorNorm, C);
      if C > Largest then
      begin
        Largest := C;
        J := Row;
      end;
    end;
    if VectorNorm = 0 then Continue;
    Alpha := AVectors.FData[J * N + K].Conjugate / (Largest * VectorNorm);
    for Row := 0 to N - 1 do
      AVectors.FData[Row * N + K] := Alpha * AVectors.FData[Row * N + K];
    { Remove the rounding residue, as LAPACK ZGEEV does. }
    AVectors.FData[J * N + K].fIm := 0;
  end;
end;

procedure TComplexMatrixHelper.HermitianEigenpairs(out AValues: TRealVector;
  out AVectors: TComplexMatrix);
var
  Work, Q: TComplexMatrix;
  D, E, Rows: TArrayOfReal;
  U, W, Phase: TArrayOfComplex;
  Scale, Tolerance, VectorNorm, OffNorm: TReal;
  Alpha, Beta, Value, Projection: TComplex;
  N, I, J, K: longint;
  IsTridiagonal: boolean;
begin
  N := Self.Order;
  if N = 0 then
    raise EDimensionError.Create('Eigenpairs are undefined for an empty matrix.');
  Work := Self.Clone;
  Scale := 0;
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
    begin
      if IsNan(Work[I, J].Re) or IsInfinite(Work[I, J].Re) or
         IsNan(Work[I, J].Im) or IsInfinite(Work[I, J].Im) then
        raise EInvalidOp.Create('Matrix entries must be finite.');
      Scale := Max(Scale, Work[I, J].Norm);
    end;
  Tolerance := 32 * Precision * Scale;
  IsTridiagonal := True;
  for I := 0 to N - 1 do
  begin
    if Abs(Work[I, I].Im) > Tolerance then
      raise EInvalidOp.Create('Matrix must be Hermitian.');
    Work[I, I] := Complex(Work[I, I].Re, 0);
    for J := I + 1 to N - 1 do
    begin
      if (Work[I, J] - Work[J, I].Conjugate).Norm > Tolerance then
        raise EInvalidOp.Create('Matrix must be Hermitian.');
      Value := (Work[I, J] + Work[J, I].Conjugate) / 2;
      Work[I, J] := Value;
      Work[J, I] := Value.Conjugate;
      if (J > I + 1) and (Value.Norm <> 0) then
        IsTridiagonal := False;
    end;
  end;

  Q.Init([]);
  if not IsTridiagonal then
  begin
    Q := Self.Identity;
    SetLength(U, N);
    SetLength(W, N);
    for K := 0 to N - 3 do
    begin
      VectorNorm := 0;
      for I := K + 1 to N - 1 do
        VectorNorm := Hypot(VectorNorm, Work[I, K].Norm);
      if VectorNorm = 0 then Continue;
      OffNorm := Work[K + 1, K].Norm;
      if OffNorm = 0 then
        Alpha := -VectorNorm
      else
        Alpha := -VectorNorm * (Work[K + 1, K] / OffNorm);
      U[K + 1] := Work[K + 1, K] - Alpha;
      for I := K + 2 to N - 1 do U[I] := Work[I, K];
      VectorNorm := 0;
      for I := K + 1 to N - 1 do
        VectorNorm := Hypot(VectorNorm, U[I].Norm);
      for I := K + 1 to N - 1 do U[I] := U[I] / VectorNorm;

      for I := K + 1 to N - 1 do
      begin
        W[I] := 0;
        for J := K + 1 to N - 1 do
          W[I] := W[I] + Work[I, J] * U[J];
        W[I] := 2 * W[I];
      end;
      Beta := 0;
      for I := K + 1 to N - 1 do
        Beta := Beta + U[I].Conjugate * W[I];
      for I := K + 1 to N - 1 do
        W[I] := W[I] - Beta.Re * U[I];
      for I := K + 1 to N - 1 do
        for J := I to N - 1 do
        begin
          Value := Work[I, J] - U[I] * W[J].Conjugate -
            W[I] * U[J].Conjugate;
          if I = J then Value.Im := 0;
          Work[I, J] := Value;
          Work[J, I] := Value.Conjugate;
        end;
      Work[K + 1, K] := Alpha;
      Work[K, K + 1] := Alpha.Conjugate;
      for I := K + 2 to N - 1 do
      begin
        Work[I, K] := 0;
        Work[K, I] := 0;
      end;

      for I := 0 to N - 1 do
      begin
        Projection := 0;
        for J := K + 1 to N - 1 do
          Projection := Projection + Q[I, J] * U[J];
        for J := K + 1 to N - 1 do
          Q[I, J] := Q[I, J] - 2 * Projection * U[J].Conjugate;
      end;
    end;
  end;

  SetLength(D, N);
  SetLength(E, N);
  SetLength(Phase, N);
  Phase[0] := 1;
  for I := 0 to N - 1 do
  begin
    D[I] := Work[I, I].Re;
    if I < N - 1 then
    begin
      OffNorm := Work[I + 1, I].Norm;
      E[I] := OffNorm;
      if OffNorm = 0 then
        Phase[I + 1] := Phase[I]
      else
        Phase[I + 1] := Phase[I] *
          (Work[I + 1, I] / OffNorm);
    end;
  end;
  { The real QL rotations act identically on interleaved real/imaginary
    parts, so they are accumulated directly into Q*diag(Phase), stored by
    columns. }
  SetLength(Rows, 2 * N * N);
  for J := 0 to N - 1 do
    for I := 0 to N - 1 do
    begin
      if IsTridiagonal then
      begin
        if I = J then Value := Phase[J] else Value := 0;
      end else
        Value := Q[I, J] * Phase[J];
      Rows[2 * (J * N + I)] := Value.Re;
      Rows[2 * (J * N + I) + 1] := Value.Im;
    end;
  TridiagonalQL(D, E, Rows, 2 * N);
  AValues.Init(D);
  AVectors.SetOrder(N);
  for I := 0 to N - 1 do
    for J := 0 to N - 1 do
      AVectors[I, J] := Complex(Rows[2 * (J * N + I)],
        Rows[2 * (J * N + I) + 1]);
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

function SolveEquation(const a: TReal): TReal;
begin
  result := -a;
end;

function SolveEquation(const a: TComplex): TComplex;
begin
  result := -a;
end;

{ Returns a power of two s such that the monic polynomial with coefficients
  ACoefficients[k]/s^(k+1) has coefficients of order one. Power-of-two
  scaling is exact unless the values underflow or overflow. }
function PolynomialScale(const ACoefficients: array of TComplex): TReal;
var
  LIndex: longint;
  LBound: TReal;
begin
  LBound := 0;
  for LIndex := 0 to High(ACoefficients) do
    if ACoefficients[LIndex].Norm > 0 then
      LBound := Max(LBound,
        Power(ACoefficients[LIndex].Norm, 1 / (LIndex + 1)));
  if LBound = 0 then Exit(0);
  result := IntPower(2, Math.Ceil(Math.Log2(LBound)));
end;

{ Coefficients of y^n + c[0]*y^(n-1) + ... + c[n-1] after x = s*y. }
procedure ScalePolynomial(const ACoefficients: array of TComplex;
  AScale: TReal; out AScaled: TArrayOfComplex);
var
  LIndex, LPower: longint;
begin
  AScaled := nil;
  SetLength(AScaled, Length(ACoefficients));
  for LIndex := 0 to High(ACoefficients) do
  begin
    AScaled[LIndex] := ACoefficients[LIndex];
    for LPower := 0 to LIndex do
      AScaled[LIndex] := AScaled[LIndex] / AScale;
  end;
end;

{ Horner evaluation of the monic polynomial and of its derivative. }
procedure EvaluatePolynomial(const ACoefficients: TArrayOfComplex;
  const AX: TComplex; out AValue, ADerivative: TComplex);
var
  LIndex: longint;
begin
  AValue := 1;
  ADerivative := 0;
  for LIndex := 0 to High(ACoefficients) do
  begin
    ADerivative := ADerivative * AX + AValue;
    AValue := AValue * AX + ACoefficients[LIndex];
  end;
end;

{ Refines all roots together with Ehrlich-Aberth corrections. A correction
  is accepted only when it lowers the residual, so a root never drifts to a
  neighbour and multiple roots are left at their closed-form values. }
procedure PolishRoots(const ACoefficients: TArrayOfComplex;
  var ARoots: TArrayOfComplex);
const
  MaxSweeps = 8;
var
  LValue, LDerivative, LNewton, LSum, LCandidate, LNewValue,
    LDifference, LDenominator: TComplex;
  LSweep, LIndex, LOther: longint;
  LChanged, LSkip: boolean;
begin
  for LSweep := 1 to MaxSweeps do
  begin
    LChanged := False;
    for LIndex := 0 to High(ARoots) do
    begin
      EvaluatePolynomial(ACoefficients, ARoots[LIndex], LValue, LDerivative);
      if (LValue.Norm = 0) or (LDerivative.Norm = 0) then Continue;
      LNewton := LValue / LDerivative;
      LSum := 0;
      LSkip := False;
      for LOther := 0 to High(ARoots) do
        if LOther <> LIndex then
        begin
          LDifference := ARoots[LIndex] - ARoots[LOther];
          if LDifference.Norm = 0 then
          begin
            LSkip := True;
            Break;
          end;
          LSum := LSum + LDifference.Reciprocal;
        end;
      if LSkip then Continue;
      LDenominator := 1 - LNewton * LSum;
      if LDenominator.Norm = 0 then Continue;
      LCandidate := ARoots[LIndex] - LNewton / LDenominator;
      if LCandidate = ARoots[LIndex] then Continue;
      EvaluatePolynomial(ACoefficients, LCandidate, LNewValue, LDerivative);
      if LNewValue.Norm < LValue.Norm then
      begin
        ARoots[LIndex] := LCandidate;
        LChanged := True;
      end;
    end;
    if not LChanged then Break;
  end;
end;

function SolveEquation(const a, b: TComplex): TArrayOfComplex;
var
  LScale: TReal;
  LScaled: TArrayOfComplex;
  LRoot, LLarge: TComplex;
begin
  result := nil;
  SetLength(result, 2);
  LScale := PolynomialScale([a, b]);
  if LScale = 0 then
  begin
    result[0] := 0;
    result[1] := 0;
    Exit;
  end;
  ScalePolynomial([a, b], LScale, LScaled);
  LRoot := SquareRoot(SquarePower(LScaled[0]) - 4 * LScaled[1])[0];
  { The larger root is formed from two terms that do not cancel; the
    smaller one follows from the product of the roots, using the unscaled b
    so that it cannot underflow. result[0] is still the root associated
    with +sqrt(discriminant). }
  if LScaled[0].fRe * LRoot.fRe + LScaled[0].fIm * LRoot.fIm >= 0 then
  begin
    LLarge := LScale * (-(LScaled[0] + LRoot) / 2);
    result[1] := LLarge;
    result[0] := b / LLarge;
  end else
  begin
    LLarge := LScale * ((LRoot - LScaled[0]) / 2);
    result[0] := LLarge;
    result[1] := b / LLarge;
  end;
end;

{ Newton iterations on one root, keeping only steps that lower the
  residual. }
procedure PolishRoot(const ACoefficients: TArrayOfComplex; var ARoot: TComplex);
const
  MaxSteps = 8;
var
  LValue, LDerivative, LCandidate, LNewValue, LNewDerivative: TComplex;
  LStep: longint;
begin
  EvaluatePolynomial(ACoefficients, ARoot, LValue, LDerivative);
  for LStep := 1 to MaxSteps do
  begin
    if (LValue.Norm = 0) or (LDerivative.Norm = 0) then Exit;
    LCandidate := ARoot - LValue / LDerivative;
    if LCandidate = ARoot then Exit;
    EvaluatePolynomial(ACoefficients, LCandidate, LNewValue, LNewDerivative);
    if LNewValue.Norm >= LValue.Norm then Exit;
    ARoot := LCandidate;
    LValue := LNewValue;
    LDerivative := LNewDerivative;
  end;
end;

{ Index of the element of largest modulus. }
function LargestRoot(const ARoots: TArrayOfComplex): longint;
var
  LIndex: longint;
begin
  result := 0;
  for LIndex := 1 to High(ARoots) do
    if ARoots[LIndex].Norm > ARoots[result].Norm then result := LIndex;
end;

{ Roots of the scaled monic cubic y^3 + c[0]*y^2 + c[1]*y + c[2]. The
  closed form only supplies the largest root, which it determines to full
  relative accuracy after Newton polishing; that root is removed by
  backward deflation, stable for the root of largest modulus
  (G. Peters, J. H. Wilkinson, J. Inst. Maths Applics 8, 1971), and the
  remaining quadratic is solved with the stable formula. }
function ScaledCubicRoots(const AScaled: TArrayOfComplex): TArrayOfComplex;
var
  LShift, p, q, LRoot, LCube, LLargest, LBeta, LAlpha: TComplex;
  LCubeRoots, LPair: TArrayOfComplex;
  LIndex: longint;
begin
  result := nil;
  SetLength(result, 3);
  if (AScaled[2].fRe = 0) and (AScaled[2].fIm = 0) then
  begin
    { An exact zero root. }
    LPair := SolveEquation(AScaled[0], AScaled[1]);
    result[0] := LPair[0];
    result[1] := LPair[1];
    result[2] := 0;
    Exit;
  end;
  { Depressed cubic t^3 + p*t + q = 0 with y = t - a/3. }
  LShift := AScaled[0] / 3;
  p := AScaled[1] - AScaled[0] * LShift;
  q := (2 * LShift * LShift - AScaled[1]) * LShift + AScaled[2];
  { Cardano: choose the sign that gives the larger u^3 to avoid
    cancellation. u^3 = 0 only when p = q = 0. }
  LRoot := SquareRoot(SquarePower(q / 2) + CubicPower(p / 3))[0];
  if q.fRe * LRoot.fRe + q.fIm * LRoot.fIm >= 0 then
    LCube := -(q / 2 + LRoot)
  else
    LCube := LRoot - q / 2;
  if LCube.Norm = 0 then
  begin
    for LIndex := 0 to 2 do result[LIndex] := -LShift;
    Exit;
  end;
  LCubeRoots := CubicRoot(LCube);
  for LIndex := 0 to 2 do
    result[LIndex] := LCubeRoots[LIndex] -
      p / (3 * LCubeRoots[LIndex]) - LShift;
  LLargest := result[LargestRoot(result)];
  PolishRoot(AScaled, LLargest);
  { y^3 + a*y^2 + b*y + c = (y - r)(y^2 + alpha*y + beta). }
  LBeta := -AScaled[2] / LLargest;
  LAlpha := (LBeta - AScaled[1]) / LLargest;
  LPair := SolveEquation(LAlpha, LBeta);
  result[0] := LLargest;
  result[1] := LPair[0];
  result[2] := LPair[1];
end;

function SolveEquation(const a, b, c: TComplex): TArrayOfComplex;
var
  LScale: TReal;
  LScaled: TArrayOfComplex;
  LIndex: longint;
begin
  result := nil;
  SetLength(result, 3);
  LScale := PolynomialScale([a, b, c]);
  if LScale = 0 then
  begin
    for LIndex := 0 to 2 do result[LIndex] := 0;
    Exit;
  end;
  ScalePolynomial([a, b, c], LScale, LScaled);
  result := ScaledCubicRoots(LScaled);
  PolishRoots(LScaled, result);
  for LIndex := 0 to 2 do result[LIndex] := LScale * result[LIndex];
end;

function SolveEquation(const a, b, c, d: TComplex): TArrayOfComplex;
var
  LScale, LBest: TReal;
  LScaled, LResolvent, LPair, LCubic, LApproximations: TArrayOfComplex;
  LShift, p, q, r, m, s, LTerm, LLargest, LAlpha, LBeta, LGamma: TComplex;
  LIndex: longint;
begin
  result := nil;
  SetLength(result, 4);
  LScale := PolynomialScale([a, b, c, d]);
  if LScale = 0 then
  begin
    for LIndex := 0 to 3 do result[LIndex] := 0;
    Exit;
  end;
  ScalePolynomial([a, b, c, d], LScale, LScaled);
  if (LScaled[3].fRe = 0) and (LScaled[3].fIm = 0) then
  begin
    { An exact zero root. }
    LCubic := ScaledCubicRoots([LScaled[0], LScaled[1], LScaled[2]]);
    for LIndex := 0 to 2 do result[LIndex] := LCubic[LIndex];
    result[3] := 0;
  end else
  begin
    { Depressed quartic z^4 + p*z^2 + q*z + r = 0 with y = z - a/4. }
    LShift := LScaled[0] / 4;
    p := LScaled[1] - 6 * LShift * LShift;
    q := LScaled[2] - 2 * LScaled[1] * LShift + 8 * CubicPower(LShift);
    r := LScaled[3] - LScaled[2] * LShift + LScaled[1] * LShift * LShift -
      3 * QuarticPower(LShift);
    { Ferrari: (z^2 + m)^2 = (2m - p)*(z - q/(2*(2m - p)))^2, where m solves
      the resolvent cubic. The root with the largest |2m - p| is the best
      conditioned choice for the division by s = sqrt(2m - p). }
    LResolvent := SolveEquation(-p / 2, -r, p * r / 2 - q * q / 8);
    m := LResolvent[0];
    LBest := (2 * m - p).Norm;
    for LIndex := 1 to 2 do
      if (2 * LResolvent[LIndex] - p).Norm > LBest then
      begin
        m := LResolvent[LIndex];
        LBest := (2 * m - p).Norm;
      end;
    SetLength(LApproximations, 4);
    if LBest <= 16 * Precision * Max(p.Norm, 2 * m.Norm) then
    begin
      { Biquadratic: z^4 + p*z^2 + r = 0. }
      LPair := SolveEquation(p, r);
      LApproximations[0] := SquareRoot(LPair[0])[0];
      LApproximations[1] := -LApproximations[0];
      LApproximations[2] := SquareRoot(LPair[1])[0];
      LApproximations[3] := -LApproximations[2];
    end else
    begin
      s := SquareRoot(2 * m - p)[0];
      LTerm := q / (2 * s);
      LPair := SolveEquation(-s, m + LTerm);
      LApproximations[0] := LPair[0];
      LApproximations[1] := LPair[1];
      LPair := SolveEquation(s, m - LTerm);
      LApproximations[2] := LPair[0];
      LApproximations[3] := LPair[1];
    end;
    for LIndex := 0 to 3 do
      LApproximations[LIndex] := LApproximations[LIndex] - LShift;
    { As for the cubic, keep the largest root and deflate:
      y^4 + a*y^3 + b*y^2 + c*y + d = (y - r)(y^3 + alpha*y^2 + beta*y + gamma). }
    LLargest := LApproximations[LargestRoot(LApproximations)];
    PolishRoot(LScaled, LLargest);
    LGamma := -LScaled[3] / LLargest;
    LBeta := (LGamma - LScaled[2]) / LLargest;
    LAlpha := (LBeta - LScaled[1]) / LLargest;
    LCubic := SolveEquation(LAlpha, LBeta, LGamma);
    result[0] := LLargest;
    for LIndex := 0 to 2 do result[LIndex + 1] := LCubic[LIndex];
  end;
  PolishRoots(LScaled, result);
  for LIndex := 0 to 3 do result[LIndex] := LScale * result[LIndex];
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
