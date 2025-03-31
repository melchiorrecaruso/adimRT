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
  public
    property Re: double read fRe write fRe;
    property Im: double read fIm write fIm;
  end;



