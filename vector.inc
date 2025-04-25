{ Vector interface }

type

  // TRVector

  generic TRVector<TSpace> = record
  type
    TRMatrix = specialize TRMatrix<TSpace>;
  private
    fm: array[1..TSpace.N] of double;
    function Get(ARow: longint): double;
    procedure Put(ARow: longint; AValue: double);
  public
    function IsNull: boolean;
    function IsNotNull: boolean;
    function Norm: double;
    function Normalize: TRVector;
    function Reciprocal: TRVector;
    function SquaredNorm: double;
    class operator<>(const ALeft, ARight: TRVector): boolean;
    class operator =(const ALeft, ARight: TRVector): boolean;
    class operator +(const ASelf: TRVector): TRVector;
    class operator +(const ALeft, ARight: TRVector): TRVector;
    class operator -(const ASelf: TRVector): TRVector;
    class operator -(const ALeft, ARight: TRVector): TRVector;
    class operator *(const ALeft, ARight: TRVector): double;
    class operator *(const ALeft: double; const ARight: TRVector): TRVector;
    class operator *(const ALeft: TRVector; const ARight: double): TRVector;
    class operator *(const ALeft: TRVector; const ARight: TRMatrix): TRVector;
    class operator *(const ALeft: TRMatrix; const ARight: TRVector): TRVector;
    class operator /(const ALeft: TRVector; const ARight: double): TRVector;
    class operator /(const ALeft: double; const ARight: TRVector): TRVector;
  public
    property a[ARow: longint]: double read Get write Put; default;
  end;

  // TCVector

  generic TCVector<TSpace> = record
  type
    TRVector = specialize TRVector<TSpace>;
    TCMatrix = specialize TCMatrix<TSpace>;
  private
    fm: array[1..TSpace.N] of TComplex;
    function Get(ARow: longint): TComplex;
    procedure Put(ARow: longint; AValue: TComplex);
  public
    function IsNull: boolean;
    function IsNotNull: boolean;
    function Norm: double;
    function Normalize: TCVector;
    function Reciprocal: TCVector;
    function SquaredNorm: double;
    class operator:=(const ASelf: TRVector): TCVector;
    class operator<>(const ALeft, ARight: TCVector): boolean;
    class operator =(const ALeft, ARight: TCVector): boolean;
    class operator +(const ASelf: TCVector): TCVector;
    class operator +(const ALeft, ARight: TCVector): TCVector;
    class operator -(const ASelf: TCVector): TCVector;
    class operator -(const ALeft, ARight: TCVector): TCVector;
    class operator *(const ALeft, ARight: TCVector): TComplex;
    class operator *(const ALeft: double; const ARight: TCVector): TCVector;
    class operator *(const ALeft: TCVector; const ARight: double): TCVector;
    class operator *(const ALeft: TComplex; const ARight: TCVector): TCVector;
    class operator *(const ALeft: TCVector; const ARight: TComplex): TCVector;
    class operator *(const ALeft: TCVector; const ARight: TCMatrix): TCVector;
    class operator *(const ALeft: TCMatrix; const ARight: TCVector): TCVector;
    class operator /(const ALeft: TCVector; const ARight: double): TCVector;
    class operator /(const ALeft: double; const ARight: TCVector): TCVector;
    class operator /(const ALeft: TCVector; const ARight: TComplex): TCVector;
    class operator /(const ALeft: TComplex; const ARight: TCVector): TCVector;
  public
    property a[ARow: longint]: TComplex read Get write Put; default;
  end;

  TC2Vector = specialize TCVector<T2DSpace>;
  TC3Vector = specialize TCVector<T3DSpace>;
  TC4Vector = specialize TCVector<T4DSpace>;

  TR2Vector = specialize TRVector<T2DSpace>;
  TR3Vector = specialize TRVector<T3DSpace>;
  TR4Vector = specialize TRVector<T4DSpace>;

  TC2ArrayOfComplex = array[1..T2DSpace.N] of TComplex;
  TC3ArrayOfComplex = array[1..T3DSpace.N] of TComplex;
  TC4ArrayOfComplex = array[1..T4DSpace.N] of TComplex;

  TC2ArrayOfVector = array[1..T2DSpace.N] of TC2Vector;
  TC3ArrayOfVector = array[1..T3DSpace.N] of TC3Vector;
  TC4ArrayOfVector = array[1..T4DSpace.N] of TC4Vector;

  {$IFNDEF ADIMOFF}

  // TRVecQuantity

  generic TRVecQuantity<TSpace> = record
  type
    TRVector = specialize TRVector<TSpace>;
    TRMatrixQuantity = specialize TRMatrixQuantity<TSpace>;
  private
    FID: longint;
    FValue: TRVector;
    function Get(ARow: longint): TQuantity;
    procedure Put(ARow: longint; const AQuantity: TQuantity);
  public
    function Normalize: TRVecQuantity;
    class operator <>(const ALeft, ARight: TRVecQuantity): boolean;
    class operator = (const ALeft, ARight: TRVecQuantity): boolean;
    class operator + (const AValue: TRVecQuantity): TRVecQuantity;
    class operator + (const ALeft, ARight: TRVecQuantity): TRVecQuantity;
    class operator - (const AValue: TRVecQuantity): TRVecQuantity;
    class operator - (const ALeft, ARight: TRVecQuantity): TRVecQuantity;

    class operator * (const ALeft: TQuantity; const ARight: TRVecQuantity): TRVecQuantity;
    class operator * (const ALeft: TRVecQuantity; const ARight: TQuantity): TRVecQuantity;

    class operator * (const ALeft: TRMatrixQuantity; const ARight: TRVecQuantity): TRVecQuantity;
    class operator * (const ALeft, ARight: TRVecQuantity): TQuantity;

    class operator / (const ALeft: TQuantity; const ARight: TRVecQuantity): TRVecQuantity;
    class operator / (const ALeft: TRVecQuantity; const ARight: TQuantity): TRVecQuantity;
  public
    property a[ARow: longint]: TQuantity read Get write Put; default;
  end;

  // TCVecQuantity

  generic TCVecQuantity<TSpace> = record
  type
    TCVector = specialize TCVector<TSpace>;
    TCMatrixQuantity = specialize TCMatrixQuantity<TSpace>;
  private
    FID: longint;
    FValue: TCVector;
    function Get(ARow: longint): TComplexQuantity;
    procedure Put(ARow: longint; const AQuantity: TComplexQuantity);
  public
    function Normalize: TCVecQuantity;
    class operator :=(const AValue: TCVector): TCVecQuantity;
    class operator <>(const ALeft, ARight: TCVecQuantity): boolean;
    class operator = (const ALeft, ARight: TCVecQuantity): boolean;
    class operator + (const AValue: TCVecQuantity): TCVecQuantity;
    class operator + (const ALeft, ARight: TCVecQuantity): TCVecQuantity;
    class operator - (const AValue: TCVecQuantity): TCVecQuantity;
    class operator - (const ALeft, ARight: TCVecQuantity): TCVecQuantity;

    class operator * (const ALeft, ARight: TCVecQuantity): TComplexQuantity;

    class operator * (const ALeft: TQuantity; const ARight: TCVecQuantity): TCVecQuantity;
    class operator * (const ALeft: TCVecQuantity; const ARight: TQuantity): TCVecQuantity;

    class operator * (const ALeft: TCVecQuantity; const ARight: TCMatrixQuantity): TCVecQuantity;
    class operator * (const ALeft: TCMatrixQuantity; const ARight: TCVecQuantity): TCVecQuantity;

    class operator * (const ALeft: TCVector; const ARight: TCVecQuantity): TComplexQuantity;

    class operator / (const ALeft: TQuantity; const ARight: TCVecQuantity): TCVecQuantity;
    class operator / (const ALeft: TCVecQuantity; const ARight: TQuantity): TCVecQuantity;
  public
    property a[ARow: longint]: TComplexQuantity read Get write Put; default;
  end;

  TR2VecQuantity = specialize TRVecQuantity<T2DSpace>;
  TR3VecQuantity = specialize TRVecQuantity<T3DSpace>;
  TR4VecQuantity = specialize TRVecQuantity<T4DSpace>;

  TC2VecQuantity = specialize TCVecQuantity<T2DSpace>;
  TC3VecQuantity = specialize TCVecQuantity<T3DSpace>;
  TC4VecQuantity = specialize TCVecQuantity<T4DSpace>;
  {$ELSE}
  TR2VecQuantity = specialize TRVector<T2DSpace>;
  TR3VecQuantity = specialize TRVector<T3DSpace>;
  TR4VecQuantity = specialize TRVector<T4DSpace>;

  TC2VecQuantity = specialize TCVector<T2DSpace>;
  TC3VecQuantity = specialize TCVector<T3DSpace>;
  TC4VecQuantity = specialize TCVector<T4DSpace>;
  {$ENDIF}

  // Helpers

  TR2MatrixHelper = record helper for TR2Matrix
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TR3MatrixHelper = record helper for TR3Matrix
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TR4MatrixHelper = record helper for TR4Matrix
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC2MatrixHelper = record helper for TC2Matrix
    function Diagonalize(const AEigenValues: TC2ArrayOfComplex): TC2Matrix;
    function Conjugate: TC2Matrix;
    function Determinant: TComplex;
    function Eigenvalues: TC2ArrayOfComplex;
    function Eigenvectors(const AEigenValues: TC2ArrayOfComplex): TC2ArrayOfVector;
    function Reciprocal(const ADeterminant: TComplex): TC2Matrix;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
    function TransposeConjugate: TC2Matrix;
  end;

  TC3MatrixHelper = record helper for TC3Matrix
    function Diagonalize(const AEigenValues: TC3ArrayOfComplex): TC3Matrix;
    function Conjugate: TC3Matrix;
    function Determinant: TComplex;
    function Eigenvalues: TC3ArrayOfComplex;
    function Eigenvectors(const AEigenValues: TC3ArrayOfComplex): TC3ArrayOfVector;
    function Reciprocal(const ADeterminant: TComplex): TC3Matrix;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
    function TransposeConjugate: TC3Matrix;
  end;

  TC4MatrixHelper = record helper for TC4Matrix
    function Diagonalize(const AEigenValues: TC4ArrayOfComplex): TC4Matrix;
    function Conjugate: TC4Matrix;
    function Determinant: TComplex;
    function Eigenvalues: TC4ArrayOfComplex;
    function Eigenvectors(const AEigenValues: TC4ArrayOfComplex): TC4ArrayOfVector;
    function Reciprocal(const ADeterminant: TComplex): TC4Matrix;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
    function TransposeConjugate: TC4Matrix;
  end;

  TC2VectorHelper = record helper for TC2Vector
    function Dot(const AVector: TC2Vector): TComplex;
    function Conjugate: TC2Vector;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC3VectorHelper = record helper for TC3Vector
    function Conjugate: TC3Vector;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TC4VectorHelper = record helper for TC4Vector
    function Conjugate: TC4Vector;
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;
  end;

  TR2VectorHelper = record helper for TR2Vector
    function ToString(APrecision, ADigits: longint): string;
    function ToString: string;
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

  TR4VectorHelper = record helper for TR4Vector
    function ToString(APrecision, ADigits: longint): string;
    function ToString: string;
  end;


