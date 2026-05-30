unit ADimMath;

{$H+}{$J-}
{$modeswitch advancedrecords}

interface

type
  { Represents a complex number in Cartesian form: @code(z = Re + i·Im).

    A complex number consists of:
    @unorderedList(
      @item(@bold(Re): the real part)
      @item(@bold(Im): the imaginary part)
    )
    The imaginary unit @code(i) is defined by @code(i² = -1).
    All arithmetic operations follow standard complex number algebra.
  }
  TComplex = record
  private
    fRe, fIm: double;
  public
    { Returns the argument (phase angle) of the complex number, in radians.
      The argument is defined as @code(φ = arctan(Im / Re)), adjusted for quadrant.
      Returns a value in the range @code([-π, π]).
    }
    function Arg: double;

    { Returns the complex conjugate of the number.
      If @code(z = a + i·b), the conjugate is @code(z* = a - i·b).
    }
    function Conjugate: TComplex;

    { Returns @true if the complex number is zero, i.e. both @code(Re = 0) and @code(Im = 0). }
    function IsNull: boolean;

    { Returns @true if the complex number is not zero,
      i.e. at least one of @code(Re) or @code(Im) is non-zero.
    }
    function IsNotNull: boolean;

    { Returns the modulus (magnitude) of the complex number.
      Defined as @code(|z| = √(Re² + Im²)).
    }
    function Norm: double;

    { Returns the squared modulus of the complex number.
      Defined as @code(|z|² = Re² + Im²).
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: double;

    { Returns the reciprocal of the complex number: @code(1 / z).
      @raises(Exception if the number is zero, i.e. @code(|z| = 0).)
    }
    function Reciprocal: TComplex;

    { Converts the complex number to its default string representation.
      The format is @code(a + bi) or @code(a - bi).
    }
    function ToString: string;

    { Converts the complex number to a formatted string with controlled precision.
      @param(APrecision Number of significant digits for floating point formatting.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Sets the complex number to zero.
      After this call @code(Re = 0.0) and @code(Im = 0.0).
    }
    procedure Zero;

    { Implicit conversion from a real value to a complex number.
      The resulting complex number has @code(Im = 0).
    }
    class operator := (const AValue: double): TComplex;

    { Returns @true if both the real and imaginary parts of the two operands are equal. }
    class operator =(const ALeft, ARight: TComplex): boolean; inline;

    { Returns @true if the real or imaginary parts of the two operands differ. }
    class operator <>(const ALeft, ARight: TComplex): boolean; inline;

    { Unary plus. Returns the complex number unchanged. }
    class operator +(const AValue: TComplex): TComplex; inline;

    { Returns the sum of two complex numbers: @code((a+bi) + (c+di) = (a+c) + (b+d)i). }
    class operator +(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the sum of a real number and a complex number. }
    class operator +(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Returns the sum of a complex number and a real number. }
    class operator +(const ALeft: TComplex; const ARight: double): TComplex; inline;

    { Unary minus. Returns the negation of the complex number: @code(-(a+bi) = -a - bi). }
    class operator -(const AValue: TComplex): TComplex; inline;

    { Returns the difference of two complex numbers: @code((a+bi) - (c+di) = (a-c) + (b-d)i). }
    class operator -(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the difference of a real number and a complex number. }
    class operator -(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Returns the difference of a complex number and a real number. }
    class operator -(const ALeft: TComplex; const ARight: double): TComplex; inline;

    { Returns the product of two complex numbers.
      @code((a+bi)·(c+di) = (ac - bd) + (ad + bc)i)
    }
    class operator *(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the product of a real number and a complex number. }
    class operator *(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Returns the product of a complex number and a real number. }
    class operator *(const ALeft: TComplex; const ARight: double): TComplex; inline;

    { Returns the quotient of two complex numbers.
      @raises(Exception if the divisor is zero, i.e. @code(|ARight| = 0).)
    }
    class operator /(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the quotient of a real number divided by a complex number. }
    class operator /(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Returns the quotient of a complex number divided by a real number. }
    class operator /(const ALeft: TComplex; const ARight: double): TComplex; inline;
  public
    { Real part of the complex number. }
    property Re: double read fRe write fRe;

    { Imaginary part of the complex number. }
    property Im: double read fIm write fIm;
  end;

  { Represents the imaginary unit @code(i), defined by @code(i² = -1).

    This record has no fields: it acts as a compile-time constant used to construct
    @link(TComplex) numbers naturally via operator overloading.
    A global constant of this type (conventionally named @code(i)) should be declared
    to allow idiomatic use in expressions.
  }
  TImaginaryUnit = record
  public
    { Implicit conversion of the imaginary unit to a @link(TComplex) number.
      Returns @code(TComplex(Re=0, Im=1)).
    }
    class operator := (const ASelf: TImaginaryUnit): TComplex;
    class operator *(const ALeft, ARight: TImaginaryUnit): double;
    class operator /(const ALeft, ARight: TImaginaryUnit): double;
    class operator -(const AValue: TImaginaryUnit): TComplex;
    class operator +(const AValue: TImaginaryUnit): TComplex;
    class operator +(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
    class operator +(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
    class operator -(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
    class operator -(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
    class operator +(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
    class operator +(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
    class operator -(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
    class operator -(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
    class operator *(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
    class operator *(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
    class operator *(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
    class operator *(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
    class operator /(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
    class operator /(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
    class operator /(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
    class operator /(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
  end;

  { Tag record representing a 2-dimensional space.
    Used as a generic parameter to instantiate 2×2 matrix types.
  }
  T2DSpace = record const N = 2; end;

  { Tag record representing a 3-dimensional space.
    Used as a generic parameter to instantiate 3×3 matrix types.
  }
  T3DSpace = record const N = 3; end;

  { Tag record representing a 4-dimensional space.
    Used as a generic parameter to instantiate 4×4 matrix types.
  }
  T4DSpace = record const N = 4; end;

  { Dynamic array of @code(double) values. Used to store eigenvalues of @link(TRMatrix). }
  TArrayOfDouble = array of double;

  { Dynamic array of @link(TComplex) values. Used to store eigenvalues of @link(TCMatrix). }
  TArrayOfComplex = array of TComplex;

  { Generic square matrix of real values (@code(double)) with dimension
    @code(N × N), where N is determined at runtime.

    The matrix elements are stored in a dynamic 0-based 2D array allocated
    via @link(Init). Use the default array property @code(a[row, col]) to
    read and write individual elements using 0-based indices.
    Concrete types are provided as @link(TR2Matrix), @link(TR3Matrix),
    and @link(TR4Matrix) for fixed small dimensions.
  }
  generic TRMatrix<TSpace> = record
  private
    fm: array of array of double;

    { Writes the element at position (@code(ARow), @code(ACol)). }
    procedure Put(ARow, ACol: longint; AValue: double);

    { Reads the element at position (@code(ARow), @code(ACol)). }
    function Get(ARow, ACol: longint): double;

    { Performs forward Gaussian elimination with partial pivoting.
      Used internally by @link(Determinant) and @link(RowReduction).
      @param(SwapCount Number of row swaps performed, used to determine
      the sign of the determinant.)
      @return(Upper triangular matrix after elimination.)
    }
    function ForwardElimination(out SwapCount: integer): TRMatrix; inline;

    { Computes the Householder reflection vector for column @code(k).
      Used internally by @link(HessenbergReduction).
      @param(k Column index, 0-based.)
      @return(Normalized Householder vector stored in column 0.)
    }
    function HouseholderVector(k: longint): TRMatrix;

    { Reduces the matrix to upper Hessenberg form using Householder reflections.
      Used internally by @link(Eigenvalues).
      @return(Upper Hessenberg matrix similar to Self, with same eigenvalues.)
    }
    function HessenbergReduction: TRMatrix;

    { Decomposes the Hessenberg matrix into Q·R using Givens rotations.
      Optimized for Hessenberg matrices: @code(O(N²)) instead of @code(O(N³)).
      Used internally by @link(Eigenvalues).
      @param(Q Orthogonal matrix.)
      @param(R Upper triangular matrix.)
    }
    procedure QRDecompose(out Q, R: TRMatrix);

  public
    { Allocates the @code(N × N) dynamic array and sets all elements to zero.
      Must be called before using any other method on a local variable.
    }
    procedure Init;

    { Returns a deep copy of the matrix.
      Required because dynamic array assignment copies only the reference.
    }
    function Clone: TRMatrix;

    { Returns @true if all elements of the matrix are zero. }
    function IsNull: boolean;

    { Returns @true if at least one element of the matrix is non-zero. }
    function IsNotNull: boolean;

    { Returns @true if the matrix satisfies @code(A·Aᵀ = I). }
    function IsOrthogonal: boolean;

    { Returns @true if two matrices are equal within the default floating
      point tolerance @link(DefaultEpsilon).
    }
    function SameValue(const AMatrix: TRMatrix): boolean;

    { Returns the number of linearly independent rows or columns. }
    function Rank: longint;

    { Swaps rows @code(ARow1) and @code(ARow2) in place. 0-based indices. }
    procedure Swap(ARow1, ARow2: longint);

    { Returns the trace of the matrix, i.e. the sum of diagonal elements:
      @code(tr(A) = Σ A[i,i]).
    }
    function Trace: double;

    { Returns the Frobenius norm of the matrix:
      @code(‖A‖_F = √(Σ|a[i,j]|²)).
    }
    function Norm: double;

    { Returns the transpose of the matrix.
      Element @code([i,j]) of the result equals element @code([j,i]) of the original.
    }
    function Transpose: TRMatrix;

    { Returns the row-reduced echelon form of the matrix using Gaussian
      elimination with partial pivoting. The original matrix is not modified.
    }
    function RowReduction: TRMatrix;

    { Returns the determinant of the matrix using Gaussian elimination
      with partial pivoting (LU decomposition).
      Precision is equivalent to closed-form formulas for well-conditioned
      matrices. Both methods are subject to standard IEEE 754 rounding.
    }
    function Determinant: double;

    { Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    }
    function Reciprocal(const ADeterminant: double): TRMatrix;

    { Returns the eigenvalues of the matrix as a dynamic array of @code(double).
      Uses the QR algorithm with Hessenberg reduction and Wilkinson shift.
      Convergence is typically cubic with Wilkinson shift.
      @return(Dynamic array of @code(TSpace.N) real eigenvalues, not guaranteed to be sorted.)
    }
    function Eigenvalues: TArrayOfDouble;

    { Returns the @code(N × N) identity matrix with ones on the diagonal
      and zeros elsewhere.
    }
    class function Identity: TRMatrix; static;

    { Returns the @code(N × N) null matrix with all elements equal to zero. }
    class function Null: TRMatrix; static;

    { Converts the matrix to its default string representation. }
    function ToString: string;

    { Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Returns @true if the two matrices differ in at least one element. }
    class operator <>(const ALeft, ARight: TRMatrix): boolean;

    { Returns @true if all corresponding elements of the two matrices are equal. }
    class operator =(const ALeft, ARight: TRMatrix): boolean;

    { Returns the element-wise sum of two matrices of the same size. }
    class operator +(const ALeft, ARight: TRMatrix): TRMatrix;

    { Returns the element-wise difference of two matrices of the same size. }
    class operator -(const ALeft, ARight: TRMatrix): TRMatrix;

    { Returns the matrix product of two matrices.
      @code((A·B)[i,j] = Σ_k A[i,k] · B[k,j])
    }
    class operator *(const ALeft, ARight: TRMatrix): TRMatrix;

    { Returns the product of a real scalar and a matrix. }
    class operator *(const ALeft: double; const ARight: TRMatrix): TRMatrix;

    { Returns the product of a matrix and a real scalar. }
    class operator *(const ALeft: TRMatrix; const ARight: double): TRMatrix;

    { Returns the matrix divided by a real scalar. }
    class operator /(const ALeft: TRMatrix; const ARight: double): TRMatrix;

  public
    { Provides access to individual matrix elements using 0-based row and
      column indices. @code(a[0,0]) is the top-left element.
    }
    property a[ARow, ACol: longint]: double read Get write Put; default;
  end;

  { 2×2 real matrix. Specialization of @link(TRMatrix) for @link(T2DSpace). }
  TR2Matrix = specialize TRMatrix<T2DSpace>;

  { 3×3 real matrix. Specialization of @link(TRMatrix) for @link(T3DSpace). }
  TR3Matrix = specialize TRMatrix<T3DSpace>;

  { 4×4 real matrix. Specialization of @link(TRMatrix) for @link(T4DSpace). }
  TR4Matrix = specialize TRMatrix<T4DSpace>;

  { Generic square matrix of complex values (@link(TComplex)) with dimension
    @code(N × N), where N is determined at runtime.

    Extends the functionality of @link(TRMatrix) to the complex domain.
    Supports implicit conversion from a real matrix.
    The matrix elements are stored in a dynamic 0-based 2D array allocated
    via @link(Init). Use the default array property @code(a[row, col]) to
    read and write individual elements using 0-based indices.
    Concrete types are provided as @link(TC2Matrix), @link(TC3Matrix),
    and @link(TC4Matrix) for fixed small dimensions.
  }
  generic TCMatrix<TSpace> = record
  type
    TRMatrix = specialize TRMatrix<TSpace>;
  private
    fm: array of array of TComplex;

    { Writes the complex element at position (@code(ARow), @code(ACol)). }
    procedure Put(ARow, ACol: longint; AValue: TComplex);

    { Reads the complex element at position (@code(ARow), @code(ACol)). }
    function Get(ARow, ACol: longint): TComplex;

    { Performs forward Gaussian elimination with partial pivoting.
      Used internally by @link(Determinant) and @link(RowReduction).
      @param(SwapCount Number of row swaps performed, used to determine
      the sign of the determinant.)
      @return(Upper triangular matrix after elimination.)
    }
    function ForwardElimination(out SwapCount: integer): TCMatrix; inline;

    { Computes the Householder reflection vector for column @code(k).
      Used internally by @link(HessenbergReduction).
      @param(k Column index, 0-based.)
      @return(Normalized Householder vector stored in column 0.)
    }
    function HouseholderVector(k: longint): TCMatrix;

    { Reduces the matrix to upper Hessenberg form using Householder reflections.
      Used internally by @link(Eigenvalues).
      @return(Upper Hessenberg matrix similar to Self, with same eigenvalues.)
    }
    function HessenbergReduction: TCMatrix;

    { Decomposes the Hessenberg matrix into Q·R using Givens rotations.
      Optimized for Hessenberg matrices: @code(O(N²)) instead of @code(O(N³)).
      Used internally by @link(Eigenvalues).
      @param(Q Unitary matrix.)
      @param(R Upper triangular matrix.)
    }
    procedure QRDecompose(out Q, R: TCMatrix);

  public
    { Allocates the @code(N × N) dynamic array and sets all elements to zero.
      Must be called before using any other method on a local variable.
    }
    procedure Init;

    { Returns a deep copy of the matrix.
      Required because dynamic array assignment copies only the reference.
    }
    function Clone: TCMatrix;

    { Returns @true if all elements of the matrix are zero. }
    function IsNull: boolean;

    { Returns @true if at least one element of the matrix is non-zero. }
    function IsNotNull: boolean;

    { Returns @true if the matrix is equal to its conjugate transpose:
      @code(A = Aᴴ).
    }
    function IsHermitian: boolean;

    { Returns @true if the matrix satisfies @code(A·Aᴴ = I). }
    function IsUnitary: boolean;

    { Returns the number of linearly independent rows or columns. }
    function Rank: longint;

    { Returns @true if two matrices are equal within the default floating
      point tolerance @link(DefaultEpsilon).
    }
    function SameValue(const AMatrix: TCMatrix): boolean;

    { Swaps rows @code(ARow1) and @code(ARow2) in place. 0-based indices. }
    procedure Swap(ARow1, ARow2: longint);

    { Returns the trace of the matrix, i.e. the sum of diagonal elements:
      @code(tr(A) = Σ A[i,i]).
    }
    function Trace: TComplex;

    { Returns the Frobenius norm of the matrix:
      @code(‖A‖_F = √(Σ|a[i,j]|²)).
    }
    function Norm: double;

    { Returns the element-wise complex conjugate of the matrix. }
    function Conjugate: TCMatrix;

    { Returns the transpose of the matrix.
      Element @code([i,j]) of the result equals element @code([j,i]) of the original.
    }
    function Transpose: TCMatrix;

    { Returns the conjugate transpose (Hermitian adjoint) of the matrix:
      @code(Aᴴ[i,j] = conj(A[j,i])).
    }
    function TransposeConjugate: TCMatrix;

    { Returns the row-reduced echelon form of the matrix using Gaussian
      elimination with partial pivoting. The original matrix is not modified.
    }
    function RowReduction: TCMatrix;

    { Returns the determinant of the matrix using Gaussian elimination
      with partial pivoting (LU decomposition).
      Precision is equivalent to closed-form formulas for well-conditioned
      matrices. Both methods are subject to standard IEEE 754 rounding.
    }
    function Determinant: TComplex;

    { Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    }
    function Reciprocal(const ADeterminant: TComplex): TCMatrix;

    { Returns the eigenvalues of the matrix as a dynamic array of @link(TComplex).
      Uses the QR algorithm with Hessenberg reduction and Wilkinson shift.
      Convergence is typically cubic with Wilkinson shift.
      @return(Dynamic array of @code(TSpace.N) complex eigenvalues, not guaranteed to be sorted.)
    }
    function Eigenvalues: TArrayOfComplex;

    { Returns the diagonal matrix built from the given eigenvalues.
      Element @code(D[i,i] = AEigenValues[i]) and all off-diagonal elements are zero.
      @param(AEigenValues Array of @code(TSpace.N) complex eigenvalues,
      typically computed via @link(Eigenvalues).)
    }
    function Diagonalize(const AEigenValues: TArrayOfComplex): TCMatrix;

    { Returns the @code(N × N) identity matrix with ones on the diagonal
      and zeros elsewhere.
    }
    class function Identity: TCMatrix; static;

    { Returns the @code(N × N) null matrix with all elements equal to zero. }
    class function Null: TCMatrix; static;

    { Converts the matrix to its default string representation. }
    function ToString: string;

    { Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Implicit conversion from a real matrix to a complex matrix.
      Each element @code(a[i,j]) is converted to @code(TComplex(Re=a[i,j], Im=0)).
    }
    class operator := (const AMatrix: TRMatrix): TCMatrix;

    { Returns @true if the two matrices differ in at least one element. }
    class operator <>(const ALeft, ARight: TCMatrix): boolean;

    { Returns @true if all corresponding elements of the two matrices are equal. }
    class operator =(const ALeft, ARight: TCMatrix): boolean;

    { Returns the element-wise sum of two complex matrices. }
    class operator +(const ALeft, ARight: TCMatrix): TCMatrix;

    { Returns the element-wise difference of two complex matrices. }
    class operator -(const ALeft, ARight: TCMatrix): TCMatrix;

    { Returns the matrix product of two complex matrices.
      @code((A·B)[i,j] = Σ_k A[i,k] · B[k,j])
    }
    class operator *(const ALeft, ARight: TCMatrix): TCMatrix;

    { Returns the product of a complex scalar and a matrix. }
    class operator *(const ALeft: TComplex; const ARight: TCMatrix): TCMatrix;

    { Returns the product of a complex matrix and a complex scalar. }
    class operator *(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;

    { Returns the complex matrix divided by a complex scalar. }
    class operator /(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;

  public
    { Provides access to individual complex matrix elements using 0-based
      row and column indices. @code(a[0,0]) is the top-left element.
    }
    property a[ARow, ACol: longint]: TComplex read Get write Put; default;
  end;

  { 2×2 complex matrix. Specialization of @link(TCMatrix) for @link(T2DSpace). }
  TC2Matrix = specialize TCMatrix<T2DSpace>;

  { 3×3 complex matrix. Specialization of @link(TCMatrix) for @link(T3DSpace). }
  TC3Matrix = specialize TCMatrix<T3DSpace>;

  { 4×4 complex matrix. Specialization of @link(TCMatrix) for @link(T4DSpace). }
  TC4Matrix = specialize TCMatrix<T4DSpace>;

  { Generic column vector of real values (@code(double)) with @code(TSpace.N) components.

    Components are stored in a dynamic 0-based array allocated via @link(Init).
    Use the default array property @code(a[row]) to read and write individual components.
    Concrete types are provided as @link(TR2Vector), @link(TR3Vector), and @link(TR4Vector).
  }
  generic TRVector<TSpace> = record
  type
    TRMatrix = specialize TRMatrix<TSpace>;
  private
    fm: array of double;

    { Reads the component at position @code(ARow). }
    function Get(ARow: longint): double;

    { Writes the component at position @code(ARow). }
    procedure Put(ARow: longint; AValue: double);
  public
    { Allocates the dynamic array and sets all components to zero. }
    procedure Init;

    { Returns @true if all components are zero. }
    function IsNull: boolean;

    { Returns @true if at least one component is non-zero. }
    function IsNotNull: boolean;

    { Returns the Euclidean norm (magnitude) of the vector.
      @code(|v| = √(Σ vᵢ²))
    }
    function Norm: double;

    { Returns the unit vector in the same direction.
      Each component is divided by @link(Norm).
    }
    function Normalize: TRVector;

    { Returns the element-wise reciprocal of the vector.
      Each component @code(vᵢ) is replaced by @code(1/vᵢ).
    }
    function Reciprocal: TRVector;

    { Returns the squared Euclidean norm of the vector.
      @code(|v|² = Σ vᵢ²). Avoids the square root of @link(Norm).
    }
    function SquaredNorm: double;

    { Returns @true if the two vectors differ in at least one component. }
    class operator <>(const ALeft, ARight: TRVector): boolean;

    { Returns @true if all corresponding components of the two vectors are equal. }
    class operator =(const ALeft, ARight: TRVector): boolean;

    { Unary plus. Returns the vector unchanged. }
    class operator +(const ASelf: TRVector): TRVector;

    { Returns the component-wise sum of two vectors. }
    class operator +(const ALeft, ARight: TRVector): TRVector;

    { Unary minus. Returns the negation of the vector. }
    class operator -(const ASelf: TRVector): TRVector;

    { Returns the component-wise difference of two vectors. }
    class operator -(const ALeft, ARight: TRVector): TRVector;

    { Returns the dot product (inner product) of two vectors.
      @code(u·v = Σ uᵢ·vᵢ)
    }
    class operator *(const ALeft, ARight: TRVector): double;

    { Returns the product of a real scalar and a vector. }
    class operator *(const ALeft: double; const ARight: TRVector): TRVector;

    { Returns the product of a vector and a real scalar. }
    class operator *(const ALeft: TRVector; const ARight: double): TRVector;

    { Returns the product of a row vector and a square matrix: @code(v' = v·A). }
    class operator *(const ALeft: TRVector; const ARight: TRMatrix): TRVector;

    { Returns the product of a square matrix and a column vector: @code(v' = A·v). }
    class operator *(const ALeft: TRMatrix; const ARight: TRVector): TRVector;

    { Returns the vector divided by a real scalar. }
    class operator /(const ALeft: TRVector; const ARight: double): TRVector;

    { Returns the element-wise quotient of a scalar divided by a vector. }
    class operator /(const ALeft: double; const ARight: TRVector): TRVector;

  public
    { Provides access to individual vector components using a 0-based index. }
    property a[ARow: longint]: double read Get write Put; default;
  end;

  { 2-component real vector. Specialization of @link(TRVector) for @link(T2DSpace). }
  TR2Vector = specialize TRVector<T2DSpace>;

  { 3-component real vector. Specialization of @link(TRVector) for @link(T3DSpace). }
  TR3Vector = specialize TRVector<T3DSpace>;

  { 4-component real vector. Specialization of @link(TRVector) for @link(T4DSpace). }
  TR4Vector = specialize TRVector<T4DSpace>;

  { Record helper for @link(TR3Vector) providing the cross product. }
  TR3VectorHelper = record helper for TR3Vector
    { Returns the cross product of two 3-component real vectors.
      @code(u×v = (u₁v₂ - u₂v₁, u₂v₀ - u₀v₂, u₀v₁ - u₁v₀)) (0-based)
    }
    function Cross(const AVector: TR3Vector): TR3Vector;
  end;

  { Generic column vector of complex values (@link(TComplex)) with @code(TSpace.N) components.

    Extends @link(TRVector) to the complex domain. Supports implicit conversion
    from a real vector. Components stored in a 0-based static array.
    Concrete types are provided as @link(TC2Vector), @link(TC3Vector), and @link(TC4Vector).
  }
  generic TCVector<TSpace> = record
  type
    TRVector = specialize TRVector<TSpace>;
    TCMatrix = specialize TCMatrix<TSpace>;
  private
    fm: array[0..TSpace.N-1] of TComplex;

    { Reads the complex component at position @code(ARow). }
    function Get(ARow: longint): TComplex;

    { Writes the complex component at position @code(ARow). }
    procedure Put(ARow: longint; AValue: TComplex);
  public
    { Returns @true if all components are zero. }
    function IsNull: boolean;

    { Returns @true if at least one component is non-zero. }
    function IsNotNull: boolean;

    { Returns the Euclidean norm: @code(|v| = √(Σ |vᵢ|²)) }
    function Norm: double;

    { Returns the unit vector in the same direction. }
    function Normalize: TCVector;

    { Returns the element-wise reciprocal of the vector. }
    function Reciprocal: TCVector;

    { Returns the squared Euclidean norm: @code(|v|² = Σ |vᵢ|²) }
    function SquaredNorm: double;

    { Implicit conversion from a real vector to a complex vector. }
    class operator :=(const ASelf: TRVector): TCVector;

    class operator <>(const ALeft, ARight: TCVector): boolean;
    class operator =(const ALeft, ARight: TCVector): boolean;
    class operator +(const ASelf: TCVector): TCVector;
    class operator +(const ALeft, ARight: TCVector): TCVector;
    class operator -(const ASelf: TCVector): TCVector;
    class operator -(const ALeft, ARight: TCVector): TCVector;

    { Returns the dot product: @code(u·v = Σ uᵢ·vᵢ) (bilinear, not Hermitian) }
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
    { Provides access to individual complex vector components using a 0-based index. }
    property a[ARow: longint]: TComplex read Get write Put; default;
  end;

  { 2-component complex vector. Specialization of @link(TCVector) for @link(T2DSpace). }
  TC2Vector = specialize TCVector<T2DSpace>;

  { 3-component complex vector. Specialization of @link(TCVector) for @link(T3DSpace). }
  TC3Vector = specialize TCVector<T3DSpace>;

  { 4-component complex vector. Specialization of @link(TCVector) for @link(T4DSpace). }
  TC4Vector = specialize TCVector<T4DSpace>;

  { Fixed-size array of 2 complex vectors. Used to store eigenvectors of @link(TC2Matrix). }
  TC2ArrayOfVector = array[1..T2DSpace.N] of TC2Vector;

  { Fixed-size array of 3 complex vectors. Used to store eigenvectors of @link(TC3Matrix). }
  TC3ArrayOfVector = array[1..T3DSpace.N] of TC3Vector;

  { Fixed-size array of 4 complex vectors. Used to store eigenvectors of @link(TC4Matrix). }
  TC4ArrayOfVector = array[1..T4DSpace.N] of TC4Vector;

  { Returns the absolute value of a real number. }
  function Abs(const AValue: double): double;

  { Returns the modulus (magnitude) of a complex number: @code(|z| = √(Re² + Im²)). }
  function Abs(const AValue: TComplex): double;

  { Returns the square of the complex number: @code(z² = (Re²-Im²) + 2·Re·Im·i). }
  function SquarePower(const AValue: TComplex): TComplex;

  { Returns the cube of the complex number: @code(z³ = z²·z). }
  function CubicPower(const AValue: TComplex): TComplex;

  { Returns the fourth power of the complex number: @code(z⁴ = (z²)²). }
  function QuarticPower(const AValue: TComplex): TComplex;

  { Returns all square roots of the complex number as a fixed-size array. }
  function SquareRoot(const AValue: TComplex): TArrayOfComplex;

  { Returns all cube roots of the complex number as a fixed-size array. }
  function CubicRoot(const AValue: TComplex): TArrayOfComplex;

  { Returns all fourth roots of the complex number as a fixed-size array. }
  function QuarticRoot(const AValue: TComplex): TArrayOfComplex;

  { Returns the commutator of two 2×2 complex matrices: @code([A,B] = A·B - B·A). }
  function Commutator(const ALeft, ARight: TC2Matrix): TC2Matrix;

  { Returns the commutator of two 3×3 complex matrices: @code([A,B] = A·B - B·A). }
  function Commutator(const ALeft, ARight: TC3Matrix): TC3Matrix;

  { Returns the commutator of two 4×4 complex matrices: @code([A,B] = A·B - B·A). }
  function Commutator(const ALeft, ARight: TC4Matrix): TC4Matrix;

  { Returns @true if two real numbers are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: double): boolean;

  { Returns @true if two complex numbers are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: TComplex): boolean;

  { Returns @true if two 2-component complex vectors are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: TC2Vector): boolean;

  { Returns @true if two 3-component complex vectors are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: TC3Vector): boolean;

  { Returns @true if two 4-component complex vectors are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: TC4Vector): boolean;

  { Returns @true if two 2×2 complex matrices are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: TC2Matrix): boolean;

  { Returns @true if two 3×3 complex matrices are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: TC3Matrix): boolean;

  { Returns @true if two 4×4 complex matrices are equal within @link(DefaultEpsilon). }
  function SameValueEx(const AValue1, AValue2: TC4Matrix): boolean;

  { Solves @code(a·x = 0) over the reals. }
  function SolveEquation(const a: double): double;

  { Solves @code(a·z = 0) over the complex numbers. }
  function SolveEquation(const a: TComplex): TComplex;

  { Solves @code(a·z + b = 0) over the complex numbers. }
  function SolveEquation(const a, b: TComplex): TArrayOfComplex;

  { Solves @code(a·z² + b·z + c = 0) over the complex numbers. }
  function SolveEquation(const a, b, c: TComplex): TArrayOfComplex;

  { Solves @code(a·z³ + b·z² + c·z + d = 0) using Cardano's method. }
  function SolveEquation(const a, b, c, d: TComplex): TArrayOfComplex;

var
  { Default epsilon for floating point comparisons. }
  DefaultEpsilon: double = 1E-12;

  { Internal format routines. @exclude }
  function Fmt(const AValue: double): string;
  function Fmt(const AValue: double; APrecision, ADigits: longint): string;

implementation

uses Math, SysUtils;

// --- Format routines ---

function Fmt(const AValue: double): string;
begin
  if AValue < 0.0 then
    result := FloatToStr(AValue)
  else
    result := '+' + FloatToStr(AValue);
end;

function Fmt(const AValue: double; APrecision, ADigits: longint): string;
begin
  if AValue < 0.0 then
    result := FloatToStrF(AValue, ffGeneral, APrecision, ADigits)
  else
    result := '+' + FloatToStrF(AValue, ffGeneral, APrecision, ADigits);
end;

// --- TComplex ---

function TComplex.Arg: double;
begin
  result := Math.ArcTan2(fIm, fRe);
end;

function TComplex.Conjugate: TComplex;
begin
  result.fRe :=  fRe;
  result.fIm := -fIm;
end;

function TComplex.IsNull: boolean;
begin
  result := SameValueEx(fRe, 0) and SameValueEx(fIm, 0);
end;

function TComplex.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TComplex.Norm: double;
begin
  result := hypot(fRe, fIm);
end;

function TComplex.SquaredNorm: double;
begin
  result := sqr(fRe) + sqr(fIm);
end;

function TComplex.Reciprocal: TComplex;
begin
  result := Conjugate / SquaredNorm;
end;

function TComplex.ToString: string;
var
  sign: array[boolean] of string = ('+', '-');
begin
  if (not SameValueEx(fRe, 0)) and (not SameValueEx(fIm, 0)) then
  begin
    if SameValueEx(System.Abs(fIm), 1) then
      result := Format('%s %si', [FloatToStr(fRe), sign[fIm < 0]])
    else
      result := Format('%s %s%s∙i', [FloatToStr(fRe), sign[fIm < 0], FloatToStr(System.Abs(fIm))]);
  end else
    if not SameValueEx(fRe, 0) then
      result := FloatToStr(fRe)
    else
      if not SameValueEx(fIm, 0) then
      begin
        if SameValueEx(fIm, 1) then result := 'i'
        else if SameValueEx(fIm, -1) then result := '-i'
        else result := Format('%s∙i', [FloatToStr(fIm)])
      end else
        result := '0';
end;

function TComplex.ToString(APrecision, ADigits: integer): string;
var
  sign: array[boolean] of string = ('+', '-');
begin
  if (not SameValueEx(fRe, 0)) and (not SameValueEx(fIm, 0)) then
  begin
    if SameValueEx(System.Abs(fIm), 1) then
      result := Format('%s %si', [FloatToStrF(fRe, ffGeneral, APrecision, ADigits), sign[fIm < 0]])
    else
      result := Format('%s %s%s∙i', [
        FloatToStrF(fRe,              ffGeneral, APrecision, ADigits), sign[fIm < 0],
        FloatToStrF(System.Abs(fIm),  ffGeneral, APrecision, ADigits)]);
  end else
    if not SameValueEx(fRe, 0) then
      result := FloatToStrF(fRe, ffGeneral, APrecision, ADigits)
    else
      if not SameValueEx(fIm, 0) then
      begin
        if SameValueEx(fIm, 1) then result := 'i'
        else if SameValueEx(fIm, -1) then result := '-i'
        else result := Format('%s∙i', [FloatToStrF(fIm, ffGeneral, APrecision, ADigits)])
      end else
        result := '0';
end;

procedure TComplex.Zero;
begin
  fRe := 0;
  fIm := 0;
end;

class operator TComplex.:=(const AValue: double): TComplex;
begin
  result.fRe := AValue;
  result.fIm := 0;
end;

class operator TComplex.=(const ALeft, ARight: TComplex): boolean;
begin
  result := (ALeft.fRe = ARight.fRe) and (ALeft.fIm = ARight.fIm);
end;

class operator TComplex.<>(const ALeft, ARight: TComplex): boolean;
begin
  result := (ALeft.fRe <> ARight.fRe) or (ALeft.fIm <> ARight.fIm);
end;

class operator TComplex.+(const AValue: TComplex): TComplex;
begin
  result.fRe := AValue.fRe;
  result.fIm := AValue.fIm;
end;

class operator TComplex.+(const ALeft, ARight: TComplex): TComplex;
begin
  result.fRe := ALeft.fRe + ARight.fRe;
  result.fIm := ALeft.fIm + ARight.fIm;
end;

class operator TComplex.+(const ALeft: double; const ARight: TComplex): TComplex;
begin
  result.fRe := ALeft + ARight.fRe;
  result.fIm :=         ARight.fIm;
end;

class operator TComplex.+(const ALeft: TComplex; const ARight: double): TComplex;
begin
  result.fRe := ALeft.fRe + ARight;
  result.fIm := ALeft.fIm;
end;

class operator TComplex.-(const AValue: TComplex): TComplex;
begin
  result.fRe := -AValue.fRe;
  result.fIm := -AValue.fIm;
end;

class operator TComplex.-(const ALeft, ARight: TComplex): TComplex;
begin
  result.fRe := ALeft.fRe - ARight.fRe;
  result.fIm := ALeft.fIm - ARight.fIm;
end;

class operator TComplex.-(const ALeft: double; const ARight: TComplex): TComplex;
begin
  result.fRe := ALeft - ARight.fRe;
  result.fIm :=       - ARight.fIm;
end;

class operator TComplex.-(const ALeft: TComplex; const ARight: double): TComplex;
begin
  result.fRe := ALeft.fRe - ARight;
  result.fIm := ALeft.fIm;
end;

class operator TComplex.*(const ALeft, ARight: TComplex): TComplex;
begin
  result.fRe := ALeft.fRe * ARight.fRe - ALeft.fIm * ARight.fIm;
  result.fIm := ALeft.fRe * ARight.fIm + ALeft.fIm * ARight.fRe;
end;

class operator TComplex.*(const ALeft: double; const ARight: TComplex): TComplex;
begin
  result.fRe := ALeft * ARight.fRe;
  result.fIm := ALeft * ARight.fIm;
end;

class operator TComplex.*(const ALeft: TComplex; const ARight: double): TComplex;
begin
  result.fRe := ALeft.fRe * ARight;
  result.fIm := ALeft.fIm * ARight;
end;

class operator TComplex./(const ALeft, ARight: TComplex): TComplex;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TComplex./(const ALeft: double; const ARight: TComplex): TComplex;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TComplex./(const ALeft: TComplex; const ARight: double): TComplex;
begin
  result.fRe := ALeft.fRe / ARight;
  result.fIm := ALeft.fIm / ARight;
end;

// --- TImaginaryUnit ---

class operator TImaginaryUnit.:=(const ASelf: TImaginaryUnit): TComplex;
begin
  result.fRe := 0;
  result.fIm := 1;
end;

class operator TImaginaryUnit.*(const ALeft, ARight: TImaginaryUnit): double;
begin
  result := -1;
end;

class operator TImaginaryUnit./(const ALeft, ARight: TImaginaryUnit): double;
begin
  result := 1;
end;

class operator TImaginaryUnit.-(const AValue: TImaginaryUnit): TComplex;
begin
  result.fRe :=  0;
  result.fIm := -1;
end;

class operator TImaginaryUnit.+(const AValue: TImaginaryUnit): TComplex;
begin
  result.fRe := 0;
  result.fIm := 1;
end;

class operator TImaginaryUnit.+(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe := ALeft;
  result.fIm := 1;
end;

class operator TImaginaryUnit.+(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
begin
  result.fRe := ARight;
  result.fIm := 1;
end;

class operator TImaginaryUnit.-(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe :=  ALeft;
  result.fIm := -1;
end;

class operator TImaginaryUnit.-(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
begin
  result.fRe := -ARight;
  result.fIm :=  1;
end;

class operator TImaginaryUnit.+(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe := ALeft.fRe;
  result.fIm := ALeft.fIm + 1;
end;

class operator TImaginaryUnit.+(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
begin
  result.fRe := ARight.fRe;
  result.fIm := ARight.fIm + 1;
end;

class operator TImaginaryUnit.-(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe := ALeft.fRe;
  result.fIm := ALeft.fIm - 1;
end;

class operator TImaginaryUnit.-(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
begin
  result.fRe :=  -ARight.fRe;
  result.fIm := 1 - ARight.fIm;
end;

class operator TImaginaryUnit.*(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe := 0;
  result.fIm := ALeft;
end;

class operator TImaginaryUnit.*(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
begin
  result.fRe := 0;
  result.fIm := ARight;
end;

class operator TImaginaryUnit.*(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe := -ALeft.fIm;
  result.fIm :=  ALeft.fRe;
end;

class operator TImaginaryUnit.*(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
begin
  result.fRe := -ARight.fIm;
  result.fIm :=  ARight.fRe;
end;

class operator TImaginaryUnit./(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe :=  0;
  result.fIm := -ALeft;
end;

class operator TImaginaryUnit./(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
begin
  result.fRe := 0;
  result.fIm := 1 / ARight;
end;

class operator TImaginaryUnit./(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
begin
  result.fRe :=  ALeft.fIm;
  result.fIm := -ALeft.fRe;
end;

class operator TImaginaryUnit./(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
var
  denom: double;
begin
  denom      :=  ARight.SquaredNorm;
  result.fRe :=  ARight.fIm / denom;
  result.fIm :=  ARight.fRe / denom;
end;

// --- TRMatrix ---

procedure TRMatrix.Put(ARow, ACol: longint; AValue: double);
begin
  fm[ARow, ACol] := AValue;
end;

function TRMatrix.Get(ARow, ACol: longint): double;
begin
  result := fm[ARow, ACol];
end;

procedure TRMatrix.Init;
var
  i: longint;
begin
  SetLength(fm, TSpace.N, TSpace.N);
  for i := 0 to TSpace.N - 1 do
    FillDWord(fm[i][0], TSpace.N, 0);
end;

function TRMatrix.Clone: TRMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := fm[i, j];
end;

function TRMatrix.ForwardElimination(out SwapCount: integer): TRMatrix;
var
  pivot, ratio,
  maxVal:  double;
  i, j, k,
  maxRow:  longint;
  rowI,
  rowJ:    array of double;
begin
  result    := Self.Clone;
  SwapCount := 0;

  for i := 0 to TSpace.N - 1 do
  begin
    // 1. Ricerca pivot parziale
    maxRow := i;
    maxVal := System.Abs(result.fm[i, i]);
    for j := i + 1 to TSpace.N - 1 do
      if System.Abs(result.fm[j, i]) > maxVal then
      begin
        maxVal := System.Abs(result.fm[j, i]);
        maxRow := j;
      end;

    // 2. Matrice singolare
    if maxVal < DefaultEpsilon then Continue;

    // 3. Scambio righe
    if maxRow <> i then
    begin
      result.Swap(i, maxRow);
      Inc(SwapCount);
    end;

    // 4. Riferimento alla riga pivot — evita doppio accesso nel loop interno
    rowI  := result.fm[i];
    pivot := rowI[i];

    // 5. Eliminazione sotto la diagonale
    for j := i + 1 to TSpace.N - 1 do
    begin
      if System.Abs(result.fm[j, i]) < DefaultEpsilon then Continue;
      rowJ       := result.fm[j];
      ratio      := rowJ[i] / pivot;
      rowJ[i]    := 0;
      for k := i + 1 to TSpace.N - 1 do
        rowJ[k] := rowJ[k] - ratio * rowI[k];
      result.fm[j] := rowJ;
    end;
  end;
end;

function TRMatrix.HouseholderVector(k: longint): TRMatrix;
var
  i:    longint;
  sum: double;
begin
  result.Init;

  // Copia la sottocolonna k+1..N-1
  for i := k + 1 to TSpace.N - 1 do
    result.fm[i, 0] := fm[i, k];

  // Calcola la norma della sottocolonna
  sum := 0;
  for i := k + 1 to TSpace.N - 1 do
    sum := sum + sqr(result.fm[i, 0]);
  sum := sqrt(sum);

  if sum < DefaultEpsilon then Exit;

  // Aggiunge sum al primo elemento per stabilità numerica
  result.fm[k + 1, 0] := result.fm[k + 1, 0] + sum;

  // Ricalcola la norma dopo la modifica
  sum := 0;
  for i := k + 1 to TSpace.N - 1 do
    sum := sum + sqr(result.fm[i, 0]);
  sum := sqrt(sum);

  // Normalizza
  if sum < DefaultEpsilon then Exit;
  for i := k + 1 to TSpace.N - 1 do
    result.fm[i, 0] := result.fm[i, 0] / sum;
end;

function TRMatrix.HessenbergReduction: TRMatrix;
var
  V:       TRMatrix;
  k, i, j: longint;
  dot:     double;
  rowI:    array of double;
begin
  result := Self.Clone;

  for k := 0 to TSpace.N - 3 do
  begin
    V := result.HouseholderVector(k);
    if V.IsNull then Continue;

    // Applica da sinistra: result := (I - 2·V·Vᵀ) · result
    for j := 0 to TSpace.N - 1 do
    begin
      dot := 0;
      for i := k + 1 to TSpace.N - 1 do
        dot := dot + V.fm[i, 0] * result.fm[i, j];
      for i := k + 1 to TSpace.N - 1 do
        result.fm[i, j] := result.fm[i, j] - 2 * V.fm[i, 0] * dot;
    end;

    // Applica da destra: result := result · (I - 2·V·Vᵀ)
    for i := 0 to TSpace.N - 1 do
    begin
      rowI := result.fm[i];
      dot  := 0;
      for j := k + 1 to TSpace.N - 1 do
        dot := dot + rowI[j] * V.fm[j, 0];
      for j := k + 1 to TSpace.N - 1 do
        rowI[j] := rowI[j] - 2 * dot * V.fm[j, 0];
      result.fm[i] := rowI;
    end;

    // Azzera esplicitamente sotto la prima sottodiagonale
    for i := k + 2 to TSpace.N - 1 do
      result.fm[i, k] := 0;
  end;
end;

procedure TRMatrix.QRDecompose(out Q, R: TRMatrix);
var
  i, j:        longint;
  c, s,
  temp1, temp2,
  denom:       double;
  rowI, rowJ:  array of double;
begin
  Q := TRMatrix.Identity;
  R := Self.Clone;

  for j := 0 to TSpace.N - 2 do
    if System.Abs(R.fm[j + 1, j]) > DefaultEpsilon then
    begin
      // Calcola rotazione di Givens — denom è reale positivo
      denom := sqrt(sqr(R.fm[j, j]) + sqr(R.fm[j + 1, j]));
      c := R.fm[j,     j] / denom;
      s := R.fm[j + 1, j] / denom;

      // Applica a R da sinistra
      rowI := R.fm[j];
      rowJ := R.fm[j + 1];
      for i := j to TSpace.N - 1 do
      begin
        temp1   :=  c * rowI[i] + s * rowJ[i];
        temp2   := -s * rowI[i] + c * rowJ[i];
        rowI[i] := temp1;
        rowJ[i] := temp2;
      end;
      R.fm[j]     := rowI;
      R.fm[j + 1] := rowJ;

      // Applica a Q da destra
      for i := 0 to TSpace.N - 1 do
      begin
        rowI        := Q.fm[i];
        temp1       :=  c * rowI[j] + s * rowI[j + 1];
        temp2       := -s * rowI[j] + c * rowI[j + 1];
        rowI[j]     := temp1;
        rowI[j + 1] := temp2;
        Q.fm[i]     := rowI;
      end;
    end;
end;

function TRMatrix.IsNull: boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if not SameValueEx(fm[i, j], 0) then Exit(False);
  result := True;
end;

function TRMatrix.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TRMatrix.IsOrthogonal: boolean;
begin
  result := TRMatrix.Identity.SameValue(Self.Transpose * Self);
end;

function TRMatrix.SameValue(const AMatrix: TRMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if not SameValueEx(fm[i, j], AMatrix.fm[i, j]) then Exit(False);
  result := True;
end;

function TRMatrix.Rank: longint;
var
  U:     TRMatrix;
  swaps: integer;
  i:     longint;
begin
  U      := ForwardElimination(swaps);
  result := 0;
  for i  := 0 to TSpace.N - 1 do
    if System.Abs(U.fm[i, i]) > DefaultEpsilon then
      Inc(result);
end;

procedure TRMatrix.Swap(ARow1, ARow2: longint);
var
  tmp: array of double;
begin
  tmp          := fm[ARow1];
  fm[ARow1]    := fm[ARow2];
  fm[ARow2]    := tmp;
end;

function TRMatrix.Trace: double;
var
  i: longint;
begin
  result := 0;
  for i := 0 to TSpace.N - 1 do
    result := result + fm[i, i];
end;

function TRMatrix.Norm: double;
var
  i, j: longint;
  sum:  double;
  rowI: array of double;
begin
  sum := 0;
  for i := 0 to TSpace.N - 1 do
  begin
    rowI := fm[i];
    for j := 0 to TSpace.N - 1 do
      sum := sum + sqr(rowI[j]);
  end;
  result := sqrt(sum);
end;

function TRMatrix.Transpose: TRMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := fm[j, i];
end;

function TRMatrix.RowReduction: TRMatrix;
var
  ratio:         double;
  i, j, k,
  maxRow:        longint;
  rowI, rowJ:    array of double;
begin
  result := Self.Clone;

  // Step 1: Forward elimination with partial pivoting
  for i := 0 to TSpace.N - 1 do
  begin
    maxRow := i;
    for j := i + 1 to TSpace.N - 1 do
      if System.Abs(result.fm[j, i]) > System.Abs(result.fm[maxRow, i]) then
        maxRow := j;

    if maxRow <> i then
      result.Swap(i, maxRow);

    if not SameValueEx(result.fm[i, i], 0) then
    begin
      rowI := result.fm[i];
      // Normalizza la riga pivot
      for j := i + 1 to TSpace.N - 1 do
        rowI[j] := rowI[j] / rowI[i];
      rowI[i] := 1;
      result.fm[i] := rowI;

      // Elimina sotto il pivot
      for j := i + 1 to TSpace.N - 1 do
      begin
        if SameValueEx(result.fm[j, i], 0) then Continue;
        rowJ    := result.fm[j];
        ratio   := rowJ[i];
        rowJ[i] := 0;
        for k := i + 1 to TSpace.N - 1 do
          rowJ[k] := rowJ[k] - ratio * rowI[k];
        result.fm[j] := rowJ;
      end;
    end;
  end;

  // Step 2: Back-substitution
  for i := TSpace.N - 1 downto 0 do
    if not SameValueEx(result.fm[i, i], 0) then
    begin
      rowI := result.fm[i];
      for j := i - 1 downto 0 do
      begin
        rowJ    := result.fm[j];
        ratio   := rowJ[i];
        rowJ[i] := 0;
        for k := i to TSpace.N - 1 do
          rowJ[k] := rowJ[k] - ratio * rowI[k];
        result.fm[j] := rowJ;
      end;
    end;
end;

function TRMatrix.Determinant: double;
var
  U:     TRMatrix;
  swaps: integer;
  i:     longint;
begin
  U      := ForwardElimination(swaps);
  result := 1.0;
  for i  := 0 to TSpace.N - 1 do
    result := result * U.fm[i, i];
  if Odd(swaps) then
    result := -result;
end;

function TRMatrix.Reciprocal(const ADeterminant: double): TRMatrix;
var
  Adj:     TRMatrix;
  sub:     TRMatrix;
  i, j,
  ri, ci,
  si, sj:  longint;
  sign:    double;
begin
  Adj.Init;
  result.Init;

  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
    begin
      // Costruisce la sottomatrice (N-1)×(N-1) eliminando riga i e colonna j
      sub.Init;
      si := 0;
      for ri := 0 to TSpace.N - 1 do
      begin
        if ri = i then Continue;
        sj := 0;
        for ci := 0 to TSpace.N - 1 do
        begin
          if ci = j then Continue;
          sub.fm[si, sj] := fm[ri, ci];
          Inc(sj);
        end;
        Inc(si);
      end;

      // Cofattore C[i,j] = (-1)^(i+j) * det(sub)
      if Odd(i + j) then sign := -1.0 else sign := 1.0;

      // Aggiunta è la trasposta dei cofattori: Adj[j,i] = C[i,j]
      Adj.fm[j, i] := sign * sub.Determinant;
    end;

  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := Adj.fm[i, j] / ADeterminant;
end;

function TRMatrix.Eigenvalues: TArrayOfDouble;
var
  H:         TRMatrix;
  Q, R:      TRMatrix;
  i, iter,
  n:         longint;
  shift:     double;
  converged: boolean;
const
  MaxIter   = 1000;
begin
  SetLength(result, TSpace.N);
  H := Self.HessenbergReduction;
  n := TSpace.N - 1;  // 0-based last index

  while n > 0 do
  begin
    converged := False;
    for iter := 1 to MaxIter do
    begin
      // Wilkinson shift
      shift := H.fm[n, n];
      for i := 0 to n do
        H.fm[i, i] := H.fm[i, i] - shift;

      H.QRDecompose(Q, R);
      H := R * Q;

      for i := 0 to n do
        H.fm[i, i] := H.fm[i, i] + shift;

      if System.Abs(H.fm[n, n - 1]) < DefaultEpsilon then
      begin
        result[n] := H.fm[n, n];
        Dec(n);
        converged := True;
        break;
      end;
    end;

    if not converged then
    begin
      result[n] := H.fm[n, n];
      Dec(n);
    end;
  end;
  result[0] := H.fm[0, 0];
end;

class function TRMatrix.Identity: TRMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := Ord(i = j);
end;

class function TRMatrix.Null: TRMatrix;
begin
  result.Init;
end;

function TRMatrix.ToString: string;
var
  i, j: longint;
  rows: array of string;
begin
  SetLength(rows, TSpace.N);
  for i := 0 to TSpace.N - 1 do
  begin
    rows[i] := '(';
    for j := 0 to TSpace.N - 1 do
    begin
      if j > 0 then rows[i] := rows[i] + ', ';
      rows[i] := rows[i] + FloatToStr(fm[i, j]);
    end;
    rows[i] := rows[i] + ')';
  end;
  result := '(' + string.Join(', ', rows) + ')';
end;

function TRMatrix.ToString(APrecision, ADigits: integer): string;
var
  i, j: longint;
  rows: array of string;
begin
  SetLength(rows, TSpace.N);
  for i := 0 to TSpace.N - 1 do
  begin
    rows[i] := '(';
    for j := 0 to TSpace.N - 1 do
    begin
      if j > 0 then rows[i] := rows[i] + ', ';
      rows[i] := rows[i] + FloatToStrF(fm[i, j], ffGeneral, APrecision, ADigits);
    end;
    rows[i] := rows[i] + ')';
  end;
  result := '(' + string.Join(', ', rows) + ')';
end;

class operator TRMatrix.<>(const ALeft, ARight: TRMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if ALeft.fm[i, j] <> ARight.fm[i, j] then Exit(True);
  result := False;
end;

class operator TRMatrix.=(const ALeft, ARight: TRMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if ALeft.fm[i, j] <> ARight.fm[i, j] then Exit(False);
  result := True;
end;

class operator TRMatrix.+(const ALeft, ARight: TRMatrix): TRMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] + ARight.fm[i, j];
end;

class operator TRMatrix.-(const ALeft, ARight: TRMatrix): TRMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] - ARight.fm[i, j];
end;

class operator TRMatrix.*(const ALeft, ARight: TRMatrix): TRMatrix;
var
  i, j, k: longint;
  rowI:    array of double;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
  begin
    rowI := ALeft.fm[i];
    for j := 0 to TSpace.N - 1 do
    begin
      result.fm[i, j] := 0;
      for k := 0 to TSpace.N - 1 do
        result.fm[i, j] := result.fm[i, j] + rowI[k] * ARight.fm[k, j];
    end;
  end;
end;

class operator TRMatrix.*(const ALeft: double; const ARight: TRMatrix): TRMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft * ARight.fm[i, j];
end;

class operator TRMatrix.*(const ALeft: TRMatrix; const ARight: double): TRMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] * ARight;
end;

class operator TRMatrix./(const ALeft: TRMatrix; const ARight: double): TRMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] / ARight;
end;

// --- Exact specializations for TR2Matrix, TR3Matrix, TR4Matrix ---

function Determinant(const M: TR2Matrix): double;
begin
  result := M.fm[0,0]*M.fm[1,1] - M.fm[0,1]*M.fm[1,0];
end;

function Reciprocal(const M: TR2Matrix; const ADeterminant: double): TR2Matrix;
begin
  result.Init;
  result.fm[0,0] :=  M.fm[1,1] / ADeterminant;
  result.fm[0,1] := -M.fm[0,1] / ADeterminant;
  result.fm[1,0] := -M.fm[1,0] / ADeterminant;
  result.fm[1,1] :=  M.fm[0,0] / ADeterminant;
end;

function Determinant(const M: TR3Matrix): double;
begin
  result :=  M.fm[0,0]*(M.fm[1,1]*M.fm[2,2] - M.fm[1,2]*M.fm[2,1])
            +M.fm[0,1]*(M.fm[1,2]*M.fm[2,0] - M.fm[1,0]*M.fm[2,2])
            +M.fm[0,2]*(M.fm[1,0]*M.fm[2,1] - M.fm[1,1]*M.fm[2,0]);
end;

function Reciprocal(const M: TR3Matrix; const ADeterminant: double): TR3Matrix;
begin
  result.Init;
  result.fm[0,0] :=  (M.fm[1,1]*M.fm[2,2] - M.fm[1,2]*M.fm[2,1]) / ADeterminant;
  result.fm[0,1] := -(M.fm[0,1]*M.fm[2,2] - M.fm[0,2]*M.fm[2,1]) / ADeterminant;
  result.fm[0,2] :=  (M.fm[0,1]*M.fm[1,2] - M.fm[0,2]*M.fm[1,1]) / ADeterminant;
  result.fm[1,0] := -(M.fm[1,0]*M.fm[2,2] - M.fm[1,2]*M.fm[2,0]) / ADeterminant;
  result.fm[1,1] :=  (M.fm[0,0]*M.fm[2,2] - M.fm[0,2]*M.fm[2,0]) / ADeterminant;
  result.fm[1,2] := -(M.fm[0,0]*M.fm[1,2] - M.fm[0,2]*M.fm[1,0]) / ADeterminant;
  result.fm[2,0] :=  (M.fm[1,0]*M.fm[2,1] - M.fm[1,1]*M.fm[2,0]) / ADeterminant;
  result.fm[2,1] := -(M.fm[0,0]*M.fm[2,1] - M.fm[0,1]*M.fm[2,0]) / ADeterminant;
  result.fm[2,2] :=  (M.fm[0,0]*M.fm[1,1] - M.fm[0,1]*M.fm[1,0]) / ADeterminant;
end;

function Determinant(const M: TR4Matrix): double;
begin
  result :=
    (M.fm[0,0]*M.fm[1,1]-M.fm[0,1]*M.fm[1,0])*(M.fm[2,2]*M.fm[3,3]-M.fm[2,3]*M.fm[3,2]) -
    (M.fm[0,0]*M.fm[1,2]-M.fm[0,2]*M.fm[1,0])*(M.fm[2,1]*M.fm[3,3]-M.fm[2,3]*M.fm[3,1]) +
    (M.fm[0,0]*M.fm[1,3]-M.fm[0,3]*M.fm[1,0])*(M.fm[2,1]*M.fm[3,2]-M.fm[2,2]*M.fm[3,1]) +
    (M.fm[0,1]*M.fm[1,2]-M.fm[0,2]*M.fm[1,1])*(M.fm[2,0]*M.fm[3,3]-M.fm[2,3]*M.fm[3,0]) -
    (M.fm[0,1]*M.fm[1,3]-M.fm[0,3]*M.fm[1,1])*(M.fm[2,0]*M.fm[3,2]-M.fm[2,2]*M.fm[3,0]) +
    (M.fm[0,2]*M.fm[1,3]-M.fm[0,3]*M.fm[1,2])*(M.fm[2,0]*M.fm[3,1]-M.fm[2,1]*M.fm[3,0]);
end;

function Reciprocal(const M: TR4Matrix; const ADeterminant: double): TR4Matrix;
begin
  result.Init;
  result.fm[0,0]:=(M.fm[1,1]*(M.fm[2,2]*M.fm[3,3]-M.fm[2,3]*M.fm[3,2])+
                   M.fm[1,2]*(M.fm[2,3]*M.fm[3,1]-M.fm[2,1]*M.fm[3,3])+
                   M.fm[1,3]*(M.fm[2,1]*M.fm[3,2]-M.fm[2,2]*M.fm[3,1]))/ADeterminant;
  result.fm[0,1]:=(M.fm[2,1]*(M.fm[0,2]*M.fm[3,3]-M.fm[0,3]*M.fm[3,2])+
                   M.fm[2,2]*(M.fm[0,3]*M.fm[3,1]-M.fm[0,1]*M.fm[3,3])+
                   M.fm[2,3]*(M.fm[0,1]*M.fm[3,2]-M.fm[0,2]*M.fm[3,1]))/ADeterminant;
  result.fm[0,2]:=(M.fm[3,1]*(M.fm[0,2]*M.fm[1,3]-M.fm[0,3]*M.fm[1,2])+
                   M.fm[3,2]*(M.fm[0,3]*M.fm[1,1]-M.fm[0,1]*M.fm[1,3])+
                   M.fm[3,3]*(M.fm[0,1]*M.fm[1,2]-M.fm[0,2]*M.fm[1,1]))/ADeterminant;
  result.fm[0,3]:=(M.fm[0,1]*(M.fm[1,3]*M.fm[2,2]-M.fm[1,2]*M.fm[2,3])+
                   M.fm[0,2]*(M.fm[1,1]*M.fm[2,3]-M.fm[1,3]*M.fm[2,1])+
                   M.fm[0,3]*(M.fm[1,2]*M.fm[2,1]-M.fm[1,1]*M.fm[2,2]))/ADeterminant;
  result.fm[1,0]:=(M.fm[1,2]*(M.fm[2,0]*M.fm[3,3]-M.fm[2,3]*M.fm[3,0])+
                   M.fm[1,3]*(M.fm[2,2]*M.fm[3,0]-M.fm[2,0]*M.fm[3,2])+
                   M.fm[1,0]*(M.fm[2,3]*M.fm[3,2]-M.fm[2,2]*M.fm[3,3]))/ADeterminant;
  result.fm[1,1]:=(M.fm[2,2]*(M.fm[0,0]*M.fm[3,3]-M.fm[0,3]*M.fm[3,0])+
                   M.fm[2,3]*(M.fm[0,2]*M.fm[3,0]-M.fm[0,0]*M.fm[3,2])+
                   M.fm[2,0]*(M.fm[0,3]*M.fm[3,2]-M.fm[0,2]*M.fm[3,3]))/ADeterminant;
  result.fm[1,2]:=(M.fm[3,2]*(M.fm[0,0]*M.fm[1,3]-M.fm[0,3]*M.fm[1,0])+
                   M.fm[3,3]*(M.fm[0,2]*M.fm[1,0]-M.fm[0,0]*M.fm[1,2])+
                   M.fm[3,0]*(M.fm[0,3]*M.fm[1,2]-M.fm[0,2]*M.fm[1,3]))/ADeterminant;
  result.fm[1,3]:=(M.fm[0,2]*(M.fm[1,3]*M.fm[2,0]-M.fm[1,0]*M.fm[2,3])+
                   M.fm[0,3]*(M.fm[1,0]*M.fm[2,2]-M.fm[1,2]*M.fm[2,0])+
                   M.fm[0,0]*(M.fm[1,2]*M.fm[2,3]-M.fm[1,3]*M.fm[2,2]))/ADeterminant;
  result.fm[2,0]:=(M.fm[1,3]*(M.fm[2,0]*M.fm[3,1]-M.fm[2,1]*M.fm[3,0])+
                   M.fm[1,0]*(M.fm[2,1]*M.fm[3,3]-M.fm[2,3]*M.fm[3,1])+
                   M.fm[1,1]*(M.fm[2,3]*M.fm[3,0]-M.fm[2,0]*M.fm[3,3]))/ADeterminant;
  result.fm[2,1]:=(M.fm[2,3]*(M.fm[0,0]*M.fm[3,1]-M.fm[0,1]*M.fm[3,0])+
                   M.fm[2,0]*(M.fm[0,1]*M.fm[3,3]-M.fm[0,3]*M.fm[3,1])+
                   M.fm[2,1]*(M.fm[0,3]*M.fm[3,0]-M.fm[0,0]*M.fm[3,3]))/ADeterminant;
  result.fm[2,2]:=(M.fm[3,3]*(M.fm[0,0]*M.fm[1,1]-M.fm[0,1]*M.fm[1,0])+
                   M.fm[3,0]*(M.fm[0,1]*M.fm[1,3]-M.fm[0,3]*M.fm[1,1])+
                   M.fm[3,1]*(M.fm[0,3]*M.fm[1,0]-M.fm[0,0]*M.fm[1,3]))/ADeterminant;
  result.fm[2,3]:=(M.fm[0,3]*(M.fm[1,1]*M.fm[2,0]-M.fm[1,0]*M.fm[2,1])+
                   M.fm[0,0]*(M.fm[1,3]*M.fm[2,1]-M.fm[1,1]*M.fm[2,3])+
                   M.fm[0,1]*(M.fm[1,0]*M.fm[2,3]-M.fm[1,3]*M.fm[2,0]))/ADeterminant;
  result.fm[3,0]:=(M.fm[1,0]*(M.fm[2,2]*M.fm[3,1]-M.fm[2,1]*M.fm[3,2])+
                   M.fm[1,1]*(M.fm[2,0]*M.fm[3,2]-M.fm[2,2]*M.fm[3,0])+
                   M.fm[1,2]*(M.fm[2,1]*M.fm[3,0]-M.fm[2,0]*M.fm[3,1]))/ADeterminant;
  result.fm[3,1]:=(M.fm[2,0]*(M.fm[0,2]*M.fm[3,1]-M.fm[0,1]*M.fm[3,2])+
                   M.fm[2,1]*(M.fm[0,0]*M.fm[3,2]-M.fm[0,2]*M.fm[3,0])+
                   M.fm[2,2]*(M.fm[0,1]*M.fm[3,0]-M.fm[0,0]*M.fm[3,1]))/ADeterminant;
  result.fm[3,2]:=(M.fm[3,0]*(M.fm[0,2]*M.fm[1,1]-M.fm[0,1]*M.fm[1,2])+
                   M.fm[3,1]*(M.fm[0,0]*M.fm[1,2]-M.fm[0,2]*M.fm[1,0])+
                   M.fm[3,2]*(M.fm[0,1]*M.fm[1,0]-M.fm[0,0]*M.fm[1,1]))/ADeterminant;
  result.fm[3,3]:=(M.fm[0,0]*(M.fm[1,1]*M.fm[2,2]-M.fm[1,2]*M.fm[2,1])+
                   M.fm[0,1]*(M.fm[1,2]*M.fm[2,0]-M.fm[1,0]*M.fm[2,2])+
                   M.fm[0,2]*(M.fm[1,0]*M.fm[2,1]-M.fm[1,1]*M.fm[2,0]))/ADeterminant;
end;

// --- TCMatrix ---

procedure TCMatrix.Put(ARow, ACol: longint; AValue: TComplex);
begin
  fm[ARow, ACol] := AValue;
end;

function TCMatrix.Get(ARow, ACol: longint): TComplex;
begin
  result := fm[ARow, ACol];
end;

procedure TCMatrix.Init;
var
  i, j: longint;
begin
  SetLength(fm, TSpace.N, TSpace.N);
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
    begin
      fm[i, j].fRe := 0;
      fm[i, j].fIm := 0;
    end;
end;

function TCMatrix.Clone: TCMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := fm[i, j];
end;

function TCMatrix.ForwardElimination(out SwapCount: integer): TCMatrix;
var
  pivot, ratio: TComplex;
  maxVal:       double;
  i, j, k,
  maxRow:       longint;
  rowI, rowJ:   array of TComplex;
begin
  result    := Self.Clone;
  SwapCount := 0;

  for i := 0 to TSpace.N - 1 do
  begin
    // 1. Ricerca pivot parziale
    maxRow := i;
    maxVal := result.fm[i, i].Norm;
    for j := i + 1 to TSpace.N - 1 do
      if result.fm[j, i].Norm > maxVal then
      begin
        maxVal := result.fm[j, i].Norm;
        maxRow := j;
      end;

    // 2. Matrice singolare
    if maxVal < DefaultEpsilon then Continue;

    // 3. Scambio righe
    if maxRow <> i then
    begin
      result.Swap(i, maxRow);
      Inc(SwapCount);
    end;

    // 4. Riferimento alla riga pivot
    rowI  := result.fm[i];
    pivot := rowI[i];

    // 5. Eliminazione sotto la diagonale
    for j := i + 1 to TSpace.N - 1 do
    begin
      if result.fm[j, i].Norm < DefaultEpsilon then Continue;
      rowJ    := result.fm[j];
      ratio   := rowJ[i] / pivot;
      rowJ[i] := 0;
      for k := i + 1 to TSpace.N - 1 do
        rowJ[k] := rowJ[k] - ratio * rowI[k];
      result.fm[j] := rowJ;
    end;
  end;
end;

function TCMatrix.HouseholderVector(k: longint): TCMatrix;
var
  i:    longint;
  sum: double;
begin
  result.Init;

  // Copia la sottocolonna k+1..N-1
  for i := k + 1 to TSpace.N - 1 do
    result.fm[i, 0] := fm[i, k];

  // Calcola la norma della sottocolonna
  sum := 0;
  for i := k + 1 to TSpace.N - 1 do
    sum := sum + result.fm[i, 0].SquaredNorm;
  sum := sqrt(sum);

  if sum < DefaultEpsilon then Exit;

  // Aggiunge sum al primo elemento per stabilità numerica
  result.fm[k + 1, 0] := result.fm[k + 1, 0] + sum;

  // Ricalcola la norma dopo la modifica
  sum := 0;
  for i := k + 1 to TSpace.N - 1 do
    sum := sum + result.fm[i, 0].SquaredNorm;
  sum := sqrt(sum);

  // Normalizza
  if sum < DefaultEpsilon then Exit;
  for i := k + 1 to TSpace.N - 1 do
    result.fm[i, 0] := result.fm[i, 0] / sum;
end;

function TCMatrix.HessenbergReduction: TCMatrix;
var
  V:       TCMatrix;
  k, i, j: longint;
  dot:     TComplex;
  rowI:    array of TComplex;
begin
  result := Self.Clone;

  for k := 0 to TSpace.N - 3 do
  begin
    V := result.HouseholderVector(k);
    if V.IsNull then Continue;

    // Applica da sinistra: result := (I - 2·V·Vᴴ) · result
    for j := 0 to TSpace.N - 1 do
    begin
      dot := 0;
      for i := k + 1 to TSpace.N - 1 do
        dot := dot + V.fm[i, 0].Conjugate * result.fm[i, j];
      for i := k + 1 to TSpace.N - 1 do
        result.fm[i, j] := result.fm[i, j] - 2 * V.fm[i, 0] * dot;
    end;

    // Applica da destra: result := result · (I - 2·V·Vᴴ)
    for i := 0 to TSpace.N - 1 do
    begin
      rowI := result.fm[i];
      dot  := 0;
      for j := k + 1 to TSpace.N - 1 do
        dot := dot + rowI[j] * V.fm[j, 0];
      for j := k + 1 to TSpace.N - 1 do
        rowI[j] := rowI[j] - 2 * dot * V.fm[j, 0].Conjugate;
      result.fm[i] := rowI;
    end;

    // Azzera esplicitamente sotto la prima sottodiagonale
    for i := k + 2 to TSpace.N - 1 do
      result.fm[i, k] := 0;
  end;
end;

procedure TCMatrix.QRDecompose(out Q, R: TCMatrix);
var
  i, j:         longint;
  c, s,
  temp1, temp2: TComplex;
  denom:        double;
  rowI, rowJ:   array of TComplex;
begin
  Q := TCMatrix.Identity;
  R := Self.Clone;

  for j := 0 to TSpace.N - 2 do
    if R.fm[j + 1, j].Norm > DefaultEpsilon then
    begin
      // denom è reale positivo: √(|r_jj|² + |r_j+1,j|²)
      denom := sqrt(R.fm[j, j].SquaredNorm + R.fm[j + 1, j].SquaredNorm);
      c := R.fm[j,     j] / denom;
      s := R.fm[j + 1, j] / denom;

      // Applica a R da sinistra
      rowI := R.fm[j];
      rowJ := R.fm[j + 1];
      for i := j to TSpace.N - 1 do
      begin
        temp1   := c.Conjugate * rowI[i] + s.Conjugate * rowJ[i];
        temp2   :=           -s * rowI[i] +           c * rowJ[i];
        rowI[i] := temp1;
        rowJ[i] := temp2;
      end;
      R.fm[j]     := rowI;
      R.fm[j + 1] := rowJ;

      // Applica a Q da destra
      for i := 0 to TSpace.N - 1 do
      begin
        rowI        := Q.fm[i];
        temp1       :=            c * rowI[j] +           s * rowI[j + 1];
        temp2       := -s.Conjugate * rowI[j] + c.Conjugate * rowI[j + 1];
        rowI[j]     := temp1;
        rowI[j + 1] := temp2;
        Q.fm[i]     := rowI;
      end;
    end;
end;

function TCMatrix.IsNull: boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if not SameValueEx(fm[i, j], 0) then Exit(False);
  result := True;
end;

function TCMatrix.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TCMatrix.IsHermitian: boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if not SameValueEx(fm[i, j], fm[j, i].Conjugate) then Exit(False);
  result := True;
end;

function TCMatrix.IsUnitary: boolean;
begin
  result := TCMatrix.Identity.SameValue(Self * Self.TransposeConjugate);
end;

function TCMatrix.SameValue(const AMatrix: TCMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if not SameValueEx(fm[i, j], AMatrix.fm[i, j]) then Exit(False);
  result := True;
end;

function TCMatrix.Rank: longint;
var
  U:     TCMatrix;
  swaps: integer;
  i:     longint;
begin
  U      := ForwardElimination(swaps);
  result := 0;
  for i  := 0 to TSpace.N - 1 do
    if U.fm[i, i].Norm > DefaultEpsilon then
      Inc(result);
end;

procedure TCMatrix.Swap(ARow1, ARow2: longint);
var
  tmp: array of TComplex;
begin
  tmp       := fm[ARow1];
  fm[ARow1] := fm[ARow2];
  fm[ARow2] := tmp;
end;

function TCMatrix.Trace: TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 0 to TSpace.N - 1 do
    result := result + fm[i, i];
end;

function TCMatrix.Norm: double;
var
  i, j: longint;
  sum:  double;
  rowI: array of TComplex;
begin
  sum := 0;
  for i := 0 to TSpace.N - 1 do
  begin
    rowI := fm[i];
    for j := 0 to TSpace.N - 1 do
      sum := sum + rowI[j].SquaredNorm;
  end;
  result := sqrt(sum);
end;

function TCMatrix.Conjugate: TCMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := fm[i, j].Conjugate;
end;

function TCMatrix.Transpose: TCMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := fm[j, i];
end;

function TCMatrix.TransposeConjugate: TCMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := fm[j, i].Conjugate;
end;

function TCMatrix.RowReduction: TCMatrix;
var
  ratio:       TComplex;
  i, j, k,
  maxRow:      longint;
  rowI, rowJ:  array of TComplex;
begin
  result := Self.Clone;

  // Step 1: Forward elimination with partial pivoting
  for i := 0 to TSpace.N - 1 do
  begin
    maxRow := i;
    for j := i + 1 to TSpace.N - 1 do
      if result.fm[j, i].Norm > result.fm[maxRow, i].Norm then
        maxRow := j;

    if maxRow <> i then
      result.Swap(i, maxRow);

    if result.fm[i, i].IsNotNull then
    begin
      rowI := result.fm[i];
      for j := i + 1 to TSpace.N - 1 do
        rowI[j] := rowI[j] / rowI[i];
      rowI[i] := 1;
      result.fm[i] := rowI;

      for j := i + 1 to TSpace.N - 1 do
      begin
        if result.fm[j, i].IsNull then Continue;
        rowJ    := result.fm[j];
        ratio   := rowJ[i];
        rowJ[i] := 0;
        for k := i + 1 to TSpace.N - 1 do
          rowJ[k] := rowJ[k] - ratio * rowI[k];
        result.fm[j] := rowJ;
      end;
    end;
  end;

  // Step 2: Back-substitution
  for i := TSpace.N - 1 downto 0 do
    if result.fm[i, i].IsNotNull then
    begin
      rowI := result.fm[i];
      for j := i - 1 downto 0 do
      begin
        rowJ    := result.fm[j];
        ratio   := rowJ[i];
        rowJ[i] := 0;
        for k := i to TSpace.N - 1 do
          rowJ[k] := rowJ[k] - ratio * rowI[k];
        result.fm[j] := rowJ;
      end;
    end;
end;

function TCMatrix.Determinant: TComplex;
var
  U:     TCMatrix;
  swaps: integer;
  i:     longint;
begin
  U      := ForwardElimination(swaps);
  result := 1;
  for i  := 0 to TSpace.N - 1 do
    result := result * U.fm[i, i];
  if Odd(swaps) then
    result := -result;
end;

function TCMatrix.Reciprocal(const ADeterminant: TComplex): TCMatrix;
var
  Adj:     TCMatrix;
  sub:     TCMatrix;
  i, j,
  ri, ci,
  si, sj:  longint;
  sign:    double;
begin
  Adj.Init;
  result.Init;

  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
    begin
      sub.Init;
      si := 0;
      for ri := 0 to TSpace.N - 1 do
      begin
        if ri = i then Continue;
        sj := 0;
        for ci := 0 to TSpace.N - 1 do
        begin
          if ci = j then Continue;
          sub.fm[si, sj] := fm[ri, ci];
          Inc(sj);
        end;
        Inc(si);
      end;
      if Odd(i + j) then sign := -1.0 else sign := 1.0;
      Adj.fm[j, i] := sign * sub.Determinant;
    end;

  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := Adj.fm[i, j] / ADeterminant;
end;

function TCMatrix.Eigenvalues: TArrayOfComplex;
var
  H:         TCMatrix;
  Q, R:      TCMatrix;
  i, iter,
  n:         longint;
  shift:     TComplex;
  converged: boolean;
const
  MaxIter = 1000;
begin
  SetLength(result, TSpace.N);
  H := Self.HessenbergReduction;
  n := TSpace.N - 1;

  while n > 0 do
  begin
    converged := False;
    for iter := 1 to MaxIter do
    begin
      // Wilkinson shift
      shift := H.fm[n, n];
      for i := 0 to n do
        H.fm[i, i] := H.fm[i, i] - shift;

      H.QRDecompose(Q, R);
      H := R * Q;

      for i := 0 to n do
        H.fm[i, i] := H.fm[i, i] + shift;

      if H.fm[n, n - 1].Norm < DefaultEpsilon then
      begin
        result[n] := H.fm[n, n];
        Dec(n);
        converged := True;
        break;
      end;
    end;

    if not converged then
    begin
      result[n] := H.fm[n, n];
      Dec(n);
    end;
  end;
  result[0] := H.fm[0, 0];
end;

function TCMatrix.Diagonalize(const AEigenValues: TArrayOfComplex): TCMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if i = j then
        result.fm[i, i] := AEigenValues[i]
      else
        result.fm[i, j] := 0;
end;

class function TCMatrix.Identity: TCMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if i = j then
        result.fm[i, j] := 1
      else
        result.fm[i, j] := 0;
end;

class function TCMatrix.Null: TCMatrix;
begin
  result.Init;
end;

function TCMatrix.ToString: string;
var
  i, j: longint;
  rows: array of string;
begin
  SetLength(rows, TSpace.N);
  for i := 0 to TSpace.N - 1 do
  begin
    rows[i] := '(';
    for j := 0 to TSpace.N - 1 do
    begin
      if j > 0 then rows[i] := rows[i] + ', ';
      rows[i] := rows[i] + fm[i, j].ToString;
    end;
    rows[i] := rows[i] + ')';
  end;
  result := '(' + string.Join(', ', rows) + ')';
end;

function TCMatrix.ToString(APrecision, ADigits: integer): string;
var
  i, j: longint;
  rows: array of string;
begin
  SetLength(rows, TSpace.N);
  for i := 0 to TSpace.N - 1 do
  begin
    rows[i] := '(';
    for j := 0 to TSpace.N - 1 do
    begin
      if j > 0 then rows[i] := rows[i] + ', ';
      rows[i] := rows[i] + fm[i, j].ToString(APrecision, ADigits);
    end;
    rows[i] := rows[i] + ')';
  end;
  result := '(' + string.Join(', ', rows) + ')';
end;

class operator TCMatrix.:=(const AMatrix: TRMatrix): TCMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := AMatrix.fm[i, j];
end;

class operator TCMatrix.<>(const ALeft, ARight: TCMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if ALeft.fm[i, j] <> ARight.fm[i, j] then Exit(True);
  result := False;
end;

class operator TCMatrix.=(const ALeft, ARight: TCMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if ALeft.fm[i, j] <> ARight.fm[i, j] then Exit(False);
  result := True;
end;

class operator TCMatrix.+(const ALeft, ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] + ARight.fm[i, j];
end;

class operator TCMatrix.-(const ALeft, ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] - ARight.fm[i, j];
end;

class operator TCMatrix.*(const ALeft, ARight: TCMatrix): TCMatrix;
var
  i, j, k: longint;
  rowI:    array of TComplex;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
  begin
    rowI := ALeft.fm[i];
    for j := 0 to TSpace.N - 1 do
    begin
      result.fm[i, j] := 0;
      for k := 0 to TSpace.N - 1 do
        result.fm[i, j] := result.fm[i, j] + rowI[k] * ARight.fm[k, j];
    end;
  end;
end;

class operator TCMatrix.*(const ALeft: TComplex; const ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft * ARight.fm[i, j];
end;

class operator TCMatrix.*(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] * ARight;
end;

class operator TCMatrix./(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] / ARight;
end;

// --- TRVector ---

procedure TRVector.Put(ARow: longint; AValue: double);
begin
  fm[ARow] := AValue;
end;

function TRVector.Get(ARow: longint): double;
begin
  result := fm[ARow];
end;

procedure TRVector.Init;
begin
  SetLength(fm, TSpace.N);
  FillDWord(fm[0], TSpace.N, 0);
end;

function TRVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    if not SameValueEx(fm[i], 0) then Exit(False);
  result := True;
end;

function TRVector.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TRVector.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TRVector.Normalize: TRVector;
var
  i: longint;
  n: double;
begin
  result.Init;
  n := Norm;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := fm[i] / n;
end;

function TRVector.Reciprocal: TRVector;
var
  i:  longint;
  sn: double;
begin
  result.Init;
  sn := SquaredNorm;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := fm[i] / sn;
end;

function TRVector.SquaredNorm: double;
var
  i: longint;
begin
  result := 0;
  for i := 0 to TSpace.N - 1 do
    result := result + sqr(fm[i]);
end;

class operator TRVector.<>(const ALeft, ARight: TRVector): boolean;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    if ALeft.fm[i] <> ARight.fm[i] then Exit(True);
  result := False;
end;

class operator TRVector.=(const ALeft, ARight: TRVector): boolean;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    if ALeft.fm[i] <> ARight.fm[i] then Exit(False);
  result := True;
end;

class operator TRVector.+(const ASelf: TRVector): TRVector;
begin
  result := ASelf;
end;

class operator TRVector.+(const ALeft, ARight: TRVector): TRVector;
var
  i: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] + ARight.fm[i];
end;

class operator TRVector.-(const ASelf: TRVector): TRVector;
var
  i: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := -ASelf.fm[i];
end;

class operator TRVector.-(const ALeft, ARight: TRVector): TRVector;
var
  i: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] - ARight.fm[i];
end;

class operator TRVector.*(const ALeft, ARight: TRVector): double;
var
  i: longint;
begin
  result := 0;
  for i := 0 to TSpace.N - 1 do
    result := result + ALeft.fm[i] * ARight.fm[i];
end;

class operator TRVector.*(const ALeft: double; const ARight: TRVector): TRVector;
var
  i: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft * ARight.fm[i];
end;

class operator TRVector.*(const ALeft: TRVector; const ARight: double): TRVector;
var
  i: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] * ARight;
end;

class operator TRVector.*(const ALeft: TRVector; const ARight: TRMatrix): TRVector;
var
  i, j: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
  begin
    result.fm[i] := 0;
    for j := 0 to TSpace.N - 1 do
      result.fm[i] := result.fm[i] + ALeft.fm[j] * ARight.fm[j, i];
  end;
end;

class operator TRVector.*(const ALeft: TRMatrix; const ARight: TRVector): TRVector;
var
  i, j: longint;
  rowI: array of double;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
  begin
    rowI         := ALeft.fm[i];
    result.fm[i] := 0;
    for j := 0 to TSpace.N - 1 do
      result.fm[i] := result.fm[i] + rowI[j] * ARight.fm[j];
  end;
end;

class operator TRVector./(const ALeft: TRVector; const ARight: double): TRVector;
var
  i: longint;
begin
  result.Init;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] / ARight;
end;

class operator TRVector./(const ALeft: double; const ARight: TRVector): TRVector;
var
  i: longint;
begin
  result := ARight.Reciprocal;
  for i  := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft * result.fm[i];
end;

// --- TR3VectorHelper ---

function TR3VectorHelper.Cross(const AVector: TR3Vector): TR3Vector;
begin
  result.Init;
  result.fm[0] :=  fm[1]*AVector.fm[2] - fm[2]*AVector.fm[1];
  result.fm[1] :=  fm[2]*AVector.fm[0] - fm[0]*AVector.fm[2];
  result.fm[2] :=  fm[0]*AVector.fm[1] - fm[1]*AVector.fm[0];
end;

// --- TCVector ---

procedure TCVector.Put(ARow: longint; AValue: TComplex);
begin
  fm[ARow] := AValue;
end;

function TCVector.Get(ARow: longint): TComplex;
begin
  result := fm[ARow];
end;

function TCVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    if fm[i].IsNotNull then Exit(False);
  result := True;
end;

function TCVector.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TCVector.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TCVector.Normalize: TCVector;
var
  i: longint;
  n: double;
begin
  n := Norm;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := fm[i] / n;
end;

function TCVector.Reciprocal: TCVector;
var
  i:  longint;
  sn: double;
begin
  sn := SquaredNorm;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := fm[i] / sn;
end;

function TCVector.SquaredNorm: double;
var
  i: longint;
begin
  result := 0;
  for i := 0 to TSpace.N - 1 do
    result := result + fm[i].SquaredNorm;
end;

class operator TCVector.:=(const ASelf: TRVector): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ASelf.fm[i];
end;

class operator TCVector.<>(const ALeft, ARight: TCVector): boolean;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    if ALeft.fm[i] <> ARight.fm[i] then Exit(True);
  result := False;
end;

class operator TCVector.=(const ALeft, ARight: TCVector): boolean;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    if ALeft.fm[i] <> ARight.fm[i] then Exit(False);
  result := True;
end;

class operator TCVector.+(const ASelf: TCVector): TCVector;
begin
  result := ASelf;
end;

class operator TCVector.+(const ALeft, ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] + ARight.fm[i];
end;

class operator TCVector.-(const ASelf: TCVector): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := -ASelf.fm[i];
end;

class operator TCVector.-(const ALeft, ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] - ARight.fm[i];
end;

class operator TCVector.*(const ALeft, ARight: TCVector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 0 to TSpace.N - 1 do
    result := result + ALeft.fm[i] * ARight.fm[i];
end;

class operator TCVector.*(const ALeft: double; const ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft * ARight.fm[i];
end;

class operator TCVector.*(const ALeft: TCVector; const ARight: double): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] * ARight;
end;

class operator TCVector.*(const ALeft: TComplex; const ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft * ARight.fm[i];
end;

class operator TCVector.*(const ALeft: TCVector; const ARight: TComplex): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] * ARight;
end;

class operator TCVector.*(const ALeft: TCVector; const ARight: TCMatrix): TCVector;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
  begin
    result.fm[i] := 0;
    for j := 0 to TSpace.N - 1 do
      result.fm[i] := result.fm[i] + ALeft.fm[j] * ARight.fm[j, i];
  end;
end;

class operator TCVector.*(const ALeft: TCMatrix; const ARight: TCVector): TCVector;
var
  i, j: longint;
  rowI: array of TComplex;
begin
  for i := 0 to TSpace.N - 1 do
  begin
    rowI         := ALeft.fm[i];
    result.fm[i] := 0;
    for j := 0 to TSpace.N - 1 do
      result.fm[i] := result.fm[i] + rowI[j] * ARight.fm[j];
  end;
end;

class operator TCVector./(const ALeft: TCVector; const ARight: double): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] / ARight;
end;

class operator TCVector./(const ALeft: double; const ARight: TCVector): TCVector;
var
  i: longint;
  r: TCVector;
begin
  r := ARight.Reciprocal;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft * r.fm[i];
end;

class operator TCVector./(const ALeft: TCVector; const ARight: TComplex): TCVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] / ARight;
end;

class operator TCVector./(const ALeft: TComplex; const ARight: TCVector): TCVector;
var
  i: longint;
  r: TCVector;
begin
  r := ARight.Reciprocal;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft * r.fm[i];
end;

// --- Standalone functions ---

function Abs(const AValue: double): double;
begin
  result := System.Abs(AValue);
end;

function Abs(const AValue: TComplex): double;
begin
  result := AValue.Norm;
end;

function SquarePower(const AValue: TComplex): TComplex;
begin
  result := AValue * AValue;
end;

function CubicPower(const AValue: TComplex): TComplex;
begin
  result := AValue * AValue * AValue;
end;

function QuarticPower(const AValue: TComplex): TComplex;
begin
  result := AValue * AValue * AValue * AValue;
end;

function SquareRoot(const AValue: TComplex): TArrayOfComplex;
var
  norm: double;
begin
  SetLength(result, 2);
  norm := hypot(AValue.fRe, AValue.fIm);
  result[0].fRe := sqrt(0.5 * (norm + AValue.fRe));
  if AValue.fIm >= 0 then
    result[0].fIm :=  sqrt(0.5 * (norm - AValue.fRe))
  else
    result[0].fIm := -sqrt(0.5 * (norm - AValue.fRe));
  result[1] := -result[0];
end;

function CubicRoot(const AValue: TComplex): TArrayOfComplex;
const
  i: TImaginaryUnit = ();
var
  theta, rootModulus, rootArgument: double;
begin
  SetLength(result, 3);
  rootModulus := Power(AValue.Norm, 1/3);
  theta       := Math.ArcTan2(AValue.fIm, AValue.fRe);

  rootArgument := theta / 3;
  result[0] := rootModulus * (Cos(rootArgument) + Sin(rootArgument) * i);

  rootArgument := (theta + 2*Pi) / 3;
  result[1] := rootModulus * (Cos(rootArgument) + Sin(rootArgument) * i);

  rootArgument := (theta + 4*Pi) / 3;
  result[2] := rootModulus * (Cos(rootArgument) + Sin(rootArgument) * i);
end;

function QuarticRoot(const AValue: TComplex): TArrayOfComplex;
const
  i: TImaginaryUnit = ();
var
  theta, rootModulus, rootArgument: double;
begin
  SetLength(result, 4);
  rootModulus := Power(AValue.Norm, 1/4);
  theta       := Math.ArcTan2(AValue.fIm, AValue.fRe);

  rootArgument := theta / 4;
  result[0] := rootModulus * (Cos(rootArgument) + Sin(rootArgument) * i);

  rootArgument := (theta + 2*Pi) / 4;
  result[1] := rootModulus * (Cos(rootArgument) + Sin(rootArgument) * i);

  rootArgument := (theta + 4*Pi) / 4;
  result[2] := rootModulus * (Cos(rootArgument) + Sin(rootArgument) * i);

  rootArgument := (theta + 6*Pi) / 4;
  result[3] := rootModulus * (Cos(rootArgument) + Sin(rootArgument) * i);
end;

function Commutator(const ALeft, ARight: TC2Matrix): TC2Matrix;
begin
  result := ALeft * ARight - ARight * ALeft;
end;

function Commutator(const ALeft, ARight: TC3Matrix): TC3Matrix;
begin
  result := ALeft * ARight - ARight * ALeft;
end;

function Commutator(const ALeft, ARight: TC4Matrix): TC4Matrix;
begin
  result := ALeft * ARight - ARight * ALeft;
end;

function SameValueEx(const AValue1, AValue2: double): boolean;
begin
  result := Math.SameValue(AValue1, AValue2, DefaultEpsilon);
end;

function SameValueEx(const AValue1, AValue2: TComplex): boolean;
begin
  result := SameValueEx(AValue1.fRe, AValue2.fRe) and
            SameValueEx(AValue1.fIm, AValue2.fIm);
end;

function SameValueEx(const AValue1, AValue2: TC2Vector): boolean;
begin
  result := SameValueEx(AValue1.fm[0], AValue2.fm[0]) and
            SameValueEx(AValue1.fm[1], AValue2.fm[1]);
end;

function SameValueEx(const AValue1, AValue2: TC3Vector): boolean;
begin
  result := SameValueEx(AValue1.fm[0], AValue2.fm[0]) and
            SameValueEx(AValue1.fm[1], AValue2.fm[1]) and
            SameValueEx(AValue1.fm[2], AValue2.fm[2]);
end;

function SameValueEx(const AValue1, AValue2: TC4Vector): boolean;
begin
  result := SameValueEx(AValue1.fm[0], AValue2.fm[0]) and
            SameValueEx(AValue1.fm[1], AValue2.fm[1]) and
            SameValueEx(AValue1.fm[2], AValue2.fm[2]) and
            SameValueEx(AValue1.fm[3], AValue2.fm[3]);
end;

function SameValueEx(const AValue1, AValue2: TC2Matrix): boolean;
begin
  result := SameValueEx(AValue1.fm[0,0], AValue2.fm[0,0]) and
            SameValueEx(AValue1.fm[0,1], AValue2.fm[0,1]) and
            SameValueEx(AValue1.fm[1,0], AValue2.fm[1,0]) and
            SameValueEx(AValue1.fm[1,1], AValue2.fm[1,1]);
end;

function SameValueEx(const AValue1, AValue2: TC3Matrix): boolean;
begin
  result := SameValueEx(AValue1.fm[0,0], AValue2.fm[0,0]) and
            SameValueEx(AValue1.fm[0,1], AValue2.fm[0,1]) and
            SameValueEx(AValue1.fm[0,2], AValue2.fm[0,2]) and
            SameValueEx(AValue1.fm[1,0], AValue2.fm[1,0]) and
            SameValueEx(AValue1.fm[1,1], AValue2.fm[1,1]) and
            SameValueEx(AValue1.fm[1,2], AValue2.fm[1,2]) and
            SameValueEx(AValue1.fm[2,0], AValue2.fm[2,0]) and
            SameValueEx(AValue1.fm[2,1], AValue2.fm[2,1]) and
            SameValueEx(AValue1.fm[2,2], AValue2.fm[2,2]);
end;

function SameValueEx(const AValue1, AValue2: TC4Matrix): boolean;
begin
  result := SameValueEx(AValue1.fm[0,0], AValue2.fm[0,0]) and
            SameValueEx(AValue1.fm[0,1], AValue2.fm[0,1]) and
            SameValueEx(AValue1.fm[0,2], AValue2.fm[0,2]) and
            SameValueEx(AValue1.fm[0,3], AValue2.fm[0,3]) and
            SameValueEx(AValue1.fm[1,0], AValue2.fm[1,0]) and
            SameValueEx(AValue1.fm[1,1], AValue2.fm[1,1]) and
            SameValueEx(AValue1.fm[1,2], AValue2.fm[1,2]) and
            SameValueEx(AValue1.fm[1,3], AValue2.fm[1,3]) and
            SameValueEx(AValue1.fm[2,0], AValue2.fm[2,0]) and
            SameValueEx(AValue1.fm[2,1], AValue2.fm[2,1]) and
            SameValueEx(AValue1.fm[2,2], AValue2.fm[2,2]) and
            SameValueEx(AValue1.fm[2,3], AValue2.fm[2,3]) and
            SameValueEx(AValue1.fm[3,0], AValue2.fm[3,0]) and
            SameValueEx(AValue1.fm[3,1], AValue2.fm[3,1]) and
            SameValueEx(AValue1.fm[3,2], AValue2.fm[3,2]) and
            SameValueEx(AValue1.fm[3,3], AValue2.fm[3,3]);
end;

function SolveEquation(const a: double): double;
begin
  result := -a;
end;

function SolveEquation(const a: TComplex): TComplex;
begin
  result := -a;
end;

function SolveEquation(const a, b: TComplex): TArrayOfComplex;
var
  delta: TComplex;
begin
  SetLength(result, 2);
  delta     := SquareRoot(SquarePower(a) - 4*b)[0];
  result[0] := (-a + delta) / 2;
  result[1] := (-a - delta) / 2;
end;

function SolveEquation(const a, b, c: TComplex): TArrayOfComplex;
var
  p, q, s1, t: TComplex;
  u, v:        TArrayOfComplex;
begin
  SetLength(result, 3);
  p := 9*b - 3*SquarePower(a);
  q := 27*c - 9*a*b + 2*CubicPower(a);

  if p.IsNotNull and q.IsNotNull then
  begin
    s1 := -q/2 + SquareRoot(SquarePower(q)/4 + CubicPower(p)/27)[0];
    u  := CubicRoot(s1);
    t := u[0] - p/(3*u[0]); result[0] := (t - a)/3;
    t := u[1] - p/(3*u[1]); result[1] := (t - a)/3;
    t := u[2] - p/(3*u[2]); result[2] := (t - a)/3;
  end else
    if p.IsNull and q.IsNull then
    begin
      result[0] := -a/3;
      result[1] := -a/3;
      result[2] := -a/3;
    end else
      if q.IsNull then
      begin
        v         := SquareRoot(p);
        result[0] := 0;
        result[1] := v[0];
        result[2] := v[1];
      end else
      begin
        u         := CubicRoot(q);
        result[0] := u[0];
        result[1] := u[1];
        result[2] := u[2];
      end;
end;

function SolveEquation(const a, b, c, d: TComplex): TArrayOfComplex;
var
  p, q, r:     TComplex;
  u1, u2, u3,
  v1, v2, v3:  TArrayOfComplex;
  alpha, beta,
  gamma:       TComplex;
begin
  SetLength(result, 4);
  p := 16*b - 6*SquarePower(a);
  q := 64*c - 32*a*b + 8*CubicPower(a);
  r := 256*d - 64*a*c + 16*b*SquarePower(a) - 3*QuarticPower(a);

  if q.IsNull then
  begin
    u1 := SolveEquation(p, r);
    u2 := SquareRoot(u1[0]);
    u3 := SquareRoot(u1[1]);
    result[0] := (u2[0] - a) / 4;
    result[1] := (u2[1] - a) / 4;
    result[2] := (u3[0] - a) / 4;
    result[3] := (u3[1] - a) / 4;
  end else
  begin
    v1    := SolveEquation(2*p, SquarePower(p) - 4*r, -SquarePower(q));
    alpha := SquareRoot(v1[0])[0];
    beta  := (SquarePower(alpha)*alpha + p*alpha - q) / (2*alpha);
    gamma := (SquarePower(alpha)*alpha + p*alpha + q) / (2*alpha);
    v2 := SolveEquation( alpha,  beta);
    v3 := SolveEquation(-alpha, gamma);
    result[0] := (v2[0] - a) / 4;
    result[1] := (v2[1] - a) / 4;
    result[2] := (v3[0] - a) / 4;
    result[3] := (v3[1] - a) / 4;
  end;
end;

end.
