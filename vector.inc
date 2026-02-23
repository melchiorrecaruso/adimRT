
  (**
    Generic column vector of real values (@code(double)) with @code(TSpace.N) components.

    Components are stored in a 1-based array. Use the default array property
    @code(a[row]) to read and write individual components.
    Concrete types are provided as @link(TR2Vector), @link(TR3Vector), and @link(TR4Vector).
  *)
  generic TRVector<TSpace> = record
  type
    TRMatrix = specialize TRMatrix<TSpace>;
  private
    fm: array[1..TSpace.N] of double;

    (** Reads the component at position @code(ARow). *)
    function Get(ARow: longint): double;

    (** Writes the component at position @code(ARow). *)
    procedure Put(ARow: longint; AValue: double);
  public
    (** Returns @true if all components are zero. *)
    function IsNull: boolean;

    (** Returns @true if at least one component is non-zero. *)
    function IsNotNull: boolean;

    (**
      Returns the Euclidean norm (magnitude) of the vector.
      @code(|v| = √(Σ vᵢ²))
    *)
    function Norm: double;

    (**
      Returns the unit vector in the same direction.
      Each component is divided by @link(Norm).
    *)
    function Normalize: TRVector;

    (**
      Returns the element-wise reciprocal of the vector.
       Each component @code(vᵢ) is replaced by @code(1/vᵢ).
    *)
    function Reciprocal: TRVector;

    (**
      Returns the squared Euclidean norm of the vector.
      @code(|v|² = Σ vᵢ²). Avoids the square root of @link(Norm).
    *)
    function SquaredNorm: double;

    (** Returns @true if the two vectors differ in at least one component. *)
    class operator <>(const ALeft, ARight: TRVector): boolean;

    (** Returns @true if all corresponding components of the two vectors are equal. *)
    class operator =(const ALeft, ARight: TRVector): boolean;

    (** Unary plus. Returns the vector unchanged. *)
    class operator +(const ASelf: TRVector): TRVector;

    (** Returns the component-wise sum of two vectors. *)
    class operator +(const ALeft, ARight: TRVector): TRVector;

    (** Unary minus. Returns the negation of the vector: each component @code(vᵢ) becomes @code(-vᵢ). *)
    class operator -(const ASelf: TRVector): TRVector;

    (** Returns the component-wise difference of two vectors. *)
    class operator -(const ALeft, ARight: TRVector): TRVector;

    (**
      Returns the dot product (inner product) of two vectors.
      @code(u·v = Σ uᵢ·vᵢ)
    *)
    class operator *(const ALeft, ARight: TRVector): double;

    (** Returns the product of a real scalar and a vector. Each component is multiplied by @code(ALeft). *)
    class operator *(const ALeft: double; const ARight: TRVector): TRVector;

    (** Returns the product of a vector and a real scalar. Each component is multiplied by @code(ARight). *)
    class operator *(const ALeft: TRVector; const ARight: double): TRVector;

    (**
      Returns the product of a row vector and a square matrix: @code(v' = v·A).
      The result is a row vector.
    *)
    class operator *(const ALeft: TRVector; const ARight: TRMatrix): TRVector;

    (**
      Returns the product of a square matrix and a column vector: @code(v' = A·v).
      The result is a column vector.
    *)
    class operator *(const ALeft: TRMatrix; const ARight: TRVector): TRVector;

    (** Returns the vector divided by a real scalar. Each component is divided by @code(ARight). *)
    class operator /(const ALeft: TRVector; const ARight: double): TRVector;

    (** Returns the element-wise quotient of a scalar divided by a vector: each component becomes @code(ALeft/vᵢ). *)
    class operator /(const ALeft: double; const ARight: TRVector): TRVector;

  public
    (**
      Provides access to individual vector components using a 1-based index.
      @code(a[1]) is the first component.
    *)
    property a[ARow: longint]: double read Get write Put; default;
  end;

  (**
    Generic column vector of complex values (@link(TComplex)) with @code(TSpace.N) components.

    Extends @link(TRVector) to the complex domain. Supports implicit conversion
    from a real vector. Use the default array property @code(a[row]) to read and
    write individual components.
    Concrete types are provided as @link(TC2Vector), @link(TC3Vector), and @link(TC4Vector).
  *)
  generic TCVector<TSpace> = record
  type
    TRVector = specialize TRVector<TSpace>;
    TCMatrix = specialize TCMatrix<TSpace>;
  private
    fm: array[1..TSpace.N] of TComplex;

    (** Reads the complex component at position @code(ARow). *)
    function Get(ARow: longint): TComplex;

    (** Writes the complex component at position @code(ARow). *)
    procedure Put(ARow: longint; AValue: TComplex);
  public
    (** Returns @true if all components are zero. *)
    function IsNull: boolean;

    (** Returns @true if at least one component is non-zero. *)
    function IsNotNull: boolean;

    (**
      Returns the Euclidean norm (magnitude) of the complex vector.
      @code(|v| = √(Σ |vᵢ|²))
    *)
    function Norm: double;

    (**
      Returns the unit vector in the same direction.
      Each component is divided by @link(Norm).
    *)
    function Normalize: TCVector;

    (**
      Returns the element-wise reciprocal of the vector.
      Each component @code(vᵢ) is replaced by @code(1/vᵢ).
    *)
    function Reciprocal: TCVector;

    (**
      Returns the squared Euclidean norm of the complex vector.
      @code(|v|² = Σ |vᵢ|²). Avoids the square root of @link(Norm).
    *)
    function SquaredNorm: double;

    (**
      Implicit conversion from a real vector to a complex vector.
      Each component @code(vᵢ) is converted to @code(TComplex(Re=vᵢ, Im=0)).
    *)
    class operator :=(const ASelf: TRVector): TCVector;

    (** Returns @true if the two vectors differ in at least one component. *)
    class operator <>(const ALeft, ARight: TCVector): boolean;

    (** Returns @true if all corresponding components of the two vectors are equal. *)
    class operator =(const ALeft, ARight: TCVector): boolean;

    (** Unary plus. Returns the vector unchanged. *)
    class operator +(const ASelf: TCVector): TCVector;

    (** Returns the component-wise sum of two complex vectors. *)
    class operator +(const ALeft, ARight: TCVector): TCVector;

    (** Unary minus. Returns the negation of the vector: each component @code(vᵢ) becomes @code(-vᵢ). *)
    class operator -(const ASelf: TCVector): TCVector;

    (** Returns the component-wise difference of two complex vectors. *)
    class operator -(const ALeft, ARight: TCVector): TCVector;

    (**
      Returns the dot product (inner product) of two complex vectors.
      @code(u·v = Σ uᵢ·vᵢ)
      Note: this is the bilinear dot product, not the Hermitian inner product.
      Use @link(TC2VectorHelper.Dot) for the conjugate-linear inner product.
    *)
    class operator *(const ALeft, ARight: TCVector): TComplex;

    (** Returns the product of a real scalar and a complex vector. Each component is multiplied by @code(ALeft). *)
    class operator *(const ALeft: double; const ARight: TCVector): TCVector;

    (** Returns the product of a complex vector and a real scalar. Each component is multiplied by @code(ARight). *)
    class operator *(const ALeft: TCVector; const ARight: double): TCVector;

    (** Returns the product of a complex scalar and a complex vector. Each component is multiplied by @code(ALeft). *)
    class operator *(const ALeft: TComplex; const ARight: TCVector): TCVector;

    (** Returns the product of a complex vector and a complex scalar. Each component is multiplied by @code(ARight). *)
    class operator *(const ALeft: TCVector; const ARight: TComplex): TCVector;

    (**
      Returns the product of a row complex vector and a square complex matrix: @code(v' = v·A).
      The result is a row vector.
    *)
    class operator *(const ALeft: TCVector; const ARight: TCMatrix): TCVector;

    (**
      Returns the product of a square complex matrix and a column complex vector: @code(v' = A·v).
      The result is a column vector.
    *)
    class operator *(const ALeft: TCMatrix; const ARight: TCVector): TCVector;

    (** Returns the complex vector divided by a real scalar. Each component is divided by @code(ARight). *)
    class operator /(const ALeft: TCVector; const ARight: double): TCVector;

    (** Returns the element-wise quotient of a real scalar divided by a complex vector: each component becomes @code(ALeft/vᵢ). *)
    class operator /(const ALeft: double; const ARight: TCVector): TCVector;

    (** Returns the complex vector divided by a complex scalar. Each component is divided by @code(ARight). *)
    class operator /(const ALeft: TCVector; const ARight: TComplex): TCVector;

    (** Returns the element-wise quotient of a complex scalar divided by a complex vector: each component becomes @code(ALeft/vᵢ). *)
    class operator /(const ALeft: TComplex; const ARight: TCVector): TCVector;

  public
    (**
      Provides access to individual complex vector components using a 1-based index.
      @code(a[1]) is the first component.
    *)
    property a[ARow: longint]: TComplex read Get write Put; default;
  end;

  (** 2-component complex vector. Specialization of @link(TCVector) for @link(T2DSpace). *)
  TC2Vector = specialize TCVector<T2DSpace>;
  (** 3-component complex vector. Specialization of @link(TCVector) for @link(T3DSpace). *)
  TC3Vector = specialize TCVector<T3DSpace>;
  (** 4-component complex vector. Specialization of @link(TCVector) for @link(T4DSpace). *)
  TC4Vector = specialize TCVector<T4DSpace>;

  (** 2-component real vector. Specialization of @link(TRVector) for @link(T2DSpace). *)
  TR2Vector = specialize TRVector<T2DSpace>;
  (** 3-component real vector. Specialization of @link(TRVector) for @link(T3DSpace). *)
  TR3Vector = specialize TRVector<T3DSpace>;
  (** 4-component real vector. Specialization of @link(TRVector) for @link(T4DSpace). *)
  TR4Vector = specialize TRVector<T4DSpace>;

  (** Fixed-size array of 2 complex values. Used to store eigenvalues of @link(TC2Matrix). *)
  TC2ArrayOfComplex = array[1..T2DSpace.N] of TComplex;
  (** Fixed-size array of 3 complex values. Used to store eigenvalues of @link(TC3Matrix). *)
  TC3ArrayOfComplex = array[1..T3DSpace.N] of TComplex;
  (** Fixed-size array of 4 complex values. Used to store eigenvalues of @link(TC4Matrix). *)
  TC4ArrayOfComplex = array[1..T4DSpace.N] of TComplex;

  (** Fixed-size array of 2 complex vectors. Used to store eigenvectors of @link(TC2Matrix). *)
  TC2ArrayOfVector = array[1..T2DSpace.N] of TC2Vector;
  (** Fixed-size array of 3 complex vectors. Used to store eigenvectors of @link(TC3Matrix). *)
  TC3ArrayOfVector = array[1..T3DSpace.N] of TC3Vector;
  (** Fixed-size array of 4 complex vectors. Used to store eigenvectors of @link(TC4Matrix). *)
  TC4ArrayOfVector = array[1..T4DSpace.N] of TC4Vector;

  (**
    Generic column vector of real physical quantities (@link(TQuantity)) with @code(TSpace.N) components.

    Each component carries the same physical dimension, stored in @code(FDim).
    Supports arithmetic operations with dimensional consistency checking.
    When @code(ADIMOFF) is defined, degenerates to the corresponding @link(TRVector) specialization.
    Concrete types are provided as @link(TR2VecQuantity), @link(TR3VecQuantity), and @link(TR4VecQuantity).
  *)
  {$IFNDEF ADIMOFF}
  generic TRVecQuantity<TSpace> = record
  type
    TRVector = specialize TRVector<TSpace>;
    TRMatrixQuantity = specialize TRMatrixQuantity<TSpace>;
  private
    FDim: TDimension;
    FValue: TRVector;

    (** Reads the component at position @code(ARow) as a @link(TQuantity). *)
    function Get(ARow: longint): TQuantity;

    (** Writes the component at position @code(ARow) as a @link(TQuantity). *)
    procedure Put(ARow: longint; const AQuantity: TQuantity);
  public
    (**
      Returns the unit vector in the same direction.
      The dimension is preserved; only the numerical values are normalized.
    *)
    function Normalize: TRVecQuantity;

    (** Returns @true if the two vectors differ in dimension or in at least one component. *)
    class operator <>(const ALeft, ARight: TRVecQuantity): boolean;

    (** Returns @true if both vectors have the same dimension and all corresponding components are equal. *)
    class operator =(const ALeft, ARight: TRVecQuantity): boolean;

    (** Unary plus. Returns the quantity vector unchanged. *)
    class operator +(const AValue: TRVecQuantity): TRVecQuantity;

    (** Returns the component-wise sum of two quantity vectors. Both operands must have the same dimension. *)
    class operator +(const ALeft, ARight: TRVecQuantity): TRVecQuantity;

    (** Unary minus. Returns the negation of the quantity vector. *)
    class operator -(const AValue: TRVecQuantity): TRVecQuantity;

    (** Returns the component-wise difference of two quantity vectors. Both operands must have the same dimension. *)
    class operator -(const ALeft, ARight: TRVecQuantity): TRVecQuantity;

    (**
      Returns the product of a real quantity scalar and a quantity vector.
      The resulting dimension is the product of the two dimensions.
    *)
    class operator *(const ALeft: TQuantity; const ARight: TRVecQuantity): TRVecQuantity;

    (**
      Returns the product of a quantity vector and a real quantity scalar.
      The resulting dimension is the product of the two dimensions.
    *)
    class operator *(const ALeft: TRVecQuantity; const ARight: TQuantity): TRVecQuantity;

    (**
      Returns the product of a real quantity matrix and a quantity vector: @code(v' = A·v).
      The resulting dimension is the product of the two dimensions.
    *)
    class operator *(const ALeft: TRMatrixQuantity; const ARight: TRVecQuantity): TRVecQuantity;

    (**
      Returns the dot product of two quantity vectors.
      @code(u·v = Σ uᵢ·vᵢ). The resulting dimension is the product of the two dimensions.
    *)
    class operator *(const ALeft, ARight: TRVecQuantity): TQuantity;

    (**
      Returns the quotient of a real quantity scalar divided by a quantity vector.
      Each component becomes @code(ALeft/vᵢ). The resulting dimension is the ratio of the two dimensions.
    *)
    class operator /(const ALeft: TQuantity; const ARight: TRVecQuantity): TRVecQuantity;

    (**
      Returns the quantity vector divided by a real quantity scalar.
      The resulting dimension is the ratio of the two dimensions.
    *)
    class operator /(const ALeft: TRVecQuantity; const ARight: TQuantity): TRVecQuantity;

  public
    (**
      Provides access to individual vector components using a 1-based index.
      Each component is returned as a @link(TQuantity) carrying the vector's dimension.
    *)
    property a[ARow: longint]: TQuantity read Get write Put; default;
  end;

  (**
    Generic column vector of complex physical quantities (@link(TComplexQuantity)) with @code(TSpace.N) components.

    Each component carries the same physical dimension, stored in @code(FDim).
    Supports arithmetic operations with dimensional consistency checking.
    When @code(ADIMOFF) is defined, degenerates to the corresponding @link(TCVector) specialization.
    Concrete types are provided as @link(TC2VecQuantity), @link(TC3VecQuantity), and @link(TC4VecQuantity).
  *)
  generic TCVecQuantity<TSpace> = record
  type
    TCVector = specialize TCVector<TSpace>;
    TCMatrixQuantity = specialize TCMatrixQuantity<TSpace>;
  private
    FDim: TDimension;
    FValue: TCVector;

    (** Reads the component at position @code(ARow) as a @link(TComplexQuantity). *)
    function Get(ARow: longint): TComplexQuantity;

    (** Writes the component at position @code(ARow) as a @link(TComplexQuantity). *)
    procedure Put(ARow: longint; const AQuantity: TComplexQuantity);
  public
    (**
      Returns the unit vector in the same direction.
      The dimension is preserved; only the numerical values are normalized.
    *)
    function Normalize: TCVecQuantity;

    (**
      Implicit conversion from a dimensionless complex vector to a complex quantity vector.
      The resulting vector has a scalar (dimensionless) dimension.
    *)
    class operator :=(const AValue: TCVector): TCVecQuantity;

    (** Returns @true if the two vectors differ in dimension or in at least one component. *)
    class operator <>(const ALeft, ARight: TCVecQuantity): boolean;

    (** Returns @true if both vectors have the same dimension and all corresponding components are equal. *)
    class operator =(const ALeft, ARight: TCVecQuantity): boolean;

    (** Unary plus. Returns the complex quantity vector unchanged. *)
    class operator +(const AValue: TCVecQuantity): TCVecQuantity;

    (** Returns the component-wise sum of two complex quantity vectors. Both operands must have the same dimension. *)
    class operator +(const ALeft, ARight: TCVecQuantity): TCVecQuantity;

    (** Unary minus. Returns the negation of the complex quantity vector. *)
    class operator -(const AValue: TCVecQuantity): TCVecQuantity;

    (** Returns the component-wise difference of two complex quantity vectors. Both operands must have the same dimension. *)
    class operator -(const ALeft, ARight: TCVecQuantity): TCVecQuantity;

    (**
      Returns the dot product of two complex quantity vectors.
      @code(u·v = Σ uᵢ·vᵢ). The resulting dimension is the product of the two dimensions.
    *)
    class operator *(const ALeft, ARight: TCVecQuantity): TComplexQuantity;

    (**
      Returns the product of a real quantity scalar and a complex quantity vector.
      The resulting dimension is the product of the two dimensions.
    *)
    class operator *(const ALeft: TQuantity; const ARight: TCVecQuantity): TCVecQuantity;

    (**
      Returns the product of a complex quantity vector and a real quantity scalar.
      The resulting dimension is the product of the two dimensions.
    *)
    class operator *(const ALeft: TCVecQuantity; const ARight: TQuantity): TCVecQuantity;

    (**
      Returns the product of a complex quantity vector and a complex quantity matrix: @code(v' = v·A).
      The resulting dimension is the product of the two dimensions.
    *)
    class operator *(const ALeft: TCVecQuantity; const ARight: TCMatrixQuantity): TCVecQuantity;

    (**
      Returns the product of a complex quantity matrix and a complex quantity vector: @code(v' = A·v).
      The resulting dimension is the product of the two dimensions.
    *)
    class operator *(const ALeft: TCMatrixQuantity; const ARight: TCVecQuantity): TCVecQuantity;

    (**
      Returns the dot product of a dimensionless complex vector and a complex quantity vector.
      @code(u·v = Σ uᵢ·vᵢ). The dimension of the result equals the dimension of @code(ARight).
    *)
    class operator *(const ALeft: TCVector; const ARight: TCVecQuantity): TComplexQuantity;

    (**
      Returns the quotient of a real quantity scalar divided by a complex quantity vector.
      Each component becomes @code(ALeft/vᵢ). The resulting dimension is the ratio of the two dimensions.
    *)
    class operator /(const ALeft: TQuantity; const ARight: TCVecQuantity): TCVecQuantity;

    (**
      Returns the complex quantity vector divided by a real quantity scalar.
      The resulting dimension is the ratio of the two dimensions.
    *)
    class operator /(const ALeft: TCVecQuantity; const ARight: TQuantity): TCVecQuantity;

  public
    (**
      Provides access to individual vector components using a 1-based index.
      Each component is returned as a @link(TComplexQuantity) carrying the vector's dimension.
    *)
    property a[ARow: longint]: TComplexQuantity read Get write Put; default;
  end;

  (** 2-component real quantity vector. Specialization of @link(TRVecQuantity) for @link(T2DSpace). *)
  TR2VecQuantity = specialize TRVecQuantity<T2DSpace>;
  (** 3-component real quantity vector. Specialization of @link(TRVecQuantity) for @link(T3DSpace). *)
  TR3VecQuantity = specialize TRVecQuantity<T3DSpace>;
  (** 4-component real quantity vector. Specialization of @link(TRVecQuantity) for @link(T4DSpace). *)
  TR4VecQuantity = specialize TRVecQuantity<T4DSpace>;

  (** 2-component complex quantity vector. Specialization of @link(TCVecQuantity) for @link(T2DSpace). *)
  TC2VecQuantity = specialize TCVecQuantity<T2DSpace>;
  (** 3-component complex quantity vector. Specialization of @link(TCVecQuantity) for @link(T3DSpace). *)
  TC3VecQuantity = specialize TCVecQuantity<T3DSpace>;
  (** 4-component complex quantity vector. Specialization of @link(TCVecQuantity) for @link(T4DSpace). *)
  TC4VecQuantity = specialize TCVecQuantity<T4DSpace>;

  {$ELSE}
  TR2VecQuantity = specialize TRVector<T2DSpace>;
  TR3VecQuantity = specialize TRVector<T3DSpace>;
  TR4VecQuantity = specialize TRVector<T4DSpace>;

  TC2VecQuantity = specialize TCVector<T2DSpace>;
  TC3VecQuantity = specialize TCVector<T3DSpace>;
  TC4VecQuantity = specialize TCVector<T4DSpace>;
  {$ENDIF}

  (**
    Record helper for @link(TR2Matrix) providing additional operations specific to 2×2 real matrices.
  *)
  TR2MatrixHelper = record helper for TR2Matrix
    (** Returns the determinant of the 2×2 matrix: @code(det(A) = a₁₁·a₂₂ - a₁₂·a₂₁). *)
    function Determinant: double;

    (**
      Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    *)
    function Reciprocal(const ADeterminant: double): TR2Matrix;

    (** Converts the matrix to its default string representation. *)
    function ToString: string;

    (**
      Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    *)
    function ToString(APrecision, ADigits: integer): string;

    (** Returns the transpose of the 2×2 matrix. *)
    function Transpose: TR2Matrix;
  end;

  (**
    Record helper for @link(TR3Matrix) providing additional operations specific to 3×3 real matrices.
  *)
  TR3MatrixHelper = record helper for TR3Matrix
    (** Returns the determinant of the 3×3 matrix using cofactor expansion. *)
    function Determinant: double;

    (**
      Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    *)
    function Reciprocal(const ADeterminant: double): TR3Matrix;

    (** Converts the matrix to its default string representation. *)
    function ToString: string;

    (**
      Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    *)
    function ToString(APrecision, ADigits: integer): string;

    (** Returns the transpose of the 3×3 matrix. *)
    function Transpose: TR3Matrix;
  end;

  (**
    Record helper for @link(TR4Matrix) providing additional operations specific to 4×4 real matrices.
  *)
  TR4MatrixHelper = record helper for TR4Matrix
    (** Returns the determinant of the 4×4 matrix using cofactor expansion. *)
    function Determinant: double;

    (**
      Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    *)
    function Reciprocal(const ADeterminant: double): TR4Matrix;

    (** Converts the matrix to its default string representation. *)
    function ToString: string;

    (**
      Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    *)
    function ToString(APrecision, ADigits: integer): string;

    (** Returns the transpose of the 4×4 matrix. *)
    function Transpose: TR4Matrix;
  end;

  (**
    Record helper for @link(TC2Matrix) providing additional operations specific to 2×2 complex matrices.
  *)
  TC2MatrixHelper = record helper for TC2Matrix
    (** Returns the element-wise complex conjugate of the matrix. *)
    function Conjugate: TC2Matrix;

    (** Returns the determinant of the 2×2 complex matrix: @code(det(A) = a₁₁·a₂₂ - a₁₂·a₂₁). *)
    function Determinant: TComplex;

    (**
      Returns the diagonal matrix built from the given eigenvalues.
      @param(AEigenValues The eigenvalues, typically computed via @link(Eigenvalues).)
    *)
    function Diagonalize(const AEigenValues: TC2ArrayOfComplex): TC2Matrix;

    (** Returns the eigenvalues of the 2×2 complex matrix as a fixed-size array. *)
    function Eigenvalues: TC2ArrayOfComplex;

    (**
      Returns the eigenvectors of the 2×2 complex matrix corresponding to the given eigenvalues.
      @param(AEigenValues The eigenvalues, computed via @link(Eigenvalues).)
    *)
    function Eigenvectors(const AEigenValues: TC2ArrayOfComplex): TC2ArrayOfVector;

    (**
      Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    *)
    function Reciprocal(const ADeterminant: TComplex): TC2Matrix;

    (** Converts the matrix to its default string representation. *)
    function ToString: string;

    (**
      Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    *)
    function ToString(APrecision, ADigits: integer): string;

    (** Returns the transpose of the 2×2 complex matrix. *)
    function Transpose: TC2Matrix;

    (**
      Returns the conjugate transpose (Hermitian adjoint) of the matrix: @code(A† = (Aᵀ)"*").
      Each element @code([i,j]) of the result is the conjugate of @code([j,i]) of the original.
    *)
    function TransposeConjugate: TC2Matrix;
  end;

  (**
    Record helper for @link(TC3Matrix) providing additional operations specific to 3×3 complex matrices.
  *)
  TC3MatrixHelper = record helper for TC3Matrix
    (** Returns the element-wise complex conjugate of the matrix. *)
    function Conjugate: TC3Matrix;

    (** Returns the determinant of the 3×3 complex matrix using cofactor expansion. *)
    function Determinant: TComplex;

    (**
      Returns the diagonal matrix built from the given eigenvalues.
      @param(AEigenValues The eigenvalues, typically computed via @link(Eigenvalues).)
    *)
    function Diagonalize(const AEigenValues: TC3ArrayOfComplex): TC3Matrix;

    (** Returns the eigenvalues of the 3×3 complex matrix as a fixed-size array. *)
    function Eigenvalues: TC3ArrayOfComplex;

    (**
      Returns the eigenvectors of the 3×3 complex matrix corresponding to the given eigenvalues.
      @param(AEigenValues The eigenvalues, computed via @link(Eigenvalues).)
    *)
    function Eigenvectors(const AEigenValues: TC3ArrayOfComplex): TC3ArrayOfVector;

    (**
      Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    *)
    function Reciprocal(const ADeterminant: TComplex): TC3Matrix;

    (** Converts the matrix to its default string representation. *)
    function ToString: string;

    (**
      Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    *)
    function ToString(APrecision, ADigits: integer): string;

    (** Returns the transpose of the 3×3 complex matrix. *)
    function Transpose: TC3Matrix;

    (**
      Returns the conjugate transpose (Hermitian adjoint) of the matrix: @code(A† = (Aᵀ)"*").
      Each element @code([i,j]) of the result is the conjugate of @code([j,i]) of the original.
    *)
    function TransposeConjugate: TC3Matrix;
  end;

  (**
    Record helper for @link(TC4Matrix) providing additional operations specific to 4×4 complex matrices.
  *)
  TC4MatrixHelper = record helper for TC4Matrix
    (** Returns the element-wise complex conjugate of the matrix. *)
    function Conjugate: TC4Matrix;

    (** Returns the determinant of the 4×4 complex matrix using cofactor expansion. *)
    function Determinant: TComplex;

    (**
      Returns the diagonal matrix built from the given eigenvalues.
      @param(AEigenValues The eigenvalues, typically computed via @link(Eigenvalues).)
    *)
    function Diagonalize(const AEigenValues: TC4ArrayOfComplex): TC4Matrix;

    (** Returns the eigenvalues of the 4×4 complex matrix as a fixed-size array. *)
    function Eigenvalues: TC4ArrayOfComplex;

    (**
      Returns the eigenvectors of the 4×4 complex matrix corresponding to the given eigenvalues.
      @param(AEigenValues The eigenvalues, computed via @link(Eigenvalues).)
    *)
    function Eigenvectors(const AEigenValues: TC4ArrayOfComplex): TC4ArrayOfVector;

    (**
      Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    *)
    function Reciprocal(const ADeterminant: TComplex): TC4Matrix;

    (** Converts the matrix to its default string representation. *)
    function ToString: string;

    (**
      Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    *)
    function ToString(APrecision, ADigits: integer): string;

    (** Returns the transpose of the 4×4 complex matrix. *)
    function Transpose: TC4Matrix;

    (**
      Returns the conjugate transpose (Hermitian adjoint) of the matrix: @code(A† = (Aᵀ)"*").
      Each element @code([i,j]) of the result is the conjugate of @code([j,i]) of the original.
    *)
    function TransposeConjugate: TC4Matrix;
  end;

  (**
    Record helper for @link(TC2Vector) providing additional operations specific to 2-component complex vectors.
  *)
  TC2VectorHelper = record helper for TC2Vector
    (** Returns the element-wise complex conjugate of the vector. *)
    function Conjugate: TC2Vector;

    (**
      Returns the Hermitian inner product of two complex vectors.
      @code(〈u,v〉 = Σ conj(uᵢ)·vᵢ)
      Unlike the @code("*") operator, this uses the conjugate of the left operand.
      @param(AVector The right-hand operand.)
    *)
    function Dot(const AVector: TC2Vector): TComplex;

    (** Converts the vector to its default string representation. *)
    function ToString: string;

    (**
      Converts the vector to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    *)
    function ToString(APrecision, ADigits: integer): string;
  end;

  (**
    Record helper for @link(TC3Vector) providing additional operations specific to 3-component complex vectors.
  *)
  TC3VectorHelper = record helper for TC3Vector
    (** Returns the element-wise complex conjugate of the vector. *)
    function Conjugate: TC3Vector;

    (**
      Returns the Hermitian inner product of two complex vectors.
      @code(〈u,v〉 = Σ conj(uᵢ)·vᵢ)
      Unlike the @code("*") operator, this uses the conjugate of the left operand.
      @param(AVector The right-hand operand.)
    *)
    function Dot(const AVector: TC3Vector): TComplex;

    (** Converts the vector to its default string representation. *)
    function ToString: string;

    (**
      Converts the vector to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    *)
    function ToString(APrecision, ADigits: integer): string;
  end;

  (**
    Record helper for @link(TC4Vector) providing additional operations specific to 4-component complex vectors.
  *)
  TC4VectorHelper = record helper for TC4Vector
    (** Returns the element-wise complex conjugate of the vector. *)
    function Conjugate: TC4Vector;

    (**
      Returns the Hermitian inner product of two complex vectors.
      @code(〈u,v〉 = Σ conj(uᵢ)·vᵢ)
      Unlike the @code("*") operator, this uses the conjugate of the left operand.
      @param(AVector The right-hand operand.)
    *)
    function Dot(const AVector: TC4Vector): TComplex;

    (** Converts the vector to its default string representation. *)
    function ToString: string;

    (**
      Converts the vector to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    *)
    function ToString(APrecision, ADigits: integer): string;
  end;

  (**
    Record helper for @link(TR2Vector) providing additional operations specific to 2-component real vectors.
  *)
  TR2VectorHelper = record helper for TR2Vector
    (**
      Returns the dot product of two 2-component real vectors.
      @code(u·v = u₁v₁ + u₂v₂)
      @param(AVector The right-hand operand.)
    *)
    function Dot(const AVector: TR2Vector): double;

    (** Converts the vector to its default string representation. *)
    function ToString: string;

    (**
      Converts the vector to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    *)
    function ToString(APrecision, ADigits: longint): string;
  end;

  (**
    Record helper for @link(TR3Vector) providing additional operations specific to 3-component real vectors.
  *)
  TR3VectorHelper = record helper for TR3Vector
    (**
      Returns the dot product of two 3-component real vectors.
      @code(u·v = u₁v₁ + u₂v₂ + u₃v₃)
      @param(AVector The right-hand operand.)
    *)
    function Dot(const AVector: TR3Vector): double;

    (**
      Returns the cross product of two 3-component real vectors.
      @code(u×v = (u₂v₃ - u₃v₂, u₃v₁ - u₁v₃, u₁v₂ - u₂v₁))
      The result is a vector perpendicular to both operands.
      @param(AVector The right-hand operand.)
    *)
    function Cross(const AVector: TR3Vector): TR3Vector;

    (** Converts the vector to its default string representation. *)
    function ToString: string;

    (**
      Converts the vector to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    *)
    function ToString(APrecision, ADigits: longint): string;
  end;

  (**
    Record helper for @link(TR4Vector) providing additional operations specific to 4-component real vectors.
  *)
  TR4VectorHelper = record helper for TR4Vector
    (**
      Returns the dot product of two 4-component real vectors.
      @code(u·v = u₁v₁ + u₂v₂ + u₃v₃ + u₄v₄)
      @param(AVector The right-hand operand.)
    *)
    function Dot(const AVector: TR4Vector): double;

    (** Converts the vector to its default string representation. *)
    function ToString: string;

    (**
      Converts the vector to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    *)
    function ToString(APrecision, ADigits: longint): string;
  end;

