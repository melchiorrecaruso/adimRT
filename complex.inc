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

  TC2Matrix = record
  private
    fm11, fm12,
    fm21, fm22: TComplex;
  public
    function Dual: TC2Matrix;
    function Transpose: TC2Matrix;
    function TransposeDual: TC2Matrix;
    function Determinant: TComplex;
    function Reciprocal(const ADeterminant: TComplex): TC2Matrix;
    class operator +(const ALeft, ARight: TC2Matrix): TC2Matrix;
    class operator -(const ALeft, ARight: TC2Matrix): TC2Matrix;
    class operator *(const ALeft: double; const ARight: TC2Matrix): TC2Matrix;
    class operator *(const ALeft: TC2Matrix; const ARight: double): TC2Matrix;
    class operator *(const ALeft: TComplex; const ARight: TC2Matrix): TC2Matrix;
    class operator *(const ALeft: TC2Matrix; const ARight: TComplex): TC2Matrix;
    class operator *(const ALeft, ARight: TC2Matrix): TC2Matrix;
    class operator /(const ALeft: TC2Matrix; const ARight: double): TC2Matrix;
    class operator /(const ALeft: TC2Matrix; const ARight: TComplex): TC2Matrix;
  public
    property a11: TComplex read fm11 write fm11;
    property a12: TComplex read fm12 write fm12;
    property a21: TComplex read fm21 write fm21;
    property a22: TComplex read fm22 write fm22;
  end;

  TC3Matrix = record
  private
    fm11, fm12, fm13,
    fm21, fm22, fm23,
    fm31, fm32, fm33: TComplex;
  public
    function Dual: TC3Matrix;
    function Transpose: TC3Matrix;
    function TransposeDual: TC3Matrix;
    function Determinant: TComplex;
    function Reciprocal(const ADeterminant: TComplex): TC3Matrix;
    class operator +(const ALeft, ARight: TC3Matrix): TC3Matrix;
    class operator -(const ALeft, ARight: TC3Matrix): TC3Matrix;
    class operator *(const ALeft: double; const ARight: TC3Matrix): TC3Matrix;
    class operator *(const ALeft: TC3Matrix; const ARight: double): TC3Matrix;
    class operator *(const ALeft: TComplex; const ARight: TC3Matrix): TC3Matrix;
    class operator *(const ALeft: TC3Matrix; const ARight: TComplex): TC3Matrix;
    class operator *(const ALeft, ARight: TC3Matrix): TC3Matrix;
    class operator /(const ALeft: TC3Matrix; const ARight: double): TC3Matrix;
    class operator /(const ALeft: TC3Matrix; const ARight: TComplex): TC3Matrix;
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

  // TKet for Hilbert space

  TC2Ket = record
  private
    fm1, fm2: TComplex;
  public
    class operator +(const ALeft, ARight: TC2Ket): TC2Ket;
    class operator -(const ALeft, ARight: TC2Ket): TC2Ket;
    class operator *(const ALeft: double; const ARight: TC2Ket): TC2Ket;
    class operator *(const ALeft: TC2Ket; const ARight: double): TC2Ket;
    class operator *(const ALeft: TComplex; const ARight: TC2Ket): TC2Ket;
    class operator *(const ALeft: TC2Ket; const ARight: TComplex): TC2Ket;
    class operator *(const ALeft: TC2Matrix; const ARight: TC2Ket): TC2Ket;
    class operator /(const ALeft: TC2Ket; const ARight: double): TC2Ket;
    class operator /(const ALeft: TC2Ket; const ARight: TComplex): TC2Ket;
  public
    property a1: TComplex read fm1 write fm1;
    property a2: TComplex read fm2 write fm2;
  end;

  TC3Ket = record
  private
    fm1, fm2, fm3: TComplex;
  public
    class operator +(const ALeft, ARight: TC3Ket): TC3Ket;
    class operator -(const ALeft, ARight: TC3Ket): TC3Ket;
    class operator *(const ALeft: double; const ARight: TC3Ket): TC3Ket;
    class operator *(const ALeft: TC3Ket; const ARight: double): TC3Ket;
    class operator *(const ALeft: TComplex; const ARight: TC3Ket): TC3Ket;
    class operator *(const ALeft: TC3Ket; const ARight: TComplex): TC3Ket;
    class operator *(const ALeft: TC3Matrix; const ARight: TC3Ket): TC3Ket;
    class operator /(const ALeft: TC3Ket; const ARight: double): TC3Ket;
    class operator /(const ALeft: TC3Ket; const ARight: TComplex): TC3Ket;
  public
    property a1: TComplex read fm1 write fm1;
    property a2: TComplex read fm2 write fm2;
    property a3: TComplex read fm3 write fm3;
  end;

  // TBra for Hilbert space

  TC2Bra = record
  private
    fm1, fm2: TComplex;
  public
    class operator +(const ALeft, ARight: TC2Bra): TC2Bra;
    class operator -(const ALeft, ARight: TC2Bra): TC2Bra;
    class operator *(const ALeft: double; const ARight: TC2Bra): TC2Bra;
    class operator *(const ALeft: TC2Bra; const ARight: double): TC2Bra;
    class operator *(const ALeft: TComplex; const ARight: TC2Bra): TC2Bra;
    class operator *(const ALeft: TC2Bra; const ARight: TComplex): TC2Bra;
    class operator *(const ALeft: TC2Bra; const ARight: TC2Ket): TComplex;
    class operator *(const ALeft: TC2Ket; const ARight: TC2Bra): TC2Matrix;
    class operator *(const ALeft: TC2Bra; const ARight: TC2Matrix): TC2Bra;
    class operator /(const ALeft: TC2Bra; const ARight: double): TC2Bra;
    class operator /(const ALeft: TC2Bra; const ARight: TComplex): TC2Bra;
  public
    property a1: TComplex read fm1 write fm1;
    property a2: TComplex read fm2 write fm2;
  end;

  TC3Bra = record
  private
    fm1, fm2, fm3: TComplex;
  public
    class operator +(const ALeft, ARight: TC3Bra): TC3Bra;
    class operator -(const ALeft, ARight: TC3Bra): TC3Bra;
    class operator *(const ALeft: double; const ARight: TC3Bra): TC3Bra;
    class operator *(const ALeft: TC3Bra; const ARight: double): TC3Bra;
    class operator *(const ALeft: TComplex; const ARight: TC3Bra): TC3Bra;
    class operator *(const ALeft: TC3Bra; const ARight: TComplex): TC3Bra;
    class operator *(const ALeft: TC3Bra; const ARight: TC3Ket): TComplex;
    class operator *(const ALeft: TC3Ket; const ARight: TC3Bra): TC3Matrix;
    class operator *(const ALeft: TC3Bra; const ARight: TC3Matrix): TC3Bra;
    class operator /(const ALeft: TC3Bra; const ARight: double): TC3Bra;
    class operator /(const ALeft: TC3Bra; const ARight: TComplex): TC3Bra;
  public
    property a1: TComplex read fm1 write fm1;
    property a2: TComplex read fm2 write fm2;
    property a3: TComplex read fm3 write fm3;
  end;

  // Helpers

  TC2KetHelper = record helper for TC2Ket
    function SquareNorm: double;
    function Norm: double;
    function Normalize: TC2Ket;
    function TransposeDual: TC2Bra;
    function IsNull: boolean;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC3KetHelper = record helper for TC3Ket
    function SquareNorm: double;
    function Norm: double;
    function TransposeDual: TC3Bra;
    function IsNull: boolean;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC2BraHelper = record helper for TC2Bra
    function SquareNorm: double;
    function Norm: double;
    function Normalize: TC2Bra;
    function TransposeDual: TC2Ket;
    function IsNull: boolean;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC3BraHelper = record helper for TC3Bra
    function SquareNorm: double;
    function Norm: double;
    function TransposeDual: TC3Ket;
    function IsNull: boolean;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TSwapValue = (swNone, sw12, sw13, sw14, sw23, sw24, sw34);

  TC2MatrixHelper = record helper for TC2Matrix
    function Trace: TComplex;
    function Eigenvalues: TC2Ket;
    function Eigenvector(const AEigenValue: TComplex): TC2Ket;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC3MatrixHelper = record helper for TC3Matrix
    function SwapRow(ASwap: TSwapValue): TC3Matrix;
    function Trace: TComplex;
    function Eigenvalues: TC3Ket;
    function Eigenvector(const AEigenValue: TComplex): TC3Ket;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

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
  end;

const
  NullComplex: TComplex = (FRe: 0; fIm: 0);

  C2NullBra : TC2Bra = (fm1:(fRe:0; fIm:0); fm2:(fRe:0; fIm:0));
  C2NullKet : TC2Ket = (fm1:(fRe:0; fIm:0); fm2:(fRe:0; fIm:0));
  C2NullMatrix : TC2Matrix =
    (fm11: (fRe: 0; fIm:0); fm12:(fRe: 0; fIm:0);
     fm21: (fRe: 0; fIm:0); fm22:(fRe: 0; fIm:0));

  C3NullBra : TC3Bra = (fm1:(fRe:0; fIm:0); fm2:(fRe:0; fIm:0); fm3:(fRe:0; fIm:0));
  C3NullKet : TC3Ket = (fm1:(fRe:0; fIm:0); fm2:(fRe:0; fIm:0); fm3:(fRe:0; fIm:0));
  C3NullMatrix : TC3Matrix =
    (fm11:(fRe: 0; fIm:0); fm12:(fRe: 0; fIm:0); fm13:(fRe: 0; fIm:0);
     fm21:(fRe: 0; fIm:0); fm22:(fRe: 0; fIm:0); fm23:(fRe: 0; fIm:0);
     fm31:(fRe: 0; fIm:0); fm32:(fRe: 0; fIm:0); fm33:(fRe: 0; fIm:0));

function SquarePower(const AValue: TComplex): TComplex;
function SquareRoot(const AValue: TComplex): TC2Ket;
function CubicPower(const AValue: TComplex): TComplex;
function CubicRoot(const AValue: TComplex): TC3Ket;

function Commutator(const ALeft, ARight: TC2Matrix): TC2Matrix;
function Commutator(const ALeft, ARight: TC3Matrix): TC3Matrix;

function SameValue(const AValue1, AValue2: TComplex): boolean;
function SameValue(const AValue1, AValue2: TC2Ket): boolean;
function SameValue(const AValue1, AValue2: TC3Ket): boolean;
function SameValue(const AValue1, AValue2: TC2Bra): boolean;
function SameValue(const AValue1, AValue2: TC3Bra): boolean;
function SameValue(const AValue1, AValue2: TC2Matrix): boolean;
function SameValue(const AValue1, AValue2: TC3Matrix): boolean;

function SolveEquation3(const a, b, c: TComplex): TC3Ket;


