{ Complex quantity interface }

type

  // TComplexQuantity

  {$IFNDEF ADIMOFF}
  TComplexQuantity = record
  private
    FID: longint;
    FValue: TComplex;
  public
    function Dual: TComplexQuantity;
    function Reciprocal: TComplexQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;
    class operator:=(const AValue: TComplex): TComplexQuantity;
    class operator =(const ALeft, ARight: TComplexQuantity): boolean; inline;
    class operator<>(const ALeft, ARight: TComplexQuantity): boolean; inline;

    class operator +(const AValue: TComplexQuantity): TComplexQuantity; inline;
    class operator +(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator +(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator +(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;

    class operator -(const AValue: TComplexQuantity): TComplexQuantity; inline;
    class operator -(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator -(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator -(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;

    class operator *(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator *(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator *(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity; inline;
    class operator *(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator *(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
    {$IFNDEF ADIMOFF}
    class operator /(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity; inline;
    class operator /(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
    {$ENDIF}
  end;
  {$ELSE}
  TComplexQuantity = TComplex;
  {$ENDIF}

  // TImaginaryNumber

  TImaginaryNumber = record
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

