type

  // TComplex

  TComplex = record
  private
    FRe, FIm: double;
  public
    function Re: double;
    function Im: double;
    function Dual: TComplex;
    function Reciprocal: TComplex;
    function Norm: double;
    function SquaredNorm: double;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;

    class operator :=(const AValue: double): TComplex; inline;
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

    class operator =(const ALeft, ARight: TComplex): boolean; inline;
    class operator <>(const ALeft, ARight: TComplex): boolean; inline;
  end;

  // TImaginaryUnit

  TImaginaryUnit = record
    class operator *(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
    class operator *(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
    class operator *(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
    class operator *(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    class operator /(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
    class operator /(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
    class operator /(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
    class operator /(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
  end;

var
  img: TImaginaryUnit; 
