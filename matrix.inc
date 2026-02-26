  {
    Tag record representing a 2-dimensional space.
    Used as a generic parameter to instantiate 2×2 matrix types.
  }
  T2DSpace = record
  private
  const
    N = 2;
  end;

  {
    Tag record representing a 3-dimensional space.
    Used as a generic parameter to instantiate 3×3 matrix types.
  }
  T3DSpace = record
  private
  const
    N = 3;
  end;

  {
    Tag record representing a 4-dimensional space.
    Used as a generic parameter to instantiate 4×4 matrix types.
  }
  T4DSpace = record
  private
  const
    N = 4;
  end;

  {
    Generic square matrix of real values (@code(double)) with dimension @code(TSpace.N × TSpace.N).

    The matrix elements are stored in a 1-based 2D array.
    Use the default array property @code(a[row, col]) to read and write individual elements.
    Concrete types are provided as @link(TR2Matrix), @link(TR3Matrix), and @link(TR4Matrix).
  }
  generic TRMatrix<TSpace> = record
  private
    fm: array[1..TSpace.N, 1..TSpace.N] of double;

    { Writes the element at position (@code(ARow), @code(ACol)). }
    procedure Put(ARow, ACol: longint; AValue: double);

    { Reads the element at position (@code(ARow), @code(ACol)). }
    function Get(ARow, ACol: longint): double;
  public
    { Returns @true if all elements of the matrix are zero. }
    function IsNull: boolean;

    { Returns @true if at least one element of the matrix is non-zero. }
    function IsNotNull: boolean;

    {
      Returns the row-reduced echelon form of the matrix (Gauss elimination).
      The original matrix is not modified.
    }
    function RowReduction: TRMatrix;

    { Swaps rows @code(ARow1) and @code(ARow2) in place. }
    procedure Swap(ARow1, ARow2: longint);

    {
      Returns the trace of the matrix, i.e. the sum of the diagonal elements:
      @code(tr(A) = Σ A[i,i]).
    }
    function Trace: double;

    {
      Returns the transpose of the matrix.
      Element @code([i,j]) of the result equals element @code([j,i]) of the original.
    }
    function Transpose: TRMatrix;

    { Returns @true if the two matrices differ in at least one element. }
    class operator <>(const ALeft, ARight: TRMatrix): boolean;

    { Returns @true if all corresponding elements of the two matrices are equal. }
    class operator =(const ALeft, ARight: TRMatrix): boolean;

    { Returns the element-wise sum of two matrices of the same size. }
    class operator +(const ALeft, ARight: TRMatrix): TRMatrix;

    { Returns the element-wise difference of two matrices of the same size. }
    class operator -(const ALeft, ARight: TRMatrix): TRMatrix;

    {
      Returns the matrix product of two matrices.
      @code((A·B)[i,j] = Σ_k A[i,k] · B[k,j])
    }
    class operator *(const ALeft, ARight: TRMatrix): TRMatrix;

    { Returns the product of a real scalar and a matrix. Each element is multiplied by @code(ALeft). }
    class operator *(const ALeft: double; const ARight: TRMatrix): TRMatrix;

    { Returns the product of a matrix and a real scalar. Each element is multiplied by @code(ARight). }
    class operator *(const ALeft: TRMatrix; const ARight: double): TRMatrix;

    { Returns the matrix divided by a real scalar. Each element is divided by @code(ARight). }
    class operator /(const ALeft: TRMatrix; const ARight: double): TRMatrix;

  public
    {
      Provides access to individual matrix elements using 1-based row and column indices.
      @code(a[1,1]) is the top-left element.
    }
    property a[ARow, ACol: longint]: double read Get write Put; default;
  end;

  {
    Generic square matrix of complex values (@link(TComplex)) with dimension @code(TSpace.N × TSpace.N).

    Extends the functionality of @link(TRMatrix) to the complex domain.
    Supports implicit conversion from a real matrix.
    Use the default array property @code(a[row, col]) to read and write individual elements.
    Concrete types are provided as @link(TC2Matrix), @link(TC3Matrix), and @link(TC4Matrix).
  }
  generic TCMatrix<TSpace> = record
  type
    TRMatrix = specialize TRMatrix<TSpace>;
  private
    fm: array[1..TSpace.N, 1..TSpace.N] of TComplex;

    { Writes the complex element at position (@code(ARow), @code(ACol)). }
    procedure Put(ARow, ACol: longint; AValue: TComplex);

    { Reads the complex element at position (@code(ARow), @code(ACol)). }
    function Get(ARow, ACol: longint): TComplex;
  public
    { Returns @true if all elements of the matrix are zero. }
    function IsNull: boolean;

    { Returns @true if at least one element of the matrix is non-zero. }
    function IsNotNull: boolean;

    {
      Returns the row-reduced echelon form of the matrix (Gauss elimination).
      The original matrix is not modified.
    }
    function RowReduction: TCMatrix;

    { Swaps rows @code(ARow1) and @code(ARow2) in place. }
    procedure Swap(ARow1, ARow2: longint);

    {
      Returns the trace of the matrix, i.e. the sum of the diagonal elements:
      @code(tr(A) = Σ A[i,i]).
    }
    function Trace: TComplex;

    {
      Returns the transpose of the matrix.
      Element @code([i,j]) of the result equals element @code([j,i]) of the original.
    }
    function Transpose: TCMatrix;

    {
      Implicit conversion from a real matrix to a complex matrix.
      Each element @code(a[i,j]) is converted to @code(TComplex(Re=a[i,j], Im=0)).
    }
    class operator := (const AMatrix: TRMatrix): TCMatrix;

    { Returns @true if the two matrices differ in at least one element. }
    class operator <>(const ALeft, ARight: TCMatrix): boolean;

    { Returns @true if all corresponding elements of the two matrices are equal. }
    class operator =(const ALeft, ARight: TCMatrix): boolean;

    { Returns the element-wise sum of two complex matrices of the same size. }
    class operator +(const ALeft, ARight: TCMatrix): TCMatrix;

    { Returns the element-wise difference of two complex matrices of the same size. }
    class operator -(const ALeft, ARight: TCMatrix): TCMatrix;

    {
      Returns the matrix product of two complex matrices.
      @code((A·B)[i,j] = Σ_k A[i,k] · B[k,j])
    }
    class operator *(const ALeft, ARight: TCMatrix): TCMatrix;

    { Returns the product of a complex scalar and a matrix. Each element is multiplied by @code(ALeft). }
    class operator *(const ALeft: TComplex; const ARight: TCMatrix): TCMatrix;

    { Returns the product of a complex matrix and a complex scalar. Each element is multiplied by @code(ARight). }
    class operator *(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;

    { Returns the complex matrix divided by a complex scalar. Each element is divided by @code(ARight). }
    class operator /(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;

  public
    {
      Provides access to individual complex matrix elements using 1-based row and column indices.
      @code(a[1,1]) is the top-left element.
    }
    property a[ARow, ACol: longint]: TComplex read Get write Put; default;
  end;

  { 2×2 real matrix. Specialization of @link(TRMatrix) for @link(T2DSpace). }
  TR2Matrix = specialize TRMatrix<T2DSpace>;
  { 3×3 real matrix. Specialization of @link(TRMatrix) for @link(T3DSpace). }
  TR3Matrix = specialize TRMatrix<T3DSpace>;
  { 4×4 real matrix. Specialization of @link(TRMatrix) for @link(T4DSpace). }
  TR4Matrix = specialize TRMatrix<T4DSpace>;

  { 2×2 complex matrix. Specialization of @link(TCMatrix) for @link(T2DSpace). }
  TC2Matrix = specialize TCMatrix<T2DSpace>;
  { 3×3 complex matrix. Specialization of @link(TCMatrix) for @link(T3DSpace). }
  TC3Matrix = specialize TCMatrix<T3DSpace>;
  { 4×4 complex matrix. Specialization of @link(TCMatrix) for @link(T4DSpace). }
  TC4Matrix = specialize TCMatrix<T4DSpace>;

  {
    Generic square matrix of real physical quantities (@link(TQuantity)) with dimension @code(TSpace.N × TSpace.N).

    Each element carries the same physical dimension, stored in @code(FDim).
    Supports arithmetic operations with dimensional consistency checking.
    When @code(ADIMOFF) is defined, degenerates to the corresponding @link(TRMatrix) specialization.
    Concrete types are provided as @link(TR2MatrixQuantity), @link(TR3MatrixQuantity), and @link(TR4MatrixQuantity).
  }
  {$IFNDEF ADIMOFF}
  generic TRMatrixQuantity<TSpace> = record
  type
    TRMatrix = specialize TRMatrix<TSpace>;
  private
    FDim: TDimension;
    FValue: TRMatrix;

    { Writes the element at position (@code(ARow), @code(ACol)) as a @link(TQuantity). }
    procedure Put(ARow, ACol: longint; AQuantity: TQuantity);

    { Reads the element at position (@code(ARow), @code(ACol)) as a @link(TQuantity). }
    function Get(ARow, ACol: longint): TQuantity;
  public
    {
      Implicit conversion from a dimensionless real matrix to a quantity matrix.
      The resulting matrix has a scalar (dimensionless) dimension.
    }
    class operator := (const AMatrix: TRMatrix): TRMatrixQuantity;

    { Returns @true if the two matrices differ in dimension or in at least one element. }
    class operator <>(const ALeft, ARight: TRMatrixQuantity): boolean;

    { Returns @true if both matrices have the same dimension and all corresponding elements are equal. }
    class operator =(const ALeft, ARight: TRMatrixQuantity): boolean;

    { Returns the element-wise sum of two quantity matrices. Both operands must have the same dimension. }
    class operator +(const ALeft, ARight: TRMatrixQuantity): TRMatrixQuantity;

    { Returns the element-wise difference of two quantity matrices. Both operands must have the same dimension. }
    class operator -(const ALeft, ARight: TRMatrixQuantity): TRMatrixQuantity;

    {
      Returns the matrix product of two quantity matrices.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft, ARight: TRMatrixQuantity): TRMatrixQuantity;

    {
      Returns the product of a real quantity scalar and a quantity matrix.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TQuantity;
      const ARight: TRMatrixQuantity): TRMatrixQuantity;

    {
      Returns the product of a quantity matrix and a real quantity scalar.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TRMatrixQuantity;
      const ARight: TQuantity): TRMatrixQuantity;

    {
      Returns the quantity matrix divided by a real quantity scalar.
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TRMatrixQuantity;
      const ARight: TQuantity): TRMatrixQuantity;
  end;


  {
    Generic square matrix of complex physical quantities (@link(TComplexQuantity)) with dimension @code(TSpace.N × TSpace.N).

    Each element carries the same physical dimension, stored in @code(FDim).
    Supports arithmetic operations with dimensional consistency checking.
    When @code(ADIMOFF) is defined, degenerates to the corresponding @link(TCMatrix) specialization.
    Concrete types are provided as @link(TC2MatrixQuantity), @link(TC3MatrixQuantity), and @link(TC4MatrixQuantity).
  }
  generic TCMatrixQuantity<TSpace> = record
  type
    TCMatrix = specialize TCMatrix<TSpace>;
  private
    FDim: TDimension;
    FValue: TCMatrix;

    { Writes the element at position (@code(ARow), @code(ACol)) as a @link(TComplexQuantity). }
    procedure Put(ARow, ACol: longint; AQuantity: TComplexQuantity);

    { Reads the element at position (@code(ARow), @code(ACol)) as a @link(TComplexQuantity). }
    function Get(ARow, ACol: longint): TComplexQuantity;
  public
    {
      Implicit conversion from a complex matrix to a complex quantity matrix.
      The resulting matrix has a scalar (dimensionless) dimension.
    }
    class operator := (const AMatrix: TCMatrix): TCMatrixQuantity;

    { Returns @true if the two matrices differ in dimension or in at least one element. }
    class operator <>(const ALeft, ARight: TCMatrixQuantity): boolean;

    { Returns @true if both matrices have the same dimension and all corresponding elements are equal. }
    class operator =(const ALeft, ARight: TCMatrixQuantity): boolean;

    { Returns the element-wise sum of two complex quantity matrices. Both operands must have the same dimension. }
    class operator +(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;

    { Returns the element-wise difference of two complex quantity matrices. Both operands must have the same dimension. }
    class operator -(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;

    {
      Returns the matrix product of two complex quantity matrices.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;

    {
      Returns the product of a complex quantity scalar and a complex quantity matrix.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TComplexQuantity;
      const ARight: TCMatrixQuantity): TCMatrixQuantity;

    {
      Returns the product of a complex quantity matrix and a complex quantity scalar.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCMatrixQuantity;
      const ARight: TComplexQuantity): TCMatrixQuantity;

    {
      Returns the complex quantity matrix divided by a complex quantity scalar.
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCMatrixQuantity;
      const ARight: TComplexQuantity): TCMatrixQuantity;

  public
    {
      Provides access to individual complex quantity matrix elements using 1-based row and column indices.
      @code(a[1,1]) is the top-left element.
    }
    property a[ARow, ACol: longint]: TComplexQuantity read Get write Put; default;
  end;

  { 2×2 real quantity matrix. Specialization of @link(TRMatrixQuantity) for @link(T2DSpace). }
  TR2MatrixQuantity = specialize TRMatrixQuantity<T2DSpace>;
  { 3×3 real quantity matrix. Specialization of @link(TRMatrixQuantity) for @link(T3DSpace). }
  TR3MatrixQuantity = specialize TRMatrixQuantity<T3DSpace>;
  { 4×4 real quantity matrix. Specialization of @link(TRMatrixQuantity) for @link(T4DSpace). }
  TR4MatrixQuantity = specialize TRMatrixQuantity<T4DSpace>;

  { 2×2 complex quantity matrix. Specialization of @link(TCMatrixQuantity) for @link(T2DSpace). }
  TC2MatrixQuantity = specialize TCMatrixQuantity<T2DSpace>;
  { 3×3 complex quantity matrix. Specialization of @link(TCMatrixQuantity) for @link(T3DSpace). }
  TC3MatrixQuantity = specialize TCMatrixQuantity<T3DSpace>;
  { 4×4 complex quantity matrix. Specialization of @link(TCMatrixQuantity) for @link(T4DSpace). }
  TC4MatrixQuantity = specialize TCMatrixQuantity<T4DSpace>;
  {$ELSE}
  TR2MatrixQuantity = specialize TRMatrix<T2DSpace>;
  TR3MatrixQuantity = specialize TRMatrix<T3DSpace>;
  TR4MatrixQuantity = specialize TRMatrix<T4DSpace>;

  TC2MatrixQuantity = specialize TCMatrix<T2DSpace>;
  TC3MatrixQuantity = specialize TCMatrix<T3DSpace>;
  TC4MatrixQuantity = specialize TCMatrix<T4DSpace>;
  {$ENDIF}
