
  { Represents a complex number in Cartesian form: z = Re + i⋅Im.

    A complex number has:
      - Re = real part,
      - Im = imaginary part

    The imaginary unit i is defined by i² = -1. }
  TComplex = record
  private
    fRe, fIm: double;
  public
    { Returns the argument (angle) of the complex number in radians. }
    function Arg: double;

    { Returns the complex conjugate.

    If z = (a + i⋅b), the conjugate is (a - i⋅b) }
    function Conjugate: TComplex;

    { Returns TRUE if both real and imaginary parts are zero. }
    function IsNull: boolean;

    { Returns TRUE if the number is not zero. }
    function IsNotNull: boolean;

    { Returns the magnitude (modulus) of the number.

      |z| = √(Re² + Im²) }
    function Norm: double;

    { Returns the squared magnitude.

      z² = Re² + Im² }
    function SquaredNorm: double;

    { Returns the reciprocal (1 / z).

      Raises an exception if the number is zero. }
    function Reciprocal: TComplex;

    { Converts the complex number to a string. }
    function ToString: string;

    { Converts the complex number to a formatted string.

      @param APrecision Floating point precision.
      @param ADigits Number of digits. }
    function ToString(APrecision, ADigits: integer): string;

    { Implicit conversion from real value.

      The imaginary part is set to zero. }
    class operator :=(const AValue: double): TComplex;

    { Equality comparison operator. }
    class operator =(const ALeft, ARight: TComplex): boolean; inline;

    { Inequality comparison operator. }
    class operator <>(const ALeft, ARight: TComplex): boolean; inline;

    { Unary plus operator. }
    class operator +(const AValue: TComplex): TComplex; inline;

    { Addition between two complex numbers. }
    class operator +(const ALeft, ARight: TComplex): TComplex; inline;

    { Addition between real and complex number. }
    class operator +(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Addition between complex and real number. }
    class operator +(const ALeft: TComplex; const ARight: double): TComplex; inline;

    { Unary minus operator. }
    class operator -(const AValue: TComplex): TComplex; inline;

    { Subtraction between two complex numbers. }
    class operator -(const ALeft, ARight: TComplex): TComplex; inline;

    { Subtraction between real and complex number. }
    class operator -(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Subtraction between complex and real number. }
    class operator -(const ALeft: TComplex; const ARight: double): TComplex; inline;

    { Multiplication between two complex numbers.

      (a + bi)(c + di) = (ac - bd) + (ad + bc)i }
    class operator *(const ALeft, ARight: TComplex): TComplex; inline;

    { Multiplication between real and complex number. }
    class operator *(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Multiplication between complex and real number. }
    class operator *(const ALeft: TComplex; const ARight: double): TComplex; inline;

    { Division between two complex numbers.

      Raises an exception if the divisor is zero. }
    class operator /(const ALeft, ARight: TComplex): TComplex; inline;

    { Division between real and complex number. }
    class operator /(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Division between complex and real number. }
    class operator /(const ALeft: TComplex; const ARight: double): TComplex; inline;
  public
    { Real part of the complex number. }
    property Re: double read fRe write fRe;

    { Imaginary part of the complex number. }
    property Im: double read fIm write fIm;
  end;

  { Represents a complex quantity with dimensions.

    Combines a complex number (value) with a dimension.

    Supports arithmetic operations while preserving dimensional consistency. }
  {$IFNDEF ADIMOFF}
  TComplexQuantity = record
  private
    FDim: TDimension;
    FValue: TComplex;
  public
    { Assigns a real quantity to a complex quantity. }
    class operator :=(const AQuantity: TQuantity): TComplexQuantity;

    { Equality comparison between two complex quantities. }
    class operator =(const ALeft, ARight: TComplexQuantity): boolean; inline;

    { Inequality comparison between two complex quantities. }
    class operator <>(const ALeft, ARight: TComplexQuantity): boolean; inline;

    { Unary plus operator. }
    class operator +(const AValue: TComplexQuantity): TComplexQuantity; inline;

    { Addition between two complex quantities. }
    class operator +(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;

    { Unary minus operator. }
    class operator -(const AValue: TComplexQuantity): TComplexQuantity; inline;

    { Subtraction between two complex quantities. }
    class operator -(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;

    { Multiplication between two complex quantities. }
    class operator *(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;

    { Multiplication between a real scalar and a complex quantity. }
    class operator *(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity; inline;

    { Multiplication between a complex quantity and a real scalar. }
    class operator *(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity; inline;

    { Division between two complex quantities. }
    class operator /(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;

    { Division of a real scalar by a complex quantity. }
    class operator /(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity; inline;

    { Division of a complex quantity by a real scalar. }
    class operator /(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity; inline;

    { Addition of a real quantity and a complex quantity. }
    class operator +(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;

    { Addition of a complex quantity and a real quantity. }
    class operator +(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;

    { Subtraction of a real quantity and a complex quantity. }
    class operator -(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;

    { Subtraction of a complex quantity and a real quantity. }
    class operator -(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;

    { Multiplication of a real quantity and a complex quantity. }
    class operator *(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;

    { Multiplication of a complex quantity and a real quantity. }
    class operator *(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;

    { Division of a real quantity by a complex quantity. }
    class operator /(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;

    { Division of a complex quantity by a real quantity. }
    class operator /(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
  end;
  {$ELSE}
  TComplexQuantity = TComplex;
  {$ENDIF}

  { Represents a purely imaginary number: z = i⋅b

    Only the imaginary part is non-zero.

    Supports arithmetic operations with real numbers, complex numbers,
    and optionally with quantities (TQuantity/TComplexQuantity). }
  TImaginaryNumber = record
  public
    { Implicit conversion to a complex number. }
    class operator :=(const ASelf: TImaginaryNumber): TComplex;

    { Addition of a real number and an imaginary number. }
    class operator +(const ALeft: double; const ARight: TImaginaryNumber): TComplex;

    { Addition of an imaginary number and a real number. }
    class operator +(const ALeft: TImaginaryNumber; const ARight: double): TComplex;

    { Subtraction of an imaginary number from a real number. }
    class operator -(const ALeft: double; const ARight: TImaginaryNumber): TComplex;

    { Subtraction of a real number from an imaginary number. }
    class operator -(const ALeft: TImaginaryNumber; const ARight: double): TComplex;

    { Addition of a complex number and an imaginary number. }
    class operator +(const ALeft: TComplex; const ARight: TImaginaryNumber): TComplex;

    { Addition of an imaginary number and a complex number. }
    class operator +(const ALeft: TImaginaryNumber; const ARight: TComplex): TComplex;

    { Subtraction of an imaginary number from a complex number. }
    class operator -(const ALeft: TComplex; const ARight: TImaginaryNumber): TComplex;

    { Subtraction of a complex number from an imaginary number. }
    class operator -(const ALeft: TImaginaryNumber; const ARight: TComplex): TComplex;

    { Multiplication of a real number and an imaginary number. }
    class operator *(const ALeft: double; const ARight: TImaginaryNumber): TComplex;

    { Multiplication of an imaginary number and a real number. }
    class operator *(const ALeft: TImaginaryNumber; const ARight: double): TComplex;

    { Multiplication of a complex number and an imaginary number. }
    class operator *(const ALeft: TComplex; const ARight: TImaginaryNumber): TComplex;

    { Multiplication of an imaginary number and a complex number. }
    class operator *(const ALeft: TImaginaryNumber; const ARight: TComplex): TComplex;

    { Division of a real number by an imaginary number. }
    class operator /(const ALeft: double; const ARight: TImaginaryNumber): TComplex;

    { Division of an imaginary number by a real number. }
    class operator /(const ALeft: TImaginaryNumber; const ARight: double): TComplex;

    { Division of a complex number by an imaginary number. }
    class operator /(const ALeft: TComplex; const ARight: TImaginaryNumber): TComplex;

    { Division of an imaginary number by a complex number. }
    class operator /(const ALeft: TImaginaryNumber; const ARight: TComplex): TComplex;

    {$IFNDEF ADIMOFF}
    { Multiplication of a quantity and an imaginary number. }
    class operator *(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;

    { Multiplication of an imaginary number and a quantity. }
    class operator *(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;

    { Division of an imaginary number by a quantity. }
    class operator /(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;

    { Division of a quantity by an imaginary number. }
    class operator /(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;
    {$ENDIF}
  end;

