
  { TComplex }

  TComplex = record
  private
    fRe, fIm: double;
  public
    function Conjugate: TComplex;
    function IsNull: boolean;
    function IsNotNull: boolean;
    function Norm: double;
    function Reciprocal: TComplex;
    function SquaredNorm: double;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
    class operator:=(const AValue: double): TComplex;
    class operator =(const ALeft, ARight: TComplex): boolean; inline;
    class operator<>(const ALeft, ARight: TComplex): boolean; inline;

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

  { TComplexQuantity }

  {$IFNDEF ADIMOFF}
  TComplexQuantity = record
  private
    FDim: TDimension;
    FValue: TComplex;
  public
    class operator:=(const AQuantity: TQuantity): TComplexQuantity;
    class operator =(const ALeft, ARight: TComplexQuantity): boolean; inline;
    class operator<>(const ALeft, ARight: TComplexQuantity): boolean; inline;
    class operator +(const AValue: TComplexQuantity): TComplexQuantity; inline;
    class operator +(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator -(const AValue: TComplexQuantity): TComplexQuantity; inline;
    class operator -(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator *(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator *(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator *(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity; inline;
    class operator /(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity; inline;

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

  { TImaginaryNumber }

  TImaginaryNumber = record
  public
    class operator:=(const ASelf: TImaginaryNumber): TComplex;
    class operator +(const ALeft: double; const ARight: TImaginaryNumber): TComplex;
    class operator +(const ALeft: TImaginaryNumber; const ARight: double): TComplex;
    class operator -(const ALeft: double; const ARight: TImaginaryNumber): TComplex;
    class operator -(const ALeft: TImaginaryNumber; const ARight: double): TComplex;
    class operator +(const ALeft: TComplex; const ARight: TImaginaryNumber): TComplex;
    class operator +(const ALeft: TImaginaryNumber; const ARight: TComplex): TComplex;
    class operator -(const ALeft: TComplex; const ARight: TImaginaryNumber): TComplex;
    class operator -(const ALeft: TImaginaryNumber; const ARight: TComplex): TComplex;
    class operator *(const ALeft: double; const ARight: TImaginaryNumber): TComplex;
    class operator *(const ALeft: TImaginaryNumber; const ARight: double): TComplex;
    class operator *(const ALeft: TComplex; const ARight: TImaginaryNumber): TComplex;
    class operator *(const ALeft: TImaginaryNumber; const ARight: TComplex): TComplex;
    class operator /(const ALeft: double; const ARight: TImaginaryNumber): TComplex;
    class operator /(const ALeft: TImaginaryNumber; const ARight: double): TComplex;
    class operator /(const ALeft: TComplex; const ARight: TImaginaryNumber): TComplex;
    class operator /(const ALeft: TImaginaryNumber; const ARight: TComplex): TComplex;
    {$IFNDEF ADIMOFF}
    class operator *(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;
    class operator *(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;
    class operator /(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;
    class operator /(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;
    {$ENDIF}
  end;

