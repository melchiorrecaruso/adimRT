{ ADim complex number, matrix and vector types.

  Defines complex number, matrix and vector types used throughout the
  ADimPas library, including:

  @unorderedList(
    @item(@link(TComplex) — complex number in Cartesian form with full
          arithmetic operator support.)
    @item(@link(TImaginaryUnit) — compile-time imaginary unit constant
          for idiomatic complex number construction.)
    @item(@link(TCMatrix) — N×N complex matrix with Gaussian elimination,
          QR decomposition, eigenvalue computation, and Hermitian operations.
          Dimension N is set at runtime via @link(TCMatrix.Init).)
    @item(@link(TCVector) — N-component complex column vector with standard
          linear algebra operations and matrix-vector products. Dimension N
          is set at runtime via @link(TCVector.Init).)
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
unit ADimC;

{$H+}{$J-}
{$modeswitch advancedrecords}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function's return value.
{$WARN 6058 OFF} // Suppress warning for function marked as inline that cannot be inlined.

interface

uses
  ADimCommon, ADimR;

type







  { Square matrix of complex values (@link(TComplex)) with runtime-variable
    dimension @code(N × N).

    The dimension must be set before use by calling @link(Init).
    Matrix elements are stored in a 0-based dynamic 2D array.
    Use the default array property @code(a[row, col]) to read and write
    individual elements using 0-based indices.
  }
  TCMatrix = record
  private
    fm: array of array of TComplex;
    fOrder: longint;

    { Reads the complex element at position (@code(ARow), @code(ACol)). }
    function Get(ARow, ACol: longint): TComplex;

    { Writes the complex element at position (@code(ARow), @code(ACol)). }
    procedure Put(ARow, ACol: longint; AValue: TComplex);

    { Performs forward Gaussian elimination with partial pivoting.
      Used internally by @link(Determinant) and @link(RowReduction).
      @param(SwapCount Number of row swaps performed, used to determine
      the sign of the determinant.)
      @return(Upper triangular matrix after elimination.)
    }
    function ForwardElimination(out SwapCount: integer): TCMatrix; inline;

    { Reduces the matrix to upper Hessenberg form using Householder reflections.
      Used internally by @link(Eigenvalues).
      @return(Upper Hessenberg matrix similar to Self, with same eigenvalues.)
    }
    function HessenbergReduction: TCMatrix;

    { Computes the Householder reflection vector for column @code(k).
      Used internally by @link(HessenbergReduction).
      @param(k Column index, 0-based.)
      @return(Normalized Householder vector stored in column 0.)
    }
    function HouseholderVector(k: longint): TCMatrix;

    { Decomposes the Hessenberg matrix into Q·R using Givens rotations.
      Optimized for Hessenberg matrices: @code(O(N²)) instead of @code(O(N³)).
      Used internally by @link(Eigenvalues).
      @param(Q Unitary matrix.)
      @param(R Upper triangular matrix.)
    }
    procedure QRDecompose(out Q, R: TCMatrix);

  public
    { Sets the matrix to @code(N × N) and resets all elements to zero, in place. }
    procedure Init(AOrder: longint);

    { Sets the matrix to @code(N × N) and fills it row-major from AData, in place.
      No temporary matrix is allocated. AData must contain exactly
      @code(AOrder·AOrder) values. }
    procedure Init(AOrder: longint; const AData: array of TComplex);

    { Sets the matrix from AData, in place, inferring the order from the number
      of values (which must be a perfect square), filled row-major. }
    procedure Init(const AData: array of TComplex);

    { Returns a new N×N matrix with all elements set to zero. }
    class function New(AOrder: longint): TCMatrix; static;

    { Returns a new N×N matrix filled row-major from AData.
      AData must contain exactly AOrder·AOrder values. }
    class function New(AOrder: longint; const AData: array of TComplex): TCMatrix; static;

    { Returns a new square matrix whose order is inferred from the number of
      values in AData (which must be a perfect square), filled row-major. }
    class function New(const AData: array of TComplex): TCMatrix; static;

    { Returns the @code(N × N) identity matrix. The result has the same dimension as Self. }
    function Identity: TCMatrix;

    { Returns the @code(N × N) null matrix. The result has the same dimension as Self. }
    function Null: TCMatrix;

    { Returns the diagonal matrix built from the given eigenvalues.
      @param(AEigenValues 0-based dynamic array of @code(N) complex eigenvalues.)
    }
    function Diagonalize(const AEigenValues: TArrayOfComplex): TCMatrix;

    { Returns @true if all elements of the matrix are zero. }
    function IsNull: boolean;

    { Returns @true if at least one element of the matrix is non-zero. }
    function IsNotNull: boolean;

    { Returns @true if the matrix satisfies @code(A·Aᴴ = I). }
    function IsUnitary: boolean;

    { Returns @true if the matrix is equal to its conjugate transpose:
      @code(A = Aᴴ), i.e. @code(a[i,j] = conj(a[j,i])).
    }
    function IsHermitian: boolean;

    { Returns @true if two matrices are equal within @link(DefaultEpsilon). }
    function SameValue(const AMatrix: TCMatrix): boolean;

    { Returns the determinant of the matrix using Gaussian elimination
      with partial pivoting (LU decomposition).
    }
    function Determinant: TComplex;

    { Returns the Frobenius norm: @code(‖A‖_F = √(Σ|a[i,j]|²)). }
    function Norm: double;

    { Returns the number of linearly independent rows or columns. }
    function Rank: longint;

    { Returns the trace: @code(tr(A) = Σ A[i,i]). }
    function Trace: TComplex;

    { Returns a deep copy of the matrix. }
    function Clone: TCMatrix;

    { Returns the element-wise complex conjugate of the matrix. }
    function Conjugate: TCMatrix;

    { Returns the transpose of the matrix. }
    function Transpose: TCMatrix;

    { Returns the conjugate transpose (Hermitian adjoint): @code(Aᴴ[i,j] = conj(A[j,i])). }
    function TransposeConjugate: TCMatrix;

    { Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    }
    function Reciprocal(const ADeterminant: TComplex): TCMatrix;

    { Returns the row-reduced echelon form of the matrix. }
    function RowReduction: TCMatrix;

    { Returns the eigenvalues of the matrix as a dynamic array of @link(TComplex).
      Uses the QR algorithm with Hessenberg reduction and Wilkinson shift.
      @return(0-based dynamic array of @code(N) complex eigenvalues,
      not guaranteed to be sorted.)
    }
    function Eigenvalues: TArrayOfComplex;

    { Swaps rows @code(ARow1) and @code(ARow2) in place. Indices are 0-based. }
    procedure Swap(ARow1, ARow2: longint);

    { Converts the matrix to its default string representation. }
    function ToString: string;

    { Converts the matrix to a formatted string with controlled precision. }
    function ToString(APrecision, ADigits: integer): string;

    { Management operator: zero-initialises a new matrix (empty, order 0). }
    class operator Initialize(var ASelf: TCMatrix);

    { Management operator: releases the dynamic storage when the matrix goes out of scope. }
    class operator Finalize(var ASelf: TCMatrix);

    { Management operator: performs a deep copy on assignment, so each matrix owns independent storage. }
    class operator Copy(constref ASrc: TCMatrix; var ADst: TCMatrix);

    { Implicit conversion from a real matrix to a complex matrix.
      Each element @code(a[i,j]) is converted to @code(TComplex(Re=a[i,j], Im=0)).
      The source matrix must already be initialized via @link(TRMatrix.Init).
    }
    class operator :=(const AMatrix: TRMatrix): TCMatrix;

    { Returns @true if all corresponding elements are equal. }
    class operator =(const ALeft, ARight: TCMatrix): boolean;

    { Returns @true if the two matrices differ in at least one element. }
    class operator <>(const ALeft, ARight: TCMatrix): boolean;

    { Returns the element-wise sum of two complex matrices. }
    class operator +(const ALeft, ARight: TCMatrix): TCMatrix;

    { Returns the element-wise difference of two complex matrices. }
    class operator -(const ALeft, ARight: TCMatrix): TCMatrix;

    { Returns the matrix product of two complex matrices. }
    class operator *(const ALeft, ARight: TCMatrix): TCMatrix;

    { Returns the product of a complex scalar and a matrix. }
    class operator *(const ALeft: TComplex; const ARight: TCMatrix): TCMatrix;

    { Returns the product of a complex matrix and a complex scalar. }
    class operator *(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;

    { Returns the complex matrix divided by a complex scalar. }
    class operator /(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;

    { Provides access to individual elements using 0-based row and column indices. }
    property a[ARow, ACol: longint]: TComplex read Get write Put; default;

    { The dimension @code(N) of the matrix. Set by @link(Init). Read-only. }
    property Order: longint read fOrder;
  end;

  { Column vector of complex values (@link(TComplex)) with runtime-variable
    dimension @code(N).

    The dimension must be set before use by calling @link(Init).
    Components are stored in a 0-based dynamic array.
    Use the default array property @code(a[row]) to read and write individual
    components using 0-based indices.
  }
  TCVector = record
  private
    fm: array of TComplex;
    fN: longint;

    { Reads the complex component at position @code(ARow). }
    function Get(ARow: longint): TComplex;

    { Writes the complex component at position @code(ARow). }
    procedure Put(ARow: longint; AValue: TComplex);

  public
    { Allocates the dynamic array and sets the dimension.
      Must be called before any other method.
      @param(AN Number of components; must be greater than zero.)
    }
    procedure Init(AOrder: longint);

    { Sets the vector from AData, in place; the size becomes @code(Length(AData)).
      No temporary vector is allocated. }
    procedure Init(const AData: array of TComplex);











    { Returns the element-wise complex conjugate of the vector. }
    function Conjugate: TCVector;

    { Returns the bilinear dot product: @code(u·v = Σ uᵢ·vᵢ). }
    function Dot(const AVector: TCVector): TComplex;

    { Returns the Hermitian inner product: @code(⟨u,v⟩ = Σ conj(uᵢ)·vᵢ). }
    function HermitianDot(const AVector: TCVector): TComplex;

    { Returns @true if all components are zero. }
    function IsNull: boolean;

    { Returns @true if at least one component is non-zero. }
    function IsNotNull: boolean;

    { Returns the Euclidean norm: @code(|v| = √(Σ |vᵢ|²)). }
    function Norm: double;

    { Returns the unit vector in the same direction. }
    function Normalize: TCVector;

    { Returns the dual (reciprocal) vector: each component @code(vᵢ / |v|²). }
    function Reciprocal: TCVector;

    { Returns the squared Euclidean norm: @code(|v|² = Σ |vᵢ|²). }
    function SquaredNorm: double;

    { Converts the vector to its default string representation. }
    function ToString: string;

    { Implicit conversion from a real vector to a complex vector.
      The source vector must already be initialized via @link(TRVector.Init).
    }
    class operator :=(const ASelf: TRVector): TCVector;

    { Returns @true if the two vectors differ in at least one component. }
    class operator <>(const ALeft, ARight: TCVector): boolean;

    { Returns @true if all corresponding components are equal. }
    class operator =(const ALeft, ARight: TCVector): boolean;

    { Unary plus. Returns the vector unchanged. }
    class operator +(const ASelf: TCVector): TCVector;

    { Returns the component-wise sum of two complex vectors. }
    class operator +(const ALeft, ARight: TCVector): TCVector;

    { Unary minus. Returns the negation of the vector. }
    class operator -(const ASelf: TCVector): TCVector;

    { Returns the component-wise difference of two complex vectors. }
    class operator -(const ALeft, ARight: TCVector): TCVector;

    { Returns the dot product: @code(u·v = Σ uᵢ·vᵢ). }
    class operator *(const ALeft, ARight: TCVector): TComplex;

    { Returns the product of a real scalar and a complex vector. }
    class operator *(const ALeft: double; const ARight: TCVector): TCVector;

    { Returns the product of a complex vector and a real scalar. }
    class operator *(const ALeft: TCVector; const ARight: double): TCVector;

    { Returns the product of a complex scalar and a complex vector. }
    class operator *(const ALeft: TComplex; const ARight: TCVector): TCVector;

    { Returns the product of a complex vector and a complex scalar. }
    class operator *(const ALeft: TCVector; const ARight: TComplex): TCVector;

    { Returns the product of a row complex vector and a square complex matrix. }
    class operator *(const ALeft: TCVector; const ARight: TCMatrix): TCVector;

    { Returns the product of a square complex matrix and a column complex vector. }
    class operator *(const ALeft: TCMatrix; const ARight: TCVector): TCVector;

    { Returns the complex vector divided by a real scalar. }
    class operator /(const ALeft: TCVector; const ARight: double): TCVector;

    { Returns @code(ALeft) scaled by the dual of @code(ARight): @code(ALeft·vᵢ/|v|²). }
    class operator /(const ALeft: double; const ARight: TCVector): TCVector;

    { Returns the complex vector divided by a complex scalar. }
    class operator /(const ALeft: TCVector; const ARight: TComplex): TCVector;

    { Returns @code(ALeft) scaled by the dual of @code(ARight): @code(ALeft·vᵢ/|v|²). }
    class operator /(const ALeft: TComplex; const ARight: TCVector): TCVector;

  public
    { The dimension @code(N) of the vector. Set by @link(Init). Read-only. }
    property N: longint read fN;

    { Provides access to individual components using a 0-based index. }
    property a[ARow: longint]: TComplex read Get write Put; default;
  end;

{ Returns the modulus of a complex number: @code(|z| = √(Re² + Im²)). }
function Abs(const AValue: TComplex): double;

{ Returns the square of the complex number: @code(z²). }
function SquarePower(const AValue: TComplex): TComplex;

{ Returns the cube of the complex number: @code(z³). }
function CubicPower(const AValue: TComplex): TComplex;

{ Returns the fourth power of the complex number: @code(z⁴). }
function QuarticPower(const AValue: TComplex): TComplex;

{ Returns all 2 square roots of the complex number as a 0-based dynamic array. }
function SquareRoot(const AValue: TComplex): TArrayOfComplex;

{ Returns all 3 cube roots of the complex number as a 0-based dynamic array. }
function CubicRoot(const AValue: TComplex): TArrayOfComplex;

{ Returns all 4 fourth roots of the complex number as a 0-based dynamic array. }
function QuarticRoot(const AValue: TComplex): TArrayOfComplex;

{ Returns @true if two complex numbers are equal within @link(DefaultEpsilon). }
function SameValueEx(const AValue1, AValue2: TComplex): boolean;

{ Solves @code(z + a = 0) over the complex numbers. Returns @code(-a). }
function SolveEquation(const a: TComplex): TComplex;

{ Solves @code(z² + a·z + b = 0). Returns the two roots as a 0-based dynamic array. }
function SolveEquation(const a, b: TComplex): TArrayOfComplex;

{ Solves @code(z³ + a·z² + b·z + c = 0). Returns the three roots. }
function SolveEquation(const a, b, c: TComplex): TArrayOfComplex;

{ Solves @code(z⁴ + a·z³ + b·z² + c·z + d = 0). Returns the four roots. }
function SolveEquation(const a, b, c, d: TComplex): TArrayOfComplex;

{ Creates a @link(TComplex) number from its real and imaginary parts. }
function Complex(const ARe, AIm: double): TComplex;

var
  { The imaginary unit @code(i), defined by @code(i² = -1).
    Use in expressions: @code(z := 3.0 + 2.0*img;)
  }
  img: TImaginaryUnit;

implementation

uses Math, SysUtils;

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
        FloatToStrF(fRe,             ffGeneral, APrecision, ADigits), sign[fIm < 0],
        FloatToStrF(System.Abs(fIm), ffGeneral, APrecision, ADigits)]);
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
  denom: double;
begin
  denom      := ARight.SquaredNorm;
  result.fRe := ARight.fIm / denom;
  result.fIm := ARight.fRe / denom;
end;

// TCMatrix

procedure TCMatrix.Init(AOrder: longint);
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

procedure TCMatrix.Init(AOrder: longint; const AData: array of TComplex);
var
  i, j: longint;
begin
  Assert(Length(AData) = AOrder * AOrder,
    Format('TRMatrix.Init: expected %d values, got %d', [AOrder * AOrder, Length(AData)]));

  Init(AOrder);
  for i := 0 to AOrder - 1 do
    for j := 0 to AOrder - 1 do
      fm[i, j] := AData[i * AOrder + j];
end;

procedure TCMatrix.Init(const AData: array of TComplex);
var
  n: longint;
begin
  n := Round(Sqrt(Length(AData)));
  Assert(n * n = Length(AData),
    Format('TCMatrix.Init: %d values do not form a square matrix', [Length(AData)]));

  Init(n, AData);
end;

class function TCMatrix.New(AOrder: longint): TCMatrix; static;
begin
  result.Init(AOrder);
end;

class function TCMatrix.New(AOrder: longint; const AData: array of TComplex): TCMatrix; static;
var
  i, j: longint;
begin
  Assert(Length(AData) = AOrder * AOrder,
    Format('TCMatrix.New: expected %d values, got %d', [AOrder * AOrder, Length(AData)]));

  result.Init(AOrder);
  for i := 0 to AOrder - 1 do
    for j := 0 to AOrder - 1 do
      result.fm[i, j] := AData[i * AOrder + j];
end;

class function TCMatrix.New(const AData: array of TComplex): TCMatrix; static;
var
  n: longint;
begin
  n := Round(Sqrt(Length(AData)));
  Assert(n * n = Length(AData),
    Format('TCMatrix.New: %d values do not form a square matrix', [Length(AData)]));

  result.Init(n, AData);
end;

function TCMatrix.Identity: TCMatrix;
var
  i, j: longint;
begin
  result.Init(fOrder);
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      result.fm[i, j] := Ord(i = j);
end;

function TCMatrix.Null: TCMatrix;
var
  i, j: longint;
begin
  result.Init(fOrder);
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      result.fm[i, j] := 0;
end;

function TCMatrix.Diagonalize(const AEigenValues: TArrayOfComplex): TCMatrix;
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

function TCMatrix.IsNull: boolean;
var
  i, j: longint;
begin
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      if not SameValueEx(fm[i, j], 0) then Exit(False);
  result := True;
end;

function TCMatrix.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TCMatrix.IsUnitary: boolean;
begin
  result := Identity.SameValue(TransposeConjugate * Self);
end;

function TCMatrix.SameValue(const AMatrix: TCMatrix): boolean;
var
  i, j: longint;
begin
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      if not SameValueEx(fm[i, j], AMatrix.fm[i, j]) then Exit(False);
  result := True;
end;

function TCMatrix.Determinant: TComplex;
var
  U:     TCMatrix;
  swaps: integer;
  i:     longint;
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

function TCMatrix.Norm: double;
var
  i, j: longint;
  sum:  double;
  rowI: array of TComplex;
begin
  sum := 0;
  for i := 0 to fOrder - 1 do
  begin
    rowI := fm[i];
    for j := 0 to fOrder - 1 do
      sum := sum + rowI[j].SquaredNorm;
  end;
  result := sqrt(sum);
end;

function TCMatrix.Rank: longint;
var
  U:     TCMatrix;
  swaps: integer;
  i:     longint;
begin
  // Count non-zero diagonal entries of the upper triangular factor.
  // Each non-zero pivot corresponds to one linearly independent row.
  U      := ForwardElimination(swaps);
  result := 0;
  for i  := 0 to fOrder - 1 do
    if U.fm[i, i].Norm > DefaultEpsilon then
      Inc(result);
end;

function TCMatrix.Trace: TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 0 to fOrder - 1 do
    result := result + fm[i, i];
end;

function TCMatrix.Clone: TCMatrix;
var
  i, j: longint;
begin
  result.Init(fOrder);
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      result.fm[i, j] := fm[i, j];
end;

function TCMatrix.Transpose: TCMatrix;
var
  i, j: longint;
begin
  result.Init(fOrder);
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      result.fm[i, j] := fm[j, i];
end;

function TCMatrix.Reciprocal(const ADeterminant: TComplex): TCMatrix;
var
  Adj: TCMatrix;
  sub: TCMatrix;
  i, j,
  ri, ci,
  si, sj: longint;
  sign: double;
begin
  // A singular matrix has no inverse; guard against division by a zero
  // determinant, which would otherwise produce silent Inf/NaN entries.
  if Abs(ADeterminant) < DefaultEpsilon then
    raise EZeroDivide.Create('TRMatrix.Reciprocal: matrix is singular (determinant is zero).');

  Adj.Init(fOrder);
  result.Init(fOrder);

  if fOrder > 1 then
    sub.Init(fOrder - 1);

  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
    begin
      // Build (N-1)×(N-1) submatrix by deleting row i and column j
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

      // Cofactor C[i,j] = (-1)^(i+j) * det(sub)
      if Odd(i + j) then sign := -1.0 else sign := 1.0;

      // Adjugate is transpose of cofactor matrix: Adj[j,i] = C[i,j]
      Adj.fm[j, i] := sign * sub.Determinant;
    end;

  // Inverse = Adj / det(A)
  for i := 0 to fOrder - 1 do
    for j := 0 to fOrder - 1 do
      result.fm[i, j] := Adj.fm[i, j] / ADeterminant;
end;

function TCMatrix.RowReduction: TCMatrix;
var
  ratio: TComplex;
  i, j, k, maxRow: longint;
  rowI, rowJ: array of TComplex;
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















function TCMatrix.Get(ARow, ACol: longint): TComplex;
begin
  Assert(fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  result := fm[ARow, ACol];
end;

procedure TCMatrix.Put(ARow, ACol: longint; AValue: TComplex);
begin
  Assert(fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  fm[ARow, ACol] := AValue;
end;

function TCMatrix.ForwardElimination(out SwapCount: integer): TCMatrix;
var
  pivot, ratio: TComplex;
  maxVal:       double;
  i, j, k,
  maxRow:       longint;
  rowI, rowJ:   array of TComplex;
begin
  Assert(fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  result    := Self.Clone;
  SwapCount := 0;

  for i := 0 to fN - 1 do
  begin
    // Partial pivot search using modulus
    maxRow := i;
    maxVal := result.fm[i, i].Norm;
    for j := i + 1 to fN - 1 do
      if result.fm[j, i].Norm > maxVal then
      begin
        maxVal := result.fm[j, i].Norm;
        maxRow := j;
      end;

    if maxVal < DefaultEpsilon then Continue;

    if maxRow <> i then
    begin
      result.Swap(i, maxRow);
      Inc(SwapCount);
    end;

    rowI  := result.fm[i];
    pivot := rowI[i];

    for j := i + 1 to fN - 1 do
    begin
      if result.fm[j, i].Norm < DefaultEpsilon then Continue;
      rowJ    := result.fm[j];
      ratio   := rowJ[i] / pivot;
      rowJ[i] := 0;
      for k := i + 1 to fN - 1 do
        rowJ[k] := rowJ[k] - ratio * rowI[k];
      result.fm[j] := rowJ;
    end;
  end;
end;

function TCMatrix.HouseholderVector(k: longint): TCMatrix;
var
  i:      longint;
  LNorm,
  LNorm2: double;
begin
  Assert(fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  result := Self.Null;

  for i := k + 1 to fN - 1 do
    result.fm[i, 0] := fm[i, k];

  LNorm := 0;
  for i := k + 1 to fN - 1 do
    LNorm := LNorm + result.fm[i, 0].SquaredNorm;
  LNorm := sqrt(LNorm);

  if LNorm < DefaultEpsilon then Exit;

  result.fm[k + 1, 0] := result.fm[k + 1, 0] + LNorm;

  // Avoid recomputing norm via analytical update: norm2² = 2·norm·|v[k+1]|
  LNorm2 := sqrt(2 * LNorm * result.fm[k + 1, 0].Norm);

  if LNorm2 < DefaultEpsilon then Exit;

  for i := k + 1 to fN - 1 do
    result.fm[i, 0] := result.fm[i, 0] / LNorm2;
end;

function TCMatrix.HessenbergReduction: TCMatrix;
var
  V:       TCMatrix;
  k, i, j: longint;
  dot:     TComplex;
  rowI:    array of TComplex;
begin
  Assert(fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  result := Self.Clone;

  for k := 0 to fN - 3 do
  begin
    V := result.HouseholderVector(k);
    if V.IsNull then Continue;

    // Apply from left: result := (I - 2·V·Vᴴ) · result
    for j := 0 to fN - 1 do
    begin
      dot := 0;
      for i := k + 1 to fN - 1 do
        dot := dot + V.fm[i, 0].Conjugate * result.fm[i, j];
      for i := k + 1 to fN - 1 do
        result.fm[i, j] := result.fm[i, j] - 2 * V.fm[i, 0] * dot;
    end;

    // Apply from right: result := result · (I - 2·V·Vᴴ)
    for i := 0 to fN - 1 do
    begin
      rowI := result.fm[i];
      dot  := 0;
      for j := k + 1 to fN - 1 do
        dot := dot + rowI[j] * V.fm[j, 0];
      for j := k + 1 to fN - 1 do
        rowI[j] := rowI[j] - 2 * dot * V.fm[j, 0].Conjugate;
      result.fm[i] := rowI;
    end;

    // Explicitly zero below first subdiagonal for numerical stability
    for i := k + 2 to fN - 1 do
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
  Assert(fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  Q := Self.Identity;
  R := Self.Clone;

  for j := 0 to fN - 2 do
    if R.fm[j + 1, j].Norm > DefaultEpsilon then
    begin
      // denom is real positive: √(|r_jj|² + |r_j+1,j|²)
      denom := sqrt(R.fm[j, j].SquaredNorm + R.fm[j + 1, j].SquaredNorm);
      c := R.fm[j,     j] / denom;
      s := R.fm[j + 1, j] / denom;

      // Apply Givens rotation to R from left
      rowI := R.fm[j];
      rowJ := R.fm[j + 1];
      for i := j to fN - 1 do
      begin
        temp1   := c.Conjugate * rowI[i] + s.Conjugate * rowJ[i];
        temp2   :=           -s * rowI[i] +           c * rowJ[i];
        rowI[i] := temp1;
        rowJ[i] := temp2;
      end;
      R.fm[j]     := rowI;
      R.fm[j + 1] := rowJ;

      // Apply Givens rotation to Q from right
      for i := 0 to fN - 1 do
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

function TCMatrix.Conjugate: TCMatrix;
var
  i, j: longint;
begin
  Assert(fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  result.Init(fN);
  for i := 0 to fN - 1 do
    for j := 0 to fN - 1 do
      result.fm[i, j] := fm[i, j].Conjugate;
end;

function TCMatrix.Eigenvalues: TArrayOfComplex;
var
  H:         TCMatrix;
  Q, R:      TCMatrix;
  i, iter,
  idx:       longint;
  shift:     TComplex;
  converged: boolean;
const
  MaxIter = 1000;
begin
  Assert(fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  SetLength(result, fN);
  H   := Self.HessenbergReduction;
  idx := fN - 1;

  while idx > 0 do
  begin
    converged := False;
    for iter := 1 to MaxIter do
    begin
      // Wilkinson shift
      shift := H.fm[idx, idx];
      for i := 0 to idx do
        H.fm[i, i] := H.fm[i, i] - shift;

      H.QRDecompose(Q, R);
      H := R * Q;

      for i := 0 to idx do
        H.fm[i, i] := H.fm[i, i] + shift;

      if H.fm[idx, idx - 1].Norm < DefaultEpsilon then
      begin
        result[idx] := H.fm[idx, idx];
        Dec(idx);
        converged := True;
        Break;
      end;
    end;

    // No convergence: take best available value and deflate
    if not converged then
    begin
      result[idx] := H.fm[idx, idx];
      Dec(idx);
    end;
  end;
  result[0] := H.fm[0, 0];
end;



function TCMatrix.IsHermitian: boolean;
var
  i, j: longint;
begin
  Assert(fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  for i := 0 to fN - 1 do
    for j := 0 to fN - 1 do
      if not SameValueEx(fm[i, j], fm[j, i].Conjugate) then Exit(False);
  result := True;
end;



















procedure TCMatrix.Swap(ARow1, ARow2: longint);
var
  tmp: array of TComplex;
begin
  Assert(fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  tmp       := fm[ARow1];
  fm[ARow1] := fm[ARow2];
  fm[ARow2] := tmp;
end;



function TCMatrix.ToString: string;
var
  i, j: longint;
  rows: array of string;
begin
  Assert(fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  SetLength(rows, fN);
  for i := 0 to fN - 1 do
  begin
    rows[i] := '(';
    for j := 0 to fN - 1 do
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
  Assert(fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  SetLength(rows, fN);
  for i := 0 to fN - 1 do
  begin
    rows[i] := '(';
    for j := 0 to fN - 1 do
    begin
      if j > 0 then rows[i] := rows[i] + ', ';
      rows[i] := rows[i] + fm[i, j].ToString(APrecision, ADigits);
    end;
    rows[i] := rows[i] + ')';
  end;
  result := '(' + string.Join(', ', rows) + ')';
end;


function TCMatrix.TransposeConjugate: TCMatrix;
var
  i, j: longint;
begin
  Assert(fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  result.Init(fN);
  for i := 0 to fN - 1 do
    for j := 0 to fN - 1 do
      result.fm[i, j] := fm[j, i].Conjugate;
end;

class operator TCMatrix.:=(const AMatrix: TRMatrix): TCMatrix;
var
  i, j: longint;
begin
  Assert(AMatrix.N > 0, 'TRMatrix not initialized: call Init(N) first.');
  result.Init(AMatrix.N);
  for i := 0 to AMatrix.N - 1 do
    for j := 0 to AMatrix.N - 1 do
      result.fm[i, j] := AMatrix[i, j];
end;

class operator TCMatrix.<>(const ALeft, ARight: TCMatrix): boolean;
var
  i, j: longint;
begin
  Assert(ALeft.fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  for i := 0 to ALeft.fN - 1 do
    for j := 0 to ALeft.fN - 1 do
      if ALeft.fm[i, j] <> ARight.fm[i, j] then Exit(True);
  result := False;
end;

class operator TCMatrix.=(const ALeft, ARight: TCMatrix): boolean;
var
  i, j: longint;
begin
  Assert(ALeft.fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  for i := 0 to ALeft.fN - 1 do
    for j := 0 to ALeft.fN - 1 do
      if ALeft.fm[i, j] <> ARight.fm[i, j] then Exit(False);
  result := True;
end;

class operator TCMatrix.+(const ALeft, ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  Assert(ALeft.fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  result.Init(ALeft.fN);
  for i := 0 to ALeft.fN - 1 do
    for j := 0 to ALeft.fN - 1 do
      result.fm[i, j] := ALeft.fm[i, j] + ARight.fm[i, j];
end;

class operator TCMatrix.-(const ALeft, ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  Assert(ALeft.fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  result.Init(ALeft.fN);
  for i := 0 to ALeft.fN - 1 do
    for j := 0 to ALeft.fN - 1 do
      result.fm[i, j] := ALeft.fm[i, j] - ARight.fm[i, j];
end;

class operator TCMatrix.*(const ALeft, ARight: TCMatrix): TCMatrix;
var
  i, j, k: longint;
  rowI:    array of TComplex;
begin
  Assert(ALeft.fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  result.Init(ALeft.fN);
  for i := 0 to ALeft.fN - 1 do
  begin
    rowI := ALeft.fm[i];
    for j := 0 to ALeft.fN - 1 do
    begin
      result.fm[i, j] := 0;
      for k := 0 to ALeft.fN - 1 do
        result.fm[i, j] := result.fm[i, j] + rowI[k] * ARight.fm[k, j];
    end;
  end;
end;

class operator TCMatrix.*(const ALeft: TComplex; const ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  Assert(ARight.fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  result.Init(ARight.fN);
  for i := 0 to ARight.fN - 1 do
    for j := 0 to ARight.fN - 1 do
      result.fm[i, j] := ALeft * ARight.fm[i, j];
end;

class operator TCMatrix.*(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;
var
  i, j: longint;
begin
  Assert(ALeft.fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  result.Init(ALeft.fN);
  for i := 0 to ALeft.fN - 1 do
    for j := 0 to ALeft.fN - 1 do
      result.fm[i, j] := ALeft.fm[i, j] * ARight;
end;

class operator TCMatrix./(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;
var
  i, j: longint;
begin
  Assert(ALeft.fN > 0, 'TCMatrix not initialized: call Init(N) first.');
  result.Init(ALeft.fN);
  for i := 0 to ALeft.fN - 1 do
    for j := 0 to ALeft.fN - 1 do
      result.fm[i, j] := ALeft.fm[i, j] / ARight;
end;

// TCVector

procedure TCVector.Init(AN: longint);
begin
  Assert(AN > 0, 'TCVector.Init: N must be greater than zero.');
  fN := AN;
  SetLength(fm, fN);
end;

function TCVector.Get(ARow: longint): TComplex;
begin
  Assert(fN > 0, 'TCVector not initialized: call Init(N) first.');
  result := fm[ARow];
end;

procedure TCVector.Put(ARow: longint; AValue: TComplex);
begin
  Assert(fN > 0, 'TCVector not initialized: call Init(N) first.');
  fm[ARow] := AValue;
end;

function TCVector.Conjugate: TCVector;
var
  i: longint;
begin
  Assert(fN > 0, 'TCVector not initialized: call Init(N) first.');
  result.Init(fN);
  for i := 0 to fN - 1 do
    result.fm[i] := fm[i].Conjugate;
end;

function TCVector.Dot(const AVector: TCVector): TComplex;
var
  i: longint;
begin
  Assert(fN > 0, 'TCVector not initialized: call Init(N) first.');
  result := 0;
  for i := 0 to fN - 1 do
    result := result + fm[i] * AVector.fm[i];
end;

function TCVector.HermitianDot(const AVector: TCVector): TComplex;
var
  i: longint;
begin
  Assert(fN > 0, 'TCVector not initialized: call Init(N) first.');
  result := 0;
  for i := 0 to fN - 1 do
    result := result + fm[i].Conjugate * AVector.fm[i];
end;

function TCVector.IsNull: boolean;
var
  i: longint;
begin
  Assert(fN > 0, 'TCVector not initialized: call Init(N) first.');
  for i := 0 to fN - 1 do
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
  i:     longint;
  LNorm: double;
begin
  Assert(fN > 0, 'TCVector not initialized: call Init(N) first.');
  result.Init(fN);
  LNorm := Norm;
  for i := 0 to fN - 1 do
    result.fm[i] := fm[i] / LNorm;
end;

function TCVector.Reciprocal: TCVector;
var
  i:  longint;
  sn: double;
begin
  Assert(fN > 0, 'TCVector not initialized: call Init(N) first.');
  result.Init(fN);
  sn := SquaredNorm;
  for i := 0 to fN - 1 do
    result.fm[i] := fm[i] / sn;
end;

function TCVector.SquaredNorm: double;
var
  i: longint;
begin
  Assert(fN > 0, 'TCVector not initialized: call Init(N) first.');
  result := 0;
  for i := 0 to fN - 1 do
    result := result + fm[i].SquaredNorm;
end;

function TCVector.ToString: string;
var
  i: longint;
begin
  result := '';
  for i := 0 to fN -1 do
    result := result + fm[i].ToString + ',';

  i := Length(result);
  SetLength(result, Max(0, i -1));
  result := '(' + result + ')';
end;

class operator TCVector.:=(const ASelf: TRVector): TCVector;
var
  i: longint;
begin
  Assert(ASelf.N > 0, 'TRVector not initialized: call Init(N) first.');
  result.Init(ASelf.N);
  for i := 0 to ASelf.N - 1 do
    result.fm[i] := ASelf[i];
end;

class operator TCVector.<>(const ALeft, ARight: TCVector): boolean;
var
  i: longint;
begin
  Assert(ALeft.fN > 0, 'TCVector not initialized: call Init(N) first.');
  for i := 0 to ALeft.fN - 1 do
    if ALeft.fm[i] <> ARight.fm[i] then Exit(True);
  result := False;
end;

class operator TCVector.=(const ALeft, ARight: TCVector): boolean;
var
  i: longint;
begin
  Assert(ALeft.fN > 0, 'TCVector not initialized: call Init(N) first.');
  for i := 0 to ALeft.fN - 1 do
    if ALeft.fm[i] <> ARight.fm[i] then Exit(False);
  result := True;
end;

class operator TCVector.+(const ASelf: TCVector): TCVector;
begin
  Assert(ASelf.fN > 0, 'TCVector not initialized: call Init(N) first.');
  result := ASelf;
end;

class operator TCVector.+(const ALeft, ARight: TCVector): TCVector;
var
  i: longint;
begin
  Assert(ALeft.fN > 0, 'TCVector not initialized: call Init(N) first.');
  result.Init(ALeft.fN);
  for i := 0 to ALeft.fN - 1 do
    result.fm[i] := ALeft.fm[i] + ARight.fm[i];
end;

class operator TCVector.-(const ASelf: TCVector): TCVector;
var
  i: longint;
begin
  Assert(ASelf.fN > 0, 'TCVector not initialized: call Init(N) first.');
  result.Init(ASelf.fN);
  for i := 0 to ASelf.fN - 1 do
    result.fm[i] := -ASelf.fm[i];
end;

class operator TCVector.-(const ALeft, ARight: TCVector): TCVector;
var
  i: longint;
begin
  Assert(ALeft.fN > 0, 'TCVector not initialized: call Init(N) first.');
  result.Init(ALeft.fN);
  for i := 0 to ALeft.fN - 1 do
    result.fm[i] := ALeft.fm[i] - ARight.fm[i];
end;

class operator TCVector.*(const ALeft, ARight: TCVector): TComplex;
var
  i: longint;
begin
  Assert(ALeft.fN > 0, 'TCVector not initialized: call Init(N) first.');
  result := 0;
  for i := 0 to ALeft.fN - 1 do
    result := result + ALeft.fm[i] * ARight.fm[i];
end;

class operator TCVector.*(const ALeft: double; const ARight: TCVector): TCVector;
var
  i: longint;
begin
  Assert(ARight.fN > 0, 'TCVector not initialized: call Init(N) first.');
  result.Init(ARight.fN);
  for i := 0 to ARight.fN - 1 do
    result.fm[i] := ALeft * ARight.fm[i];
end;

class operator TCVector.*(const ALeft: TCVector; const ARight: double): TCVector;
var
  i: longint;
begin
  Assert(ALeft.fN > 0, 'TCVector not initialized: call Init(N) first.');
  result.Init(ALeft.fN);
  for i := 0 to ALeft.fN - 1 do
    result.fm[i] := ALeft.fm[i] * ARight;
end;

class operator TCVector.*(const ALeft: TComplex; const ARight: TCVector): TCVector;
var
  i: longint;
begin
  Assert(ARight.fN > 0, 'TCVector not initialized: call Init(N) first.');
  result.Init(ARight.fN);
  for i := 0 to ARight.fN - 1 do
    result.fm[i] := ALeft * ARight.fm[i];
end;

class operator TCVector.*(const ALeft: TCVector; const ARight: TComplex): TCVector;
var
  i: longint;
begin
  Assert(ALeft.fN > 0, 'TCVector not initialized: call Init(N) first.');
  result.Init(ALeft.fN);
  for i := 0 to ALeft.fN - 1 do
    result.fm[i] := ALeft.fm[i] * ARight;
end;

class operator TCVector.*(const ALeft: TCVector; const ARight: TCMatrix): TCVector;
var
  i, j: longint;
begin
  Assert(ALeft.fN > 0, 'TCVector not initialized: call Init(N) first.');
  result.Init(ALeft.fN);
  for i := 0 to ALeft.fN - 1 do
  begin
    result.fm[i] := 0;
    for j := 0 to ALeft.fN - 1 do
      result.fm[i] := result.fm[i] + ALeft.fm[j] * ARight.fm[j, i];
  end;
end;

class operator TCVector.*(const ALeft: TCMatrix; const ARight: TCVector): TCVector;
var
  i, j: longint;
  rowI: array of TComplex;
begin
  Assert(ARight.fN > 0, 'TCVector not initialized: call Init(N) first.');
  result.Init(ARight.fN);
  for i := 0 to ARight.fN - 1 do
  begin
    rowI         := ALeft.fm[i];
    result.fm[i] := 0;
    for j := 0 to ARight.fN - 1 do
      result.fm[i] := result.fm[i] + rowI[j] * ARight.fm[j];
  end;
end;

class operator TCVector./(const ALeft: TCVector; const ARight: double): TCVector;
var
  i: longint;
begin
  Assert(ALeft.fN > 0, 'TCVector not initialized: call Init(N) first.');
  result.Init(ALeft.fN);
  for i := 0 to ALeft.fN - 1 do
    result.fm[i] := ALeft.fm[i] / ARight;
end;

class operator TCVector./(const ALeft: double; const ARight: TCVector): TCVector;
var
  i: longint;
  r: TCVector;
begin
  Assert(ARight.fN > 0, 'TCVector not initialized: call Init(N) first.');
  r := ARight.Reciprocal;
  result.Init(ARight.fN);
  for i := 0 to ARight.fN - 1 do
    result.fm[i] := ALeft * r.fm[i];
end;

class operator TCVector./(const ALeft: TCVector; const ARight: TComplex): TCVector;
var
  i: longint;
begin
  Assert(ALeft.fN > 0, 'TCVector not initialized: call Init(N) first.');
  result.Init(ALeft.fN);
  for i := 0 to ALeft.fN - 1 do
    result.fm[i] := ALeft.fm[i] / ARight;
end;

class operator TCVector./(const ALeft: TComplex; const ARight: TCVector): TCVector;
var
  i: longint;
  r: TCVector;
begin
  Assert(ARight.fN > 0, 'TCVector not initialized: call Init(N) first.');
  r := ARight.Reciprocal;
  result.Init(ARight.fN);
  for i := 0 to ARight.fN - 1 do
    result.fm[i] := ALeft * r.fm[i];
end;

// Standalone functions

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

function SameValueEx(const AValue1, AValue2: TComplex): boolean;
begin
  result := SameValueEx(AValue1.fRe, AValue2.fRe) and
            SameValueEx(AValue1.fIm, AValue2.fIm);
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

function Complex(const ARe, AIm: double): TComplex;
begin
  result.Re := ARe;
  result.Im := AIm;
end;

end.
