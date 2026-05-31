unit ADimC;

{$H+}{$J-}
{$modeswitch advancedrecords}

interface

uses
  ADimCommon, ADimR;

type
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
    fRe, fIm: double;
  public
    { Returns the argument (phase angle) of the complex number, in radians.
      The argument is defined as @code(φ = arctan(Im / Re)), adjusted for quadrant.
      Returns a value in the range @code([-π, π]).
    }
    function Arg: double;

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

    { Returns the modulus (magnitude) of the complex number.
      Defined as @code(|z| = √(Re² + Im²)).
    }
    function Norm: double;

    { Returns the squared modulus of the complex number.
      Defined as @code(|z|² = Re² + Im²).
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: double;

    { Returns the reciprocal of the complex number: @code(1 / z).
      @raises(Exception if the number is zero, i.e. @code(|z| = 0).)
    }
    function Reciprocal: TComplex;

    { Converts the complex number to its default string representation.
      The format is @code(a + bi) or @code(a - bi).
    }
    function ToString: string;

    { Converts the complex number to a formatted string with controlled precision.
      @param(APrecision Number of significant digits for floating point formatting.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Sets the complex number to zero.
      After this call @code(Re = 0.0) and @code(Im = 0.0).
    }
    procedure Zero;

    { Implicit conversion from a real value to a complex number.
      The resulting complex number has @code(Im = 0).
    }
    class operator := (const AValue: double): TComplex;

    { Returns @true if both the real and imaginary parts of the two operands are equal. }
    class operator =(const ALeft, ARight: TComplex): boolean; inline;

    { Returns @true if the real or imaginary parts of the two operands differ. }
    class operator <>(const ALeft, ARight: TComplex): boolean; inline;

    { Unary plus. Returns the complex number unchanged. }
    class operator +(const AValue: TComplex): TComplex; inline;

    { Returns the sum of two complex numbers: @code((a+bi) + (c+di) = (a+c) + (b+d)i). }
    class operator +(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the sum of a real number and a complex number. }
    class operator +(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Returns the sum of a complex number and a real number. }
    class operator +(const ALeft: TComplex; const ARight: double): TComplex; inline;

    { Unary minus. Returns the negation of the complex number: @code(-(a+bi) = -a - bi). }
    class operator -(const AValue: TComplex): TComplex; inline;

    { Returns the difference of two complex numbers: @code((a+bi) - (c+di) = (a-c) + (b-d)i). }
    class operator -(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the difference of a real number and a complex number. }
    class operator -(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Returns the difference of a complex number and a real number. }
    class operator -(const ALeft: TComplex; const ARight: double): TComplex; inline;

    { Returns the product of two complex numbers.
      @code((a+bi)·(c+di) = (ac - bd) + (ad + bc)i)
    }
    class operator *(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the product of a real number and a complex number. }
    class operator *(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Returns the product of a complex number and a real number. }
    class operator *(const ALeft: TComplex; const ARight: double): TComplex; inline;

    { Returns the quotient of two complex numbers.
      @raises(Exception if the divisor is zero, i.e. @code(|ARight| = 0).)
    }
    class operator /(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the quotient of a real number divided by a complex number. }
    class operator /(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Returns the quotient of a complex number divided by a real number. }
    class operator /(const ALeft: TComplex; const ARight: double): TComplex; inline;
  public
    { Real part of the complex number. }
    property Re: double read fRe write fRe;

    { Imaginary part of the complex number. }
    property Im: double read fIm write fIm;
  end;

  { Represents the imaginary unit @code(i), defined by @code(i² = -1).

    This record has no fields: it acts as a compile-time constant used to construct
    @link(TComplex) numbers naturally via operator overloading.
    A global constant of this type (conventionally named @code(i)) should be declared
    to allow idiomatic use in expressions.
  }
  TImaginaryUnit = record
  public
    { Implicit conversion of the imaginary unit to a @link(TComplex) number.
      Returns @code(TComplex(Re=0, Im=1)).
    }
    class operator := (const ASelf: TImaginaryUnit): TComplex;
    class operator *(const ALeft, ARight: TImaginaryUnit): double;
    class operator /(const ALeft, ARight: TImaginaryUnit): double;
    class operator -(const AValue: TImaginaryUnit): TComplex;
    class operator +(const AValue: TImaginaryUnit): TComplex;
    class operator +(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
    class operator +(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
    class operator -(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
    class operator -(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
    class operator +(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
    class operator +(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
    class operator -(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
    class operator -(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
    class operator *(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
    class operator *(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
    class operator *(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
    class operator *(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
    class operator /(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
    class operator /(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
    class operator /(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
    class operator /(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
  end;

  { Dynamic array of @link(TComplex) values. }
  TArrayOfComplex = array of TComplex;

  generic TCMatrix<TSpace> = record
  type
    TRMatrix = specialize TRMatrix<TSpace>;
  private
    fm: array of array of TComplex;
    function Get(ARow, ACol: longint): TComplex;
    procedure Put(ARow, ACol: longint; AValue: TComplex);
    function ForwardElimination(out SwapCount: integer): TCMatrix; inline;
    function HessenbergReduction: TCMatrix;
    function HouseholderVector(k: longint): TCMatrix;
    procedure QRDecompose(out Q, R: TCMatrix);
  public
    function Clone: TCMatrix;
    function Conjugate: TCMatrix;
    function Determinant: TComplex;
    function Diagonalize(const AEigenValues: TArrayOfComplex): TCMatrix;
    function Eigenvalues: TArrayOfComplex;
    class function Identity: TCMatrix; static;
    function IsHermitian: boolean;
    function IsNull: boolean;
    function IsNotNull: boolean;
    function IsUnitary: boolean;
    function Norm: double;
    class function Null: TCMatrix; static;
    function Rank: longint;
    function Reciprocal(const ADeterminant: TComplex): TCMatrix;
    function RowReduction: TCMatrix;
    function SameValue(const AMatrix: TCMatrix): boolean;
    procedure Swap(ARow1, ARow2: longint);
    function Trace: TComplex;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
    function Transpose: TCMatrix;
    function TransposeConjugate: TCMatrix;
    class operator Initialize(var ASelf: TCMatrix);
    class operator Finalize(var ASelf: TCMatrix);
    class operator := (const AMatrix: TRMatrix): TCMatrix;
    class operator <>(const ALeft, ARight: TCMatrix): boolean;
    class operator =(const ALeft, ARight: TCMatrix): boolean;
    class operator +(const ALeft, ARight: TCMatrix): TCMatrix;
    class operator -(const ALeft, ARight: TCMatrix): TCMatrix;
    class operator *(const ALeft, ARight: TCMatrix): TCMatrix;
    class operator *(const ALeft: TComplex; const ARight: TCMatrix): TCMatrix;
    class operator *(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;
    class operator /(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;
  public
    property a[ARow, ACol: longint]: TComplex read Get write Put; default;
  end;

  { 2×2 complex matrix. Specialization of @link(TCMatrix) for @link(T2DSpace). }
  TC2Matrix = specialize TCMatrix<T2DSpace>;

  { 3×3 complex matrix. Specialization of @link(TCMatrix) for @link(T3DSpace). }
  TC3Matrix = specialize TCMatrix<T3DSpace>;

  { 4×4 complex matrix. Specialization of @link(TCMatrix) for @link(T4DSpace). }
  TC4Matrix = specialize TCMatrix<T4DSpace>;

  { Generic column vector of complex values (@link(TComplex)) with @code(TSpace.N) components.

    Extends @link(TRVector) to the complex domain. Supports implicit conversion
    from a real vector. Components stored in a 0-based static array.
    Concrete types are provided as @link(TC2Vector), @link(TC3Vector), and @link(TC4Vector).
  }
  generic TCVector<TSpace> = record
  type
    TRVector = specialize TRVector<TSpace>;
    TCMatrix = specialize TCMatrix<TSpace>;
  private
    fm: array of TComplex;

    { Reads the complex component at position @code(ARow). }
    function Get(ARow: longint): TComplex;

    { Writes the complex component at position @code(ARow). }
    procedure Put(ARow: longint; AValue: TComplex);
  public
    function Dot(const AVector: TCVector): TComplex;

    { Returns @true if all components are zero. }
    function IsNull: boolean;

    { Returns @true if at least one component is non-zero. }
    function IsNotNull: boolean;

    { Returns the Euclidean norm: @code(|v| = √(Σ |vᵢ|²)) }
    function Norm: double;

    { Returns the unit vector in the same direction. }
    function Normalize: TCVector;

    { Returns the element-wise reciprocal of the vector. }
    function Reciprocal: TCVector;

    { Returns the squared Euclidean norm: @code(|v|² = Σ |vᵢ|²) }
    function SquaredNorm: double;

    class operator Initialize(var ASelf: TCVector);
    class operator Finalize(var ASelf: TCVector);

    { Implicit conversion from a real vector to a complex vector. }
    class operator :=(const ASelf: TRVector): TCVector;

    class operator <>(const ALeft, ARight: TCVector): boolean;
    class operator =(const ALeft, ARight: TCVector): boolean;
    class operator +(const ASelf: TCVector): TCVector;
    class operator +(const ALeft, ARight: TCVector): TCVector;
    class operator -(const ASelf: TCVector): TCVector;
    class operator -(const ALeft, ARight: TCVector): TCVector;

    class operator *(const ALeft: double; const ARight: TCVector): TCVector;
    class operator *(const ALeft: TCVector; const ARight: double): TCVector;
    class operator *(const ALeft: TComplex; const ARight: TCVector): TCVector;
    class operator *(const ALeft: TCVector; const ARight: TComplex): TCVector;
    class operator *(const ALeft: TCVector; const ARight: TCMatrix): TCVector;
    class operator *(const ALeft: TCMatrix; const ARight: TCVector): TCVector;
    class operator /(const ALeft: TCVector; const ARight: double): TCVector;
    class operator /(const ALeft: double; const ARight: TCVector): TCVector;
    class operator /(const ALeft: TCVector; const ARight: TComplex): TCVector;
    class operator /(const ALeft: TComplex; const ARight: TCVector): TCVector;

  public
    { Provides access to individual complex vector components using a 0-based index. }
    property a[ARow: longint]: TComplex read Get write Put; default;
  end;

  { 2-component complex vector. Specialization of @link(TCVector) for @link(T2DSpace). }
  TC2Vector = specialize TCVector<T2DSpace>;

  { 3-component complex vector. Specialization of @link(TCVector) for @link(T3DSpace). }
  TC3Vector = specialize TCVector<T3DSpace>;

  { 4-component complex vector. Specialization of @link(TCVector) for @link(T4DSpace). }
  TC4Vector = specialize TCVector<T4DSpace>;

  { Returns the modulus (magnitude) of a complex number: @code(|z| = √(Re² + Im²)). }
  function Abs(const AValue: TComplex): double;

  { Returns the square of the complex number: @code(z² = (Re²-Im²) + 2·Re·Im·i). }
  function SquarePower(const AValue: TComplex): TComplex;

  { Returns the cube of the complex number: @code(z³ = z²·z). }
  function CubicPower(const AValue: TComplex): TComplex;

  { Returns the fourth power of the complex number: @code(z⁴ = (z²)²). }
  function QuarticPower(const AValue: TComplex): TComplex;

  { Returns all square roots of the complex number as a fixed-size array. }
  function SquareRoot(const AValue: TComplex): TArrayOfComplex;

  { Returns all cube roots of the complex number as a fixed-size array. }
  function CubicRoot(const AValue: TComplex): TArrayOfComplex;

  { Returns all fourth roots of the complex number as a fixed-size array. }
  function QuarticRoot(const AValue: TComplex): TArrayOfComplex;

  { Returns the commutator of two 2×2 complex matrices: @code([A,B] = A·B - B·A). }
  function Commutator(const ALeft, ARight: TC2Matrix): TC2Matrix;

  { Returns the commutator of two 3×3 complex matrices: @code([A,B] = A·B - B·A). }
  function Commutator(const ALeft, ARight: TC3Matrix): TC3Matrix;

  { Returns the commutator of two 4×4 complex matrices: @code([A,B] = A·B - B·A). }
  function Commutator(const ALeft, ARight: TC4Matrix): TC4Matrix;

  { Returns @true if two complex numbers are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: TComplex): boolean;

  { Returns @true if two 2-component complex vectors are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: TC2Vector): boolean;

  { Returns @true if two 3-component complex vectors are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: TC3Vector): boolean;

  { Returns @true if two 4-component complex vectors are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: TC4Vector): boolean;

  { Returns @true if two 2×2 complex matrices are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: TC2Matrix): boolean;

  { Returns @true if two 3×3 complex matrices are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: TC3Matrix): boolean;

  { Returns @true if two 4×4 complex matrices are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: TC4Matrix): boolean;

  { Solves @code(a·z = 0) over the complex numbers. }
  function SolveEquation(const a: TComplex): TComplex;

  { Solves @code(a·z + b = 0) over the complex numbers. }
  function SolveEquation(const a, b: TComplex): TArrayOfComplex;

  { Solves @code(a·z² + b·z + c = 0) over the complex numbers. }
  function SolveEquation(const a, b, c: TComplex): TArrayOfComplex;

  { Solves @code(a·z³ + b·z² + c·z + d = 0) using Cardano's method. }
  function SolveEquation(const a, b, c, d: TComplex): TArrayOfComplex;

  { Creates a @link(TComplex) number from its real and imaginary parts.
    @param(ARe The real part.)
    @param(AIm The imaginary part.)
  }
  function Complex(const ARe, AIm: double): TComplex;

  { Creates a 2-component complex vector from two complex numbers.
    The result is @code(v = (a1, a2)ᵀ).
    @param(a1 The first component.)
    @param(a2 The second component.)
  }
  function Vector(const a1, a2: TComplex): TC2Vector;

  { Creates a 3-component complex vector from three complex numbers.
    The result is @code(v = (a1, a2, a3)ᵀ).
    @param(a1 The first component.)
    @param(a2 The second component.)
    @param(a3 The third component.)
  }
  function Vector(const a1, a2, a3: TComplex): TC3Vector;

  { Creates a 4-component complex vector from four complex numbers.
    The result is @code(v = (a1, a2, a3, a4)ᵀ).
    @param(a1 The first component.)
    @param(a2 The second component.)
    @param(a3 The third component.)
    @param(a4 The fourth component.)
  }
  function Vector(const a1, a2, a3, a4: TComplex): TC4Vector;

  { Creates a 2×2 complex matrix from its elements in row-major order.
    The result is:
    @code(| a11  a12 |)
    @code(| a21  a22 |)
    @param(a11 Element at row 1, column 1.)
    @param(a12 Element at row 1, column 2.)
    @param(a21 Element at row 2, column 1.)
    @param(a22 Element at row 2, column 2.)
  }
  function Matrix(const a11, a12, a21, a22: TComplex): TC2Matrix;

  { Creates a 3×3 complex matrix from its elements in row-major order.
    The result is:
    @code(| a11  a12  a13 |)
    @code(| a21  a22  a23 |)
    @code(| a31  a32  a33 |)
    @param(a11 Element at row 1, column 1.)
    @param(a12 Element at row 1, column 2.)
    @param(a13 Element at row 1, column 3.)
    @param(a21 Element at row 2, column 1.)
    @param(a22 Element at row 2, column 2.)
    @param(a23 Element at row 2, column 3.)
    @param(a31 Element at row 3, column 1.)
    @param(a32 Element at row 3, column 2.)
    @param(a33 Element at row 3, column 3.)
  }
  function Matrix(const a11, a12, a13, a21, a22, a23, a31, a32, a33: TComplex): TC3Matrix;

  { Creates a 4×4 complex matrix from its elements in row-major order.
    The result is:
    @code(| a11  a12  a13  a14 |)
    @code(| a21  a22  a23  a24 |)
    @code(| a31  a32  a33  a34 |)
    @code(| a41  a42  a43  a44 |)
    @param(a11 Element at row 1, column 1.)
    @param(a12 Element at row 1, column 2.)
    @param(a13 Element at row 1, column 3.)
    @param(a14 Element at row 1, column 4.)
    @param(a21 Element at row 2, column 1.)
    @param(a22 Element at row 2, column 2.)
    @param(a23 Element at row 2, column 3.)
    @param(a24 Element at row 2, column 4.)
    @param(a31 Element at row 3, column 1.)
    @param(a32 Element at row 3, column 2.)
    @param(a33 Element at row 3, column 3.)
    @param(a34 Element at row 3, column 4.)
    @param(a41 Element at row 4, column 1.)
    @param(a42 Element at row 4, column 2.)
    @param(a43 Element at row 4, column 3.)
    @param(a44 Element at row 4, column 4.)
  }
  function Matrix(const a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44: TComplex): TC4Matrix;

var
  { The imaginary unit @code(i), defined by @code(i² = -1).
    Can be used directly in expressions to construct complex numbers idiomatically:
    @code(z := 3.0 + 2.0*img;)
  }
  img: TImaginaryUnit;

implementation

uses Math, SysUtils;

// TComplex

function TComplex.Arg: double;
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

function TComplex.Norm: double;
begin
  result := hypot(fRe, fIm);
end;

function TComplex.SquaredNorm: double;
begin
  result := sqr(fRe) + sqr(fIm);
end;

function TComplex.Reciprocal: TComplex;
begin
  result := Conjugate / SquaredNorm;
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
      result := Format('%s %si', [FloatToStrF(fRe, ffGeneral, APrecision, ADigits), sign[fIm < 0]])
    else
      result := Format('%s %s%s∙i', [
        FloatToStrF(fRe,              ffGeneral, APrecision, ADigits), sign[fIm < 0],
        FloatToStrF(System.Abs(fIm),  ffGeneral, APrecision, ADigits)]);
  end else
    if not SameValueEx(fRe, 0) then
      result := FloatToStrF(fRe, ffGeneral, APrecision, ADigits)
    else
      if not SameValueEx(fIm, 0) then
      begin
        if SameValueEx(fIm, 1) then result := 'i'
        else if SameValueEx(fIm, -1) then result := '-i'
        else result := Format('%s∙i', [FloatToStrF(fIm, ffGeneral, APrecision, ADigits)])
      end else
        result := '0';
end;

procedure TComplex.Zero;
begin
  fRe := 0;
  fIm := 0;
end;

class operator TComplex.:=(const AValue: double): TComplex;
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

class operator TComplex.+(const ALeft: double; const ARight: TComplex): TComplex;
begin
  result.fRe := ALeft + ARight.fRe;
  result.fIm :=         ARight.fIm;
end;

class operator TComplex.+(const ALeft: TComplex; const ARight: double): TComplex;
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

class operator TComplex.-(const ALeft: double; const ARight: TComplex): TComplex;
begin
  result.fRe := ALeft - ARight.fRe;
  result.fIm :=       - ARight.fIm;
end;

class operator TComplex.-(const ALeft: TComplex; const ARight: double): TComplex;
begin
  result.fRe := ALeft.fRe - ARight;
  result.fIm := ALeft.fIm;
end;

class operator TComplex.*(const ALeft, ARight: TComplex): TComplex;
begin
  result.fRe := ALeft.fRe * ARight.fRe - ALeft.fIm * ARight.fIm;
  result.fIm := ALeft.fRe * ARight.fIm + ALeft.fIm * ARight.fRe;
end;

class operator TComplex.*(const ALeft: double; const ARight: TComplex): TComplex;
begin
  result.fRe := ALeft * ARight.fRe;
  result.fIm := ALeft * ARight.fIm;
end;

class operator TComplex.*(const ALeft: TComplex; const ARight: double): TComplex;
begin
  result.fRe := ALeft.fRe * ARight;
  result.fIm := ALeft.fIm * ARight;
end;

class operator TComplex./(const ALeft, ARight: TComplex): TComplex;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TComplex./(const ALeft: double; const ARight: TComplex): TComplex;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TComplex./(const ALeft: TComplex; const ARight: double): TComplex;
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

class operator TImaginaryUnit.*(const ALeft, ARight: TImaginaryUnit): double;
begin
  result := -1;
end;

class operator TImaginaryUnit./(const ALeft, ARight: TImaginaryUnit): double;
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

class operator TImaginaryUnit.+(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe := ALeft;
  result.fIm := 1;
end;

class operator TImaginaryUnit.+(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
begin
  result.fRe := ARight;
  result.fIm := 1;
end;

class operator TImaginaryUnit.-(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe :=  ALeft;
  result.fIm := -1;
end;

class operator TImaginaryUnit.-(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
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

class operator TImaginaryUnit.*(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe := 0;
  result.fIm := ALeft;
end;

class operator TImaginaryUnit.*(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
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

class operator TImaginaryUnit./(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe :=  0;
  result.fIm := -ALeft;
end;

class operator TImaginaryUnit./(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
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
  denom: double;
begin
  denom      :=  ARight.SquaredNorm;
  result.fRe :=  ARight.fIm / denom;
  result.fIm :=  ARight.fRe / denom;
end;

// TCMatrix

function TCMatrix.Get(ARow, ACol: longint): TComplex;
begin
  result := fm[ARow, ACol];
end;

procedure TCMatrix.Put(ARow, ACol: longint; AValue: TComplex);
begin
  fm[ARow, ACol] := AValue;
end;

function TCMatrix.ForwardElimination(out SwapCount: integer): TCMatrix;
var
  pivot, ratio: TComplex;
  maxVal:       double;
  i, j, k,
  maxRow:       longint;
  rowI, rowJ:   array of TComplex;
begin
  result    := Self.Clone;
  SwapCount := 0;

  for i := 0 to TSpace.N - 1 do
  begin
    // Partial pivot search using modulus
    maxRow := i;
    maxVal := result.fm[i, i].Norm;
    for j := i + 1 to TSpace.N - 1 do
      if result.fm[j, i].Norm > maxVal then
      begin
        maxVal := result.fm[j, i].Norm;
        maxRow := j;
      end;

    if maxVal < DefaultEpsilon then Continue;

    if maxRow <> i then
    begin
      result.Swap(i, maxRow);
      Inc(SwapCount);
    end;

    // Cache pivot row to avoid repeated double-indexing
    rowI  := result.fm[i];
    pivot := rowI[i];

    for j := i + 1 to TSpace.N - 1 do
    begin
      if result.fm[j, i].Norm < DefaultEpsilon then Continue;
      rowJ    := result.fm[j];
      ratio   := rowJ[i] / pivot;
      rowJ[i] := 0;
      for k := i + 1 to TSpace.N - 1 do
        rowJ[k] := rowJ[k] - ratio * rowI[k];
      result.fm[j] := rowJ;
    end;
  end;
end;

function TCMatrix.HouseholderVector(k: longint): TCMatrix;
var
  i:      longint;
  LNorm,
  LNorm2: double;
begin
  result := TCMatrix.Null;

  for i := k + 1 to TSpace.N - 1 do
    result.fm[i, 0] := fm[i, k];

  LNorm := 0;
  for i := k + 1 to TSpace.N - 1 do
    LNorm := LNorm + result.fm[i, 0].SquaredNorm;
  LNorm := sqrt(LNorm);

  if LNorm < DefaultEpsilon then Exit;

  result.fm[k + 1, 0] := result.fm[k + 1, 0] + LNorm;

  // Avoid recomputing norm via analytical update: norm2² = 2·norm·|v[k+1]|
  LNorm2 := sqrt(2 * LNorm * result.fm[k + 1, 0].Norm);

  if LNorm2 < DefaultEpsilon then Exit;

  for i := k + 1 to TSpace.N - 1 do
    result.fm[i, 0] := result.fm[i, 0] / LNorm2;
end;

function TCMatrix.HessenbergReduction: TCMatrix;
var
  V:       TCMatrix;
  k, i, j: longint;
  dot:     TComplex;
  rowI:    array of TComplex;
begin
  result := Self.Clone;

  for k := 0 to TSpace.N - 3 do
  begin
    V := result.HouseholderVector(k);
    if V.IsNull then Continue;

    // Apply from left: result := (I - 2·V·Vᴴ) · result
    for j := 0 to TSpace.N - 1 do
    begin
      dot := 0;
      for i := k + 1 to TSpace.N - 1 do
        dot := dot + V.fm[i, 0].Conjugate * result.fm[i, j];
      for i := k + 1 to TSpace.N - 1 do
        result.fm[i, j] := result.fm[i, j] - 2 * V.fm[i, 0] * dot;
    end;

    // Apply from right: result := result · (I - 2·V·Vᴴ)
    for i := 0 to TSpace.N - 1 do
    begin
      rowI := result.fm[i];
      dot  := 0;
      for j := k + 1 to TSpace.N - 1 do
        dot := dot + rowI[j] * V.fm[j, 0];
      for j := k + 1 to TSpace.N - 1 do
        rowI[j] := rowI[j] - 2 * dot * V.fm[j, 0].Conjugate;
      result.fm[i] := rowI;
    end;

    // Explicitly zero below first subdiagonal for numerical stability
    for i := k + 2 to TSpace.N - 1 do
      result.fm[i, k] := 0;
  end;
end;

procedure TCMatrix.QRDecompose(out Q, R: TCMatrix);
var
  i, j:         longint;
  c, s,
  temp1, temp2: TComplex;
  denom:        double;
  rowI, rowJ:   array of TComplex;
begin
  Q := TCMatrix.Identity;
  R := Self.Clone;

  for j := 0 to TSpace.N - 2 do
    if R.fm[j + 1, j].Norm > DefaultEpsilon then
    begin
      // denom is real positive: √(|r_jj|² + |r_j+1,j|²)
      denom := sqrt(R.fm[j, j].SquaredNorm + R.fm[j + 1, j].SquaredNorm);
      c := R.fm[j,     j] / denom;
      s := R.fm[j + 1, j] / denom;

      // Apply Givens rotation to R from left
      rowI := R.fm[j];
      rowJ := R.fm[j + 1];
      for i := j to TSpace.N - 1 do
      begin
        temp1   := c.Conjugate * rowI[i] + s.Conjugate * rowJ[i];
        temp2   :=           -s * rowI[i] +           c * rowJ[i];
        rowI[i] := temp1;
        rowJ[i] := temp2;
      end;
      R.fm[j]     := rowI;
      R.fm[j + 1] := rowJ;

      // Apply Givens rotation to Q from right
      for i := 0 to TSpace.N - 1 do
      begin
        rowI        := Q.fm[i];
        temp1       :=            c * rowI[j] +           s * rowI[j + 1];
        temp2       := -s.Conjugate * rowI[j] + c.Conjugate * rowI[j + 1];
        rowI[j]     := temp1;
        rowI[j + 1] := temp2;
        Q.fm[i]     := rowI;
      end;
    end;
end;

function TCMatrix.Clone: TCMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := fm[i, j];
end;

function TCMatrix.Conjugate: TCMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := fm[i, j].Conjugate;
end;

function TCMatrix.Determinant: TComplex;
var
  U:     TCMatrix;
  swaps: integer;
  i:     longint;
begin
  U      := ForwardElimination(swaps);
  result := 1;
  for i  := 0 to TSpace.N - 1 do
    result := result * U.fm[i, i];
  if Odd(swaps) then
    result := -result;
end;

function TCMatrix.Diagonalize(const AEigenValues: TArrayOfComplex): TCMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if i = j then
        result.fm[i, i] := AEigenValues[i]
      else
        result.fm[i, j] := 0;
end;

function TCMatrix.Eigenvalues: TArrayOfComplex;
var
  H:         TCMatrix;
  Q, R:      TCMatrix;
  i, iter,
  n:         longint;
  shift:     TComplex;
  converged: boolean;
const
  MaxIter = 1000;
begin
  SetLength(result, TSpace.N);
  H := Self.HessenbergReduction;
  n := TSpace.N - 1;

  while n > 0 do
  begin
    converged := False;
    for iter := 1 to MaxIter do
    begin
      // Wilkinson shift
      shift := H.fm[n, n];
      for i := 0 to n do
        H.fm[i, i] := H.fm[i, i] - shift;

      H.QRDecompose(Q, R);
      H := R * Q;

      for i := 0 to n do
        H.fm[i, i] := H.fm[i, i] + shift;

      if H.fm[n, n - 1].Norm < DefaultEpsilon then
      begin
        result[n] := H.fm[n, n];
        Dec(n);
        converged := True;
        Break;
      end;
    end;

    // No convergence: take best available value and deflate
    if not converged then
    begin
      result[n] := H.fm[n, n];
      Dec(n);
    end;
  end;
  result[0] := H.fm[0, 0];
end;

class function TCMatrix.Identity: TCMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if i = j then
        result.fm[i, j] := 1
      else
        result.fm[i, j] := 0;
end;

function TCMatrix.IsHermitian: boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if not SameValueEx(fm[i, j], fm[j, i].Conjugate) then Exit(False);
  result := True;
end;

function TCMatrix.IsNull: boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if not SameValueEx(fm[i, j], 0) then Exit(False);
  result := True;
end;

function TCMatrix.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TCMatrix.IsUnitary: boolean;
begin
  result := TCMatrix.Identity.SameValue(Self * Self.TransposeConjugate);
end;

function TCMatrix.Norm: double;
var
  i, j: longint;
  sum:  double;
  rowI: array of TComplex;
begin
  sum := 0;
  for i := 0 to TSpace.N - 1 do
  begin
    rowI := fm[i];
    for j := 0 to TSpace.N - 1 do
      sum := sum + rowI[j].SquaredNorm;
  end;
  result := sqrt(sum);
end;

class function TCMatrix.Null: TCMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
    begin
      result.fm[i, j].fRe := 0;
      result.fm[i, j].fIm := 0;
    end;
end;

function TCMatrix.Rank: longint;
var
  U:     TCMatrix;
  swaps: integer;
  i:     longint;
begin
  U      := ForwardElimination(swaps);
  result := 0;
  for i  := 0 to TSpace.N - 1 do
    if U.fm[i, i].Norm > DefaultEpsilon then
      Inc(result);
end;

function TCMatrix.Reciprocal(const ADeterminant: TComplex): TCMatrix;
var
  Adj:    TCMatrix;
  sub:    TCMatrix;
  i, j,
  ri, ci,
  si, sj: longint;
  sign:   double;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
    begin
      // Build (N-1)×(N-1) submatrix by deleting row i and column j
      si := 0;
      for ri := 0 to TSpace.N - 1 do
      begin
        if ri = i then Continue;
        sj := 0;
        for ci := 0 to TSpace.N - 1 do
        begin
          if ci = j then Continue;
          sub.fm[si, sj] := fm[ri, ci];
          Inc(sj);
        end;
        Inc(si);
      end;

      // Cofactor C[i,j] = (-1)^(i+j) * det(sub)
      if Odd(i + j) then sign := -1.0 else sign := 1.0;

      // Adjugate is transpose of cofactor matrix: Adj[j,i] = C[i,j]
      Adj.fm[j, i] := sign * sub.Determinant;
    end;

  // Inverse = Adj / det(A)
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := Adj.fm[i, j] / ADeterminant;
end;

function TCMatrix.RowReduction: TCMatrix;
var
  ratio:      TComplex;
  i, j, k,
  maxRow:     longint;
  rowI, rowJ: array of TComplex;
begin
  result := Self.Clone;

  // Step 1: Forward elimination with partial pivoting
  for i := 0 to TSpace.N - 1 do
  begin
    maxRow := i;
    for j := i + 1 to TSpace.N - 1 do
      if result.fm[j, i].Norm > result.fm[maxRow, i].Norm then
        maxRow := j;

    if maxRow <> i then
      result.Swap(i, maxRow);

    if result.fm[i, i].IsNull then Continue;

    rowI := result.fm[i];
    for j := i + 1 to TSpace.N - 1 do
      rowI[j] := rowI[j] / rowI[i];
    rowI[i]      := 1;
    result.fm[i] := rowI;

    for j := i + 1 to TSpace.N - 1 do
    begin
      if result.fm[j, i].IsNull then Continue;
      rowJ    := result.fm[j];
      ratio   := rowJ[i];
      rowJ[i] := 0;
      for k := i + 1 to TSpace.N - 1 do
        rowJ[k] := rowJ[k] - ratio * rowI[k];
      result.fm[j] := rowJ;
    end;
  end;

  // Step 2: Back-substitution
  for i := TSpace.N - 1 downto 0 do
  begin
    if result.fm[i, i].IsNull then Continue;
    rowI := result.fm[i];
    for j := i - 1 downto 0 do
    begin
      rowJ    := result.fm[j];
      ratio   := rowJ[i];
      rowJ[i] := 0;
      for k := i to TSpace.N - 1 do
        rowJ[k] := rowJ[k] - ratio * rowI[k];
      result.fm[j] := rowJ;
    end;
  end;
end;

function TCMatrix.SameValue(const AMatrix: TCMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if not SameValueEx(fm[i, j], AMatrix.fm[i, j]) then Exit(False);
  result := True;
end;

procedure TCMatrix.Swap(ARow1, ARow2: longint);
var
  tmp: array of TComplex;
begin
  tmp       := fm[ARow1];
  fm[ARow1] := fm[ARow2];
  fm[ARow2] := tmp;
end;

function TCMatrix.Trace: TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 0 to TSpace.N - 1 do
    result := result + fm[i, i];
end;

function TCMatrix.ToString: string;
var
  i, j: longint;
  rows: array of string;
begin
  SetLength(rows, TSpace.N);
  for i := 0 to TSpace.N - 1 do
  begin
    rows[i] := '(';
    for j := 0 to TSpace.N - 1 do
    begin
      if j > 0 then rows[i] := rows[i] + ', ';
      rows[i] := rows[i] + fm[i, j].ToString;
    end;
    rows[i] := rows[i] + ')';
  end;
  result := '(' + string.Join(', ', rows) + ')';
end;

function TCMatrix.ToString(APrecision, ADigits: integer): string;
var
  i, j: longint;
  rows: array of string;
begin
  SetLength(rows, TSpace.N);
  for i := 0 to TSpace.N - 1 do
  begin
    rows[i] := '(';
    for j := 0 to TSpace.N - 1 do
    begin
      if j > 0 then rows[i] := rows[i] + ', ';
      rows[i] := rows[i] + fm[i, j].ToString(APrecision, ADigits);
    end;
    rows[i] := rows[i] + ')';
  end;
  result := '(' + string.Join(', ', rows) + ')';
end;

function TCMatrix.Transpose: TCMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := fm[j, i];
end;

function TCMatrix.TransposeConjugate: TCMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := fm[j, i].Conjugate;
end;

class operator TCMatrix.Initialize(var ASelf: TCMatrix);
begin
  SetLength(ASelf.fm, TSpace.N, TSpace.N);
end;

class operator TCMatrix.Finalize(var ASelf: TCMatrix);
begin
  SetLength(ASelf.fm, 0, 0);
end;

class operator TCMatrix.:=(const AMatrix: TRMatrix): TCMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := AMatrix.fm[i, j];
end;

class operator TCMatrix.<>(const ALeft, ARight: TCMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if ALeft.fm[i, j] <> ARight.fm[i, j] then Exit(True);
  result := False;
end;

class operator TCMatrix.=(const ALeft, ARight: TCMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if ALeft.fm[i, j] <> ARight.fm[i, j] then Exit(False);
  result := True;
end;

class operator TCMatrix.+(const ALeft, ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] + ARight.fm[i, j];
end;

class operator TCMatrix.-(const ALeft, ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] - ARight.fm[i, j];
end;

class operator TCMatrix.*(const ALeft, ARight: TCMatrix): TCMatrix;
var
  i, j, k: longint;
  rowI:    array of TComplex;
begin
  for i := 0 to TSpace.N - 1 do
  begin
    rowI := ALeft.fm[i];
    for j := 0 to TSpace.N - 1 do
    begin
      result.fm[i, j] := 0;
      for k := 0 to TSpace.N - 1 do
        result.fm[i, j] := result.fm[i, j] + rowI[k] * ARight.fm[k, j];
    end;
  end;
end;

class operator TCMatrix.*(const ALeft: TComplex; const ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft * ARight.fm[i, j];
end;

class operator TCMatrix.*(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] * ARight;
end;

class operator TCMatrix./(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] / ARight;
end;

// TCVector

function TCVector.Get(ARow: longint): TComplex;
begin
  result := fm[ARow];
end;

procedure TCVector.Put(ARow: longint; AValue: TComplex);
begin
  fm[ARow] := AValue;
end;

function TCVector.Dot(const AVector: TCVector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 0 to TSpace.N - 1 do
    result := result + fm[i] * AVector.fm[i];
end;

function TCVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    if fm[i].IsNotNull then Exit(False);
  result := True;
end;

function TCVector.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TCVector.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TCVector.Normalize: TCVector;
var
  i: longint;
  n: double;
begin
  n := Norm;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := fm[i] / n;
end;

function TCVector.Reciprocal: TCVector;
var
  i:  longint;
  sn: double;
begin
  sn := SquaredNorm;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := fm[i] / sn;
end;

function TCVector.SquaredNorm: double;
var
  i: longint;
begin
  result := 0;
  for i := 0 to TSpace.N - 1 do
    result := result + fm[i].SquaredNorm;
end;

class operator TCVector.Initialize(var ASelf: TCVector);
begin
  SetLength(ASelf.fm, TSpace.N);
end;

class operator TCVector.Finalize(var ASelf: TCVector);
begin
  SetLength(ASelf.fm, 0);
end;

class operator TCVector.:=(const ASelf: TRVector): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ASelf.fm[i];
end;

class operator TCVector.<>(const ALeft, ARight: TCVector): boolean;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    if ALeft.fm[i] <> ARight.fm[i] then Exit(True);
  result := False;
end;

class operator TCVector.=(const ALeft, ARight: TCVector): boolean;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    if ALeft.fm[i] <> ARight.fm[i] then Exit(False);
  result := True;
end;

class operator TCVector.+(const ASelf: TCVector): TCVector;
begin
  result := ASelf;
end;

class operator TCVector.+(const ALeft, ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] + ARight.fm[i];
end;

class operator TCVector.-(const ASelf: TCVector): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := -ASelf.fm[i];
end;

class operator TCVector.-(const ALeft, ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] - ARight.fm[i];
end;

class operator TCVector.*(const ALeft: double; const ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft * ARight.fm[i];
end;

class operator TCVector.*(const ALeft: TCVector; const ARight: double): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] * ARight;
end;

class operator TCVector.*(const ALeft: TComplex; const ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft * ARight.fm[i];
end;

class operator TCVector.*(const ALeft: TCVector; const ARight: TComplex): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] * ARight;
end;

class operator TCVector.*(const ALeft: TCVector; const ARight: TCMatrix): TCVector;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
  begin
    result.fm[i] := 0;
    for j := 0 to TSpace.N - 1 do
      result.fm[i] := result.fm[i] + ALeft.fm[j] * ARight.fm[j, i];
  end;
end;

class operator TCVector.*(const ALeft: TCMatrix; const ARight: TCVector): TCVector;
var
  i, j: longint;
  rowI: array of TComplex;
begin
  for i := 0 to TSpace.N - 1 do
  begin
    rowI         := ALeft.fm[i];
    result.fm[i] := 0;
    for j := 0 to TSpace.N - 1 do
      result.fm[i] := result.fm[i] + rowI[j] * ARight.fm[j];
  end;
end;

class operator TCVector./(const ALeft: TCVector; const ARight: double): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] / ARight;
end;

class operator TCVector./(const ALeft: double; const ARight: TCVector): TCVector;
var
  i: longint;
  r: TCVector;
begin
  r := ARight.Reciprocal;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft * r.fm[i];
end;

class operator TCVector./(const ALeft: TCVector; const ARight: TComplex): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] / ARight;
end;

class operator TCVector./(const ALeft: TComplex; const ARight: TCVector): TCVector;
var
  i: longint;
  r: TCVector;
begin
  r := ARight.Reciprocal;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft * r.fm[i];
end;

// Standalone functions

function Abs(const AValue: TComplex): double;
begin
  result := AValue.Norm;
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
  norm: double;
begin
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
  theta, rootModulus, rootArgument: double;
begin
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
  theta, rootModulus, rootArgument: double;
begin
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

function Commutator(const ALeft, ARight: TC2Matrix): TC2Matrix;
begin
  result := ALeft * ARight - ARight * ALeft;
end;

function Commutator(const ALeft, ARight: TC3Matrix): TC3Matrix;
begin
  result := ALeft * ARight - ARight * ALeft;
end;

function Commutator(const ALeft, ARight: TC4Matrix): TC4Matrix;
begin
  result := ALeft * ARight - ARight * ALeft;
end;

function SameValueEx(const AValue1, AValue2: TComplex): boolean;
begin
  result := SameValueEx(AValue1.fRe, AValue2.fRe) and
            SameValueEx(AValue1.fIm, AValue2.fIm);
end;

function SameValueEx(const AValue1, AValue2: TC2Vector): boolean;
begin
  result := SameValueEx(AValue1.fm[0], AValue2.fm[0]) and
            SameValueEx(AValue1.fm[1], AValue2.fm[1]);
end;

function SameValueEx(const AValue1, AValue2: TC3Vector): boolean;
begin
  result := SameValueEx(AValue1.fm[0], AValue2.fm[0]) and
            SameValueEx(AValue1.fm[1], AValue2.fm[1]) and
            SameValueEx(AValue1.fm[2], AValue2.fm[2]);
end;

function SameValueEx(const AValue1, AValue2: TC4Vector): boolean;
begin
  result := SameValueEx(AValue1.fm[0], AValue2.fm[0]) and
            SameValueEx(AValue1.fm[1], AValue2.fm[1]) and
            SameValueEx(AValue1.fm[2], AValue2.fm[2]) and
            SameValueEx(AValue1.fm[3], AValue2.fm[3]);
end;

function SameValueEx(const AValue1, AValue2: TC2Matrix): boolean;
begin
  result := SameValueEx(AValue1.fm[0,0], AValue2.fm[0,0]) and
            SameValueEx(AValue1.fm[0,1], AValue2.fm[0,1]) and
            SameValueEx(AValue1.fm[1,0], AValue2.fm[1,0]) and
            SameValueEx(AValue1.fm[1,1], AValue2.fm[1,1]);
end;

function SameValueEx(const AValue1, AValue2: TC3Matrix): boolean;
begin
  result := SameValueEx(AValue1.fm[0,0], AValue2.fm[0,0]) and
            SameValueEx(AValue1.fm[0,1], AValue2.fm[0,1]) and
            SameValueEx(AValue1.fm[0,2], AValue2.fm[0,2]) and
            SameValueEx(AValue1.fm[1,0], AValue2.fm[1,0]) and
            SameValueEx(AValue1.fm[1,1], AValue2.fm[1,1]) and
            SameValueEx(AValue1.fm[1,2], AValue2.fm[1,2]) and
            SameValueEx(AValue1.fm[2,0], AValue2.fm[2,0]) and
            SameValueEx(AValue1.fm[2,1], AValue2.fm[2,1]) and
            SameValueEx(AValue1.fm[2,2], AValue2.fm[2,2]);
end;

function SameValueEx(const AValue1, AValue2: TC4Matrix): boolean;
begin
  result := SameValueEx(AValue1.fm[0,0], AValue2.fm[0,0]) and
            SameValueEx(AValue1.fm[0,1], AValue2.fm[0,1]) and
            SameValueEx(AValue1.fm[0,2], AValue2.fm[0,2]) and
            SameValueEx(AValue1.fm[0,3], AValue2.fm[0,3]) and
            SameValueEx(AValue1.fm[1,0], AValue2.fm[1,0]) and
            SameValueEx(AValue1.fm[1,1], AValue2.fm[1,1]) and
            SameValueEx(AValue1.fm[1,2], AValue2.fm[1,2]) and
            SameValueEx(AValue1.fm[1,3], AValue2.fm[1,3]) and
            SameValueEx(AValue1.fm[2,0], AValue2.fm[2,0]) and
            SameValueEx(AValue1.fm[2,1], AValue2.fm[2,1]) and
            SameValueEx(AValue1.fm[2,2], AValue2.fm[2,2]) and
            SameValueEx(AValue1.fm[2,3], AValue2.fm[2,3]) and
            SameValueEx(AValue1.fm[3,0], AValue2.fm[3,0]) and
            SameValueEx(AValue1.fm[3,1], AValue2.fm[3,1]) and
            SameValueEx(AValue1.fm[3,2], AValue2.fm[3,2]) and
            SameValueEx(AValue1.fm[3,3], AValue2.fm[3,3]);
end;

function SolveEquation(const a: TComplex): TComplex;
begin
  result := -a;
end;

function SolveEquation(const a, b: TComplex): TArrayOfComplex;
var
  delta: TComplex;
begin
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
        v         := SquareRoot(p);
        result[0] := 0;
        result[1] := v[0];
        result[2] := v[1];
      end else
      begin
        u         := CubicRoot(q);
        result[0] := u[0];
        result[1] := u[1];
        result[2] := u[2];
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

function Complex(const ARe, AIm: double): TComplex;
begin
  result.Re := ARe;
  result.Im := AIm;
end;

function Vector(const a1, a2: TComplex): TC2Vector;
begin
  result[1] := a1;
  result[2] := a2;
end;

function Vector(const a1, a2, a3: TComplex): TC3Vector;
begin
  result[1] := a1;
  result[2] := a2;
  result[3] := a3;
end;

function Vector(const a1, a2, a3, a4: TComplex): TC4Vector;
begin
  result[1] := a1;
  result[2] := a2;
  result[3] := a3;
  result[4] := a4;
end;

function Matrix(const a11, a12, a21, a22: TComplex): TC2Matrix;
begin
  result[1,1] := a11;
  result[1,2] := a12;
  result[2,1] := a21;
  result[2,2] := a22;
end;

function Matrix(const a11, a12, a13, a21, a22, a23, a31, a32, a33: TComplex): TC3Matrix;
begin
  result[1,1] := a11;
  result[1,2] := a12;
  result[1,3] := a13;
  result[2,1] := a21;
  result[2,2] := a22;
  result[2,3] := a23;
  result[3,1] := a31;
  result[3,2] := a32;
  result[3,3] := a33;
end;

function Matrix(const a11, a12, a13, a14, a21, a22, a23, a24, a31, a32, a33, a34, a41, a42, a43, a44: TComplex): TC4Matrix;
begin
  result[1,1] := a11;
  result[1,2] := a12;
  result[1,3] := a13;
  result[1,4] := a14;
  result[2,1] := a21;
  result[2,2] := a22;
  result[2,3] := a23;
  result[2,4] := a24;
  result[3,1] := a31;
  result[3,2] := a32;
  result[3,3] := a33;
  result[3,4] := a34;
  result[4,1] := a41;
  result[4,2] := a42;
  result[4,3] := a43;
  result[4,4] := a44;
end;

end.
