unit ADimR;

{$H+}{$J-}
{$modeswitch advancedrecords}

interface

uses
  ADimCommon;

type
  { Dynamic array of @code(double) values. }
  TArrayOfDouble = array of double;

  { Generic square matrix of real values (@code(double)) with dimension
    @code(TSpace.N × TSpace.N), where @code(N) is determined at compile time.

    Matrix elements are stored in a dynamic 0-based 2D array allocated
    automatically via the @code(Initialize) operator.
    Use the default array property @code(a[row, col]) to read and write
    individual elements using 0-based indices.
    Concrete types are provided as @link(TR2Matrix), @link(TR3Matrix),
    and @link(TR4Matrix).
  }
  generic TRMatrix<TSpace> = record
  private
    fm: array of array of double;

    { Reads the element at position (@code(ARow), @code(ACol)). }
    function Get(ARow, ACol: longint): double;

    { Writes the element at position (@code(ARow), @code(ACol)). }
    procedure Put(ARow, ACol: longint; const AValue: double);

    { Performs forward Gaussian elimination with partial pivoting.
      Used internally by @link(Determinant) and @link(RowReduction).
      @param(SwapCount Number of row swaps performed, used to determine
      the sign of the determinant.)
      @return(Upper triangular matrix after elimination.)
    }
    function ForwardElimination(out SwapCount: integer): TRMatrix; inline;

    { Reduces the matrix to upper Hessenberg form using Householder reflections.
      Used internally by @link(Eigenvalues).
      @return(Upper Hessenberg matrix similar to Self, with same eigenvalues.)
    }
    function HessenbergReduction: TRMatrix;

    { Computes the Householder reflection vector for column @code(k).
      Used internally by @link(HessenbergReduction).
      @param(k Column index, 0-based.)
      @return(Normalized Householder vector stored in column 0.)
    }
    function HouseholderVector(k: longint): TRMatrix;

    { Decomposes the Hessenberg matrix into Q·R using Givens rotations.
      Optimized for Hessenberg matrices: @code(O(N²)) instead of @code(O(N³)).
      Used internally by @link(Eigenvalues).
      @param(Q Orthogonal matrix.)
      @param(R Upper triangular matrix.)
    }
    procedure QRDecompose(out Q, R: TRMatrix);

  public
    { Returns a deep copy of the matrix.
      Required because dynamic array assignment copies only the reference.
    }
    function Clone: TRMatrix;

    { Returns the determinant of the matrix using Gaussian elimination
      with partial pivoting (LU decomposition).
      Precision is equivalent to closed-form formulas for well-conditioned
      matrices. Both methods are subject to standard IEEE 754 rounding.
    }
    function Determinant: double;

    { Returns the diagonal matrix built from the given eigenvalues.
      Element @code(D[i,i] = AEigenValues[i]) and all off-diagonal elements are zero.
      @param(AEigenValues 0-based dynamic array of @code(TSpace.N) real eigenvalues,
      typically computed via @link(Eigenvalues).)
    }
    function Diagonalize(const AEigenValues: TArrayOfDouble): TRMatrix;

    { Returns the eigenvalues of the matrix as a dynamic array of @code(double).
      Uses the QR algorithm with Hessenberg reduction and Wilkinson shift.
      Convergence is typically cubic with Wilkinson shift.
      @return(0-based dynamic array of @code(TSpace.N) real eigenvalues,
      not guaranteed to be sorted.)
    }
    function Eigenvalues: TArrayOfDouble;

    { Returns the @code(N × N) identity matrix with ones on the diagonal
      and zeros elsewhere.
    }
    class function Identity: TRMatrix; static;

    { Returns @true if all elements of the matrix are zero. }
    function IsNull: boolean;

    { Returns @true if at least one element of the matrix is non-zero. }
    function IsNotNull: boolean;

    { Returns @true if the matrix satisfies @code(A·Aᵀ = I). }
    function IsUnitary: boolean;

    { Returns the Frobenius norm of the matrix:
      @code(‖A‖_F = √(Σ|a[i,j]|²)).
    }
    function Norm: double;

    { Returns the @code(N × N) null matrix with all elements equal to zero. }
    class function Null: TRMatrix; static;

    { Returns the number of linearly independent rows or columns. }
    function Rank: longint;

    { Returns the inverse of the matrix given its precomputed determinant.
      Uses the adjugate (cofactor transpose) method.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    }
    function Reciprocal(const ADeterminant: double): TRMatrix;

    { Returns the row-reduced echelon form of the matrix using Gaussian
      elimination with partial pivoting. The original matrix is not modified.
    }
    function RowReduction: TRMatrix;

    { Returns @true if two matrices are equal within the default floating
      point tolerance @link(DefaultEpsilon).
    }
    function SameValue(const AMatrix: TRMatrix): boolean;

    { Swaps rows @code(ARow1) and @code(ARow2) in place. Indices are 0-based. }
    procedure Swap(ARow1, ARow2: longint);

    { Returns the trace of the matrix, i.e. the sum of diagonal elements:
      @code(tr(A) = Σ A[i,i]).
    }
    function Trace: double;

    { Converts the matrix to its default string representation. }
    function ToString: string;

    { Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Returns the transpose of the matrix.
      Element @code([i,j]) of the result equals element @code([j,i]) of the original.
    }
    function Transpose: TRMatrix;

    { Allocates the @code(N × N) dynamic array. Called automatically before first use. }
    class operator Initialize(var ASelf: TRMatrix);

    { Releases the dynamic array. Called automatically when the record goes out of scope. }
    class operator Finalize(var ASelf: TRMatrix);

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

    { Returns the product of a real scalar and a matrix.
      Each element is multiplied by @code(ALeft).
    }
    class operator *(const ALeft: double; const ARight: TRMatrix): TRMatrix;

    { Returns the product of a matrix and a real scalar.
      Each element is multiplied by @code(ARight).
    }
    class operator *(const ALeft: TRMatrix; const ARight: double): TRMatrix;

    { Returns the matrix divided by a real scalar.
      Each element is divided by @code(ARight).
    }
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

  { Generic column vector of real values (@code(double)) with @code(TSpace.N) components.

    Components are stored in a dynamic 0-based array allocated automatically
    via the @code(Initialize) operator.
    Use the default array property @code(a[row]) to read and write individual
    components using 0-based indices.
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
    { Returns @true if all components are zero. }
    function IsNull: boolean;

    { Returns @true if at least one component is non-zero. }
    function IsNotNull: boolean;

    { Returns the Euclidean norm (magnitude) of the vector:
      @code(|v| = √(Σ vᵢ²)).
    }
    function Norm: double;

    { Returns the unit vector in the same direction.
      Each component is divided by @link(Norm).
    }
    function Normalize: TRVector;

    { Returns the dual (reciprocal) vector: each component @code(vᵢ)
      is divided by the squared norm @code(|v|²).
    }
    function Reciprocal: TRVector;

    { Returns the squared Euclidean norm of the vector:
      @code(|v|² = Σ vᵢ²). Avoids the square root of @link(Norm).
    }
    function SquaredNorm: double;

    { Allocates the dynamic array. Called automatically before first use. }
    class operator Initialize(var ASelf: TRVector);

    { Releases the dynamic array. Called automatically when the record goes out of scope. }
    class operator Finalize(var ASelf: TRVector);

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

    { Returns the dot product (inner product) of two vectors:
      @code(u·v = Σ uᵢ·vᵢ).
    }
    class operator *(const ALeft, ARight: TRVector): double;

    { Returns the product of a real scalar and a vector.
      Each component is multiplied by @code(ALeft).
    }
    class operator *(const ALeft: double; const ARight: TRVector): TRVector;

    { Returns the product of a vector and a real scalar.
      Each component is multiplied by @code(ARight).
    }
    class operator *(const ALeft: TRVector; const ARight: double): TRVector;

    { Returns the product of a row vector and a square matrix: @code(v' = v·A).
      The result is a row vector.
    }
    class operator *(const ALeft: TRVector; const ARight: TRMatrix): TRVector;

    { Returns the product of a square matrix and a column vector: @code(v' = A·v).
      The result is a column vector.
    }
    class operator *(const ALeft: TRMatrix; const ARight: TRVector): TRVector;

    { Returns the vector divided by a real scalar.
      Each component is divided by @code(ARight).
    }
    class operator /(const ALeft: TRVector; const ARight: double): TRVector;

    { Returns @code(ALeft) scaled by the dual of @code(ARight):
      each component of the result is @code(ALeft · vᵢ / |v|²).
    }
    class operator /(const ALeft: double; const ARight: TRVector): TRVector;

  public
    { Provides access to individual vector components using a 0-based index.
      @code(a[0]) is the first component.
    }
    property a[ARow: longint]: double read Get write Put; default;
  end;

  { 2-component real vector. Specialization of @link(TRVector) for @link(T2DSpace). }
  TR2Vector = specialize TRVector<T2DSpace>;

  { 3-component real vector. Specialization of @link(TRVector) for @link(T3DSpace). }
  TR3Vector = specialize TRVector<T3DSpace>;

  { 4-component real vector. Specialization of @link(TRVector) for @link(T4DSpace). }
  TR4Vector = specialize TRVector<T4DSpace>;

  { Record helper for @link(TR3Vector) providing the cross product operation,
    which is defined only for 3-component vectors.
  }
  TR3VectorHelper = record helper for TR3Vector
    { Returns the cross product of two 3-component real vectors:
      @code(u×v = (u[1]v[2]-u[2]v[1], u[2]v[0]-u[0]v[2], u[0]v[1]-u[1]v[0]))
      using 0-based indices.
    }
    function Cross(const AVector: TR3Vector): TR3Vector;
  end;

{ Returns the absolute value of a real number. }
function Abs(const AValue: double): double;

{ Returns @true if two real numbers are equal within @link(DefaultEpsilon). }
function SameValueEx(const AValue1, AValue2: double): boolean;

{ Solves @code(a·x = 0) over the real numbers. Returns @code(-a). }
function SolveEquation(const a: double): double;

{ Returns the exact determinant of a 2×2 real matrix:
  @code(det = a[0,0]·a[1,1] - a[0,1]·a[1,0]).
}
function Determinant(const M: TR2Matrix): double;

{ Returns the exact determinant of a 3×3 real matrix using Sarrus' rule. }
function Determinant(const M: TR3Matrix): double;

{ Returns the exact determinant of a 4×4 real matrix using Laplace expansion. }
function Determinant(const M: TR4Matrix): double;

{ Returns the exact inverse of a 2×2 real matrix given its precomputed determinant. }
function Reciprocal(const M: TR2Matrix; const ADeterminant: double): TR2Matrix;

{ Returns the exact inverse of a 3×3 real matrix given its precomputed determinant. }
function Reciprocal(const M: TR3Matrix; const ADeterminant: double): TR3Matrix;

{ Returns the exact inverse of a 4×4 real matrix given its precomputed determinant. }
function Reciprocal(const M: TR4Matrix; const ADeterminant: double): TR4Matrix;

{ Returns a 2-component real vector with components @code([m0, m1]) (0-based). }
function Vector(const m0, m1: double): TR2Vector;

{ Returns a 3-component real vector with components @code([m0, m1, m2]) (0-based). }
function Vector(const m0, m1, m2: double): TR3Vector;

{ Returns a 4-component real vector with components @code([m0, m1, m2, m3]) (0-based). }
function Vector(const m0, m1, m2, m3: double): TR4Vector;

{ Returns a 2×2 real matrix. Parameters are in row-major order, 0-based:
  @code(m00, m01) for row 0; @code(m10, m11) for row 1.
}
function Matrix(const m00, m01,
                      m10, m11: double): TR2Matrix;

{ Returns a 3×3 real matrix. Parameters are in row-major order, 0-based. }
function Matrix(const m00, m01, m02,
                      m10, m11, m12,
                      m20, m21, m22: double): TR3Matrix;

{ Returns a 4×4 real matrix. Parameters are in row-major order, 0-based. }
function Matrix(const m00, m01, m02, m03,
                      m10, m11, m12, m13,
                      m20, m21, m22, m23,
                      m30, m31, m32, m33: double): TR4Matrix;

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

// TRMatrix

function TRMatrix.Get(ARow, ACol: longint): double;
begin
  result := fm[ARow, ACol];
end;

procedure TRMatrix.Put(ARow, ACol: longint; const AValue: double);
begin
  fm[ARow, ACol] := AValue;
end;

function TRMatrix.ForwardElimination(out SwapCount: integer): TRMatrix;
var
  pivot, ratio,
  maxVal:     double;
  i, j, k,
  maxRow:     longint;
  rowI, rowJ: array of double;
begin
  result    := Self.Clone;
  SwapCount := 0;

  for i := 0 to TSpace.N - 1 do
  begin
    // Partial pivot search
    maxRow := i;
    maxVal := Abs(result.fm[i, i]);
    for j := i + 1 to TSpace.N - 1 do
      if Abs(result.fm[j, i]) > maxVal then
      begin
        maxVal := Abs(result.fm[j, i]);
        maxRow := j;
      end;

    if maxVal < DefaultEpsilon then Continue;

    if maxRow <> i then
    begin
      result.Swap(i, maxRow);
      Inc(SwapCount);
    end;

    // Cache pivot row to avoid repeated double-indexing
    rowI  := result.fm[i];
    pivot := rowI[i];

    for j := i + 1 to TSpace.N - 1 do
    begin
      if Abs(result.fm[j, i]) < DefaultEpsilon then Continue;
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
  i:      longint;
  LNorm,
  LNorm2: double;
begin
  result := TRMatrix.Null;

  for i := k + 1 to TSpace.N - 1 do
    result.fm[i, 0] := fm[i, k];

  LNorm := 0;
  for i := k + 1 to TSpace.N - 1 do
    LNorm := LNorm + sqr(result.fm[i, 0]);
  LNorm := sqrt(LNorm);

  if LNorm < DefaultEpsilon then Exit;

  result.fm[k + 1, 0] := result.fm[k + 1, 0] + LNorm;

  // Avoid recomputing norm via analytical update: norm2² = 2·norm·v[k+1]
  LNorm2 := sqrt(2 * LNorm * result.fm[k + 1, 0]);

  if LNorm2 < DefaultEpsilon then Exit;

  for i := k + 1 to TSpace.N - 1 do
    result.fm[i, 0] := result.fm[i, 0] / LNorm2;
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

    // Apply from left: result := (I - 2·V·Vᵀ) · result
    for j := 0 to TSpace.N - 1 do
    begin
      dot := 0;
      for i := k + 1 to TSpace.N - 1 do
        dot := dot + V.fm[i, 0] * result.fm[i, j];
      for i := k + 1 to TSpace.N - 1 do
        result.fm[i, j] := result.fm[i, j] - 2 * V.fm[i, 0] * dot;
    end;

    // Apply from right: result := result · (I - 2·V·Vᵀ)
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

    // Explicitly zero below first subdiagonal for numerical stability
    for i := k + 2 to TSpace.N - 1 do
      result.fm[i, k] := 0;
  end;
end;

procedure TRMatrix.QRDecompose(out Q, R: TRMatrix);
var
  i, j:       longint;
  c, s,
  temp1,
  temp2,
  denom:      double;
  rowI, rowJ: array of double;
begin
  Q := TRMatrix.Identity;
  R := Self.Clone;

  for j := 0 to TSpace.N - 2 do
    if Abs(R.fm[j + 1, j]) > DefaultEpsilon then
    begin
      // denom is real positive: √(r_jj² + r_j+1,j²)
      denom := sqrt(sqr(R.fm[j, j]) + sqr(R.fm[j + 1, j]));
      c :=  R.fm[j,     j] / denom;
      s :=  R.fm[j + 1, j] / denom;

      // Apply Givens rotation to R from left
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

      // Apply Givens rotation to Q from right
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

function TRMatrix.Clone: TRMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := fm[i, j];
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

function TRMatrix.Diagonalize(const AEigenValues: TArrayOfDouble): TRMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if i = j then
        result.fm[i, i] := AEigenValues[i]
      else
        result.fm[i, j] := 0;
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

      if Abs(H.fm[n, n - 1]) < DefaultEpsilon then
      begin
        result[n] := H.fm[n, n];
        Dec(n);
        converged := True;
        Break;
      end;
    end;

    // No convergence: take best available value and deflate
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
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := Ord(i = j);
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

function TRMatrix.IsUnitary: boolean;
begin
  result := TRMatrix.Identity.SameValue(Self.Transpose * Self);
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

class function TRMatrix.Null: TRMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := 0;
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
    if Abs(U.fm[i, i]) > DefaultEpsilon then
      Inc(result);
end;

function TRMatrix.Reciprocal(const ADeterminant: double): TRMatrix;
var
  Adj:    TRMatrix;
  sub:    TRMatrix;
  i, j,
  ri, ci,
  si, sj: longint;
  sign:   double;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
    begin
      // Build (N-1)×(N-1) submatrix by deleting row i and column j
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

      // Cofactor C[i,j] = (-1)^(i+j) * det(sub)
      if Odd(i + j) then sign := -1.0 else sign := 1.0;

      // Adjugate is transpose of cofactor matrix: Adj[j,i] = C[i,j]
      Adj.fm[j, i] := sign * sub.Determinant;
    end;

  // Inverse = Adj / det(A)
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := Adj.fm[i, j] / ADeterminant;
end;

function TRMatrix.RowReduction: TRMatrix;
var
  ratio:      double;
  i, j, k,
  maxRow:     longint;
  rowI, rowJ: array of double;
begin
  result := Self.Clone;

  // Step 1: Forward elimination with partial pivoting
  for i := 0 to TSpace.N - 1 do
  begin
    maxRow := i;
    for j := i + 1 to TSpace.N - 1 do
      if Abs(result.fm[j, i]) > Abs(result.fm[maxRow, i]) then
        maxRow := j;

    if maxRow <> i then
      result.Swap(i, maxRow);

    if SameValueEx(result.fm[i, i], 0) then Continue;

    rowI := result.fm[i];
    for j := i + 1 to TSpace.N - 1 do
      rowI[j] := rowI[j] / rowI[i];
    rowI[i]      := 1;
    result.fm[i] := rowI;

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

  // Step 2: Back-substitution
  for i := TSpace.N - 1 downto 0 do
  begin
    if SameValueEx(result.fm[i, i], 0) then Continue;
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

function TRMatrix.SameValue(const AMatrix: TRMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      if not SameValueEx(fm[i, j], AMatrix.fm[i, j]) then Exit(False);
  result := True;
end;

procedure TRMatrix.Swap(ARow1, ARow2: longint);
var
  tmp: array of double;
begin
  tmp       := fm[ARow1];
  fm[ARow1] := fm[ARow2];
  fm[ARow2] := tmp;
end;

function TRMatrix.Trace: double;
var
  i: longint;
begin
  result := 0;
  for i := 0 to TSpace.N - 1 do
    result := result + fm[i, i];
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

function TRMatrix.Transpose: TRMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := fm[j, i];
end;

class operator TRMatrix.Initialize(var ASelf: TRMatrix);
begin
  SetLength(ASelf.fm, TSpace.N, TSpace.N);
end;

class operator TRMatrix.Finalize(var ASelf: TRMatrix);
begin
  ASelf.fm := nil;
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
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] + ARight.fm[i, j];
end;

class operator TRMatrix.-(const ALeft, ARight: TRMatrix): TRMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] - ARight.fm[i, j];
end;

class operator TRMatrix.*(const ALeft, ARight: TRMatrix): TRMatrix;
var
  i, j, k: longint;
  rowI:    array of double;
begin
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
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft * ARight.fm[i, j];
end;

class operator TRMatrix.*(const ALeft: TRMatrix; const ARight: double): TRMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] * ARight;
end;

class operator TRMatrix./(const ALeft: TRMatrix; const ARight: double): TRMatrix;
var
  i, j: longint;
begin
  for i := 0 to TSpace.N - 1 do
    for j := 0 to TSpace.N - 1 do
      result.fm[i, j] := ALeft.fm[i, j] / ARight;
end;

// TRVector

function TRVector.Get(ARow: longint): double;
begin
  result := fm[ARow];
end;

procedure TRVector.Put(ARow: longint; AValue: double);
begin
  fm[ARow] := AValue;
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
  n := Norm;
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := fm[i] / n;
end;

function TRVector.Reciprocal: TRVector;
var
  i:  longint;
  sn: double;
begin
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

class operator TRVector.Initialize(var ASelf: TRVector);
begin
  SetLength(ASelf.fm, TSpace.N);
end;

class operator TRVector.Finalize(var ASelf: TRVector);
begin
  ASelf.fm := nil;
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
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] + ARight.fm[i];
end;

class operator TRVector.-(const ASelf: TRVector): TRVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := -ASelf.fm[i];
end;

class operator TRVector.-(const ALeft, ARight: TRVector): TRVector;
var
  i: longint;
begin
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
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft * ARight.fm[i];
end;

class operator TRVector.*(const ALeft: TRVector; const ARight: double): TRVector;
var
  i: longint;
begin
  for i := 0 to TSpace.N - 1 do
    result.fm[i] := ALeft.fm[i] * ARight;
end;

class operator TRVector.*(const ALeft: TRVector; const ARight: TRMatrix): TRVector;
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

class operator TRVector.*(const ALeft: TRMatrix; const ARight: TRVector): TRVector;
var
  i, j: longint;
  rowI: array of double;
begin
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

// TR3VectorHelper

function TR3VectorHelper.Cross(const AVector: TR3Vector): TR3Vector;
begin
  result.fm[0] := fm[1]*AVector.fm[2] - fm[2]*AVector.fm[1];
  result.fm[1] := fm[2]*AVector.fm[0] - fm[0]*AVector.fm[2];
  result.fm[2] := fm[0]*AVector.fm[1] - fm[1]*AVector.fm[0];
end;

// Exact specializations

function Determinant(const M: TR2Matrix): double;
begin
  result := M.fm[0,0]*M.fm[1,1] - M.fm[0,1]*M.fm[1,0];
end;

function Reciprocal(const M: TR2Matrix; const ADeterminant: double): TR2Matrix;
begin
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

function Vector(const m0, m1: double): TR2Vector;
begin
  result[0] := m0;
  result[1] := m1;
end;

function Vector(const m0, m1, m2: double): TR3Vector;
begin
  result[0] := m0;
  result[1] := m1;
  result[2] := m2;
end;

function Vector(const m0, m1, m2, m3: double): TR4Vector;
begin
  result[0] := m0;
  result[1] := m1;
  result[2] := m2;
  result[3] := m3;
end;

function Matrix(const m00, m01, m10, m11: double): TR2Matrix;
begin
  result[0,0] := m00;
  result[0,1] := m01;
  result[1,0] := m10;
  result[1,1] := m11;
end;

function Matrix(const m00, m01, m02,
                      m10, m11, m12,
                      m20, m21, m22: double): TR3Matrix;
begin
  result[0,0] := m00;
  result[0,1] := m01;
  result[0,2] := m02;
  result[1,0] := m10;
  result[1,1] := m11;
  result[1,2] := m12;
  result[2,0] := m20;
  result[2,1] := m21;
  result[2,2] := m22;
end;

function Matrix(const m00, m01, m02, m03,
                      m10, m11, m12, m13,
                      m20, m21, m22, m23,
                      m30, m31, m32, m33: double): TR4Matrix;
begin
  result[0,0] := m00;
  result[0,1] := m01;
  result[0,2] := m02;
  result[0,3] := m03;
  result[1,0] := m10;
  result[1,1] := m11;
  result[1,2] := m12;
  result[1,3] := m13;
  result[2,0] := m20;
  result[2,1] := m21;
  result[2,2] := m22;
  result[2,3] := m23;
  result[3,0] := m30;
  result[3,1] := m31;
  result[3,2] := m32;
  result[3,3] := m33;
end;

end.
