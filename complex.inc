
  (**
    Represents a complex number in Cartesian form: @code(z = Re + i·Im).

    A complex number consists of:
    @unorderedList(
      @item(@bold(Re): the real part)
      @item(@bold(Im): the imaginary part)
    )
    The imaginary unit @code(i) is defined by @code(i² = -1).
    All arithmetic operations follow standard complex number algebra.
  *)
  TComplex = record
  private
    fRe, fIm: double;
  public
    (**
      Returns the argument (phase angle) of the complex number, in radians.
      The argument is defined as @code(φ = arctan(Im / Re)), adjusted for quadrant.
      Returns a value in the range @code((-π, π]).
    *)
    function Arg: double;

    (**
      Returns the complex conjugate of the number.
      If @code(z = a + i·b), the conjugate is @code(z* = a - i·b).
    *)
    function Conjugate: TComplex;

    (**
      Returns @true if the complex number is zero, i.e. both @code(Re = 0) and @code(Im = 0).
    *)
    function IsNull: boolean;

    (**
      Returns @true if the complex number is not zero,
      i.e. at least one of @code(Re) or @code(Im) is non-zero.
    *)
    function IsNotNull: boolean;

    (**
      Returns the modulus (magnitude) of the complex number.
      Defined as @code(|z| = √(Re² + Im²)).
    *)
    function Norm: double;

    (**
      Returns the squared modulus of the complex number.
      Defined as @code(|z|² = Re² + Im²).
      Avoids the square root computation of @link(Norm).
    *)
    function SquaredNorm: double;

    (**
      Returns the reciprocal of the complex number: @code(1 / z).
      @raises(Exception if the number is zero, i.e. @code(|z| = 0).)
    *)
    function Reciprocal: TComplex;

    (**
      Converts the complex number to its default string representation.
      The format is @code(a + bi) or @code(a - bi).
    *)
    function ToString: string;

    (**
      Converts the complex number to a formatted string with controlled precision.
      @param(APrecision Number of significant digits for floating point formatting.)
      @param(ADigits    Minimum number of digits in the output.)
    *)
    function ToString(APrecision, ADigits: integer): string;

    (**
      Implicit conversion from a real value to a complex number.
      The resulting complex number has @code(Im = 0).
    *)
    class operator :=(const AValue: double): TComplex;

    (** Returns @true if both the real and imaginary parts of the two operands are equal. *)
    class operator =(const ALeft, ARight: TComplex): boolean; inline;

    (** Returns @true if the real or imaginary parts of the two operands differ. *)
    class operator <>(const ALeft, ARight: TComplex): boolean; inline;

    (** Unary plus. Returns the complex number unchanged. *)
    class operator +(const AValue: TComplex): TComplex; inline;

    (** Returns the sum of two complex numbers: @code((a+bi) + (c+di) = (a+c) + (b+d)i). *)
    class operator +(const ALeft, ARight: TComplex): TComplex; inline;

    (** Returns the sum of a real number and a complex number. *)
    class operator +(const ALeft: double; const ARight: TComplex): TComplex; inline;

    (** Returns the sum of a complex number and a real number. *)
    class operator +(const ALeft: TComplex; const ARight: double): TComplex; inline;

    (** Unary minus. Returns the negation of the complex number: @code(-(a+bi) = -a - bi). *)
    class operator -(const AValue: TComplex): TComplex; inline;

    (** Returns the difference of two complex numbers: @code((a+bi) - (c+di) = (a-c) + (b-d)i). *)
    class operator -(const ALeft, ARight: TComplex): TComplex; inline;

    (** Returns the difference of a real number and a complex number. *)
    class operator -(const ALeft: double; const ARight: TComplex): TComplex; inline;

    (** Returns the difference of a complex number and a real number. *)
    class operator -(const ALeft: TComplex; const ARight: double): TComplex; inline;

    (**
      Returns the product of two complex numbers.
      @code((a+bi)·(c+di) = (ac - bd) + (ad + bc)i)
    *)
    class operator *(const ALeft, ARight: TComplex): TComplex; inline;

    (** Returns the product of a real number and a complex number. *)
    class operator *(const ALeft: double; const ARight: TComplex): TComplex; inline;

    (** Returns the product of a complex number and a real number. *)
    class operator *(const ALeft: TComplex; const ARight: double): TComplex; inline;

    (**
      Returns the quotient of two complex numbers.
      @raises(Exception if the divisor is zero, i.e. @code(|ARight| = 0).)
    *)
    class operator /(const ALeft, ARight: TComplex): TComplex; inline;

    (** Returns the quotient of a real number divided by a complex number. *)
    class operator /(const ALeft: double; const ARight: TComplex): TComplex; inline;

    (** Returns the quotient of a complex number divided by a real number. *)
    class operator /(const ALeft: TComplex; const ARight: double): TComplex; inline;
  public
    (** Real part of the complex number. *)
    property Re: double read fRe write fRe;

    (** Imaginary part of the complex number. *)
    property Im: double read fIm write fIm;
  end;

  (**
    Represents a complex quantity with physical dimensions.

    Combines a @link(TComplex) value with a @link(TDimension), supporting
    arithmetic operations while preserving dimensional consistency.
    When the symbol @code(ADIMOFF) is defined, this type degenerates to @link(TComplex).
  *)
  {$IFNDEF ADIMOFF}
  TComplexQuantity = record
  private
    FDim: TDimension;
    FValue: TComplex;
  public
    (** Implicit conversion from a real @link(TQuantity) to a complex quantity. The imaginary part is set to zero. *)
    class operator :=(const AQuantity: TQuantity): TComplexQuantity;

    (** Returns @true if both operands have the same dimension and equal complex values. *)
    class operator =(const ALeft, ARight: TComplexQuantity): boolean; inline;

    (** Returns @true if the operands differ in dimension or in complex value. *)
    class operator <>(const ALeft, ARight: TComplexQuantity): boolean; inline;

    (** Unary plus. Returns the complex quantity unchanged. *)
    class operator +(const AValue: TComplexQuantity): TComplexQuantity; inline;

    (** Unary minus. Returns the negation of the complex quantity. *)
    class operator -(const AValue: TComplexQuantity): TComplexQuantity; inline;

    (** Returns the sum of two complex quantities. Both operands must have the same dimension. *)
    class operator +(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;

    (** Returns the difference of two complex quantities. Both operands must have the same dimension. *)
    class operator -(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;

    (** Returns the product of two complex quantities. The resulting dimension is the product of the two dimensions. *)
    class operator *(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;

    (** Returns the product of a dimensionless real scalar and a complex quantity. *)
    class operator *(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity; inline;

    (** Returns the product of a complex quantity and a dimensionless real scalar. *)
    class operator *(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity; inline;

    (** Returns the product of a real quantity and a complex quantity. The resulting dimension is the product of the two dimensions. *)
    class operator *(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;

    (** Returns the product of a complex quantity and a real quantity. The resulting dimension is the product of the two dimensions. *)
    class operator *(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;

    (**
      Returns the quotient of two complex quantities.
      The resulting dimension is the ratio of the two dimensions.
      @raises(Exception if the divisor is zero.)
    *)
    class operator /(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;

    (** Returns the quotient of a dimensionless real scalar divided by a complex quantity. *)
    class operator /(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity; inline;

    (** Returns the quotient of a complex quantity divided by a dimensionless real scalar. *)
    class operator /(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity; inline;

    (** Returns the quotient of a real quantity divided by a complex quantity. The resulting dimension is the ratio of the two dimensions. *)
    class operator /(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;

    (** Returns the quotient of a complex quantity divided by a real quantity. The resulting dimension is the ratio of the two dimensions. *)
    class operator /(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;

    (** Returns the sum of a real quantity and a complex quantity. Both operands must have the same dimension. *)
    class operator +(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;

    (** Returns the sum of a complex quantity and a real quantity. Both operands must have the same dimension. *)
    class operator +(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;

    (** Returns the difference of a real quantity and a complex quantity. Both operands must have the same dimension. *)
    class operator -(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;

    (** Returns the difference of a complex quantity and a real quantity. Both operands must have the same dimension. *)
    class operator -(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
  end;
  {$ELSE}
  TComplexQuantity = TComplex;
  {$ENDIF}

  (**
    Represents the imaginary unit @code(i), defined by @code(i² = -1).

    This record has no fields: it acts as a compile-time constant used to construct
    @link(TComplex) numbers naturally via operator overloading
    (e.g. @code(3*i), @code(1 + 2*i), @code(z*i)).
    A global constant of this type (conventionally named @code(i)) should be declared
    to allow idiomatic use in expressions.
    Supports arithmetic with real numbers, @link(TComplex) numbers, and optionally
    with dimensional quantities (@link(TQuantity) / @link(TComplexQuantity)).
  *)
  TImaginaryUnit = record
  public
    (**
    Implicit conversion of the imaginary unit to a @link(TComplex) number.
      Returns @code(TComplex(Re=0, Im=1)).
    *)
    class operator :=(const ASelf: TImaginaryUnit): TComplex;

    (**
      Returns the product of the imaginary unit with itself: @code(i·i = -1).
      The result is a plain @code(double).
    *)
    class operator *(const ALeft, ARight: TImaginaryUnit): double;

    (**
      Returns the quotient of the imaginary unit divided by itself: @code(i/i = 1).
      The result is a plain @code(double).
    *)
    class operator /(const ALeft, ARight: TImaginaryUnit): double;

    (**
      Unary minus. Returns the negation of the imaginary unit as a @link(TComplex) number.
      Result: @code(TComplex(Re=0, Im=-1)).
    *)
    class operator -(const AValue: TImaginaryUnit): TComplex;

    (**
      Unary plus. Returns the imaginary unit as a @link(TComplex) number unchanged.
      Result: @code(TComplex(Re=0, Im=1)).
    *)
    class operator +(const AValue: TImaginaryUnit): TComplex;

    (** Returns the sum of a real number and the imaginary unit: @code(a + i = a + 1·i). *)
    class operator +(const ALeft: double; const ARight: TImaginaryUnit): TComplex;

    (** Returns the sum of the imaginary unit and a real number: @code(i + a = a + 1·i). *)
    class operator +(const ALeft: TImaginaryUnit; const ARight: double): TComplex;

    (** Returns the difference of a real number and the imaginary unit: @code(a - i = a - 1·i). *)
    class operator -(const ALeft: double; const ARight: TImaginaryUnit): TComplex;

    (** Returns the difference of the imaginary unit and a real number: @code(i - a = -a + 1·i). *)
    class operator -(const ALeft: TImaginaryUnit; const ARight: double): TComplex;

    (** Returns the sum of a complex number and the imaginary unit: @code((a+bi) + i = a + (b+1)i). *)
    class operator +(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    (** Returns the sum of the imaginary unit and a complex number: @code(i + (a+bi) = a + (b+1)i). *)
    class operator +(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    (** Returns the difference of a complex number and the imaginary unit: @code((a+bi) - i = a + (b-1)i). *)
    class operator -(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    (** Returns the difference of the imaginary unit and a complex number: @code(i - (a+bi) = -a + (1-b)i). *)
    class operator -(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    (** Returns the product of a real number and the imaginary unit: @code(a·i = 0 + ai). *)
    class operator *(const ALeft: double; const ARight: TImaginaryUnit): TComplex;

    (** Returns the product of the imaginary unit and a real number: @code(i·a = 0 + ai). *)
    class operator *(const ALeft: TImaginaryUnit; const ARight: double): TComplex;

    (** Returns the product of a complex number and the imaginary unit: @code((a+bi)·i = -b + ai). *)
    class operator *(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    (** Returns the product of the imaginary unit and a complex number: @code(i·(a+bi) = -b + ai). *)
    class operator *(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    (** Returns the quotient of a real number divided by the imaginary unit: @code(a/i = 0 - ai). *)
    class operator /(const ALeft: double; const ARight: TImaginaryUnit): TComplex;

    (** Returns the quotient of the imaginary unit divided by a real number: @code(i/a = 0 + (1/a)i). *)
    class operator /(const ALeft: TImaginaryUnit; const ARight: double): TComplex;

    (** Returns the quotient of a complex number divided by the imaginary unit: @code((a+bi)/i = b - ai). *)
    class operator /(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    (** Returns the quotient of the imaginary unit divided by a complex number: @code(i/(a+bi) = b/(a²+b²) + (-a/(a²+b²))i). *)
    class operator /(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    {$IFNDEF ADIMOFF}
    (** Returns the product of a dimensional quantity and the imaginary unit. The dimension is preserved. *)
    class operator *(const ALeft: TQuantity; const ARight: TImaginaryUnit): TComplexQuantity;

    (** Returns the product of the imaginary unit and a dimensional quantity. The dimension is preserved. *)
    class operator *(const ALeft: TImaginaryUnit; const ARight: TQuantity): TComplexQuantity;

    (** Returns the quotient of the imaginary unit divided by a dimensional quantity. The resulting dimension is the inverse of @code(ARight). *)
    class operator /(const ALeft: TImaginaryUnit; const ARight: TQuantity): TComplexQuantity;

    (** Returns the quotient of a dimensional quantity divided by the imaginary unit. The dimension is preserved. *)
    class operator /(const ALeft: TQuantity; const ARight: TImaginaryUnit): TComplexQuantity;
    {$ENDIF}
  end;

