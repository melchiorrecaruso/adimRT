{ Vector interface }

type

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
    class operator *(const ALeft: double; const ARight: TSelf): TSelf;
    class operator *(const ALeft: TSelf; const ARight: double): TSelf;
    class operator *(const ALeft: TComplex; const ARight: TSelf): TSelf;
    class operator *(const ALeft: TSelf; const ARight: TComplex): TSelf;
    class operator *(const ALeft: TMatrix; const ARight: TSelf): TSelf;
    class operator /(const ALeft: TSelf; const ARight: double): TSelf;
    class operator /(const ALeft: double; const ARight: TSelf): TSelf;
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

  TC2Ket = TC2Vector;
  TC3Ket = TC3Vector;
  TC4Ket = TC4Vector;

  TC2Bra = TC2TransposedVector;
  TC3Bra = TC3TransposedVector;
  TC4Bra = TC4TransposedVector;

  TC2ArrayOfComplex = array[1..T2DSpace.N] of TComplex;
  TC3ArrayOfComplex = array[1..T3DSpace.N] of TComplex;
  TC4ArrayOfComplex = array[1..T4DSpace.N] of TComplex;

  TC2ArrayOfVector = array[1..T2DSpace.N] of TC2Vector;
  TC3ArrayOfVector = array[1..T3DSpace.N] of TC3Vector;
  TC4ArrayOfVector = array[1..T4DSpace.N] of TC4Vector;

  // TCVecQuantity

  {$IFNDEF ADIMOFF}
  generic TCVecQuantity<TSpace> = record
  type
    TSelf = specialize TCVecQuantity<TSpace>;
    TVector = specialize TCVector<TSpace>;
    TMatrixQuantity = specialize TCMatrixQuantity<TSpace>;
  private
    FID: longint;
    FValue: TVector;
  public
    function Normalize: TSelf;
    class operator :=(const AValue: TVector): TSelf;
    class operator <>(const ALeft, ARight: TSelf): boolean;
    class operator = (const ALeft, ARight: TSelf): boolean;
    class operator + (const AValue: TSelf): TSelf;
    class operator + (const ALeft, ARight: TSelf): TSelf;
    class operator - (const AValue: TSelf): TSelf;
    class operator - (const ALeft, ARight: TSelf): TSelf;
    class operator * (const ALeft: TMatrixQuantity; const ARight: TSelf): TSelf;
    class operator / (const ALeft: TMatrixQuantity; const ARight: TSelf): TSelf;
  end;

  // TRVecQuantity

  generic TRVecQuantity<TSpace> = record
  type
    TSelf = specialize TRVecQuantity<TSpace>;
    TVector = specialize TRVector<TSpace>;
  private
    FID: longint;
    FValue: TVector;
  public
    function Normalize: TSelf;
    class operator <>(const ALeft, ARight: TSelf): boolean;
    class operator = (const ALeft, ARight: TSelf): boolean;
    class operator + (const AValue: TSelf): TSelf;
    class operator + (const ALeft, ARight: TSelf): TSelf;
    class operator - (const AValue: TSelf): TSelf;
    class operator - (const ALeft, ARight: TSelf): TSelf;
  end;

  TC2VecQuantity = specialize TCVecQuantity<T2DSpace>;
  TC3VecQuantity = specialize TCVecQuantity<T3DSpace>;
  TC4VecQuantity = specialize TCVecQuantity<T4DSpace>;
  TR2VecQuantity = specialize TRVecQuantity<T2DSpace>;
  TR3VecQuantity = specialize TRVecQuantity<T3DSpace>;
  TR4VecQuantity = specialize TRVecQuantity<T4DSpace>;
  {$ELSE}
  TC2VecQuantity = specialize TCVector<T2DSpace>;
  TC3VecQuantity = specialize TCVector<T3DSpace>;
  TC4VecQuantity = specialize TCVector<T4DSpace>;
  TR2VecQuantity = specialize TRVector<T2DSpace>;
  TR3VecQuantity = specialize TRVector<T3DSpace>;
  TR4VecQuantity = specialize TRVector<T4DSpace>;
  {$ENDIF}

  {$IFNDEF ADIMOFF}
  generic TCTransposedVecQuantity<TSpace> = record
  type
    TSelf = specialize TCTransposedVecQuantity<TSpace>;
    TTransposedVector = specialize TCTransposedVector<TSpace>;
    TVector = specialize TCVector<TSpace>;
    TVecQuantity = specialize TCVecQuantity<TSpace>;
    TMatrix = specialize TCMatrix<TSpace>;
    TMatrixQuantity = specialize TCMatrixQuantity<TSpace>;
  private
    FID: longint;
    FValue: TTransposedVector;
  public
    class operator<>(const ALeft, ARight: TSelf): boolean;
    class operator =(const ALeft, ARight: TSelf): boolean;
    class operator +(const ALeft, ARight: TSelf): TSelf;
    class operator -(const ALeft, ARight: TSelf): TSelf;
    class operator *(const ALeft: TVecQuantity; const ARight: TSelf): TMatrixQuantity;
    class operator *(const ALeft: TSelf; const ARight: TMatrixQuantity): TSelf;
    class operator *(const ALeft: TSelf; const ARight: TVecQuantity): TComplexQuantity;
    class operator /(const ALeft: TSelf; const ARight: TVecQuantity): TComplexQuantity;
  end;

  generic TRTransposedVecQuantity<TSpace> = record
  type
    TSelf = specialize TRTransposedVecQuantity<TSpace>;
    TVector = specialize TRVector<TSpace>;
  private
    FID: longint;
    FValue: TVector;
  public
  end;

  TC2TransposedVecQuantity = specialize TCTransposedVecQuantity<T2DSpace>;
  TC3TransposedVecQuantity = specialize TCTransposedVecQuantity<T3DSpace>;
  TC4TransposedVecQuantity = specialize TCTransposedVecQuantity<T4DSpace>;
  TR2TransposedVecQuantity = specialize TRTransposedVecQuantity<T2DSpace>;
  TR3TransposedVecQuantity = specialize TRTransposedVecQuantity<T3DSpace>;
  TR4TransposedVecQuantity = specialize TRTransposedVecQuantity<T4DSpace>;
  {$ELSE}
  TC2TransposedVecQuantity = specialize TCTransposedVector<T2DSpace>;
  TC3TransposedVecQuantity = specialize TCTransposedVector<T3DSpace>;
  TC4TransposedVecQuantity = specialize TCTransposedVector<T4DSpace>;
  TR2TransposedVecQuantity = specialize TRTransposedVector<T2DSpace>;
  TR3TransposedVecQuantity = specialize TRTransposedVector<T3DSpace>;
  TR4TransposedVecQuantity = specialize TRTransposedVector<T4DSpace>;
  {$ENDIF}

  // Helpers

  TC2MatrixHelper = record helper for TC2Matrix
    function Diagonalize(const AEigenValues: TC2ArrayOfComplex): TC2Matrix;
    function Dual: TC2Matrix;
    function Determinant: TComplex;
    function Eigenvalues: TC2ArrayOfComplex;
    function Eigenvectors(const AEigenValues: TC2ArrayOfComplex): TC2ArrayOfVector;
    function Reciprocal(const ADeterminant: TComplex): TC2Matrix;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
    function TransposeDual: TC2Matrix;
  end;

  TC3MatrixHelper = record helper for TC3Matrix
    function Diagonalize(const AEigenValues: TC3ArrayOfComplex): TC3Matrix;
    function Dual: TC3Matrix;
    function Determinant: TComplex;
    function Eigenvalues: TC3ArrayOfComplex;
    function Eigenvectors(const AEigenValues: TC3ArrayOfComplex): TC3ArrayOfVector;
    function Reciprocal(const ADeterminant: TComplex): TC3Matrix;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
    function TransposeDual: TC3Matrix;
  end;

  TC4MatrixHelper = record helper for TC4Matrix
    function Diagonalize(const AEigenValues: TC4ArrayOfComplex): TC4Matrix;
    function Dual: TC4Matrix;
    function Determinant: TComplex;
    function Eigenvalues: TC4ArrayOfComplex;
    function Eigenvectors(const AEigenValues: TC4ArrayOfComplex): TC4ArrayOfVector;
    function Reciprocal(const ADeterminant: TComplex): TC4Matrix;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
    function TransposeDual: TC4Matrix;
  end;

  TC2VectorHelper = record helper for TC2Vector
    function Dot(const AVector: TC2Vector): TComplex;
    function Dual: TC2Vector;
    function Transpose: TC2TransposedVector;
    function TransposeDual: TC2TransposedVector;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC3VectorHelper = record helper for TC3Vector
    function Dot(const AVector: TC3Vector): TComplex;
    function Dual: TC3Vector;
    function Transpose: TC3TransposedVector;
    function TransposeDual: TC3TransposedVector;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC4VectorHelper = record helper for TC4Vector
    function Dot(const AVector: TC4Vector): TComplex;
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

  TR3VectorHelper = record helper for TR3Vector
    function Dot(const AVector: TR3Vector): double;
    function Cross(const AVector: TR3Vector): TR3Vector;
    function Projection(const AVector: TR3Vector): TR3Vector; overload;
    function Rejection(const AVector: TR3Vector): TR3Vector; overload;
    function Reflection(const AVector: TR3Vector): TR3Vector; overload;
    function ToString(APrecision, ADigits: longint): string;
    function ToString: string;
  end;

