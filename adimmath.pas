{ ADim mathematical types and operations.

  Defines real and complex scalar types, fixed-dimension real and complex
  vectors and square matrices, and the related algebraic operations used
  throughout the ADimPas library.

  Vector and matrix dimensions are determined by the generic @code(Space)
  parameter. The predefined @link(T2DSpace), @link(T3DSpace), and
  @link(T4DSpace) tags provide dimensions 2, 3, and 4 respectively.

  @author Melchiorre Caruso (melchiorrecaruso@@gmail.com)
  @copyright 2025-2026 Melchiorre Caruso
  @license GNU Lesser General Public License v3 with modified LGPL exception.

  This unit is part of the ADim library, distributed under the
  GNU Lesser General Public License v3 (LGPL v3) with the following
  special exception:

  As a special exception, the copyright holders of this library give you
  permission to link this library with independent modules to produce an
  executable, regardless of the license terms of these independent modules,
  and to copy and distribute the resulting executable under terms of your
  choice, provided that you also meet, for each linked independent module,
  the terms and conditions of the license of that module. An independent
  module is a module which is not derived from or based on this library.
  If you modify this library, you may extend this exception to your version
  of the library, but you are not obligated to do so. If you do not wish
  to do so, delete this exception statement from your version.
}

unit ADimMath;

{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function's return value.
{$WARN 6058 OFF} // Suppress warning for function marked as inline that cannot be inlined.

interface

uses
  SysUtils;

type
  { Represents a real number. }
  TReal = double;

  { Dynamic array of @code(TReal) values. }
  TArrayOfReal = array of TReal;

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
      The angle is measured from the positive real axis with the quadrant
      determined from both @link(Re) and @link(Im).
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

    { Returns the modulus (magnitude) of the complex number:
      @code(|z| = √(Re² + Im²)).
    }
    function Norm: double;

    { Returns the squared modulus of the complex number:
      @code(|z|² = Re² + Im²).
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: double;

    { Returns the reciprocal of the complex number: @code(1 / z). }
    function Reciprocal: TComplex;

    { Converts the complex number to its default string representation. }
    function ToString: string;

    { Converts the complex number to a formatted string with controlled precision.
      @param(APrecision Number of significant digits for floating point formatting.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Sets the complex number to zero. }
    procedure Zero;

    { Implicit conversion from a real value to a complex number. }
    class operator :=(const AValue: double): TComplex;

    { Returns @true if the real or imaginary parts of the two operands differ. }
    class operator <>(const ALeft, ARight: TComplex): boolean; inline;

    { Returns @true if both the real and imaginary parts of the two operands are equal. }
    class operator =(const ALeft, ARight: TComplex): boolean; inline;

    { Unary plus. Returns the complex number unchanged. }
    class operator +(const AValue: TComplex): TComplex; inline;

    { Returns the sum of two complex numbers. }
    class operator +(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the sum of a real number and a complex number. }
    class operator +(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Returns the sum of a complex number and a real number. }
    class operator +(const ALeft: TComplex; const ARight: double): TComplex; inline;

    { Unary minus. Returns the negation of the complex number. }
    class operator -(const AValue: TComplex): TComplex; inline;

    { Returns the difference of two complex numbers. }
    class operator -(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the difference of a real number and a complex number. }
    class operator -(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Returns the difference of a complex number and a real number. }
    class operator -(const ALeft: TComplex; const ARight: double): TComplex; inline;

    { Returns the product of two complex numbers. }
    class operator *(const ALeft, ARight: TComplex): TComplex; inline;

    { Returns the product of a real number and a complex number. }
    class operator *(const ALeft: double; const ARight: TComplex): TComplex; inline;

    { Returns the product of a complex number and a real number. }
    class operator *(const ALeft: TComplex; const ARight: double): TComplex; inline;

    { Returns the quotient of two complex numbers. }
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

  { Dynamic array of @link(TComplex) values. }
  TArrayOfComplex = array of TComplex;

  { Represents the imaginary unit @code(i), defined by @code(i² = -1).

    This record has no fields: it acts as a compile-time constant used to
    construct @link(TComplex) numbers naturally via operator overloading.
    A global variable of this type (conventionally named @code(img)) should be
    declared to allow idiomatic use such as @code(3.0 + 2.0*img).
  }
  TImaginaryUnit = record
  public
    { Implicit conversion of the imaginary unit to a @link(TComplex) number. }
    class operator :=(const ASelf: TImaginaryUnit): TComplex;

    { Returns @code(i·i = -1). }
    class operator *(const ALeft, ARight: TImaginaryUnit): double;

    { Returns @code(i/i = 1). }
    class operator /(const ALeft, ARight: TImaginaryUnit): double;

    { Returns @code(-i) as a @link(TComplex). }
    class operator -(const AValue: TImaginaryUnit): TComplex;

    { Returns @code(+i) as a @link(TComplex). }
    class operator +(const AValue: TImaginaryUnit): TComplex;

    { Returns @code(a + i) as a @link(TComplex). }
    class operator +(const ALeft: double; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i + a) as a @link(TComplex). }
    class operator +(const ALeft: TImaginaryUnit; const ARight: double): TComplex;

    { Returns @code(a - i) as a @link(TComplex). }
    class operator -(const ALeft: double; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i - a) as a @link(TComplex). }
    class operator -(const ALeft: TImaginaryUnit; const ARight: double): TComplex;

    { Returns @code((a+bi) + i). }
    class operator +(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i + (a+bi)). }
    class operator +(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    { Returns @code((a+bi) - i). }
    class operator -(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i - (a+bi)). }
    class operator -(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    { Returns @code(a·i) as a @link(TComplex). }
    class operator *(const ALeft: double; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i·a) as a @link(TComplex). }
    class operator *(const ALeft: TImaginaryUnit; const ARight: double): TComplex;

    { Returns @code((a+bi)·i = -b + ai). }
    class operator *(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i·(a+bi) = -b + ai). }
    class operator *(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    { Returns @code(a/i = -ai). }
    class operator /(const ALeft: double; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i/a). }
    class operator /(const ALeft: TImaginaryUnit; const ARight: double): TComplex;

    { Returns @code((a+bi)/i = b - ai). }
    class operator /(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    { Returns @code(i/(a+bi)). }
    class operator /(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
  end;

  { Tag record representing a 2-dimensional space.
    Used as a generic parameter to instantiate 2×2 matrix types.
  }
  T2DSpace = record private const N = 2; end;

  { Tag record representing a 3-dimensional space.
    Used as a generic parameter to instantiate 3×3 matrix types.
  }
  T3DSpace = record private const N = 3; end;

  { Tag record representing a 4-dimensional space.
    Used as a generic parameter to instantiate 4×4 matrix types.
  }
  T4DSpace = record private const N = 4; end;

  { Fixed-dimension vector of complex values.

    The vector is represented as a mathematical column vector. Its dimension
    is determined by @code(Space.N). Components are stored internally in a
    0-based dynamic array and are accessed through the default property
    @code(a[row]).
  }
  generic TComplexVector<Space> = record
  private
    { Storage of the vector components. }
    fm: TArrayOfComplex;

    { Reads the component at position @code(ARow). }
    function Get(ARow: longint): TComplex; inline;

    { Writes the component at position @code(ARow). }
    procedure Put(ARow: longint; AValue: TComplex); inline;

  public
    { Assigns all vector components from @code(AValues).

      The number of supplied values must match the vector dimension
      @code(Space.N). Values are assigned in component order, starting
      from index 0.

      @param(AValues Values to assign to the vector components.)
      @raises(EArgumentException if the number of values does not match
        @code(Space.N).)
    }
    procedure Assign(const AValues: array of TComplex);

    { Returns the algebraic cross product of two 3-component vectors.
      Using 0-based indices:
      @code(u×v = (u[1]v[2]-u[2]v[1], u[2]v[0]-u[0]v[2], u[0]v[1]-u[1]v[0])).
      Requires @code(Space.N = 3).
      @raises(ERangeError if @code(Space.N <> 3).)
    }
    function Cross(const AVector: TComplexVector): TComplexVector;

    { Returns the bilinear dot product of this vector and @code(AVector):
      @code(u·v = Σ uᵢ·vᵢ). No complex conjugation is applied.
    }
    function Dot(const AVector: TComplexVector): TComplex;

    { Returns @true if all components are zero. }
    function IsNull: boolean;

    { Returns @true if at least one component is non-zero. }
    function IsNotNull: boolean;

    { Returns the Euclidean norm (magnitude) of the vector:
      @code(‖v‖ = √(Σ |vᵢ|²)).
    }
    function Norm: TReal;
    { Returns the squared Euclidean norm of the vector:
      @code(‖v‖² = Σ |vᵢ|²).
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: TReal;

    { Returns the unit vector in the same direction.
      Each component is divided by @link(Norm).
      @raises(EZeroDivide if the vector is null.)
    }
    function Normalize: TComplexVector;
    { Returns the reciprocal vector defined component-wise by
      @code(result[i] = Self[i] / ‖Self‖²).
      @raises(EZeroDivide if the vector is null.)
    }
    function Reciprocal: TComplexVector;

    { Converts the vector to its default string representation. }
    function ToString: string;

    { Returns the component-wise complex conjugate of the vector. }
    function Conjugate: TComplexVector;

    { Initialises the vector storage. }
    class operator Initialize(var ASelf: TComplexVector);

    { Releases the dynamic storage of the vector. }
    class operator Finalize(var ASelf: TComplexVector);

    { Performs a deep copy on assignment so that each vector variable
      owns independent storage.
    }
    class operator Copy(constref ASrc: TComplexVector; var ADst: TComplexVector);

    { Returns @true if all corresponding components of the two vectors are equal. }
    class operator =(const ALeft, ARight: TComplexVector): boolean;

    { Returns @true if the two vectors differ in at least one component. }
    class operator <>(const ALeft, ARight: TComplexVector): boolean;

    { Unary plus. Returns the vector unchanged. }
    class operator +(const ASelf: TComplexVector): TComplexVector;

    { Returns the component-wise sum of two vectors. }
    class operator +(const ALeft, ARight: TComplexVector): TComplexVector;

    { Unary minus. Returns the negation of the vector. }
    class operator -(const ASelf: TComplexVector): TComplexVector;

    { Returns the component-wise difference of two vectors. }
    class operator -(const ALeft, ARight: TComplexVector): TComplexVector;

    { Returns the dot product of two vectors. }
    class operator *(const ALeft, ARight: TComplexVector): TComplex;

    { Returns the product of a real scalar and a vector. }
    class operator *(const ALeft: TReal; const ARight: TComplexVector): TComplexVector;

    { Returns the product of a vector and a real scalar. }
    class operator *(const ALeft: TComplexVector; const ARight: TReal): TComplexVector;

    { Returns the product of a complex scalar and a vector. }
    class operator *(const ALeft: TComplex; const ARight: TComplexVector): TComplexVector;

    { Returns the product of a vector and a complex scalar. }
    class operator *(const ALeft: TComplexVector; const ARight: TComplex): TComplexVector;

    { Returns the vector divided by a complex scalar. }
    class operator /(const ALeft: TComplexVector; const ARight: TComplex): TComplexVector;

    { Returns the vector divided by a real scalar. }
    class operator /(const ALeft: TComplexVector; const ARight: TReal): TComplexVector;

    { Provides access to individual vector components using a 0-based index.
      @code(a[0]) is the first component.
    }
    property a[ARow: longint]: TComplex read Get write Put; default;
  end;

  { Fixed-dimension square matrix of complex values.

    The matrix order is determined by @code(Space.N). Elements are stored
    internally in a 0-based two-dimensional dynamic array and are accessed
    through the default property @code(a[row, col]).
  }
  generic TComplexMatrix<Space> = record
  type
    TComplexVector = specialize TComplexVector<Space>;
  private
    { Row-major storage of the matrix elements. }
    fm: array of array of TComplex;

    { Reads the element at position (@code(ARow), @code(ACol)). }
    function Get(ARow, ACol: longint): TComplex; inline;

    { Writes the element at position (@code(ARow), @code(ACol)). }
    procedure Put(ARow, ACol: longint; const AValue: TComplex); inline;

    { Performs forward Gaussian elimination with partial pivoting.
      Used internally by @link(Determinant) and @link(Rank).
      @param(SwapCount Number of row swaps performed, used to determine
      the sign of the determinant.)
      @return(Upper triangular matrix after elimination.)
    }
    function ForwardElimination(out SwapCount: integer): TComplexMatrix; inline;

    { Returns the solution of the linear system @code(Self · x = AData),
      operating on raw component arrays. Backs the public SolveLinear
      methods of the type helpers.
      @raises(EDimensionError if @code(Length(AData)) differs from the order.)
      @raises(EZeroDivide if the matrix is singular.)
    }
    { Reduces the matrix to upper Hessenberg form using Householder reflections.
      Used internally by @link(Eigenvalues).
      @return(Upper Hessenberg matrix similar to Self, with same eigenvalues.)
    }
    function HessenbergReduction: TComplexMatrix;

    { Computes the Householder reflection vector for column @code(k).
      Used internally by @link(HessenbergReduction).
      @param(k Column index, 0-based.)
      @return(Normalized Householder vector stored in column 0.)
    }
    function HouseholderVector(k: longint): TComplexMatrix;
  public
    { Solves the linear system @code(Self * x = AData) by Gaussian
      elimination with partial pivoting, without explicitly forming the
      inverse matrix.
      @raises(EZeroDivide if the matrix is singular.)
    }
    function SolveLinear(const AData: TComplexVector): TComplexVector;

    { Assigns all matrix elements from @code(AValues).

      The number of supplied values must be exactly
      @code(Space.N * Space.N). Values are assigned in row-major order:
      all elements of row 0 are assigned first, followed by row 1, and
      so on.

      @param(AValues Values to assign to the matrix elements.)
      @raises(EArgumentException if the number of values does not match
      @code(Space.N * Space.N).)
    }
    procedure Assign(const AValues: array of TComplex);

    { Returns the @code(N × N) identity matrix with ones on the diagonal
      and zeros elsewhere. The result has the same dimension as Self.
    }
    function Identity: TComplexMatrix;

    { Returns the @code(N × N) null matrix with all elements equal to zero.
      The result has the same dimension as Self.
    }
    function Null: TComplexMatrix;

    { Returns the diagonal matrix built from the supplied values.
      Element @code(D[i,i] = AEigenValues[i]) and all off-diagonal elements
      are zero.
      @param(AEigenValues Vector containing the diagonal values.)
    }
    function Diagonalize(const AEigenValues: TComplexVector): TComplexMatrix;

    { Returns @true if all elements of the matrix are zero. }
    function IsNull: boolean;

    { Returns @true if at least one element of the matrix is non-zero. }
    function IsNotNull: boolean;

    { Returns @true if two matrices are equal within the default floating
      point tolerance @link(DefaultEpsilon).
    }
    function SameValue(const AMatrix: TComplexMatrix): boolean;

    { Returns the determinant of the matrix using Gaussian elimination
      with partial pivoting (LU decomposition).
    }
    function Determinant: TComplex;

    { Returns the Frobenius norm of the matrix:
      @code(‖A‖_F = √(Σ|a[i,j]|²)).
    }
    function Norm: TReal;

    { Returns the number of linearly independent rows or columns. }
    function Rank: longint;

    { Returns the trace of the matrix, i.e. the sum of diagonal elements:
      @code(tr(A) = Σ A[i,i]).
    }
    function Trace: TComplex;

    { Returns an independent copy of the matrix with its own storage. }
    function Clone: TComplexMatrix;

    { Returns the transpose of the matrix.
      Element @code([i,j]) of the result equals element @code([j,i]) of the original.
    }
    function Transpose: TComplexMatrix;

    { Returns the inverse of the matrix.
      @raises(EZeroDivide if the matrix is singular.)
    }
    function Inverse: TComplexMatrix;

    { Returns the row-reduced echelon form of the matrix using Gaussian
      elimination with partial pivoting.
    }
    function RowReduction: TComplexMatrix;

    { Returns the eigenvalues of the matrix as a complex vector.
      The result contains one value for each matrix dimension. The ordering
      of the eigenvalues is not part of the interface contract.
    }
    function Eigenvalues: TComplexVector;

    { Returns the eigenvectors of the matrix as columns of a complex matrix.
      Column @code(j) corresponds to @code(AEigenvalues[j]).
      @param(AEigenvalues Eigenvalues associated with the requested eigenvectors.)
    }
    function Eigenvectors(const AEigenvalues: TComplexVector): TComplexMatrix;

    { Swaps rows @code(ARow1) and @code(ARow2) in place. Indices are 0-based. }
    procedure Swap(ARow1, ARow2: longint);

    { Converts the matrix to its default string representation. }
    function ToString: string;

    { Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Returns the element-wise complex conjugate of the matrix:
      each element @code(a[i,j]) is replaced by @code(a[i,j]*).
    }
    function Conjugate: TComplexMatrix;

    { Returns the conjugate transpose (Hermitian adjoint) of the matrix:
      @code(Aᴴ[i,j] = A[j,i]*).
    }
    function TransposeConjugate: TComplexMatrix;

    { Returns @true if the matrix is unitary, i.e. @code(Aᴴ · A = I). }
    function IsUnitary: boolean;

    { Initialises a new matrix. }
    class operator Initialize(var ASelf: TComplexMatrix);

    { Releases the dynamic storage of the matrix. }
    class operator Finalize(var ASelf: TComplexMatrix);

    { Performs a deep copy on assignment so that each matrix variable
      owns independent storage.
    }
    class operator Copy(constref ASrc: TComplexMatrix; var ADst: TComplexMatrix);

    { Returns @true if the two matrices differ in at least one element. }
    class operator <>(const ALeft, ARight: TComplexMatrix): boolean;

    { Returns @true if all corresponding elements of the two matrices are equal. }
    class operator =(const ALeft, ARight: TComplexMatrix): boolean;

    { Returns the element-wise sum of two matrices of the same size. }
    class operator +(const ALeft, ARight: TComplexMatrix): TComplexMatrix;

    { Returns the element-wise difference of two matrices of the same size. }
    class operator -(const ALeft, ARight: TComplexMatrix): TComplexMatrix;

    { Returns the matrix product of two matrices.
      @code((A·B)[i,j] = Σ_k A[i,k] · B[k,j])
    }
    class operator *(const ALeft, ARight: TComplexMatrix): TComplexMatrix;

    { Returns the product of a real scalar and a matrix. }
    class operator *(const ALeft: TReal; const ARight: TComplexMatrix): TComplexMatrix;

    { Returns the product of a matrix and a real scalar. }
    class operator *(const ALeft: TComplexMatrix; const ARight: TReal): TComplexMatrix;

    { Returns the product of a complex scalar and a matrix. }
    class operator *(const ALeft: TComplex; const ARight: TComplexMatrix): TComplexMatrix;

    { Returns the product of a matrix and a complex scalar. }
    class operator *(const ALeft: TComplexMatrix; const ARight: TComplex): TComplexMatrix;

    { Returns the row-vector product @code(v · A).
      The left vector is interpreted as a row vector for this operation.
    }
    class operator *(const ALeft: TComplexVector; const ARight: TComplexMatrix): TComplexVector;

    { Returns the matrix-column-vector product @code(A · v).
      @code(ARight) is interpreted according to the vector's standard
      column-vector representation.
    }
    class operator *(const ALeft: TComplexMatrix; const ARight: TComplexVector): TComplexVector;

    { Provides access to individual matrix elements using 0-based row and
      column indices. @code(a[0,0]) is the top-left element.
    }
    property a[ARow, ACol: longint]: TComplex read Get write Put; default;
  end;

  { Fixed-dimension vector of real values.

    The vector is represented as a mathematical column vector. Its dimension
    is determined by @code(Space.N). Components are stored internally in a
    0-based dynamic array and are accessed through the default property
    @code(a[row]).
  }
  generic TRealVector<Space> = record
  type
    TComplexVector = specialize TComplexVector<Space>;
  private
    fm: TArrayOfReal;

    function Get(ARow: longint): TReal; inline;
    procedure Put(ARow: longint; AValue: TReal); inline;

  public
    { Assigns all vector components from @code(AValues).

      The number of supplied values must match the vector dimension
      @code(Space.N). Values are assigned in component order, starting
      from index 0.

      @param(AValues Values to assign to the vector components.)
      @raises(EArgumentException if the number of values does not match
        @code(Space.N).)
    }
    procedure Assign(const AValues: array of TReal);

    { Returns the cross product of two 3-component real vectors.
      Requires @code(Space.N = 3).
      @raises(ERangeError if @code(Space.N <> 3).)
    }
    function Cross(const AVector: TRealVector): TRealVector;

    { Returns the Euclidean dot product @code(u·v = Σ uᵢvᵢ). }
    function Dot(const AVector: TRealVector): TReal;

    { Returns @true if all components are zero. }
    function IsNull: boolean;

    { Returns @true if at least one component is non-zero. }
    function IsNotNull: boolean;

    { Returns the Euclidean norm @code(‖v‖ = √(Σ vᵢ²)). }
    function Norm: TReal;

    { Returns the squared Euclidean norm @code(‖v‖² = Σ vᵢ²). }
    function SquaredNorm: TReal;

    { Returns the unit vector in the same direction.
      @raises(EZeroDivide if the vector is null.)
    }
    function Normalize: TRealVector;

    { Returns the reciprocal vector defined by
      @code(result[i] = Self[i] / ‖Self‖²).
      @raises(EZeroDivide if the vector is null.)
    }
    function Reciprocal: TRealVector;

    { Converts the vector to its default string representation. }
    function ToString: string;

    { Converts the real vector to the corresponding complex vector. }
    function ToComplex: TComplexVector;

    class operator Initialize(var ASelf: TRealVector);
    class operator Finalize(var ASelf: TRealVector);
    class operator Copy(constref ASrc: TRealVector; var ADst: TRealVector);

    class operator =(const ALeft, ARight: TRealVector): boolean;
    class operator <>(const ALeft, ARight: TRealVector): boolean;

    class operator +(const ASelf: TRealVector): TRealVector;
    class operator +(const ALeft, ARight: TRealVector): TRealVector;

    class operator -(const ASelf: TRealVector): TRealVector;
    class operator -(const ALeft, ARight: TRealVector): TRealVector;

    class operator *(const ALeft, ARight: TRealVector): TReal;

    class operator *(const ALeft: TReal; const ARight: TRealVector): TRealVector;
    class operator *(const ALeft: TRealVector; const ARight: TReal): TRealVector;

    class operator /(const ALeft: TRealVector; const ARight: TReal): TRealVector;

    property a[ARow: longint]: TReal read Get write Put; default;
  end;

  { Fixed-dimension square matrix of real values.

    The matrix order is determined by @code(Space.N). Elements are stored
    internally in a 0-based two-dimensional dynamic array and are accessed
    through the default property @code(a[row, col]).
  }
  generic TRealMatrix<Space> = record
  type
    TRealVector    = specialize TRealVector<Space>;
    TComplexVector = specialize TComplexVector<Space>;
    TComplexMatrix = specialize TComplexMatrix<Space>;
  private
    fm: array of array of TReal;

    function Get(ARow, ACol: longint): TReal; inline;
    procedure Put(ARow, ACol: longint; AValue: TReal); inline;

    function ForwardElimination(out SwapCount: integer): TRealMatrix; inline;
  public
    { Solves the linear system @code(Self * x = AData) by Gaussian
      elimination with partial pivoting, without explicitly forming the
      inverse matrix.
      @raises(EZeroDivide if the matrix is singular.)
    }
    function SolveLinear(const AData: TRealVector): TRealVector;

    { Assigns all matrix elements from @code(AValues).

      The number of supplied values must be exactly
      @code(Space.N * Space.N). Values are assigned in row-major order:
      all elements of row 0 are assigned first, followed by row 1, and
      so on.

      @param(AValues Values to assign to the matrix elements.)
      @raises(EArgumentException if the number of values does not match
        @code(Space.N * Space.N).)
    }
    procedure Assign(const AValues: array of TReal);

    { Returns the identity matrix. }
    function Identity: TRealMatrix;

    { Returns the null matrix. }
    function Null: TRealMatrix;

    { Returns a real diagonal matrix whose diagonal is @code(ADiagonal). }
    function Diagonalize(const ADiagonal: TRealVector): TRealMatrix;

    { Returns @true if all elements are zero. }
    function IsNull: boolean;

    { Returns @true if at least one element is non-zero. }
    function IsNotNull: boolean;

    { Returns @true if two matrices are equal within @link(DefaultEpsilon). }
    function SameValue(const AMatrix: TRealMatrix): boolean;

    { Returns the determinant using Gaussian elimination with partial pivoting. }
    function Determinant: TReal;

    { Returns the Frobenius norm. }
    function Norm: TReal;

    { Returns the matrix rank. }
    function Rank: longint;

    { Returns the trace. }
    function Trace: TReal;

    { Returns an independent copy of the matrix. }
    function Clone: TRealMatrix;

    { Returns the transpose. }
    function Transpose: TRealMatrix;

    { Returns the inverse.
      @raises(EZeroDivide if the matrix is singular.)
    }
    function Inverse: TRealMatrix;

    { Returns the row-reduced echelon form. }
    function RowReduction: TRealMatrix;

    { Converts the real matrix to the corresponding complex matrix. }
    function ToComplex: TComplexMatrix;

    { Returns the eigenvalues as a complex vector.
      The complex matrix eigensolver is reused without duplicating the
      spectral algorithm.
    }
    function Eigenvalues: TComplexVector;

    { Returns the eigenvectors as columns of a complex matrix.
      The complex matrix eigensolver is reused without duplicating the
      spectral algorithm.
    }
    function Eigenvectors(const AEigenvalues: TComplexVector): TComplexMatrix;

    procedure Swap(ARow1, ARow2: longint);

    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;

    class operator Initialize(var ASelf: TRealMatrix);
    class operator Finalize(var ASelf: TRealMatrix);
    class operator Copy(constref ASrc: TRealMatrix; var ADst: TRealMatrix);

    class operator =(const ALeft, ARight: TRealMatrix): boolean;
    class operator <>(const ALeft, ARight: TRealMatrix): boolean;

    class operator +(const ALeft, ARight: TRealMatrix): TRealMatrix;
    class operator -(const ALeft, ARight: TRealMatrix): TRealMatrix;
    class operator *(const ALeft, ARight: TRealMatrix): TRealMatrix;

    class operator *(const ALeft: TReal; const ARight: TRealMatrix): TRealMatrix;
    class operator *(const ALeft: TRealMatrix; const ARight: TReal): TRealMatrix;

    { Returns the row-vector product @code(v · A). }
    class operator *(const ALeft: TRealVector; const ARight: TRealMatrix): TRealVector;

    { Returns the matrix-column-vector product @code(A · v). }
    class operator *(const ALeft: TRealMatrix; const ARight: TRealVector): TRealVector;

    property a[ARow, ACol: longint]: TReal read Get write Put; default;
  end;

  { Complex vector specialisations. }
  T2ComplexVector = specialize TComplexVector<T2DSpace>;
  T3ComplexVector = specialize TComplexVector<T3DSpace>;
  T4ComplexVector = specialize TComplexVector<T4DSpace>;

  { Complex matrix specialisations. }
  T2ComplexMatrix = specialize TComplexMatrix<T2DSpace>;
  T3ComplexMatrix = specialize TComplexMatrix<T3DSpace>;
  T4ComplexMatrix = specialize TComplexMatrix<T4DSpace>;

  { Real vector specialisations. }
  T2RealVector = specialize TRealVector<T2DSpace>;
  T3RealVector = specialize TRealVector<T3DSpace>;
  T4RealVector = specialize TRealVector<T4DSpace>;

  { Real matrix specialisations. }
  T2RealMatrix = specialize TRealMatrix<T2DSpace>;
  T3RealMatrix = specialize TRealMatrix<T3DSpace>;
  T4RealMatrix = specialize TRealMatrix<T4DSpace>;

{ Constructs a @link(TComplex) from real and imaginary parts. }
function Complex(const ARe, AIm: double): TComplex;

{ Returns the absolute value of a real number. }
function Abs(const AValue: double): double;

{ Returns the absolute value of a complex number. }
function Abs(const AValue: TComplex): double;

{ Returns @true if two real numbers are equal within @link(DefaultEpsilon). }
function SameValueEx(const AValue1, AValue2: double): boolean;

{ Returns @true if two complex numbers are equal within @link(DefaultEpsilon). }
function SameValueEx(const AValue1, AValue2: TComplex): boolean;

{ Solves @code(x + a = 0) over the real numbers. Returns @code(-a). }
function SolveEquation(const a: double): double;

{ Solves @code(x + a = 0) over the complex numbers. Returns @code(-a). }
function SolveEquation(const a: TComplex): TComplex;

{ Returns the square of a real number: @code(x²). }
function SquareNorm(const AValue: double): double;
{ Returns the squared modulus of a complex number: @code(|z|² = Re² + Im²). }
function SquareNorm(const AValue: TComplex): double;

{ Returns the absolute value of a real number: @code(|x|). }
function Norm(const AValue: double): double;
{ Returns the modulus of a complex number: @code(|z| = √(Re² + Im²)). }
function Norm(const AValue: TComplex): double;

{ Converts a real number to its default string representation. }
function FloatToStrF(const AValue: double): string;

{ Converts a complex number to its default string representation. }
function FloatToStrF(const AValue: TComplex): string;

{ Converts a real number to a string with controlled precision.
  @param(APrecision Number of significant digits.)
  @param(ADigits    Minimum number of digits in the output.)
}
function FloatToStrF(const AValue: double; APrecision, ADigits: longint): string;
{ Converts a complex number to a string with controlled precision.
  @param(APrecision Number of significant digits.)
  @param(ADigits    Minimum number of digits in the output.)
}
function FloatToStrF(const AValue: TComplex; APrecision, ADigits: longint): string;

{ Returns @code(z²). }
function SquarePower(const AValue: TComplex): TComplex;

{ Returns @code(z³). }
function CubicPower(const AValue: TComplex): TComplex;

{ Returns @code(z⁴). }
function QuarticPower(const AValue: TComplex): TComplex;

{ Returns the two square roots of @code(AValue) as a 2-element array.
  @code(result[0]) is the principal root; @code(result[1] = -result[0]).
}
function SquareRoot(const AValue: TComplex): TArrayOfComplex;

{ Returns the three cube roots of @code(AValue) as a 3-element array,
  at arguments @code(θ/3), @code((θ+2π)/3), and @code((θ+4π)/3).
}
function CubicRoot(const AValue: TComplex): TArrayOfComplex;

{ Returns the four fourth roots of @code(AValue) as a 4-element array,
  at arguments @code(θ/4), @code((θ+2π)/4), @code((θ+4π)/4), and @code((θ+6π)/4).
}
function QuarticRoot(const AValue: TComplex): TArrayOfComplex;

{ Solves @code(x² + a·x + b = 0) over the complex numbers.
  Returns a 2-element array containing both roots.
}
function SolveEquation(const a, b: TComplex): TArrayOfComplex;

{ Solves @code(x³ + a·x² + b·x + c = 0) over the complex numbers.
  Returns a 3-element array containing all three roots.
}
function SolveEquation(const a, b, c: TComplex): TArrayOfComplex;

{ Solves @code(x⁴ + a·x³ + b·x² + c·x + d = 0) over the complex numbers.
  Returns a 4-element array containing all four roots.
}
function SolveEquation(const a, b, c, d: TComplex): TArrayOfComplex;

{ @exclude }
function Fmt(const AValue: TReal): string;

{ @exclude }
function Fmt(const AValue: TReal; APrecision, ADigits: longint): string;

var
  { The imaginary unit @code(i), defined by @code(i² = -1).
    Use in expressions: @code(z := 3.0 + 2.0*img;)
  }
  img: TImaginaryUnit;

  { Default epsilon for floating point comparisons. }
  DefaultEpsilon: TReal = 1E-12;

implementation

uses Math;

function Fmt(const AValue: TReal): string;
begin
  if AValue < 0.0 then
    result := FloatToStr(AValue)
  else
    result := '+' + FloatToStr(AValue);
end;

function Fmt(const AValue: TReal; APrecision, ADigits: longint): string;
begin
  if AValue < 0.0 then
    result := SysUtils.FloatToStrF(AValue, ffGeneral, APrecision, ADigits)
  else
    result := '+' + SysUtils.FloatToStrF(AValue, ffGeneral, APrecision, ADigits);
end;

function Fmt(const AValue: TComplex): string;
begin
  result := AValue.ToString;
end;

function Fmt(const AValue: TComplex; APrecision, ADigits: longint): string;
begin
  result := AValue.ToString(APrecision, ADigits)
end;

// TComplex

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
var
  LRatio, LDenominator: double;
begin
  if (fRe = 0) and (fIm = 0) then
    raise EZeroDivide.Create('TComplex.Reciprocal: division by zero.');

  if System.Abs(fRe) >= System.Abs(fIm) then
  begin
    LRatio := fIm / fRe;
    LDenominator := fRe + fIm * LRatio;
    result.fRe := 1 / LDenominator;
    result.fIm := -LRatio / LDenominator;
  end else
  begin
    LRatio := fRe / fIm;
    LDenominator := fIm + fRe * LRatio;
    result.fRe := LRatio / LDenominator;
    result.fIm := -1 / LDenominator;
  end;
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
      result := Format('%s %si', [SysUtils.FloatToStrF(fRe, ffGeneral, APrecision, ADigits), sign[fIm < 0]])
    else
      result := Format('%s %s%s∙i', [
        SysUtils.FloatToStrF(fRe,             ffGeneral, APrecision, ADigits), sign[fIm < 0],
        SysUtils.FloatToStrF(System.Abs(fIm), ffGeneral, APrecision, ADigits)]);
  end else
    if not SameValueEx(fRe, 0) then
      result := SysUtils.FloatToStrF(fRe, ffGeneral, APrecision, ADigits)
    else
      if not SameValueEx(fIm, 0) then
      begin
        if SameValueEx(fIm, 1) then result := 'i'
        else if SameValueEx(fIm, -1) then result := '-i'
        else result := Format('%s∙i', [SysUtils.FloatToStrF(fIm, ffGeneral, APrecision, ADigits)])
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

// TImaginaryUnit

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
  LReciprocal: TComplex;
begin
  LReciprocal := ARight.Reciprocal;
  result.fRe := -LReciprocal.fIm;
  result.fIm :=  LReciprocal.fRe;
end;

// TComplexMatrix

function TComplexMatrix.Get(ARow, ACol: longint): TComplex;
begin
  result := fm[ARow, ACol];
end;

procedure TComplexMatrix.Put(ARow, ACol: longint; const AValue: TComplex);
begin
  fm[ARow, ACol] := AValue;
end;

function TComplexMatrix.ForwardElimination(out SwapCount: integer): TComplexMatrix; inline;
var
  pivot, ratio: TComplex;
  maxVal: double;
  i, j, k, maxRow: longint;
  rowI, rowJ: TArrayOfComplex;
begin
  result := Self.Clone;

  SwapCount := 0;
  for i := 0 to Space.N - 1 do
  begin
    maxRow := i;
    maxVal := Abs(result.fm[i, i]);
    for j := i + 1 to Space.N - 1 do
      if Abs(result.fm[j, i]) > maxVal then
      begin
        maxVal := Abs(result.fm[j, i]);
        maxRow := j;
      end;

    if maxVal = 0 then Continue;

    if maxRow <> i then
    begin
      result.Swap(i, maxRow);
      Inc(SwapCount);
    end;

    rowI  := result.fm[i];
    pivot := rowI[i];

    for j := i + 1 to Space.N - 1 do
    begin
      if Abs(result.fm[j, i]) = 0 then Continue;
      rowJ       := result.fm[j];
      ratio      := rowJ[i] / pivot;
      rowJ[i]    := 0;
      for k := i + 1 to Space.N - 1 do
        rowJ[k] := rowJ[k] - ratio * rowI[k];
      result.fm[j] := rowJ;
    end;
  end;
end;

function TComplexMatrix.HessenbergReduction: TComplexMatrix;
var
  V: TComplexMatrix;
  k, i, j: longint;
  dot: TComplex;
  rowI: TArrayOfComplex;
begin
  result := Self.Clone;

  for k := 0 to Space.N - 3 do
  begin
    V := result.HouseholderVector(k);
    if V.IsNull then Continue;

    for j := 0 to Space.N - 1 do
    begin
      dot := 0;
      for i := k + 1 to Space.N - 1 do
        dot := dot + V.fm[i, 0].Conjugate * result.fm[i, j];
      for i := k + 1 to Space.N - 1 do
        result.fm[i, j] := result.fm[i, j] - 2 * V.fm[i, 0] * dot;
    end;

    for i := 0 to Space.N - 1 do
    begin
      rowI := result.fm[i];
      dot  := 0;
      for j := k + 1 to Space.N - 1 do
        dot := dot + rowI[j] * V.fm[j, 0];
      for j := k + 1 to Space.N - 1 do
        rowI[j] := rowI[j] - 2 * dot * V.fm[j, 0].Conjugate;
      result.fm[i] := rowI;
    end;

    for i := k + 2 to Space.N - 1 do
      result.fm[i, k] := 0;
  end;
end;

function TComplexMatrix.HouseholderVector(k: longint): TComplexMatrix;
var
  i: longint;
  LNorm, VNorm, X0Norm: double;
  phase, alpha: TComplex;
begin
  result := Self.Null;

  LNorm := 0;
  for i := k + 1 to Space.N - 1 do
  begin
    result.fm[i, 0] := fm[i, k];
    LNorm := LNorm + SquareNorm(result.fm[i, 0]);
  end;
  LNorm := sqrt(LNorm);

  if LNorm < DefaultEpsilon then Exit;

  X0Norm := Abs(result.fm[k + 1, 0]);
  if X0Norm < DefaultEpsilon then
    phase := 1
  else
    phase := result.fm[k + 1, 0] / X0Norm;

  alpha := -phase * LNorm;
  result.fm[k + 1, 0] := result.fm[k + 1, 0] - alpha;

  VNorm := 0;
  for i := k + 1 to Space.N - 1 do
    VNorm := VNorm + SquareNorm(result.fm[i, 0]);
  VNorm := sqrt(VNorm);

  if VNorm < DefaultEpsilon then Exit;

  for i := k + 1 to Space.N - 1 do
    result.fm[i, 0] := result.fm[i, 0] / VNorm;
end;

procedure TComplexMatrix.Assign(const AValues: array of TComplex);
var
  row, col, i: longint;
begin
  if Length(AValues) <> Space.N * Space.N then
  begin
    raise EArgumentException.CreateFmt('TComplexMatrix.Assign: expected %d values, received %d.', [Space.N * Space.N, Length(AValues)]);
  end;

  i := 0;
  for row := 0 to Space.N - 1 do
    for col := 0 to Space.N - 1 do
    begin
      fm[row, col] := AValues[i];
      Inc(i);
    end;
end;




function TComplexMatrix.Identity: TComplexMatrix;
var
  i, j: longint;
begin
  SetLength(result.fm, Space.N, Space.N);
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      result.fm[i, j] := Ord(i = j);
end;

function TComplexMatrix.Null: TComplexMatrix;
var
  i, j: longint;
begin
  SetLength(result.fm, Space.N, Space.N);
  for i := 0 to Space.N - 1 do
    for j := 0 to Space.N - 1 do
      result.fm[i, j] := 0;
end;

function TComplexMatrix.Diagonalize(const AEigenValues: TComplexVector): TComplexMatrix;
var
  i, j: longint;
begin
  SetLength(result.fm, Space.N, Space.N);
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      if i = j then
        result.fm[i, i] := AEigenValues[i]
      else
        result.fm[i, j] := 0;
end;

function TComplexMatrix.IsNull: boolean;
var
  i, j: longint;
begin
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      if not SameValueEx(fm[i, j], 0) then Exit(False);
  result := True;
end;

function TComplexMatrix.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TComplexMatrix.SameValue(const AMatrix: TComplexMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      if not SameValueEx(fm[i, j], AMatrix.fm[i, j]) then Exit(False);
  result := True;
end;

function TComplexMatrix.Determinant: TComplex;
var
  U: TComplexMatrix;
  swaps: integer;
  i: longint;
begin
  U      := ForwardElimination(swaps);
  result := 1.0;
  for i  := 0 to Space.N -1 do
    result := result * U.fm[i, i];
  if Odd(swaps) then
    result := -result;
end;

function TComplexMatrix.Norm: double;
var
  i, j: longint;
  rowI: TArrayOfComplex;
begin
  result := 0;
  for i := 0 to Space.N -1 do
  begin
    rowI := fm[i];
    for j := 0 to Space.N -1 do
      result := Hypot(result, rowI[j].Norm);
  end;
end;

function TComplexMatrix.Rank: longint;
var
  W: TComplexMatrix;
  pivot, factor: TComplex;
  maxVal: double;
  pivotRow, col, row, k, maxRow: longint;
  rowP, rowR: TArrayOfComplex;
begin
  W := Self.Clone;
  pivotRow := 0;
  result := 0;

  for col := 0 to Space.N - 1 do
  begin
    if pivotRow >= Space.N then Break;

    maxRow := pivotRow;
    maxVal := Abs(W.fm[pivotRow, col]);
    for row := pivotRow + 1 to Space.N - 1 do
      if Abs(W.fm[row, col]) > maxVal then
      begin
        maxVal := Abs(W.fm[row, col]);
        maxRow := row;
      end;

    if maxVal <= DefaultEpsilon then Continue;

    if maxRow <> pivotRow then
      W.Swap(pivotRow, maxRow);

    rowP := W.fm[pivotRow];
    pivot := rowP[col];
    for row := pivotRow + 1 to Space.N - 1 do
    begin
      rowR := W.fm[row];
      if Abs(rowR[col]) <= DefaultEpsilon then Continue;
      factor := rowR[col] / pivot;
      rowR[col] := 0;
      for k := col + 1 to Space.N - 1 do
        rowR[k] := rowR[k] - factor * rowP[k];
      W.fm[row] := rowR;
    end;

    Inc(result);
    Inc(pivotRow);
  end;
end;

function TComplexMatrix.Trace: TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 0 to Space.N -1 do
    result := result + fm[i, i];
end;

function TComplexMatrix.Clone: TComplexMatrix;
var
  i, j: longint;
begin
  SetLength(result.fm, Space.N, Space.N);
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      result.fm[i, j] := fm[i, j];
end;

function TComplexMatrix.Transpose: TComplexMatrix;
var
  i, j: longint;
begin
  SetLength(result.fm, Space.N, Space.N);
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      result.fm[i, j] := fm[j, i];
end;

function TComplexMatrix.Inverse: TComplexMatrix;
var
  W: TComplexMatrix;
  pivot, factor: TComplex;
  maxVal: double;
  i, j, k, maxRow: longint;
  rowW, rowR, pivW, pivR: TArrayOfComplex;
begin
  W := Self.Clone;
  result := Self.Identity;

  for i := 0 to Space.N -1 do
  begin
    maxRow := i;
    maxVal := Abs(W.fm[i, i]);
    for j := i + 1 to Space.N -1 do
      if Abs(W.fm[j, i]) > maxVal then
      begin
        maxVal := Abs(W.fm[j, i]);
        maxRow := j;
      end;

    if maxVal = 0 then
      raise EZeroDivide.Create('TComplexMatrix.Inverse: matrix is singular (zero pivot).');

    if maxRow <> i then
    begin
      W.Swap(i, maxRow);
      result.Swap(i, maxRow);
    end;

    pivW  := W.fm[i];
    pivR  := result.fm[i];
    pivot := pivW[i];
    for k := 0 to Space.N -1 do
    begin
      pivW[k] := pivW[k] / pivot;
      pivR[k] := pivR[k] / pivot;
    end;

    for j := 0 to Space.N -1 do
    begin
      if j = i then Continue;
      rowW   := W.fm[j];
      factor := rowW[i];
      if Abs(factor) = 0 then Continue;
      rowR := result.fm[j];
      for k := 0 to Space.N -1 do
      begin
        rowW[k] := rowW[k] - factor * pivW[k];
        rowR[k] := rowR[k] - factor * pivR[k];
      end;
    end;
  end;
end;

function TComplexMatrix.SolveLinear(const AData: TComplexVector): TComplexVector;
var
  W: TComplexMatrix;
  v: TComplexVector;
  factor, s: TComplex;
  maxVal: double;
  i, j, k, maxRow: longint;
  rowI, rowJ: TArrayOfComplex;
begin
  W := Self.Clone;
  v := AData;

  for i := 0 to Space.N -1 do
  begin
    maxRow := i;
    maxVal := Abs(W.fm[i, i]);
    for j := i + 1 to Space.N -1 do
      if Abs(W.fm[j, i]) > maxVal then
      begin
        maxVal := Abs(W.fm[j, i]);
        maxRow := j;
      end;

    if maxVal = 0 then
      raise EZeroDivide.Create('TComplexMatrix.SolveLinear: matrix is singular (zero pivot).');

    if maxRow <> i then
    begin
      W.Swap(i, maxRow);
      s := v[i]; v[i] := v[maxRow]; v[maxRow] := s;
    end;

    rowI := W.fm[i];
    for j := i + 1 to Space.N -1 do
    begin
      rowJ   := W.fm[j];
      factor := rowJ[i] / rowI[i];
      if Abs(factor) = 0 then Continue;
      for k := i to Space.N -1 do
        rowJ[k] := rowJ[k] - factor * rowI[k];
      v[j] := v[j] - factor * v[i];
    end;
  end;

  for i := Space.N -1 downto 0 do
  begin
    rowI := W.fm[i];
    s := v[i];
    for k := i + 1 to Space.N -1 do
      s := s - rowI[k] * result[k];
    result[i] := s / rowI[i];
  end;
end;

function TComplexMatrix.RowReduction: TComplexMatrix;
var
  pivot, factor: TComplex;
  maxVal: double;
  pivotRow, col, row, k, maxRow: longint;
  rowP, rowR: TArrayOfComplex;
begin
  result := Self.Clone;
  pivotRow := 0;

  for col := 0 to Space.N - 1 do
  begin
    if pivotRow >= Space.N then Break;

    maxRow := pivotRow;
    maxVal := Abs(result.fm[pivotRow, col]);
    for row := pivotRow + 1 to Space.N - 1 do
      if Abs(result.fm[row, col]) > maxVal then
      begin
        maxVal := Abs(result.fm[row, col]);
        maxRow := row;
      end;

    if maxVal = 0 then Continue;

    if maxRow <> pivotRow then
      result.Swap(pivotRow, maxRow);

    rowP := result.fm[pivotRow];
    pivot := rowP[col];
    for k := col to Space.N - 1 do
      rowP[k] := rowP[k] / pivot;
    result.fm[pivotRow] := rowP;

    for row := 0 to Space.N - 1 do
    begin
      if row = pivotRow then Continue;
      rowR := result.fm[row];
      factor := rowR[col];
      if Abs(factor) = 0 then Continue;
      rowR[col] := 0;
      for k := col + 1 to Space.N - 1 do
        rowR[k] := rowR[k] - factor * rowP[k];
      result.fm[row] := rowR;
    end;

    Inc(pivotRow);
  end;
end;

function TComplexMatrix.Eigenvalues: TComplexVector;
const
  MaxIter = 2000;
var
  LHessenberg, LShifted, LQ, LR: TComplexMatrix;
  LPair: TArrayOfComplex;
  LShift: TComplex;
  LTolerance: double;
  LIndex, LLow, LRow, LCol, LIteration: longint;
  LConverged: boolean;

  procedure QRDecompose(const AMatrix: TComplexMatrix; ALow, AHigh: longint;
                        out AQ, AR: TComplexMatrix);
  var
    LRowIndex, LColIndex, LK: longint;
    LCosine, LSine, LDiagonal, LSubDiagonal, LValue0, LValue1: TComplex;
    LRadius: double;
    LQRow, LRRow0, LRRow1: TArrayOfComplex;
  begin
    AQ := AMatrix.Identity;
    AR := AMatrix.Clone;

    for LColIndex := ALow to AHigh - 1 do
    begin
      LDiagonal    := AR.fm[LColIndex, LColIndex];
      LSubDiagonal := AR.fm[LColIndex + 1, LColIndex];
      LRadius := sqrt(SquareNorm(LDiagonal) + SquareNorm(LSubDiagonal));

      if LRadius <= DefaultEpsilon then
      begin
        LCosine := 1;
        LSine   := 0;
      end else
      begin
        LCosine := LDiagonal.Conjugate / LRadius;
        LSine   := LSubDiagonal.Conjugate / LRadius;
      end;

      LRRow0 := AR.fm[LColIndex];
      LRRow1 := AR.fm[LColIndex + 1];
      for LK := LColIndex to AHigh do
      begin
        LValue0 :=  LCosine * LRRow0[LK] + LSine * LRRow1[LK];
        LValue1 := -LSine.Conjugate * LRRow0[LK] +
                    LCosine.Conjugate * LRRow1[LK];
        LRRow0[LK] := LValue0;
        LRRow1[LK] := LValue1;
      end;
      AR.fm[LColIndex]     := LRRow0;
      AR.fm[LColIndex + 1] := LRRow1;

      for LRowIndex := ALow to AHigh do
      begin
        LQRow   := AQ.fm[LRowIndex];
        LValue0 := LQRow[LColIndex];
        LValue1 := LQRow[LColIndex + 1];
        LQRow[LColIndex] :=
          LCosine.Conjugate * LValue0 + LSine.Conjugate * LValue1;
        LQRow[LColIndex + 1] :=
          -LSine * LValue0 + LCosine * LValue1;
        AQ.fm[LRowIndex] := LQRow;
      end;
    end;
  end;

begin
  LHessenberg := Self.HessenbergReduction;
  LIndex := Space.N - 1;

  while LIndex >= 0 do
  begin
    if LIndex = 0 then
    begin
      result[0] := LHessenberg.fm[0, 0];
      Break;
    end;

    LTolerance := DefaultEpsilon *
      (Abs(LHessenberg.fm[LIndex - 1, LIndex - 1]) +
       Abs(LHessenberg.fm[LIndex, LIndex]) + 1);
    if Abs(LHessenberg.fm[LIndex, LIndex - 1]) <= LTolerance then
    begin
      LHessenberg.fm[LIndex, LIndex - 1] := 0;
      result[LIndex] := LHessenberg.fm[LIndex, LIndex];
      Dec(LIndex);
      Continue;
    end;

    LLow := LIndex - 1;
    while LLow > 0 do
    begin
      LTolerance := DefaultEpsilon *
        (Abs(LHessenberg.fm[LLow - 1, LLow - 1]) +
         Abs(LHessenberg.fm[LLow, LLow]) + 1);
      if Abs(LHessenberg.fm[LLow, LLow - 1]) <= LTolerance then
      begin
        LHessenberg.fm[LLow, LLow - 1] := 0;
        Break;
      end;
      Dec(LLow);
    end;

    if LIndex - LLow = 1 then
    begin
      LPair := SolveEquation(
        -(LHessenberg.fm[LLow, LLow] + LHessenberg.fm[LIndex, LIndex]),
         LHessenberg.fm[LLow, LLow] * LHessenberg.fm[LIndex, LIndex] -
         LHessenberg.fm[LLow, LIndex] * LHessenberg.fm[LIndex, LLow]);
      result[LLow]   := LPair[0];
      result[LIndex] := LPair[1];
      LIndex := LLow - 1;
      Continue;
    end;

    LConverged := False;
    for LIteration := 1 to MaxIter do
    begin
      LPair := SolveEquation(
        -(LHessenberg.fm[LIndex - 1, LIndex - 1] +
          LHessenberg.fm[LIndex, LIndex]),
         LHessenberg.fm[LIndex - 1, LIndex - 1] *
         LHessenberg.fm[LIndex, LIndex] -
         LHessenberg.fm[LIndex - 1, LIndex] *
         LHessenberg.fm[LIndex, LIndex - 1]);

      if Abs(LPair[0] - LHessenberg.fm[LIndex, LIndex]) <=
         Abs(LPair[1] - LHessenberg.fm[LIndex, LIndex]) then
        LShift := LPair[0]
      else
        LShift := LPair[1];

      LShifted := LHessenberg.Clone;
      for LRow := LLow to LIndex do
        LShifted.fm[LRow, LRow] := LShifted.fm[LRow, LRow] - LShift;

      QRDecompose(LShifted, LLow, LIndex, LQ, LR);
      LShifted := LR * LQ;
      for LRow := LLow to LIndex do
        LShifted.fm[LRow, LRow] := LShifted.fm[LRow, LRow] + LShift;

      for LRow := LLow to LIndex do
        for LCol := LLow to LIndex do
          LHessenberg.fm[LRow, LCol] := LShifted.fm[LRow, LCol];

      for LRow := LLow + 2 to LIndex do
        for LCol := LLow to LRow - 2 do
          if Abs(LHessenberg.fm[LRow, LCol]) <= DefaultEpsilon then
            LHessenberg.fm[LRow, LCol] := 0;

      LTolerance := DefaultEpsilon *
        (Abs(LHessenberg.fm[LIndex - 1, LIndex - 1]) +
         Abs(LHessenberg.fm[LIndex, LIndex]) + 1);
      if Abs(LHessenberg.fm[LIndex, LIndex - 1]) <= LTolerance then
      begin
        LConverged := True;
        Break;
      end;
    end;

    if LConverged then
    begin
      LHessenberg.fm[LIndex, LIndex - 1] := 0;
      result[LIndex] := LHessenberg.fm[LIndex, LIndex];
      Dec(LIndex);
    end else
    begin
      LPair := SolveEquation(
        -(LHessenberg.fm[LIndex - 1, LIndex - 1] +
          LHessenberg.fm[LIndex, LIndex]),
         LHessenberg.fm[LIndex - 1, LIndex - 1] *
         LHessenberg.fm[LIndex, LIndex] -
         LHessenberg.fm[LIndex - 1, LIndex] *
         LHessenberg.fm[LIndex, LIndex - 1]);
      result[LIndex - 1] := LPair[0];
      result[LIndex]     := LPair[1];
      Dec(LIndex, 2);
    end;
  end;
end;

procedure TComplexMatrix.Swap(ARow1, ARow2: longint);
var
  tmp: TArrayOfComplex;
begin
  tmp       := fm[ARow1];
  fm[ARow1] := fm[ARow2];
  fm[ARow2] := tmp;
end;

function TComplexMatrix.ToString: string;
var
  i, j: longint;
  rows: array of string;
begin
  SetLength(rows, Space.N);
  for i := 0 to Space.N -1 do
  begin
    rows[i] := '(';
    for j := 0 to Space.N -1 do
    begin
      if j > 0 then rows[i] := rows[i] + ', ';
      rows[i] := rows[i] + (fm[i, j].ToString);
    end;
    rows[i] := rows[i] + ')';
  end;
  result := '(' + string.Join(', ', rows) + ')';
end;

function TComplexMatrix.ToString(APrecision, ADigits: integer): string;
var
  i, j: longint;
  rows: array of string;
begin
  SetLength(rows, Space.N);
  for i := 0 to Space.N -1 do
  begin
    rows[i] := '(';
    for j := 0 to Space.N -1 do
    begin
      if j > 0 then rows[i] := rows[i] + ', ';
      rows[i] := rows[i] + FloatToStrF(fm[i, j], APrecision, ADigits);
    end;
    rows[i] := rows[i] + ')';
  end;
  result := '(' + string.Join(', ', rows) + ')';
end;

class operator TComplexMatrix.Initialize(var ASelf: TComplexMatrix);
begin
  SetLength(ASelf.fm, Space.N, Space.N);
end;

class operator TComplexMatrix.Finalize(var ASelf: TComplexMatrix);
begin
  SetLength(ASelf.fm, 0, 0);
end;

class operator TComplexMatrix.Copy(constref ASrc: TComplexMatrix; var ADst: TComplexMatrix);
var
  i, j: longint;
begin
  SetLength(ADst.fm, Space.N, Space.N);
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      ADst.fm[i, j] := ASrc.fm[i, j];
end;

class operator TComplexMatrix.=(const ALeft, ARight: TComplexMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      if ALeft.fm[i, j] <> ARight.fm[i, j] then Exit(False);
  result := True;
end;

class operator TComplexMatrix.<>(const ALeft, ARight: TComplexMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      if ALeft.fm[i, j] <> ARight.fm[i, j] then Exit(True);
  result := False;
end;

class operator TComplexMatrix.+(const ALeft, ARight: TComplexMatrix): TComplexMatrix;
var
  i, j: longint;
begin
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      result.fm[i, j] := ALeft.fm[i, j] + ARight.fm[i, j];
end;

class operator TComplexMatrix.-(const ALeft, ARight: TComplexMatrix): TComplexMatrix;
var
  i, j: longint;
begin
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      result.fm[i, j] := ALeft.fm[i, j] - ARight.fm[i, j];
end;

class operator TComplexMatrix.*(const ALeft, ARight: TComplexMatrix): TComplexMatrix;
var
  i, j, k: longint;
  row: TArrayOfComplex;
begin
  for i := 0 to Space.N -1 do
  begin
    row := ALeft.fm[i];
    for j := 0 to Space.N -1 do
    begin
      result.fm[i, j] := 0;
      for k := 0 to Space.N -1 do
        result.fm[i, j] := result.fm[i, j] + row[k] * ARight.fm[k, j];
    end;
  end;
end;

class operator TComplexMatrix.*(const ALeft: TComplex; const ARight: TComplexMatrix): TComplexMatrix;
var
  i, j: longint;
begin
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      result.fm[i, j] := ALeft * ARight.fm[i, j];
end;

class operator TComplexMatrix.*(const ALeft: TComplexMatrix; const ARight: TComplex): TComplexMatrix;
var
  i, j: longint;
begin
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      result.fm[i, j] := ALeft.fm[i, j] * ARight;
end;

class operator TComplexMatrix.*(const ALeft: TReal; const ARight: TComplexMatrix): TComplexMatrix;
var
  i, j: longint;
begin
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      result.fm[i, j] := ALeft * ARight.fm[i, j];
end;

class operator TComplexMatrix.*(const ALeft: TComplexMatrix; const ARight: TReal): TComplexMatrix;
var
  i, j: longint;
begin
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      result.fm[i, j] := ALeft.fm[i, j] * ARight;
end;

class operator TComplexMatrix.*(const ALeft: TComplexVector; const ARight: TComplexMatrix): TComplexVector;
var
  i, j: longint;
begin
  for i := 0 to Space.N -1 do
  begin
    result.fm[i] := 0;
    for j := 0 to Space.N -1 do
      result.fm[i] := result.fm[i] + ALeft.fm[j] * ARight.fm[j, i];
  end;
end;

class operator TComplexMatrix.*(const ALeft: TComplexMatrix; const ARight: TComplexVector): TComplexVector;
var
  i, j: longint;
  row: TArrayOfComplex;
begin
  for i := 0 to Space.N -1 do
  begin
    row := ALeft.fm[i];
    result.fm[i] := 0;
    for j := 0 to Space.N -1 do
      result.fm[i] := result.fm[i] + row[j] * ARight.fm[j];
  end;
end;

function TComplexMatrix.Eigenvectors(const AEigenvalues: TComplexVector): TComplexMatrix;
var
  M: TComplexMatrix;
  v, w: TComplexVector;
  lam, shift, proj, phase: TComplex;
  i, j, k, attempt, pass, phaseIndex: longint;
  delta, scale, clusterTol, phaseNorm, maxComponentNorm: TReal;
  seed: longword;
  solved: boolean;

  function NextRand: double;
  begin
    {$push}{$R-}{$Q-}
    seed := seed * 1664525 + 1013904223;
    {$pop}
    result := (seed / 4294967295.0) * 2 - 1;
  end;

begin
  scale := Self.Norm;
  seed  := 123456789;

  for j := 0 to Space.N -1 do
  begin
    lam := AEigenvalues[j];

    for i := 0 to Space.N -1 do
      v[i] := Complex(NextRand, NextRand);
    v := v.Normalize;

    delta := 0;
    solved := False;
    for attempt := 1 to 6 do
    begin
      shift := lam + delta;
      M := Self.Clone;
      for i := 0 to Space.N -1 do
        M[i, i] := M[i, i] - shift;

      try
        for pass := 1 to 3 do
        begin
          w := M.SolveLinear(v);

          for k := 0 to j - 1 do
          begin
            clusterTol := 100 * DefaultEpsilon * (Abs(AEigenvalues[k]) + Abs(lam) + 1);
            if Abs(AEigenvalues[k] - lam) <= clusterTol then
            begin
              proj := 0;
              for i := 0 to Space.N -1 do
                proj := proj + result[i, k].Conjugate * w[i];
              for i := 0 to Space.N -1 do
                w[i] := w[i] - proj * result[i, k];
            end;
          end;

          if w.Norm < DefaultEpsilon then
          begin
            for i := 0 to Space.N -1 do
              w[i] := Complex(NextRand, NextRand);
          end;
          v := w.Normalize;
        end;
        solved := True;
        Break;
      except
        on EZeroDivide do
          if delta = 0 then
            delta := (scale + Abs(lam) + 1) * 1e-12
          else
            delta := delta * 1e2;
      end;
    end;

    if not solved then
      raise EInvalidOp.Create('TComplexMatrix.Eigenvectors: inverse iteration did not converge.');

    { An eigenvector is defined only up to a unit complex factor.  Choose a
      deterministic phase by making its largest component real and
      non-negative.  Besides making repeated calls reproducible, this removes
      the arbitrary complex phase from eigenvectors of real matrices. }
    phaseIndex := 0;
    maxComponentNorm := Abs(v[0]);
    for i := 1 to Space.N - 1 do
      if Abs(v[i]) > maxComponentNorm then
      begin
        phaseIndex := i;
        maxComponentNorm := Abs(v[i]);
      end;

    if maxComponentNorm > 0 then
    begin
      phaseNorm := Abs(v[phaseIndex]);
      phase := v[phaseIndex].Conjugate / phaseNorm;
      v := phase * v;
    end;

    for i := 0 to Space.N -1 do
      result[i, j] := v[i];
  end;
end;

function TComplexMatrix.Conjugate: TComplexMatrix;
var
  i, j: longint;
begin
  for i := 0 to Space.N -1 do
    for j := 0 to Space.N -1 do
      result.fm[i, j] := fm[i, j].Conjugate;
end;

function TComplexMatrix.TransposeConjugate: TComplexMatrix;
begin
  result := Transpose.Conjugate;
end;

function TComplexMatrix.IsUnitary: boolean;
begin
  result := Identity.SameValue(Self.TransposeConjugate * Self);
end;

// TComplexVector

function TComplexVector.Get(ARow: longint): TComplex;
begin
  result := fm[ARow];
end;

procedure TComplexVector.Put(ARow: longint; AValue: TComplex);
begin
  fm[ARow] := AValue;
end;

procedure TComplexVector.Assign(const AValues: array of TComplex);
var
  i: longint;
begin
  if Length(AValues) <> Space.N then
  begin
    raise EArgumentException.CreateFmt('TComplexVector.Assign: expected %d values, received %d.', [Space.N, Length(AValues)]);
  end;

  for i := 0 to Space.N -1 do
    fm[i] := AValues[i];
end;

function TComplexVector.Cross(const AVector: TComplexVector): TComplexVector;
begin
  if Space.N <> 3 then
    raise ERangeError.Create('TComplexVector.Cross: cross product is defined only for 3-dimensional vectors.');

  result.fm[0] := fm[1]*AVector.fm[2] - fm[2]*AVector.fm[1];
  result.fm[1] := fm[2]*AVector.fm[0] - fm[0]*AVector.fm[2];
  result.fm[2] := fm[0]*AVector.fm[1] - fm[1]*AVector.fm[0];
end;

function TComplexVector.Dot(const AVector: TComplexVector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 0 to Space.N -1 do
    result := result + fm[i] * AVector.fm[i];
end;

function TComplexVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 0 to Space.N -1 do
    if not SameValueEx(fm[i], 0) then Exit(False);
  result := True;
end;

function TComplexVector.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TComplexVector.Norm: double;
var
  i: longint;
begin
  result := 0;
  for i := 0 to Space.N - 1 do
    result := Hypot(result, fm[i].Norm);
end;

function TComplexVector.SquaredNorm: double;
var
  i: longint;
begin
  result := 0;
  for i := 0 to Space.N -1 do
    result := result + SquareNorm(fm[i]);
end;

function TComplexVector.Normalize: TComplexVector;
var
  i:     longint;
  LNorm: double;
begin
  LNorm := Norm;
  if LNorm = 0 then
    raise EZeroDivide.Create('TRVector.Normalize: cannot normalise a null vector.');

  for i := 0 to Space.N -1 do
    result.fm[i] := fm[i] / LNorm;
end;

function TComplexVector.Reciprocal: TComplexVector;
var
  i:           longint;
  LNorm: double;
begin
  LNorm := Norm;
  if LNorm = 0 then
    raise EZeroDivide.Create('TRVector.Reciprocal: cannot invert a null vector.');

  for i := 0 to Space.N -1 do
    result.fm[i] := (fm[i] / LNorm) / LNorm;
end;

function TComplexVector.ToString: string;
var
  i: longint;
begin
  result := '';
  for i := 0 to Space.N -1 do
    result := result + FloatToStrF(fm[i]) + ',';

  i := Length(result);
  SetLength(result, Max(0, i - 1));
  result := '(' + result + ')';
end;

class operator TComplexVector.Initialize(var ASelf: TComplexVector);
begin
  SetLength(ASelf.fm, Space.N);
end;

class operator TComplexVector.Finalize(var ASelf: TComplexVector);
begin
  SetLength(ASelf.fm, 0);
end;

class operator TComplexVector.Copy(constref ASrc: TComplexVector; var ADst: TComplexVector);
begin
  SetLength(ADst.fm, Space.N);
  ADst.fm := System.Copy(ASrc.fm);
end;

class operator TComplexVector.=(const ALeft, ARight: TComplexVector): boolean;
var
  i: longint;
begin
  for i := 0 to Space.N -1 do
    if ALeft.fm[i] <> ARight.fm[i] then Exit(False);
  result := True;
end;

class operator TComplexVector.<>(const ALeft, ARight: TComplexVector): boolean;
var
  i: longint;
begin
  for i := 0 to Space.N -1 do
    if ALeft.fm[i] <> ARight.fm[i] then Exit(True);
  result := False;
end;

class operator TComplexVector.+(const ASelf: TComplexVector): TComplexVector;
begin
  result := ASelf;
end;

class operator TComplexVector.+(const ALeft, ARight: TComplexVector): TComplexVector;
var
  i: longint;
begin
  for i := 0 to Space.N -1 do
    result.fm[i] := ALeft.fm[i] + ARight.fm[i];
end;

class operator TComplexVector.-(const ASelf: TComplexVector): TComplexVector;
var
  i: longint;
begin
  for i := 0 to Space.N -1 do
    result.fm[i] := -ASelf.fm[i];
end;

class operator TComplexVector.-(const ALeft, ARight: TComplexVector): TComplexVector;
var
  i: longint;
begin
  for i := 0 to Space.N -1 do
    result.fm[i] := ALeft.fm[i] - ARight.fm[i];
end;

class operator TComplexVector.*(const ALeft, ARight: TComplexVector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 0 to Space.N -1 do
    result := result + ALeft.fm[i] * ARight.fm[i];
end;

class operator TComplexVector.*(const ALeft: TComplex; const ARight: TComplexVector): TComplexVector;
var
  i: longint;
begin
  for i := 0 to Space.N -1 do
    result.fm[i] := ALeft * ARight.fm[i];
end;

class operator TComplexVector.*(const ALeft: TComplexVector; const ARight: TComplex): TComplexVector;
var
  i: longint;
begin
  for i := 0 to Space.N -1 do
    result.fm[i] := ALeft.fm[i] * ARight;
end;

class operator TComplexVector.*(const ALeft: TReal; const ARight: TComplexVector): TComplexVector;
var
  i: longint;
begin
  for i := 0 to Space.N -1 do
    result.fm[i] := ALeft * ARight.fm[i];
end;

class operator TComplexVector.*(const ALeft: TComplexVector; const ARight: TReal): TComplexVector;
var
  i: longint;
begin
  for i := 0 to Space.N -1 do
    result.fm[i] := ALeft.fm[i] * ARight;
end;

class operator TComplexVector./(const ALeft: TComplexVector; const ARight: TComplex): TComplexVector;
var
  i: longint;
begin
  for i := 0 to Space.N -1 do
    result.fm[i] := ALeft.fm[i] / ARight;
end;

class operator TComplexVector./(const ALeft: TComplexVector; const ARight: TReal): TComplexVector;
var
  i: longint;
begin
  for i := 0 to Space.N -1 do
    result.fm[i] := ALeft.fm[i] / ARight;
end;

function TComplexVector.Conjugate: TComplexVector;
var
  i: longint;
begin
  for i := 0 to Space.N -1 do
    result[i] := fm[i].Conjugate;
end;

// TRealVector

function TRealVector.Get(ARow: longint): TReal;
begin
  result := fm[ARow];
end;

procedure TRealVector.Put(ARow: longint; AValue: TReal);
begin
  fm[ARow] := AValue;
end;

procedure TRealVector.Assign(const AValues: array of TReal);
var
  i: longint;
begin
  if Length(AValues) <> Space.N then
  begin
    raise EArgumentException.CreateFmt('TRealVector.Assign: expected %d values, received %d.', [Space.N, Length(AValues)]);
  end;

  for i := 0 to Space.N - 1 do
    fm[i] := AValues[i];
end;

function TRealVector.Cross(const AVector: TRealVector): TRealVector;
begin
  if Space.N <> 3 then
  begin
    raise ERangeError.Create('TRealVector.Cross: cross product is defined only for 3-dimensional vectors.');
  end;

  result.fm[0] := fm[1] * AVector.fm[2] - fm[2] * AVector.fm[1];
  result.fm[1] := fm[2] * AVector.fm[0] - fm[0] * AVector.fm[2];
  result.fm[2] := fm[0] * AVector.fm[1] - fm[1] * AVector.fm[0];
end;

function TRealVector.Dot(const AVector: TRealVector): TReal;
var
  LIndex: longint;
begin
  result := 0;
  for LIndex := 0 to Space.N - 1 do
    result := result + fm[LIndex] * AVector.fm[LIndex];
end;

function TRealVector.IsNull: boolean;
var
  LIndex: longint;
begin
  for LIndex := 0 to Space.N - 1 do
    if not SameValueEx(fm[LIndex], 0) then Exit(False);
  result := True;
end;

function TRealVector.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TRealVector.Norm: TReal;
var
  LIndex: longint;
begin
  result := 0;
  for LIndex := 0 to Space.N - 1 do
    result := Hypot(result, fm[LIndex]);
end;

function TRealVector.SquaredNorm: TReal;
var
  LIndex: longint;
begin
  result := 0;
  for LIndex := 0 to Space.N - 1 do
    result := result + sqr(fm[LIndex]);
end;

function TRealVector.Normalize: TRealVector;
var
  LIndex: longint;
  LNorm: TReal;
begin
  LNorm := Norm;
  if LNorm = 0 then
    raise EZeroDivide.Create('TRealVector.Normalize: cannot normalise a null vector.');

  for LIndex := 0 to Space.N - 1 do
    result.fm[LIndex] := fm[LIndex] / LNorm;
end;

function TRealVector.Reciprocal: TRealVector;
var
  LIndex: longint;
  LNorm: TReal;
begin
  LNorm := Norm;
  if LNorm = 0 then
    raise EZeroDivide.Create('TRealVector.Reciprocal: cannot invert a null vector.');

  for LIndex := 0 to Space.N - 1 do
    result.fm[LIndex] := (fm[LIndex] / LNorm) / LNorm;
end;

function TRealVector.ToString: string;
var
  LIndex: longint;
begin
  result := '';
  for LIndex := 0 to Space.N - 1 do
  begin
    if LIndex > 0 then result := result + ',';
    result := result + FloatToStrF(fm[LIndex]);
  end;
  result := '(' + result + ')';
end;

function TRealVector.ToComplex: TComplexVector;
var
  LIndex: longint;
begin
  for LIndex := 0 to Space.N - 1 do
    result[LIndex] := fm[LIndex];
end;

class operator TRealVector.Initialize(var ASelf: TRealVector);
begin
  SetLength(ASelf.fm, Space.N);
end;

class operator TRealVector.Finalize(var ASelf: TRealVector);
begin
  SetLength(ASelf.fm, 0);
end;

class operator TRealVector.Copy(constref ASrc: TRealVector; var ADst: TRealVector);
begin
  SetLength(ADst.fm, Space.N);
  ADst.fm := System.Copy(ASrc.fm);
end;

class operator TRealVector.=(const ALeft, ARight: TRealVector): boolean;
var
  LIndex: longint;
begin
  for LIndex := 0 to Space.N - 1 do
    if ALeft.fm[LIndex] <> ARight.fm[LIndex] then Exit(False);
  result := True;
end;

class operator TRealVector.<>(const ALeft, ARight: TRealVector): boolean;
var
  LIndex: longint;
begin
  for LIndex := 0 to Space.N - 1 do
    if ALeft.fm[LIndex] <> ARight.fm[LIndex] then Exit(True);
  result := False;
end;

class operator TRealVector.+(const ASelf: TRealVector): TRealVector;
begin
  result := ASelf;
end;

class operator TRealVector.+(const ALeft, ARight: TRealVector): TRealVector;
var
  LIndex: longint;
begin
  for LIndex := 0 to Space.N - 1 do
    result.fm[LIndex] := ALeft.fm[LIndex] + ARight.fm[LIndex];
end;

class operator TRealVector.-(const ASelf: TRealVector): TRealVector;
var
  LIndex: longint;
begin
  for LIndex := 0 to Space.N - 1 do
    result.fm[LIndex] := -ASelf.fm[LIndex];
end;

class operator TRealVector.-(const ALeft, ARight: TRealVector): TRealVector;
var
  LIndex: longint;
begin
  for LIndex := 0 to Space.N - 1 do
    result.fm[LIndex] := ALeft.fm[LIndex] - ARight.fm[LIndex];
end;

class operator TRealVector.*(const ALeft, ARight: TRealVector): TReal;
var
  LIndex: longint;
begin
  result := 0;
  for LIndex := 0 to Space.N - 1 do
    result := result + ALeft.fm[LIndex] * ARight.fm[LIndex];
end;

class operator TRealVector.*(const ALeft: TReal; const ARight: TRealVector): TRealVector;
var
  LIndex: longint;
begin
  for LIndex := 0 to Space.N - 1 do
    result.fm[LIndex] := ALeft * ARight.fm[LIndex];
end;

class operator TRealVector.*(const ALeft: TRealVector; const ARight: TReal): TRealVector;
var
  LIndex: longint;
begin
  for LIndex := 0 to Space.N - 1 do
    result.fm[LIndex] := ALeft.fm[LIndex] * ARight;
end;

class operator TRealVector./(const ALeft: TRealVector; const ARight: TReal): TRealVector;
var
  LIndex: longint;
begin
  for LIndex := 0 to Space.N - 1 do
    result.fm[LIndex] := ALeft.fm[LIndex] / ARight;
end;

// TRealMatrix

function TRealMatrix.Get(ARow, ACol: longint): TReal;
begin
  result := fm[ARow, ACol];
end;

procedure TRealMatrix.Put(ARow, ACol: longint; AValue: TReal);
begin
  fm[ARow, ACol] := AValue;
end;

function TRealMatrix.ForwardElimination(out SwapCount: integer): TRealMatrix;
var
  LPivot, LRatio, LMaxValue: TReal;
  LRow, LCol, LNextRow, LPivotRow: longint;
  LRowPivot, LRowWork: TArrayOfReal;
begin
  result := Self.Clone;
  SwapCount := 0;

  for LCol := 0 to Space.N - 1 do
  begin
    LPivotRow := LCol;
    LMaxValue := System.Abs(result.fm[LCol, LCol]);

    for LRow := LCol + 1 to Space.N - 1 do
      if System.Abs(result.fm[LRow, LCol]) > LMaxValue then
      begin
        LMaxValue := System.Abs(result.fm[LRow, LCol]);
        LPivotRow := LRow;
      end;

    if LMaxValue = 0 then Continue;

    if LPivotRow <> LCol then
    begin
      result.Swap(LCol, LPivotRow);
      Inc(SwapCount);
    end;

    LRowPivot := result.fm[LCol];
    LPivot := LRowPivot[LCol];

    for LNextRow := LCol + 1 to Space.N - 1 do
    begin
      if result.fm[LNextRow, LCol] = 0 then Continue;

      LRowWork := result.fm[LNextRow];
      LRatio := LRowWork[LCol] / LPivot;
      LRowWork[LCol] := 0;

      for LRow := LCol + 1 to Space.N - 1 do
        LRowWork[LRow] := LRowWork[LRow] - LRatio * LRowPivot[LRow];

      result.fm[LNextRow] := LRowWork;
    end;
  end;
end;

function TRealMatrix.SolveLinear(const AData: TRealVector): TRealVector;
var
  LWork: TRealMatrix;
  LData: TRealVector;
  LFactor, LSum, LMaxValue, LTemp: TReal;
  LCol, LRow, LIndex, LPivotRow: longint;
  LPivotData, LRowData: TArrayOfReal;
begin
  LWork := Self.Clone;
  LData := AData;

  for LCol := 0 to Space.N - 1 do
  begin
    LPivotRow := LCol;
    LMaxValue := System.Abs(LWork.fm[LCol, LCol]);

    for LRow := LCol + 1 to Space.N - 1 do
      if System.Abs(LWork.fm[LRow, LCol]) > LMaxValue then
      begin
        LMaxValue := System.Abs(LWork.fm[LRow, LCol]);
        LPivotRow := LRow;
      end;

    if LMaxValue = 0 then
      raise EZeroDivide.Create('TRealMatrix.SolveLinear: matrix is singular.');

    if LPivotRow <> LCol then
    begin
      LWork.Swap(LCol, LPivotRow);
      LTemp := LData[LCol];
      LData[LCol] := LData[LPivotRow];
      LData[LPivotRow] := LTemp;
    end;

    LPivotData := LWork.fm[LCol];

    for LRow := LCol + 1 to Space.N - 1 do
    begin
      LRowData := LWork.fm[LRow];
      LFactor := LRowData[LCol] / LPivotData[LCol];
      if LFactor = 0 then Continue;

      LRowData[LCol] := 0;
      for LIndex := LCol + 1 to Space.N - 1 do
        LRowData[LIndex] := LRowData[LIndex] - LFactor * LPivotData[LIndex];

      LData[LRow] := LData[LRow] - LFactor * LData[LCol];
      LWork.fm[LRow] := LRowData;
    end;
  end;

  for LRow := Space.N - 1 downto 0 do
  begin
    LSum := LData[LRow];
    for LIndex := LRow + 1 to Space.N - 1 do
      LSum := LSum - LWork.fm[LRow, LIndex] * result[LIndex];

    result[LRow] := LSum / LWork.fm[LRow, LRow];
  end;
end;

procedure TRealMatrix.Assign(const AValues: array of TReal);
var
  row, col, i: longint;
begin
  if Length(AValues) <> Space.N * Space.N then
  begin
    raise EArgumentException.CreateFmt('TRealMatrix.Assign: expected %d values, received %d.', [Space.N * Space.N, Length(AValues)]);
  end;

  i := 0;
  for row := 0 to Space.N -1 do
    for col := 0 to Space.N -1 do
    begin
      fm[row, col] := AValues[i];
      Inc(i);
    end;
end;

function TRealMatrix.Identity: TRealMatrix;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      result.fm[LRow, LCol] := Ord(LRow = LCol);
end;

function TRealMatrix.Null: TRealMatrix;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      result.fm[LRow, LCol] := 0;
end;

function TRealMatrix.Diagonalize(const ADiagonal: TRealVector): TRealMatrix;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      if LRow = LCol then
        result.fm[LRow, LCol] := ADiagonal[LRow]
      else
        result.fm[LRow, LCol] := 0;
end;

function TRealMatrix.IsNull: boolean;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      if not SameValueEx(fm[LRow, LCol], 0) then Exit(False);
  result := True;
end;

function TRealMatrix.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TRealMatrix.SameValue(const AMatrix: TRealMatrix): boolean;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      if not SameValueEx(fm[LRow, LCol], AMatrix.fm[LRow, LCol]) then Exit(False);
  result := True;
end;

function TRealMatrix.Determinant: TReal;
var
  LUpper: TRealMatrix;
  LSwapCount: integer;
  LIndex: longint;
begin
  LUpper := ForwardElimination(LSwapCount);
  result := 1;
  for LIndex := 0 to Space.N - 1 do
    result := result * LUpper.fm[LIndex, LIndex];

  if Odd(LSwapCount) then result := -result;
end;

function TRealMatrix.Norm: TReal;
var
  LRow, LCol: longint;
begin
  result := 0;
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      result := Hypot(result, fm[LRow, LCol]);
end;

function TRealMatrix.Rank: longint;
var
  LWork: TRealMatrix;
  LRow, LCol, LPivotRow, LScanRow, LIndex: longint;
  LMaxValue, LFactor: TReal;
  LPivotData, LRowData: TArrayOfReal;
begin
  LWork := Self.Clone;
  result := 0;
  LRow := 0;

  for LCol := 0 to Space.N - 1 do
  begin
    if LRow >= Space.N then Break;

    LPivotRow := LRow;
    LMaxValue := System.Abs(LWork.fm[LRow, LCol]);
    for LScanRow := LRow + 1 to Space.N - 1 do
      if System.Abs(LWork.fm[LScanRow, LCol]) > LMaxValue then
      begin
        LMaxValue := System.Abs(LWork.fm[LScanRow, LCol]);
        LPivotRow := LScanRow;
      end;

    if LMaxValue <= DefaultEpsilon then Continue;

    if LPivotRow <> LRow then
      LWork.Swap(LRow, LPivotRow);

    LPivotData := LWork.fm[LRow];

    for LScanRow := LRow + 1 to Space.N - 1 do
    begin
      LRowData := LWork.fm[LScanRow];
      LFactor := LRowData[LCol] / LPivotData[LCol];
      if System.Abs(LFactor) <= DefaultEpsilon then Continue;

      LRowData[LCol] := 0;
      for LIndex := LCol + 1 to Space.N - 1 do
        LRowData[LIndex] := LRowData[LIndex] - LFactor * LPivotData[LIndex];

      LWork.fm[LScanRow] := LRowData;
    end;

    Inc(result);
    Inc(LRow);
  end;
end;

function TRealMatrix.Trace: TReal;
var
  LIndex: longint;
begin
  result := 0;
  for LIndex := 0 to Space.N - 1 do
    result := result + fm[LIndex, LIndex];
end;

function TRealMatrix.Clone: TRealMatrix;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      result.fm[LRow, LCol] := fm[LRow, LCol];
end;

function TRealMatrix.Transpose: TRealMatrix;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      result.fm[LRow, LCol] := fm[LCol, LRow];
end;

function TRealMatrix.Inverse: TRealMatrix;
var
  LWork: TRealMatrix;
  LPivot, LFactor, LMaxValue: TReal;
  LCol, LRow, LIndex, LPivotRow: longint;
  LWorkRow, LResultRow, LPivotWorkRow, LPivotResultRow: TArrayOfReal;
begin
  LWork := Self.Clone;
  result := Identity;

  for LCol := 0 to Space.N - 1 do
  begin
    LPivotRow := LCol;
    LMaxValue := System.Abs(LWork.fm[LCol, LCol]);

    for LRow := LCol + 1 to Space.N - 1 do
      if System.Abs(LWork.fm[LRow, LCol]) > LMaxValue then
      begin
        LMaxValue := System.Abs(LWork.fm[LRow, LCol]);
        LPivotRow := LRow;
      end;

    if LMaxValue = 0 then
      raise EZeroDivide.Create('TRealMatrix.Inverse: matrix is singular.');

    if LPivotRow <> LCol then
    begin
      LWork.Swap(LCol, LPivotRow);
      result.Swap(LCol, LPivotRow);
    end;

    LPivotWorkRow := LWork.fm[LCol];
    LPivotResultRow := result.fm[LCol];
    LPivot := LPivotWorkRow[LCol];

    for LIndex := 0 to Space.N - 1 do
    begin
      LPivotWorkRow[LIndex] := LPivotWorkRow[LIndex] / LPivot;
      LPivotResultRow[LIndex] := LPivotResultRow[LIndex] / LPivot;
    end;

    LWork.fm[LCol] := LPivotWorkRow;
    result.fm[LCol] := LPivotResultRow;

    for LRow := 0 to Space.N - 1 do
    begin
      if LRow = LCol then Continue;

      LWorkRow := LWork.fm[LRow];
      LFactor := LWorkRow[LCol];
      if LFactor = 0 then Continue;

      LResultRow := result.fm[LRow];
      for LIndex := 0 to Space.N - 1 do
      begin
        LWorkRow[LIndex] := LWorkRow[LIndex] - LFactor * LPivotWorkRow[LIndex];
        LResultRow[LIndex] := LResultRow[LIndex] - LFactor * LPivotResultRow[LIndex];
      end;

      LWork.fm[LRow] := LWorkRow;
      result.fm[LRow] := LResultRow;
    end;
  end;
end;

function TRealMatrix.RowReduction: TRealMatrix;
var
  LLeadRow, LCol, LPivotRow, LScanRow, LIndex: longint;
  LMaxValue, LPivot, LFactor: TReal;
  LPivotData, LRowData: TArrayOfReal;
begin
  result := Self.Clone;
  LLeadRow := 0;

  for LCol := 0 to Space.N - 1 do
  begin
    if LLeadRow >= Space.N then Break;

    LPivotRow := LLeadRow;
    LMaxValue := System.Abs(result.fm[LLeadRow, LCol]);
    for LScanRow := LLeadRow + 1 to Space.N - 1 do
      if System.Abs(result.fm[LScanRow, LCol]) > LMaxValue then
      begin
        LMaxValue := System.Abs(result.fm[LScanRow, LCol]);
        LPivotRow := LScanRow;
      end;

    if LMaxValue = 0 then Continue;

    if LPivotRow <> LLeadRow then
      result.Swap(LLeadRow, LPivotRow);

    LPivotData := result.fm[LLeadRow];
    LPivot := LPivotData[LCol];

    for LIndex := LCol to Space.N - 1 do
      LPivotData[LIndex] := LPivotData[LIndex] / LPivot;
    result.fm[LLeadRow] := LPivotData;

    for LScanRow := 0 to Space.N - 1 do
    begin
      if LScanRow = LLeadRow then Continue;

      LRowData := result.fm[LScanRow];
      LFactor := LRowData[LCol];
      if LFactor = 0 then
      begin
        LRowData[LCol] := 0;
        result.fm[LScanRow] := LRowData;
        Continue;
      end;

      for LIndex := LCol to Space.N - 1 do
        LRowData[LIndex] := LRowData[LIndex] - LFactor * LPivotData[LIndex];

      LRowData[LCol] := 0;
      result.fm[LScanRow] := LRowData;
    end;

    Inc(LLeadRow);
  end;
end;

function TRealMatrix.ToComplex: TComplexMatrix;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      result[LRow, LCol] := fm[LRow, LCol];
end;

function TRealMatrix.Eigenvalues: TComplexVector;
var
  LComplexMatrix: TComplexMatrix;
begin
  LComplexMatrix := ToComplex;
  result := LComplexMatrix.Eigenvalues;
end;

function TRealMatrix.Eigenvectors(const AEigenvalues: TComplexVector): TComplexMatrix;
var
  LComplexMatrix: TComplexMatrix;
begin
  LComplexMatrix := ToComplex;
  result := LComplexMatrix.Eigenvectors(AEigenvalues);
end;

procedure TRealMatrix.Swap(ARow1, ARow2: longint);
var
  LTemp: TArrayOfReal;
begin
  LTemp := fm[ARow1];
  fm[ARow1] := fm[ARow2];
  fm[ARow2] := LTemp;
end;

function TRealMatrix.ToString: string;
var
  LRow, LCol: longint;
  LRows: array of string;
begin
  SetLength(LRows, Space.N);

  for LRow := 0 to Space.N - 1 do
  begin
    LRows[LRow] := '(';
    for LCol := 0 to Space.N - 1 do
    begin
      if LCol > 0 then LRows[LRow] := LRows[LRow] + ', ';
      LRows[LRow] := LRows[LRow] + FloatToStrF(fm[LRow, LCol]);
    end;
    LRows[LRow] := LRows[LRow] + ')';
  end;

  result := '(' + string.Join(', ', LRows) + ')';
end;

function TRealMatrix.ToString(APrecision, ADigits: integer): string;
var
  LRow, LCol: longint;
  LRows: array of string;
begin
  SetLength(LRows, Space.N);

  for LRow := 0 to Space.N - 1 do
  begin
    LRows[LRow] := '(';
    for LCol := 0 to Space.N - 1 do
    begin
      if LCol > 0 then LRows[LRow] := LRows[LRow] + ', ';
      LRows[LRow] := LRows[LRow] +
        FloatToStrF(fm[LRow, LCol], APrecision, ADigits);
    end;
    LRows[LRow] := LRows[LRow] + ')';
  end;

  result := '(' + string.Join(', ', LRows) + ')';
end;

class operator TRealMatrix.Initialize(var ASelf: TRealMatrix);
begin
  SetLength(ASelf.fm, Space.N, Space.N);
end;

class operator TRealMatrix.Finalize(var ASelf: TRealMatrix);
begin
  SetLength(ASelf.fm, 0, 0);
end;

class operator TRealMatrix.Copy(constref ASrc: TRealMatrix; var ADst: TRealMatrix);
var
  LRow, LCol: longint;
begin
  SetLength(ADst.fm, Space.N, Space.N);
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      ADst.fm[LRow, LCol] := ASrc.fm[LRow, LCol];
end;

class operator TRealMatrix.=(const ALeft, ARight: TRealMatrix): boolean;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      if ALeft.fm[LRow, LCol] <> ARight.fm[LRow, LCol] then Exit(False);
  result := True;
end;

class operator TRealMatrix.<>(const ALeft, ARight: TRealMatrix): boolean;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      if ALeft.fm[LRow, LCol] <> ARight.fm[LRow, LCol] then Exit(True);
  result := False;
end;

class operator TRealMatrix.+(const ALeft, ARight: TRealMatrix): TRealMatrix;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      result.fm[LRow, LCol] := ALeft.fm[LRow, LCol] + ARight.fm[LRow, LCol];
end;

class operator TRealMatrix.-(const ALeft, ARight: TRealMatrix): TRealMatrix;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      result.fm[LRow, LCol] := ALeft.fm[LRow, LCol] - ARight.fm[LRow, LCol];
end;

class operator TRealMatrix.*(const ALeft, ARight: TRealMatrix): TRealMatrix;
var
  LRow, LCol, LIndex: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
    begin
      result.fm[LRow, LCol] := 0;
      for LIndex := 0 to Space.N - 1 do
        result.fm[LRow, LCol] := result.fm[LRow, LCol] +
          ALeft.fm[LRow, LIndex] * ARight.fm[LIndex, LCol];
    end;
end;

class operator TRealMatrix.*(const ALeft: TReal; const ARight: TRealMatrix): TRealMatrix;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      result.fm[LRow, LCol] := ALeft * ARight.fm[LRow, LCol];
end;

class operator TRealMatrix.*(const ALeft: TRealMatrix; const ARight: TReal): TRealMatrix;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
    for LCol := 0 to Space.N - 1 do
      result.fm[LRow, LCol] := ALeft.fm[LRow, LCol] * ARight;
end;

class operator TRealMatrix.*(const ALeft: TRealVector; const ARight: TRealMatrix): TRealVector;
var
  LRow, LCol: longint;
begin
  for LCol := 0 to Space.N - 1 do
  begin
    result.fm[LCol] := 0;
    for LRow := 0 to Space.N - 1 do
      result.fm[LCol] := result.fm[LCol] +
        ALeft.fm[LRow] * ARight.fm[LRow, LCol];
  end;
end;

class operator TRealMatrix.*(const ALeft: TRealMatrix; const ARight: TRealVector): TRealVector;
var
  LRow, LCol: longint;
begin
  for LRow := 0 to Space.N - 1 do
  begin
    result.fm[LRow] := 0;
    for LCol := 0 to Space.N - 1 do
      result.fm[LRow] := result.fm[LRow] +
        ALeft.fm[LRow, LCol] * ARight.fm[LCol];
  end;
end;

function Complex(const ARe, AIm: double): TComplex;
begin
  result.Re := ARe;
  result.Im := AIm;
end;

function Abs(const AValue: double): double;
begin
  result := System.Abs(AValue);
end;

function Abs(const AValue: TComplex): double;
begin
  result := AValue.Norm;
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
        v         := SquareRoot(-p);
        result[0] := (0    - a) / 3;
        result[1] := (v[0] - a) / 3;
        result[2] := (v[1] - a) / 3;
      end else
      begin
        u         := CubicRoot(-q);
        result[0] := (u[0] - a) / 3;
        result[1] := (u[1] - a) / 3;
        result[2] := (u[2] - a) / 3;
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

function SquareNorm(const AValue: double): double;
begin
  result := sqr(Avalue);
end;

function SquareNorm(const AValue: TComplex): double;
begin
  result := AValue.SquaredNorm;
end;

function Norm(const AValue: double): double;
begin
  result := System.Abs(AValue);
end;

function Norm(const AValue: TComplex): double;
begin
  result := AValue.Norm;
end;

function FloatToStrF(const AValue: double): string;
begin
  result := AValue.ToString;
end;

function FloatToStrF(const AValue: TComplex): string;
begin
  result := AValue.ToString;
end;

function FloatToStrF(const AValue: double; APrecision, ADigits: longint): string;
begin
  result := SysUtils.FloatToStrF(AValue, ffGeneral, APrecision, ADigits);
end;

function FloatToStrF(const AValue: TComplex; APrecision, ADigits: longint): string;
begin
  result := AValue.ToString(APrecision, ADigits);
end;

end.
