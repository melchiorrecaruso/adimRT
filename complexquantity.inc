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

    class operator /(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity; inline;
    class operator /(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
  end;
  {$ELSE}
  TComplexQuantity = TComplex;
  {$ENDIF}

{$IFNDEF ADIMOFF}
  operator *(const ALeft: TQuantity; const ARight: TImaginaryUnit): TComplexQuantity;
  operator *(const ALeft: TImaginaryUnit; const ARight: TQuantity): TComplexQuantity;
  operator /(const ALeft: TImaginaryUnit; const ARight: TQuantity): TComplexQuantity;
  operator /(const ALeft: TQuantity; const ARight: TImaginaryUnit): TComplexQuantity;
{$ENDIF}
