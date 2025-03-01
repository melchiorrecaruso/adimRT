{ Complex number interface }

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

  // TKet for vector space 3

  TKet3 = record
  private
    fm1,
    fm2,
    fm3: TComplex;
  public
    class operator +(const ALeft, ARight: TKet3): TKet3;
    class operator -(const ALeft, ARight: TKet3): TKet3;
    class operator *(const ALeft: double; const ARight: TKet3): TKet3;
    class operator *(const ALeft: TKet3; const ARight: double): TKet3;
    class operator /(const ALeft: TKet3; const ARight: double): TKet3;
  public
    property a1: TComplex read fm1 write fm1;
    property a2: TComplex read fm2 write fm2;
    property a3: TComplex read fm3 write fm3;
  end;

  // TBra for vector space 3

  TBra3 = record
  private
    fm1,
    fm2,
    fm3: TComplex;
  public
    class operator +(const ALeft, ARight: TBra3): TBra3;
    class operator -(const ALeft, ARight: TBra3): TBra3;
    class operator *(const ALeft: double; const ARight: TBra3): TBra3;
    class operator *(const ALeft: TBra3; const ARight: double): TBra3;
    class operator *(const ALeft: TBra3; const ARight: TKet3): TComplex;
    class operator /(const ALeft: TBra3; const ARight: double): TBra3;
  public
    property a1: TComplex read fm1 write fm1;
    property a2: TComplex read fm2 write fm2;
    property a3: TComplex read fm3 write fm3;
  end;

  TKet3Helper = record helper for TKet3
     function Bra: TBra3;
     function Norm: double;
     function SquareNorm: double;
   end;

  TBra3Helper = record helper for TBra3
    function Ket: TKet3;
  end;

  T3x3Complex = record
  private
    fm11, fm12, fm13,
    fm21, fm22, fm23,
    fm31, fm32, fm33: TComplex;
  public
    function Dual: T3x3Complex;
    function Transpose: T3x3Complex;
    function TransposeDual: T3x3Complex;
    class operator *(const ALeft: T3x3Complex; const ARight: TKet3): TKet3;
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
