{ ADim matrix and vector types.

  Defines real matrix and vector types used throughout the ADimPas library,
  including:

  @unorderedList(
    @item(@link(TRMatrix) — N×N real matrix with Gaussian elimination,
          QR decomposition, and eigenvalue computation. Dimension N is set
          at runtime via @link(TRMatrix.Init).)
    @item(@link(TRVector) — N-component real column vector with standard
          linear algebra operations and matrix-vector products. Dimension N
          is set at runtime via @link(TRVector.Init).)
  )

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

unit ADimR;

{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function's return value.
{$WARN 6058 OFF} // Suppress warning for function marked as inline that cannot be inlined.

interface

uses
  ADimCommon;

type
  { Dynamic array of @code(double) values. }
  TArrayOfDouble = array of double;

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

    { Returns @true if both the real and imaginary parts of the two operands are equal. }
    class operator =(const ALeft, ARight: TComplex): boolean; inline;

    { Returns @true if the real or imaginary parts of the two operands differ. }
    class operator <>(const ALeft, ARight: TComplex): boolean; inline;

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

  { Square matrix of real values (@code(double)) with runtime-variable
    dimension @code(N × N).

    The dimension must be set before use by calling @link(Init).
    Matrix elements are stored in a 0-based dynamic 2D array.
    Use the default array property @code(a[row, col]) to read and write
    individual elements using 0-based indices.
  }
  generic TMatrix<T> = record
  type
    TArrayOfArrayOfT = array of array of T;
    TArrayOfT = array of T;
  private
    fm: TArrayOfArrayOfT;
    fOrder: longint;

    { Reads the element at position (@code(ARow), @code(ACol)). }
    function Get(ARow, ACol: longint): T;

    { Writes the element at position (@code(ARow), @code(ACol)). }
    procedure Put(ARow, ACol: longint; const AValue: T);

    { Performs forward Gaussian elimination with partial pivoting.
      Used internally by @link(Determinant) and @link(RowReduction).
      @param(SwapCount Number of row swaps performed, used to determine
      the sign of the determinant.)
      @return(Upper triangular matrix after elimination.)
    }
    function ForwardElimination(out SwapCount: integer): TMatrix; inline;

    { Reduces the matrix to upper Hessenberg form using Householder reflections.
      Used internally by @link(Eigenvalues).
      @return(Upper Hessenberg matrix similar to Self, with same eigenvalues.)
    }
    function HessenbergReduction: TMatrix;

    { Computes the Householder reflection vector for column @code(k).
      Used internally by @link(HessenbergReduction).
      @param(k Column index, 0-based.)
      @return(Normalized Householder vector stored in column 0.)
    }
    function HouseholderVector(k: longint): TMatrix;

    { Decomposes the Hessenberg matrix into Q·R using Givens rotations.
      Optimized for Hessenberg matrices: @code(O(N²)) instead of @code(O(N³)).
      Used internally by @link(Eigenvalues).
      @param(Q Orthogonal matrix.)
      @param(R Upper triangular matrix.)
    }
    procedure QRDecompose(out Q, R: TMatrix);

  public
    { Sets the matrix to @code(N × N) and resets all elements to zero, in place. }
    procedure Init(AOrder: longint);

    { Sets the matrix to @code(N × N) and fills it row-major from AData, in place.
      No temporary matrix is allocated. AData must contain exactly
      @code(AOrder·AOrder) values. }
    procedure Init(AOrder: longint; const AData: TArrayOfT);

    { Sets the matrix from AData, in place, inferring the order from the number
      of values (which must be a perfect square), filled row-major. }
    procedure Init(const AData: TArrayOfT);

    { Returns a new N×N matrix with all elements set to zero. }
    class function New(AOrder: longint): TMatrix; static;

    { Returns a new N×N matrix filled row-major from AData.
      AData must contain exactly AOrder·AOrder values. }
    class function New(AOrder: longint; const AData: TArrayOfT): TMatrix; static;

    { Returns a new square matrix whose order is inferred from the number of
      values in AData (which must be a perfect square), filled row-major. }
    class function New(const AData: TArrayOfT): TMatrix; static;

    { Returns the @code(N × N) identity matrix with ones on the diagonal
      and zeros elsewhere. The result has the same dimension as Self.
    }
    function Identity: TMatrix;

    { Returns the @code(N × N) null matrix with all elements equal to zero.
      The result has the same dimension as Self.
    }
    function Null: TMatrix;

    { Returns the diagonal matrix built from the given eigenvalues.
      Element @code(D[i,i] = AEigenValues[i]) and all off-diagonal elements are zero.
      @param(AEigenValues 0-based dynamic array of @code(N) real eigenvalues,
      typically computed via @link(Eigenvalues).)
    }
    function Diagonalize(const AEigenValues: TArrayOfT): TMatrix;

    { Returns @true if all elements of the matrix are zero. }
    function IsNull: boolean;

    { Returns @true if at least one element of the matrix is non-zero. }
    function IsNotNull: boolean;

    { Returns @true if two matrices are equal within the default floating
      point tolerance @link(DefaultEpsilon).
    }
    function SameValue(const AMatrix: TMatrix): boolean;

    { Returns the determinant of the matrix using Gaussian elimination
      with partial pivoting (LU decomposition).
    }
    function Determinant: T;

    { Returns the Frobenius norm of the matrix:
      @code(‖A‖_F = √(Σ|a[i,j]|²)).
    }
    function Norm: double;

    { Returns the number of linearly independent rows or columns. }
    function Rank: longint;

    { Returns the trace of the matrix, i.e. the sum of diagonal elements:
      @code(tr(A) = Σ A[i,i]).
    }
    function Trace: T;

    { Returns a deep copy of the matrix.
      Required because dynamic array assignment copies only the reference.
    }
    function Clone: TMatrix;

    { Returns the transpose of the matrix.
      Element @code([i,j]) of the result equals element @code([j,i]) of the original.
    }
    function Transpose: TMatrix;

    { Returns the inverse of the matrix given its precomputed determinant.
      Uses the adjugate (cofactor transpose) method.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
      @raises(EZeroDivide if the matrix is singular, i.e. ADeterminant is zero.)
    }
    function Reciprocal(const ADeterminant: T): TMatrix;

    { Returns the row-reduced echelon form of the matrix using Gaussian
      elimination with partial pivoting.
    }
    function RowReduction: TMatrix;

    { Returns the eigenvalues of the matrix as a dynamic array of @code(double).
      Uses the QR algorithm with Hessenberg reduction and Wilkinson shift.
      Assumes a real spectrum (always true for symmetric matrices).
      @return(0-based dynamic array of @code(N) real eigenvalues,
      not guaranteed to be sorted.)
      @raises(Exception if a complex conjugate eigenvalue pair is detected.)
    }
    function Eigenvalues: TArrayOfT;

    { Swaps rows @code(ARow1) and @code(ARow2) in place. Indices are 0-based. }
    procedure Swap(ARow1, ARow2: longint);

    { Converts the matrix to its default string representation. }
    function ToString: string;

    { Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Management operator: zero-initialises a new matrix (empty, order 0). }
    class operator Initialize(var ASelf: TMatrix);

    { Management operator: releases the dynamic storage when the matrix goes out of scope. }
    class operator Finalize(var ASelf: TMatrix);

    { Management operator: performs a deep copy on assignment, so each matrix owns
      independent storage. }
    class operator Copy(constref ASrc: TMatrix; var ADst: TMatrix);

    { Returns @true if all corresponding elements of the two matrices are equal. }
    class operator =(const ALeft, ARight: TMatrix): boolean;

    { Returns @true if the two matrices differ in at least one element. }
    class operator <>(const ALeft, ARight: TMatrix): boolean;

    { Returns the element-wise sum of two matrices of the same size. }
    class operator +(const ALeft, ARight: TMatrix): TMatrix;

    { Returns the element-wise difference of two matrices of the same size. }
    class operator -(const ALeft, ARight: TMatrix): TMatrix;

    { Returns the matrix product of two matrices.
      @code((A·B)[i,j] = Σ_k A[i,k] · B[k,j])
    }
    class operator *(const ALeft, ARight: TMatrix): TMatrix;

    { Returns the product of a real scalar and a matrix. }
    class operator *(const ALeft: T; const ARight: TMatrix): TMatrix;

    { Returns the product of a matrix and a real scalar. }
    class operator *(const ALeft: TMatrix; const ARight: T): TMatrix;

    { Returns the matrix divided by a real scalar. }
    class operator /(const ALeft: TMatrix; const ARight: T): TMatrix;

    { Provides access to individual matrix elements using 0-based row and
      column indices. @code(a[0,0]) is the top-left element.
    }
    property a[ARow, ACol: longint]: T read Get write Put; default;

    { The dimension @code(N) of the matrix. Set by @link(Init).}
    property Order: longint read fOrder;
  end;

  { Column vector of real values (@code(double)) with runtime-variable
    dimension @code(N).

    The dimension must be set before use by assigning @link(Size).
    Components are stored in a 0-based dynamic array.
    Use the default array property @code(a[row]) to read and write individual
    components using 0-based indices.
  }
  generic TVector<T> = record
  type
    TMatrix = specialize TMatrix<T>;
    TArrayOfT = array of T;
  private
    fm: TArrayOfT;
    fOrder: longint;

    { Reads the component at position @code(ARow). }
    function Get(ARow: longint): T;

    { Writes the component at position @code(ARow). }
    procedure Put(ARow: longint; AValue: T);

  public
    { Sets the vector to @code(ASize) components and resets them to zero, in place. }
    procedure Init(ASize: longint);

    { Sets the vector from AData, in place; the size becomes @code(Length(AData)).
      No temporary vector is allocated. }
    procedure Init(const AData: TArrayOfT);

    { Returns a new vector of @code(ASize) components, all set to zero. }
    class function New(ASize: longint): TVector; static;

    { Returns a new vector filled from AData; its size is @code(Length(AData)). }
    class function New(const AData: TArrayOfT): TVector; static;

    { Returns the cross product of two 3-component real vectors:
      @code(u×v = (u[1]v[2]-u[2]v[1], u[2]v[0]-u[0]v[2], u[0]v[1]-u[1]v[0]))
      using 0-based indices. Requires @code(N = 3).
    }
    function Cross(const AVector: TVector): TVector;

    { Returns the dot product (inner product) of two real vectors:
      @code(u·v = Σ uᵢ·vᵢ).
    }
    function Dot(const AVector: TVector): T;

    { Returns @true if all components are zero. }
    function IsNull: boolean;

    { Returns @true if at least one component is non-zero. }
    function IsNotNull: boolean;

    { Returns the Euclidean norm (magnitude) of the vector:
      @code(|v| = √(Σ vᵢ²)).
    }
    function Norm: double;
    { Returns the squared Euclidean norm of the vector:
      @code(|v|² = Σ vᵢ²).
    }
    function SquaredNorm: double;

    { Returns the unit vector in the same direction.
      Each component is divided by @link(Norm).
      @raises(EZeroDivide if the vector is null.)
    }
    function Normalize: TVector;
    { Returns the dual (reciprocal) vector: each component @code(vᵢ)
      is divided by the squared norm @code(|v|²).
      @raises(EZeroDivide if the vector is null.)
    }
    function Reciprocal: TVector;

    { Converts the vector to its default string representation. }
    function ToString: string;

    { Management operator: zero-initialises a new vector (empty, size 0). }
    class operator Initialize(var ASelf: TVector);

    { Management operator: releases the dynamic storage when the vector goes out of scope. }
    class operator Finalize(var ASelf: TVector);

    { Management operator: performs a deep copy on assignment, so each vector owns independent storage. }
    class operator Copy(constref ASrc: TVector; var ADst: TVector);

    { Returns @true if all corresponding components of the two vectors are equal. }
    class operator =(const ALeft, ARight: TVector): boolean;

    { Returns @true if the two vectors differ in at least one component. }
    class operator <>(const ALeft, ARight: TVector): boolean;

    { Unary plus. Returns the vector unchanged. }
    class operator +(const ASelf: TVector): TVector;

    { Returns the component-wise sum of two vectors. }
    class operator +(const ALeft, ARight: TVector): TVector;

    { Unary minus. Returns the negation of the vector. }
    class operator -(const ASelf: TVector): TVector;

    { Returns the component-wise difference of two vectors. }
    class operator -(const ALeft, ARight: TVector): TVector;

    { Returns the dot product (inner product) of two vectors:
      @code(u·v = Σ uᵢ·vᵢ).
    }
    class operator *(const ALeft, ARight: TVector): T;

    { Returns the product of a real scalar and a vector. }
    class operator *(const ALeft: T; const ARight: TVector): TVector;

    { Returns the product of a vector and a real scalar. }
    class operator *(const ALeft: TVector; const ARight: T): TVector;

    { Returns the product of a row vector and a square matrix: @code(v' = v·A). }
    class operator *(const ALeft: TVector; const ARight: TMatrix): TVector;

    { Returns the product of a square matrix and a column vector: @code(v' = A·v). }
    class operator *(const ALeft: TMatrix; const ARight: TVector): TVector;

    { Returns the vector divided by a real scalar. }
    class operator /(const ALeft: TVector; const ARight: T): TVector;

    { Returns @code(ALeft) scaled by the dual of @code(ARight):
      each component of the result is @code(ALeft · vᵢ / |v|²).
    }
  //class operator /(const ALeft: T; const ARight: TVector): TVector;

    { Provides access to individual vector components using a 0-based index.
      @code(a[0]) is the first component.
    }
    property a[ARow: longint]: T read Get write Put; default;

    { The dimension @code(N) of the vector. Assigning it resizes the vector. }
    property Order: longint read fOrder;
  end;

  TRMatrix = specialize TMatrix<double>;

  TRMatrixHelper = record helper for TRMatrix
    function IsUnitary: boolean;
  end;

  TCMatrix = specialize TMatrix<TComplex>;

  TCMatrixHelper = record helper for TCMatrix
    function IsUnitary: boolean;
  end;

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


function SquareNorm(AValue: double): double;
function SquareNorm(AValue: TComplex): double;



{ @exclude Internal format routines. }
function Fmt(const AValue: double): string;
{ @exclude }
function Fmt(const AValue: double; APrecision, ADigits: longint): string;

implementation

uses Math, SysUtils;

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

// TMatrix

function TMatrix.Get(ARow, ACol: longint): T;
begin
  result := fm[ARow, ACol];
end;

procedure TMatrix.Put(ARow, ACol: longint; const AValue: T);
begin
  fm[ARow, ACol] := AValue;
end;

function TMatrix.ForwardElimination(out SwapCount: integer): TMatrix; inline;
var
  pivot, ratio: T;
  maxVal: double;
  i, j, k, maxRow: longint;
  rowI, rowJ: TArrayOfT;
begin
  result := Self.Clone;

  SwapCount := 0;
  for i := 0 to fOrder - 1 do
  begin
    // Find the row with the largest absolute value in column i (partial pivoting).
    maxRow := i;
    maxVal := Abs(result.fm[i, i]);
    for j := i + 1 to fOrder - 1 do
      if Abs(result.fm[j, i]) > maxVal then
      begin
        maxVal := Abs(result.fm[j, i]);
        maxRow := j;
      end;

    // Skip column if all entries below the diagonal are negligible (singular/rank-deficient).
    if maxVal < DefaultEpsilon then Continue;

    if maxRow <> i then
    begin
      result.Swap(i, maxRow);
      Inc(SwapCount);
    end;

    rowI  := result.fm[i];
    pivot := rowI[i];

    // Eliminate entries below the pivot in column i.
    for j := i + 1 to fOrder - 1 do
    begin
      if Abs(result.fm[j, i]) < DefaultEpsilon then Continue;
      rowJ       := result.fm[j];
      ratio      := rowJ[i] / pivot;
      rowJ[i]    := 0;
      for k := i + 1 to fOrder - 1 do
        rowJ[k] := rowJ[k] - ratio * rowI[k];
      result.fm[j] := rowJ;
    end;
  end;
end;

function TMatrix.HessenbergReduction: TMatrix;
var
  V: TMatrix;
  k, i, j: longint;
  dot: T;
  rowI: TArrayOfT;
begin
  result := Self.Clone;

  // Apply N-2 Householder reflections H_k = I - 2·v·vᵀ to reduce the matrix
  // to upper Hessenberg form. Each reflection zeroes the subcolumn below the
  // first subdiagonal in column k, while preserving eigenvalues via similarity:
  // H_k · A · H_kᵀ (H_k is symmetric and orthogonal, so H_kᵀ = H_k).
  for k := 0 to fOrder - 3 do
  begin
    V := result.HouseholderVector(k);
    if V.IsNull then Continue;

    // Apply from left: result := (I - 2·V·Vᵀ) · result
    for j := 0 to fOrder - 1 do
    begin
      dot := 0;
      for i := k + 1 to fOrder - 1 do
        dot := dot + V.fm[i, 0] * result.fm[i, j];
      for i := k + 1 to fOrder - 1 do
        result.fm[i, j] := result.fm[i, j] - 2 * V.fm[i, 0] * dot;
    end;

    // Apply from right: result := result · (I - 2·V·Vᵀ)
    for i := 0 to fOrder - 1 do
    begin
      rowI := result.fm[i];
      dot  := 0;
      for j := k + 1 to fOrder - 1 do
        dot := dot + rowI[j] * V.fm[j, 0];
      for j := k + 1 to fOrder - 1 do
        rowI[j] := rowI[j] - 2 * dot * V.fm[j, 0];
      result.fm[i] := rowI;
    end;

    // Explicitly zero entries below the first subdiagonal to suppress
    // floating-point noise that would otherwise accumulate across iterations.
    for i := k + 2 to fOrder - 1 do
      result.fm[i, k] := 0;
  end;
end;

function TMatrix.HouseholderVector(k: longint): TMatrix;
var
  i: longint;
  alpha,
  LNorm,
  LNorm2: double;
begin
  result := Self.Null;

  // Copy the subcolumn below the k-th diagonal entry into column 0 of result.
  for i := k + 1 to fOrder - 1 do
    result.fm[i, 0] := fm[i, k];

  // Compute the Euclidean norm of the subcolumn.
  LNorm := 0;
  for i := k + 1 to fOrder - 1 do
    LNorm := LNorm + SquareNorm(result.fm[i, 0]);
  LNorm := sqrt(LNorm);

  // Subcolumn is already zero; no reflection needed.
  if LNorm < DefaultEpsilon then Exit;

  // Householder vector v = x + sign(x[k+1])·||x||·e1. Choosing the shift sign
  // equal to that of the leading component avoids catastrophic cancellation in
  // v[k+1] when x[k+1] is close to -||x||.
  alpha := result.fm[k + 1, 0];
  if alpha >= 0 then
    result.fm[k + 1, 0] := alpha + LNorm
  else
    result.fm[k + 1, 0] := alpha - LNorm;

  // Normalise v so that v·v = 1, using the analytical identity
  // ||v||² = 2·||x||·(||x|| + |x[k+1]|) to avoid recomputing the full norm.
  LNorm2 := sqrt(2 * LNorm * (LNorm + Abs(alpha)));

  if LNorm2 < DefaultEpsilon then Exit;

  for i := k + 1 to fOrder - 1 do
    result.fm[i, 0] := result.fm[i, 0] / LNorm2;
end;

procedure TMatrix.QRDecompose(out Q, R: TMatrix);
var
  i, j: longint;
  c, s, temp1, temp2, denom: T;
  rowI, rowJ: TArrayOfT;
begin
  // Q accumulates the product of all Givens rotations Gⱼᵀ;
  // at the end Q is orthogonal and R is upper triangular, with A = Q·R.
  Q := Self.Identity;
  R := Self.Clone;

  // A Hessenberg matrix has at most one non-zero subdiagonal entry per column,
  // so only adjacent-row Givens rotations are needed: O(N²) instead of O(N³).
  for j := 0 to fOrder - 2 do
    if Abs(R.fm[j + 1, j]) > DefaultEpsilon then
    begin
      denom := sqrt(sqr(R.fm[j, j]) + sqr(R.fm[j + 1, j]));
      c :=  R.fm[j,     j] / denom;
      s :=  R.fm[j + 1, j] / denom;

      // Apply Givens rotation to R from the left: zero out R[j+1, j].
      rowI := R.fm[j];
      rowJ := R.fm[j + 1];
      for i := j to fOrder - 1 do
      begin
        temp1   :=  c * rowI[i] + s * rowJ[i];
        temp2   := -s * rowI[i] + c * rowJ[i];
        rowI[i] := temp1;
        rowJ[i] := temp2;
      end;
      R.fm[j]     := rowI;
      R.fm[j + 1] := rowJ;

      // Accumulate the transpose rotation into Q from the right.
      for i := 0 to fOrder - 1 do
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

procedure TMatrix.Init(AOrder: longint);
var
  i, j: longint;
begin
  if fOrder <> AOrder then
  begin
    fOrder := AOrder;
    SetLength(fm, fOrder, fOrder);
  end;

  for i := 0 to AOrder -1 do
    for j := 0 to AOrder -1 do
      fm[i, j] := 0;
end;

procedure TMatrix.Init(AOrder: longint; const AData: TArrayOfT);
var
  i, j: longint;
begin
  Assert(Length(AData) = AOrder * AOrder,
    Format('TMatrix.Init: expected %d values, got %d', [AOrder * AOrder, Length(AData)]));

  Init(AOrder);
  for i := 0 to AOrder - 1 do
    for j := 0 to AOrder - 1 do
      fm[i, j] := AData[i * AOrder + j];
end;

procedure TMatrix.Init(const AData: TArrayOfT);
var
  n: longint;
begin
  n := Round(Sqrt(Length(AData)));
  Assert(n * n = Length(AData),
    Format('TMatrix.Init: %d values do not form a square matrix', [Length(AData)]));

  Init(n, AData);
end;

class function TMatrix.New(AOrder: longint): TMatrix; static;
begin
  result.Init(AOrder);
end;

class function TMatrix.New(AOrder: longint; const AData: TArrayOfT): TMatrix; static;
var
  i, j: longint;
begin
  Assert(Length(AData) = AOrder * AOrder,
    Format('TMatrix.New: expected %d values, got %d', [AOrder * AOrder, Length(AData)]));

  result.Init(AOrder);
  for i := 0 to AOrder - 1 do
    for j := 0 to AOrder - 1 do
      result.fm[i, j] := AData[i * AOrder + j];
end;

class function TMatrix.New(const AData: TArrayOfT): TMatrix; static;
var
  n: longint;
begin
  n := Round(Sqrt(Length(AData)));
  Assert(n * n = Length(AData),
    Format('TMatrix.New: %d values do not form a square matrix', [Length(AData)]));

  result.Init(n, AData);
end;

function TMatrix.Identity: TMatrix;
var
  i, j: longint;
begin
  result.Init(fOrder);
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      result.fm[i, j] := Ord(i = j);
end;

function TMatrix.Null: TMatrix;
var
  i, j: longint;
begin
  result.Init(fOrder);
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      result.fm[i, j] := 0;
end;

function TMatrix.Diagonalize(const AEigenValues: TArrayOfT): TMatrix;
var
  i, j: longint;
begin
  result.Init(fOrder);
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      if i = j then
        result.fm[i, i] := AEigenValues[i]
      else
        result.fm[i, j] := 0;
end;

function TMatrix.IsNull: boolean;
var
  i, j: longint;
begin
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      if not SameValueEx(fm[i, j], 0) then Exit(False);
  result := True;
end;

function TMatrix.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TMatrix.SameValue(const AMatrix: TMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      if not SameValueEx(fm[i, j], AMatrix.fm[i, j]) then Exit(False);
  result := True;
end;

function TMatrix.Determinant: T;
var
  U: TMatrix;
  swaps: integer;
  i: longint;
begin
  // det(A) = det(U) · (-1)^swaps, where U is the upper triangular factor
  // from Gaussian elimination and swaps is the number of row interchanges.
  U      := ForwardElimination(swaps);
  result := 1.0;
  for i  := 0 to fOrder - 1 do
    result := result * U.fm[i, i];
  if Odd(swaps) then
    result := -result;
end;

function TMatrix.Norm: double;
var
  i, j: longint;
  sum:  double;
  rowI: TArrayOfT;
begin
  sum := 0;
  for i := 0 to fOrder - 1 do
  begin
    rowI := fm[i];
    for j := 0 to fOrder - 1 do
      sum := sum + SquareNorm(rowI[j]);
  end;
  result := sqrt(sum);
end;

function TMatrix.Rank: longint;
var
  U: TMatrix;
  swaps: integer;
  i: longint;
begin
  // Count non-zero diagonal entries of the upper triangular factor.
  // Each non-zero pivot corresponds to one linearly independent row.
  U      := ForwardElimination(swaps);
  result := 0;
  for i  := 0 to fOrder - 1 do
    if Abs(U.fm[i, i]) > DefaultEpsilon then
      Inc(result);
end;

function TMatrix.Trace: T;
var
  i: longint;
begin
  result := 0;
  for i := 0 to fOrder - 1 do
    result := result + fm[i, i];
end;

function TMatrix.Clone: TMatrix;
var
  i, j: longint;
begin
  result.Init(fOrder);
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      result.fm[i, j] := fm[i, j];
end;

function TMatrix.Transpose: TMatrix;
var
  i, j: longint;
begin
  result.Init(fOrder);
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      result.fm[i, j] := fm[j, i];
end;

function TMatrix.Reciprocal(const ADeterminant: T): TMatrix;
var
  Adj: TMatrix;
  sub: TMatrix;
  i, j,
  ri, ci,
  si, sj: longint;
  sign: double;
begin
  // A singular matrix has no inverse; guard against division by a zero
  // determinant, which would otherwise produce silent Inf/NaN entries.
  if Abs(ADeterminant) < DefaultEpsilon then
    raise EZeroDivide.Create('TRMatrix.Reciprocal: matrix is singular (determinant is zero).');

  result.Init(fOrder);
  Adj.Init(fOrder);

  // sub is only needed for fOrder > 1; for a 1×1 matrix the inverse is 1/a[0,0].
  if fOrder > 1 then
    sub.Init(fOrder - 1);

  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
    begin
      // Build the (N-1)×(N-1) submatrix by deleting row i and column j.
      si := 0;
      for ri := 0 to fOrder - 1 do
      begin
        if ri = i then Continue;
        sj := 0;
        for ci := 0 to fOrder - 1 do
        begin
          if ci = j then Continue;
          sub.fm[si, sj] := fm[ri, ci];
          Inc(sj);
        end;
        Inc(si);
      end;

      // Cofactor: C[i,j] = (-1)^(i+j) · det(submatrix).
      if Odd(i + j) then sign := -1.0 else sign := 1.0;

      // Adjugate is the transpose of the cofactor matrix: Adj[j,i] = C[i,j].
      Adj.fm[j, i] := sign * sub.Determinant;
    end;

  // A⁻¹ = Adj(A) / det(A).
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      result.fm[i, j] := Adj.fm[i, j] / ADeterminant;
end;

function TMatrix.RowReduction: TMatrix;
var
  ratio: T;
  i, j, k, maxRow: longint;
  rowI, rowJ: TArrayOfT;
begin
  result := Self.Clone;

  // Step 1: Forward elimination with partial pivoting.
  // Produces an upper triangular matrix with leading 1s on each pivot row.
  for i := 0 to fOrder - 1 do
  begin
    maxRow := i;
    for j := i + 1 to fOrder - 1 do
      if Abs(result.fm[j, i]) > Abs(result.fm[maxRow, i]) then
        maxRow := j;

    if maxRow <> i then
      result.Swap(i, maxRow);

    if SameValueEx(result.fm[i, i], 0) then Continue;

    rowI := result.fm[i];
    for j := i + 1 to fOrder - 1 do
      rowI[j] := rowI[j] / rowI[i];
    rowI[i]      := 1;
    result.fm[i] := rowI;

    for j := i + 1 to fOrder - 1 do
    begin
      if SameValueEx(result.fm[j, i], 0) then Continue;
      rowJ    := result.fm[j];
      ratio   := rowJ[i];
      rowJ[i] := 0;
      for k := i + 1 to fOrder - 1 do
        rowJ[k] := rowJ[k] - ratio * rowI[k];
      result.fm[j] := rowJ;
    end;
  end;

  // Step 2: Back-substitution.
  // Eliminates entries above each pivot, completing the reduced row echelon form.
  for i := fOrder - 1 downto 0 do
  begin
    if SameValueEx(result.fm[i, i], 0) then Continue;
    rowI := result.fm[i];
    for j := i - 1 downto 0 do
    begin
      rowJ    := result.fm[j];
      ratio   := rowJ[i];
      rowJ[i] := 0;
      // Start from i+1: rowJ[i] has already been zeroed explicitly above.
      for k := i + 1 to fOrder - 1 do
        rowJ[k] := rowJ[k] - ratio * rowI[k];
      result.fm[j] := rowJ;
    end;
  end;
end;

function TMatrix.Eigenvalues: TArrayOfT;
var
  H: TMatrix;
  Q, R: TMatrix;
  i, iter,
  idx: longint;
  shift,
  subA, subB,
  subD,
  delta, denom: T;
  converged: boolean;
const
  MaxIter = 1000;
begin
  SetLength(result, fOrder);

  // Trivial case: a 1×1 matrix has a single eigenvalue equal to its only element.
  if fOrder = 1 then
  begin
    result[0] := fm[0, 0];
    Exit;
  end;

  // Reduce to upper Hessenberg form first. This preserves eigenvalues and
  // reduces each QR iteration from O(N³) to O(N²).
  H   := Self.HessenbergReduction;
  idx := fOrder - 1;

  // Deflating QR iteration with Wilkinson shift.
  while idx > 0 do
  begin
    converged := False;
    for iter := 1 to MaxIter do
    begin
      // Wilkinson shift: the eigenvalue of the trailing 2×2 block
      //   [ subA  subB ]
      //   [ subB  subD ]
      // closest to subD. Unlike the bare Rayleigh shift subD, this breaks the
      // symmetry of matrices with a (near-)constant or zero diagonal, for which
      // the unshifted iteration never converges.
      subA  := H.fm[idx - 1, idx - 1];
      subB  := H.fm[idx,     idx - 1];
      subD  := H.fm[idx,     idx];
      delta := (subA - subD) * 0.5;
      denom := Abs(delta) + sqrt(sqr(delta) + sqr(subB));
      if denom < DefaultEpsilon then
        shift := subD
      else if delta >= 0 then
        shift := subD - sqr(subB) / denom
      else
        shift := subD + sqr(subB) / denom;

      // Apply the shift, perform one QR step, then restore the shift.
      for i := 0 to idx do
        H.fm[i, i] := H.fm[i, i] - shift;

      H.QRDecompose(Q, R);
      H := R * Q;

      for i := 0 to idx do
        H.fm[i, i] := H.fm[i, i] + shift;

      // Deflate when the subdiagonal entry is negligible.
      if Abs(H.fm[idx, idx - 1]) < DefaultEpsilon then
      begin
        result[idx] := H.fm[idx, idx];
        Dec(idx);
        converged := True;
        Break;
      end;
    end;

    // No convergence after MaxIter steps: record the best available approximation
    // and deflate anyway to avoid an infinite loop.
    if not converged then
    begin
      // A trailing 2x2 block that never deflates corresponds to a complex
      // conjugate eigenvalue pair, which a real-shift QR iteration cannot
      // isolate and which a real result array cannot represent.
      if sqr(H.fm[idx - 1, idx - 1] - H.fm[idx, idx]) + 4 * H.fm[idx - 1, idx] * H.fm[idx, idx - 1] < 0 then
        raise Exception.Create('TRMatrix.Eigenvalues: matrix has complex eigenvalues, which are not supported.');

      result[idx] := H.fm[idx, idx];
      Dec(idx);
    end;
  end;
  result[0] := H.fm[0, 0];
end;
procedure TRMatrix.Swap(ARow1, ARow2: longint);
var
  tmp: array of double;
begin
  // Row swap via reference exchange: O(1), no element copying.
  tmp       := fm[ARow1];
  fm[ARow1] := fm[ARow2];
  fm[ARow2] := tmp;
end;
function TRMatrix.ToString: string;
var
  i, j: longint;
  rows: array of string;
begin
  SetLength(rows, fOrder);
  for i := 0 to fOrder - 1 do
  begin
    rows[i] := '(';
    for j := 0 to fOrder - 1 do
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
  SetLength(rows, fOrder);
  for i := 0 to fOrder - 1 do
  begin
    rows[i] := '(';
    for j := 0 to fOrder - 1 do
    begin
      if j > 0 then rows[i] := rows[i] + ', ';
      rows[i] := rows[i] + FloatToStrF(fm[i, j], ffGeneral, APrecision, ADigits);
    end;
    rows[i] := rows[i] + ')';
  end;
  result := '(' + string.Join(', ', rows) + ')';
end;
class operator TRMatrix.Initialize(var ASelf: TRMatrix);
begin
  ASelf.fm    := nil;
  ASelf.fOrder := 0;
end;
class operator TRMatrix.Finalize(var ASelf: TRMatrix);
begin
  SetLength(ASelf.fm, 0, 0);
end;
class operator TRMatrix.Copy(constref ASrc: TRMatrix; var ADst: TRMatrix);
var
  i, j: longint;
begin
  ADst.fOrder := ASrc.fOrder;
  SetLength(ADst.fm, ASrc.fOrder, ASrc.fOrder);
  for i := 0 to ASrc.fOrder - 1 do
    for j := 0 to ASrc.fOrder - 1 do
      ADst.fm[i, j] := ASrc.fm[i, j];
end;
class operator TRMatrix.=(const ALeft, ARight: TRMatrix): boolean;
var
  i, j: longint;
begin
  if ALeft.fOrder <> ARight.fOrder then Exit(False);

  for i := 0 to ALeft.fOrder -1 do
    for j := 0 to ALeft.fOrder -1 do
      if ALeft.fm[i, j] <> ARight.fm[i, j] then Exit(False);
  result := True;
end;
class operator TRMatrix.<>(const ALeft, ARight: TRMatrix): boolean;
var
  i, j: longint;
begin
  if ALeft.fOrder <> ARight.fOrder then Exit(True);

  for i := 0 to ALeft.fOrder - 1 do
    for j := 0 to ALeft.fOrder - 1 do
      if ALeft.fm[i, j] <> ARight.fm[i, j] then Exit(True);
  result := False;
end;
class operator TRMatrix.+(const ALeft, ARight: TRMatrix): TRMatrix;
var
  i, j: longint;
begin
  Assert(ALeft.fOrder = ARight.fOrder, Format('TRMatrix.+: size mismatch (%d <> %d)', [ALeft.fOrder, ARight.fOrder]));

  result.Init(ALeft.fOrder);
  for i := 0 to ALeft.fOrder -1 do
    for j := 0 to ALeft.fOrder -1 do
      result.fm[i, j] := ALeft.fm[i, j] + ARight.fm[i, j];
end;
class operator TRMatrix.-(const ALeft, ARight: TRMatrix): TRMatrix;
var
  i, j: longint;
begin
  Assert(ALeft.fOrder = ARight.fOrder, Format('TRMatrix.-: size mismatch (%d <> %d)', [ALeft.fOrder, ARight.fOrder]));

  result.Init(ALeft.fOrder);
  for i := 0 to ALeft.fOrder -1 do
    for j := 0 to ALeft.fOrder -1 do
      result.fm[i, j] := ALeft.fm[i, j] - ARight.fm[i, j];
end;
class operator TRMatrix.*(const ALeft, ARight: TRMatrix): TRMatrix;
var
  i, j, k: longint;
  row: array of double;
begin
  Assert(ALeft.fOrder = ARight.fOrder, Format('TRMatrix.*: size mismatch (%d <> %d)', [ALeft.fOrder, ARight.fOrder]));

  result.Init(ALeft.fOrder);
  for i := 0 to ALeft.fOrder -1 do
  begin
    row := ALeft.fm[i];
    for j := 0 to ALeft.fOrder -1 do
    begin
      result.fm[i, j] := 0;
      for k := 0 to ALeft.fOrder -1 do
        result.fm[i, j] := result.fm[i, j] + row[k] * ARight.fm[k, j];
    end;
  end;
end;
class operator TRMatrix.*(const ALeft: double; const ARight: TRMatrix): TRMatrix;
var
  i, j: longint;
begin
  result.Init(ARight.fOrder);
  for i := 0 to ARight.fOrder -1 do
    for j := 0 to ARight.fOrder -1 do
      result.fm[i, j] := ALeft * ARight.fm[i, j];
end;
class operator TRMatrix.*(const ALeft: TRMatrix; const ARight: double): TRMatrix;
var
  i, j: longint;
begin
  result.Init(ALeft.fOrder);
  for i := 0 to ALeft.fOrder -1 do
    for j := 0 to ALeft.fOrder -1 do
      result.fm[i, j] := ALeft.fm[i, j] * ARight;
end;
class operator TRMatrix./(const ALeft: TRMatrix; const ARight: double): TRMatrix;
var
  i, j: longint;
begin
  result.Init(ALeft.fOrder);
  for i := 0 to ALeft.fOrder -1 do
    for j := 0 to ALeft.fOrder -1 do
      result.fm[i, j] := ALeft.fm[i, j] / ARight;
end;

function TRVector.Get(ARow: longint): double;
begin
  result := fm[ARow];
end;
procedure TRVector.Put(ARow: longint; AValue: double);
begin
  fm[ARow] := AValue;
end;

// TRMatrixHelper

function TRMatrixHelper.IsUnitary: boolean;
begin
  result := Identity.SameValue(Transpose * Self);
end;

// TCMatrixHelper

function TCMatrixHelper.IsUnitary: boolean;
begin
  result := Identity.SameValue(TransposeConjugate * Self);
end;

// TRVector

procedure TRVector.Init(ASize: longint);
var
  i: longint;
begin
  if fOrder <> ASize then
  begin
    fOrder := ASize;
    SetLength(fm, fOrder);
  end;
  for i := 0 to fOrder - 1 do
    fm[i] := 0;
end;

procedure TRVector.Init(const AData: array of double);
var
  i: longint;
begin
  if fOrder <> Length(AData) then
  begin
    fOrder := Length(AData);
    SetLength(fm, fOrder);
  end;
  for i := 0 to fOrder - 1 do
    fm[i] := AData[i];
end;

class function TRVector.New(ASize: longint): TRVector; static;
begin
  result.Init(ASize);
end;

class function TRVector.New(const AData: array of double): TRVector; static;
begin
  result.Init(AData);
end;
function TRVector.Cross(const AVector: TRVector): TRVector;
begin
  Assert(Self.fOrder = 3, Format('TRVector.Cross: Size must be 3, got %d.', [Self.fOrder]));
  Assert(AVector.fOrder = 3, Format('TRVector.Cross: AVector.Size must be 3, got %d.', [AVector.fOrder]));

  result.Init(3);
  result.fm[0] := fm[1]*AVector.fm[2] - fm[2]*AVector.fm[1];
  result.fm[1] := fm[2]*AVector.fm[0] - fm[0]*AVector.fm[2];
  result.fm[2] := fm[0]*AVector.fm[1] - fm[1]*AVector.fm[0];
end;
function TRVector.Dot(const AVector: TRVector): double;
var
  i: longint;
begin
  Assert(fOrder = AVector.fOrder, Format('TRVector.Dot: size mismatch (%d <> %d)', [fOrder, AVector.fOrder]));

  result := 0;
  for i := 0 to fOrder -1 do
    result := result + fm[i] * AVector.fm[i];
end;
function TRVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 0 to fOrder - 1 do
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
function TRVector.SquaredNorm: double;
var
  i: longint;
begin
  result := 0;
  for i := 0 to fOrder -1 do
    result := result + sqr(fm[i]);
end;
function TRVector.Normalize: TRVector;
var
  i:     longint;
  LNorm: double;
begin
  LNorm := Norm;
  if LNorm < DefaultEpsilon then
    raise EZeroDivide.Create('TRVector.Normalize: cannot normalise a null vector.');

  result.Init(fOrder);
  for i := 0 to fOrder - 1 do
    result.fm[i] := fm[i] / LNorm;
end;
function TRVector.Reciprocal: TRVector;
var
  i:           longint;
  LSquareNorm: double;
begin
  LSquareNorm := SquaredNorm;
  if LSquareNorm < DefaultEpsilon then
    raise EZeroDivide.Create('TRVector.Reciprocal: cannot invert a null vector.');

  result.Init(fOrder);
  for i := 0 to fOrder - 1 do
    result.fm[i] := fm[i] / LSquareNorm;
end;
function TRVector.ToString: string;
var
  i: longint;
begin
  result := '';
  for i := 0 to fOrder - 1 do
    result := result + FloatToStr(fm[i]) + ',';

  // Remove the trailing comma before wrapping in parentheses.
  // Max(0, ...) guards against the empty-vector case (fOrder = 0).
  i := Length(result);
  SetLength(result, Max(0, i - 1));
  result := '(' + result + ')';
end;
class operator TRVector.Initialize(var ASelf: TRVector);
begin
  ASelf.fm    := nil;
  ASelf.fOrder := 0;
end;
class operator TRVector.Finalize(var ASelf: TRVector);
begin
  SetLength(ASelf.fm, 0);
end;
class operator TRVector.Copy(constref ASrc: TRVector; var ADst: TRVector);
begin
  // System.Copy on a 1D dynamic array produces a full independent copy.
  ADst.fOrder := ASrc.fOrder;
  ADst.fm    := System.Copy(ASrc.fm);
end;
class operator TRVector.=(const ALeft, ARight: TRVector): boolean;
var
  i: longint;
begin
  if ALeft.fOrder <> ARight.fOrder then Exit(False);

  for i := 0 to ALeft.fOrder - 1 do
    if ALeft.fm[i] <> ARight.fm[i] then Exit(False);
  result := True;
end;
class operator TRVector.<>(const ALeft, ARight: TRVector): boolean;
var
  i: longint;
begin
  if ALeft.fOrder <> ARight.fOrder then Exit(True);

  for i := 0 to ALeft.fOrder - 1 do
    if ALeft.fm[i] <> ARight.fm[i] then Exit(True);
  result := False;
end;
class operator TRVector.+(const ASelf: TRVector): TRVector;
begin
  result := ASelf;
end;
class operator TRVector.+(const ALeft, ARight: TRVector): TRVector;
var
  i: longint;
begin
  Assert(ALeft.fOrder = ARight.fOrder, Format('TRVector.+: size mismatch (%d <> %d)', [ALeft.fOrder, ARight.fOrder]));

  result.Init(ALeft.fOrder);
  for i := 0 to ALeft.fOrder -1 do
    result.fm[i] := ALeft.fm[i] + ARight.fm[i];
end;
class operator TRVector.-(const ASelf: TRVector): TRVector;
var
  i: longint;
begin
  result.Init(ASelf.fOrder);
  for i := 0 to ASelf.fOrder -1 do
    result.fm[i] := -ASelf.fm[i];
end;
class operator TRVector.-(const ALeft, ARight: TRVector): TRVector;
var
  i: longint;
begin
  Assert(ALeft.fOrder = ARight.fOrder, Format('TRVector.-: size mismatch (%d <> %d)', [ALeft.fOrder, ARight.fOrder]));

  result.Init(ALeft.fOrder);
  for i := 0 to ALeft.fOrder -1 do
    result.fm[i] := ALeft.fm[i] - ARight.fm[i];
end;
class operator TRVector.*(const ALeft, ARight: TRVector): double;
var
  i: longint;
begin
  Assert(ALeft.fOrder = ARight.fOrder, Format('TRVector.*: size mismatch (%d <> %d)', [ALeft.fOrder, ARight.fOrder]));

  result := 0;
  for i := 0 to ALeft.fOrder -1 do
    result := result + ALeft.fm[i] * ARight.fm[i];
end;
class operator TRVector.*(const ALeft: double; const ARight: TRVector): TRVector;
var
  i: longint;
begin
  result.Init(ARight.fOrder);
  for i := 0 to ARight.fOrder -1 do
    result.fm[i] := ALeft * ARight.fm[i];
end;
class operator TRVector.*(const ALeft: TRVector; const ARight: double): TRVector;
var
  i: longint;
begin
  result.Init(ALeft.fOrder);
  for i := 0 to ALeft.fOrder - 1 do
    result.fm[i] := ALeft.fm[i] * ARight;
end;
class operator TRVector.*(const ALeft: TRVector; const ARight: TRMatrix): TRVector;
var
  i, j: longint;
begin
  Assert(ALeft.fOrder = ARight.fOrder, Format('TRVector.*: size mismatch (%d <> %d)', [ALeft.fOrder, ARight.fOrder]));

  // v·A: treat ALeft as a row vector (1×N) and accumulate column-wise.
  result.Init(ALeft.fOrder);
  for i := 0 to ALeft.fOrder -1 do
  begin
    result.fm[i] := 0;
    for j := 0 to ALeft.fOrder -1 do
      result.fm[i] := result.fm[i] + ALeft.fm[j] * ARight.fm[j, i];
  end;
end;
class operator TRVector.*(const ALeft: TRMatrix; const ARight: TRVector): TRVector;
var
  i, j: longint;
  row: array of double;
begin
  Assert(ALeft.fOrder = ARight.fOrder, Format('TRVector.*: size mismatch (%d <> %d)', [ALeft.fOrder, ARight.fOrder]));

  // A·v: treat ARight as a column vector (N×1); cache each row of A for
  // sequential memory access in the inner loop.
  result.Init(ARight.fOrder);
  for i := 0 to ARight.fOrder -1 do
  begin
    row := ALeft.fm[i];
    result.fm[i] := 0;
    for j := 0 to ARight.fOrder -1 do
      result.fm[i] := result.fm[i] + row[j] * ARight.fm[j];
  end;
end;
class operator TRVector./(const ALeft: TRVector; const ARight: double): TRVector;
var
  i: longint;
begin
  result.Init(ALeft.fOrder);
  for i := 0 to ALeft.fOrder - 1 do
    result.fm[i] := ALeft.fm[i] / ARight;
end;
class operator TRVector./(const ALeft: double; const ARight: TRVector): TRVector;
var
  i: longint;
begin
  result := ARight.Reciprocal;
  for i  := 0 to ARight.fOrder - 1 do
    result.fm[i] := ALeft * result.fm[i];
end;

// Standalone functions

function Abs(const AValue: double): double;
begin
  result := System.Abs(AValue);
end;
function SameValueEx(const AValue1, AValue2: double): boolean;
begin
  result := Math.SameValue(AValue1, AValue2, DefaultEpsilon);
end;
function SolveEquation(const a: double): double;
begin
  result := -a;
end;
end.
