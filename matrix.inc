
{ Matrix and vector interface }

type
  T2DSpace = record const N = 2; end;
  T3DSpace = record const N = 3; end;
  T4DSpace = record const N = 4; end;

  // TCMatrix

  generic TCMatrix<TSpace> = record
  type
    TSelf = specialize TCMatrix<TSpace>;
  private
    fm: array[1..TSpace.N, 1..TSpace.N] of TComplex;
    procedure Put(ARow, ACol: longint; AValue: TComplex);
    function Get(ARow, ACol: longint): TComplex;
  public
    function IsNull: boolean;
    function IsNotNull: boolean;
    function RowReduction: TCMatrix;
    procedure Swap(ARow1, ARow2: longint);

    function Trace: TComplex;
    function Transpose: TSelf;
    class operator<>(const ALeft, ARight: TSelf): boolean;
    class operator =(const ALeft, ARight: TSelf): boolean;
    class operator +(const ALeft, ARight: TSelf): TSelf;
    class operator -(const ALeft, ARight: TSelf): TSelf;
    class operator *(const ALeft: TComplex; const ARight: TSelf): TSelf;
    class operator *(const ALeft: TSelf; const ARight: TComplex): TSelf;
    class operator *(const ALeft, ARight: TSelf): TSelf;
    class operator /(const ALeft: TSelf; const ARight: TComplex): TSelf;
  public
    property a[ARow, ACol: longint]: TComplex read Get write Put; default;
  end;

  // TRMatrix

  generic TRMatrix<TSpace> = record
  type
    TSelf = specialize TRMatrix<TSpace>;
    TCMatrix = specialize TCMatrix<TSpace>;
  private
    fm: array[1..TSpace.N, 1..TSpace.N] of double;
    procedure Put(ARow, ACol: longint; AValue: double);
    function Get(ARow, ACol: longint): double;
  public
    function IsNull: boolean;
    function IsNotNull: boolean;
    function RowReduction: TRMatrix;
    procedure Swap(ARow1, ARow2: longint);

    function Trace: double;
    function Transpose: TSelf;
    class operator:=(const AValue: TSelf): TCMatrix;
    class operator<>(const ALeft, ARight: TSelf): boolean;
    class operator =(const ALeft, ARight: TSelf): boolean;
    class operator +(const ALeft, ARight: TSelf): TSelf;
    class operator -(const ALeft, ARight: TSelf): TSelf;
    class operator *(const ALeft: double; const ARight: TSelf): TSelf;
    class operator *(const ALeft: TSelf; const ARight: double): TSelf;
    class operator *(const ALeft, ARight: TSelf): TSelf;
    class operator /(const ALeft: TSelf; const ARight: double): TSelf;
  public
    property a[ARow, ACol: longint]: double read Get write Put; default;
  end;

  // TCVector

  generic TCVector<TSpace> = record
  type
    TSelf = specialize TCVector<TSpace>;
    TMatrix = specialize TCMatrix<TSpace>;
  private
    fm: array[1..TSpace.N] of TComplex;
    function Get(ARow: longint): TComplex;
    procedure Put(ARow: longint; AValue: TComplex);
  public
    function IsNull: boolean;
    function IsNotNull: boolean;
    function Norm: double;
    function Normalize: TSelf;
    function Reciprocal: TSelf;
    function SquaredNorm: double;
    class operator<>(const ALeft, ARight: TSelf): boolean;
    class operator =(const ALeft, ARight: TSelf): boolean;
    class operator +(const ASelf: TSelf): TSelf;
    class operator +(const ALeft, ARight: TSelf): TSelf;
    class operator -(const ASelf: TSelf): TSelf;
    class operator -(const ALeft, ARight: TSelf): TSelf;
    class operator *(const ALeft: TComplex; const ARight: TSelf): TSelf;
    class operator *(const ALeft: TSelf; const ARight: TComplex): TSelf;
    class operator *(const ALeft: TMatrix; const ARight: TSelf): TSelf;
    class operator /(const ALeft: TSelf; const ARight: TComplex): TSelf;
    class operator /(const ALeft: TComplex; const ARight: TSelf): TSelf;
  public
    property a[ARow: longint]: TComplex read Get write Put; default;
  end;

  // TRVector

  generic TRVector<TSpace> = record
  type
    TSelf = specialize TRVector<TSpace>;
    TMatrix = specialize TRMatrix<TSpace>;
  private
    fm: array[1..TSpace.N] of double;
    function Get(ARow: longint): double;
    procedure Put(ARow: longint; AValue: double);
  public
    function IsNull: boolean;
    function IsNotNull: boolean;
    function Norm: double;
    function Normalize: TSelf;
    function Reciprocal: TSelf;
    function SquaredNorm: double;
    class operator<>(const ALeft, ARight: TSelf): boolean;
    class operator =(const ALeft, ARight: TSelf): boolean;
    class operator +(const ASelf: TSelf): TSelf;
    class operator +(const ALeft, ARight: TSelf): TSelf;
    class operator -(const ASelf: TSelf): TSelf;
    class operator -(const ALeft, ARight: TSelf): TSelf;
    class operator *(const ALeft: double; const ARight: TSelf): TSelf;
    class operator *(const ALeft: TSelf; const ARight: double): TSelf;
    class operator *(const ALeft: TMatrix; const ARight: TSelf): TSelf;
    class operator /(const ALeft: TSelf; const ARight: double): TSelf;
    class operator /(const ALeft: double; const ARight: TSelf): TSelf;
  public
    property a[ARow: longint]: double read Get write Put; default;
  end;

  // TCTransposedVector

  generic TCTransposedVector<TSpace> = record
  type
    TSelf = specialize TCTransposedVector<TSpace>;
    TVector = specialize TCVector<TSpace>;
    TMatrix = specialize TCMatrix<TSpace>;
  private
    fm: array[1..TSpace.N] of TComplex;
    function Get(ACol: longint): TComplex;
    procedure Put(ACol: longint; AValue: TComplex);
  public
    function IsNull: boolean;
    function IsNotNull: boolean;
    function Norm: double;
    function Normalize: TSelf;
    function Reciprocal: TSelf;
    function SquaredNorm: double;
    class operator<>(const ALeft, ARight: TSelf): boolean;
    class operator =(const ALeft, ARight: TSelf): boolean;
    class operator +(const ALeft, ARight: TSelf): TSelf;
    class operator -(const ALeft, ARight: TSelf): TSelf;
    class operator *(const ALeft: TComplex; const ARight: TSelf): TSelf;
    class operator *(const ALeft: TSelf; const ARight: TComplex): TSelf;
    class operator *(const ALeft: TSelf; const ARight: TVector): TComplex;
    class operator *(const ALeft: TVector; const ARight: TSelf): TMatrix;
    class operator *(const ALeft: TSelf; const ARight: TMatrix): TSelf;
    class operator /(const ALeft: TSelf; const ARight: TComplex): TSelf;
    class operator /(const ALeft: TComplex; const ARight: TSelf): TSelf;
  public
    property a[ACol: longint]: TComplex read Get write Put; default;
  end;

  // TRTransposedVector

  generic TRTransposedVector<TSpace> = record
  type
    TSelf = specialize TRTransposedVector<TSpace>;
    TVector = specialize TRVector<TSpace>;
    TMatrix = specialize TRMatrix<TSpace>;
  private
    fm: array[1..TSpace.N] of double;
    function Get(ACol: longint): double;
    procedure Put(ACol: longint; AValue: double);
  public
    function IsNull: boolean;
    function IsNotNull: boolean;
    function Norm: double;
    function Normalize: TSelf;
    function Reciprocal: TSelf;
    function SquaredNorm: double;
    class operator<>(const ALeft, ARight: TSelf): boolean;
    class operator =(const ALeft, ARight: TSelf): boolean;
    class operator +(const ALeft, ARight: TSelf): TSelf;
    class operator -(const ALeft, ARight: TSelf): TSelf;
    class operator *(const ALeft: double; const ARight: TSelf): TSelf;
    class operator *(const ALeft: TSelf; const ARight: double): TSelf;
    class operator *(const ALeft: TSelf; const ARight: TVector): double;
    class operator *(const ALeft: TVector; const ARight: TSelf): TMatrix;
    class operator *(const ALeft: TSelf; const ARight: TMatrix): TSelf;
    class operator /(const ALeft: TSelf; const ARight: double): TSelf;
    class operator /(const ALeft: double; const ARight: TSelf): TSelf;
  public
    property a[ACol: longint]: double read Get write Put; default;
  end;

  TC2Matrix = specialize TCMatrix<T2DSpace>;
  TC3Matrix = specialize TCMatrix<T3DSpace>;
  TC4Matrix = specialize TCMatrix<T4DSpace>;

  TR2Matrix = specialize TRMatrix<T2DSpace>;
  TR3Matrix = specialize TRMatrix<T3DSpace>;
  TR4Matrix = specialize TRMatrix<T4DSpace>;

  TC2Vector = specialize TCVector<T2DSpace>;
  TC3Vector = specialize TCVector<T3DSpace>;
  TC4Vector = specialize TCVector<T4DSpace>;

  TR2Vector = specialize TRVector<T2DSpace>;
  TR3Vector = specialize TRVector<T3DSpace>;
  TR4Vector = specialize TRVector<T4DSpace>;

  TC2TransposedVector = specialize TCTransposedVector<T2DSpace>;
  TC3TransposedVector = specialize TCTransposedVector<T3DSpace>;
  TC4TransposedVector = specialize TCTransposedVector<T4DSpace>;

  TR2TransposedVector = specialize TRTransposedVector<T2DSpace>;
  TR3TransposedVector = specialize TRTransposedVector<T3DSpace>;
  TR4TransposedVector = specialize TRTransposedVector<T4DSpace>;

  TC2Array = array[1..T2DSpace.N] of TComplex;
  TC3Array = array[1..T3DSpace.N] of TComplex;
  TC4Array = array[1..T4DSpace.N] of TComplex;

  TC2Eigenvalues = TC2Array;
  TC3Eigenvalues = TC3Array;
  TC4Eigenvalues = TC4Array;

  TC2Eigenvectors = array[1..T2DSpace.N] of TC2Vector;
  TC3Eigenvectors = array[1..T3DSpace.N] of TC3Vector;
  TC4Eigenvectors = array[1..T4DSpace.N] of TC4Vector;

  // TKet for Hilbert space

  TC2Ket = TC2Vector;
  TC3Ket = TC3Vector;
  TC4Ket = TC4Vector;

  // TBra for Hilbert space

  TC2Bra = TC2TransposedVector;
  TC3Bra = TC3TransposedVector;
  TC4Bra = TC4TransposedVector;

  // Complex space matrix helpers

  TC2MatrixHelper = record helper for TC2Matrix
    function Dual: TC2Matrix;
    function Determinant: TComplex;
    function Eigenvalues: TC2Eigenvalues;
    function Eigenvectors(const AEigenValues: TC2Array): TC2Eigenvectors;
    function Reciprocal(const ADeterminant: TComplex): TC2Matrix;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
    function TransposeDual: TC2Matrix;
  end;

  TC3MatrixHelper = record helper for TC3Matrix
    function Dual: TC3Matrix;
    function Determinant: TComplex;
    function Eigenvalues: TC3Eigenvalues;
    function Eigenvectors(const AEigenValues: TC3Array): TC3Eigenvectors;
    function Reciprocal(const ADeterminant: TComplex): TC3Matrix;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
    function TransposeDual: TC3Matrix;
  end;

  TC4MatrixHelper = record helper for TC4Matrix
    function Dual: TC4Matrix;
    function Determinant: TComplex;
    function Eigenvalues: TC4Eigenvalues;
    function Eigenvectors(const AEigenValues: TC4Array): TC4Eigenvectors;
    function Reciprocal(const ADeterminant: TComplex): TC4Matrix;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
    function TransposeDual: TC4Matrix;
  end;

  // Complex space vector helpers

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

  // Real space vector helpers

  TR3VectorHelper = record helper for TR3Vector
    function Dot(const AVector: TR3Vector): double;
    function Cross(const AVector: TR3Vector): TR3Vector;
    function Projection(const AVector: TR3Vector): TR3Vector; overload;
    function Rejection(const AVector: TR3Vector): TR3Vector; overload;
    function Reflection(const AVector: TR3Vector): TR3Vector; overload;
    function ToString(APrecision, ADigits: longint): string;
    function ToString: string;
  end;

