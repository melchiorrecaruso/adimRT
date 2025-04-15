{ Complex number interface }

type

  // TComplex

  TComplex = record
  private
    fRe, fIm: double;
  public
    function Dual: TComplex;
    function IsNull: boolean;
    function IsNotNull: boolean;
    function Norm: double;
    function Reciprocal: TComplex;
    function SquaredNorm: double;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
    class operator :=(const AValue: double): TComplex;
    class operator  =(const ALeft, ARight: TComplex): boolean; inline;
    class operator <>(const ALeft, ARight: TComplex): boolean; inline;

    class operator +(const AValue: TComplex): TComplex; inline;
    class operator +(const ALeft, ARight: TComplex): TComplex; inline;
    class operator +(const ALeft: double; const ARight: TComplex): TComplex; inline;
    class operator +(const ALeft: TComplex; const ARight: double): TComplex; inline;

    class operator -(const AValue: TComplex): TComplex; inline;
    class operator -(const ALeft, ARight: TComplex): TComplex; inline;
    class operator -(const ALeft: double; const ARight: TComplex): TComplex; inline;
    class operator -(const ALeft: TComplex; const ARight: double): TComplex; inline;

    class operator *(const ALeft, ARight: TComplex): TComplex; inline;
    class operator *(const ALeft: double; const ARight: TComplex): TComplex; inline;
    class operator *(const ALeft: TComplex; const ARight: double): TComplex; inline;

    class operator /(const ALeft, ARight: TComplex): TComplex; inline;
    class operator /(const ALeft: double; const ARight: TComplex): TComplex; inline;
    class operator /(const ALeft: TComplex; const ARight: double): TComplex; inline;
  public
    property Re: double read fRe write fRe;
    property Im: double read fIm write fIm;
  end;

  // TComplexQuantity

  {$IFNDEF ADIMOFF}
  TComplexQuantity = record
  type
    TSelf = TComplexQuantity;
  private
    FID: longint;
    FValue: TComplex;
  public
    class operator:=(const AQuantity: TQuantity): TSelf;
    class operator =(const ALeft, ARight: TSelf): boolean; inline;
    class operator<>(const ALeft, ARight: TSelf): boolean; inline;
    class operator +(const AValue: TSelf): TSelf; inline;
    class operator +(const ALeft, ARight: TSelf): TSelf; inline;
    class operator -(const AValue: TSelf): TSelf; inline;
    class operator -(const ALeft, ARight: TSelf): TSelf; inline;
    class operator *(const ALeft, ARight: TSelf): TSelf; inline;
    class operator *(const ALeft: double; const ARight: TSelf): TSelf; inline;
    class operator *(const ALeft: TSelf; const ARight: double): TSelf; inline;
    class operator /(const ALeft, ARight: TSelf): TSelf; inline;
    class operator /(const ALeft: double; const ARight: TSelf): TSelf; inline;
    class operator /(const ALeft: TSelf; const ARight: double): TSelf; inline;

    class operator +(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator +(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
    class operator -(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator -(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
    class operator *(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator *(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
    class operator /(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
  end;
  {$ELSE}
  TComplexQuantity = TComplex;
  {$ENDIF}

  // TImaginaryNumber

  TImaginaryNumber = record
  type
    TSelf = TImaginaryNumber;
  public
    class operator:=(const ASelf: TSelf): TComplex;
    class operator +(const ALeft: double; const ARight: TSelf): TComplex;
    class operator +(const ALeft: TSelf; const ARight: double): TComplex;
    class operator -(const ALeft: double; const ARight: TSelf): TComplex;
    class operator -(const ALeft: TSelf; const ARight: double): TComplex;
    class operator +(const ALeft: TComplex; const ARight: TSelf): TComplex;
    class operator +(const ALeft: TSelf; const ARight: TComplex): TComplex;
    class operator -(const ALeft: TComplex; const ARight: TSelf): TComplex;
    class operator -(const ALeft: TSelf; const ARight: TComplex): TComplex;
    class operator *(const ALeft: double; const ARight: TSelf): TComplex;
    class operator *(const ALeft: TSelf; const ARight: double): TComplex;
    class operator *(const ALeft: TComplex; const ARight: TSelf): TComplex;
    class operator *(const ALeft: TSelf; const ARight: TComplex): TComplex;
    class operator /(const ALeft: double; const ARight: TSelf): TComplex;
    class operator /(const ALeft: TSelf; const ARight: double): TComplex;
    class operator /(const ALeft: TComplex; const ARight: TSelf): TComplex;
    class operator /(const ALeft: TSelf; const ARight: TComplex): TComplex;
    {$IFNDEF ADIMOFF}
    class operator *(const ALeft: TQuantity; const ARight: TSelf): TComplexQuantity;
    class operator *(const ALeft: TSelf; const ARight: TQuantity): TComplexQuantity;
    class operator /(const ALeft: TSelf; const ARight: TQuantity): TComplexQuantity;
    class operator /(const ALeft: TQuantity; const ARight: TSelf): TComplexQuantity;
    {$ENDIF}
  end;

