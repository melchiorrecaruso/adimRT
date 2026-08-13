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

    { Returns @true if the complex number is zero, i.e. both @code(Re = 0) and @code(Im = 0). }
    function IsNull: boolean;

    { Returns @true if the complex number is not zero,
      i.e. at least one of @code(Re) or @code(Im) is non-zero.
    }
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
      @link(DefaultEpsilon) in both components. }
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
  private
    FData: array of T;
    FOrder: longint;
    function Get(ARow, ACol: longint): T; inline;
    procedure Put(ARow, ACol: longint; const AValue: T); inline;
    procedure RequireSameOrder(const AMatrix: TMatrix); inline;
    procedure SetOrder(AOrder: longint);
    function ForwardElimination(out ASwapCount: integer): TMatrix;
    function Multiply(const AMatrix: TMatrix): TMatrix;
  public
    procedure Init(const AValues: array of T);
    function Order: longint; inline;
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
    function Eigenvalues: TComplexVector;
    function Eigenvectors(const AEigenvalues: TComplexVector): TComplexMatrix;
  end;

  TComplexMatrixHelper = type helper for TComplexMatrix
  private
    function HessenbergReduction: TComplexMatrix;
    function HouseholderVector(AColumn: longint): TComplexVector;
  public
    function Conjugate: TComplexMatrix;
    function Eigenvalues: TComplexVector;
    function Eigenvectors(const AEigenvalues: TComplexVector): TComplexMatrix;
    function IsUnitary: boolean;
    function TransposeConjugate: TComplexMatrix;
  end;


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
var
  LRatio, LDenominator: TReal;
begin
  if (fRe = 0) and (fIm = 0) then
    raise EZeroDivide.Create('TComplex.Reciprocal: division by zero.');

  if System.Abs(fRe) >= System.Abs(fIm) then
  begin
    LRatio := fIm / fRe;
    LDenominator := fRe + fIm * LRatio;
    result.fRe := 1 / LDenominator;
    result.fIm := -LRatio / LDenominator;
  end else
  begin
    LRatio := fRe / fIm;
    LDenominator := fIm + fRe * LRatio;
    result.fRe := LRatio / LDenominator;
    result.fIm := -1 / LDenominator;
  end;
end;

function TComplex.ToString: string;
var
  sign: array[boolean] of string = ('+', '-');
begin
  if (not SameValueEx(fRe, 0)) and (not SameValueEx(fIm, 0)) then
  begin
    if SameValueEx(System.Abs(fIm), 1) then
      result := Format('%s %si', [FloatToStr(fRe), sign[fIm < 0]])
    else
      result := Format('%s %s%s∙i', [FloatToStr(fRe), sign[fIm < 0], FloatToStr(System.Abs(fIm))]);
  end else
    if not SameValueEx(fRe, 0) then
      result := FloatToStr(fRe)
    else
      if not SameValueEx(fIm, 0) then
      begin
        if SameValueEx(fIm, 1) then result := 'i'
        else if SameValueEx(fIm, -1) then result := '-i'
        else result := Format('%s∙i', [FloatToStr(fIm)])
      end else
        result := '0';
end;

function TComplex.ToString(APrecision, ADigits: integer): string;
var
  sign: array[boolean] of string = ('+', '-');
begin
  if (not SameValueEx(fRe, 0)) and (not SameValueEx(fIm, 0)) then
  begin
    if SameValueEx(System.Abs(fIm), 1) then
      result := Format('%s %si', [SysUtils.FloatToStrF(fRe, ffGeneral, APrecision, ADigits), sign[fIm < 0]])
    else
      result := Format('%s %s%s∙i', [
        SysUtils.FloatToStrF(fRe,             ffGeneral, APrecision, ADigits), sign[fIm < 0],
        SysUtils.FloatToStrF(System.Abs(fIm), ffGeneral, APrecision, ADigits)]);
  end else
    if not SameValueEx(fRe, 0) then
      result := SysUtils.FloatToStrF(fRe, ffGeneral, APrecision, ADigits)
    else
      if not SameValueEx(fIm, 0) then
      begin
        if SameValueEx(fIm, 1) then result := 'i'
        else if SameValueEx(fIm, -1) then result := '-i'
        else result := Format('%s∙i', [SysUtils.FloatToStrF(fIm, ffGeneral, APrecision, ADigits)])
      end else
        result := '0';
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
  result := ALeft * ARight.Reciprocal;
end;

class operator TComplex./(const ALeft: TReal; const ARight: TComplex): TComplex;
begin
  result := ALeft * ARight.Reciprocal;
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
begin
  RequireSameSize(AVector);
  if Size = 0 then
    raise EDimensionError.Create('Dot product is undefined for empty vectors.');
  result := FData[0] * AVector.FData[0];
  for LIndex := 1 to Size - 1 do
    result := result + FData[LIndex] * AVector.FData[LIndex];
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
begin
  result := 0;
  for LIndex := 0 to Size - 1 do
    result := Math.Hypot(result, Abs(FData[LIndex]));
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

function TMatrix.ForwardElimination(out ASwapCount: integer): TMatrix;
var
  LPivot, LRatio: T;
  LMaxValue: TReal;
  LRow, LCol, LIndex, LMaxRow: longint;
begin
  result := Clone;
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
      LRatio := result[LRow, LCol] / LPivot;
      result[LRow, LCol] := 0;
      for LIndex := LCol + 1 to FOrder - 1 do
        result[LRow, LIndex] := result[LRow, LIndex] -
          LRatio * result[LCol, LIndex];
    end;
  end;
end;

function TComplexMatrixHelper.HouseholderVector(
  AColumn: longint): TComplexVector;
var
  LIndex: longint;
  LNorm, LVectorNorm, LFirstNorm: TReal;
  LPhase, LAlpha: TComplex;
begin
  result.SetSize(Self.FOrder);
  LNorm := 0;
  for LIndex := AColumn + 1 to Self.FOrder - 1 do
  begin
    result[LIndex] := Self[LIndex, AColumn];
    LNorm := Math.Hypot(LNorm, Abs(result[LIndex]));
  end;
  if LNorm < DefaultEpsilon then Exit;
  LFirstNorm := Abs(result[AColumn + 1]);
  if LFirstNorm < DefaultEpsilon then
    LPhase := 1
  else
    LPhase := result[AColumn + 1] / LFirstNorm;
  LAlpha := -LPhase * LNorm;
  result[AColumn + 1] := result[AColumn + 1] - LAlpha;
  LVectorNorm := 0;
  for LIndex := AColumn + 1 to Self.FOrder - 1 do
    LVectorNorm := Math.Hypot(LVectorNorm, Abs(result[LIndex]));
  if LVectorNorm < DefaultEpsilon then Exit;
  for LIndex := AColumn + 1 to Self.FOrder - 1 do
    result[LIndex] := result[LIndex] / LVectorNorm;
end;

function TComplexMatrixHelper.HessenbergReduction: TComplexMatrix;
var
  LVector: TComplexVector;
  LColumn, LRow, LIndex: longint;
  LDot: TComplex;
begin
  result := Self.Clone;
  for LColumn := 0 to Self.FOrder - 3 do
  begin
    LVector := result.HouseholderVector(LColumn);
    if LVector.IsNull then Continue;
    for LIndex := 0 to Self.FOrder - 1 do
    begin
      LDot := LVector[LColumn + 1].Conjugate *
        result[LColumn + 1, LIndex];
      for LRow := LColumn + 2 to Self.FOrder - 1 do
        LDot := LDot + LVector[LRow].Conjugate *
          result[LRow, LIndex];
      for LRow := LColumn + 1 to Self.FOrder - 1 do
        result[LRow, LIndex] := result[LRow, LIndex] -
          2 * LVector[LRow] * LDot;
    end;
    for LRow := 0 to Self.FOrder - 1 do
    begin
      LDot := result[LRow, LColumn + 1] * LVector[LColumn + 1];
      for LIndex := LColumn + 2 to Self.FOrder - 1 do
        LDot := LDot + result[LRow, LIndex] * LVector[LIndex];
      for LIndex := LColumn + 1 to Self.FOrder - 1 do
        result[LRow, LIndex] := result[LRow, LIndex] -
          2 * LDot * LVector[LIndex].Conjugate;
    end;
    for LRow := LColumn + 2 to Self.FOrder - 1 do
      result[LRow, LColumn] := 0;
  end;
end;

function TMatrix.SolveLinear(const AData: TVectorType): TVectorType;
var
  LWork: TMatrix;
  LData: TVectorType;
  LFactor, LValue, LTemp: T;
  LMaxValue: TReal;
  LRow, LCol, LIndex, LMaxRow: longint;
begin
  if AData.Size <> FOrder then
    raise EDimensionError.CreateFmt(
      'Matrix order %d and vector dimension %d are incompatible.',
      [FOrder, AData.Size]);
  LWork := Clone;
  LData := AData;
  result.SetSize(FOrder);
  for LCol := 0 to FOrder - 1 do
  begin
    LMaxRow := LCol;
    LMaxValue := Abs(LWork[LCol, LCol]);
    for LRow := LCol + 1 to FOrder - 1 do
      if Abs(LWork[LRow, LCol]) > LMaxValue then
      begin
        LMaxValue := Abs(LWork[LRow, LCol]);
        LMaxRow := LRow;
      end;
    if LMaxValue = 0 then
      raise EZeroDivide.Create('Matrix is singular.');
    if LMaxRow <> LCol then
    begin
      LWork.Swap(LCol, LMaxRow);
      LTemp := LData[LCol];
      LData[LCol] := LData[LMaxRow];
      LData[LMaxRow] := LTemp;
    end;
    for LRow := LCol + 1 to FOrder - 1 do
    begin
      LFactor := LWork[LRow, LCol] / LWork[LCol, LCol];
      if Abs(LFactor) = 0 then Continue;
      for LIndex := LCol to FOrder - 1 do
        LWork[LRow, LIndex] := LWork[LRow, LIndex] -
          LFactor * LWork[LCol, LIndex];
      LData[LRow] := LData[LRow] - LFactor * LData[LCol];
    end;
  end;
  for LRow := FOrder - 1 downto 0 do
  begin
    LValue := LData[LRow];
    for LIndex := LRow + 1 to FOrder - 1 do
      LValue := LValue - LWork[LRow, LIndex] * result[LIndex];
    result[LRow] := LValue / LWork[LRow, LRow];
  end;
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
  LSwapCount, LIndex: longint;
begin
  if FOrder = 0 then
    raise EDimensionError.Create('Determinant is undefined for an empty matrix.');
  LUpper := ForwardElimination(LSwapCount);
  result := LUpper[0, 0];
  for LIndex := 1 to FOrder - 1 do
    result := result * LUpper[LIndex, LIndex];
  if Odd(LSwapCount) then result := -result;
end;

function TMatrix.Norm: TReal;
var
  LIndex: longint;
begin
  result := 0;
  for LIndex := 0 to High(FData) do
    result := Math.Hypot(result, Abs(FData[LIndex]));
end;

function TMatrix.Rank: longint;
var
  LWork: TMatrix;
  LPivot, LFactor: T;
  LMaxValue: TReal;
  LPivotRow, LColumn, LRow, LIndex, LMaxRow: longint;
begin
  LWork := Clone;
  LPivotRow := 0;
  result := 0;
  for LColumn := 0 to FOrder - 1 do
  begin
    if LPivotRow >= FOrder then Break;
    LMaxRow := LPivotRow;
    LMaxValue := Abs(LWork[LPivotRow, LColumn]);
    for LRow := LPivotRow + 1 to FOrder - 1 do
      if Abs(LWork[LRow, LColumn]) > LMaxValue then
      begin
        LMaxValue := Abs(LWork[LRow, LColumn]);
        LMaxRow := LRow;
      end;
    if LMaxValue <= DefaultEpsilon then Continue;
    if LMaxRow <> LPivotRow then LWork.Swap(LPivotRow, LMaxRow);
    LPivot := LWork[LPivotRow, LColumn];
    for LRow := LPivotRow + 1 to FOrder - 1 do
    begin
      if Abs(LWork[LRow, LColumn]) <= DefaultEpsilon then Continue;
      LFactor := LWork[LRow, LColumn] / LPivot;
      LWork[LRow, LColumn] := 0;
      for LIndex := LColumn + 1 to FOrder - 1 do
        LWork[LRow, LIndex] := LWork[LRow, LIndex] -
          LFactor * LWork[LPivotRow, LIndex];
    end;
    Inc(result);
    Inc(LPivotRow);
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
  LWork: TMatrix;
  LPivot, LFactor: T;
  LMaxValue: TReal;
  LColumn, LRow, LIndex, LMaxRow: longint;
begin
  LWork := Clone;
  result := Identity;
  for LColumn := 0 to FOrder - 1 do
  begin
    LMaxRow := LColumn;
    LMaxValue := Abs(LWork[LColumn, LColumn]);
    for LRow := LColumn + 1 to FOrder - 1 do
      if Abs(LWork[LRow, LColumn]) > LMaxValue then
      begin
        LMaxValue := Abs(LWork[LRow, LColumn]);
        LMaxRow := LRow;
      end;
    if LMaxValue = 0 then
      raise EZeroDivide.Create('Matrix is singular.');
    if LMaxRow <> LColumn then
    begin
      LWork.Swap(LColumn, LMaxRow);
      result.Swap(LColumn, LMaxRow);
    end;
    LPivot := LWork[LColumn, LColumn];
    for LIndex := 0 to FOrder - 1 do
    begin
      LWork[LColumn, LIndex] := LWork[LColumn, LIndex] / LPivot;
      result[LColumn, LIndex] := result[LColumn, LIndex] / LPivot;
    end;
    for LRow := 0 to FOrder - 1 do
    begin
      if LRow = LColumn then Continue;
      LFactor := LWork[LRow, LColumn];
      if Abs(LFactor) = 0 then Continue;
      for LIndex := 0 to FOrder - 1 do
      begin
        LWork[LRow, LIndex] := LWork[LRow, LIndex] -
          LFactor * LWork[LColumn, LIndex];
        result[LRow, LIndex] := result[LRow, LIndex] -
          LFactor * result[LColumn, LIndex];
      end;
    end;
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

function TMatrix.Multiply(const AMatrix: TMatrix): TMatrix;
var
  LRow, LCol, LIndex, LLeftOffset, LResultOffset: longint;
  LValue: T;
begin
  RequireSameOrder(AMatrix);
  result.SetOrder(FOrder);
  if FOrder = 0 then Exit;
  for LRow := 0 to FOrder - 1 do
  begin
    LLeftOffset := LRow * FOrder;
    LResultOffset := LLeftOffset;
    for LCol := 0 to FOrder - 1 do
    begin
      LValue := FData[LLeftOffset] * AMatrix.FData[LCol];
      for LIndex := 1 to FOrder - 1 do
        LValue := LValue + FData[LLeftOffset + LIndex] *
          AMatrix.FData[LIndex * FOrder + LCol];
      result.FData[LResultOffset + LCol] := LValue;
    end;
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
  LRow, LCol: longint;
  LValue: T;
begin
  if ALeft.Size <> ARight.FOrder then
    raise EDimensionError.CreateFmt(
      'Vector dimension %d and matrix order %d are incompatible.',
      [ALeft.Size, ARight.FOrder]);
  result.SetSize(ARight.FOrder);
  if ARight.FOrder = 0 then Exit;
  for LCol := 0 to ARight.FOrder - 1 do
  begin
    LValue := ALeft[0] * ARight[0, LCol];
    for LRow := 1 to ARight.FOrder - 1 do
      LValue := LValue + ALeft[LRow] * ARight[LRow, LCol];
    result[LCol] := LValue;
  end;
end;

class operator TMatrix.*(const ALeft: TMatrix;
  const ARight: TVectorType): TVectorType;
var
  LRow, LCol, LOffset: longint;
  LValue: T;
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
    for LCol := 1 to ALeft.FOrder - 1 do
      LValue := LValue + ALeft.FData[LOffset + LCol] * ARight[LCol];
    result[LRow] := LValue;
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

function TRealMatrixHelper.Eigenvalues: TComplexVector;
begin
  result := ToComplex.Eigenvalues;
end;

function TRealMatrixHelper.Eigenvectors(
  const AEigenvalues: TComplexVector): TComplexMatrix;
begin
  result := ToComplex.Eigenvectors(AEigenvalues);
end;

function TComplexMatrixHelper.Eigenvalues: TComplexVector;
const
  MaxIter = 2000;
var
  LHessenberg, LShifted, LQ, LR: TComplexMatrix;
  LPair: TArrayOfComplex;
  LShift: TComplex;
  LTolerance, LRadius: TReal;
  LIndex, LLow, LRow, LCol, LIteration: longint;
  LConverged: boolean;

  procedure QRDecompose(const AMatrix: TComplexMatrix;
    ALow, AHigh: longint; out AQ, AR: TComplexMatrix);
  var
    LRowIndex, LColIndex, LK: longint;
    LCosine, LSine, LDiagonal, LSubDiagonal, LValue0, LValue1: TComplex;
  begin
    AQ := AMatrix.Identity;
    AR := AMatrix.Clone;
    for LColIndex := ALow to AHigh - 1 do
    begin
      LDiagonal := AR[LColIndex, LColIndex];
      LSubDiagonal := AR[LColIndex + 1, LColIndex];
      LRadius := Hypot(LDiagonal.Norm, LSubDiagonal.Norm);
      if LRadius <= DefaultEpsilon then
      begin
        LCosine := 1;
        LSine := 0;
      end else
      begin
        LCosine := LDiagonal.Conjugate / LRadius;
        LSine := LSubDiagonal.Conjugate / LRadius;
      end;
      for LK := LColIndex to AHigh do
      begin
        LValue0 := LCosine * AR[LColIndex, LK] +
          LSine * AR[LColIndex + 1, LK];
        LValue1 := -LSine.Conjugate * AR[LColIndex, LK] +
          LCosine.Conjugate * AR[LColIndex + 1, LK];
        AR[LColIndex, LK] := LValue0;
        AR[LColIndex + 1, LK] := LValue1;
      end;
      for LRowIndex := ALow to AHigh do
      begin
        LValue0 := AQ[LRowIndex, LColIndex];
        LValue1 := AQ[LRowIndex, LColIndex + 1];
        AQ[LRowIndex, LColIndex] :=
          LCosine.Conjugate * LValue0 + LSine.Conjugate * LValue1;
        AQ[LRowIndex, LColIndex + 1] :=
          -LSine * LValue0 + LCosine * LValue1;
      end;
    end;
  end;

begin
  result.SetSize(Self.FOrder);
  LHessenberg := Self.HessenbergReduction;
  LIndex := Self.FOrder - 1;
  while LIndex >= 0 do
  begin
    if LIndex = 0 then
    begin
      result[0] := LHessenberg[0, 0];
      Break;
    end;
    LTolerance := DefaultEpsilon *
      (LHessenberg[LIndex - 1, LIndex - 1].Norm +
       LHessenberg[LIndex, LIndex].Norm + 1);
    if LHessenberg[LIndex, LIndex - 1].Norm <= LTolerance then
    begin
      LHessenberg[LIndex, LIndex - 1] := 0;
      result[LIndex] := LHessenberg[LIndex, LIndex];
      Dec(LIndex);
      Continue;
    end;
    LLow := LIndex - 1;
    while LLow > 0 do
    begin
      LTolerance := DefaultEpsilon *
        (LHessenberg[LLow - 1, LLow - 1].Norm +
         LHessenberg[LLow, LLow].Norm + 1);
      if LHessenberg[LLow, LLow - 1].Norm <= LTolerance then
      begin
        LHessenberg[LLow, LLow - 1] := 0;
        Break;
      end;
      Dec(LLow);
    end;
    if LIndex - LLow = 1 then
    begin
      LPair := SolveEquation(
        -(LHessenberg[LLow, LLow] + LHessenberg[LIndex, LIndex]),
         LHessenberg[LLow, LLow] * LHessenberg[LIndex, LIndex] -
         LHessenberg[LLow, LIndex] * LHessenberg[LIndex, LLow]);
      result[LLow] := LPair[0];
      result[LIndex] := LPair[1];
      LIndex := LLow - 1;
      Continue;
    end;
    LConverged := False;
    for LIteration := 1 to MaxIter do
    begin
      LPair := SolveEquation(
        -(LHessenberg[LIndex - 1, LIndex - 1] +
          LHessenberg[LIndex, LIndex]),
         LHessenberg[LIndex - 1, LIndex - 1] *
         LHessenberg[LIndex, LIndex] -
         LHessenberg[LIndex - 1, LIndex] *
         LHessenberg[LIndex, LIndex - 1]);
      if (LPair[0] - LHessenberg[LIndex, LIndex]).Norm <=
         (LPair[1] - LHessenberg[LIndex, LIndex]).Norm then
        LShift := LPair[0]
      else
        LShift := LPair[1];
      LShifted := LHessenberg.Clone;
      for LRow := LLow to LIndex do
        LShifted[LRow, LRow] := LShifted[LRow, LRow] - LShift;
      QRDecompose(LShifted, LLow, LIndex, LQ, LR);
      LShifted := LR * LQ;
      for LRow := LLow to LIndex do
        LShifted[LRow, LRow] := LShifted[LRow, LRow] + LShift;
      for LRow := LLow to LIndex do
        for LCol := LLow to LIndex do
          LHessenberg[LRow, LCol] := LShifted[LRow, LCol];
      for LRow := LLow + 2 to LIndex do
        for LCol := LLow to LRow - 2 do
          if LHessenberg[LRow, LCol].Norm <= DefaultEpsilon then
            LHessenberg[LRow, LCol] := 0;
      LTolerance := DefaultEpsilon *
        (LHessenberg[LIndex - 1, LIndex - 1].Norm +
         LHessenberg[LIndex, LIndex].Norm + 1);
      if LHessenberg[LIndex, LIndex - 1].Norm <= LTolerance then
      begin
        LConverged := True;
        Break;
      end;
    end;
    if LConverged then
    begin
      LHessenberg[LIndex, LIndex - 1] := 0;
      result[LIndex] := LHessenberg[LIndex, LIndex];
      Dec(LIndex);
    end else
    begin
      LPair := SolveEquation(
        -(LHessenberg[LIndex - 1, LIndex - 1] +
          LHessenberg[LIndex, LIndex]),
         LHessenberg[LIndex - 1, LIndex - 1] *
         LHessenberg[LIndex, LIndex] -
         LHessenberg[LIndex - 1, LIndex] *
         LHessenberg[LIndex, LIndex - 1]);
      result[LIndex - 1] := LPair[0];
      result[LIndex] := LPair[1];
      Dec(LIndex, 2);
    end;
  end;
end;

function TComplexMatrixHelper.Eigenvectors(
  const AEigenvalues: TComplexVector): TComplexMatrix;
var
  LMatrix: TComplexMatrix;
  LVector, LWork: TComplexVector;
  LEigenvalue, LShift, LProjection, LPhase: TComplex;
  LRow, LColumn, LPrevious, LAttempt, LPass, LPhaseIndex: longint;
  LDelta, LScale, LClusterTolerance, LPhaseNorm, LMaxNorm: TReal;
  LSeed: longword;
  LSolved: boolean;

  function NextRandom: TReal;
  begin
    {$push}{$R-}{$Q-}
    LSeed := LSeed * 1664525 + 1013904223;
    {$pop}
    result := (LSeed / 4294967295.0) * 2 - 1;
  end;

begin
  if AEigenvalues.Size <> Self.FOrder then
    raise EDimensionError.CreateFmt(
      'Matrix order %d and eigenvalue count %d are incompatible.',
      [Self.FOrder, AEigenvalues.Size]);
  result.SetOrder(Self.FOrder);
  LVector.SetSize(Self.FOrder);
  LScale := Self.Norm;
  LSeed := 123456789;
  for LColumn := 0 to Self.FOrder - 1 do
  begin
    LEigenvalue := AEigenvalues[LColumn];
    for LRow := 0 to Self.FOrder - 1 do
      LVector[LRow] := Complex(NextRandom, NextRandom);
    LVector := LVector.Normalize;
    LDelta := 0;
    LSolved := False;
    for LAttempt := 1 to 6 do
    begin
      LShift := LEigenvalue + LDelta;
      LMatrix := Self.Clone;
      for LRow := 0 to Self.FOrder - 1 do
        LMatrix[LRow, LRow] := LMatrix[LRow, LRow] - LShift;
      try
        for LPass := 1 to 3 do
        begin
          LWork := LMatrix.SolveLinear(LVector);
          for LPrevious := 0 to LColumn - 1 do
          begin
            LClusterTolerance := 100 * DefaultEpsilon *
              (AEigenvalues[LPrevious].Norm + LEigenvalue.Norm + 1);
            if (AEigenvalues[LPrevious] - LEigenvalue).Norm <=
              LClusterTolerance then
            begin
              LProjection := result[0, LPrevious].Conjugate * LWork[0];
              for LRow := 1 to Self.FOrder - 1 do
                LProjection := LProjection +
                  result[LRow, LPrevious].Conjugate * LWork[LRow];
              for LRow := 0 to Self.FOrder - 1 do
                LWork[LRow] := LWork[LRow] -
                  LProjection * result[LRow, LPrevious];
            end;
          end;
          if LWork.Norm < DefaultEpsilon then
            for LRow := 0 to Self.FOrder - 1 do
              LWork[LRow] := Complex(NextRandom, NextRandom);
          LVector := LWork.Normalize;
        end;
        LSolved := True;
        Break;
      except
        on EZeroDivide do
          if LDelta = 0 then
          begin
            LDelta := Max(LScale, LEigenvalue.Norm) * 1E-12;
            if LDelta = 0 then LDelta := 1E-12;
          end
          else
            LDelta := LDelta * 1E2;
      end;
    end;
    if not LSolved then
      raise EInvalidOp.Create(
        'TComplexMatrix.Eigenvectors: inverse iteration did not converge.');
    LPhaseIndex := 0;
    LMaxNorm := LVector[0].Norm;
    for LRow := 1 to Self.FOrder - 1 do
      if LVector[LRow].Norm > LMaxNorm then
      begin
        LPhaseIndex := LRow;
        LMaxNorm := LVector[LRow].Norm;
      end;
    if LMaxNorm > 0 then
    begin
      LPhaseNorm := LVector[LPhaseIndex].Norm;
      LPhase := LVector[LPhaseIndex].Conjugate / LPhaseNorm;
      LVector := LPhase * LVector;
    end;
    for LRow := 0 to Self.FOrder - 1 do
      result[LRow, LColumn] := LVector[LRow];
  end;
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

function SquareRoot(const AValue: TComplex): TArrayOfComplex;
var
  norm: TReal;
begin
  result := nil;
  SetLength(result, 2);
  norm := hypot(AValue.fRe, AValue.fIm);
  result[0].fRe := sqrt(0.5 * (norm + AValue.fRe));
  if AValue.fIm >= 0 then
    result[0].fIm :=  sqrt(0.5 * (norm - AValue.fRe))
  else
    result[0].fIm := -sqrt(0.5 * (norm - AValue.fRe));
  result[1] := -result[0];
end;

function CubicRoot(const AValue: TComplex): TArrayOfComplex;
const
  i: TImaginaryUnit = ();
var
  theta, rootModulus, rootArgument: TReal;
begin
  result := nil;
  SetLength(result, 3);
  rootModulus := Power(AValue.Norm, 1/3);
  theta       := Math.ArcTan2(AValue.fIm, AValue.fRe);

  rootArgument := theta / 3;
  result[0] := rootModulus * (Cos(rootArgument) + Sin(rootArgument) * i);

  rootArgument := (theta + 2*Pi) / 3;
  result[1] := rootModulus * (Cos(rootArgument) + Sin(rootArgument) * i);

  rootArgument := (theta + 4*Pi) / 3;
  result[2] := rootModulus * (Cos(rootArgument) + Sin(rootArgument) * i);
end;

function QuarticRoot(const AValue: TComplex): TArrayOfComplex;
const
  i: TImaginaryUnit = ();
var
  theta, rootModulus, rootArgument: TReal;
begin
  result := nil;
  SetLength(result, 4);
  rootModulus := Power(AValue.Norm, 1/4);
  theta       := Math.ArcTan2(AValue.fIm, AValue.fRe);

  rootArgument := theta / 4;
  result[0] := rootModulus * (Cos(rootArgument) + Sin(rootArgument) * i);

  rootArgument := (theta + 2*Pi) / 4;
  result[1] := rootModulus * (Cos(rootArgument) + Sin(rootArgument) * i);

  rootArgument := (theta + 4*Pi) / 4;
  result[2] := rootModulus * (Cos(rootArgument) + Sin(rootArgument) * i);

  rootArgument := (theta + 6*Pi) / 4;
  result[3] := rootModulus * (Cos(rootArgument) + Sin(rootArgument) * i);
end;

function SolveEquation(const a: TReal): TReal;
begin
  result := -a;
end;

function SolveEquation(const a: TComplex): TComplex;
begin
  result := -a;
end;

function SolveEquation(const a, b: TComplex): TArrayOfComplex;
var
  delta: TComplex;
begin
  result := nil;
  SetLength(result, 2);
  delta     := SquareRoot(SquarePower(a) - 4*b)[0];
  result[0] := (-a + delta) / 2;
  result[1] := (-a - delta) / 2;
end;

function SolveEquation(const a, b, c: TComplex): TArrayOfComplex;
var
  p, q, s1, t: TComplex;
  u, v:        TArrayOfComplex;
begin
  result := nil;
  SetLength(result, 3);
  p := 9*b - 3*SquarePower(a);
  q := 27*c - 9*a*b + 2*CubicPower(a);

  if p.IsNotNull and q.IsNotNull then
  begin
    s1 := -q/2 + SquareRoot(SquarePower(q)/4 + CubicPower(p)/27)[0];
    u  := CubicRoot(s1);
    t := u[0] - p/(3*u[0]); result[0] := (t - a)/3;
    t := u[1] - p/(3*u[1]); result[1] := (t - a)/3;
    t := u[2] - p/(3*u[2]); result[2] := (t - a)/3;
  end else
    if p.IsNull and q.IsNull then
    begin
      result[0] := -a/3;
      result[1] := -a/3;
      result[2] := -a/3;
    end else
      if q.IsNull then
      begin
        v         := SquareRoot(-p);
        result[0] := (0    - a) / 3;
        result[1] := (v[0] - a) / 3;
        result[2] := (v[1] - a) / 3;
      end else
      begin
        u         := CubicRoot(-q);
        result[0] := (u[0] - a) / 3;
        result[1] := (u[1] - a) / 3;
        result[2] := (u[2] - a) / 3;
      end;
end;

function SolveEquation(const a, b, c, d: TComplex): TArrayOfComplex;
var
  p, q, r:     TComplex;
  u1, u2, u3,
  v1, v2, v3:  TArrayOfComplex;
  alpha, beta,
  gamma:       TComplex;
begin
  result := nil;
  SetLength(result, 4);
  p := 16*b - 6*SquarePower(a);
  q := 64*c - 32*a*b + 8*CubicPower(a);
  r := 256*d - 64*a*c + 16*b*SquarePower(a) - 3*QuarticPower(a);

  if q.IsNull then
  begin
    u1 := SolveEquation(p, r);
    u2 := SquareRoot(u1[0]);
    u3 := SquareRoot(u1[1]);
    result[0] := (u2[0] - a) / 4;
    result[1] := (u2[1] - a) / 4;
    result[2] := (u3[0] - a) / 4;
    result[3] := (u3[1] - a) / 4;
  end else
  begin
    v1    := SolveEquation(2*p, SquarePower(p) - 4*r, -SquarePower(q));
    alpha := SquareRoot(v1[0])[0];
    beta  := (SquarePower(alpha)*alpha + p*alpha - q) / (2*alpha);
    gamma := (SquarePower(alpha)*alpha + p*alpha + q) / (2*alpha);
    v2 := SolveEquation( alpha,  beta);
    v3 := SolveEquation(-alpha, gamma);
    result[0] := (v2[0] - a) / 4;
    result[1] := (v2[1] - a) / 4;
    result[2] := (v3[0] - a) / 4;
    result[3] := (v3[1] - a) / 4;
  end;
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
