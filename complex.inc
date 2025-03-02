{ Complex number interface }

type

  // TComplex

  TComplex = record
  private
    fRe, fIm: double;
  public
    function Dual: TComplex;
    function Reciprocal: TComplex;
    function Norm: double;
    function SquaredNorm: double;
    function IsNull: boolean;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
    function SameValue(const AComplex: TComplex): boolean;

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

  TComplexMatrix = record
  private
    fm11, fm12, fm13,
    fm21, fm22, fm23,
    fm31, fm32, fm33: TComplex;
  public
    function Dual: TComplexMatrix;
    function Transpose: TComplexMatrix;
    function TransposeDual: TComplexMatrix;
    function SameValue(const AMatrix: TComplexMatrix): boolean;
    class operator +(const ALeft, ARight: TComplexMatrix): TComplexMatrix;
    class operator -(const ALeft, ARight: TComplexMatrix): TComplexMatrix;
    class operator *(const ALeft: double; const ARight: TComplexMatrix): TComplexMatrix;
    class operator *(const ALeft: TComplexMatrix; const ARight: double): TComplexMatrix;
    class operator *(const ALeft: TComplex; const ARight: TComplexMatrix): TComplexMatrix;
    class operator *(const ALeft: TComplexMatrix; const ARight: TComplex): TComplexMatrix;
    class operator *(const ALeft, ARight: TComplexMatrix): TComplexMatrix;
    class operator /(const ALeft: TComplexMatrix; const ARight: double): TComplexMatrix;
    class operator /(const ALeft: TComplexMatrix; const ARight: TComplex): TComplexMatrix;
  public
    property a11: TComplex read fm11 write fm11;
    property a12: TComplex read fm12 write fm12;
    property a13: TComplex read fm13 write fm13;
    property a21: TComplex read fm21 write fm21;
    property a22: TComplex read fm22 write fm22;
    property a23: TComplex read fm23 write fm23;
    property a31: TComplex read fm31 write fm31;
    property a32: TComplex read fm32 write fm32;
    property a33: TComplex read fm33 write fm33;
  end;

  // TKet for Hilbert space 3

  TKet = record
  private
    fm1, fm2, fm3: TComplex;
  public
    class operator +(const ALeft, ARight: TKet): TKet;
    class operator -(const ALeft, ARight: TKet): TKet;
    class operator *(const ALeft: double; const ARight: TKet): TKet;
    class operator *(const ALeft: TKet; const ARight: double): TKet;
    class operator *(const ALeft: TComplex; const ARight: TKet): TKet;
    class operator *(const ALeft: TKet; const ARight: TComplex): TKet;
    class operator *(const ALeft: TComplexMatrix; const ARight: TKet): TKet;
    class operator /(const ALeft: TKet; const ARight: double): TKet;
    class operator /(const ALeft: TKet; const ARight: TComplex): TKet;
  public
    property a1: TComplex read fm1 write fm1;
    property a2: TComplex read fm2 write fm2;
    property a3: TComplex read fm3 write fm3;
  end;

  // TBra for Hilbert space 3

  TBra = record
  private
    fm1, fm2, fm3: TComplex;
  public
    class operator +(const ALeft, ARight: TBra): TBra;
    class operator -(const ALeft, ARight: TBra): TBra;
    class operator *(const ALeft: double; const ARight: TBra): TBra;
    class operator *(const ALeft: TBra; const ARight: double): TBra;
    class operator *(const ALeft: TComplex; const ARight: TBra): TBra;
    class operator *(const ALeft: TBra; const ARight: TComplex): TBra;
    class operator *(const ALeft: TBra; const ARight: TKet): TComplex;
    class operator *(const ALeft: TKet; const ARight: TBra): TComplexMatrix;
    class operator *(const ALeft: TBra; const ARight: TComplexMatrix): TBra;
    class operator /(const ALeft: TBra; const ARight: double): TBra;
    class operator /(const ALeft: TBra; const ARight: TComplex): TBra;
  public
    property a1: TComplex read fm1 write fm1;
    property a2: TComplex read fm2 write fm2;
    property a3: TComplex read fm3 write fm3;
  end;

  TKetHelper = record helper for TKet
    function SquareNorm: double;
    function Norm: double;
    function TransposeDual: TBra;
    function IsNull: boolean;
    function SameValue(const AVector: TKet): boolean;
  end;

  TBraHelper = record helper for TBra
    function SquareNorm: double;
    function Norm: double;
    function TransposeDual: TKet;
    function IsNull: boolean;
    function SameValue(const AVector: TBra): boolean;
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

  function Ket(const a1, a2, a3: TComplex): TKet;
  function Bra(const a1, a2, a3: TComplex): TBra;
  function ComplexMatrix(const a11, a12, a13, a21, a22, a23, a31, a32, a33: TComplex): TComplexMatrix;
  function Commutator(const ALeft, ARight: TComplexMatrix): TComplexMatrix;

const
  NullComplex: TComplex = (FRe: 0; fIm: 0);
  NullMatrix : TComplexMatrix =
    (fm11: (fRe: 0; fIm:0); fm12: (fRe: 0; fIm:0); fm13: (fRe: 0; fIm:0);
     fm21: (fRe: 0; fIm:0); fm22: (fRe: 0; fIm:0); fm23: (fRe: 0; fIm:0);
     fm31: (fRe: 0; fIm:0); fm32: (fRe: 0; fIm:0); fm33: (fRe: 0; fIm:00)
    );

var
  img: TImaginaryUnit;

