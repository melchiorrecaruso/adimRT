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

  // TMatrix

  generic TMatrix<TType, TSpace> = record
  type
    TSelf = specialize TMatrix<TType, TSpace>;
  private
    fm: array[1..TSpace.N, 1..TSpace.N] of TType;
    procedure Put(ARow, ACol: longint; AValue: TType);
    function Get(ARow, ACol: longint): TType;
  public
    function IsNull: boolean;
    function IsNotNull: boolean;
    function RowReduction: TMatrix;
    procedure Swap(ARow1, ARow2: longint);

    function Trace: TType;
    function Transpose: TSelf;
    function TransposeDual: TSelf;
    class operator +(const ALeft, ARight: TSelf): TSelf;
    class operator -(const ALeft, ARight: TSelf): TSelf;
    class operator *(const ALeft: TType; const ARight: TSelf): TSelf;
    class operator *(const ALeft: TSelf; const ARight: TType): TSelf;
    class operator *(const ALeft, ARight: TSelf): TSelf;
    class operator /(const ALeft: TSelf; const ARight: TType): TSelf;
  public
    property a[ARow, ACol: longint]: TType read Get write Put; default;
  end;

  // TVector

  generic TVector<TType, TSpace> = record
  type
    TSelf = specialize TVector<TType, TSpace>;
    TMatrix = specialize TMatrix<TType, TSpace>;
  private
    fm: array[1..TSpace.N] of TType;
    function Get(ARow: longint): TType;
    procedure Put(ARow: longint; AValue: TType);
  public
    function IsNull: boolean;
    function IsNotNull: boolean;
    function Norm: double;
    function Normalize: TSelf;
    function SquareNorm: double;
    class operator +(const ALeft, ARight: TSelf): TSelf;
    class operator -(const ALeft, ARight: TSelf): TSelf;
    class operator *(const ALeft: TType; const ARight: TSelf): TSelf;
    class operator *(const ALeft: TSelf; const ARight: TType): TSelf;
    class operator *(const ALeft: TMatrix; const ARight: TSelf): TSelf;
    class operator /(const ALeft: TSelf; const ARight: TType): TSelf;
  public
    property a[ARow: longint]: TType read Get write Put; default;
  end;

  // TTransposedVector

  generic TTransposedVector<TType, TSpace> = record
  type
    TSelf = specialize TTransposedVector<TType, TSpace>;
    TVector = specialize TVector<TType, TSpace>;
    TMatrix = specialize TMatrix<TType, TSpace>;
  private
    fm: array[1..TSpace.N] of TType;
    function Get(ACol: longint): TType;
    procedure Put(ACol: longint; AValue: TType);
  public
    function IsNull: boolean;
    function IsNotNull: boolean;
    function Norm: double;
    function Normalize: TSelf;
    function SquareNorm: double;
    class operator +(const ALeft, ARight: TSelf): TSelf;
    class operator -(const ALeft, ARight: TSelf): TSelf;
    class operator *(const ALeft: TType; const ARight: TSelf): TSelf;
    class operator *(const ALeft: TSelf; const ARight: TType): TSelf;
    class operator *(const ALeft: TSelf; const ARight: TVector): TType;
    class operator *(const ALeft: TVector; const ARight: TSelf): TMatrix;
    class operator *(const ALeft: TSelf; const ARight: TMatrix): TSelf;
    class operator /(const ALeft: TSelf; const ARight: TType): TSelf;
  public
    property a[ACol: longint]: TType read Get write Put; default;
  end;

  T2DSpace = record const N = 2; end;
  T3DSpace = record const N = 3; end;
  T4DSpace = record const N = 4; end;

  TC2Vector = specialize TVector<TComplex, T2DSpace>;
  TC3Vector = specialize TVector<TComplex, T3DSpace>;
  TC4Vector = specialize TVector<TComplex, T4DSpace>;

  TC2TransposedVector = specialize TTransposedVector<TComplex, T2DSpace>;
  TC3TransposedVector = specialize TTransposedVector<TComplex, T3DSpace>;
  TC4TransposedVector = specialize TTransposedVector<TComplex, T4DSpace>;

  TC2Matrix = specialize TMatrix<TComplex, T2DSpace>;
  TC3Matrix = specialize TMatrix<TComplex, T3DSpace>;
  TC4Matrix = specialize TMatrix<TComplex, T4DSpace>;

  // TKet for Hilbert space

  TC2Ket = TC2Vector;
  TC3Ket = TC3Vector;
  TC4Ket = TC4Vector;

  // TBra for Hilbert space

  TC2Bra = TC2TransposedVector;
  TC3Bra = TC3TransposedVector;
  TC4Bra = TC4TransposedVector;

  // Helpers

  TC2VectorHelper = record helper for TC2Vector
    function Dual: TC2Vector;
    function Transpose: TC2TransposedVector;
    function TransposeDual: TC2TransposedVector;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC3VectorHelper = record helper for TC3Vector
    function Dual: TC3Vector;
    function Transpose: TC3TransposedVector;
    function TransposeDual: TC3TransposedVector;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC4VectorHelper = record helper for TC4Vector
    function Dual: TC4Vector;
    function Transpose: TC4TransposedVector;
    function TransposeDual: TC4TransposedVector;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC2TransposedVectorHelper = record helper for TC2TransposedVector
    function Dual: TC2TransposedVector;
    function Transpose: TC2Vector;
    function TransposeDual: TC2Vector;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC3TransposedVectorHelper = record helper for TC3TransposedVector
    function Dual: TC3TransposedVector;
    function Transpose: TC3Vector;
    function TransposeDual: TC3Vector;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC4TransposedVectorHelper = record helper for TC4TransposedVector
    function Dual: TC4TransposedVector;
    function Transpose: TC4Vector;
    function TransposeDual: TC4Vector;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC2Array = array[1..T2DSpace.N] of TComplex;
  TC3Array = array[1..T3DSpace.N] of TComplex;
  TC4Array = array[1..T4DSpace.N] of TComplex;

  TC2Eigenvalues = TC2Array;
  TC3Eigenvalues = TC3Array;
  TC4Eigenvalues = TC4Array;

  TC2Eigenvectors = array[1..T2DSpace.N] of TC2Vector;
  TC3Eigenvectors = array[1..T3DSpace.N] of TC3Vector;
  TC4Eigenvectors = array[1..T4DSpace.N] of TC4Vector;

  TC2MatrixHelper = record helper for TC2Matrix
    function Dual: TC2Matrix;
    function Determinant: TComplex;
    function Eigenvalues: TC2Eigenvalues;
    function Eigenvectors(const AEigenValues: TC2Array): TC2Eigenvectors;
    function Reciprocal(const ADeterminant: TComplex): TC2Matrix;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC3MatrixHelper = record helper for TC3Matrix
    function Dual: TC3Matrix;
    function Determinant: TComplex;
    function Eigenvalues: TC3Eigenvalues;
    function Eigenvectors(const AEigenValues: TC3Array): TC3Eigenvectors;
    function Reciprocal(const ADeterminant: TComplex): TC3Matrix;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC4MatrixHelper = record helper for TC4Matrix
    function Dual: TC4Matrix;
    function Determinant: TComplex;
    function Eigenvalues: TC4Eigenvalues;
    function Eigenvectors(const AEigenValues: TC4Array): TC4Eigenvectors;
    function Reciprocal(const ADeterminant: TComplex): TC4Matrix;
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

// Power and root functions

function SquarePower(const AValue: TComplex): TComplex;
function CubicPower(const AValue: TComplex): TComplex;
function QuarticPower(const AValue: TComplex): TComplex;

function SquareRoot(const AValue: TComplex): TC2Array;
function CubicRoot(const AValue: TComplex): TC3Array;
function QuarticRoot(const AValue: TComplex): TC4Array;

// Usefull routines

function Commutator(const ALeft, ARight: TC2Matrix): TC2Matrix;
function Commutator(const ALeft, ARight: TC3Matrix): TC3Matrix;
function Commutator(const ALeft, ARight: TC4Matrix): TC4Matrix;

function SameValue(const AValue1, AValue2: TComplex): boolean;
function SameValue(const AValue1, AValue2: TC2Vector): boolean;
function SameValue(const AValue1, AValue2: TC3Vector): boolean;
function SameValue(const AValue1, AValue2: TC4Vector): boolean;
function SameValue(const AValue1, AValue2: TC2TransposedVector): boolean;
function SameValue(const AValue1, AValue2: TC3TransposedVector): boolean;
function SameValue(const AValue1, AValue2: TC4TransposedVector): boolean;
function SameValue(const AValue1, AValue2: TC2Matrix): boolean;
function SameValue(const AValue1, AValue2: TC3Matrix): boolean;
function SameValue(const AValue1, AValue2: TC4Matrix): boolean;

function C2NullVector: TC2Vector;
function C3NullVector: TC3Vector;
function C4NullVector: TC4Vector;

function C2NullTransposedVector: TC2TransposedVector;
function C3NullTransposedVector: TC3TransposedVector;
function C4NullTransposedVector: TC4TransposedVector;

function C2NullMatrix: TC2Matrix;
function C3NullMatrix: TC3Matrix;
function C4NullMatrix: TC4Matrix;

function C2IdMatrix: TC2Matrix;
function C3IdMatrix: TC3Matrix;
function C4IdMatrix: TC4Matrix;

// Solvers for linear, quadratic, cubic and quartic equation

function SolveEquation(const a: double): double;
function SolveEquation(const a: TComplex): TComplex;
function SolveEquation(const a, b: TComplex): TC2Array;
function SolveEquation(const a, b, c: TComplex): TC3Array;
function SolveEquation(const a, b, c, d: TComplex): TC4Array;

