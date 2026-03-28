{
  Description: ADim Run-time library.

  Copyright (C) 2024-2026 Melchiorre Caruso <melchiorrecaruso@gmail.com>

  This library is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program. If not, see <http://www.gnu.org/licenses/>.
}

unit Skeleton;

{$H+}{$J-}
{$modeswitch advancedrecords}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function''s return value.
{$WARN 6058 OFF} // Suppress warning for function marked as inline that cannot be inlined.

{#HEADER}

interface

uses
  ADimTypes, SysUtils;

type
  { TPrefix }

  TPrefix = (pQuetta, pRonna, pYotta, pZetta, pExa, pPeta, pTera, pGiga, pMega, pKilo, pHecto, pDeca,
    pNone, pDeci, pCenti, pMilli, pMicro, pNano, pPico, pFemto, pAtto, pZepto, pYocto, pRonto, pQuecto);

  { TPrefixes }

  TPrefixes = array of TPrefix;

  { TExponents }

  TExponents = array of longint;

  { Represents a physical quantity with dimension checking at runtime.

    Combines a @code(double) value with a @link(TDimension), ensuring that
    arithmetic operations are dimensionally consistent. Incompatible dimensions
    raise an exception at runtime.
    When the symbol @code(ADIMOFF) is defined, this type degenerates to @code(double)
    and all dimension checking is disabled.
  }
  {$IFNDEF ADIMOFF}
  TQuantity = record
  private
    FDim: TDimension;
    FValue: double;
  public
    { Returns the reciprocal of the quantity: @code(1 / self).
      The resulting dimension is the inverse of the original dimension.
    }
    function Reciprocal: TQuantity;

    { Unary plus. Returns the quantity unchanged. }
    class operator +(const ASelf: TQuantity): TQuantity;

    { Unary minus. Returns the negation of the quantity. }
    class operator -(const ASelf: TQuantity): TQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft, ARight: TQuantity): TQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft, ARight: TQuantity): TQuantity;

    { Returns the product of two quantities. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft, ARight: TQuantity): TQuantity;

    { Returns the product of a dimensionless real scalar and a quantity. The dimension is preserved. }
    class operator *(const ALeft: double; const ARight: TQuantity): TQuantity;

    { Returns the product of a quantity and a dimensionless real scalar. The dimension is preserved. }
    class operator *(const ALeft: TQuantity; const ARight: double): TQuantity;

    { Returns the quotient of two quantities. The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft, ARight: TQuantity): TQuantity;

    { Returns the quotient of a dimensionless real scalar divided by a quantity.
      The resulting dimension is the inverse of @code(ARight).
    }
    class operator /(const ALeft: double; const ARight: TQuantity): TQuantity;

    { Returns the quotient of a quantity divided by a dimensionless real scalar. The dimension is preserved. }
    class operator /(const ALeft: TQuantity; const ARight: double): TQuantity;

    { Returns @true if both operands have the same dimension and equal values. }
    class operator =(const ALeft, ARight: TQuantity): boolean;

    { Returns @true if @code(ALeft) is dimensionally compatible with @code(ARight) and its value is strictly less. }
    class operator <(const ALeft, ARight: TQuantity): boolean;

    { Returns @true if @code(ALeft) is dimensionally compatible with @code(ARight) and its value is strictly greater. }
    class operator >(const ALeft, ARight: TQuantity): boolean;

    { Returns @true if @code(ALeft) is dimensionally compatible with @code(ARight) and its value is less than or equal. }
    class operator <=(const ALeft, ARight: TQuantity): boolean;

    { Returns @true if @code(ALeft) is dimensionally compatible with @code(ARight) and its value is greater than or equal. }
    class operator >=(const ALeft, ARight: TQuantity): boolean;

    { Returns @true if the operands differ in dimension or in value. }
    class operator <>(const ALeft, ARight: TQuantity): boolean;

    { Implicit conversion from a dimensionless real value to a @link(TQuantity).
      The resulting quantity has a scalar (dimensionless) dimension.
    }
    class operator :=(const AValue: double): TQuantity;
  end;
  {$ELSE}
  TQuantity = double;
  {$ENDIF}

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
      Returns a value in the range @code((-π, π]).
    }
    function Arg: double;

    { Returns the complex conjugate of the number.
      If @code(z = a + i·b), the conjugate is @code(z* = a - i·b).
    }
    function Conjugate: TComplex;

    { Returns @true if the complex number is zero, i.e. both @code(Re = 0) and @code(Im = 0).
    }
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
      Useful to reset a complex number before accumulating sums.
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

  { Represents a complex quantity with physical dimensions.

    Combines a @link(TComplex) value with a @link(TDimension), supporting
    arithmetic operations while preserving dimensional consistency.
    When the symbol @code(ADIMOFF) is defined, this type degenerates to @link(TComplex).
  }
  {$IFNDEF ADIMOFF}
  TComplexQuantity = record
  private
    FDim: TDimension;
    FValue: TComplex;
  public
    { Implicit conversion from a real @link(TQuantity) to a complex quantity. The imaginary part is set to zero. }
    class operator := (const AQuantity: TQuantity): TComplexQuantity;

    { Returns @true if both operands have the same dimension and equal complex values. }
    class operator =(const ALeft, ARight: TComplexQuantity): boolean; inline;

    { Returns @true if the operands differ in dimension or in complex value. }
    class operator <>(const ALeft, ARight: TComplexQuantity): boolean; inline;

    { Unary plus. Returns the complex quantity unchanged. }
    class operator +(const AValue: TComplexQuantity): TComplexQuantity; inline;

    { Unary minus. Returns the negation of the complex quantity. }
    class operator -(const AValue: TComplexQuantity): TComplexQuantity; inline;

    { Returns the sum of two complex quantities. Both operands must have the same dimension. }
    class operator +(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;

    { Returns the difference of two complex quantities. Both operands must have the same dimension. }
    class operator -(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;

    { Returns the product of two complex quantities. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;

    { Returns the product of a dimensionless real scalar and a complex quantity. }
    class operator *(const ALeft: double;
      const ARight: TComplexQuantity): TComplexQuantity; inline;

    { Returns the product of a complex quantity and a dimensionless real scalar. }
    class operator *(const ALeft: TComplexQuantity;
      const ARight: double): TComplexQuantity; inline;

    { Returns the product of a real quantity and a complex quantity. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TQuantity;
      const ARight: TComplexQuantity): TComplexQuantity; inline;

    { Returns the product of a complex quantity and a real quantity. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TComplexQuantity;
      const ARight: TQuantity): TComplexQuantity; inline;

    { Returns the quotient of two complex quantities.
      The resulting dimension is the ratio of the two dimensions.
      @raises(Exception if the divisor is zero.)
    }
    class operator /(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;

    { Returns the quotient of a dimensionless real scalar divided by a complex quantity. }
    class operator /(const ALeft: double;
      const ARight: TComplexQuantity): TComplexQuantity; inline;

    { Returns the quotient of a complex quantity divided by a dimensionless real scalar. }
    class operator /(const ALeft: TComplexQuantity;
      const ARight: double): TComplexQuantity; inline;

    { Returns the quotient of a real quantity divided by a complex quantity.
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TQuantity;
      const ARight: TComplexQuantity): TComplexQuantity; inline;

    { Returns the quotient of a complex quantity divided by a real quantity.
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TComplexQuantity;
      const ARight: TQuantity): TComplexQuantity; inline;

    { Returns the sum of a real quantity and a complex quantity.
      Both operands must have the same dimension.
    }
    class operator +(const ALeft: TQuantity;
      const ARight: TComplexQuantity): TComplexQuantity; inline;

    { Returns the sum of a complex quantity and a real quantity.
      Both operands must have the same dimension.
    }
    class operator +(const ALeft: TComplexQuantity;
      const ARight: TQuantity): TComplexQuantity; inline;

    { Returns the difference of a real quantity and a complex quantity.
      Both operands must have the same dimension.
    }
    class operator -(const ALeft: TQuantity;
      const ARight: TComplexQuantity): TComplexQuantity; inline;

    { Returns the difference of a complex quantity and a real quantity.
      Both operands must have the same dimension.
    }
    class operator -(const ALeft: TComplexQuantity;
      const ARight: TQuantity): TComplexQuantity; inline;
  end;
  {$ELSE}
  TComplexQuantity = TComplex;
  {$ENDIF}

  { Represents the imaginary unit @code(i), defined by @code(i² = -1).

    This record has no fields: it acts as a compile-time constant used to construct
    @link(TComplex) numbers naturally via operator overloading
    (e.g. @code(3*i), @code(1 + 2*i), @code(z*i)).
    A global constant of this type (conventionally named @code(i)) should be declared
    to allow idiomatic use in expressions.
    Supports arithmetic with real numbers, @link(TComplex) numbers, and optionally
    with dimensional quantities (@link(TQuantity) / @link(TComplexQuantity)).
  }
  TImaginaryUnit = record
  public
    { Implicit conversion of the imaginary unit to a @link(TComplex) number.
      Returns @code(TComplex(Re=0, Im=1)).
    }
    class operator := (const ASelf: TImaginaryUnit): TComplex;

    { Returns the product of the imaginary unit with itself: @code(i·i = -1).
      The result is a plain @code(double).
    }
    class operator *(const ALeft, ARight: TImaginaryUnit): double;

    { Returns the quotient of the imaginary unit divided by itself: @code(i/i = 1).
      The result is a plain @code(double).
    }
    class operator /(const ALeft, ARight: TImaginaryUnit): double;

    { Unary minus. Returns the negation of the imaginary unit as a @link(TComplex) number.
      Result: @code(TComplex(Re=0, Im=-1)).
    }
    class operator -(const AValue: TImaginaryUnit): TComplex;

    { Unary plus. Returns the imaginary unit as a @link(TComplex) number unchanged.
      Result: @code(TComplex(Re=0, Im=1)).
    }
    class operator +(const AValue: TImaginaryUnit): TComplex;

    { Returns the sum of a real number and the imaginary unit: @code(a + i = a + 1·i). }
    class operator +(const ALeft: double; const ARight: TImaginaryUnit): TComplex;

    { Returns the sum of the imaginary unit and a real number: @code(i + a = a + 1·i). }
    class operator +(const ALeft: TImaginaryUnit; const ARight: double): TComplex;

    { Returns the difference of a real number and the imaginary unit: @code(a - i = a - 1·i). }
    class operator -(const ALeft: double; const ARight: TImaginaryUnit): TComplex;

    { Returns the difference of the imaginary unit and a real number: @code(i - a = -a + 1·i). }
    class operator -(const ALeft: TImaginaryUnit; const ARight: double): TComplex;

    { Returns the sum of a complex number and the imaginary unit: @code((a+bi) + i = a + (b+1)i). }
    class operator +(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    { Returns the sum of the imaginary unit and a complex number: @code(i + (a+bi) = a + (b+1)i). }
    class operator +(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    { Returns the difference of a complex number and the imaginary unit: @code((a+bi) - i = a + (b-1)i). }
    class operator -(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    { Returns the difference of the imaginary unit and a complex number: @code(i - (a+bi) = -a + (1-b)i). }
    class operator -(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    { Returns the product of a real number and the imaginary unit: @code(a·i = 0 + ai). }
    class operator *(const ALeft: double; const ARight: TImaginaryUnit): TComplex;

    { Returns the product of the imaginary unit and a real number: @code(i·a = 0 + ai). }
    class operator *(const ALeft: TImaginaryUnit; const ARight: double): TComplex;

    { Returns the product of a complex number and the imaginary unit: @code((a+bi)·i = -b + ai). }
    class operator *(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    { Returns the product of the imaginary unit and a complex number: @code(i·(a+bi) = -b + ai). }
    class operator *(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    { Returns the quotient of a real number divided by the imaginary unit: @code(a/i = 0 - ai). }
    class operator /(const ALeft: double; const ARight: TImaginaryUnit): TComplex;

    { Returns the quotient of the imaginary unit divided by a real number: @code(i/a = 0 + (1/a)i). }
    class operator /(const ALeft: TImaginaryUnit; const ARight: double): TComplex;

    { Returns the quotient of a complex number divided by the imaginary unit: @code((a+bi)/i = b - ai). }
    class operator /(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;

    { Returns the quotient of the imaginary unit divided by a complex number: @code(i/(a+bi) = b/(a²+b²) + (-a/(a²+b²))i). }
    class operator /(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;

    {$IFNDEF ADIMOFF}
    { Returns the product of a dimensional quantity and the imaginary unit.
      The dimension is preserved.
    }
    class operator *(const ALeft: TQuantity;
      const ARight: TImaginaryUnit): TComplexQuantity;

    { Returns the product of the imaginary unit and a dimensional quantity.
      The dimension is preserved.
    }
    class operator *(const ALeft: TImaginaryUnit;
      const ARight: TQuantity): TComplexQuantity;

    { Returns the quotient of the imaginary unit divided by a dimensional quantity.
      The resulting dimension is the inverse of @code(ARight).
    }
    class operator /(const ALeft: TImaginaryUnit;
      const ARight: TQuantity): TComplexQuantity;

    { Returns the quotient of a dimensional quantity divided by the imaginary unit.
      The dimension is preserved.
    }
    class operator /(const ALeft: TQuantity;
      const ARight: TImaginaryUnit): TComplexQuantity;
    {$ENDIF}
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

  { Generic square matrix of real values (@code(double)) with dimension @code(TSpace.N × TSpace.N).

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

    { Returns the row-reduced echelon form of the matrix (Gauss elimination).
      The original matrix is not modified.
    }
    function RowReduction: TRMatrix;

    { Swaps rows @code(ARow1) and @code(ARow2) in place. }
    procedure Swap(ARow1, ARow2: longint);

    { Returns the trace of the matrix, i.e. the sum of the diagonal elements:
      @code(tr(A) = Σ A[i,i]).
    }
    function Trace: double;

    { Returns the transpose of the matrix.
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
    { Provides access to individual matrix elements using 1-based row and column indices.
      @code(a[1,1]) is the top-left element.
    }
    property a[ARow, ACol: longint]: double read Get write Put; default;
  end;

  { Generic square matrix of complex values (@link(TComplex)) with dimension @code(TSpace.N × TSpace.N).

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

    { Returns the row-reduced echelon form of the matrix (Gauss elimination).
      The original matrix is not modified.
    }
    function RowReduction: TCMatrix;

    { Swaps rows @code(ARow1) and @code(ARow2) in place. }
    procedure Swap(ARow1, ARow2: longint);

    { Returns the trace of the matrix, i.e. the sum of the diagonal elements:
      @code(tr(A) = Σ A[i,i]).
    }
    function Trace: TComplex;

    { Returns the transpose of the matrix.
      Element @code([i,j]) of the result equals element @code([j,i]) of the original.
    }
    function Transpose: TCMatrix;

    { Implicit conversion from a real matrix to a complex matrix.
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

    { Returns the matrix product of two complex matrices.
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
    { Provides access to individual complex matrix elements using 1-based row and column indices.
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

  { Generic square matrix of real physical quantities (@link(TQuantity)) with dimension @code(TSpace.N × TSpace.N).

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
    { Implicit conversion from a dimensionless real matrix to a quantity matrix.
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

    { Returns the matrix product of two quantity matrices.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft, ARight: TRMatrixQuantity): TRMatrixQuantity;

    { Returns the product of a real quantity scalar and a quantity matrix.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TQuantity; const ARight: TRMatrixQuantity): TRMatrixQuantity;

    { Returns the product of a quantity matrix and a real quantity scalar.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TRMatrixQuantity; const ARight: TQuantity): TRMatrixQuantity;

    { Returns the quantity matrix divided by a real quantity scalar.
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TRMatrixQuantity;  const ARight: TQuantity): TRMatrixQuantity;
  end;

  { Generic square matrix of complex physical quantities (@link(TComplexQuantity)) with dimension @code(TSpace.N × TSpace.N).

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
    { Implicit conversion from a complex matrix to a complex quantity matrix.
      The resulting matrix has a scalar (dimensionless) dimension.
    }
    class operator := (const AMatrix: TCMatrix): TCMatrixQuantity;

    { Returns @true if the two matrices differ in dimension or in at least one element. }
    class operator <>(const ALeft, ARight: TCMatrixQuantity): boolean;

    { Returns @true if both matrices have the same dimension and all corresponding elements are equal. }
    class operator =(const ALeft, ARight: TCMatrixQuantity): boolean;

    { Returns the element-wise sum of two complex quantity matrices.
      Both operands must have the same dimension.
    }
    class operator +(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;

    { Returns the element-wise difference of two complex quantity matrices.
      Both operands must have the same dimension.
    }
    class operator -(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;

    { Returns the matrix product of two complex quantity matrices.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;

    { Returns the product of a complex quantity scalar and a complex quantity matrix.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TComplexQuantity; const ARight: TCMatrixQuantity): TCMatrixQuantity;

    { Returns the product of a complex quantity matrix and a complex quantity scalar.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCMatrixQuantity;  const ARight: TComplexQuantity): TCMatrixQuantity;

    { Returns the complex quantity matrix divided by a complex quantity scalar.
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCMatrixQuantity; const ARight: TComplexQuantity): TCMatrixQuantity;

  public
    { Provides access to individual complex quantity matrix elements using 1-based row and column indices.
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

  { Generic column vector of real values (@code(double)) with @code(TSpace.N) components.

    Components are stored in a 1-based array. Use the default array property
    @code(a[row]) to read and write individual components.
    Concrete types are provided as @link(TR2Vector), @link(TR3Vector), and @link(TR4Vector).
  }
  generic TRVector<TSpace> = record
  type
    TRMatrix = specialize TRMatrix<TSpace>;
  private
    fm: array[1..TSpace.N] of double;

    { Reads the component at position @code(ARow). }
    function Get(ARow: longint): double;

    { Writes the component at position @code(ARow). }
    procedure Put(ARow: longint; AValue: double);
  public
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

    { Unary minus. Returns the negation of the vector: each component @code(vᵢ) becomes @code(-vᵢ). }
    class operator -(const ASelf: TRVector): TRVector;

    { Returns the component-wise difference of two vectors. }
    class operator -(const ALeft, ARight: TRVector): TRVector;

    { Returns the dot product (inner product) of two vectors.
      @code(u·v = Σ uᵢ·vᵢ)
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

    {
      Returns the product of a square matrix and a column vector: @code(v' = A·v).
      The result is a column vector.
    }
    class operator *(const ALeft: TRMatrix; const ARight: TRVector): TRVector;

    { Returns the vector divided by a real scalar.
      Each component is divided by @code(ARight).
    }
    class operator /(const ALeft: TRVector; const ARight: double): TRVector;

    { Returns the element-wise quotient of a scalar divided by a vector: each component becomes @code(ALeft/vᵢ). }
    class operator /(const ALeft: double; const ARight: TRVector): TRVector;

  public
    { Provides access to individual vector components using a 1-based index.
      @code(a[1]) is the first component.
    }
    property a[ARow: longint]: double read Get write Put; default;
  end;

  { Generic column vector of complex values (@link(TComplex)) with @code(TSpace.N) components.

    Extends @link(TRVector) to the complex domain. Supports implicit conversion
    from a real vector. Use the default array property @code(a[row]) to read and
    write individual components.
    Concrete types are provided as @link(TC2Vector), @link(TC3Vector), and @link(TC4Vector).
  }
  generic TCVector<TSpace> = record
  type
    TRVector = specialize TRVector<TSpace>;
    TCMatrix = specialize TCMatrix<TSpace>;
  private
    fm: array[1..TSpace.N] of TComplex;

    { Reads the complex component at position @code(ARow). }
    function Get(ARow: longint): TComplex;

    { Writes the complex component at position @code(ARow). }
    procedure Put(ARow: longint; AValue: TComplex);
  public
    { Returns @true if all components are zero. }
    function IsNull: boolean;

    { Returns @true if at least one component is non-zero. }
    function IsNotNull: boolean;

    { Returns the Euclidean norm (magnitude) of the complex vector.
      @code(|v| = √(Σ |vᵢ|²))
    }
    function Norm: double;

    { Returns the unit vector in the same direction.
      Each component is divided by @link(Norm).
    }
    function Normalize: TCVector;

    { Returns the element-wise reciprocal of the vector.
      Each component @code(vᵢ) is replaced by @code(1/vᵢ).
    }
    function Reciprocal: TCVector;

    { Returns the squared Euclidean norm of the complex vector.
      @code(|v|² = Σ |vᵢ|²). Avoids the square root of @link(Norm).
    }
    function SquaredNorm: double;

    { Implicit conversion from a real vector to a complex vector.
      Each component @code(vᵢ) is converted to @code(TComplex(Re=vᵢ, Im=0)).
    }
    class operator :=(const ASelf: TRVector): TCVector;

    { Returns @true if the two vectors differ in at least one component. }
    class operator <>(const ALeft, ARight: TCVector): boolean;

    { Returns @true if all corresponding components of the two vectors are equal. }
    class operator =(const ALeft, ARight: TCVector): boolean;

    { Unary plus. Returns the vector unchanged. }
    class operator +(const ASelf: TCVector): TCVector;

    { Returns the component-wise sum of two complex vectors. }
    class operator +(const ALeft, ARight: TCVector): TCVector;

    { Unary minus. Returns the negation of the vector: each component @code(vᵢ) becomes @code(-vᵢ). }
    class operator -(const ASelf: TCVector): TCVector;

    { Returns the component-wise difference of two complex vectors. }
    class operator -(const ALeft, ARight: TCVector): TCVector;

    { Returns the dot product (inner product) of two complex vectors.
      @code(u·v = Σ uᵢ·vᵢ)
      Note: this is the bilinear dot product, not the Hermitian inner product.
      Use @link(TC2VectorHelper.Dot) for the conjugate-linear inner product.
    }
    class operator *(const ALeft, ARight: TCVector): TComplex;

    { Returns the product of a real scalar and a complex vector.
      Each component is multiplied by @code(ALeft).
    }
    class operator *(const ALeft: double; const ARight: TCVector): TCVector;

    { Returns the product of a complex vector and a real scalar.
      Each component is multiplied by @code(ARight).
    }
    class operator *(const ALeft: TCVector; const ARight: double): TCVector;

    { Returns the product of a complex scalar and a complex vector.
      Each component is multiplied by @code(ALeft).
    }
    class operator *(const ALeft: TComplex; const ARight: TCVector): TCVector;

    { Returns the product of a complex vector and a complex scalar.
      Each component is multiplied by @code(ARight).
    }
    class operator *(const ALeft: TCVector; const ARight: TComplex): TCVector;

    { Returns the product of a row complex vector and a square complex matrix: @code(v' = v·A).
      The result is a row vector.
    }
    class operator *(const ALeft: TCVector; const ARight: TCMatrix): TCVector;

    { Returns the product of a square complex matrix and a column complex vector: @code(v' = A·v).
      The result is a column vector.
    }
    class operator *(const ALeft: TCMatrix; const ARight: TCVector): TCVector;

    { Returns the complex vector divided by a real scalar.
      Each component is divided by @code(ARight).
    }
    class operator /(const ALeft: TCVector; const ARight: double): TCVector;

    { Returns the element-wise quotient of a real scalar divided by a complex vector: each component becomes @code(ALeft/vᵢ). }
    class operator /(const ALeft: double; const ARight: TCVector): TCVector;

    { Returns the complex vector divided by a complex scalar.
      Each component is divided by @code(ARight).
    }
    class operator /(const ALeft: TCVector; const ARight: TComplex): TCVector;

    { Returns the element-wise quotient of a complex scalar divided by a complex vector: each component becomes @code(ALeft/vᵢ). }
    class operator /(const ALeft: TComplex; const ARight: TCVector): TCVector;

  public
    { Provides access to individual complex vector components using a 1-based index.
      @code(a[1]) is the first component.
    }
    property a[ARow: longint]: TComplex read Get write Put; default;
  end;

  { 2-component complex vector. Specialization of @link(TCVector) for @link(T2DSpace). }
  TC2Vector = specialize TCVector<T2DSpace>;
  { 3-component complex vector. Specialization of @link(TCVector) for @link(T3DSpace). }
  TC3Vector = specialize TCVector<T3DSpace>;
  { 4-component complex vector. Specialization of @link(TCVector) for @link(T4DSpace). }
  TC4Vector = specialize TCVector<T4DSpace>;

  { 2-component real vector. Specialization of @link(TRVector) for @link(T2DSpace). }
  TR2Vector = specialize TRVector<T2DSpace>;
  { 3-component real vector. Specialization of @link(TRVector) for @link(T3DSpace). }
  TR3Vector = specialize TRVector<T3DSpace>;
  { 4-component real vector. Specialization of @link(TRVector) for @link(T4DSpace). }
  TR4Vector = specialize TRVector<T4DSpace>;

  { Fixed-size array of 2 complex values. Used to store eigenvalues of @link(TC2Matrix). }
  TC2ArrayOfComplex = array[1..T2DSpace.N] of TComplex;
  { Fixed-size array of 3 complex values. Used to store eigenvalues of @link(TC3Matrix). }
  TC3ArrayOfComplex = array[1..T3DSpace.N] of TComplex;
  { Fixed-size array of 4 complex values. Used to store eigenvalues of @link(TC4Matrix). }
  TC4ArrayOfComplex = array[1..T4DSpace.N] of TComplex;

  { Fixed-size array of 2 complex vectors. Used to store eigenvectors of @link(TC2Matrix). }
  TC2ArrayOfVector = array[1..T2DSpace.N] of TC2Vector;
  { Fixed-size array of 3 complex vectors. Used to store eigenvectors of @link(TC3Matrix). }
  TC3ArrayOfVector = array[1..T3DSpace.N] of TC3Vector;
  { Fixed-size array of 4 complex vectors. Used to store eigenvectors of @link(TC4Matrix). }
  TC4ArrayOfVector = array[1..T4DSpace.N] of TC4Vector;

  { Generic column vector of real physical quantities (@link(TQuantity)) with @code(TSpace.N) components.

    Each component carries the same physical dimension, stored in @code(FDim).
    Supports arithmetic operations with dimensional consistency checking.
    When @code(ADIMOFF) is defined, degenerates to the corresponding @link(TRVector) specialization.
    Concrete types are provided as @link(TR2VecQuantity), @link(TR3VecQuantity), and @link(TR4VecQuantity).
  }
  {$IFNDEF ADIMOFF}
  generic TRVecQuantity<TSpace> = record
  type
    TRVector = specialize TRVector<TSpace>;
    TRMatrixQuantity = specialize TRMatrixQuantity<TSpace>;
  private
    FDim: TDimension;
    FValue: TRVector;

    { Reads the component at position @code(ARow) as a @link(TQuantity). }
    function Get(ARow: longint): TQuantity;

    { Writes the component at position @code(ARow) as a @link(TQuantity). }
    procedure Put(ARow: longint; const AQuantity: TQuantity);
  public
    { Returns the unit vector in the same direction.
      The dimension is preserved; only the numerical values are normalized.
    }
    function Normalize: TRVecQuantity;

    { Returns @true if the two vectors differ in dimension or in at least one component. }
    class operator <>(const ALeft, ARight: TRVecQuantity): boolean;

    { Returns @true if both vectors have the same dimension and all corresponding components are equal. }
    class operator =(const ALeft, ARight: TRVecQuantity): boolean;

    { Unary plus. Returns the quantity vector unchanged. }
    class operator +(const AValue: TRVecQuantity): TRVecQuantity;

    { Returns the component-wise sum of two quantity vectors.
      Both operands must have the same dimension.
    }
    class operator +(const ALeft, ARight: TRVecQuantity): TRVecQuantity;

    { Unary minus. Returns the negation of the quantity vector. }
    class operator -(const AValue: TRVecQuantity): TRVecQuantity;

    { Returns the component-wise difference of two quantity vectors.
      Both operands must have the same dimension.
    }
    class operator -(const ALeft, ARight: TRVecQuantity): TRVecQuantity;

    { Returns the product of a real quantity scalar and a quantity vector.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TQuantity; const ARight: TRVecQuantity): TRVecQuantity;

    { Returns the product of a quantity vector and a real quantity scalar.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TRVecQuantity; const ARight: TQuantity): TRVecQuantity;

    { Returns the product of a real quantity matrix and a quantity vector: @code(v' = A·v).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TRMatrixQuantity; const ARight: TRVecQuantity): TRVecQuantity;

    { Returns the dot product of two quantity vectors.
      @code(u·v = Σ uᵢ·vᵢ). The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft, ARight: TRVecQuantity): TQuantity;

    { Returns the quotient of a real quantity scalar divided by a quantity vector.
      Each component becomes @code(ALeft/vᵢ). The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TQuantity; const ARight: TRVecQuantity): TRVecQuantity;

    { Returns the quantity vector divided by a real quantity scalar.
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TRVecQuantity; const ARight: TQuantity): TRVecQuantity;

  public
    { Provides access to individual vector components using a 1-based index.
      Each component is returned as a @link(TQuantity) carrying the vector's dimension.
    }
    property a[ARow: longint]: TQuantity read Get write Put; default;
  end;

  { Generic column vector of complex physical quantities (@link(TComplexQuantity)) with @code(TSpace.N) components.

    Each component carries the same physical dimension, stored in @code(FDim).
    Supports arithmetic operations with dimensional consistency checking.
    When @code(ADIMOFF) is defined, degenerates to the corresponding @link(TCVector) specialization.
    Concrete types are provided as @link(TC2VecQuantity), @link(TC3VecQuantity), and @link(TC4VecQuantity).
  }
  generic TCVecQuantity<TSpace> = record
  type
    TCVector = specialize TCVector<TSpace>;
    TCMatrixQuantity = specialize TCMatrixQuantity<TSpace>;
  private
    FDim: TDimension;
    FValue: TCVector;

    { Reads the component at position @code(ARow) as a @link(TComplexQuantity). }
    function Get(ARow: longint): TComplexQuantity;

    { Writes the component at position @code(ARow) as a @link(TComplexQuantity). }
    procedure Put(ARow: longint; const AQuantity: TComplexQuantity);
  public
    { Returns the unit vector in the same direction.
      The dimension is preserved; only the numerical values are normalized.
    }
    function Normalize: TCVecQuantity;

    { Implicit conversion from a dimensionless complex vector to a complex quantity vector.
      The resulting vector has a scalar (dimensionless) dimension.
    }
    class operator :=(const AValue: TCVector): TCVecQuantity;

    { Returns @true if the two vectors differ in dimension or in at least one component. }
    class operator <>(const ALeft, ARight: TCVecQuantity): boolean;

    { Returns @true if both vectors have the same dimension and all corresponding components are equal. }
    class operator =(const ALeft, ARight: TCVecQuantity): boolean;

    { Unary plus. Returns the complex quantity vector unchanged. }
    class operator +(const AValue: TCVecQuantity): TCVecQuantity;

    { Returns the component-wise sum of two complex quantity vectors. Both operands must have the same dimension. }
    class operator +(const ALeft, ARight: TCVecQuantity): TCVecQuantity;

    { Unary minus. Returns the negation of the complex quantity vector. }
    class operator -(const AValue: TCVecQuantity): TCVecQuantity;

    { Returns the component-wise difference of two complex quantity vectors. Both operands must have the same dimension. }
    class operator -(const ALeft, ARight: TCVecQuantity): TCVecQuantity;

    { Returns the dot product of two complex quantity vectors.
      @code(u·v = Σ uᵢ·vᵢ). The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft, ARight: TCVecQuantity): TComplexQuantity;

    { Returns the product of a real quantity scalar and a complex quantity vector.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TQuantity; const ARight: TCVecQuantity): TCVecQuantity;

    { Returns the product of a complex quantity vector and a real quantity scalar.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCVecQuantity; const ARight: TQuantity): TCVecQuantity;

    { Returns the product of a complex quantity vector and a complex quantity matrix: @code(v' = v·A).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCVecQuantity; const ARight: TCMatrixQuantity): TCVecQuantity;

    { Returns the product of a complex quantity matrix and a complex quantity vector: @code(v' = A·v).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCMatrixQuantity; const ARight: TCVecQuantity): TCVecQuantity;

    { Returns the dot product of a dimensionless complex vector and a complex quantity vector.
      @code(u·v = Σ uᵢ·vᵢ). The dimension of the result equals the dimension of @code(ARight).
    }
    class operator *(const ALeft: TCVector; const ARight: TCVecQuantity): TComplexQuantity;

    { Returns the quotient of a real quantity scalar divided by a complex quantity vector.
      Each component becomes @code(ALeft/vᵢ). The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TQuantity; const ARight: TCVecQuantity): TCVecQuantity;

    { Returns the complex quantity vector divided by a real quantity scalar.
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCVecQuantity; const ARight: TQuantity): TCVecQuantity;

  public
    { Provides access to individual vector components using a 1-based index.
      Each component is returned as a @link(TComplexQuantity) carrying the vector's dimension.
    }
    property a[ARow: longint]: TComplexQuantity read Get write Put; default;
  end;

  { 2-component real quantity vector. Specialization of @link(TRVecQuantity) for @link(T2DSpace). }
  TR2VecQuantity = specialize TRVecQuantity<T2DSpace>;
  { 3-component real quantity vector. Specialization of @link(TRVecQuantity) for @link(T3DSpace). }
  TR3VecQuantity = specialize TRVecQuantity<T3DSpace>;
  { 4-component real quantity vector. Specialization of @link(TRVecQuantity) for @link(T4DSpace). }
  TR4VecQuantity = specialize TRVecQuantity<T4DSpace>;

  { 2-component complex quantity vector. Specialization of @link(TCVecQuantity) for @link(T2DSpace). }
  TC2VecQuantity = specialize TCVecQuantity<T2DSpace>;
  { 3-component complex quantity vector. Specialization of @link(TCVecQuantity) for @link(T3DSpace). }
  TC3VecQuantity = specialize TCVecQuantity<T3DSpace>;
  { 4-component complex quantity vector. Specialization of @link(TCVecQuantity) for @link(T4DSpace). }
  TC4VecQuantity = specialize TCVecQuantity<T4DSpace>;

  {$ELSE}
  TR2VecQuantity = specialize TRVector<T2DSpace>;
  TR3VecQuantity = specialize TRVector<T3DSpace>;
  TR4VecQuantity = specialize TRVector<T4DSpace>;

  TC2VecQuantity = specialize TCVector<T2DSpace>;
  TC3VecQuantity = specialize TCVector<T3DSpace>;
  TC4VecQuantity = specialize TCVector<T4DSpace>;
  {$ENDIF}

  { Record helper for @link(TR2Matrix) providing additional operations specific to 2×2 real matrices. }
  TR2MatrixHelper = record helper for TR2Matrix
    { Returns the determinant of the 2×2 matrix: @code(det(A) = a₁₁·a₂₂ - a₁₂·a₂₁). }
    function Determinant: double;

    { Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    }
    function Reciprocal(const ADeterminant: double): TR2Matrix;

    { Converts the matrix to its default string representation. }
    function ToString: string;

    { Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Returns the transpose of the 2×2 matrix. }
    function Transpose: TR2Matrix;
  end;

  { Record helper for @link(TR3Matrix) providing additional operations specific to 3×3 real matrices. }
  TR3MatrixHelper = record helper for TR3Matrix
    { Returns the determinant of the 3×3 matrix using cofactor expansion. }
    function Determinant: double;

    { Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    }
    function Reciprocal(const ADeterminant: double): TR3Matrix;

    { Converts the matrix to its default string representation. }
    function ToString: string;

    { Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Returns the transpose of the 3×3 matrix. }
    function Transpose: TR3Matrix;
  end;

  { Record helper for @link(TR4Matrix) providing additional operations specific to 4×4 real matrices. }
  TR4MatrixHelper = record helper for TR4Matrix
    { Returns the determinant of the 4×4 matrix using cofactor expansion. }
    function Determinant: double;

    { Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).) }
    function Reciprocal(const ADeterminant: double): TR4Matrix;

    { Converts the matrix to its default string representation. }
    function ToString: string;

    { Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Returns the transpose of the 4×4 matrix. }
    function Transpose: TR4Matrix;
  end;

  { Record helper for @link(TC2Matrix) providing additional operations specific to 2×2 complex matrices. }
  TC2MatrixHelper = record helper for TC2Matrix
    { Returns the element-wise complex conjugate of the matrix. }
    function Conjugate: TC2Matrix;

    { Returns the determinant of the 2×2 complex matrix: @code(det(A) = a₁₁·a₂₂ - a₁₂·a₂₁). }
    function Determinant: TComplex;

    { Returns the diagonal matrix built from the given eigenvalues.
      @param(AEigenValues The eigenvalues, typically computed via @link(Eigenvalues).)
    }
    function Diagonalize(const AEigenValues: TC2ArrayOfComplex): TC2Matrix;

    { Returns the eigenvalues of the 2×2 complex matrix as a fixed-size array. }
    function Eigenvalues: TC2ArrayOfComplex;

    {
      Returns the eigenvectors of the 2×2 complex matrix corresponding to the given eigenvalues.
      @param(AEigenValues The eigenvalues, computed via @link(Eigenvalues).)
    }
    function Eigenvectors(const AEigenValues: TC2ArrayOfComplex): TC2ArrayOfVector;

    { Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    }
    function Reciprocal(const ADeterminant: TComplex): TC2Matrix;

    { Converts the matrix to its default string representation. }
    function ToString: string;

    { Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Returns the transpose of the 2×2 complex matrix. }
    function Transpose: TC2Matrix;

    { Returns the conjugate transpose (Hermitian adjoint) of the matrix: @code(A† = (Aᵀ)"*").
      Each element @code([i,j]) of the result is the conjugate of @code([j,i]) of the original.
    }
    function TransposeConjugate: TC2Matrix;
  end;

  { Record helper for @link(TC3Matrix) providing additional operations specific to 3×3 complex matrices. }
  TC3MatrixHelper = record helper for TC3Matrix
    { Returns the element-wise complex conjugate of the matrix. }
    function Conjugate: TC3Matrix;

    { Returns the determinant of the 3×3 complex matrix using cofactor expansion. }
    function Determinant: TComplex;

    { Returns the diagonal matrix built from the given eigenvalues.
      @param(AEigenValues The eigenvalues, typically computed via @link(Eigenvalues).)
    }
    function Diagonalize(const AEigenValues: TC3ArrayOfComplex): TC3Matrix;

    { Returns the eigenvalues of the 3×3 complex matrix as a fixed-size array. }
    function Eigenvalues: TC3ArrayOfComplex;

    { Returns the eigenvectors of the 3×3 complex matrix corresponding to the given eigenvalues.
      @param(AEigenValues The eigenvalues, computed via @link(Eigenvalues).)
    }
    function Eigenvectors(const AEigenValues: TC3ArrayOfComplex): TC3ArrayOfVector;

    { Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    }
    function Reciprocal(const ADeterminant: TComplex): TC3Matrix;

    { Converts the matrix to its default string representation. }
    function ToString: string;

    { Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Returns the transpose of the 3×3 complex matrix. }
    function Transpose: TC3Matrix;

    { Returns the conjugate transpose (Hermitian adjoint) of the matrix: @code(A† = (Aᵀ)"*").
      Each element @code([i,j]) of the result is the conjugate of @code([j,i]) of the original.
    }
    function TransposeConjugate: TC3Matrix;
  end;

  { Record helper for @link(TC4Matrix) providing additional operations specific to 4×4 complex matrices. }
  TC4MatrixHelper = record helper for TC4Matrix
    { Returns the element-wise complex conjugate of the matrix. }
    function Conjugate: TC4Matrix;

    { Returns the determinant of the 4×4 complex matrix using cofactor expansion. }
    function Determinant: TComplex;

    { Returns the diagonal matrix built from the given eigenvalues.
      @param(AEigenValues The eigenvalues, typically computed via @link(Eigenvalues).)
    }
    function Diagonalize(const AEigenValues: TC4ArrayOfComplex): TC4Matrix;

    { Returns the eigenvalues of the 4×4 complex matrix as a fixed-size array. }
    function Eigenvalues: TC4ArrayOfComplex;

    { Returns the eigenvectors of the 4×4 complex matrix corresponding to the given eigenvalues.
      @param(AEigenValues The eigenvalues, computed via @link(Eigenvalues).)
    }
    function Eigenvectors(const AEigenValues: TC4ArrayOfComplex): TC4ArrayOfVector;

    { Returns the inverse of the matrix given its precomputed determinant.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    }
    function Reciprocal(const ADeterminant: TComplex): TC4Matrix;

    { Converts the matrix to its default string representation. }
    function ToString: string;

    { Converts the matrix to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;

    { Returns the transpose of the 4×4 complex matrix. }
    function Transpose: TC4Matrix;

    { Returns the conjugate transpose (Hermitian adjoint) of the matrix: @code(A† = (Aᵀ)"*").
      Each element @code([i,j]) of the result is the conjugate of @code([j,i]) of the original.
    }
    function TransposeConjugate: TC4Matrix;
  end;

  { Record helper for @link(TC2Vector) providing additional operations specific to 2-component complex vectors. }
  TC2VectorHelper = record helper for TC2Vector
    { Returns the element-wise complex conjugate of the vector. }
    function Conjugate: TC2Vector;

    { Returns the Hermitian inner product of two complex vectors.
      @code(〈u,v〉 = Σ conj(uᵢ)·vᵢ)
      Unlike the @code("*") operator, this uses the conjugate of the left operand.
      @param(AVector The right-hand operand.)
    }
    function Dot(const AVector: TC2Vector): TComplex;

    { Converts the vector to its default string representation. }
    function ToString: string;

    { Converts the vector to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;
  end;

  { Record helper for @link(TC3Vector) providing additional operations specific to 3-component complex vectors. }
  TC3VectorHelper = record helper for TC3Vector
    { Returns the element-wise complex conjugate of the vector. }
    function Conjugate: TC3Vector;

    { Returns the Hermitian inner product of two complex vectors.
      @code(〈u,v〉 = Σ conj(uᵢ)·vᵢ)
      Unlike the @code("*") operator, this uses the conjugate of the left operand.
      @param(AVector The right-hand operand.)
    }
    function Dot(const AVector: TC3Vector): TComplex;

    { Converts the vector to its default string representation. }
    function ToString: string;

    { Converts the vector to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;
  end;

  { Record helper for @link(TC4Vector) providing additional operations specific to 4-component complex vectors. }
  TC4VectorHelper = record helper for TC4Vector
    { Returns the element-wise complex conjugate of the vector. }
    function Conjugate: TC4Vector;

    { Returns the Hermitian inner product of two complex vectors.
      @code(〈u,v〉 = Σ conj(uᵢ)·vᵢ)
      Unlike the @code("*") operator, this uses the conjugate of the left operand.
      @param(AVector The right-hand operand.)
    }
    function Dot(const AVector: TC4Vector): TComplex;

    { Converts the vector to its default string representation. }
    function ToString: string;

    { Converts the vector to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: integer): string;
  end;

  { Record helper for @link(TR2Vector) providing additional operations specific to 2-component real vectors. }
  TR2VectorHelper = record helper for TR2Vector
    { Returns the dot product of two 2-component real vectors.
      @code(u·v = u₁v₁ + u₂v₂)
      @param(AVector The right-hand operand.)
    }
    function Dot(const AVector: TR2Vector): double;

    { Converts the vector to its default string representation. }
    function ToString: string;

    { Converts the vector to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: longint): string;
  end;

  { Record helper for @link(TR3Vector) providing additional operations specific to 3-component real vectors. }
  TR3VectorHelper = record helper for TR3Vector
    { Returns the dot product of two 3-component real vectors.
      @code(u·v = u₁v₁ + u₂v₂ + u₃v₃)
      @param(AVector The right-hand operand.)
    }
    function Dot(const AVector: TR3Vector): double;

    { Returns the cross product of two 3-component real vectors.
      @code(u×v = (u₂v₃ - u₃v₂, u₃v₁ - u₁v₃, u₁v₂ - u₂v₁))
      The result is a vector perpendicular to both operands.
      @param(AVector The right-hand operand.)
    }
    function Cross(const AVector: TR3Vector): TR3Vector;

    { Converts the vector to its default string representation. }
    function ToString: string;

    { Converts the vector to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: longint): string;
  end;

  { Record helper for @link(TR4Vector) providing additional operations specific to 4-component real vectors. }
  TR4VectorHelper = record helper for TR4Vector
    { Returns the dot product of two 4-component real vectors.
      @code(u·v = u₁v₁ + u₂v₂ + u₃v₃ + u₄v₄)
      @param(AVector The right-hand operand.)
    }
    function Dot(const AVector: TR4Vector): double;

    { Converts the vector to its default string representation. }
    function ToString: string;

    { Converts the vector to a formatted string with controlled precision.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: longint): string;
  end;

  { Enumeration of the eight basis blade components of a multivector in the
    Clifford algebra @code(Cl(3,0)) over @code(R3).

    The basis blades are:
    @unorderedList(
      @item(@code(mcm0)   — scalar part: @code(1))
      @item(@code(mcm1)   — vector basis blade: @code(e1))
      @item(@code(mcm2)   — vector basis blade: @code(e2))
      @item(@code(mcm3)   — vector basis blade: @code(e3))
      @item(@code(mcm12)  — bivector basis blade: @code(e1∧e2))
      @item(@code(mcm13)  — bivector basis blade: @code(e1∧e3))
      @item(@code(mcm23)  — bivector basis blade: @code(e2∧e3))
      @item(@code(mcm123) — pseudoscalar (trivector) basis blade: @code(e1∧e2∧e3))
    )
    The algebra satisfies @code(e1·e1 = +1) for all @code(i), and
    @code(e1·e2 = -e2·e1) for @code(i ≠ j).
  }
  TCL3MultivectorComponent = (mcm0, mcm1, mcm2, mcm3, mcm12, mcm13, mcm23, mcm123);

  { A set of @link(TCL3MultivectorComponent) values.
    Used to identify which components of a multivector are non-zero,
    e.g. to select or test specific grades.
  }
  TCL3MultivectorComponents = set of TCL3MultivectorComponent;

  { Represents a general multivector in the Clifford algebra @code(Cl(3,0)) over @code(R3).

    A multivector is the most general element of the algebra and is expressed as:
    @code(M = m0 + m1·e1 + m2·e2 + m3·e3 + m12·e12 + m13·e13 + m23·e23 + m123·e123)

    where:
    @unorderedList(
      @item(@code(m0) is the scalar part (grade 0))
      @item(@code(m1, m2, m3) are the vector components (grade 1))
      @item(@code(m12, m13, m23) are the bivector components (grade 2))
      @item(@code(m123) is the pseudoscalar component (grade 3))
    )

    The geometric product @code(·) is the fundamental product of the algebra,
    from which the inner product and outer (wedge) product can be derived.
    The algebra satisfies:
    @unorderedList(
      @item(@code(ei² = +1) for @code(i = 1, 2, 3))
      @item(@code(ei·ej = -ej·ei) for @code(i ≠ j))
      @item(@code(e1·e2·e3 = e123) — the unit pseudoscalar)
    )
  }
  TCL3Multivector = record
  private
    fm0: double;
    fm1: double;
    fm2: double;
    fm3: double;
    fm12: double;
    fm13: double;
    fm23: double;
    fm123: double;
  public
    { Implicit conversion from a real scalar to a multivector.
      All components are set to zero except the scalar part @code(m0 = AValue).
    }
    class operator :=(const AValue: double): TCL3Multivector;

    { Implicit conversion from a multivector to a real scalar.
      Returns the scalar part @code(m0). All other components are discarded.
      Use with care: this conversion is only meaningful for pure-scalar multivectors.
    }
    class operator :=(const AValue: TCL3Multivector): double;

    { Returns @true if the two multivectors differ in at least one component. }
    class operator <>(const ALeft, ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector differs from the scalar @code(ARight) in any component. }
    class operator <>(const ALeft: TCL3Multivector; const ARight: double): boolean;

    { Returns @true if the multivector @code(ARight) differs from the scalar @code(ALeft) in any component. }
    class operator <>(const ALeft: double; const ARight: TCL3Multivector): boolean;

    { Returns @true if all corresponding components of the two multivectors are equal. }
    class operator =(const ALeft, ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector equals the scalar @code(ARight), i.e. all non-scalar components are zero. }
    class operator =(const ALeft: TCL3Multivector; const ARight: double): boolean;

    { Returns @true if the multivector @code(ARight) equals the scalar @code(ALeft), i.e. all non-scalar components are zero. }
    class operator =(const ALeft: double; const ARight: TCL3Multivector): boolean;

    { Returns the component-wise sum of two multivectors. }
    class operator +(const ALeft, ARight: TCL3Multivector): TCL3Multivector;

    { Returns the sum of a multivector and a real scalar. Only the scalar component is affected. }
    class operator +(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;

    { Returns the sum of a real scalar and a multivector. Only the scalar component is affected. }
    class operator +(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;

    { Unary minus. Returns the negation of the multivector.
      Each component @code(mₖ) becomes @code(-mₖ).
    }
    class operator -(const ASelf: TCL3Multivector): TCL3Multivector;

    { Returns the component-wise difference of two multivectors. }
    class operator -(const ALeft, ARight: TCL3Multivector): TCL3Multivector;

    { Returns the difference of a multivector and a real scalar. Only the scalar component is affected. }
    class operator -(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;

    { Returns the difference of a real scalar and a multivector. Only the scalar component is affected. }
    class operator -(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric product of two multivectors.
      This is the fundamental product of the Clifford algebra @code(Cl(3,0)).
      It combines the inner (dot) and outer (wedge) products:
      @code(AB = A·B + A∧B).
      The geometric product is associative but generally non-commutative.
    }
    class operator *(const ALeft, ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric product of a multivector and a real scalar.
      Each component is scaled by @code(ARight).
    }
    class operator *(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;

    { Returns the geometric product of a real scalar and a multivector.
      Each component is scaled by @code(ALeft).
    }
    class operator *(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric quotient of two multivectors: @code(ALeft / ARight).
      The inverse @code(1/ARight) is computed using the reverse and the scalar norm.
      Not all multivectors are invertible; behaviour is undefined if @code(ARight)
      has no inverse.
    }
    class operator /(const ALeft, ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric quotient of a multivector divided by a real scalar.
      Each component is divided by @code(ARight).
    }
    class operator /(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;

    { Returns the geometric quotient of a real scalar divided by a multivector: @code(ALeft / ARight). }
    class operator /(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
  end;

  { Represents a pure trivector (pseudoscalar) in the Clifford algebra @code(Cl(3,0)).

    A trivector is a grade-3 element of the algebra, expressed as:
    @code(T = m123·e1∧e2∧e3)

    In @code(Cl(3,0)) the pseudoscalar @code(e123 = e1∧e2∧e3) satisfies:
    @code(e123² = -1), making it analogous to the imaginary unit in complex algebra.
    The pseudoscalar commutes with all elements of @code(Cl(3,0)) and generates
    the duality transformation between vectors and bivectors.

    When combined with elements of other grades the result is a full
    @link(TCL3Multivector). Operations between two trivectors produce a real
    scalar, since @code((m123·e123)·(n123·e123) = -m123·n123).
  }
  TCL3Trivector = record
  private
    fm123: double;
  public
    { Implicit conversion from a trivector to a full multivector.
      All components of the result are zero except @code(m123).
    }
    class operator :=(const AValue: TCL3Trivector): TCL3Multivector;

    { Implicit conversion from a multivector to a trivector.
      Returns only the grade-3 component @code(m123). All other components are discarded.
      Use with care: this conversion is only meaningful for pure-trivector multivectors.
    }
    class operator :=(const AValue: TCL3Multivector): TCL3Trivector;

    { Returns @true if the two trivectors have different @code(m123) coefficients. }
    class operator <>(const ALeft, ARight: TCL3Trivector): boolean;

    { Returns @true if the trivector and the multivector differ in any component. }
    class operator <>(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector and the trivector differ in any component. }
    class operator <>(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): boolean;

    { Returns @true if the two trivectors have equal @code(m123) coefficients. }
    class operator =(const ALeft, ARight: TCL3Trivector): boolean;

    { Returns @true if the trivector equals the multivector,
      i.e. all non-trivector components of @code(ARight) are zero.
    }
    class operator =(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector equals the trivector,
      i.e. all non-trivector components of @code(ALeft) are zero.
    }
    class operator =(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): boolean;

    { Returns the sum of two trivectors. The result is a pure trivector. }
    class operator +(const ALeft, ARight: TCL3Trivector): TCL3Trivector;

    { Returns the sum of a trivector and a real scalar.
      The result is a full multivector with @code(m0 = ARight) and @code(m123 = ALeft.m123).
    }
    class operator +(const ALeft: TCL3Trivector; const ARight: double): TCL3Multivector;

    { Returns the sum of a real scalar and a trivector.
      The result is a full multivector with @code(m0 = ALeft) and @code(m123 = ARight.m123).
    }
    class operator +(const ALeft: double; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the sum of a trivector and a multivector.
      The trivector contributes only to the grade-3 component.
    }
    class operator +(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the sum of a multivector and a trivector.
      The trivector contributes only to the grade-3 component.
    }
    class operator +(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;

    { Unary minus. Returns the negation of the trivector.
      The coefficient @code(m123) becomes @code(-m123).
    }
    class operator -(const ASelf: TCL3Trivector): TCL3Trivector;

    { Returns the difference of two trivectors. The result is a pure trivector. }
    class operator -(const ALeft, ARight: TCL3Trivector): TCL3Trivector;

    { Returns the difference of a trivector and a real scalar.
      The result is a full multivector with @code(m0 = -ARight) and @code(m123 = ALeft.m123).
    }
    class operator -(const ALeft: TCL3Trivector; const ARight: double): TCL3Multivector;

    { Returns the difference of a real scalar and a trivector.
      The result is a full multivector with @code(m0 = ALeft) and @code(m123 = -ARight.m123).
    }
    class operator -(const ALeft: double; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the difference of a trivector and a multivector.
      The trivector contributes only to the grade-3 component.
    }
    class operator -(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the difference of a multivector and a trivector.
      The trivector contributes only to the grade-3 component.
    }
    class operator -(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the geometric product of two trivectors as a real scalar.
      Since @code(e123² = -1), the result is:
      @code((m123·e123)·(n123·e123) = -m123·n123).
    }
    class operator *(const ALeft, ARight: TCL3Trivector): double;

    { Returns the geometric product of a real scalar and a trivector.
      The coefficient @code(m123) is scaled by @code(ALeft).
    }
    class operator *(const ALeft: double; const ARight: TCL3Trivector): TCL3Trivector;

    { Returns the geometric product of a trivector and a real scalar.
      The coefficient @code(m123) is scaled by @code(ARight).
    }
    class operator *(const ALeft: TCL3Trivector; const ARight: double): TCL3Trivector;

    { Returns the geometric product of a trivector and a multivector.
      The result is a full multivector. Grade mixing occurs according to the
      Clifford multiplication rules of @code(Cl(3,0)).
    }
    class operator *(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric product of a multivector and a trivector.
      The result is a full multivector. Grade mixing occurs according to the
      Clifford multiplication rules of @code(Cl(3,0)).
    }
    class operator *(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the geometric quotient of two trivectors as a real scalar.
      Computed as @code(ALeft / ARight). Since @code(e123² = -1),
      the result is: @code(m123 / (-n123) = -m123/n123).
    }
    class operator /(const ALeft, ARight: TCL3Trivector): double;

    { Returns the geometric quotient of a trivector divided by a real scalar.
      The coefficient @code(m123) is divided by @code(ARight).
    }
    class operator /(const ALeft: TCL3Trivector; const ARight: double): TCL3Trivector;

    { Returns the geometric quotient of a real scalar divided by a trivector: @code(ALeft / ARight).
      The inverse of a trivector @code(T = m123·e123) is @code(T⁻¹ = -e123/m123).
    }
    class operator /(const ALeft: double; const ARight: TCL3Trivector): TCL3Trivector;

    { Returns the geometric quotient of a trivector divided by a multivector: @code(ALeft / ARight).
      The result is a full multivector.
    }
    class operator /(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric quotient of a multivector divided by a trivector: @code(ALeft / ARight).
      The result is a full multivector.
    }
    class operator /(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;
  end;

  { Represents a pure bivector (grade-2 element) in the Clifford algebra @code(Cl(3,0)).

    A bivector is expressed as:
    @code(B = m12·e1∧e2 + m13·e1∧e3 + m23·e1∧e3)

    Geometrically, a bivector represents an oriented plane segment in @code(R3).
    In @code(Cl(3,0)) the basis bivectors satisfy:
    @unorderedList(
      @item(@code((e1∧e2)² = -1))
      @item(@code((e1∧e3)² = -1))
      @item(@code((e2∧e3)² = -1))
    )
    making bivectors analogous to quaternion basis elements @code(i, j, k).
    The subalgebra of even-grade elements (scalars and bivectors) is in fact
    isomorphic to the quaternion algebra @code(ℍ).

    The geometric product of two bivectors produces a mixed-grade result
    (scalar + bivector), hence the return type @link(TCL3Multivector).
    When combined with elements of other grades the result is always
    a full @link(TCL3Multivector).
  }
  TCL3Bivector = record
  private
    fm12: double;
    fm13: double;
    fm23: double;
  public
    { Implicit conversion from a bivector to a full multivector.
      All components of the result are zero except @code(m12), @code(m13), @code(m23).
    }
    class operator :=(const AValue: TCL3Bivector): TCL3Multivector;

    { Implicit conversion from a multivector to a bivector.
      Returns only the grade-2 components @code(m12), @code(m13), @code(m23).
      All other components are discarded.

      Use with care: this conversion is only meaningful for pure-bivector multivectors.
    }
    class operator :=(const AValue: TCL3Multivector): TCL3Bivector;

    { Returns @true if the two bivectors differ in at least one component. }
    class operator <>(const ALeft, ARight: TCL3Bivector): boolean;

    { Returns @true if the bivector and the multivector differ in any component. }
    class operator <>(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector and the bivector differ in any component. }
    class operator <>(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): boolean;

    { Returns @true if all corresponding components of the two bivectors are equal. }
    class operator =(const ALeft, ARight: TCL3Bivector): boolean;

    { Returns @true if the bivector equals the multivector,
      i.e. all non-bivector components of @code(ARight) are zero.
    }
    class operator =(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector equals the bivector,
      i.e. all non-bivector components of @code(ALeft) are zero.
    }
    class operator =(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): boolean;

    { Returns the component-wise sum of two bivectors.
      The result is a pure bivector.
    }
    class operator +(const ALeft, ARight: TCL3Bivector): TCL3Bivector;

    { Returns the sum of a bivector and a real scalar.
      The result is a full multivector with @code(m0 = ARight) and the bivector components of @code(ALeft).
    }
    class operator +(const ALeft: TCL3Bivector; const ARight: double): TCL3Multivector;

    { Returns the sum of a real scalar and a bivector.
      The result is a full multivector with @code(m0 = ALeft) and the bivector components of @code(ARight).
    }
    class operator +(const ALeft: double; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the sum of a bivector and a trivector.
      The result is a full multivector with grade-2 components from @code(ALeft)
      and grade-3 component from @code(ARight).
    }
    class operator +(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the sum of a trivector and a bivector.
      The result is a full multivector with grade-3 component from @code(ALeft)
      and grade-2 components from @code(ARight).
    }
    class operator +(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the sum of a bivector and a multivector.
      The bivector contributes only to the grade-2 components.
    }
    class operator +(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the sum of a multivector and a bivector.
      The bivector contributes only to the grade-2 components.
    }
    class operator +(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;

    { Unary minus. Returns the negation of the bivector.
      Each component @code(mₖ) becomes @code(-mₖ).
    }
    class operator -(const ASelf: TCL3Bivector): TCL3Bivector;

    { Returns the component-wise difference of two bivectors.
      The result is a pure bivector.
    }
    class operator -(const ALeft, ARight: TCL3Bivector): TCL3Bivector;

    { Returns the difference of a bivector and a real scalar.
      The result is a full multivector with @code(m0 = -ARight) and the bivector components of @code(ALeft).
    }
    class operator -(const ALeft: TCL3Bivector; const ARight: double): TCL3Multivector;

    { Returns the difference of a real scalar and a bivector.
      The result is a full multivector with @code(m0 = ALeft) and negated bivector components of @code(ARight).
    }
    class operator -(const ALeft: double; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the difference of a bivector and a trivector.
      The result is a full multivector with grade-2 components from @code(ALeft)
      and negated grade-3 component from @code(ARight).
    }
    class operator -(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the difference of a trivector and a bivector.
      The result is a full multivector with grade-3 component from @code(ALeft)
      and negated grade-2 components from @code(ARight).
    }
    class operator -(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the difference of a bivector and a multivector.
      The bivector contributes only to the grade-2 components.
    }
    class operator -(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the difference of a multivector and a bivector.
      The bivector contributes only to the grade-2 components.
    }
    class operator -(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric product of two bivectors.
      The result is a mixed-grade element (scalar + bivector), hence a full @link(TCL3Multivector).
      For example: @code((e₁∧e₂)·(e₁∧e₂) = -1) and @code((e₁∧e₂)·(e₁∧e₃) = -e₂∧e₃).
    }
    class operator *(const ALeft, ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric product of a real scalar and a bivector.
      Each component is scaled by @code(ALeft).
    }
    class operator *(const ALeft: double; const ARight: TCL3Bivector): TCL3Bivector;

    { Returns the geometric product of a bivector and a real scalar.
      Each component is scaled by @code(ARight).
    }
    class operator *(const ALeft: TCL3Bivector; const ARight: double): TCL3Bivector;

    { Returns the geometric product of a bivector and a multivector.
      Grade mixing occurs according to the Clifford multiplication rules of @code(Cl(3,0)).
    }
    class operator *(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric product of a bivector and a trivector.
      Since @code((e₁∧e₂)·(e₁∧e₂∧e₃) = e₃), the result mixes grades and
      is returned as a full @link(TCL3Multivector).
    }
    class operator *(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the geometric product of a trivector and a bivector.
      Grade mixing occurs according to the Clifford multiplication rules of @code(Cl(3,0)).
    }
    class operator *(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric product of a multivector and a bivector.
      Grade mixing occurs according to the Clifford multiplication rules of @code(Cl(3,0)).
    }
    class operator *(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric quotient of two bivectors: @code(ALeft / ARight).
      The result is a mixed-grade element, hence a full @link(TCL3Multivector).
      The inverse of a bivector @code(B) is @code(1/B = -B / |B|²) since @code(B² ≤ 0)
      for pure bivectors in @code(Cl(3,0)).
    }
    class operator /(const ALeft, ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric quotient of a bivector divided by a real scalar.
      Each component is divided by @code(ARight).
    }
    class operator /(const ALeft: TCL3Bivector; const ARight: double): TCL3Bivector;

    { Returns the geometric quotient of a real scalar divided by a bivector: @code(ALeft / ARight).
      The inverse of a bivector @code(B) is @code(1/B = -B / |B|²).
    }
    class operator /(const ALeft: double; const ARight: TCL3Bivector): TCL3Bivector;

    { Returns the geometric quotient of a bivector divided by a trivector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the geometric quotient of a trivector divided by a bivector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric quotient of a bivector divided by a multivector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric quotient of a multivector divided by a bivector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;
  end;

  { Represents a pure vector (grade-1 element) in the Clifford algebra @code(Cl(3,0)).

    A vector is expressed as:
    @code(v = m1·e₁ + m2·e₂ + m3·e₃)

    Geometrically, a vector represents an oriented line segment in @code(R3).
    The basis vectors satisfy the fundamental Clifford relations:
    @unorderedList(
      @item(@code(ei² = +1) for @code(i = 1, 2, 3))
      @item(@code(ei·ej = -ej·ei) for @code(i ≠ j))
    )

    The geometric product of two vectors decomposes into a scalar (inner product)
    and a bivector (outer product):
    @code(uv = u·v + u∧v)
    where @code(u·v = Σ ui·vi) is the symmetric part and
    @code(u∧v) is the antisymmetric part, hence the return type @link(TCL3Multivector).

    Notable special products:
    @unorderedList(
      @item(@code(v · e₁₂₃ = v · (e₁∧e₂∧e₃)) maps a vector to a bivector (left dual))
      @item(@code(e₁₂₃ · v) maps a vector to a bivector (right dual))
    )
    These are reflected in the return type @link(TCL3Bivector) for products
    involving a @link(TCL3Trivector).
  }

  TCL3Vector = record
  private
    fm1: double;
    fm2: double;
    fm3: double;
  public
    { Implicit conversion from a vector to a full multivector.
      All components of the result are zero except @code(m1), @code(m2), @code(m3).
    }
    class operator :=(const AValue: TCL3Vector): TCL3Multivector;

    { Implicit conversion from a multivector to a vector.
      Returns only the grade-1 components @code(m1), @code(m2), @code(m3).
      All other components are discarded.
      Use with care: this conversion is only meaningful for pure-vector multivectors.
    }
    class operator :=(const AValue: TCL3Multivector): TCL3Vector;

    { Returns @true if the two vectors differ in at least one component. }
    class operator <>(const ALeft, ARight: TCL3Vector): boolean;

    { Returns @true if the vector and the multivector differ in any component. }
    class operator <>(const ALeft: TCL3Vector; const ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector and the vector differ in any component. }
    class operator <>(const ALeft: TCL3Multivector; const ARight: TCL3Vector): boolean;

    { Returns @true if all corresponding components of the two vectors are equal. }
    class operator =(const ALeft, ARight: TCL3Vector): boolean;

    { Returns @true if the vector equals the multivector, i.e. all non-vector components of @code(ARight) are zero. }
    class operator =(const ALeft: TCL3Vector; const ARight: TCL3Multivector): boolean;

    { Returns @true if the multivector equals the vector, i.e. all non-vector components of @code(ALeft) are zero. }
    class operator =(const ALeft: TCL3Multivector; const ARight: TCL3Vector): boolean;

    { Returns the component-wise sum of two vectors. The result is a pure vector. }
    class operator +(const ALeft, ARight: TCL3Vector): TCL3Vector;

    { Returns the sum of a vector and a real scalar.
      The result is a full multivector with @code(m0 = ARight) and
      the vector components of @code(ALeft).
    }
    class operator +(const ALeft: TCL3Vector; const ARight: double): TCL3Multivector;

    { Returns the sum of a real scalar and a vector.
      The result is a full multivector with @code(m0 = ALeft) and
      the vector components of @code(ARight).
    }
    class operator +(const ALeft: double; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the sum of a vector and a bivector.
      The result is a full multivector with grade-1 components from @code(ALeft)
      and grade-2 components from @code(ARight).
    }
    class operator +(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the sum of a bivector and a vector.
      The result is a full multivector with grade-2 components from @code(ALeft)
      and grade-1 components from @code(ARight).
    }
    class operator +(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the sum of a vector and a trivector.
      The result is a full multivector with grade-1 components from @code(ALeft)
      and grade-3 component from @code(ARight).
    }
    class operator +(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the sum of a trivector and a vector.
      The result is a full multivector with grade-3 component from @code(ALeft)
      and grade-1 components from @code(ARight).
    }
    class operator +(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the sum of a vector and a multivector. The vector contributes only to the grade-1 components. }
    class operator +(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the sum of a multivector and a vector. The vector contributes only to the grade-1 components. }
    class operator +(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;

    { Unary minus. Returns the negation of the vector.
      Each component @code(mₖ) becomes @code(-mₖ).
    }
    class operator -(const ASelf: TCL3Vector): TCL3Vector;

    { Returns the component-wise difference of two vectors.
      The result is a pure vector.
    }
    class operator -(const ALeft, ARight: TCL3Vector): TCL3Vector;

    { Returns the difference of a vector and a real scalar.
      The result is a full multivector with @code(m0 = -ARight) and
      the vector components of @code(ALeft).
    }
    class operator -(const ALeft: TCL3Vector; const ARight: double): TCL3Multivector;

    { fference of a real scalar and a vector.
      The result is a full multivector with @code(m0 = ALeft) and
      negated vector components of @code(ARight).
    }
    class operator -(const ALeft: double; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the difference of a vector and a bivector.
      The result is a full multivector with grade-1 components from @code(ALeft)
      and negated grade-2 components from @code(ARight).
    }
    class operator -(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the difference of a bivector and a vector.
      The result is a full multivector with grade-2 components from @code(ALeft)
      and negated grade-1 components from @code(ARight).
    }
    class operator -(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the difference of a vector and a trivector.
      The result is a full multivector with grade-1 components from @code(ALeft)
      and negated grade-3 component from @code(ARight).
    }
    class operator -(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Multivector;

    { Returns the difference of a trivector and a vector.
      The result is a full multivector with grade-3 component from @code(ALeft)
      and negated grade-1 components from @code(ARight).
    }
    class operator -(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the difference of a vector and a multivector.
      The vector contributes only to the grade-1 components.
    }
    class operator -(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the difference of a multivector and a vector.
      The vector contributes only to the grade-1 components.
    }
    class operator -(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the geometric product of two vectors.
      The result decomposes into a scalar and a bivector:
      @code(uv = u·v + u∧v)
      hence the return type is a full @link(TCL3Multivector).
    }
    class operator *(const ALeft, ARight: TCL3Vector): TCL3Multivector;

    { Returns the geometric product of a real scalar and a vector.
      Each component is scaled by @code(ALeft).
    }
    class operator *(const ALeft: double; const ARight: TCL3Vector): TCL3Vector;

    { Returns the geometric product of a vector and a real scalar.
      Each component is scaled by @code(ARight).
    }
    class operator *(const ALeft: TCL3Vector; const ARight: double): TCL3Vector;

    { Returns the geometric product of a vector and a bivector.
      The result mixes grades (scalar and trivector parts may appear),
      hence the return type is a full @link(TCL3Multivector).
    }
    class operator *(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric product of a vector and the pseudoscalar @code(e₁₂₃).
      Since @code(v · e₁₂₃) maps each basis vector to its complementary bivector
      (e.g. @code(e₁·e₁₂₃ = e₂₃)), the result is a pure @link(TCL3Bivector).
      This operation corresponds to the left Hodge dual of the vector.
    }
    class operator *(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Bivector;

    { Returns the geometric product of a vector and a full multivector.
      Grade mixing occurs according to the Clifford multiplication rules of @code(Cl(3,0)).
    }
    class operator *(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric product of a bivector and a vector.
      The result mixes grades, hence the return type is a full @link(TCL3Multivector).
    }
    class operator *(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the geometric product of the pseudoscalar @code(e₁₂₃) and a vector.
      Since @code(e₁₂₃ · v) maps each basis vector to its complementary bivector
      (e.g. @code(e₁₂₃·e₁ = e₂₃)), the result is a pure @link(TCL3Bivector).
      This operation corresponds to the right Hodge dual of the vector.
    }
    class operator *(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Bivector;

    { Returns the geometric product of a full multivector and a vector.
      Grade mixing occurs according to the Clifford multiplication rules of @code(Cl(3,0)).
    }
    class operator *(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the geometric quotient of a real scalar divided by a vector: @code(ALeft / ARight).
      The inverse of a vector @code(v) in @code(Cl(3,0)) is @code(1/v = v / |v|²),
      since @code(v² = |v|²) for vectors with positive norm.
      The result is a pure vector.
    }
    class operator /(const ALeft: double; const ARight: TCL3Vector): TCL3Vector;

    { Returns the geometric quotient of a vector divided by a real scalar.
      Each component is divided by @code(ARight).
    }
    class operator /(const ALeft: TCL3Vector; const ARight: double): TCL3Vector;

    { Returns the geometric quotient of two vectors: @code(ALeft / ARight).
      The result is a mixed-grade element (scalar + bivector),
      hence the return type is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft, ARight: TCL3Vector): TCL3Multivector;

    { Returns the geometric quotient of a vector divided by a bivector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;

    { Returns the geometric quotient of a vector divided by the pseudoscalar: @code(ALeft / ARight).
      Since the inverse of @code(e₁₂₃) is @code(-e₁₂₃), this maps the vector
      to its complementary bivector, returning a pure @link(TCL3Bivector).
      This corresponds to the Hodge dual of the vector.
    }
    class operator /(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Bivector;

    { Returns the geometric quotient of a vector divided by a full multivector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;

    { Returns the geometric quotient of a bivector divided by a vector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;

    { Returns the geometric quotient of the pseudoscalar divided by a vector: @code(ALeft / ARight).
      Since @code(e₁₂₃ · v⁻¹) maps the vector to its complementary bivector,
      the result is a pure @link(TCL3Bivector).
    }
    class operator /(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Bivector;

    { Returns the geometric quotient of a full multivector divided by a vector: @code(ALeft / ARight).
      The result is a full @link(TCL3Multivector).
    }
    class operator /(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;
  end;

  { Record helper for @link(TCL3Multivector) providing the full set of geometric algebra
    operations for @code(Cl(3,0)).

    Extends @link(TCL3Multivector) with grade-aware operations including duality,
    reversion, conjugation, projection, rejection, reflection, and rotation,
    as well as utility functions for grade testing, component extraction, and
    string conversion.
  }
  TCL3MultivectorHelper = record helper for TCL3Multivector

    { Returns the Hodge dual of the multivector.
      In @code(Cl(3,0)) the dual is defined as @code(M* = M · e₁₂₃⁻¹).
      The dual exchanges grade @code(k) elements with grade @code(3-k) elements:
      scalars ↔ trivector, vectors ↔ bivectors.
    }
    function Dual: TCL3Multivector;

    { Returns the inverse of the multivector: @code(1/M) such that @code(M · M⁻¹ = 1).
      Not all multivectors are invertible. Behaviour is undefined if the
      multivector has no inverse.
    }
    function Inverse: TCL3Multivector;

    { Returns the reverse of the multivector.
      The reverse @code(M†) is obtained by reversing the order of basis vectors
      in each blade: @code((ei∧ej)† = ei∧ej = -ej∧ei).
      Grade-@code(k) components are multiplied by @code((-1)^(k(k-1)/2)):
      @unorderedList(
        @item(Grade 0 and 1: unchanged)
        @item(Grade 2: negated)
        @item(Grade 3: negated)
      )
    }
    function Reverse: TCL3Multivector;

    { Returns the Clifford conjugate of the multivector.
      The conjugate combines reversion and grade involution.
      Grade-@code(k) components are multiplied by @code((-1)^(k(k+1)/2)):
      @unorderedList(
        @item(Grade 0: unchanged)
        @item(Grade 1: negated)
        @item(Grade 2: negated)
        @item(Grade 3: unchanged)
      )
    }
    function Conjugate: TCL3Multivector;

    { Returns the right reciprocal of the multivector: @code(M⁻¹) such that @code(M · M⁻¹ = 1).
      Computed as @code(Reverse / SquaredNorm) when the multivector is
      norm-invertible. Equivalent to @link(Inverse) for versors.
    }
    function Reciprocal: TCL3Multivector;

    { Returns the left reciprocal of the multivector: @code(M⁻¹) such that @code(M⁻¹ · M = 1).
      For non-symmetric multivectors the left and right reciprocals may differ.
    }
    function LeftReciprocal: TCL3Multivector;

    { Returns the unit multivector in the same direction.
      Each component is divided by @link(Norm).
      The result satisfies @code(|Normalized| = 1).
    }
    function Normalized: TCL3Multivector;

    { Returns the norm of the multivector.
      Defined as @code(|M| = √|M · Reverse(M)|).
    }
    function Norm: double;

    { Returns the squared norm of the multivector.
      Defined as @code(|M|² = |M · Reverse(M)|).
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: double;

    { Returns the inner (dot) product of the multivector with a vector.
      The inner product extracts the grade @code(|p-q|) part of the geometric product,
      contracting the two operands.
      @param(AVector The right-hand vector operand.)
    }
    function Dot(const AVector: TCL3Vector): TCL3Multivector; overload;

    { Returns the inner (dot) product of the multivector with a bivector.
      @param(AVector The right-hand bivector operand.)
    }
    function Dot(const AVector: TCL3Bivector): TCL3Multivector; overload;

    { Returns the inner (dot) product of the multivector with a trivector.
      @param(AVector The right-hand trivector operand.)
    }
    function Dot(const AVector: TCL3Trivector): TCL3Multivector; overload;

    { Returns the inner (dot) product of two multivectors.
      @param(AVector The right-hand multivector operand.)
    }
    function Dot(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the outer (wedge) product of the multivector with a vector.
      The wedge product extracts the grade @code(p+q) part of the geometric product,
      constructing a higher-grade blade from the two operands.
      @param(AVector The right-hand vector operand.)
    }
    function Wedge(const AVector: TCL3Vector): TCL3Multivector; overload;

    { Returns the outer (wedge) product of the multivector with a bivector.
      @param(AVector The right-hand bivector operand.)
    }
    function Wedge(const AVector: TCL3Bivector): TCL3Multivector; overload;

    { Returns the outer (wedge) product of the multivector with a trivector.
      Since @code(e₁₂₃) is the highest-grade element in @code(Cl(3,0)),
      the result is a pure @link(TCL3Trivector) (only the scalar part of the
      multivector contributes).
      @param(AVector The right-hand trivector operand.)
    }
    function Wedge(const AVector: TCL3Trivector): TCL3Trivector; overload;

    { Returns the outer (wedge) product of two multivectors.
      @param(AVector The right-hand multivector operand.)
    }
    function Wedge(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the projection of the multivector onto a vector subspace.
      Defined as @code(Proj_v(M) = (M · v) · v⁻¹).
      @param(AVector The vector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Vector): TCL3Multivector; overload;

    { Returns the projection of the multivector onto a bivector subspace.
      Defined as @code(Proj_B(M) = (M · B) · B⁻¹).
      @param(AVector The bivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Bivector): TCL3Multivector; overload;

    { Returns the projection of the multivector onto the trivector subspace.
      Since the trivector spans the entire space in @code(Cl(3,0)), the
      projection returns the full multivector scaled accordingly.
      @param(AVector The trivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Trivector): TCL3Multivector; overload;

    { Returns the projection of the multivector onto a general multivector subspace.
      @param(AVector The multivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the rejection of the multivector from a vector subspace.
      Defined as @code(Rej_v(M) = (M ∧ v) · v⁻¹).
      The rejection is the component of @code(M) orthogonal to @code(v):
      @code(M = Projection + Rejection).
      @param(AVector The vector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Vector): TCL3Multivector; overload;

    { Returns the rejection of the multivector from a bivector subspace.
      Defined as @code(Rej_B(M) = (M ∧ B) · B⁻¹).
      @param(AVector The bivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Bivector): TCL3Multivector; overload;

    { Returns the rejection of the multivector from the trivector subspace as a scalar.
      Since the trivector spans the entire space, the rejection reduces to a
      scalar coefficient.
      @param(AVector The trivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Trivector): double; overload;

    { Returns the rejection of the multivector from a general multivector subspace.
      @param(AVector The multivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the reflection of the multivector through a vector hyperplane.
      Defined as @code(v · M · v⁻¹), which reflects all components of @code(M)
      through the hyperplane perpendicular to @code(v).
      @param(AVector The vector defining the hyperplane of reflection.)
    }
    function Reflection(const AVector: TCL3Vector): TCL3Multivector; overload;

    { Returns the reflection of the multivector through a bivector subspace.
      Defined as @code(B · M · B⁻¹).
      @param(AVector The bivector defining the subspace of reflection.)
    }
    function Reflection(const AVector: TCL3Bivector): TCL3Multivector; overload;

    { Returns the reflection of the multivector through the trivector subspace.
      Defined as @code(e₁₂₃ · M · e₁₂₃⁻¹).
      @param(AVector The trivector defining the subspace of reflection.)
    }
    function Reflection(const AVector: TCL3Trivector): TCL3Multivector; overload;

    { Returns the reflection of the multivector through a general multivector subspace.
      Defined as @code(N · M · N⁻¹).
      @param(AVector The multivector defining the subspace of reflection.)
    }
    function Reflection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the rotation of the multivector in the plane defined by two vectors.
      The rotation is performed by the versor @code(R = v₁·v₂), applied as
      @code(R · M · R⁻¹). The rotation angle is twice the angle between
      @code(AVector1) and @code(AVector2).
      @param(AVector1 The first vector defining the rotation plane.)
      @param(AVector2 The second vector defining the rotation plane.)
    }
    function Rotation(const AVector1, AVector2: TCL3Vector): TCL3Multivector; overload;

    { Returns the rotation of the multivector using a bivector rotor sandwich product.
      Applied as @code(R · M · R⁻¹) where @code(R = AVector1 · AVector2).
      @param(AVector1 The first bivector operand of the rotor.)
      @param(AVector2 The second bivector operand of the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Multivector; overload;

    { Returns the rotation of the multivector using a trivector rotor sandwich product.
      Applied as @code(R · M · R⁻¹) where @code(R = AVector1 · AVector2).
      @param(AVector1 The first trivector operand of the rotor.)
      @param(AVector2 The second trivector operand of the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Multivector; overload;

    { Returns the rotation of the multivector using a general multivector rotor.
      Applied as @code(R · M · R⁻¹) where @code(R = AVector1 · AVector2).
      @param(AVector1 The first multivector operand of the rotor.)
      @param(AVector2 The second multivector operand of the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector; overload;

    { Returns @true if all components of the multivector are numerically close
      to the corresponding components of @code(AValue), within floating point tolerance.
      @param(AValue The multivector to compare against.)
    }
    function SameValue(const AValue: TCL3Multivector): boolean; overload;

    { Returns @true if the multivector is numerically close to the trivector @code(AValue),
      i.e. all non-trivector components are negligible.
      @param(AValue The trivector to compare against.)
    }
    function SameValue(const AValue: TCL3Trivector): boolean; overload;

    { Returns @true if the multivector is numerically close to the bivector @code(AValue),
      i.e. all non-bivector components are negligible.
      @param(AValue The bivector to compare against.)
    }
    function SameValue(const AValue: TCL3Bivector): boolean; overload;

    { Returns @true if the multivector is numerically close to the vector @code(AValue),
      i.e. all non-vector components are negligible.
      @param(AValue The vector to compare against.)
    }
    function SameValue(const AValue: TCL3Vector): boolean; overload;

    { Returns @true if the multivector is numerically close to the scalar @code(AValue),
      i.e. all non-scalar components are negligible.
      @param(AValue The scalar to compare against.)
    }
    function SameValue(const AValue: double): boolean; overload;

    { Extracts selected components from the multivector as a @link(TCL3Multivector).
      Only the components specified in @code(AComponents) are retained;
      all others are set to zero.
      @param(AComponents The set of components to extract.)
    }
    function ExtractMultivector(AComponents: TCL3MultivectorComponents): TCL3Multivector;

    { Extracts selected bivector components from the multivector.
      Only grade-2 components present in @code(AComponents) are retained.
      @param(AComponents The set of components to extract.)
    }
    function ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3Bivector; overload;

    { Extracts selected vector components from the multivector.
      Only grade-1 components present in @code(AComponents) are retained.
      @param(AComponents The set of components to extract.)
    }
    function ExtractVector(AComponents: TCL3MultivectorComponents): TCL3Vector; overload;

    { Extracts the grade-3 (pseudoscalar) component of the multivector.
      All other components are discarded.
    }
    function ExtractTrivector: TCL3Trivector;

    { Extracts all grade-2 (bivector) components of the multivector.
      All other components are discarded.
    }
    function ExtractBivector: TCL3Bivector; overload;

    { Extracts all grade-1 (vector) components of the multivector.
      All other components are discarded.
    }
    function ExtractVector: TCL3Vector; overload;

    { Extracts the grade-0 (scalar) component of the multivector.
      All other components are discarded.
    }
    function ExtractScalar: double;

    { Returns @true if all components of the multivector are zero or numerically negligible. }
    function IsNull: boolean;

    { Returns @true if the multivector is a pure scalar, i.e. all non-scalar components are zero. }
    function IsScalar: boolean;

    { Returns @true if the multivector is a pure vector (grade 1), i.e. only grade-1 components are non-zero. }
    function IsVector: boolean;

    { Returns @true if the multivector is a pure bivector (grade 2), i.e. only grade-2 components are non-zero. }
    function IsBiVector: boolean;

    { Returns @true if the multivector is a pure trivector (grade 3), i.e. only the grade-3 component is non-zero. }
    function IsTrivector: boolean;

    { Returns a string identifying the grade structure of the multivector.
      Examples of possible return values: @code('scalar'), @code('vector'),
      @code('bivector'), @code('trivector'), @code('multivector').
    }
    function IsA: string;

    { Converts the multivector to a formatted string with controlled precision.
      Only non-zero components are included in the output.
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: longint): string;

    { Converts the multivector to its default string representation.
      Only non-zero components are included in the output.
    }
    function ToString: string;
  end;

  { Record helper for @link(TCL3Trivector) providing geometric operations
    specific to grade-3 elements of @code(Cl(3,0)).

    All operations follow the conventions of Clifford algebra over @code(ℝ³):
    @unorderedList(
      @item(The geometric product is the fundamental product of the algebra.)
      @item(The inner (dot) product lowers the grade of the result.)
      @item(The outer (wedge) product raises the grade of the result.)
      @item(The dual maps a grade-@code(k) element to a grade-@code(3-k) element
            via multiplication by @code(e₁₂₃⁻¹).)
      @item(Projection, rejection, reflection and rotation are defined via the
            geometric product and its inverse.)
    )
  }
  TCL3TrivectorHelper = record helper for TCL3Trivector

    { Returns the dual of the trivector with respect to the pseudoscalar @code(e₁₂₃).
      For @code(T = m123·e₁₂₃), the dual is the scalar:
      @code(T* = T · e₁₂₃⁻¹ = -m123).
      The dual maps grade-3 elements to grade-0 (scalar) elements.
    }
    function Dual: double;

    { Returns the inverse of the trivector under the geometric product.
      For @code(T = m123·e₁₂₃):
      @code(T⁻¹ = -e₁₂₃ / m123), since @code(e₁₂₃² = -1).
    }
    function Inverse: TCL3Trivector;

    { Returns the reverse of the trivector.
      The reverse of a grade-@code(k) blade changes sign by @code((-1)^(k·(k-1)/2)).
      For a trivector (@code(k = 3)): @code(T̃ = -T).
    }
    function Reverse: TCL3Trivector;

    { Returns the Clifford conjugate of the trivector.
      The conjugate combines reversion and grade involution.
      For a trivector (@code(k = 3)): @code(T† = -T).
    }
    function Conjugate: TCL3Trivector;

    { Returns the reciprocal of the trivector: @code(T̃ / (T · T̃)).
      Equivalent to @link(Inverse) for non-zero trivectors.
    }
    function Reciprocal: TCL3Trivector;

    { Returns the unit trivector in the same direction.
      The coefficient @code(m123) is divided by @link(Norm).
    }
    function Normalized: TCL3Trivector;

    { Returns the norm of the trivector: @code(|T| = |m123|).
      Defined as the square root of @code(T · T̃).
    }
    function Norm: double;

    { Returns the squared norm of the trivector: @code(|T|² = m123²).
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: double;

    { Returns the inner (dot) product of the trivector and a vector.
      Lowers the grade: @code(grade(3) · grade(1) → grade(2) = bivector).
      @param(AVector The grade-1 right operand.)
    }
    function Dot(const AVector: TCL3Vector): TCL3Bivector; overload;

    { Returns the inner (dot) product of the trivector and a bivector.
      Lowers the grade: @code(grade(3) · grade(2) → grade(1) = vector).
      @param(AVector The grade-2 right operand.)
    }
    function Dot(const AVector: TCL3Bivector): TCL3Vector; overload;

    { Returns the inner (dot) product of two trivectors.
      Lowers the grade: @code(grade(3) · grade(3) → grade(0) = scalar).
      Result: @code(T₁ · T₂ = -m123₁ · m123₂).
      @param(AVector The grade-3 right operand.)
    }
    function Dot(const AVector: TCL3Trivector): double; overload;

    { Returns the inner (dot) product of the trivector and a multivector.
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The right operand.)
    }
    function Dot(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the outer (wedge) product of the trivector and a vector.
      Always zero in @code(ℝ³): @code(grade(3) ∧ grade(1) → grade(4) = 0).
      @param(AVector The grade-1 right operand.)
    }
    function Wedge(const AVector: TCL3Vector): double; overload;

    { Returns the outer (wedge) product of the trivector and a bivector.
      Always zero in @code(ℝ³): @code(grade(3) ∧ grade(2) → grade(5) = 0).
      @param(AVector The grade-2 right operand.)
    }
    function Wedge(const AVector: TCL3Bivector): double; overload;

    { Returns the outer (wedge) product of two trivectors.
      Always zero in @code(ℝ³): @code(grade(3) ∧ grade(3) → grade(6) = 0).
      @param(AVector The grade-3 right operand.)
    }
    function Wedge(const AVector: TCL3Trivector): double; overload;

    { Returns the outer (wedge) product of the trivector and a multivector.
      Only the scalar part of @code(AVector) contributes to a non-zero result,
      since any higher-grade wedge product vanishes in @code(ℝ³).
      @param(AVector The right operand.)
    }
    function Wedge(const AVector: TCL3Multivector): TCL3Trivector; overload;

    { Returns the projection of the trivector onto a vector subspace.
      Defined as: @code(proj(T, v) = (T · v⁻¹) ∧ v).
      @param(AVector The vector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Vector): TCL3Trivector; overload;

    { Returns the projection of the trivector onto a bivector subspace.
      Defined as: @code(proj(T, B) = (T · B⁻¹) ∧ B).
      @param(AVector The bivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Bivector): TCL3Trivector; overload;

    { Returns the projection of the trivector onto a trivector subspace.
      Defined as: @code(proj(T₁, T₂) = (T₁ · T₂⁻¹) ∧ T₂).
      @param(AVector The trivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Trivector): TCL3Trivector; overload;

    { Returns the projection of the trivector onto a multivector subspace.
      Defined as: @code(proj(T, M) = (T · M⁻¹) ∧ M).
      @param(AVector The multivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Multivector): TCL3Trivector; overload;

    { Returns the rejection of the trivector from a vector subspace.
      Defined as: @code(rej(T, v) = T - proj(T, v)).
      In @code(ℝ³) the rejection of a trivector from a vector is a scalar.
      @param(AVector The vector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Vector): double; overload;

    { Returns the rejection of the trivector from a bivector subspace.
      Defined as: @code(rej(T, B) = T - proj(T, B)).
      In @code(ℝ³) the rejection of a trivector from a bivector is a scalar.
      @param(AVector The bivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Bivector): double; overload;

    { Returns the rejection of the trivector from another trivector subspace.
      Defined as: @code(rej(T₁, T₂) = T₁ - proj(T₁, T₂)).
      In @code(ℝ³) the rejection of a trivector from a trivector is a scalar.
      @param(AVector The trivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Trivector): double; overload;

    { Returns the rejection of the trivector from a multivector subspace.
      Defined as: @code(rej(T, M) = T - proj(T, M)).
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The multivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the reflection of the trivector through a vector.
      Defined as: @code(reflect(T, v) = -v · T · v⁻¹).
      Since the trivector is the pseudoscalar up to a scalar factor, the
      reflection preserves the grade-3 part.
      @param(AVector The vector defining the reflection hyperplane normal.)
    }
    function Reflection(const AVector: TCL3Vector): TCL3Trivector; overload;

    { Returns the reflection of the trivector through a bivector.
      Defined as: @code(reflect(T, B) = -B · T · B⁻¹).
      @param(AVector The bivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Bivector): TCL3Trivector; overload;

    { Returns the reflection of the trivector through another trivector.
      Defined as: @code(reflect(T₁, T₂) = -T₂ · T₁ · T₂⁻¹).
      @param(AVector The trivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Trivector): TCL3Trivector; overload;

    { Returns the reflection of the trivector through a multivector.
      Defined as: @code(reflect(T, M) = -M · T · M⁻¹).
      @param(AVector The multivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Multivector): TCL3Trivector; overload;

    { Returns the trivector rotated by the rotor defined by two vectors.
      The rotor is constructed as @code(R = AVector2 · AVector1)
      (normalised to a unit rotor). The rotation is applied as:
      @code(T' = R · T · R⁻¹).
      @param(AVector1 The first vector defining the rotation plane.)
      @param(AVector2 The second vector defining the rotation plane.)
    }
    function Rotation(const AVector1, AVector2: TCL3Vector): TCL3Trivector; overload;

    { Returns the trivector rotated by the rotor defined by two bivectors.
      The rotation is applied as: @code(T' = R · T · R⁻¹).
      @param(AVector1 The first bivector defining the rotor.)
      @param(AVector2 The second bivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Trivector; overload;

    { Returns the trivector rotated by the rotor defined by two trivectors.
      The rotation is applied as: @code(T' = R · T · R⁻¹).
      @param(AVector1 The first trivector defining the rotor.)
      @param(AVector2 The second trivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Trivector; overload;

    { Returns the trivector rotated by the rotor defined by two multivectors.
      The rotation is applied as: @code(T' = R · T · R⁻¹).
      @param(AVector1 The first multivector defining the rotor.)
      @param(AVector2 The second multivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Trivector; overload;

    { Returns @true if the trivector is numerically equal to the given multivector
      within the default floating point tolerance.
      All non-trivector components of @code(AValue) must be negligible.
      @param(AValue The multivector to compare against.)
    }
    function SameValue(const AValue: TCL3Multivector): boolean;

    { Returns @true if the two trivectors are numerically equal
      within the default floating point tolerance.
      @param(AValue The trivector to compare against.)
    }
    function SameValue(const AValue: TCL3Trivector): boolean;

    { Converts the trivector to a full @link(TCL3Multivector).
      All components are zero except @code(m123).
    }
    function ToMultivector: TCL3Multivector;

    { Converts the trivector to a formatted string with controlled precision.
      The format is @code(m123·e₁₂₃).
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: longint): string;

    { Converts the trivector to its default string representation.
      The format is @code(m123·e₁₂₃).
    }
    function ToString: string;
  end;

  { Record helper for @link(TCL3Bivector) providing geometric operations
    specific to grade-2 elements of @code(Cl(3,0)).

    All operations follow the conventions of Clifford algebra over @code(ℝ³):
    @unorderedList(
      @item(The geometric product is the fundamental product of the algebra.)
      @item(The inner (dot) product lowers the grade of the result.)
      @item(The outer (wedge) product raises the grade of the result.)
      @item(The dual maps a grade-@code(k) element to a grade-@code(3-k) element
            via multiplication by @code(e₁₂₃⁻¹).)
      @item(Projection, rejection, reflection and rotation are defined via the
            geometric product and its inverse.)
    )
  }
  TCL3BivectorHelper = record helper for TCL3Bivector

    { Returns the dual of the bivector with respect to the pseudoscalar @code(e₁₂₃).
      The dual maps grade-2 elements to grade-1 (vector) elements:
      @code(B* = B · e₁₂₃⁻¹).
      For example: @code((e₁∧e₂)* = -e₃),  @code((e₁∧e₃)* = e₂),  @code((e₂∧e₃)* = -e₁).
    }
    function Dual: TCL3Vector;

    { Returns the inverse of the bivector under the geometric product.
      For a pure bivector @code(B), the inverse is:
      @code(B⁻¹ = -B / |B|²), since @code(B² ≤ 0) in @code(Cl(3,0)).
    }
    function Inverse: TCL3Bivector;

    { Returns the reverse of the bivector.
      The reverse of a grade-@code(k) blade changes sign by @code((-1)^(k·(k-1)/2)).
      For a bivector (@code(k = 2)): @code(B̃ = -B).
    }
    function Reverse: TCL3Bivector;

    { Returns the Clifford conjugate of the bivector.
      The conjugate combines reversion and grade involution.
      For a bivector (@code(k = 2)): @code(B† = -B).
    }
    function Conjugate: TCL3Bivector;

    {
      Returns the reciprocal of the bivector: @code(B̃ / (B · B̃)).
      Equivalent to @link(Inverse) for non-zero bivectors.
    }
    function Reciprocal: TCL3Bivector;

    { Returns the unit bivector in the same orientation.
      Each component is divided by @link(Norm).
    }
    function Normalized: TCL3Bivector;

    { Returns the norm of the bivector: @code(|B| = √(m12² + m13² + m23²)).
      Defined as the square root of @code(-B²) since @code(B² ≤ 0) for pure bivectors.
    }
    function Norm: double;

    { Returns the squared norm of the bivector: @code(|B|² = m12² + m13² + m23²).
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: double;

    { Returns the inner (dot) product of the bivector and a vector.
      Lowers the grade: @code(grade(2) · grade(1) → grade(1) = vector).
      @param(AVector The grade-1 right operand.)
    }
    function Dot(const AVector: TCL3Vector): TCL3Vector; overload;

    { Returns the inner (dot) product of two bivectors.
      Lowers the grade: @code(grade(2) · grade(2) → grade(0) = scalar).
      Result: @code(B₁ · B₂ = -(m12₁·m12₂ + m13₁·m13₂ + m23₁·m23₂)).
      @param(AVector The grade-2 right operand.)
    }
    function Dot(const AVector: TCL3Bivector): double; overload;

    { Returns the inner (dot) product of the bivector and a trivector.
      Lowers the grade: @code(grade(2) · grade(3) → grade(1) = vector).
      @param(AVector The grade-3 right operand.)
    }
    function Dot(const AVector: TCL3Trivector): TCL3Vector; overload;

    { Returns the inner (dot) product of the bivector and a multivector.
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The right operand.)
    }
    function Dot(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the outer (wedge) product of the bivector and a vector.
      Raises the grade: @code(grade(2) ∧ grade(1) → grade(3) = trivector).
      @param(AVector The grade-1 right operand.)
    }
    function Wedge(const AVector: TCL3Vector): TCL3Trivector; overload;

    { Returns the outer (wedge) product of two bivectors.
      Always zero in @code(ℝ³): @code(grade(2) ∧ grade(2) → grade(4) = 0).
      @param(AVector The grade-2 right operand.)
    }
    function Wedge(const AVector: TCL3Bivector): double; overload;

    { Returns the outer (wedge) product of the bivector and a trivector.
      Always zero in @code(ℝ³): @code(grade(2) ∧ grade(3) → grade(5) = 0).
      @param(AVector The grade-3 right operand.)
    }
    function Wedge(const AVector: TCL3Trivector): double; overload;

    { Returns the outer (wedge) product of the bivector and a multivector.
      Only the scalar and vector parts of @code(AVector) contribute to a
      non-zero result; higher-grade wedge products vanish in @code(ℝ³).
      @param(AVector The right operand.)
    }
    function Wedge(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the projection of the bivector onto a vector subspace.
      Defined as: @code(proj(B, v) = (B · v⁻¹) ∧ v).
      The result is the component of @code(B) that lies in the plane
      containing @code(v).
      @param(AVector The vector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Vector): TCL3Bivector; overload;

    { Returns the projection of the bivector onto another bivector subspace.
      Defined as: @code(proj(B₁, B₂) = (B₁ · B₂⁻¹) ∧ B₂).
      @param(AVector The bivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Bivector): TCL3Bivector; overload;

    { Returns the projection of the bivector onto a trivector subspace.
      Defined as: @code(proj(B, T) = (B · T⁻¹) ∧ T).
      Since the trivector spans all of @code(ℝ³), the projection of any
      bivector onto it returns the bivector unchanged.
      @param(AVector The trivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Trivector): TCL3Bivector; overload;

    { Returns the projection of the bivector onto a multivector subspace.
      Defined as: @code(proj(B, M) = (B · M⁻¹) ∧ M).
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The multivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the rejection of the bivector from a vector subspace.
      Defined as: @code(rej(B, v) = B - proj(B, v)).
      The result is the component of @code(B) orthogonal to @code(v).
      @param(AVector The vector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Vector): TCL3Bivector; overload;

    { Returns the rejection of the bivector from another bivector subspace.
      Defined as: @code(rej(B₁, B₂) = B₁ - proj(B₁, B₂)).
      In @code(ℝ³) the rejection of a bivector from a bivector is a scalar.
      @param(AVector The bivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Bivector): double; overload;

    { Returns the rejection of the bivector from a trivector subspace.
      Defined as: @code(rej(B, T) = B - proj(B, T)).
      In @code(ℝ³) the rejection of a bivector from a trivector is a scalar.
      @param(AVector The trivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Trivector): double; overload;

    { Returns the rejection of the bivector from a multivector subspace.
      Defined as: @code(rej(B, M) = B - proj(B, M)).
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The multivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the reflection of the bivector through a vector.
      Defined as: @code(reflect(B, v) = -v · B · v⁻¹).
      Reflects the oriented plane of @code(B) through the hyperplane
      orthogonal to @code(v).
      @param(AVector The vector defining the reflection hyperplane normal.)
    }
    function Reflection(const AVector: TCL3Vector): TCL3Bivector; overload;

    { Returns the reflection of the bivector through another bivector.
      Defined as: @code(reflect(B₁, B₂) = -B₂ · B₁ · B₂⁻¹).
      @param(AVector The bivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Bivector): TCL3Bivector; overload;

    { Returns the reflection of the bivector through a trivector.
      Defined as: @code(reflect(B, T) = -T · B · T⁻¹).
      Since the pseudoscalar commutes with all even-grade elements, the
      reflection through a trivector returns the bivector unchanged.
      @param(AVector The trivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Trivector): TCL3Bivector; overload;

    { Returns the reflection of the bivector through a multivector.
      Defined as: @code(reflect(B, M) = -M · B · M⁻¹).
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The multivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the bivector rotated by the rotor defined by two vectors.
      The rotor is constructed as @code(R = AVector2 · AVector1)
      (normalised to a unit rotor). The rotation is applied as:
      @code(B' = R · B · R⁻¹).
      @param(AVector1 The first vector defining the rotation plane.)
      @param(AVector2 The second vector defining the rotation plane.)
    }
    function Rotation(const AVector1, AVector2: TCL3Vector): TCL3Bivector; overload;

    { Returns the bivector rotated by the rotor defined by two bivectors.
      The rotation is applied as: @code(B' = R · B · R⁻¹).
      @param(AVector1 The first bivector defining the rotor.)
      @param(AVector2 The second bivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Bivector; overload;

    { Returns the bivector rotated by the rotor defined by two trivectors.
      The rotation is applied as: @code(B' = R · B · R⁻¹).
      @param(AVector1 The first trivector defining the rotor.)
      @param(AVector2 The second trivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Bivector; overload;

    { Returns the bivector rotated by the rotor defined by two multivectors.
      The rotation is applied as: @code(B' = R · B · R⁻¹).
      The result is a full @link(TCL3Multivector) due to potential grade mixing.
      @param(AVector1 The first multivector defining the rotor.)
      @param(AVector2 The second multivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector; overload;

    { Returns @true if the bivector is numerically equal to the given multivector
      within the default floating point tolerance.
      All non-bivector components of @code(AValue) must be negligible.
      @param(AValue The multivector to compare against.)
    }
    function SameValue(const AValue: TCL3Multivector): boolean;

    { Returns @true if the two bivectors are numerically equal
      within the default floating point tolerance.
      @param(AValue The bivector to compare against.)
    }
    function SameValue(const AValue: TCL3Bivector): boolean;

    { Returns a new bivector containing only the components specified by @code(AComponents).
      Components not present in @code(AComponents) are set to zero.
      Useful for extracting specific basis blade contributions from a bivector.
      @param(AComponents A set of @link(TCL3MultivectorComponent) values identifying
                         the components to retain. Valid values are @code(mcm12),
                         @code(mcm13), @code(mcm23).)
    }
    function ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3Bivector;

    { Converts the bivector to a full @link(TCL3Multivector).
      All components are zero except @code(m12), @code(m13), @code(m23).
    }
    function ToMultivector: TCL3Multivector;

    { Converts the bivector to a formatted string with controlled precision.
      The format is @code(m12·e₁₂ + m13·e₁₃ + m23·e₂₃).
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: longint): string;

    { Converts the bivector to its default string representation.
      The format is @code(m12·e₁₂ + m13·e₁₃ + m23·e₂₃).
    }
    function ToString: string;
  end;

  { Record helper for @link(TCL3Vector) providing geometric operations
    specific to grade-1 elements of @code(Cl(3,0)).

    All operations follow the conventions of Clifford algebra over @code(R3):
    @unorderedList(
      @item(The geometric product is the fundamental product of the algebra.)
      @item(The inner (dot) product lowers the grade of the result.)
      @item(The outer (wedge) product raises the grade of the result.)
      @item(The dual maps a grade-@code(k) element to a grade-@code(3-k) element
            via multiplication by @code(e₁₂₃⁻¹)* )
      @item(The cross product is the dual of the wedge product:
            @code(u × v = (u ∧ v)* ) and is specific to @code(ℝ³).)
      @item(Projection, rejection, reflection and rotation are defined via the
            geometric product and its inverse.)
    )
  }
  TCL3VectorHelper = record helper for TCL3Vector

    { Returns the dual of the vector with respect to the pseudoscalar @code(e₁₂₃).
      The dual maps grade-1 elements to grade-2 (bivector) elements:
      @code(v* = v · e₁₂₃⁻¹).
      For example: @code(e₁* = -e₂∧e₃), @code(e₂* = e₁∧e₃), @code(e₃* = -e₁∧e₂).
    }
    function Dual: TCL3Bivector;

    { Returns the inverse of the vector under the geometric product.
      For a non-zero vector @code(v):
      @code(v⁻¹ = v / |v|²), since @code(v² = |v|² > 0) in @code(Cl(3,0)).
    }
    function Inverse: TCL3Vector;

    { Returns the reverse of the vector.
      The reverse of a grade-@code(k) blade changes sign by @code((-1)^(k·(k-1)/2)).
      For a vector (@code(k = 1)): @code(ṽ = v) (unchanged).
    }
    function Reverse: TCL3Vector;

    { Returns the Clifford conjugate of the vector.
      The conjugate combines reversion and grade involution.
      For a vector (@code(k = 1)): @code(v† = -v).
    }
    function Conjugate: TCL3Vector;

    { Returns the reciprocal of the vector: @code(ṽ / (v · ṽ)).
      Equivalent to @link(Inverse) for non-zero vectors.
    }
    function Reciprocal: TCL3Vector;

    { Returns the unit vector in the same direction.
      Each component is divided by @link(Norm).
    }
    function Normalized: TCL3Vector;

    { Returns the Euclidean norm of the vector: @code(|v| = √(m1² + m2² + m3²)).
      Defined as the square root of @code(v · ṽ = v²) since @code(v² ≥ 0)
      for vectors in @code(Cl(3,0)).
    }
    function Norm: double;

    { Returns the squared Euclidean norm of the vector:
      @code(|v|² = m1² + m2² + m3²).
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: double;

    { Returns the inner (dot) product of two vectors.
      Lowers the grade: @code(grade(1) · grade(1) → grade(0) = scalar).
      Result: @code(u · v = m1₁·m1₂ + m2₁·m2₂ + m3₁·m3₂).
      @param(AVector The grade-1 right operand.)
    }
    function Dot(const AVector: TCL3Vector): double; overload;

    { Returns the inner (dot) product of a vector and a bivector.
      Lowers the grade: @code(grade(1) · grade(2) → grade(1) = vector).
      @param(AVector The grade-2 right operand.)
    }
    function Dot(const AVector: TCL3Bivector): TCL3Vector; overload;

    { Returns the inner (dot) product of a vector and a trivector.
      Lowers the grade: @code(grade(1) · grade(3) → grade(2) = bivector).
      @param(AVector The grade-3 right operand.)
    }
    function Dot(const AVector: TCL3Trivector): TCL3Bivector; overload;

    { Returns the inner (dot) product of a vector and a multivector.
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The right operand.)
    }
    function Dot(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the outer (wedge) product of two vectors.
      Raises the grade: @code(grade(1) ∧ grade(1) → grade(2) = bivector).
      The result represents the oriented plane spanned by the two vectors.
      @param(AVector The grade-1 right operand.)
    }
    function Wedge(const AVector: TCL3Vector): TCL3Bivector; overload;

    { Returns the outer (wedge) product of a vector and a bivector.
      Raises the grade: @code(grade(1) ∧ grade(2) → grade(3) = trivector).
      The result represents the oriented volume spanned by the vector and the bivector.
      @param(AVector The grade-2 right operand.)
    }
    function Wedge(const AVector: TCL3Bivector): TCL3Trivector; overload;

    { Returns the outer (wedge) product of a vector and a trivector.
      Always zero in @code(ℝ³): @code(grade(1) ∧ grade(3) → grade(4) = 0).
      @param(AVector The grade-3 right operand.)
    }
    function Wedge(const AVector: TCL3Trivector): double; overload;

    { Returns the outer (wedge) product of a vector and a multivector.
      Only components of @code(AVector) up to grade 2 contribute to a non-zero result.
      @param(AVector The right operand.)
    }
    function Wedge(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the cross product of two vectors.
      The cross product is the dual of the wedge product:
      @code(u × v = (u ∧ v)* = -(u ∧ v) · e₁₂₃⁻¹).
      The result is a vector perpendicular to both operands with magnitude
      @code(|u||v|sin(θ)), specific to @code(ℝ³).
      @param(AVector The right operand.)
    }
    function Cross(const AVector: TCL3Vector): TCL3Vector;

    { Returns the projection of the vector onto another vector.
      Defined as: @code(proj(u, v) = (u · v⁻¹) ∧ v = (u · v / |v|²) · v).
      The result is the component of @code(u) parallel to @code(v).
      @param(AVector The vector defining the direction to project onto.)
    }
    function Projection(const AVector: TCL3Vector): TCL3Vector; overload;

    { Returns the projection of the vector onto a bivector subspace.
      Defined as: @code(proj(v, B) = (v · B⁻¹) ∧ B).
      The result is the component of @code(v) lying in the plane of @code(B).
      @param(AVector The bivector defining the plane to project onto.)
    }
    function Projection(const AVector: TCL3Bivector): TCL3Vector; overload;

    { Returns the projection of the vector onto a trivector subspace.
      Defined as: @code(proj(v, T) = (v · T⁻¹) ∧ T).
      Since the trivector spans all of @code(ℝ³), the projection of any
      vector onto it returns the vector unchanged.
      @param(AVector The trivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Trivector): TCL3Vector; overload;

    { Returns the projection of the vector onto a multivector subspace.
      Defined as: @code(proj(v, M) = (v · M⁻¹) ∧ M).
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The multivector defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the rejection of the vector from another vector.
      Defined as: @code(rej(u, v) = u - proj(u, v)).
      The result is the component of @code(u) perpendicular to @code(v).
      @param(AVector The vector defining the direction to reject from.)
    }
    function Rejection(const AVector: TCL3Vector): TCL3Vector; overload;

    { Returns the rejection of the vector from a bivector subspace.
      Defined as: @code(rej(v, B) = v - proj(v, B)).
      The result is the component of @code(v) perpendicular to the plane of @code(B).
      @param(AVector The bivector defining the plane to reject from.)
    }
    function Rejection(const AVector: TCL3Bivector): TCL3Vector; overload;

    { Returns the rejection of the vector from a trivector subspace.
      Defined as: @code(rej(v, T) = v - proj(v, T)).
      In @code(ℝ³) the rejection of a vector from a trivector is always zero,
      returned as a scalar @code(0).
      @param(AVector The trivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Trivector): double; overload;

    { Returns the rejection of the vector from a multivector subspace.
      Defined as: @code(rej(v, M) = v - proj(v, M)).
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The multivector defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the reflection of the vector through another vector.
      Defined as: @code(reflect(u, v) = v · u · v⁻¹).
      Reflects @code(u) through the line defined by @code(v),
      reversing the perpendicular component and preserving the parallel one.
      @param(AVector The vector defining the reflection axis.)
    }
    function Reflection(const AVector: TCL3Vector): TCL3Vector; overload;

    { Returns the reflection of the vector through a bivector.
      Defined as: @code(reflect(v, B) = B · v · B⁻¹).
      Reflects @code(v) through the plane represented by @code(B),
      reversing the normal component and preserving the in-plane component.
      @param(AVector The bivector defining the reflection plane.)
    }
    function Reflection(const AVector: TCL3Bivector): TCL3Vector; overload;

    { Returns the reflection of the vector through a trivector.
      Defined as: @code(reflect(v, T) = T · v · T⁻¹).
      Since the pseudoscalar commutes with odd-grade elements up to a sign,
      the reflection through a trivector negates the vector: @code(T·v·T⁻¹ = -v).
      @param(AVector The trivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Trivector): TCL3Vector; overload;

    { Returns the reflection of the vector through a multivector.
      Defined as: @code(reflect(v, M) = M · v · M⁻¹).
      The result is a full @link(TCL3Multivector) due to grade mixing.
      @param(AVector The multivector defining the reflection element.)
    }
    function Reflection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    { Returns the vector rotated by the rotor defined by two vectors.
      The rotor is constructed as @code(R = AVector2 · AVector1)
      (normalised to a unit rotor). The rotation is applied as:
      @code(v' = R · v · R⁻¹).
      The rotation is in the plane spanned by @code(AVector1) and @code(AVector2),
      by twice the angle between them.
      @param(AVector1 The first vector defining the rotation plane.)
      @param(AVector2 The second vector defining the rotation plane.)
    }
    function Rotation(const AVector1, AVector2: TCL3Vector): TCL3Vector; overload;

    { Returns the vector rotated by the rotor defined by two bivectors.
      The rotation is applied as: @code(v' = R · v · R⁻¹).
      @param(AVector1 The first bivector defining the rotor.)
      @param(AVector2 The second bivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Vector; overload;

    { Returns the vector rotated by the rotor defined by two trivectors.
      The rotation is applied as: @code(v' = R · v · R⁻¹).
      @param(AVector1 The first trivector defining the rotor.)
      @param(AVector2 The second trivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Vector; overload;

    { Returns the vector rotated by the rotor defined by two multivectors.
      The rotation is applied as: @code(v' = R · v · R⁻¹).
      The result is a full @link(TCL3Multivector) due to potential grade mixing.
      @param(AVector1 The first multivector defining the rotor.)
      @param(AVector2 The second multivector defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector; overload;

    { Returns @true if the vector is numerically equal to the given multivector
      within the default floating point tolerance.
      All non-vector components of @code(AValue) must be negligible.
      @param(AValue The multivector to compare against.)
    }
    function SameValue(const AValue: TCL3Multivector): boolean;

    { Returns @true if the two vectors are numerically equal
      within the default floating point tolerance.
      @param(AValue The vector to compare against.)
    }
    function SameValue(const AValue: TCL3Vector): boolean;

    { Returns a new vector containing only the components specified by @code(AComponents).
      Components not present in @code(AComponents) are set to zero.
      Useful for extracting specific basis blade contributions from a vector.
      @param(AComponents A set of @link(TCL3MultivectorComponent) values identifying
                         the components to retain. Valid values are @code(mcm1),
                         @code(mcm2), @code(mcm3).)
    }
    function ExtractVector(AComponents: TCL3MultivectorComponents): TCL3Vector;

    { Converts the vector to a full @link(TCL3Multivector).
      All components are zero except @code(m1), @code(m2), @code(m3).
    }
    function ToMultivector: TCL3Multivector;

    { Converts the vector to a formatted string with controlled precision.
      The format is @code(m1·e₁ + m2·e₂ + m3·e₃).
      @param(APrecision Number of significant digits.)
      @param(ADigits    Minimum number of digits in the output.)
    }
    function ToString(APrecision, ADigits: longint): string;

    { Converts the vector to its default string representation.
      The format is @code(m1·e₁ + m2·e₂ + m3·e₃).
    }
    function ToString: string;
  end;

  { Represents the basis vector @code(e₁) of @code(Cl(3,0)).
    Acts as a compile-time constant unit vector along the first axis.
    Multiplying a scalar by this record yields a grade-1 vector scaled along @code(e₁).
  }
  TCL3Versor1 = record
    { Returns the vector @code(AValue · e₁).
      @code(AValue * e₁ = (0, AValue, 0, 0, ...))
    }
    class operator *(const AValue: double; const ASelf: TCL3Versor1): TCL3Vector;
  end;

  { Represents the basis vector @code(e₂) of @code(Cl(3,0)).
    Acts as a compile-time constant unit vector along the second axis.
    Multiplying a scalar by this record yields a grade-1 vector scaled along @code(e₂).
  }
  TCL3Versor2 = record
    { Returns the vector @code(AValue · e₂).
      @code(AValue * e₂ = (0, 0, AValue, 0, ...))
    }
    class operator *(const AValue: double; const ASelf: TCL3Versor2): TCL3Vector;
  end;

  { Represents the basis vector @code(e₃) of @code(Cl(3,0)).
    Acts as a compile-time constant unit vector along the third axis.
    Multiplying a scalar by this record yields a grade-1 vector scaled along @code(e₃).
  }
  TCL3Versor3 = record
    { Returns the vector @code(AValue · e₃).
      @code(AValue * e₃ = (0, 0, 0, AValue, ...))
    }
    class operator *(const AValue: double; const ASelf: TCL3Versor3): TCL3Vector;
  end;

  { Represents the basis bivector @code(e₁∧e₂) of @code(Cl(3,0)).
    Acts as a compile-time constant unit bivector in the @code(e₁e₂) plane.
    Multiplying a scalar by this record yields a grade-2 bivector scaled along @code(e₁∧e₂).
    Satisfies @code((e₁∧e₂)² = -1).
  }
  TCL3Biversor12 = record
    { Returns the bivector @code(AValue · e₁∧e₂).
      @code(AValue * e₁₂ = (0, ..., AValue, 0, 0, 0))
    }
    class operator *(const AValue: double; const ASelf: TCL3Biversor12): TCL3Bivector;
  end;

  { Represents the basis bivector @code(e₁∧e₃) of @code(Cl(3,0)).
    Acts as a compile-time constant unit bivector in the @code(e₁e₃) plane.
    Multiplying a scalar by this record yields a grade-2 bivector scaled along @code(e₁∧e₃).
    Satisfies @code((e₁∧e₃)² = -1).
  }
  TCL3Biversor13 = record
    { Returns the bivector @code(AValue · e₁∧e₃).
      @code(AValue * e₁₃ = (0, ..., 0, AValue, 0, 0))
    }
    class operator *(const AValue: double; const ASelf: TCL3Biversor13): TCL3Bivector;
  end;

  { Represents the basis bivector @code(e₂∧e₃) of @code(Cl(3,0)).
    Acts as a compile-time constant unit bivector in the @code(e₂e₃) plane.
    Multiplying a scalar by this record yields a grade-2 bivector scaled along @code(e₂∧e₃).
    Satisfies @code((e₂∧e₃)² = -1).
  }
  TCL3Biversor23 = record
    { Returns the bivector @code(AValue · e₂∧e₃).
      @code(AValue * e₂₃ = (0, ..., 0, 0, AValue, 0))
    }
    class operator *(const AValue: double; const ASelf: TCL3Biversor23): TCL3Bivector;
  end;

  { Represents the unit pseudoscalar @code(e₁∧e₂∧e₃) of @code(Cl(3,0)).
    Acts as a compile-time constant unit trivector (the oriented unit volume of @code(ℝ³)).
    Multiplying a scalar by this record yields a grade-3 trivector scaled along @code(e₁∧e₂∧e₃).
    Satisfies @code((e₁∧e₂∧e₃)² = -1).
    The pseudoscalar commutes with all elements of @code(Cl(3,0)) and generates
    the duality transformation between vectors and bivectors.
  }
  TCL3Triversor123 = record
    { Returns the trivector @code(AValue · e₁∧e₂∧e₃).
      @code(AValue * e₁₂₃ = (0, ..., AValue))
    }
    class operator *(const AValue: double; const ASelf: TCL3Triversor123): TCL3Trivector;
  end;

  { Represents a general multivector of @code(Cl(3,0)) with physical dimensions.

    Combines a @link(TCL3Multivector) value with a @link(TDimension), supporting
    the full geometric algebra arithmetic while preserving dimensional consistency.
    All eight grades (scalar, vector, bivector, trivector) are present simultaneously,
    each carrying the same physical dimension stored in @code(FDim).

    Arithmetic operations follow both the rules of @code(Cl(3,0)) and the rules
    of dimensional analysis: incompatible dimensions raise an exception at runtime.
    When the symbol @code(ADIMOFF) is defined, this type degenerates to
    @link(TCL3Multivector) and all dimension checking is disabled.
  }
  {$IFNDEF ADIMOFF}
  TCL3MultivecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL3Multivector;
  public
    { Returns @true if the two multivector quantities differ in dimension or in any component. }
    class operator <>(const ALeft, ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if both multivector quantities have the same dimension and all components are equal. }
    class operator =(const ALeft, ARight: TCL3MultivecQuantity): boolean;

    { Returns the component-wise sum of two multivector quantities.
      Both operands must have the same dimension.
    }
    class operator +(const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Unary minus. Returns the negation of the multivector quantity.
      Each component @code(mₖ) becomes @code(-mₖ).
    }
    class operator -(const ASelf: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the component-wise difference of two multivector quantities.
      Both operands must have the same dimension.
    }
    class operator -(const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of two multivector quantities.
      The resulting dimension is the product of the two dimensions.
      The geometric product follows the full @code(Cl(3,0)) multiplication rules.
    }
    class operator *(const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of two multivector quantities: @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a dimensionless real scalar divided by a multivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the inverse of @code(ARight).
    }
    class operator /(const ALeft: double; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a multivector quantity divided by a dimensionless real scalar.
      Each component is divided by @code(ARight). The dimension is preserved.
    }
    class operator /(const ALeft: TCL3MultivecQuantity; const ARight: double): TCL3MultivecQuantity;

    { Returns @true if the multivector quantity and the real quantity differ in dimension or in any component. }
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): boolean;

    { Returns @true if the real quantity and the multivector quantity differ in dimension or in any component. }
    class operator <>(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the multivector quantity equals the real quantity,
      i.e. all non-scalar components are negligible.
    }
    class operator =(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): boolean;

    { Returns @true if the real quantity equals the multivector quantity,
      i.e. all non-scalar components are negligible.
    }
    class operator =(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns the sum of a multivector quantity and a real quantity.
      Both operands must have the same dimension.
    }
    class operator +(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;

    { Returns the sum of a real quantity and a multivector quantity.
      Both operands must have the same dimension.
    }
    class operator +(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a multivector quantity and a real quantity.
      Both operands must have the same dimension.
    }
    class operator -(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;

    { Returns the difference of a real quantity and a multivector quantity.
      Both operands must have the same dimension.
    }
    class operator -(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a multivector quantity and a real quantity.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a real quantity and a multivector quantity.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a multivector quantity divided by a real quantity: @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a real quantity divided by a multivector quantity: @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
  end;
  {$ELSE}
  TCL3MultivecQuantity = TCL3Multivector;
  {$ENDIF}

  { Represents a pure trivector (grade-3 element) of @code(Cl(3,0)) with physical dimensions.

    Combines a @link(TCL3Trivector) value with a @link(TDimension), supporting
    geometric algebra arithmetic while preserving dimensional consistency.
    The physical dimension is stored in @code(FDim) and shared by the single
    pseudoscalar component @code(m123·e₁∧e₂∧e₃).

    When combined with elements of other grades the result is promoted to a full
    @link(TCL3MultivecQuantity). When the symbol @code(ADIMOFF) is defined, this
    type degenerates to @link(TCL3Trivector) and all dimension checking is disabled.
  }
  {$IFNDEF ADIMOFF}
  TCL3TrivecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL3Trivector;
  public
    { Implicit conversion from a trivector quantity to a full multivector quantity.
      All components of the result are zero except @code(m123).
      The dimension is preserved.
    }
    class operator :=(const AValue: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns @true if the two trivector quantities differ in dimension or in their @code(m123) coefficient. }
    class operator <>(const ALeft, ARight: TCL3TrivecQuantity): boolean;

    { Returns @true if the trivector quantity and the multivector quantity differ in dimension or in any component. }
    class operator <>(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the multivector quantity and the trivector quantity differ in dimension or in any component. }
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): boolean;

    { Returns @true if both trivector quantities have the same dimension and equal @code(m123) coefficients. }
    class operator =(const ALeft, ARight: TCL3TrivecQuantity): boolean;

    { Returns @true if the trivector quantity equals the multivector quantity,
      i.e. all non-trivector components of @code(ARight) are negligible.
    }
    class operator =(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the multivector quantity equals the trivector quantity,
      i.e. all non-trivector components of @code(ALeft) are negligible.
    }
    class operator =(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): boolean;

    { Returns the sum of two trivector quantities. Both operands must have the same dimension.
      The result is a pure trivector quantity.
    }
    class operator +(const ALeft, ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the sum of a trivector quantity and a multivector quantity.
      Both operands must have the same dimension.
    }
    class operator +(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of a multivector quantity and a trivector quantity.
      Both operands must have the same dimension.
    }
    class operator +(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Unary minus. Returns the negation of the trivector quantity.
      The coefficient @code(m123) becomes @code(-m123).
    }
    class operator -(const ASelf: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the difference of two trivector quantities. Both operands must have the same dimension.
      The result is a pure trivector quantity.
    }
    class operator -(const ALeft, ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the difference of a trivector quantity and a multivector quantity.
      Both operands must have the same dimension.
    }
    class operator -(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a multivector quantity and a trivector quantity.
      Both operands must have the same dimension.
    }
    class operator -(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a trivector quantity and a multivector quantity.
      The resulting dimension is the product of the two dimensions.
      Grade mixing occurs according to the @code(Cl(3,0)) multiplication rules.
    }
    class operator *(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a multivector quantity and a trivector quantity.
      The resulting dimension is the product of the two dimensions.
      Grade mixing occurs according to the @code(Cl(3,0)) multiplication rules.
    }
    class operator *(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of two trivector quantities.
      Since @code(e₁₂₃² = -1), the result is a scalar quantity:
      @code((m123₁·e₁₂₃) · (m123₂·e₁₂₃) = -m123₁·m123₂).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft, ARight: TCL3TrivecQuantity): TQuantity;

    { Returns the geometric product of a real quantity scalar and a trivector quantity.
      The coefficient @code(m123) is scaled by @code(ALeft).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the geometric product of a trivector quantity and a real quantity scalar.
      The coefficient @code(m123) is scaled by @code(ARight).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;

    { Returns the geometric quotient of two trivector quantities: @code(ALeft * ARight⁻¹).
      Since @code(e₁₂₃² = -1), the result is a scalar quantity:
      @code((m123₁·e₁₂₃) / (m123₂·e₁₂₃) = -m123₁/m123₂).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft, ARight: TCL3TrivecQuantity): TQuantity;

    { Returns the geometric quotient of a dimensionless real scalar divided by a trivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the inverse of @code(ARight).
    }
    class operator /(const ALeft: double; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the geometric quotient of a trivector quantity divided by a dimensionless real scalar.
      The coefficient @code(m123) is divided by @code(ARight). The dimension is preserved.
    }
    class operator /(const ALeft: TCL3TrivecQuantity; const ARight: double): TCL3TrivecQuantity;

    { Returns the geometric quotient of a trivector quantity divided by a multivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a multivector quantity divided by a trivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a trivector quantity divided by a real quantity scalar:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;

    { Returns the geometric quotient of a real quantity scalar divided by a trivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the sum of a trivector quantity and a real quantity. Both operands must have the same dimension.
      The result is a full multivector quantity with the scalar part from @code(ARight) and grade-3 part from @code(ALeft).
    }
    class operator +(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;

    { Returns the sum of a real quantity and a trivector quantity. Both operands must have the same dimension.
      The result is a full multivector quantity with the scalar part from @code(ALeft) and grade-3 part from @code(ARight).
    }
    class operator +(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a trivector quantity and a real quantity. Both operands must have the same dimension.
      The result is a full multivector quantity with negated scalar part from @code(ARight) and grade-3 part from @code(ALeft).
    }
    class operator -(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;

    { Returns the difference of a real quantity and a trivector quantity. Both operands must have the same dimension.
      The result is a full multivector quantity with scalar part from @code(ALeft) and negated grade-3 part from @code(ARight).
    }
    class operator -(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
  end;
  {$ELSE}
  TCL3TrivecQuantity = TCL3Trivector;
  {$ENDIF}

  { Represents a pure bivector (grade-2 element) of @code(Cl(3,0)) with physical dimensions.

    Combines a @link(TCL3Bivector) value with a @link(TDimension), supporting
    geometric algebra arithmetic while preserving dimensional consistency.
    The physical dimension is stored in @code(FDim) and shared by the three
    bivector components @code(m12·e₁∧e₂ + m13·e₁∧e₃ + m23·e₂∧e₃).

    When combined with elements of other grades the result is promoted to a full
    @link(TCL3MultivecQuantity). The geometric product of two bivector quantities
    produces a mixed-grade result (scalar + bivector), hence a full
    @link(TCL3MultivecQuantity). When the symbol @code(ADIMOFF) is defined, this
    type degenerates to @link(TCL3Bivector) and all dimension checking is disabled.
  }
  {$IFNDEF ADIMOFF}
  TCL3BivecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL3Bivector;
  public
    { Implicit conversion from a bivector quantity to a full multivector quantity.
      All components of the result are zero except @code(m12), @code(m13), @code(m23).
      The dimension is preserved.
    }
    class operator :=(const AValue: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns @true if the two bivector quantities differ in dimension or in any bivector component. }
    class operator <>(const ALeft, ARight: TCL3BivecQuantity): boolean;

    { Returns @true if the bivector quantity and the multivector quantity differ in dimension or in any component. }
    class operator <>(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the multivector quantity and the bivector quantity differ in dimension or in any component. }
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): boolean;

    { Returns @true if both bivector quantities have the same dimension and all corresponding components are equal. }
    class operator =(const ALeft, ARight: TCL3BivecQuantity): boolean;

    { Returns @true if the bivector quantity equals the multivector quantity,
      i.e. all non-bivector components of @code(ARight) are negligible.
    }
    class operator =(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the multivector quantity equals the bivector quantity,
      i.e. all non-bivector components of @code(ALeft) are negligible.
    }
    class operator =(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): boolean;

    { Returns the component-wise sum of two bivector quantities. Both operands must have the same dimension.
      The result is a pure bivector quantity.
    }
    class operator +(const ALeft, ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the sum of a bivector quantity and a trivector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with grade-2 components from @code(ALeft) and grade-3 component from @code(ARight).
    }
    class operator +(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of a trivector quantity and a bivector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with grade-3 component from @code(ALeft) and grade-2 components from @code(ARight).
    }
    class operator +(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of a bivector quantity and a multivector quantity. Both operands must have the same dimension.
      The bivector contributes only to the grade-2 components.
    }
    class operator +(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of a multivector quantity and a bivector quantity. Both operands must have the same dimension.
      The bivector contributes only to the grade-2 components.
    }
    class operator +(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Unary minus. Returns the negation of the bivector quantity.
      Each component @code(mₖ) becomes @code(-mₖ).
    }
    class operator -(const ASelf: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the component-wise difference of two bivector quantities. Both operands must have the same dimension.
      The result is a pure bivector quantity.
    }
    class operator -(const ALeft, ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the difference of a bivector quantity and a trivector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with grade-2 components from @code(ALeft) and negated grade-3 component from @code(ARight).
    }
    class operator -(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a trivector quantity and a bivector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with grade-3 component from @code(ALeft) and negated grade-2 components from @code(ARight).
    }
    class operator -(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a bivector quantity and a multivector quantity. Both operands must have the same dimension.
      The bivector contributes only to the grade-2 components.
    }
    class operator -(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a multivector quantity and a bivector quantity. Both operands must have the same dimension.
      The bivector contributes only to the grade-2 components.
    }
    class operator -(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of two bivector quantities.
      The result is a mixed-grade element (scalar + bivector), hence a full @link(TCL3MultivecQuantity).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft, ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a bivector quantity and a multivector quantity.
      The resulting dimension is the product of the two dimensions.
      Grade mixing occurs according to the @code(Cl(3,0)) multiplication rules.
    }
    class operator *(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a bivector quantity and a trivector quantity.
      The resulting dimension is the product of the two dimensions.
      Grade mixing occurs according to the @code(Cl(3,0)) multiplication rules.
    }
    class operator *(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a trivector quantity and a bivector quantity.
      The resulting dimension is the product of the two dimensions.
      Grade mixing occurs according to the @code(Cl(3,0)) multiplication rules.
    }
    class operator *(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a multivector quantity and a bivector quantity.
      The resulting dimension is the product of the two dimensions.
      Grade mixing occurs according to the @code(Cl(3,0)) multiplication rules.
    }
    class operator *(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a real quantity scalar and a bivector quantity.
      Each component is scaled by @code(ALeft).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the geometric product of a bivector quantity and a real quantity scalar.
      Each component is scaled by @code(ARight).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3BivecQuantity;

    { Returns the geometric quotient of two bivector quantities: @code(ALeft * ARight⁻¹).
      The result is a mixed-grade element, hence a full @link(TCL3MultivecQuantity).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft, ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a dimensionless real scalar divided by a bivector quantity:
      @code(ALeft * ARight⁻¹).
      The inverse of a bivector @code(B) is @code(B⁻¹ = -B / |B|²).
      The resulting dimension is the inverse of @code(ARight).
    }
    class operator /(const ALeft: double; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the geometric quotient of a bivector quantity divided by a dimensionless real scalar.
      Each component is divided by @code(ARight). The dimension is preserved.
    }
    class operator /(const ALeft: TCL3BivecQuantity; const ARight: double): TCL3BivecQuantity;

    { Returns the geometric quotient of a bivector quantity divided by a trivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a trivector quantity divided by a bivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a bivector quantity divided by a multivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a multivector quantity divided by a bivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a bivector quantity divided by a real quantity scalar:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3BivecQuantity;

    { Returns the geometric quotient of a real quantity scalar divided by a bivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the sum of a bivector quantity and a real quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = ARight) and the bivector components of @code(ALeft).
    }
    class operator +(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;

    { Returns the sum of a real quantity and a bivector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = ALeft) and the bivector components of @code(ARight).
    }
    class operator +(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a bivector quantity and a real quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = -ARight) and the bivector components of @code(ALeft).
    }
    class operator -(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;

    { Returns the difference of a real quantity and a bivector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = ALeft) and negated bivector components of @code(ARight).
    }
    class operator -(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
  end;
  {$ELSE}
  TCL3BivecQuantity = TCL3Bivector;
  {$ENDIF}

  { Represents a pure vector (grade-1 element) of @code(Cl(3,0)) with physical dimensions.

    Combines a @link(TCL3Vector) value with a @link(TDimension), supporting
    geometric algebra arithmetic while preserving dimensional consistency.
    The physical dimension is stored in @code(FDim) and shared by the three
    vector components @code(m1·e₁ + m2·e₂ + m3·e₃).

    When combined with elements of other grades the result is generally promoted
    to a full @link(TCL3MultivecQuantity), with the following notable exceptions:
    @unorderedList(
      @item(The geometric product @code(v * T) and @code(T * v) with a trivector
            returns a @link(TCL3BivecQuantity), since @code(eᵢ · e₁₂₃ = ±eⱼ∧eₖ).)
      @item(The geometric quotient @code(v / T) and @code(T / v) analogously
            returns a @link(TCL3BivecQuantity).)
    )
    When the symbol @code(ADIMOFF) is defined, this type degenerates to
    @link(TCL3Vector) and all dimension checking is disabled.
  }
  {$IFNDEF ADIMOFF}
  TCL3VecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL3Vector;
  public
    { Implicit conversion from a vector quantity to a full multivector quantity.
      All components of the result are zero except @code(m1), @code(m2), @code(m3).
      The dimension is preserved.
    }
    class operator :=(const AValue: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns @true if the two vector quantities differ in dimension or in any vector component. }
    class operator <>(const ALeft, ARight: TCL3VecQuantity): boolean;

    { Returns @true if the vector quantity and the multivector quantity differ in dimension or in any component. }
    class operator <>(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the multivector quantity and the vector quantity differ in dimension or in any component. }
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): boolean;

    { Returns @true if both vector quantities have the same dimension and all corresponding components are equal. }
    class operator =(const ALeft, ARight: TCL3VecQuantity): boolean;

    { Returns @true if the vector quantity equals the multivector quantity,
      i.e. all non-vector components of @code(ARight) are negligible.
    }
    class operator =(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the multivector quantity equals the vector quantity,
      i.e. all non-vector components of @code(ALeft) are negligible.
    }
    class operator =(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): boolean;

    { Returns the component-wise sum of two vector quantities. Both operands must have the same dimension.
      The result is a pure vector quantity.
    }
    class operator +(const ALeft, ARight: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the sum of a vector quantity and a bivector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with grade-1 components from @code(ALeft) and grade-2 components from @code(ARight).
    }
    class operator +(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of a bivector quantity and a vector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with grade-2 components from @code(ALeft) and grade-1 components from @code(ARight).
    }
    class operator +(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the sum of a vector quantity and a trivector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with grade-1 components from @code(ALeft) and grade-3 component from @code(ARight).
    }
    class operator +(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of a trivector quantity and a vector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with grade-3 component from @code(ALeft) and grade-1 components from @code(ARight).
    }
    class operator +(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the sum of a vector quantity and a multivector quantity. Both operands must have the same dimension.
      The vector contributes only to the grade-1 components.
    }
    class operator +(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of a multivector quantity and a vector quantity. Both operands must have the same dimension.
      The vector contributes only to the grade-1 components.
    }
    class operator +(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Unary minus. Returns the negation of the vector quantity.
      Each component @code(mₖ) becomes @code(-mₖ).
    }
    class operator -(const ASelf: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the component-wise difference of two vector quantities. Both operands must have the same dimension.
      The result is a pure vector quantity.
    }
    class operator -(const ALeft, ARight: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the difference of a vector quantity and a bivector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with grade-1 components from @code(ALeft) and negated grade-2 components from @code(ARight).
    }
    class operator -(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a bivector quantity and a vector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with grade-2 components from @code(ALeft) and negated grade-1 components from @code(ARight).
    }
    class operator -(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a vector quantity and a trivector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with grade-1 components from @code(ALeft) and negated grade-3 component from @code(ARight).
    }
    class operator -(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a trivector quantity and a vector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with grade-3 component from @code(ALeft) and negated grade-1 components from @code(ARight).
    }
    class operator -(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a vector quantity and a multivector quantity. Both operands must have the same dimension.
       The vector contributes only to the grade-1 components.
    }
    class operator -(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a multivector quantity and a vector quantity. Both operands must have the same dimension.
      The vector contributes only to the grade-1 components.
    }
    class operator -(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of two vector quantities.
      The result is a mixed-grade element (scalar + bivector), hence a full @link(TCL3MultivecQuantity).
      @code((u·v) = (u·v)_scalar + (u∧v)_bivector).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft, ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a vector quantity and a bivector quantity.
      The resulting dimension is the product of the two dimensions.
      Grade mixing occurs according to the @code(Cl(3,0)) multiplication rules.
    }
    class operator *(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a vector quantity and a trivector quantity.
      Since @code(eᵢ · e₁₂₃ = ±eⱼ∧eₖ), the result is a pure bivector quantity.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3BivecQuantity;

    { Returns the geometric product of a vector quantity and a multivector quantity.
      The resulting dimension is the product of the two dimensions.
      Grade mixing occurs according to the @code(Cl(3,0)) multiplication rules.
    }
    class operator *(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a bivector quantity and a vector quantity.
      The resulting dimension is the product of the two dimensions.
      Grade mixing occurs according to the @code(Cl(3,0)) multiplication rules.
    }
    class operator *(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a trivector quantity and a vector quantity.
      Since @code(e₁₂₃ · eᵢ = ±eⱼ∧eₖ), the result is a pure bivector quantity.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3BivecQuantity;

    { Returns the geometric product of a multivector quantity and a vector quantity.
      The resulting dimension is the product of the two dimensions.
      Grade mixing occurs according to the @code(Cl(3,0)) multiplication rules.
    }
    class operator *(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a real quantity scalar and a vector quantity.
      Each component is scaled by @code(ALeft).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the geometric product of a vector quantity and a real quantity scalar.
      Each component is scaled by @code(ARight).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3VecQuantity;

    { Returns the geometric quotient of two vector quantities: @code(ALeft * ARight⁻¹).
      The result is a mixed-grade element (scalar + bivector), hence a full @link(TCL3MultivecQuantity).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft, ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a dimensionless real scalar divided by a vector quantity:
      @code(ALeft * ARight⁻¹).
      The inverse of a vector @code(v) is @code(v⁻¹ = v / |v|²).
      The resulting dimension is the inverse of @code(ARight).
    }
    class operator /(const ALeft: double; const ARight: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the geometric quotient of a vector quantity divided by a dimensionless real scalar.
      Each component is divided by @code(ARight). The dimension is preserved.
    }
    class operator /(const ALeft: TCL3VecQuantity; const ARight: double): TCL3VecQuantity;

    { Returns the geometric quotient of a vector quantity divided by a bivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a vector quantity divided by a trivector quantity:
      @code(ALeft * ARight⁻¹).
      Since @code(eᵢ · e₁₂₃⁻¹ = ±eⱼ∧eₖ), the result is a pure bivector quantity.
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3BivecQuantity;

    { Returns the geometric quotient of a vector quantity divided by a multivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a bivector quantity divided by a vector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a trivector quantity divided by a vector quantity:
      @code(ALeft * ARight⁻¹).
      Since @code(e₁₂₃ · eᵢ⁻¹ = ±eⱼ∧eₖ), the result is a pure bivector quantity.
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3BivecQuantity;

    { Returns the geometric quotient of a multivector quantity divided by a vector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a vector quantity divided by a real quantity scalar:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3VecQuantity;

    { Returns the geometric quotient of a real quantity scalar divided by a vector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the sum of a vector quantity and a real quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = ARight) and the vector components of @code(ALeft).
    }
    class operator +(const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;

    { Returns the sum of a real quantity and a vector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = ALeft) and the vector components of @code(ARight).
    }
    class operator +(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a vector quantity and a real quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = -ARight) and the vector components of @code(ALeft).
    }
    class operator -(const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;

    { Returns the difference of a real quantity and a vector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = ALeft) and negated vector components of @code(ARight).
    }
    class operator -(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
  end;
  {$ELSE}
  TCL3VecQuantity = TCL3Vector;
  {$ENDIF}

const
  { The zero multivector of @code(Cl(3,0)).
    All eight grade components are set to zero:
    @code(0 = 0 + 0·e₁ + 0·e₂ + 0·e₃ + 0·e₁₂ + 0·e₁₃ + 0·e₂₃ + 0·e₁₂₃).
    Useful as a neutral element for addition or as an initial accumulator
    in multivector summations.
  }
  CL3NullMultivector : TCL3Multivector = (fm0:0.0; fm1:0.0; fm2:0.0; fm3:0.0; fm12:0.0; fm13:0.0; fm23:0.0; fm123:0.0);

  { The zero trivector of @code(Cl(3,0)).
    The pseudoscalar coefficient is zero: @code(0·e₁∧e₂∧e₃).
    Useful as a neutral element for trivector addition.
  }
  CL3NullTrivector : TCL3Trivector = (fm123:0.0);

  { The zero bivector of @code(Cl(3,0)).
    All three bivector coefficients are zero:
    @code(0·e₁∧e₂ + 0·e₁∧e₃ + 0·e₂∧e₃).
    Useful as a neutral element for bivector addition.
  }
  CL3NullBivector : TCL3Bivector = (fm12:0.0; fm13:0.0; fm23:0.0);

  { The zero vector of @code(Cl(3,0)).
    All three vector coefficients are zero:
    @code(0·e₁ + 0·e₂ + 0·e₃).
    Useful as a neutral element for vector addition.
  }
  CL3NullVector : TCL3Vector = (fm1:0.0; fm2:0.0; fm3:0.0);

  { The zero scalar of @code(Cl(3,0)).
    Equivalent to the real number @code(0.0).
    Useful as a neutral element for scalar addition or as a default
    return value for operations that yield a dimensionless zero.
  }
  CL3NullScalar : double = (0.0);

type
  { Record helper for @link(TComplexQuantity) providing additional operations
    on complex physical quantities.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TComplexQuantityHelper = record helper for TComplexQuantity

    { Returns the complex conjugate of the quantity.
      If @code(z = (a + i·b) [dim]* ), the conjugate is @code(z* = (a - i·b) [dim]).
      The physical dimension is preserved.
    }
    function Conjugate: TComplexQuantity;

    { Returns the reciprocal of the complex quantity: @code(1 / z).
      The resulting dimension is the inverse of the original dimension.
    }
    function Reciprocal: TComplexQuantity;

    { Returns the modulus (magnitude) of the complex quantity as a real quantity.
      Defined as @code(|z| = √(Re² + Im²)).
      The resulting dimension equals the dimension of the original quantity.
    }
    function Norm: TQuantity;

    { Returns the squared modulus of the complex quantity as a real quantity.
      Defined as @code(|z|² = Re² + Im²).
      The resulting dimension is the square of the dimension of the original quantity.
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: TQuantity;
  end;
  {$ENDIF}

  { Fixed-size array of 2 complex quantities.
    Used to store eigenvalues of @link(TC2MatrixQuantity) or other
    2-element collections of @link(TComplexQuantity).
  }
  TC2ArrayOfQuantity = array[1..T2DSpace.N] of TComplexQuantity;

  { Fixed-size array of 3 complex quantities.
    Used to store eigenvalues of @link(TC3MatrixQuantity) or other
    3-element collections of @link(TComplexQuantity).
  }
  TC3ArrayOfQuantity = array[1..T3DSpace.N] of TComplexQuantity;

  { Fixed-size array of 4 complex quantities.
    Used to store eigenvalues of @link(TC4MatrixQuantity) or other
    4-element collections of @link(TComplexQuantity).
  }
  TC4ArrayOfQuantity = array[1..T4DSpace.N] of TComplexQuantity;

  { Fixed-size array of 2 complex quantity vectors (@link(TC2VecQuantity)).
    Used to store eigenvectors of @link(TC2MatrixQuantity).
  }
  TC2ArrayOfVecQuantity = array[1..T2DSpace.N] of TC2VecQuantity;

  { Fixed-size array of 3 complex quantity vectors (@link(TC3VecQuantity)).
    Used to store eigenvectors of @link(TC3MatrixQuantity).
  }
  TC3ArrayOfVecQuantity = array[1..T3DSpace.N] of TC3VecQuantity;

  { Fixed-size array of 4 complex quantity vectors (@link(TC4VecQuantity)).
    Used to store eigenvectors of @link(TC4MatrixQuantity).
  }
  TC4ArrayOfVecQuantity = array[1..T4DSpace.N] of TC4VecQuantity;

  { TC2MatrixQuantityHelper }

  { Record helper for @link(TC2MatrixQuantity) providing additional operations
    specific to 2×2 complex quantity matrices.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TC2MatrixQuantityHelper = record helper for TC2MatrixQuantity

    { Returns the diagonal matrix built from the given eigenvalues.
      The result is a 2×2 diagonal @link(TC2MatrixQuantity) with the
      eigenvalues on the main diagonal and zeros elsewhere.
      @param(AEigenvalues The eigenvalues, typically computed via @link(Eigenvalues).)
    }
    function Diagonalize(const AEigenvalues: TC2ArrayOfQuantity): TC2MatrixQuantity;

    { Returns the element-wise complex conjugate of the matrix.
      Each element @code(a[i,j] = (x + i·y) [dim]) becomes @code((x - i·y) [dim]).
      The physical dimension of each element is preserved.
    }
    function Conjugate: TC2MatrixQuantity;

    { Returns the determinant of the 2×2 complex quantity matrix.
      Defined as @code(det(A) = a₁₁·a₂₂ - a₁₂·a₂₁).
      The resulting dimension is the square of the element dimension.
    }
    function Determinant: TComplexQuantity;

    { Returns the eigenvalues of the 2×2 complex quantity matrix
      as a fixed-size array of @link(TComplexQuantity).
      The eigenvalues carry the same dimension as the matrix elements.
    }
    function Eigenvalues: TC2ArrayOfQuantity;

    { Returns the eigenvectors of the 2×2 complex quantity matrix
      corresponding to the given eigenvalues, as a fixed-size array
      of dimensionless @link(TC2Vector).
      @param(AEigenValues The eigenvalues, computed via @link(Eigenvalues).)
    }
    function Eigenvectors(const AEigenValues: TC2ArrayOfQuantity): TC2ArrayOfVector;

    { Returns the inverse of the matrix given its precomputed determinant.
      The resulting dimension is the inverse of the element dimension.
      @param(ADeterminant The determinant of the matrix, computed via @link(Determinant).)
    }
    function Reciprocal(const ADeterminant: TComplexQuantity): TC2MatrixQuantity;

    { Returns the conjugate transpose (Hermitian adjoint) of the matrix: @code(A† = (Aᵀ)* ).
      Each element @code([i,j]) of the result is the complex conjugate of @code([j,i])
      of the original. The physical dimension of each element is preserved.
    }
    function TransposeConjugate: TC2MatrixQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TC2VecQuantity) providing additional operations
    specific to 2-component complex quantity vectors.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TC2VecQuantityHelper = record helper for TC2VecQuantity

    { Returns the Hermitian inner product of two 2-component complex quantity vectors.
      Defined as @code(〈u, v〉 = Σ conj(uᵢ) · vᵢ).
      The conjugate of the left operand is used, consistent with the
      physics convention for Hermitian inner products.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right-hand operand.)
    }
    function Dot(const AVector: TC2VecQuantity): TComplexQuantity;

    { Returns the element-wise complex conjugate of the vector.
      Each component @code(vᵢ = (a + i·b) [dim]) becomes @code((a - i·b) [dim]).
      The physical dimension of each component is preserved.
    }
    function Conjugate: TC2VecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TC3VecQuantity) providing additional operations
    specific to 3-component complex quantity vectors.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TC3VecQuantityHelper = record helper for TC3VecQuantity

    { Returns the Hermitian inner product of two 3-component complex quantity vectors.
      Defined as @code(〈u, v〉 = Σ conj(uᵢ) · vᵢ).
      The conjugate of the left operand is used, consistent with the
      physics convention for Hermitian inner products.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right-hand operand.)
    }
    function Dot(const AVector: TC3VecQuantity): TComplexQuantity;

    { Returns the element-wise complex conjugate of the vector.
      Each component @code(vᵢ = (a + i·b) [dim]) becomes @code((a - i·b) [dim]).
      The physical dimension of each component is preserved.
    }
    function Conjugate: TC3VecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TC4VecQuantity) providing additional operations
    specific to 4-component complex quantity vectors.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TC4VecQuantityHelper = record helper for TC4VecQuantity

    { Returns the Hermitian inner product of two 4-component complex quantity vectors.
      Defined as @code(〈u, v〉 = Σ conj(uᵢ) · vᵢ).
      The conjugate of the left operand is used, consistent with the
      physics convention for Hermitian inner products.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right-hand operand.)
    }
    function Dot(const AVector: TC4VecQuantity): TComplexQuantity;

    { Returns the element-wise complex conjugate of the vector.
      Each component @code(vᵢ = (a + i·b) [dim]) becomes @code((a - i·b) [dim]).
      The physical dimension of each component is preserved.
    }
    function Conjugate: TC4VecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TR2VecQuantity) providing additional operations
    specific to 2-component real quantity vectors.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TR2VecQuantityHelper = record helper for TR2VecQuantity

    { Returns the dot product of two 2-component real quantity vectors.
      Defined as @code(u·v = u₁v₁ + u₂v₂).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right-hand operand.)
    }
    function Dot(const AVector: TR2VecQuantity): TQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TR3VecQuantity) providing additional operations
    specific to 3-component real quantity vectors.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TR3VecQuantityHelper = record helper for TR3VecQuantity

    { Returns the dot product of two 3-component real quantity vectors.
      Defined as @code(u·v = u₁v₁ + u₂v₂ + u₃v₃).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right-hand operand.)
    }
    function Dot(const AVector: TR3VecQuantity): TQuantity;

    { Returns the cross product of two 3-component real quantity vectors.
      Defined as @code(u×v = (u₂v₃ - u₃v₂, u₃v₁ - u₁v₃, u₁v₂ - u₂v₁)).
      The result is a vector perpendicular to both operands with magnitude
      @code(|u||v|sin(θ)).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right-hand operand.)
    }
    function Cross(const AVector: TR3VecQuantity): TR3VecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TR4VecQuantity) providing additional operations
    specific to 4-component real quantity vectors.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TR4VecQuantityHelper = record helper for TR4VecQuantity

    { Returns the dot product of two 4-component real quantity vectors.
      Defined as @code(u·v = u₁v₁ + u₂v₂ + u₃v₃ + u₄v₄).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right-hand operand.)
    }
    function Dot(const AVector: TR4VecQuantity): TQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TCL3MultivecQuantity) providing the full set of
    geometric algebra operations on multivector quantities of @code(Cl(3,0)).

    All operations follow the conventions of Clifford algebra over @code(ℝ³)
    with dimensional analysis. Incompatible dimensions raise an exception at runtime.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL3MultivecQuantityHelper = record helper for TCL3MultivecQuantity

    { Returns the dual of the multivector quantity with respect to the pseudoscalar @code(e₁₂₃).
      Defined as @code(M* = M · e₁₂₃⁻¹).
      Maps grade-@code(k) components to grade-@code(3-k) components.
      The physical dimension is preserved.
    }
    function Dual: TCL3MultivecQuantity;

    { Returns the inverse of the multivector quantity under the geometric product.
      Defined as @code(M⁻¹) such that @code(M · M⁻¹ = 1).
      The resulting dimension is the inverse of the original dimension.
      Not all multivectors are invertible; behaviour is undefined if @code(M)
      has no inverse.
    }
    function Inverse: TCL3MultivecQuantity;

    { Returns the reverse of the multivector quantity.
      The reverse of a grade-@code(k) blade changes sign by @code((-1)^(k·(k-1)/2)).
      For a general multivector: @code(M̃ = m0 + m1·e₁ + m2·e₂ + m3·e₃
      - m12·e₁₂ - m13·e₁₃ - m23·e₂₃ - m123·e₁₂₃).
      The physical dimension is preserved.
    }
    function Reverse: TCL3MultivecQuantity;

    { Returns the Clifford conjugate of the multivector quantity.
      Combines reversion and grade involution:
      @code(M† = m0 - m1·e₁ - m2·e₂ - m3·e₃ - m12·e₁₂ - m13·e₁₃ - m23·e₂₃ + m123·e₁₂₃).
      The physical dimension is preserved.
    }
    function Conjugate: TCL3MultivecQuantity;

    { Returns the right reciprocal of the multivector quantity: @code(M̃ / (M · M̃)).
      Satisfies @code(M · Reciprocal(M) = 1).
      The resulting dimension is the inverse of the original dimension.
    }
    function Reciprocal: TCL3MultivecQuantity;

    { Returns the left reciprocal of the multivector quantity: @code(M̃ / (M̃ · M)).
      Satisfies @code(LeftReciprocal(M) · M = 1).
      For non-degenerate multivectors, left and right reciprocals coincide.
      The resulting dimension is the inverse of the original dimension.
    }
    function LeftReciprocal: TCL3MultivecQuantity;

    { Returns the unit multivector in the same direction.
      Each component is divided by @link(Norm).
      The physical dimension is preserved.
    }
    function Normalized: TCL3MultivecQuantity;

    { Returns the norm of the multivector quantity: @code(|M| = √(M · M̃)).
      The resulting dimension equals the dimension of the original quantity.
    }
    function Norm: TQuantity;

    { Returns the squared norm of the multivector quantity: @code(|M|² = M · M̃).
      The resulting dimension is the square of the original dimension.
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: TQuantity;

    { Returns the inner (dot) product of the multivector quantity and a vector quantity.
      Lowers the grade of each component by 1.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-1 right operand.)
    }
    function Dot(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;

    { Returns the inner (dot) product of the multivector quantity and a bivector quantity.
      Lowers the grade of each component by 2.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-2 right operand.)
    }
    function Dot(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the inner (dot) product of the multivector quantity and a trivector quantity.
      Lowers the grade of each component by 3.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-3 right operand.)
    }
    function Dot(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the inner (dot) product of two multivector quantities.
      The result is a full @link(TCL3MultivecQuantity) due to grade mixing.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right operand.)
    }
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the outer (wedge) product of the multivector quantity and a vector quantity.
      Raises the grade of each component by 1.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-1 right operand.)
    }
    function Wedge(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;

    { Returns the outer (wedge) product of the multivector quantity and a bivector quantity.
      Raises the grade of each component by 2. Components of grade ≥ 2 contribute zero.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-2 right operand.)
    }
    function Wedge(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the outer (wedge) product of the multivector quantity and a trivector quantity.
      Only the scalar part of the multivector contributes to a non-zero result.
      The result is a pure @link(TCL3TrivecQuantity).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-3 right operand.)
    }
    function Wedge(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity; overload;

    { Returns the outer (wedge) product of two multivector quantities.
      The result is a full @link(TCL3MultivecQuantity) due to grade mixing.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right operand.)
    }
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the projection of the multivector quantity onto a vector quantity subspace.
      Defined as: @code(proj(M, v) = (M · v⁻¹) ∧ v).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The vector quantity defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;

    { Returns the projection of the multivector quantity onto a bivector quantity subspace.
      Defined as: @code(proj(M, B) = (M · B⁻¹) ∧ B).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The bivector quantity defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the projection of the multivector quantity onto a trivector quantity subspace.
      Defined as: @code(proj(M, T) = (M · T⁻¹) ∧ T).
      Since the trivector spans all of @code(ℝ³), the projection returns the
      multivector quantity unchanged.
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The trivector quantity defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the projection of the multivector quantity onto a multivector quantity subspace.
      Defined as: @code(proj(M₁, M₂) = (M₁ · M₂⁻¹) ∧ M₂).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The multivector quantity defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the rejection of the multivector quantity from a vector quantity subspace.
      Defined as: @code(rej(M, v) = M - proj(M, v)).
      The result is the component of @code(M) orthogonal to @code(v).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The vector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;

    { Returns the rejection of the multivector quantity from a bivector quantity subspace.
      Defined as: @code(rej(M, B) = M - proj(M, B)).
      The result is the component of @code(M) orthogonal to @code(B).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The bivector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the rejection of the multivector quantity from a trivector quantity subspace.
      Defined as: @code(rej(M, T) = M - proj(M, T)).
      In @code(ℝ³) the rejection of a general multivector from a trivector
      reduces to a scalar quantity.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The trivector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3TrivecQuantity): TQuantity; overload;

    { Returns the rejection of the multivector quantity from a multivector quantity subspace.
      Defined as: @code(rej(M₁, M₂) = M₁ - proj(M₁, M₂)).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The multivector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the reflection of the multivector quantity through a vector quantity.
      Defined as: @code(reflect(M, v) = -v · M · v⁻¹).
      The physical dimension is preserved.
      @param(AVector The vector quantity defining the reflection hyperplane normal.)
    }
    function Reflection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;

    { Returns the reflection of the multivector quantity through a bivector quantity.
      Defined as: @code(reflect(M, B) = -B · M · B⁻¹).
      The physical dimension is preserved.
      @param(AVector The bivector quantity defining the reflection element.)
    }
    function Reflection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the reflection of the multivector quantity through a trivector quantity.
      Defined as: @code(reflect(M, T) = -T · M · T⁻¹).
      The physical dimension is preserved.
      @param(AVector The trivector quantity defining the reflection element.)
    }
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the reflection of the multivector quantity through a multivector quantity.
      Defined as: @code(reflect(M₁, M₂) = -M₂ · M₁ · M₂⁻¹).
      The physical dimension is preserved.
      @param(AVector The multivector quantity defining the reflection element.)
    }
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the multivector quantity rotated by the rotor defined by two vector quantities.
      The rotor is constructed as @code(R = AVector2 · AVector1) (normalised to a unit rotor).
      The rotation is applied as: @code(M' = R · M · R⁻¹).
      The physical dimension is preserved.
      @param(AVector1 The first vector quantity defining the rotation plane.)
      @param(AVector2 The second vector quantity defining the rotation plane.)
    }
    function Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3MultivecQuantity; overload;

    { Returns the multivector quantity rotated by the rotor defined by two bivector quantities.
      The rotation is applied as: @code(M' = R · M · R⁻¹).
      The physical dimension is preserved.
      @param(AVector1 The first bivector quantity defining the rotor.)
      @param(AVector2 The second bivector quantity defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the multivector quantity rotated by the rotor defined by two trivector quantities.
      The rotation is applied as: @code(M' = R · M · R⁻¹).
      The physical dimension is preserved.
      @param(AVector1 The first trivector quantity defining the rotor.)
      @param(AVector2 The second trivector quantity defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the multivector quantity rotated by the rotor defined by two multivector quantities.
      The rotation is applied as: @code(M' = R · M · R⁻¹).
      The physical dimension is preserved.
      @param(AVector1 The first multivector quantity defining the rotor.)
      @param(AVector2 The second multivector quantity defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns @true if the multivector quantity is numerically equal to the given
      multivector quantity within the default floating point tolerance.
      @param(AVector The multivector quantity to compare against.)
    }
    function SameValue(const AVector: TCL3MultivecQuantity): boolean;

    { Returns @true if the multivector quantity is numerically equal to the given
      trivector quantity within the default floating point tolerance.
      All non-trivector components must be negligible.
      @param(AVector The trivector quantity to compare against.)
    }
    function SameValue(const AVector: TCL3TrivecQuantity): boolean;

    { Returns @true if the multivector quantity is numerically equal to the given
      bivector quantity within the default floating point tolerance.
      All non-bivector components must be negligible.
      @param(AVector The bivector quantity to compare against.)
    }
    function SameValue(const AVector: TCL3BivecQuantity): boolean;

    { Returns @true if the multivector quantity is numerically equal to the given
      vector quantity within the default floating point tolerance.
      All non-vector components must be negligible.
      @param(AVector The vector quantity to compare against.)
    }
    function SameValue(const AVector: TCL3VecQuantity): boolean;

    { Returns @true if the multivector quantity is numerically equal to the given
      real quantity within the default floating point tolerance.
      All non-scalar components must be negligible.
      @param(AVector The real quantity to compare against.)
    }
    function SameValue(const AVector: TQuantity): boolean;

    { Returns a new multivector quantity containing only the components specified
      by @code(AComponents). Components not present in @code(AComponents) are set to zero.
      @param(AComponents A set of @link(TCL3MultivectorComponent) values identifying
                         the components to retain.)
    }
    function ExtractMultivector(AComponents: TCL3MultivectorComponents): TCL3MultivecQuantity;

    { Returns the grade-2 components of the multivector quantity specified by
      @code(AComponents) as a @link(TCL3BivecQuantity).
      Components not present in @code(AComponents) are set to zero.
      @param(AComponents A set of @link(TCL3MultivectorComponent) values. Valid values
                         are @code(mcm12), @code(mcm13), @code(mcm23).)
    }
    function ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3BivecQuantity;

    { Returns the grade-1 components of the multivector quantity specified by
      @code(AComponents) as a @link(TCL3VecQuantity).
      Components not present in @code(AComponents) are set to zero.
      @param(AComponents A set of @link(TCL3MultivectorComponent) values. Valid values
                         are @code(mcm1), @code(mcm2), @code(mcm3).)
    }
    function ExtractVector(AComponents: TCL3MultivectorComponents): TCL3VecQuantity;

    { Returns all grade-3 components of the multivector quantity as a @link(TCL3TrivecQuantity).
      All other grade components are discarded.
    }
    function ExtractTrivector: TCL3TrivecQuantity;

    { Returns all grade-2 components of the multivector quantity as a @link(TCL3BivecQuantity).
      All other grade components are discarded.
    }
    function ExtractBivector: TCL3BivecQuantity;

    { Returns all grade-1 components of the multivector quantity as a @link(TCL3VecQuantity).
      All other grade components are discarded.
    }
    function ExtractVector: TCL3VecQuantity;

    { Returns the grade-0 (scalar) component of the multivector quantity as a @link(TQuantity).
      All other grade components are discarded.
    }
    function ExtractScalar: TQuantity;

    { Returns @true if all components of the multivector quantity are zero
      within the default floating point tolerance.
    }
    function IsNull: boolean;

    { Returns @true if the multivector quantity is a pure scalar,
      i.e. all components except @code(m0) are negligible.
    }
    function IsScalar: boolean;

    { Returns @true if the multivector quantity is a pure vector (grade-1),
      i.e. only @code(m1), @code(m2), @code(m3) are non-negligible.
    }
    function IsVector: boolean;

    { Returns @true if the multivector quantity is a pure bivector (grade-2),
      i.e. only @code(m12), @code(m13), @code(m23) are non-negligible.
    }
    function IsBiVector: boolean;

    { Returns @true if the multivector quantity is a pure trivector (grade-3),
      i.e. only @code(m123) is non-negligible.
    }
    function IsTrivector: boolean;

    { Returns a string identifying the dominant grade of the multivector quantity.
      Useful for diagnostics and debugging. Possible return values include
      @code('scalar'), @code('vector'), @code('bivector'), @code('trivector'),
      and @code('multivector') for mixed-grade elements.
    }
    function IsA: string;
  end;
  {$ENDIF}

  { Record helper for @link(TCL3TrivecQuantity) providing geometric operations
    specific to grade-3 elements of @code(Cl(3,0)) with physical dimensions.

    All operations follow the conventions of Clifford algebra over @code(ℝ³)
    with dimensional analysis. Incompatible dimensions raise an exception at runtime.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL3TrivecQuantityHelper = record helper for TCL3TrivecQuantity

    { Returns the dual of the trivector quantity with respect to the pseudoscalar @code(e₁₂₃).
      For @code(T = m123·e₁₂₃ [dim]), the dual is the scalar quantity:
      @code(T* = T · e₁₂₃⁻¹ = -m123 [dim]).
      The physical dimension is preserved.
    }
    function Dual: TQuantity;

    { Returns the inverse of the trivector quantity under the geometric product.
      For @code(T = m123·e₁₂₃ [dim]):
      @code(T⁻¹ = -e₁₂₃ / m123 [dim⁻¹]), since @code(e₁₂₃² = -1).
    }
    function Inverse: TCL3TrivecQuantity;

    { Returns the reverse of the trivector quantity.
      For a trivector (@code(k = 3)): @code(T̃ = -T).
      The physical dimension is preserved.
    }
    function Reverse: TCL3TrivecQuantity;

    { Returns the Clifford conjugate of the trivector quantity.
      For a trivector (@code(k = 3)): @code(T† = -T).
      The physical dimension is preserved.
    }
    function Conjugate: TCL3TrivecQuantity;

    { Returns the reciprocal of the trivector quantity: @code(T̃ / (T · T̃)).
      Equivalent to @link(Inverse) for non-zero trivector quantities.
      The resulting dimension is the inverse of the original dimension.
    }
    function Reciprocal: TCL3TrivecQuantity;

    { Returns the unit trivector quantity in the same direction.
      The coefficient @code(m123) is divided by @link(Norm).
      The physical dimension is preserved.
    }
    function Normalized: TCL3TrivecQuantity;

    { Returns the norm of the trivector quantity: @code(|T| = |m123| [dim]).
      The resulting dimension equals the dimension of the original quantity.
    }
    function Norm: TQuantity;

    { Returns the squared norm of the trivector quantity: @code(|T|² = m123² [dim²]).
      The resulting dimension is the square of the original dimension.
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: TQuantity;

    { Returns the inner (dot) product of the trivector quantity and a vector quantity.
      Lowers the grade: @code(grade(3) · grade(1) → grade(2) = bivector quantity).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-1 right operand.)
    }
    function Dot(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;

    { Returns the inner (dot) product of the trivector quantity and a bivector quantity.
      Lowers the grade: @code(grade(3) · grade(2) → grade(1) = vector quantity).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-2 right operand.)
    }
    function Dot(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;

    { Returns the inner (dot) product of two trivector quantities.
      Lowers the grade: @code(grade(3) · grade(3) → grade(0) = scalar quantity).
      Result: @code(T₁ · T₂ = -m123₁ · m123₂ [dim₁·dim₂]).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-3 right operand.)
    }
    function Dot(const AVector: TCL3TrivecQuantity): TQuantity; overload;

    { Returns the inner (dot) product of the trivector quantity and a multivector quantity.
      The result is a full @link(TCL3MultivecQuantity) due to grade mixing.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right operand.)
    }
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the outer (wedge) product of the trivector quantity and a vector quantity.
      Always zero in @code(ℝ³): @code(grade(3) ∧ grade(1) → grade(4) = 0).
      The result is a scalar quantity equal to zero.
      @param(AVector The grade-1 right operand.)
    }
    function Wedge(const AVector: TCL3VecQuantity): TQuantity; overload;

    { Returns the outer (wedge) product of the trivector quantity and a bivector quantity.
      Always zero in @code(ℝ³): @code(grade(3) ∧ grade(2) → grade(5) = 0).
      The result is a scalar quantity equal to zero.
      @param(AVector The grade-2 right operand.)
    }
    function Wedge(const AVector: TCL3BivecQuantity): TQuantity; overload;

    { Returns the outer (wedge) product of two trivector quantities.
      Always zero in @code(ℝ³): @code(grade(3) ∧ grade(3) → grade(6) = 0).
      The result is a scalar quantity equal to zero.
      @param(AVector The grade-3 right operand.)
    }
    function Wedge(const AVector: TCL3TrivecQuantity): TQuantity; overload;

    { Returns the outer (wedge) product of the trivector quantity and a multivector quantity.
      Only the scalar part of @code(AVector) contributes to a non-zero result.
      The result is a pure @link(TCL3TrivecQuantity).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right operand.)
    }
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity; overload;

    { Returns the projection of the trivector quantity onto a vector quantity subspace.
      Defined as: @code(proj(T, v) = (T · v⁻¹) ∧ v).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The vector quantity defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3VecQuantity): TCL3TrivecQuantity; overload;

    { Returns the projection of the trivector quantity onto a bivector quantity subspace.
      Defined as: @code(proj(T, B) = (T · B⁻¹) ∧ B).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The bivector quantity defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity; overload;

    { Returns the projection of the trivector quantity onto another trivector quantity subspace.
      Defined as: @code(proj(T₁, T₂) = (T₁ · T₂⁻¹) ∧ T₂).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The trivector quantity defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity; overload;

    { Returns the projection of the trivector quantity onto a multivector quantity subspace.
      Defined as: @code(proj(T, M) = (T · M⁻¹) ∧ M).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The multivector quantity defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity; overload;

    { Returns the rejection of the trivector quantity from a vector quantity subspace.
      Defined as: @code(rej(T, v) = T - proj(T, v)).
      In @code(ℝ³) the rejection of a trivector from a vector is a scalar quantity.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The vector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3VecQuantity): TQuantity; overload;

    { Returns the rejection of the trivector quantity from a bivector quantity subspace.
      Defined as: @code(rej(T, B) = T - proj(T, B)).
      In @code(ℝ³) the rejection of a trivector from a bivector is a scalar quantity.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The bivector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3BivecQuantity): TQuantity; overload;

    { Returns the rejection of the trivector quantity from another trivector quantity subspace.
      Defined as: @code(rej(T₁, T₂) = T₁ - proj(T₁, T₂)).
      In @code(ℝ³) the rejection of a trivector from a trivector is a scalar quantity.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The trivector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3TrivecQuantity): TQuantity; overload;

    { Returns the rejection of the trivector quantity from a multivector quantity subspace.
      Defined as: @code(rej(T, M) = T - proj(T, M)).
      The result is a full @link(TCL3MultivecQuantity) due to grade mixing.
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The multivector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the reflection of the trivector quantity through a vector quantity.
      Defined as: @code(reflect(T, v) = -v · T · v⁻¹).
      The physical dimension is preserved.
      @param(AVector The vector quantity defining the reflection hyperplane normal.)
    }
    function Reflection(const AVector: TCL3VecQuantity): TCL3TrivecQuantity; overload;

    { Returns the reflection of the trivector quantity through a bivector quantity.
      Defined as: @code(reflect(T, B) = -B · T · B⁻¹).
      The physical dimension is preserved.
      @param(AVector The bivector quantity defining the reflection element.)
    }
    function Reflection(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity; overload;

    { Returns the reflection of the trivector quantity through another trivector quantity.
      Defined as: @code(reflect(T₁, T₂) = -T₂ · T₁ · T₂⁻¹).
      The physical dimension is preserved.
      @param(AVector The trivector quantity defining the reflection element.)
    }
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity; overload;

    { Returns the reflection of the trivector quantity through a multivector quantity.
      Defined as: @code(reflect(T, M) = -M · T · M⁻¹).
      The physical dimension is preserved.
      @param(AVector The multivector quantity defining the reflection element.)
    }
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity; overload;

    { Returns the trivector quantity rotated by the rotor defined by two vector quantities.
      The rotor is constructed as @code(R = AVector2 · AVector1) (normalised to a unit rotor).
      The rotation is applied as: @code(T' = R · T · R⁻¹).
      The physical dimension is preserved.
      @param(AVector1 The first vector quantity defining the rotation plane.)
      @param(AVector2 The second vector quantity defining the rotation plane.)
    }
    function Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3TrivecQuantity; overload;

    { Returns the trivector quantity rotated by the rotor defined by two bivector quantities.
      The rotation is applied as: @code(T' = R · T · R⁻¹).
      The physical dimension is preserved.
      @param(AVector1 The first bivector quantity defining the rotor.)
      @param(AVector2 The second bivector quantity defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3TrivecQuantity; overload;

    { Returns the trivector quantity rotated by the rotor defined by two trivector quantities.
      The rotation is applied as: @code(T' = R · T · R⁻¹).
      The physical dimension is preserved.
      @param(AVector1 The first trivector quantity defining the rotor.)
      @param(AVector2 The second trivector quantity defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3TrivecQuantity; overload;

    { Returns the trivector quantity rotated by the rotor defined by two multivector quantities.
      The rotation is applied as: @code(T' = R · T · R⁻¹).
      The physical dimension is preserved.
      @param(AVector1 The first multivector quantity defining the rotor.)
      @param(AVector2 The second multivector quantity defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3TrivecQuantity; overload;

    { Returns @true if the trivector quantity is numerically equal to the given
      multivector quantity within the default floating point tolerance.
      All non-trivector components of @code(AVector) must be negligible.
      @param(AVector The multivector quantity to compare against.)
    }
    function SameValue(const AVector: TCL3MultivecQuantity): boolean;

    { Returns @true if the two trivector quantities are numerically equal
      within the default floating point tolerance.
      @param(AVector The trivector quantity to compare against.)
    }
    function SameValue(const AVector: TCL3TrivecQuantity): boolean;

    { Converts the trivector quantity to a full @link(TCL3MultivecQuantity).
      All components are zero except @code(m123). The dimension is preserved.
    }
    function ToMultivector: TCL3MultivecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TCL3BivecQuantity) providing geometric operations
    specific to grade-2 elements of @code(Cl(3,0)) with physical dimensions.

    All operations follow the conventions of Clifford algebra over @code(ℝ³)
    with dimensional analysis. Incompatible dimensions raise an exception at runtime.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL3BivecQuantityHelper = record helper for TCL3BivecQuantity

    { Returns the dual of the bivector quantity with respect to the pseudoscalar @code(e₁₂₃).
      The dual maps grade-2 elements to grade-1 (vector) elements:
      @code(B* = B · e₁₂₃⁻¹).
      For example: @code((e₁∧e₂)* = -e₃), @code((e₁∧e₃)* = e₂), @code((e₂∧e₃)* = -e₁).
      The physical dimension is preserved.
    }
    function Dual: TCL3VecQuantity;

    { Returns the inverse of the bivector quantity under the geometric product.
      For a pure bivector @code(B): @code(B⁻¹ = -B / |B|²), since @code(B² ≤ 0).
      The resulting dimension is the inverse of the original dimension.
    }
    function Inverse: TCL3BivecQuantity;

    { Returns the reverse of the bivector quantity.
      For a bivector (@code(k = 2)): @code(B̃ = -B).
      The physical dimension is preserved.
    }
    function Reverse: TCL3BivecQuantity;

    { Returns the Clifford conjugate of the bivector quantity.
      For a bivector (@code(k = 2)): @code(B† = -B).
      The physical dimension is preserved.
    }
    function Conjugate: TCL3BivecQuantity;

    { Returns the reciprocal of the bivector quantity: @code(B̃ / (B · B̃)).
      Equivalent to @link(Inverse) for non-zero bivector quantities.
      The resulting dimension is the inverse of the original dimension.
    }
    function Reciprocal: TCL3BivecQuantity;

    { Returns the unit bivector quantity in the same orientation.
      Each component is divided by @link(Norm).
      The physical dimension is preserved.
    }
    function Normalized: TCL3BivecQuantity;

    { Returns the norm of the bivector quantity:
      @code(|B| = √(m12² + m13² + m23²) [dim]).
      The resulting dimension equals the dimension of the original quantity.
    }
    function Norm: TQuantity;

    { Returns the squared norm of the bivector quantity:
      @code(|B|² = m12² + m13² + m23² [dim²]).
      The resulting dimension is the square of the original dimension.
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: TQuantity;

    { Returns the inner (dot) product of the bivector quantity and a vector quantity.
      Lowers the grade: @code(grade(2) · grade(1) → grade(1) = vector quantity).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-1 right operand.)
    }
    function Dot(const AVector: TCL3VecQuantity): TCL3VecQuantity; overload;

    { Returns the inner (dot) product of two bivector quantities.
      Lowers the grade: @code(grade(2) · grade(2) → grade(0) = scalar quantity).
      Result: @code(B₁ · B₂ = -(m12₁·m12₂ + m13₁·m13₂ + m23₁·m23₂) [dim₁·dim₂]).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-2 right operand.)
    }
    function Dot(const AVector: TCL3BivecQuantity): TQuantity; overload;

    { Returns the inner (dot) product of the bivector quantity and a trivector quantity.
      Lowers the grade: @code(grade(2) · grade(3) → grade(1) = vector quantity).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-3 right operand.)
    }
    function Dot(const AVector: TCL3TrivecQuantity): TCL3VecQuantity; overload;

    { Returns the inner (dot) product of the bivector quantity and a multivector quantity.
      The result is a full @link(TCL3MultivecQuantity) due to grade mixing.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right operand.)
    }
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the outer (wedge) product of the bivector quantity and a vector quantity.
      Raises the grade: @code(grade(2) ∧ grade(1) → grade(3) = trivector quantity).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-1 right operand.)
    }
    function Wedge(const AVector: TCL3VecQuantity): TCL3TrivecQuantity; overload;

    { Returns the outer (wedge) product of two bivector quantities.
      Always zero in @code(ℝ³): @code(grade(2) ∧ grade(2) → grade(4) = 0).
      The result is a scalar quantity equal to zero.
      @param(AVector The grade-2 right operand.)
    }
    function Wedge(const AVector: TCL3BivecQuantity): TQuantity; overload;

    { Returns the outer (wedge) product of the bivector quantity and a trivector quantity.
      Always zero in @code(ℝ³): @code(grade(2) ∧ grade(3) → grade(5) = 0).
      The result is a scalar quantity equal to zero.
      @param(AVector The grade-3 right operand.)
    }
    function Wedge(const AVector: TCL3TrivecQuantity): TQuantity; overload;

    { Returns the outer (wedge) product of the bivector quantity and a multivector quantity.
      Only the scalar and vector parts of @code(AVector) contribute to a non-zero result.
      The result is a full @link(TCL3MultivecQuantity) due to grade mixing.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right operand.)
    }
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the projection of the bivector quantity onto a vector quantity subspace.
      Defined as: @code(proj(B, v) = (B · v⁻¹) ∧ v).
      The result is the component of @code(B) lying in the plane containing @code(v).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The vector quantity defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;

    { Returns the projection of the bivector quantity onto another bivector quantity subspace.
      Defined as: @code(proj(B₁, B₂) = (B₁ · B₂⁻¹) ∧ B₂).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The bivector quantity defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3BivecQuantity): TCL3BivecQuantity; overload;

    { Returns the projection of the bivector quantity onto a trivector quantity subspace.
      Defined as: @code(proj(B, T) = (B · T⁻¹) ∧ T).
      Since the trivector spans all of @code(ℝ³), the projection returns the
      bivector quantity unchanged.
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The trivector quantity defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity; overload;

    { Returns the projection of the bivector quantity onto a multivector quantity subspace.
      Defined as: @code(proj(B, M) = (B · M⁻¹) ∧ M).
      The result is a full @link(TCL3MultivecQuantity) due to grade mixing.
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The multivector quantity defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the rejection of the bivector quantity from a vector quantity subspace.
      Defined as: @code(rej(B, v) = B - proj(B, v)).
      The result is the component of @code(B) orthogonal to @code(v).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The vector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;

    { Returns the rejection of the bivector quantity from another bivector quantity subspace.
      Defined as: @code(rej(B₁, B₂) = B₁ - proj(B₁, B₂)).
      In @code(ℝ³) the rejection of a bivector from a bivector is a scalar quantity.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The bivector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3BivecQuantity): TQuantity; overload;

    { Returns the rejection of the bivector quantity from a trivector quantity subspace.
      Defined as: @code(rej(B, T) = B - proj(B, T)).
      In @code(ℝ³) the rejection of a bivector from a trivector is a scalar quantity.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The trivector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3TrivecQuantity): TQuantity; overload;

    { Returns the rejection of the bivector quantity from a multivector quantity subspace.
      Defined as: @code(rej(B, M) = B - proj(B, M)).
      The result is a full @link(TCL3MultivecQuantity) due to grade mixing.
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The multivector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the reflection of the bivector quantity through a vector quantity.
      Defined as: @code(reflect(B, v) = -v · B · v⁻¹).
      Reflects the oriented plane of @code(B) through the hyperplane orthogonal to @code(v).
      The physical dimension is preserved.
      @param(AVector The vector quantity defining the reflection hyperplane normal.)
    }
    function Reflection(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;

    { Returns the reflection of the bivector quantity through another bivector quantity.
      Defined as: @code(reflect(B₁, B₂) = -B₂ · B₁ · B₂⁻¹).
      The physical dimension is preserved.
      @param(AVector The bivector quantity defining the reflection element.)
    }
    function Reflection(const AVector: TCL3BivecQuantity): TCL3BivecQuantity; overload;

    { Returns the reflection of the bivector quantity through a trivector quantity.
      Defined as: @code(reflect(B, T) = -T · B · T⁻¹).
      Since the pseudoscalar commutes with all even-grade elements, the reflection
      through a trivector returns the bivector quantity unchanged.
      The physical dimension is preserved.
      @param(AVector The trivector quantity defining the reflection element.)
    }
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity; overload;

    { Returns the reflection of the bivector quantity through a multivector quantity.
      Defined as: @code(reflect(B, M) = -M · B · M⁻¹).
      The result is a full @link(TCL3MultivecQuantity) due to grade mixing.
      The physical dimension is preserved.
      @param(AVector The multivector quantity defining the reflection element.)
    }
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the bivector quantity rotated by the rotor defined by two vector quantities.
      The rotor is constructed as @code(R = AVector2 · AVector1) (normalised to a unit rotor).
      The rotation is applied as: @code(B' = R · B · R⁻¹).
      The physical dimension is preserved.
      @param(AVector1 The first vector quantity defining the rotation plane.)
      @param(AVector2 The second vector quantity defining the rotation plane.)
    }
    function Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3BivecQuantity; overload;

    { Returns the bivector quantity rotated by the rotor defined by two bivector quantities.
      The rotation is applied as: @code(B' = R · B · R⁻¹).
      The physical dimension is preserved.
      @param(AVector1 The first bivector quantity defining the rotor.)
      @param(AVector2 The second bivector quantity defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3BivecQuantity; overload;

    { Returns the bivector quantity rotated by the rotor defined by two trivector quantities.
      The rotation is applied as: @code(B' = R · B · R⁻¹).
      The physical dimension is preserved.
      @param(AVector1 The first trivector quantity defining the rotor.)
      @param(AVector2 The second trivector quantity defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3BivecQuantity; overload;

    { Returns the bivector quantity rotated by the rotor defined by two multivector quantities.
      The rotation is applied as: @code(B' = R · B · R⁻¹).
      The result is a full @link(TCL3MultivecQuantity) due to potential grade mixing.
      The physical dimension is preserved.
      @param(AVector1 The first multivector quantity defining the rotor.)
      @param(AVector2 The second multivector quantity defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns @true if the bivector quantity is numerically equal to the given
      multivector quantity within the default floating point tolerance.
      All non-bivector components of @code(AVector) must be negligible.
      @param(AVector The multivector quantity to compare against.)
    }
    function SameValue(const AVector: TCL3MultivecQuantity): boolean;

    { Returns @true if the two bivector quantities are numerically equal
      within the default floating point tolerance.
      @param(AVector The bivector quantity to compare against.)
    }
    function SameValue(const AVector: TCL3BivecQuantity): boolean;

    { Returns a new bivector quantity containing only the components specified
      by @code(AComponents). Components not present in @code(AComponents) are set to zero.
      @param(AComponents A set of @link(TCL3MultivectorComponent) values identifying
                         the components to retain. Valid values are @code(mcm12),
                         @code(mcm13), @code(mcm23).)
    }
    function ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3BivecQuantity;

    { Converts the bivector quantity to a full @link(TCL3MultivecQuantity).
      All components are zero except @code(m12), @code(m13), @code(m23).
      The dimension is preserved.
    }
    function ToMultivector: TCL3MultivecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TCL3VecQuantity) providing geometric operations
    specific to grade-1 elements of @code(Cl(3,0)) with physical dimensions.

    All operations follow the conventions of Clifford algebra over @code(ℝ³)
    with dimensional analysis. Incompatible dimensions raise an exception at runtime.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL3VecQuantityHelper = record helper for TCL3VecQuantity

    { Returns the dual of the vector quantity with respect to the pseudoscalar @code(e₁₂₃).
      The dual maps grade-1 elements to grade-2 (bivector) elements:
      @code(v* = v · e₁₂₃⁻¹).
      For example: @code(e₁* = -e₂∧e₃), @code(e₂* = e₁∧e₃), @code(e₃* = -e₁∧e₂).
      The physical dimension is preserved.
    }
    function Dual: TCL3BivecQuantity;

    { Returns the inverse of the vector quantity under the geometric product.
      For a non-zero vector @code(v): @code(v⁻¹ = v / |v|²), since @code(v² > 0).
      The resulting dimension is the inverse of the original dimension.
    }
    function Inverse: TCL3VecQuantity;

    { Returns the reverse of the vector quantity.
      For a vector (@code(k = 1)): @code(ṽ = v) (unchanged).
      The physical dimension is preserved.
    }
    function Reverse: TCL3VecQuantity;

    { Returns the Clifford conjugate of the vector quantity.
      For a vector (@code(k = 1)): @code(v† = -v).
      The physical dimension is preserved.
    }
    function Conjugate: TCL3VecQuantity;

    { Returns the reciprocal of the vector quantity: @code(ṽ / (v · ṽ)).
      Equivalent to @link(Inverse) for non-zero vector quantities.
      The resulting dimension is the inverse of the original dimension.
    }
    function Reciprocal: TCL3VecQuantity;

    { Returns the unit vector quantity in the same direction.
      Each component is divided by @link(Norm).
      The physical dimension is preserved.
    }
    function Normalized: TCL3VecQuantity;

    { Returns the Euclidean norm of the vector quantity:
      @code(|v| = √(m1² + m2² + m3²) [dim]).
      The resulting dimension equals the dimension of the original quantity.
    }
    function Norm: TQuantity;

    { Returns the squared Euclidean norm of the vector quantity:
      @code(|v|² = m1² + m2² + m3² [dim²]).
      The resulting dimension is the square of the original dimension.
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: TQuantity;

    { Returns the inner (dot) product of two vector quantities.
      Lowers the grade: @code(grade(1) · grade(1) → grade(0) = scalar quantity).
      Result: @code(u · v = m1₁·m1₂ + m2₁·m2₂ + m3₁·m3₂ [dim₁·dim₂]).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-1 right operand.)
    }
    function Dot(const AVector: TCL3VecQuantity): TQuantity; overload;

    { Returns the inner (dot) product of a vector quantity and a bivector quantity.
      Lowers the grade: @code(grade(1) · grade(2) → grade(1) = vector quantity).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-2 right operand.)
    }
    function Dot(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;

    { Returns the inner (dot) product of a vector quantity and a trivector quantity.
      Lowers the grade: @code(grade(1) · grade(3) → grade(2) = bivector quantity).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-3 right operand.)
    }
    function Dot(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity; overload;

    { Returns the inner (dot) product of a vector quantity and a multivector quantity.
      The result is a full @link(TCL3MultivecQuantity) due to grade mixing.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right operand.)
    }
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the outer (wedge) product of two vector quantities.
      Raises the grade: @code(grade(1) ∧ grade(1) → grade(2) = bivector quantity).
      The result represents the oriented plane spanned by the two vectors.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-1 right operand.)
    }
    function Wedge(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;

    { Returns the outer (wedge) product of a vector quantity and a bivector quantity.
      Raises the grade: @code(grade(1) ∧ grade(2) → grade(3) = trivector quantity).
      The result represents the oriented volume spanned by the vector and the bivector.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-2 right operand.)
    }
    function Wedge(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity; overload;

    { Returns the outer (wedge) product of a vector quantity and a trivector quantity.
      Always zero in @code(ℝ³): @code(grade(1) ∧ grade(3) → grade(4) = 0).
      The result is a scalar quantity equal to zero.
      @param(AVector The grade-3 right operand.)
    }
    function Wedge(const AVector: TCL3TrivecQuantity): TQuantity; overload;

    { Returns the outer (wedge) product of a vector quantity and a multivector quantity.
      Only components of @code(AVector) up to grade 2 contribute to a non-zero result.
      The result is a full @link(TCL3MultivecQuantity) due to grade mixing.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right operand.)
    }
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the cross product of two vector quantities.
      The cross product is the dual of the wedge product:
      @code(u × v = (u ∧ v)* = -(u ∧ v) · e₁₂₃⁻¹).
      The result is a vector quantity perpendicular to both operands with magnitude
      @code(|u||v|sin(θ)), specific to @code(ℝ³).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The right operand.)
    }
    function Cross(const AVector: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the projection of the vector quantity onto another vector quantity.
      Defined as: @code(proj(u, v) = (u · v⁻¹) ∧ v = (u · v / |v|²) · v).
      The result is the component of @code(u) parallel to @code(v).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The vector quantity defining the direction to project onto.)
    }
    function Projection(const AVector: TCL3VecQuantity): TCL3VecQuantity; overload;

    { Returns the projection of the vector quantity onto a bivector quantity subspace.
      Defined as: @code(proj(v, B) = (v · B⁻¹) ∧ B).
      The result is the component of @code(v) lying in the plane of @code(B).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The bivector quantity defining the plane to project onto.)
    }
    function Projection(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;

    { Returns the projection of the vector quantity onto a trivector quantity subspace.
      Defined as: @code(proj(v, T) = (v · T⁻¹) ∧ T).
      Since the trivector spans all of @code(ℝ³), the projection returns the
      vector quantity unchanged.
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The trivector quantity defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3TrivecQuantity): TCL3VecQuantity; overload;

    { Returns the projection of the vector quantity onto a multivector quantity subspace.
      Defined as: @code(proj(v, M) = (v · M⁻¹) ∧ M).
      The result is a full @link(TCL3MultivecQuantity) due to grade mixing.
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The multivector quantity defining the subspace to project onto.)
    }
    function Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the rejection of the vector quantity from another vector quantity.
      Defined as: @code(rej(u, v) = u - proj(u, v)).
      The result is the component of @code(u) perpendicular to @code(v).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The vector quantity defining the direction to reject from.)
    }
    function Rejection(const AVector: TCL3VecQuantity): TCL3VecQuantity; overload;

    { Returns the rejection of the vector quantity from a bivector quantity subspace.
      Defined as: @code(rej(v, B) = v - proj(v, B)).
      The result is the component of @code(v) perpendicular to the plane of @code(B).
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The bivector quantity defining the plane to reject from.)
    }
    function Rejection(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;

    { Returns the rejection of the vector quantity from a trivector quantity subspace.
      Defined as: @code(rej(v, T) = v - proj(v, T)).
      In @code(ℝ³) the rejection of a vector from a trivector is always zero,
      returned as a scalar quantity equal to zero.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The trivector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3TrivecQuantity): TQuantity; overload;

    { Returns the rejection of the vector quantity from a multivector quantity subspace.
      Defined as: @code(rej(v, M) = v - proj(v, M)).
      The result is a full @link(TCL3MultivecQuantity) due to grade mixing.
      The resulting dimension is the dimension of the original quantity.
      @param(AVector The multivector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the reflection of the vector quantity through another vector quantity.
      Defined as: @code(reflect(u, v) = v · u · v⁻¹).
      Reflects @code(u) through the line defined by @code(v), reversing the
      perpendicular component and preserving the parallel one.
      The physical dimension is preserved.
      @param(AVector The vector quantity defining the reflection axis.)
    }
    function Reflection(const AVector: TCL3VecQuantity): TCL3VecQuantity; overload;

    { Returns the reflection of the vector quantity through a bivector quantity.
      Defined as: @code(reflect(v, B) = B · v · B⁻¹).
      Reflects @code(v) through the plane represented by @code(B), reversing the
      normal component and preserving the in-plane component.
      The physical dimension is preserved.
      @param(AVector The bivector quantity defining the reflection plane.)
    }
    function Reflection(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;

    { Returns the reflection of the vector quantity through a trivector quantity.
      Defined as: @code(reflect(v, T) = T · v · T⁻¹).
      Since the pseudoscalar anticommutes with vectors in @code(Cl(3,0)),
      the result is @code(-v).
      The physical dimension is preserved.
      @param(AVector The trivector quantity defining the reflection element.)
    }
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3VecQuantity; overload;

    { Returns the reflection of the vector quantity through a multivector quantity.
      Defined as: @code(reflect(v, M) = M · v · M⁻¹).
      The result is a full @link(TCL3MultivecQuantity) due to grade mixing.
      The physical dimension is preserved.
      @param(AVector The multivector quantity defining the reflection element.)
    }
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns the vector quantity rotated by the rotor defined by two vector quantities.
      The rotor is constructed as @code(R = AVector2 · AVector1) (normalised to a unit rotor).
      The rotation is applied as: @code(v' = R · v · R⁻¹).
      The rotation is in the plane spanned by @code(AVector1) and @code(AVector2),
      by twice the angle between them. The physical dimension is preserved.
      @param(AVector1 The first vector quantity defining the rotation plane.)
      @param(AVector2 The second vector quantity defining the rotation plane.)
    }
    function Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3VecQuantity; overload;

    { Returns the vector quantity rotated by the rotor defined by two bivector quantities.
      The rotation is applied as: @code(v' = R · v · R⁻¹).
      The physical dimension is preserved.
      @param(AVector1 The first bivector quantity defining the rotor.)
      @param(AVector2 The second bivector quantity defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3VecQuantity; overload;

    { Returns the vector quantity rotated by the rotor defined by two trivector quantities.
      The rotation is applied as: @code(v' = R · v · R⁻¹).
      The physical dimension is preserved.
      @param(AVector1 The first trivector quantity defining the rotor.)
      @param(AVector2 The second trivector quantity defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3VecQuantity; overload;

    { Returns the vector quantity rotated by the rotor defined by two multivector quantities.
      The rotation is applied as: @code(v' = R · v · R⁻¹).
      The result is a full @link(TCL3MultivecQuantity) due to potential grade mixing.
      The physical dimension is preserved.
      @param(AVector1 The first multivector quantity defining the rotor.)
      @param(AVector2 The second multivector quantity defining the rotor.)
    }
    function Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    { Returns @true if the vector quantity is numerically equal to the given
      multivector quantity within the default floating point tolerance.
      All non-vector components of @code(AVector) must be negligible.
      @param(AVector The multivector quantity to compare against.)
    }
    function SameValue(const AVector: TCL3MultivecQuantity): boolean;

    { Returns @true if the two vector quantities are numerically equal
      within the default floating point tolerance.
      @param(AVector The vector quantity to compare against.)
    }
    function SameValue(const AVector: TCL3VecQuantity): boolean;

    { Returns a new vector quantity containing only the components specified
      by @code(AComponents). Components not present in @code(AComponents) are set to zero.
      @param(AComponents A set of @link(TCL3MultivectorComponent) values identifying
                         the components to retain. Valid values are @code(mcm1),
                         @code(mcm2), @code(mcm3).)
    }
    function ExtractVector(AComponents: TCL3MultivectorComponents): TCL3VecQuantity;

    { Converts the vector quantity to a full @link(TCL3MultivecQuantity).
      All components are zero except @code(m1), @code(m2), @code(m3).
      The dimension is preserved.
    }
    function ToMultivector: TCL3MultivecQuantity;
  end;
  {$ENDIF}

  { Represents a physical unit of measurement with its dimensional signature,
    symbol, name and prefix information.

    @code(TUnit) is the central type for attaching physical dimensions to
    numerical values. Multiplying or dividing any supported numerical type
    (real scalar, complex number, vector, matrix, or Clifford algebra element)
    by a @code(TUnit) instance produces the corresponding dimensioned quantity type.

    Example idiomatic usage:
    @code(var v: TQuantity := 9.81 * MetrePerSquareSecond;)
    @code(var z: TComplexQuantity := (1 + 2*i) * Ohm;)
    @code(var F: TR3VecQuantity := TR3Vector(...) * Newton;)

    When the symbol @code(ADIMOFF) is defined, all operators that accept or
    return quantity types are disabled and the corresponding raw numerical types
    are used directly.
  }
  TUnit = record
  private
    FDim: TDimension;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    { Returns the real quantity @code(AValue [unit]). }
    class operator *(const AValue: double; const ASelf: TUnit): TQuantity; inline;

    { Returns the real quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: double; const ASelf: TUnit): TQuantity; inline;

    { Returns the complex quantity @code(AValue [unit]). }
    class operator *(const AValue: TComplex; const ASelf: TUnit): TComplexQuantity; inline;

    { Returns the complex quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TComplex; const ASelf: TUnit): TComplexQuantity; inline;

    { Returns the 2-component real vector quantity @code(AVector [unit]). }
    class operator *(const AVector: TR2Vector; const ASelf: TUnit): TR2VecQuantity; inline;

    { Returns the 3-component real vector quantity @code(AVector [unit]). }
    class operator *(const AVector: TR3Vector; const ASelf: TUnit): TR3VecQuantity; inline;

    { Returns the 4-component real vector quantity @code(AVector [unit]). }
    class operator *(const AVector: TR4Vector; const ASelf: TUnit): TR4VecQuantity; inline;

    { Returns the 2-component real vector quantity @code(AVector / [unit]), with inverted dimension. }
    class operator /(const AVector: TR2Vector; const ASelf: TUnit): TR2VecQuantity; inline;

    { Returns the 3-component real vector quantity @code(AVector / [unit]), with inverted dimension. }
    class operator /(const AVector: TR3Vector; const ASelf: TUnit): TR3VecQuantity; inline;

    { Returns the 4-component real vector quantity @code(AVector / [unit]), with inverted dimension. }
    class operator /(const AVector: TR4Vector; const ASelf: TUnit): TR4VecQuantity; inline;

    { Returns the 2-component complex vector quantity @code(AVector [unit]). }
    class operator *(const AVector: TC2Vector; const ASelf: TUnit): TC2VecQuantity; inline;

    { Returns the 3-component complex vector quantity @code(AVector [unit]). }
    class operator *(const AVector: TC3Vector; const ASelf: TUnit): TC3VecQuantity; inline;

    { Returns the 4-component complex vector quantity @code(AVector [unit]). }
    class operator *(const AVector: TC4Vector; const ASelf: TUnit): TC4VecQuantity; inline;

    { Returns the 2-component complex vector quantity @code(AVector / [unit]), with inverted dimension. }
    class operator /(const AVector: TC2Vector; const ASelf: TUnit): TC2VecQuantity; inline;

    { Returns the 3-component complex vector quantity @code(AVector / [unit]), with inverted dimension. }
    class operator /(const AVector: TC3Vector; const ASelf: TUnit): TC3VecQuantity; inline;

    { Returns the 4-component complex vector quantity @code(AVector / [unit]), with inverted dimension. }
    class operator /(const AVector: TC4Vector; const ASelf: TUnit): TC4VecQuantity; inline;

    { Returns the 2×2 real matrix quantity @code(AMatrix [unit]). }
    class operator *(const AMatrix: TR2Matrix; const ASelf: TUnit): TR2MatrixQuantity; inline;

    { Returns the 3×3 real matrix quantity @code(AMatrix [unit]). }
    class operator *(const AMatrix: TR3Matrix; const ASelf: TUnit): TR3MatrixQuantity; inline;

    { Returns the 4×4 real matrix quantity @code(AMatrix [unit]). }
    class operator *(const AMatrix: TR4Matrix; const ASelf: TUnit): TR4MatrixQuantity; inline;

    { Returns the 2×2 real matrix quantity @code(AMatrix / [unit]), with inverted dimension. }
    class operator /(const AMatrix: TR2Matrix; const ASelf: TUnit): TR2MatrixQuantity; inline;

    { Returns the 3×3 real matrix quantity @code(AMatrix / [unit]), with inverted dimension. }
    class operator /(const AMatrix: TR3Matrix; const ASelf: TUnit): TR3MatrixQuantity; inline;

    { Returns the 4×4 real matrix quantity @code(AMatrix / [unit]), with inverted dimension. }
    class operator /(const AMatrix: TR4Matrix; const ASelf: TUnit): TR4MatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity @code(AMatrix [unit]). }
    class operator *(const AMatrix: TC2Matrix; const ASelf: TUnit): TC2MatrixQuantity; inline;

    { Returns the 3×3 complex matrix quantity @code(AMatrix [unit]). }
    class operator *(const AMatrix: TC3Matrix; const ASelf: TUnit): TC3MatrixQuantity; inline;

    { Returns the 4×4 complex matrix quantity @code(AMatrix [unit]). }
    class operator *(const AMatrix: TC4Matrix; const ASelf: TUnit): TC4MatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity @code(AMatrix / [unit]), with inverted dimension. }
    class operator /(const AMatrix: TC2Matrix; const ASelf: TUnit): TC2MatrixQuantity; inline;

    { Returns the 3×3 complex matrix quantity @code(AMatrix / [unit]), with inverted dimension. }
    class operator /(const AMatrix: TC3Matrix; const ASelf: TUnit): TC3MatrixQuantity; inline;

    { Returns the 4×4 complex matrix quantity @code(AMatrix / [unit]), with inverted dimension. }
    class operator /(const AMatrix: TC4Matrix; const ASelf: TUnit): TC4MatrixQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity @code(AVector [unit]). }
    class operator *(const AVector: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity @code(ABivector [unit]). }
    class operator *(const ABivector: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity @code(ATrivector [unit]). }
    class operator *(const ATrivector: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity @code(AMultivector [unit]). }
    class operator *(const AMultivector: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity @code(AVector / [unit]), with inverted dimension. }
    class operator /(const AVector: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity @code(ABivector / [unit]), with inverted dimension. }
    class operator /(const ABivector: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity @code(ATrivector / [unit]), with inverted dimension. }
    class operator /(const ATrivector: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity @code(AMultivector / [unit]), with inverted dimension. }
    class operator /(const AMultivector: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;

  {$IFNDEF ADIMOFF}
    { Returns the real quantity with dimension scaled by @code([unit]).
      Used for unit conversion: @code(1.0*km * (1/Metre) = 1000).
    }
    class operator *(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;

    { Returns the real quantity with dimension divided by @code([unit]).
      Used for unit conversion: @code(1000.0*m / km = 1).
    }
    class operator /(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;

    { Returns the complex quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;

    { Returns the complex quantity with dimension scaled by @code([unit]) (unit on the left). }
    class operator *(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;

    { Returns the complex quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;

    { Returns the complex quantity with dimension inverted relative to @code([unit]). }
    class operator /(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;

    { Returns the 2-component real vector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TR2VecQuantity; const ASelf: TUnit): TR2VecQuantity; inline;

    { Returns the 3-component real vector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TR3VecQuantity; const ASelf: TUnit): TR3VecQuantity; inline;

    { Returns the 4-component real vector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TR4VecQuantity; const ASelf: TUnit): TR4VecQuantity; inline;

    { Returns the 2-component real vector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TR2VecQuantity; const ASelf: TUnit): TR2VecQuantity; inline;

    { Returns the 3-component real vector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TR3VecQuantity; const ASelf: TUnit): TR3VecQuantity; inline;

    { Returns the 4-component real vector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TR4VecQuantity; const ASelf: TUnit): TR4VecQuantity; inline;

    { Returns the 2-component complex vector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TC2VecQuantity; const ASelf: TUnit): TC2VecQuantity; inline;

    { Returns the 3-component complex vector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TC3VecQuantity; const ASelf: TUnit): TC3VecQuantity; inline;

    { Returns the 4-component complex vector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TC4VecQuantity; const ASelf: TUnit): TC4VecQuantity; inline;

    { Returns the 2-component complex vector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TC2VecQuantity; const ASelf: TUnit): TC2VecQuantity; inline;

    { Returns the 3-component complex vector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TC3VecQuantity; const ASelf: TUnit): TC3VecQuantity; inline;

    { Returns the 4-component complex vector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TC4VecQuantity; const ASelf: TUnit): TC4VecQuantity; inline;

    { Returns the 2×2 real matrix quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TR2MatrixQuantity; const ASelf: TUnit): TR2MatrixQuantity; inline;

    { Returns the 3×3 real matrix quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TR3MatrixQuantity; const ASelf: TUnit): TR3MatrixQuantity; inline;

    { Returns the 4×4 real matrix quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TR4MatrixQuantity; const ASelf: TUnit): TR4MatrixQuantity; inline;

    { Returns the 2×2 real matrix quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TR2MatrixQuantity; const ASelf: TUnit): TR2MatrixQuantity; inline;

    { Returns the 3×3 real matrix quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TR3MatrixQuantity; const ASelf: TUnit): TR3MatrixQuantity; inline;

    { Returns the 4×4 real matrix quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TR4MatrixQuantity; const ASelf: TUnit): TR4MatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TC2MatrixQuantity; const ASelf: TUnit): TC2MatrixQuantity; inline;

    { Returns the 3×3 complex matrix quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TC3MatrixQuantity; const ASelf: TUnit): TC3MatrixQuantity; inline;

    { Returns the 4×4 complex matrix quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TC4MatrixQuantity; const ASelf: TUnit): TC4MatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TC2MatrixQuantity; const ASelf: TUnit): TC2MatrixQuantity; inline;

    { Returns the 3×3 complex matrix quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TC3MatrixQuantity; const ASelf: TUnit): TC3MatrixQuantity; inline;

    { Returns the 4×4 complex matrix quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TC4MatrixQuantity; const ASelf: TUnit): TC4MatrixQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;
  {$ENDIF}
  end;

  { Represents a physical unit of measurement with a conversion factor relative
    to the corresponding SI base unit.

    @code(TFactoredUnit) extends the role of @link(TUnit) to cover units that
    are not SI base or derived units but are related to them by a fixed numerical
    factor stored in @code(FFactor). Examples include kilometres (@code(FFactor = 1000)),
    degrees (@code(FFactor = π/180)), electronvolts, and similar.

    When multiplying or dividing a numerical value by a @code(TFactoredUnit),
    the value is automatically scaled by @code(FFactor) so that the resulting
    @link(TQuantity) is always expressed in SI base units internally.

    Example idiomatic usage:
    @code(var d: TQuantity := 5.0 * Kilometre;   // stores 5000.0 m internally)
    @code(var a: TQuantity := 90.0 * Degree;     // stores π/2 rad internally)

    When the symbol @code(ADIMOFF) is defined, all operators that accept or
    return quantity types are disabled and raw numerical types are used directly.
  }
  TFactoredUnit = record
  private
    FDim: TDimension;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
    FFactor: double;
  public
    {
      Returns the real quantity @code(AValue * FFactor [dim]).
      The value is converted to SI base units using @code(FFactor).
    }
    class operator *(const AValue: double; const ASelf: TFactoredUnit): TQuantity; inline;

    { Returns the real quantity @code(AValue / FFactor [dim⁻¹]).
      The value is converted to SI base units using @code(FFactor).
    }
    class operator /(const AValue: double; const ASelf: TFactoredUnit): TQuantity; inline;

    { Returns the complex quantity @code(AValue * FFactor [dim]).
      Each component is scaled by @code(FFactor).
    }
    class operator *(const AValue: TComplex; const ASelf: TFactoredUnit): TComplexQuantity; inline;

    { Returns the complex quantity @code(AValue / FFactor [dim⁻¹]).
      Each component is scaled by @code(1/FFactor).
    }
    class operator /(const AValue: TComplex; const ASelf: TFactoredUnit): TComplexQuantity; inline;

    { Returns the 2-component real vector quantity @code(AVector * FFactor [dim]). }
    class operator *(const AVector: TR2Vector; const ASelf: TFactoredUnit): TR2VecQuantity; inline;

    { Returns the 3-component real vector quantity @code(AVector * FFactor [dim]). }
    class operator *(const AVector: TR3Vector; const ASelf: TFactoredUnit): TR3VecQuantity; inline;

    { Returns the 4-component real vector quantity @code(AVector * FFactor [dim]). }
    class operator *(const AVector: TR4Vector; const ASelf: TFactoredUnit): TR4VecQuantity; inline;

    { Returns the 2-component real vector quantity @code(AVector / FFactor [dim⁻¹]). }
    class operator /(const AVector: TR2Vector; const ASelf: TFactoredUnit): TR2VecQuantity; inline;

    { Returns the 3-component real vector quantity @code(AVector / FFactor [dim⁻¹]). }
    class operator /(const AVector: TR3Vector; const ASelf: TFactoredUnit): TR3VecQuantity; inline;

    { Returns the 4-component real vector quantity @code(AVector / FFactor [dim⁻¹]). }
    class operator /(const AVector: TR4Vector; const ASelf: TFactoredUnit): TR4VecQuantity; inline;

    { Returns the 2-component complex vector quantity @code(AVector * FFactor [dim]). }
    class operator *(const AVector: TC2Vector; const ASelf: TFactoredUnit): TC2VecQuantity; inline;

    { Returns the 3-component complex vector quantity @code(AVector * FFactor [dim]). }
    class operator *(const AVector: TC3Vector; const ASelf: TFactoredUnit): TC3VecQuantity; inline;

    { Returns the 4-component complex vector quantity @code(AVector * FFactor [dim]). }
    class operator *(const AVector: TC4Vector; const ASelf: TFactoredUnit): TC4VecQuantity; inline;

    { Returns the 2-component complex vector quantity @code(AVector / FFactor [dim⁻¹]). }
    class operator /(const AVector: TC2Vector; const ASelf: TFactoredUnit): TC2VecQuantity; inline;

    { Returns the 3-component complex vector quantity @code(AVector / FFactor [dim⁻¹]). }
    class operator /(const AVector: TC3Vector; const ASelf: TFactoredUnit): TC3VecQuantity; inline;

    { Returns the 4-component complex vector quantity @code(AVector / FFactor [dim⁻¹]). }
    class operator /(const AVector: TC4Vector; const ASelf: TFactoredUnit): TC4VecQuantity; inline;

    { Returns the 2×2 real matrix quantity @code(AMatrix * FFactor [dim]). }
    class operator *(const AMatrix: TR2Matrix; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;

    { Returns the 3×3 real matrix quantity @code(AMatrix * FFactor [dim]). }
    class operator *(const AMatrix: TR3Matrix; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;

    { Returns the 4×4 real matrix quantity @code(AMatrix * FFactor [dim]). }
    class operator *(const AMatrix: TR4Matrix; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;

    { Returns the 2×2 real matrix quantity @code(AMatrix / FFactor [dim⁻¹]). }
    class operator /(const AMatrix: TR2Matrix; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;

    { Returns the 3×3 real matrix quantity @code(AMatrix / FFactor [dim⁻¹]). }
    class operator /(const AMatrix: TR3Matrix; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;

    { Returns the 4×4 real matrix quantity @code(AMatrix / FFactor [dim⁻¹]). }
    class operator /(const AMatrix: TR4Matrix; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity @code(AMatrix * FFactor [dim]). }
    class operator *(const AMatrix: TC2Matrix; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;

    { Returns the 3×3 complex matrix quantity @code(AMatrix * FFactor [dim]). }
    class operator *(const AMatrix: TC3Matrix; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;

    { Returns the 4×4 complex matrix quantity @code(AMatrix * FFactor [dim]). }
    class operator *(const AMatrix: TC4Matrix; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity @code(AMatrix / FFactor [dim⁻¹]). }
    class operator /(const AMatrix: TC2Matrix; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;

    { Returns the 3×3 complex matrix quantity @code(AMatrix / FFactor [dim⁻¹]). }
    class operator /(const AMatrix: TC3Matrix; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;

    { Returns the 4×4 complex matrix quantity @code(AMatrix / FFactor [dim⁻¹]). }
    class operator /(const AMatrix: TC4Matrix; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;

  {$IFNDEF ADIMOFF}
    { Returns the real quantity with dimension and value rescaled by @code(FFactor).
      Used for unit conversion between factored units:
      @code(5.0*km * (1/Mile) → distance in miles).
    }
    class operator *(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;

    { Returns the real quantity with dimension and value rescaled by @code(1/FFactor).
      Used for unit conversion: @code(5000.0*m / km → 5.0).
    }
    class operator /(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;

    { Returns the complex quantity with dimension and value rescaled by @code(FFactor). }
    class operator *(const AQuantity: TComplexQuantity; const ASelf: TFactoredUnit): TComplexQuantity; inline;

    { Returns the complex quantity with dimension and value rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TComplexQuantity; const ASelf: TFactoredUnit): TComplexQuantity; inline;

    { Returns the 2-component real vector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TR2VecQuantity; const ASelf: TFactoredUnit): TR2VecQuantity; inline;

    { Returns the 3-component real vector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TR3VecQuantity; const ASelf: TFactoredUnit): TR3VecQuantity; inline;

    { Returns the 4-component real vector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TR4VecQuantity; const ASelf: TFactoredUnit): TR4VecQuantity; inline;

    { Returns the 2-component real vector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TR2VecQuantity; const ASelf: TFactoredUnit): TR2VecQuantity; inline;

    { Returns the 3-component real vector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TR3VecQuantity; const ASelf: TFactoredUnit): TR3VecQuantity; inline;

    { Returns the 4-component real vector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TR4VecQuantity; const ASelf: TFactoredUnit): TR4VecQuantity; inline;

    { Returns the 2-component complex vector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TC2VecQuantity; const ASelf: TFactoredUnit): TC2VecQuantity; inline;

    { Returns the 3-component complex vector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TC3VecQuantity; const ASelf: TFactoredUnit): TC3VecQuantity; inline;

    { Returns the 4-component complex vector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TC4VecQuantity; const ASelf: TFactoredUnit): TC4VecQuantity; inline;

    { Returns the 2-component complex vector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TC2VecQuantity; const ASelf: TFactoredUnit): TC2VecQuantity; inline;

    { Returns the 3-component complex vector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TC3VecQuantity; const ASelf: TFactoredUnit): TC3VecQuantity; inline;

    { Returns the 4-component complex vector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TC4VecQuantity; const ASelf: TFactoredUnit): TC4VecQuantity; inline;

    { Returns the 2×2 real matrix quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TR2MatrixQuantity; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;

    { Returns the 3×3 real matrix quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TR3MatrixQuantity; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;

    { Returns the 4×4 real matrix quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TR4MatrixQuantity; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;

    { Returns the 2×2 real matrix quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TR2MatrixQuantity; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;

    { Returns the 3×3 real matrix quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TR3MatrixQuantity; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;

    { Returns the 4×4 real matrix quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TR4MatrixQuantity; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TC2MatrixQuantity; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;

    { Returns the 3×3 complex matrix quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TC3MatrixQuantity; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;

    { Returns the 4×4 complex matrix quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TC4MatrixQuantity; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TC2MatrixQuantity; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;

    { Returns the 3×3 complex matrix quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TC3MatrixQuantity; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;

    { Returns the 4×4 complex matrix quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TC4MatrixQuantity; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
  {$ENDIF}
  end;

  { Represents the degree Celsius temperature unit (@code(°C)).

    Unlike SI base units, the Celsius scale has an offset relative to the
    SI base unit of temperature (kelvin): @code(T[K] = T[°C] + 273.15).
    The multiplication operator applies this offset conversion, so that
    the resulting @link(TQuantity) is always expressed in kelvin internally.

    Example:
    @code(var T: TQuantity := 100.0 * DegreeCelsius;  // stores 373.15 K internally)

    Note: because of the additive offset, Celsius degrees cannot be used
    directly in multiplications or divisions to express temperature differences
    without care. For temperature differences, use kelvin directly.
  }
  TDegreeCelsiusUnit = record
  private
    FDim: TDimension;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    { Converts a temperature value in degrees Celsius to a @link(TQuantity) in kelvin.
      Applies the offset: @code(T[K] = AValue + 273.15).
      The resulting quantity has the thermodynamic temperature dimension @code([K]).
    }
    class operator *(const AValue: double; const ASelf: TDegreeCelsiusUnit): TQuantity; inline;
  end;

  { Represents the degree Fahrenheit temperature unit (@code(°F)).

    The Fahrenheit scale has both a scale factor and an offset relative to kelvin:
    @code(T[K] = (T[°F] + 459.67) × 5/9).
    The multiplication operator applies this full conversion, so that
    the resulting @link(TQuantity) is always expressed in kelvin internally.

    Example:
    @code(var T: TQuantity := 212.0 * DegreeFahrenheit;  // stores 373.15 K internally)

    Note: because of the additive offset, Fahrenheit degrees cannot be used
    directly in multiplications or divisions to express temperature differences
    without care. For temperature differences, use kelvin directly.
  }
  TDegreeFahrenheitUnit = record
  private
    FDim: TDimension;
    FSymbol: string;
    FName: string;
    FPluralName: string;
    FPrefixes: TPrefixes;
    FExponents: TExponents;
  public
    { Converts a temperature value in degrees Fahrenheit to a @link(TQuantity) in kelvin.
      Applies the affine conversion: @code(T[K] = (AValue + 459.67) × 5/9).
      The resulting quantity has the thermodynamic temperature dimension @code([K]).
    }
    class operator *(const AValue: double; const ASelf: TDegreeFahrenheitUnit): TQuantity; inline;
  end;

  { Record helper for @link(TUnit) providing conversion and formatting operations
    for all supported quantity types.

    This helper centralises the logic for:
    @unorderedList(
      @item(Extracting the raw numerical value of a quantity expressed in a
            given unit and prefix, via the @code(ToFloat), @code(ToComplex),
            @code(ToVector) and @code(ToMatrix) family of methods.)
      @item(Formatting a quantity as a compact string with unit symbol,
            via the @code(ToString) family of methods.)
      @item(Formatting a quantity as a verbose string with full unit name,
            via the @code(ToVerboseString) family of methods.)
      @item(Computing the scaled numerical value of a raw dimensionless type
            for a given prefix, via the @code(GetValue) family of methods.)
    )
    All methods that accept @code(APrefixes) apply the corresponding SI prefix
    scaling factor to the numerical value before returning or formatting.
  }
  TUnitHelper = record helper for TUnit
  public
    { Returns the singular name of the unit with the given prefix applied.
      Example: @code(GetName([pKilo])) on the metre unit returns @code('kilometre').
      @param(Prefixes The list of SI prefixes to prepend to the unit name.)
    }
    function GetName(Prefixes: TPrefixes): string;

    { Returns the plural name of the unit with the given prefix applied.
      Example: @code(GetPluralName([pKilo])) on the metre unit returns @code('kilometres').
      @param(Prefixes The list of SI prefixes to prepend to the unit plural name.)
    }
    function GetPluralName(Prefixes: TPrefixes): string;

    { Returns the symbol of the unit with the given prefix applied.
      Example: @code(GetSymbol([pKilo])) on the metre unit returns @code('km').
      @param(Prefixes The list of SI prefixes to prepend to the unit symbol.)
    }
    function GetSymbol(Prefixes: TPrefixes): string;

    { Returns the real scalar value scaled for the given prefix.
      @param(AQuantity The dimensionless real value to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;

    { Returns the complex value scaled for the given prefix.
      @param(AQuantity The dimensionless complex value to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TComplex; const APrefixes: TPrefixes): TComplex;

    { Returns the 2-component real vector scaled for the given prefix.
      @param(AQuantity The dimensionless vector to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TR2Vector; const APrefixes: TPrefixes): TR2Vector;

    { Returns the 3-component real vector scaled for the given prefix.
      @param(AQuantity The dimensionless vector to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TR3Vector; const APrefixes: TPrefixes): TR3Vector;

    { Returns the 4-component real vector scaled for the given prefix.
      @param(AQuantity The dimensionless vector to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TR4Vector; const APrefixes: TPrefixes): TR4Vector;

    { Returns the 2-component complex vector scaled for the given prefix.
      @param(AQuantity The dimensionless complex vector to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TC2Vector; const APrefixes: TPrefixes): TC2Vector;

    { Returns the 3-component complex vector scaled for the given prefix.
      @param(AQuantity The dimensionless complex vector to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TC3Vector; const APrefixes: TPrefixes): TC3Vector;

    { Returns the 4-component complex vector scaled for the given prefix.
      @param(AQuantity The dimensionless complex vector to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TC4Vector; const APrefixes: TPrefixes): TC4Vector;

    { Returns the 2×2 real matrix scaled for the given prefix.
      @param(AQuantity The dimensionless matrix to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TR2Matrix; const APrefixes: TPrefixes): TR2Matrix;

    { Returns the 3×3 real matrix scaled for the given prefix.
      @param(AQuantity The dimensionless matrix to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TR3Matrix; const APrefixes: TPrefixes): TR3Matrix;

    { Returns the 4×4 real matrix scaled for the given prefix.
      @param(AQuantity The dimensionless matrix to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TR4Matrix; const APrefixes: TPrefixes): TR4Matrix;

    { Returns the 2×2 complex matrix scaled for the given prefix.
      @param(AQuantity The dimensionless complex matrix to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TC2Matrix; const APrefixes: TPrefixes): TC2Matrix;

    { Returns the 3×3 complex matrix scaled for the given prefix.
      @param(AQuantity The dimensionless complex matrix to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TC3Matrix; const APrefixes: TPrefixes): TC3Matrix;

    { Returns the 4×4 complex matrix scaled for the given prefix.
      @param(AQuantity The dimensionless complex matrix to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TC4Matrix; const APrefixes: TPrefixes): TC4Matrix;

    { Returns the @code(Cl(3,0)) vector scaled for the given prefix.
      @param(AQuantity The dimensionless @link(TCL3Vector) to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TCL3Vector; const APrefixes: TPrefixes): TCL3Vector;

    { Returns the @code(Cl(3,0)) bivector scaled for the given prefix.
      @param(AQuantity The dimensionless @link(TCL3Bivector) to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TCL3Bivector; const APrefixes: TPrefixes): TCL3Bivector;

    { Returns the @code(Cl(3,0)) trivector scaled for the given prefix.
      @param(AQuantity The dimensionless @link(TCL3Trivector) to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TCL3Trivector; const APrefixes: TPrefixes): TCL3Trivector;

    { Returns the @code(Cl(3,0)) multivector scaled for the given prefix.
      @param(AQuantity The dimensionless @link(TCL3Multivector) to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TCL3Multivector; const APrefixes: TPrefixes): TCL3Multivector;

  public
    { Returns the numerical value of the real quantity expressed in this unit.
      The value is converted from the internal SI representation.
      @param(AQuantity The real quantity to extract the value from.)
    }
    function ToFloat(const AQuantity: TQuantity): double;

    { Returns the numerical value of the real quantity expressed in this unit
      with the given prefix applied.
      @param(AQuantity  The real quantity to extract the value from.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;

    { Returns a compact string representation of the real quantity in this unit.
      Format: @code('<value> <symbol>'), e.g. @code('9.81 m/s²').
      @param(AQuantity The real quantity to format.)
    }
    function ToString(const AQuantity: TQuantity): string;

    { Returns a compact string representation of the real quantity in this unit
      with the given prefix applied.
      @param(AQuantity  The real quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the real quantity with controlled precision.
      @param(AQuantity   The real quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the real quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> <symbol>').
      @param(AQuantity   The central real quantity to format.)
      @param(ATolerance  The tolerance quantity to display alongside the value.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real quantity in this unit.
      Format: @code('<value> <plural name>'), e.g. @code('9.81 metres per square second').
      @param(AQuantity The real quantity to format.)
    }
    function ToVerboseString(const AQuantity: TQuantity): string;

    { Returns a verbose string representation of the real quantity with the given prefix.
      @param(AQuantity  The real quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real quantity with controlled precision.
      @param(AQuantity   The real quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> <plural name>').
      @param(AQuantity   The central real quantity to format.)
      @param(ATolerance  The tolerance quantity to display alongside the value.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TComplex) value of the complex quantity expressed in this unit.
      @param(AQuantity The complex quantity to extract the value from.)
    }
    function ToComplex(const AQuantity: TComplexQuantity): TComplex;

    { Returns the dimensionless @link(TComplex) value of the complex quantity
      with the given prefix applied.
      @param(AQuantity  The complex quantity to extract the value from.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToComplex(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): TComplex;

    { Returns a compact string representation of the complex quantity in this unit.
      Format: @code('<Re> ± <Im>i <symbol>').
      @param(AQuantity The complex quantity to format.)
    }
    function ToString(const AQuantity: TComplexQuantity): string;

    { Returns a compact string representation of the complex quantity with the given prefix.
      @param(AQuantity  The complex quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the complex quantity with controlled precision.
      @param(AQuantity   The complex quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TComplexQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the complex quantity in this unit.
      @param(AQuantity The complex quantity to format.)
    }
    function ToVerboseString(const AQuantity: TComplexQuantity): string;

    { Returns a verbose string representation of the complex quantity with the given prefix.
      @param(AQuantity  The complex quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the complex quantity with controlled precision.
      @param(AQuantity   The complex quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TComplexQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TR2Vector) of the 2-component real vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TR2VecQuantity): TR2Vector;

    { Returns the dimensionless @link(TR3Vector) of the 3-component real vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TR3VecQuantity): TR3Vector;

    { Returns the dimensionless @link(TR4Vector) of the 4-component real vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TR4VecQuantity): TR4Vector;

    { Returns the dimensionless @link(TR2Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): TR2Vector;

    { Returns the dimensionless @link(TR3Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): TR3Vector;

    { Returns the dimensionless @link(TR4Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): TR4Vector;

    { Returns a compact string representation of the 2-component real vector quantity in this unit. }
    function ToString(const AQuantity: TR2VecQuantity): string;

    { Returns a compact string representation of the 3-component real vector quantity in this unit. }
    function ToString(const AQuantity: TR3VecQuantity): string;

    { Returns a compact string representation of the 4-component real vector quantity in this unit. }
    function ToString(const AQuantity: TR4VecQuantity): string;

    { Returns a compact string representation of the 2-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 3-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 4-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2-component real vector quantity in this unit. }
    function ToVerboseString(const AQuantity: TR2VecQuantity): string;

    { Returns a verbose string representation of the 3-component real vector quantity in this unit. }
    function ToVerboseString(const AQuantity: TR3VecQuantity): string;

    { Returns a verbose string representation of the 4-component real vector quantity in this unit. }
    function ToVerboseString(const AQuantity: TR4VecQuantity): string;

    { Returns a verbose string representation of the 2-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 3-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 4-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TC2Vector) of the 2-component complex vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TC2VecQuantity): TC2Vector;

    { Returns the dimensionless @link(TC3Vector) of the 3-component complex vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TC3VecQuantity): TC3Vector;

    { Returns the dimensionless @link(TC4Vector) of the 4-component complex vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TC4VecQuantity): TC4Vector;

    { Returns the dimensionless @link(TC2Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): TC2Vector;

    { Returns the dimensionless @link(TC3Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): TC3Vector;

    { Returns the dimensionless @link(TC4Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): TC4Vector;

    { Returns a compact string representation of the 2-component complex vector quantity in this unit. }
    function ToString(const AQuantity: TC2VecQuantity): string;

    { Returns a compact string representation of the 3-component complex vector quantity in this unit. }
    function ToString(const AQuantity: TC3VecQuantity): string;

    { Returns a compact string representation of the 4-component complex vector quantity in this unit. }
    function ToString(const AQuantity: TC4VecQuantity): string;

    { Returns a compact string representation of the 2-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 3-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 4-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2-component complex vector quantity in this unit. }
    function ToVerboseString(const AQuantity: TC2VecQuantity): string;

    { Returns a verbose string representation of the 3-component complex vector quantity in this unit. }
    function ToVerboseString(const AQuantity: TC3VecQuantity): string;

    { Returns a verbose string representation of the 4-component complex vector quantity in this unit. }
    function ToVerboseString(const AQuantity: TC4VecQuantity): string;

    { Returns a verbose string representation of the 2-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 3-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 4-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TR2Matrix) of the 2×2 real matrix quantity expressed in this unit. }
    function ToMatrix(const AQuantity: TR2MatrixQuantity): TR2Matrix;

    { Returns the dimensionless @link(TR3Matrix) of the 3×3 real matrix quantity expressed in this unit. }
    function ToMatrix(const AQuantity: TR3MatrixQuantity): TR3Matrix;

    { Returns the dimensionless @link(TR4Matrix) of the 4×4 real matrix quantity expressed in this unit. }
    function ToMatrix(const AQuantity: TR4MatrixQuantity): TR4Matrix;

    { Returns the dimensionless @link(TR2Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): TR2Matrix;

    { Returns the dimensionless @link(TR3Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): TR3Matrix;

    { Returns the dimensionless @link(TR4Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): TR4Matrix;

    { Returns a compact string representation of the 2×2 real matrix quantity in this unit. }
    function ToString(const AQuantity: TR2MatrixQuantity): string;

    { Returns a compact string representation of the 3×3 real matrix quantity in this unit. }
    function ToString(const AQuantity: TR3MatrixQuantity): string;

    { Returns a compact string representation of the 4×4 real matrix quantity in this unit. }
    function ToString(const AQuantity: TR4MatrixQuantity): string;

    { Returns a compact string representation of the 2×2 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 3×3 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 4×4 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2×2 real matrix quantity in this unit. }
    function ToVerboseString(const AQuantity: TR2MatrixQuantity): string;

    { Returns a verbose string representation of the 3×3 real matrix quantity in this unit. }
    function ToVerboseString(const AQuantity: TR3MatrixQuantity): string;

    { Returns a verbose string representation of the 4×4 real matrix quantity in this unit. }
    function ToVerboseString(const AQuantity: TR4MatrixQuantity): string;

    { Returns a verbose string representation of the 2×2 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 3×3 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 4×4 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TC2Matrix) of the 2×2 complex matrix quantity expressed in this unit. }
    function ToMatrix(const AQuantity: TC2MatrixQuantity): TC2Matrix;

    { Returns the dimensionless @link(TC3Matrix) of the 3×3 complex matrix quantity expressed in this unit. }
    function ToMatrix(const AQuantity: TC3MatrixQuantity): TC3Matrix;

    { Returns the dimensionless @link(TC4Matrix) of the 4×4 complex matrix quantity expressed in this unit. }
    function ToMatrix(const AQuantity: TC4MatrixQuantity): TC4Matrix;

    { Returns the dimensionless @link(TC2Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): TC2Matrix;

    { Returns the dimensionless @link(TC3Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): TC3Matrix;

    { Returns the dimensionless @link(TC4Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): TC4Matrix;

    { Returns a compact string representation of the 2×2 complex matrix quantity in this unit. }
    function ToString(const AQuantity: TC2MatrixQuantity): string;

    { Returns a compact string representation of the 3×3 complex matrix quantity in this unit. }
    function ToString(const AQuantity: TC3MatrixQuantity): string;

    { Returns a compact string representation of the 4×4 complex matrix quantity in this unit. }
    function ToString(const AQuantity: TC4MatrixQuantity): string;

    { Returns a compact string representation of the 2×2 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 3×3 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 4×4 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2×2 complex matrix quantity in this unit. }
    function ToVerboseString(const AQuantity: TC2MatrixQuantity): string;

    { Returns a verbose string representation of the 3×3 complex matrix quantity in this unit. }
    function ToVerboseString(const AQuantity: TC3MatrixQuantity): string;

    { Returns a verbose string representation of the 4×4 complex matrix quantity in this unit. }
    function ToVerboseString(const AQuantity: TC4MatrixQuantity): string;

    { Returns a verbose string representation of the 2×2 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 3×3 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 4×4 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) vector quantity in this unit. }
    function ToString(const AQuantity: TCL3VecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) bivector quantity in this unit. }
    function ToString(const AQuantity: TCL3BivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) trivector quantity in this unit. }
    function ToString(const AQuantity: TCL3TrivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) multivector quantity in this unit. }
    function ToString(const AQuantity: TCL3MultivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) bivector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) trivector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) multivector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) vector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL3VecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) bivector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL3BivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) trivector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) multivector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) bivector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) trivector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) multivector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;
  end;

  { Record helper for @link(TFactoredUnit) providing conversion and formatting
    operations for all supported quantity types.

    This helper mirrors the interface of @link(TUnitHelper) but applies the
    conversion factor @code(FFactor) stored in @link(TFactoredUnit) to all
    extraction and formatting operations. All @code(ToFloat), @code(ToComplex),
    @code(ToVector) and @code(ToMatrix) methods return values expressed in the
    factored unit (e.g. kilometres, degrees) rather than in SI base units.

    All @code(ToString) and @code(ToVerboseString) methods produce output with
    the factored unit symbol or name (e.g. @code('5 km'), @code('90 degrees'))
    rather than the SI base unit.

    All methods that accept @code(APrefixes) apply the corresponding SI prefix
    scaling factor on top of @code(FFactor).
  }
  TFactoredUnitHelper = record helper for TFactoredUnit
  public
    { Returns the singular name of the factored unit with the given prefix applied.
      Example: @code(GetName([pMilli])) on the gram unit returns @code('milligram').
      @param(Prefixes The list of SI prefixes to prepend to the unit name.)
    }
    function GetName(Prefixes: TPrefixes): string;

    { Returns the plural name of the factored unit with the given prefix applied.
      Example: @code(GetPluralName([pMilli])) on the gram unit returns @code('milligrams').
      @param(Prefixes The list of SI prefixes to prepend to the unit plural name.)
    }
    function GetPluralName(Prefixes: TPrefixes): string;

    { Returns the symbol of the factored unit with the given prefix applied.
      Example: @code(GetSymbol([pMilli])) on the gram unit returns @code('mg').
      @param(Prefixes The list of SI prefixes to prepend to the unit symbol.)
    }
    function GetSymbol(Prefixes: TPrefixes): string;

    { Returns the real scalar value scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless real value to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;

    { Returns the complex value scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless complex value to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TComplex; const APrefixes: TPrefixes): TComplex;

    { Returns the 2-component real vector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless vector to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TR2Vector; const APrefixes: TPrefixes): TR2Vector;

    { Returns the 3-component real vector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless vector to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TR3Vector; const APrefixes: TPrefixes): TR3Vector;

    { Returns the 4-component real vector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless vector to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TR4Vector; const APrefixes: TPrefixes): TR4Vector;

    { Returns the 2-component complex vector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless complex vector to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TC2Vector; const APrefixes: TPrefixes): TC2Vector;

    { Returns the 3-component complex vector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless complex vector to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TC3Vector; const APrefixes: TPrefixes): TC3Vector;

    { Returns the 4-component complex vector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless complex vector to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TC4Vector; const APrefixes: TPrefixes): TC4Vector;

    { Returns the 2×2 real matrix scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless matrix to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TR2Matrix; const APrefixes: TPrefixes): TR2Matrix;

    { Returns the 3×3 real matrix scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless matrix to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TR3Matrix; const APrefixes: TPrefixes): TR3Matrix;

    { Returns the 4×4 real matrix scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless matrix to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TR4Matrix; const APrefixes: TPrefixes): TR4Matrix;

    { Returns the 2×2 complex matrix scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless complex matrix to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TC2Matrix; const APrefixes: TPrefixes): TC2Matrix;

    { Returns the 3×3 complex matrix scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless complex matrix to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TC3Matrix; const APrefixes: TPrefixes): TC3Matrix;

    { Returns the 4×4 complex matrix scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless complex matrix to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TC4Matrix; const APrefixes: TPrefixes): TC4Matrix;

    { Returns the @code(Cl(3,0)) vector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless @link(TCL3Vector) to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TCL3Vector; const APrefixes: TPrefixes): TCL3Vector;

    { Returns the @code(Cl(3,0)) bivector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless @link(TCL3Bivector) to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TCL3Bivector; const APrefixes: TPrefixes): TCL3Bivector;

    { Returns the @code(Cl(3,0)) trivector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless @link(TCL3Trivector) to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TCL3Trivector; const APrefixes: TPrefixes): TCL3Trivector;

    { Returns the @code(Cl(3,0)) multivector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless @link(TCL3Multivector) to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TCL3Multivector; const APrefixes: TPrefixes): TCL3Multivector;

  public
    { Returns the numerical value of the real quantity expressed in this factored unit.
      The SI base value is divided by @code(FFactor).
      @param(AQuantity The real quantity to extract the value from.)
    }
    function ToFloat(const AQuantity: TQuantity): double;

    { Returns the numerical value of the real quantity expressed in this factored unit
      with the given prefix applied.
      @param(AQuantity  The real quantity to extract the value from.)
      @param(APrefixes  The SI prefixes defining additional output scaling.)
    }
    function ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;

    { Returns a compact string representation of the real quantity in this factored unit.
      Format: @code('<value> <symbol>'), e.g. @code('5 km'), @code('90 °').
      @param(AQuantity The real quantity to format.)
    }
    function ToString(const AQuantity: TQuantity): string;

    { Returns a compact string representation of the real quantity in this factored unit
      with the given prefix applied.
      @param(AQuantity  The real quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the real quantity with controlled precision.
      @param(AQuantity   The real quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the real quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> <symbol>').
      @param(AQuantity   The central real quantity to format.)
      @param(ATolerance  The tolerance quantity to display alongside the value.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real quantity in this factored unit.
      Format: @code('<value> <plural name>'), e.g. @code('5 kilometres').
      @param(AQuantity The real quantity to format.)
    }
    function ToVerboseString(const AQuantity: TQuantity): string;

    { Returns a verbose string representation of the real quantity with the given prefix.
      @param(AQuantity  The real quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real quantity with controlled precision.
      @param(AQuantity   The real quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> <plural name>').
      @param(AQuantity   The central real quantity to format.)
      @param(ATolerance  The tolerance quantity to display alongside the value.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TComplex) value of the complex quantity
      expressed in this factored unit. The SI base value is divided by @code(FFactor).
      @param(AQuantity The complex quantity to extract the value from.)
    }
    function ToComplex(const AQuantity: TComplexQuantity): TComplex;

    { Returns the dimensionless @link(TComplex) value with the given prefix applied.
      @param(AQuantity  The complex quantity to extract the value from.)
      @param(APrefixes  The SI prefixes defining additional output scaling.)
    }
    function ToComplex(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): TComplex;

    { Returns a compact string representation of the complex quantity in this factored unit. @param(AQuantity The complex quantity to format.) }
    function ToString(const AQuantity: TComplexQuantity): string;

    { Returns a compact string representation of the complex quantity with the given prefix. @param(AQuantity The complex quantity to format.) @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the complex quantity with controlled precision.
      @param(AQuantity   The complex quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TComplexQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the complex quantity in this factored unit. @param(AQuantity The complex quantity to format.) }
    function ToVerboseString(const AQuantity: TComplexQuantity): string;

    { Returns a verbose string representation of the complex quantity with the given prefix. @param(AQuantity The complex quantity to format.) @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the complex quantity with controlled precision.
      @param(AQuantity   The complex quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TComplexQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TR2Vector) of the 2-component real vector quantity expressed in this factored unit. }
    function ToVector(const AQuantity: TR2VecQuantity): TR2Vector;

    { Returns the dimensionless @link(TR3Vector) of the 3-component real vector quantity expressed in this factored unit. }
    function ToVector(const AQuantity: TR3VecQuantity): TR3Vector;

    { Returns the dimensionless @link(TR4Vector) of the 4-component real vector quantity expressed in this factored unit. }
    function ToVector(const AQuantity: TR4VecQuantity): TR4Vector;

    { Returns the dimensionless @link(TR2Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): TR2Vector;

    { Returns the dimensionless @link(TR3Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): TR3Vector;

    { Returns the dimensionless @link(TR4Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): TR4Vector;

    { Returns a compact string representation of the 2-component real vector quantity in this factored unit. }
    function ToString(const AQuantity: TR2VecQuantity): string;

    { Returns a compact string representation of the 3-component real vector quantity in this factored unit. }
    function ToString(const AQuantity: TR3VecQuantity): string;

    { Returns a compact string representation of the 4-component real vector quantity in this factored unit. }
    function ToString(const AQuantity: TR4VecQuantity): string;

    { Returns a compact string representation of the 2-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 3-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 4-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2-component real vector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TR2VecQuantity): string;

    { Returns a verbose string representation of the 3-component real vector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TR3VecQuantity): string;

    { Returns a verbose string representation of the 4-component real vector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TR4VecQuantity): string;

    { Returns a verbose string representation of the 2-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 3-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 4-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TC2Vector) of the 2-component complex vector quantity expressed in this factored unit. }
    function ToVector(const AQuantity: TC2VecQuantity): TC2Vector;

    { Returns the dimensionless @link(TC3Vector) of the 3-component complex vector quantity expressed in this factored unit. }
    function ToVector(const AQuantity: TC3VecQuantity): TC3Vector;

    { Returns the dimensionless @link(TC4Vector) of the 4-component complex vector quantity expressed in this factored unit. }
    function ToVector(const AQuantity: TC4VecQuantity): TC4Vector;

    { Returns the dimensionless @link(TC2Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): TC2Vector;

    { Returns the dimensionless @link(TC3Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): TC3Vector;

    { Returns the dimensionless @link(TC4Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): TC4Vector;

    { Returns a compact string representation of the 2-component complex vector quantity in this factored unit. }
    function ToString(const AQuantity: TC2VecQuantity): string;

    { Returns a compact string representation of the 3-component complex vector quantity in this factored unit. }
    function ToString(const AQuantity: TC3VecQuantity): string;

    { Returns a compact string representation of the 4-component complex vector quantity in this factored unit. }
    function ToString(const AQuantity: TC4VecQuantity): string;

    { Returns a compact string representation of the 2-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 3-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 4-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2-component complex vector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TC2VecQuantity): string;

    { Returns a verbose string representation of the 3-component complex vector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TC3VecQuantity): string;

    { Returns a verbose string representation of the 4-component complex vector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TC4VecQuantity): string;

    { Returns a verbose string representation of the 2-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 3-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 4-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TR2Matrix) of the 2×2 real matrix quantity expressed in this factored unit. }
    function ToMatrix(const AQuantity: TR2MatrixQuantity): TR2Matrix;

    { Returns the dimensionless @link(TR3Matrix) of the 3×3 real matrix quantity expressed in this factored unit. }
    function ToMatrix(const AQuantity: TR3MatrixQuantity): TR3Matrix;

    { Returns the dimensionless @link(TR4Matrix) of the 4×4 real matrix quantity expressed in this factored unit. }
    function ToMatrix(const AQuantity: TR4MatrixQuantity): TR4Matrix;

    { Returns the dimensionless @link(TR2Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): TR2Matrix;

    { Returns the dimensionless @link(TR3Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): TR3Matrix;

    { Returns the dimensionless @link(TR4Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): TR4Matrix;

    { Returns a compact string representation of the 2×2 real matrix quantity in this factored unit. }
    function ToString(const AQuantity: TR2MatrixQuantity): string;

    { Returns a compact string representation of the 3×3 real matrix quantity in this factored unit. }
    function ToString(const AQuantity: TR3MatrixQuantity): string;

    { Returns a compact string representation of the 4×4 real matrix quantity in this factored unit. }
    function ToString(const AQuantity: TR4MatrixQuantity): string;

    { Returns a compact string representation of the 2×2 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 3×3 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 4×4 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2×2 real matrix quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TR2MatrixQuantity): string;

    { Returns a verbose string representation of the 3×3 real matrix quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TR3MatrixQuantity): string;

    { Returns a verbose string representation of the 4×4 real matrix quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TR4MatrixQuantity): string;

    { Returns a verbose string representation of the 2×2 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 3×3 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 4×4 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TC2Matrix) of the 2×2 complex matrix quantity expressed in this factored unit. }
    function ToMatrix(const AQuantity: TC2MatrixQuantity): TC2Matrix;

    { Returns the dimensionless @link(TC3Matrix) of the 3×3 complex matrix quantity expressed in this factored unit. }
    function ToMatrix(const AQuantity: TC3MatrixQuantity): TC3Matrix;

    { Returns the dimensionless @link(TC4Matrix) of the 4×4 complex matrix quantity expressed in this factored unit. }
    function ToMatrix(const AQuantity: TC4MatrixQuantity): TC4Matrix;

    { Returns the dimensionless @link(TC2Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): TC2Matrix;

    { Returns the dimensionless @link(TC3Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): TC3Matrix;

    { Returns the dimensionless @link(TC4Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): TC4Matrix;

    { Returns a compact string representation of the 2×2 complex matrix quantity in this factored unit. }
    function ToString(const AQuantity: TC2MatrixQuantity): string;

    { Returns a compact string representation of the 3×3 complex matrix quantity in this factored unit. }
    function ToString(const AQuantity: TC3MatrixQuantity): string;

    { Returns a compact string representation of the 4×4 complex matrix quantity in this factored unit. }
    function ToString(const AQuantity: TC4MatrixQuantity): string;

    { Returns a compact string representation of the 2×2 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 3×3 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the 4×4 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2×2 complex matrix quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TC2MatrixQuantity): string;

    { Returns a verbose string representation of the 3×3 complex matrix quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TC3MatrixQuantity): string;

    { Returns a verbose string representation of the 4×4 complex matrix quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TC4MatrixQuantity): string;

    { Returns a verbose string representation of the 2×2 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 3×3 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 4×4 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) vector quantity in this factored unit. }
    function ToString(const AQuantity: TCL3VecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) bivector quantity in this factored unit. }
    function ToString(const AQuantity: TCL3BivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) trivector quantity in this factored unit. }
    function ToString(const AQuantity: TCL3TrivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) multivector quantity in this factored unit. }
    function ToString(const AQuantity: TCL3MultivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) bivector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) trivector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) multivector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) vector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL3VecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) bivector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL3BivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) trivector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) multivector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) bivector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) trivector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) multivector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;
  end;

  { Record helper for @link(TDegreeCelsiusUnit) providing conversion and
    formatting operations for temperatures expressed in degrees Celsius.

    All extraction methods apply the inverse of the Celsius offset conversion,
    so that a quantity stored internally in kelvin is correctly displayed in @code(°C):
    @code(T[°C] = T[K] - 273.15).

    All @code(ToString) and @code(ToVerboseString) methods produce output with
    the Celsius symbol @code('°C') or name @code('degree Celsius') / @code('degrees Celsius').
  }
  TDegreeCelsiusUnitHelper = record helper for TDegreeCelsiusUnit
  public
    { Returns the singular name of the unit with the given prefix applied.
      For the Celsius unit this is typically @code('degree Celsius') without prefix.
      @param(Prefixes The list of SI prefixes to prepend to the unit name.)
    }
    function GetName(const Prefixes: TPrefixes): string;

    { Returns the plural name of the unit with the given prefix applied.
      For the Celsius unit this is typically @code('degrees Celsius') without prefix.
      @param(Prefixes The list of SI prefixes to prepend to the unit plural name.)
    }
    function GetPluralName(const Prefixes: TPrefixes): string;

    { Returns the symbol of the unit with the given prefix applied.
      For the Celsius unit this is typically @code('°C') without prefix.
      @param(Prefixes The list of SI prefixes to prepend to the unit symbol.)
    }
    function GetSymbol(const Prefixes: TPrefixes): string;

    { Returns the real scalar value scaled for the given prefix, expressed in degrees Celsius.
      Applies the inverse offset: @code(T[°C] = AQuantity - 273.15).
      @param(AQuantity The dimensionless real value in SI base units (kelvin) to convert.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;

  public

    { Returns the numerical value of the real quantity expressed in degrees Celsius.
      Applies the inverse offset conversion: @code(T[°C] = T[K] - 273.15).
      @param(AQuantity The real temperature quantity stored internally in kelvin.)
    }
    function ToFloat(const AQuantity: TQuantity): double;

    { Returns the numerical value of the real quantity expressed in degrees Celsius
      with the given prefix applied.
      @param(AQuantity  The real temperature quantity stored internally in kelvin.)
      @param(APrefixes  The SI prefixes defining additional output scaling.)
    }
    function ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;

    { Returns a compact string representation of the temperature quantity in degrees Celsius.
      Format: @code('<value> °C'), e.g. @code('100 °C').
      @param(AQuantity The real temperature quantity to format.)
    }
    function ToString(const AQuantity: TQuantity): string;

    { Returns a compact string representation of the temperature quantity in degrees Celsius
      with the given prefix applied.
      @param(AQuantity  The real temperature quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the temperature quantity with controlled precision.
      @param(AQuantity   The real temperature quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the temperature quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> °C').
      @param(AQuantity   The central temperature quantity to format.)
      @param(ATolerance  The tolerance quantity to display alongside the value.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the temperature quantity in degrees Celsius.
      Format: @code('<value> degrees Celsius'), e.g. @code('100 degrees Celsius').
      @param(AQuantity The real temperature quantity to format.)
    }
    function ToVerboseString(const AQuantity: TQuantity): string;

    { Returns a verbose string representation of the temperature quantity with the given prefix.
      @param(AQuantity  The real temperature quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the temperature quantity with controlled precision.
      @param(AQuantity   The real temperature quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the temperature quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> degrees Celsius').
      @param(AQuantity   The central temperature quantity to format.)
      @param(ATolerance  The tolerance quantity to display alongside the value.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
  end;

  { Record helper for @link(TDegreeFahrenheitUnit) providing conversion and
    formatting operations for temperatures expressed in degrees Fahrenheit.

    All extraction methods apply the inverse of the Fahrenheit affine conversion,
    so that a quantity stored internally in kelvin is correctly displayed in @code(°F):
    @code(T[°F] = T[K] × 9/5 - 459.67).

    All @code(ToString) and @code(ToVerboseString) methods produce output with
    the Fahrenheit symbol @code('°F') or name @code('degree Fahrenheit') / @code('degrees Fahrenheit').
  }
  TDegreeFahrenheitUnitHelper = record helper for TDegreeFahrenheitUnit
  public
    { Returns the singular name of the unit with the given prefix applied.
      For the Fahrenheit unit this is typically @code('degree Fahrenheit') without prefix.
      @param(Prefixes The list of SI prefixes to prepend to the unit name.)
    }
    function GetName(const Prefixes: TPrefixes): string;

    { Returns the plural name of the unit with the given prefix applied.
      For the Fahrenheit unit this is typically @code('degrees Fahrenheit') without prefix.
      @param(Prefixes The list of SI prefixes to prepend to the unit plural name.)
    }
    function GetPluralName(const Prefixes: TPrefixes): string;

    { Returns the symbol of the unit with the given prefix applied.
      For the Fahrenheit unit this is typically @code('°F') without prefix.
      @param(Prefixes The list of SI prefixes to prepend to the unit symbol.)
    }
    function GetSymbol(const Prefixes: TPrefixes): string;

    { Returns the real scalar value scaled for the given prefix, expressed in degrees Fahrenheit.
      Applies the inverse affine conversion: @code(T[°F] = T[K] × 9/5 - 459.67).
      @param(AQuantity The dimensionless real value in SI base units (kelvin) to convert.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;

  public

    { Returns the numerical value of the real quantity expressed in degrees Fahrenheit.
      Applies the inverse affine conversion: @code(T[°F] = T[K] × 9/5 - 459.67).
      @param(AQuantity The real temperature quantity stored internally in kelvin.)
    }
    function ToFloat(const AQuantity: TQuantity): double;

    { Returns the numerical value of the real quantity expressed in degrees Fahrenheit
      with the given prefix applied.
      @param(AQuantity  The real temperature quantity stored internally in kelvin.)
      @param(APrefixes  The SI prefixes defining additional output scaling.)
    }
    function ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;

    { eturns a compact string representation of the temperature quantity in degrees Fahrenheit.
      Format: @code('<value> °F'), e.g. @code('212 °F').
      @param(AQuantity The real temperature quantity to format.)
    }
    function ToString(const AQuantity: TQuantity): string;

    { Returns a compact string representation of the temperature quantity in degrees Fahrenheit
      with the given prefix applied.
      @param(AQuantity  The real temperature quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the temperature quantity with controlled precision.
      @param(AQuantity   The real temperature quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the temperature quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> °F').
      @param(AQuantity   The central temperature quantity to format.)
      @param(ATolerance  The tolerance quantity to display alongside the value.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the temperature quantity in degrees Fahrenheit.
      Format: @code('<value> degrees Fahrenheit'), e.g. @code('212 degrees Fahrenheit').
      @param(AQuantity The real temperature quantity to format.)
    }
    function ToVerboseString(const AQuantity: TQuantity): string;

    { Returns a verbose string representation of the temperature quantity with the given prefix.
      @param(AQuantity  The real temperature quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the temperature quantity with controlled precision.
      @param(AQuantity   The real temperature quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the temperature quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> degrees Fahrenheit').
      @param(AQuantity   The central temperature quantity to format.)
      @param(ATolerance  The tolerance quantity to display alongside the value.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
  end;

{ TScalar }

resourcestring
  rsScalarSymbol = '';
  rsScalarName = '';
  rsScalarPluralName = '';

const
  ScalarUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsScalarSymbol;
    FName       : rsScalarName;
    FPluralName : rsScalarPluralName;
    FPrefixes   : ();
    FExponents  : ());

{#UNITSOFMEASUREMENT}

type
  { Represents the basis vector @code(e₁) of @code(ℝ²).
    Acts as a compile-time constant unit vector along the first axis of the 2D real space.
    Multiplying a scalar by this record yields a @link(TR2Vector) scaled along @code(e₁).
  }
  TR2Versor1 = record
    { Returns the vector @code(AValue · e₁) in @code(ℝ²). }
    class operator *(const AValue: double; const ASelf: TR2Versor1): TR2Vector;
  end;

  { Represents the basis vector @code(e₂) of @code(ℝ²).
    Acts as a compile-time constant unit vector along the second axis of the 2D real space.
    Multiplying a scalar by this record yields a @link(TR2Vector) scaled along @code(e₂).
  }
  TR2Versor2 = record
    { Returns the vector @code(AValue · e₂) in @code(ℝ²). }
    class operator *(const AValue: double; const ASelf: TR2Versor2): TR2Vector;
  end;

  { Represents the basis vector @code(e₁) of @code(ℝ³).
    Acts as a compile-time constant unit vector along the first axis of the 3D real space.
    Multiplying a scalar by this record yields a @link(TR3Vector) scaled along @code(e₁).
  }
  TR3Versor1 = record
    { Returns the vector @code(AValue · e₁) in @code(ℝ³). }
    class operator *(const AValue: double; const ASelf: TR3Versor1): TR3Vector;
  end;

  { Represents the basis vector @code(e₂) of @code(ℝ³).
    Acts as a compile-time constant unit vector along the second axis of the 3D real space.
    Multiplying a scalar by this record yields a @link(TR3Vector) scaled along @code(e₂).
  }
  TR3Versor2 = record
    { Returns the vector @code(AValue · e₂) in @code(ℝ³). }
    class operator *(const AValue: double; const ASelf: TR3Versor2): TR3Vector;
  end;

  { Represents the basis vector @code(e₃) of @code(ℝ³).
    Acts as a compile-time constant unit vector along the third axis of the 3D real space.
    Multiplying a scalar by this record yields a @link(TR3Vector) scaled along @code(e₃).
  }
  TR3Versor3 = record
    { Returns the vector @code(AValue · e₃) in @code(ℝ³). }
    class operator *(const AValue: double; const ASelf: TR3Versor3): TR3Vector;
  end;

  { Represents the basis vector @code(e₁) of @code(ℝ⁴).
    Acts as a compile-time constant unit vector along the first axis of the 4D real space.
    Multiplying a scalar by this record yields a @link(TR4Vector) scaled along @code(e₁).
  }
  TR4Versor1 = record
    { Returns the vector @code(AValue · e₁) in @code(ℝ⁴). }
    class operator *(const AValue: double; const ASelf: TR4Versor1): TR4Vector;
  end;

  { Represents the basis vector @code(e₂) of @code(ℝ⁴).
    Acts as a compile-time constant unit vector along the second axis of the 4D real space.
    Multiplying a scalar by this record yields a @link(TR4Vector) scaled along @code(e₂).
  }
  TR4Versor2 = record
    { Returns the vector @code(AValue · e₂) in @code(ℝ⁴). }
    class operator *(const AValue: double; const ASelf: TR4Versor2): TR4Vector;
  end;

  { Represents the basis vector @code(e₃) of @code(ℝ⁴).
    Acts as a compile-time constant unit vector along the third axis of the 4D real space.
    Multiplying a scalar by this record yields a @link(TR4Vector) scaled along @code(e₃).
  }
  TR4Versor3 = record
    { Returns the vector @code(AValue · e₃) in @code(ℝ⁴). }
    class operator *(const AValue: double; const ASelf: TR4Versor3): TR4Vector;
  end;

  { Represents the basis vector @code(e₄) of @code(ℝ⁴).
    Acts as a compile-time constant unit vector along the fourth axis of the 4D real space.
    Multiplying a scalar by this record yields a @link(TR4Vector) scaled along @code(e₄).
  }
  TR4Versor4 = record
    { Returns the vector @code(AValue · e₄) in @code(ℝ⁴). }
    class operator *(const AValue: double; const ASelf: TR4Versor4): TR4Vector;
  end;

  { External operator overloads for multiplying @link(TQuantity) scalars with
    dimensionless matrix types, producing the corresponding matrix quantity types.

    These operators are necessary because Free Pascal does not allow operator
    overloads between two different record types to be defined inside either record
    when neither owns the other. They bridge @link(TQuantity) (defined in the
    dimensional analysis layer) with the generic matrix types (defined in the
    linear algebra layer).

    All operators follow the rule: the resulting dimension equals the dimension
    of the @link(TQuantity) operand, and the numerical values of the matrix
    elements are scaled accordingly.

    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  { Returns the 2×2 real matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ALeft). @exclude }
  operator * (const ALeft: TQuantity; const ARight: TR2Matrix): TR2MatrixQuantity;

  { Returns the 2×2 real matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ARight). @exclude }
  operator * (const ALeft: TR2Matrix; const ARight: TQuantity): TR2MatrixQuantity;

  { Returns the 3×3 real matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ALeft). @exclude }
  operator * (const ALeft: TQuantity; const ARight: TR3Matrix): TR3MatrixQuantity;

  { Returns the 3×3 real matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ARight). @exclude }
  operator * (const ALeft: TR3Matrix; const ARight: TQuantity): TR3MatrixQuantity;

  { Returns the 4×4 real matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ALeft). @exclude }
  operator * (const ALeft: TQuantity; const ARight: TR4Matrix): TR4MatrixQuantity;

  { Returns the 4×4 real matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ARight). @exclude }
  operator * (const ALeft: TR4Matrix; const ARight: TQuantity): TR4MatrixQuantity;

  { Returns the 2×2 complex matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ALeft). @exclude }
  operator * (const ALeft: TQuantity; const ARight: TC2Matrix): TC2MatrixQuantity;

  { Returns the 2×2 complex matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ARight). @exclude }
  operator * (const ALeft: TC2Matrix; const ARight: TQuantity): TC2MatrixQuantity;

  { Returns the 3×3 complex matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ALeft). @exclude }
  operator * (const ALeft: TQuantity; const ARight: TC3Matrix): TC3MatrixQuantity;

  { Returns the 3×3 complex matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ARight). @exclude }
  operator * (const ALeft: TC3Matrix; const ARight: TQuantity): TC3MatrixQuantity;

  { Returns the 4×4 complex matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ALeft). @exclude }
  operator * (const ALeft: TQuantity; const ARight: TC4Matrix): TC4MatrixQuantity;

  { Returns the 4×4 complex matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ARight). @exclude }

  operator * (const ALeft: TC4Matrix; const ARight: TQuantity): TC4MatrixQuantity;
  {$ENDIF}

  { Returns the square of the complex number @code(AValue).
    Defined as @code(z² = (Re² - Im²) + 2·Re·Im·i).
    @param(AValue The complex number to square.)
  }
  function SquarePower(const AValue: TComplex): TComplex;

  { Returns the cube of the complex number @code(AValue).
    Defined as @code(z³ = z² · z).
    @param(AValue The complex number to cube.)
  }
  function CubicPower(const AValue: TComplex): TComplex;

  { Returns the fourth power of the complex number @code(AValue).
    Defined as @code(z⁴ = (z²)²).
    @param(AValue The complex number to raise to the fourth power.)
  }
  function QuarticPower(const AValue: TComplex): TComplex;

  {$IFNDEF ADIMOFF}
  { Returns the square of the complex quantity @code(AQuantity).
    The resulting dimension is the square of the original dimension.
    @param(AQuantity The complex quantity to square.)
  }
  function SquarePower(const AQuantity: TComplexQuantity): TComplexQuantity;

  { Returns the cube of the complex quantity @code(AQuantity).
    The resulting dimension is the cube of the original dimension.
    @param(AQuantity The complex quantity to cube.)
  }
  function CubicPower(const AQuantity: TComplexQuantity): TComplexQuantity;

  { Returns the fourth power of the complex quantity @code(AQuantity).
    The resulting dimension is the fourth power of the original dimension.
    @param(AQuantity The complex quantity to raise to the fourth power.)
  }
  function QuarticPower(const AQuantity: TComplexQuantity): TComplexQuantity;
  {$ENDIF}

  { Returns all square roots of the complex number @code(AValue) as a fixed-size array.
    A non-zero complex number has exactly 2 square roots, equally spaced in argument
    by @code(π): @code(z^(1/2) = |z|^(1/2) · e^(i·(φ + 2kπ)/2)) for @code(k = 0, 1).
    @param(AValue The complex number whose square roots are computed.)
  }
  function SquareRoot(const AValue: TComplex): TC2ArrayOfComplex;

  { Returns all cube roots of the complex number @code(AValue) as a fixed-size array.
    A non-zero complex number has exactly 3 cube roots, equally spaced in argument
    by @code(2π/3): @code(z^(1/3) = |z|^(1/3) · e^(i·(φ + 2kπ)/3)) for @code(k = 0, 1, 2).
    @param(AValue The complex number whose cube roots are computed.)
  }
  function CubicRoot(const AValue: TComplex): TC3ArrayOfComplex;

  { Returns all fourth roots of the complex number @code(AValue) as a fixed-size array.
    A non-zero complex number has exactly 4 fourth roots, equally spaced in argument
    by @code(π/2): @code(z^(1/4) = |z|^(1/4) · e^(i·(φ + 2kπ)/4)) for @code(k = 0, 1, 2, 3).
    @param(AValue The complex number whose fourth roots are computed.)
  }
  function QuarticRoot(const AValue: TComplex): TC4ArrayOfComplex;

  { Returns the absolute value of a real number.
    Equivalent to the standard @code(System.Abs) but provided for
    consistency with the overloaded complex version.
    @param(AValue The real number.)
  }
  function Abs(const AValue: double): double;

  { Returns the modulus (magnitude) of a complex number.
    Defined as @code(|z| = √(Re² + Im²)).
    @param(AValue The complex number.)
  }
  function Abs(const AValue: TComplex): double;

  { Returns the commutator of two 2×2 complex matrices.
    Defined as @code([A, B] = A·B - B·A).
    The commutator is zero if and only if the two matrices commute.
    @param(ALeft  The left-hand matrix operand.)
    @param(ARight The right-hand matrix operand.)
  }
  function Commutator(const ALeft, ARight: TC2Matrix): TC2Matrix;

  { Returns the commutator of two 3×3 complex matrices.
    Defined as @code([A, B] = A·B - B·A).
    The commutator is zero if and only if the two matrices commute.
    @param(ALeft  The left-hand matrix operand.)
    @param(ARight The right-hand matrix operand.)
  }
  function Commutator(const ALeft, ARight: TC3Matrix): TC3Matrix;

  { Returns the commutator of two 4×4 complex matrices.
    Defined as @code([A, B] = A·B - B·A).
    The commutator is zero if and only if the two matrices commute.
    @param(ALeft  The left-hand matrix operand.)
    @param(ARight The right-hand matrix operand.)
  }
  function Commutator(const ALeft, ARight: TC4Matrix): TC4Matrix;

  { Returns @true if two real numbers are equal within the default floating point tolerance.
    Uses an epsilon-based comparison to account for floating point rounding errors.
    @param(AValue1 The first real number.)
    @param(AValue2 The second real number.)
  }
  function SameValueEx(const AValue1, AValue2: double): boolean;

  { Returns @true if two complex numbers are equal within the default floating point tolerance.
    Both the real and imaginary parts must be within tolerance.
    @param(AValue1 The first complex number.)
    @param(AValue2 The second complex number.)
  }
  function SameValueEx(const AValue1, AValue2: TComplex): boolean;

  { Returns @true if two 2-component complex vectors are equal within the default floating point tolerance.
    All corresponding components must be within tolerance.
    @param(AValue1 The first complex vector.)
    @param(AValue2 The second complex vector.)
  }
  function SameValueEx(const AValue1, AValue2: TC2Vector): boolean;

  { Returns @true if two 3-component complex vectors are equal within the default floating point tolerance.
    All corresponding components must be within tolerance.
    @param(AValue1 The first complex vector.)
    @param(AValue2 The second complex vector.)
  }
  function SameValueEx(const AValue1, AValue2: TC3Vector): boolean;

  { Returns @true if two 4-component complex vectors are equal within the default floating point tolerance.
    All corresponding components must be within tolerance.
    @param(AValue1 The first complex vector.)
    @param(AValue2 The second complex vector.)
  }
  function SameValueEx(const AValue1, AValue2: TC4Vector): boolean;

  { Returns @true if two 2×2 complex matrices are equal within the default floating point tolerance.
    All corresponding elements must be within tolerance.
    @param(AValue1 The first complex matrix.)
    @param(AValue2 The second complex matrix.)
  }
  function SameValueEx(const AValue1, AValue2: TC2Matrix): boolean;

  { Returns @true if two 3×3 complex matrices are equal within the default floating point tolerance.
    All corresponding elements must be within tolerance.
    @param(AValue1 The first complex matrix.)
    @param(AValue2 The second complex matrix.)
  }
  function SameValueEx(const AValue1, AValue2: TC3Matrix): boolean;

  { Returns @true if two 4×4 complex matrices are equal within the default floating point tolerance.
    All corresponding elements must be within tolerance.
    @param(AValue1 The first complex matrix.)
    @param(AValue2 The second complex matrix.)
  }
  function SameValueEx(const AValue1, AValue2: TC4Matrix): boolean;

  {$IFNDEF ADIMOFF}
  { Returns @true if two real physical quantities are equal within the default floating point tolerance.
    Both operands must have the same dimension; an exception is raised if they differ.
    @param(ALeft  The first quantity.)
    @param(ARight The second quantity.)
  }
  function SameValueEx(const ALeft, ARight: TQuantity): boolean;
  {$ENDIF}

  { Solves the linear equation @code(a·x = 0) over the reals.
    Returns @code(x = 0) for any non-zero @code(a), or raises an exception if @code(a = 0).
    @param(a The coefficient of the linear term.)
  }
  function SolveEquation(const a: double): double;

  { Solves the linear equation @code(a·z = 0) over the complex numbers.
    Returns @code(z = 0) for any non-zero @code(a), or raises an exception if @code(a = 0).
    @param(a The complex coefficient of the linear term.)
  }
  function SolveEquation(const a: TComplex): TComplex;

  { Solves the linear equation @code(a·z + b = 0) over the complex numbers.
    Returns the single root @code(z = -b/a) as a @link(TC2ArrayOfComplex).
    @raises(Exception if @code(a = 0).)
    @param(a The complex coefficient of the linear term.)
    @param(b The complex constant term.)
  }
  function SolveEquation(const a, b: TComplex): TC2ArrayOfComplex;

  { Solves the quadratic equation @code(a·z² + b·z + c = 0) over the complex numbers.
    Returns both roots (including repeated roots) as a @link(TC3ArrayOfComplex).
    @raises(Exception if @code(a = 0).)
    @param(a The complex coefficient of the quadratic term.)
    @param(b The complex coefficient of the linear term.)
    @param(c The complex constant term.)
  }
  function SolveEquation(const a, b, c: TComplex): TC3ArrayOfComplex;

  { Solves the cubic equation @code(a·z³ + b·z² + c·z + d = 0) over the complex numbers
    using Cardano's method. Returns all three roots as a @link(TC4ArrayOfComplex).
    @raises(Exception if @code(a = 0).)
    @param(a The complex coefficient of the cubic term.)
    @param(b The complex coefficient of the quadratic term.)
    @param(c The complex coefficient of the linear term.)
    @param(d The complex constant term.)
  }
  function SolveEquation(const a, b, c, d: TComplex): TC4ArrayOfComplex;

  { Checks that two dimensions are equal and raises an exception if they differ.
    Used internally to validate operands of addition, subtraction, and comparison operators.
    @param(ALeft  The dimension of the left operand.)
    @param(ARight The dimension of the right operand.)
  }
  procedure Check(ALeft, ARight: TDimension); inline;

  { Checks that two dimensions are equal and returns the common dimension.
    @raises(Exception if the two dimensions differ.)
    @param(ALeft  The dimension of the left operand.)
    @param(ARight The dimension of the right operand.)
  }
  function CheckEqual(ALeft, ARight: TDimension): TDimension; inline;

  { Validates that two dimensions are compatible for addition and returns the common dimension.
    @raises(Exception if the two dimensions differ.)
    @param(ALeft  The dimension of the left operand.)
    @param(ARight The dimension of the right operand.)
  }
  function CheckSum(ALeft, ARight: TDimension): TDimension; inline;

  { Validates that two dimensions are compatible for subtraction and returns the common dimension.
    @raises(Exception if the two dimensions differ.)
    @param(ALeft  The dimension of the left operand.)
    @param(ARight The dimension of the right operand.)
  }
  function CheckSub(ALeft, ARight: TDimension): TDimension; inline;

  { Returns the dimension resulting from multiplying two quantities.
    The result is the sum of the two dimension exponent vectors.
    @param(ALeft  The dimension of the left operand.)
    @param(ARight The dimension of the right operand.)
  }
  function CheckMul(ALeft, ARight: TDimension): TDimension; inline;

  { Returns the dimension resulting from dividing two quantities.
    The result is the difference of the two dimension exponent vectors.
    @param(ALeft  The dimension of the numerator.)
    @param(ARight The dimension of the denominator.)
  }
  function CheckDiv(ALeft, ARight: TDimension): TDimension; inline;

  { Returns the square of the quantity: @code(AQuantity²).
    The resulting dimension is the square of the original dimension.
    @param(AQuantity The quantity to square.)
  }
  function SquarePower(const AQuantity: TQuantity): TQuantity;

  { Returns the cube of the quantity: @code(AQuantity³).
    The resulting dimension is the cube of the original dimension.
    @param(AQuantity The quantity to cube.)
  }
  function CubicPower(const AQuantity: TQuantity): TQuantity;

  { Returns the fourth power of the quantity: @code(AQuantity⁴).
    The resulting dimension is the fourth power of the original dimension.
    @param(AQuantity The quantity to raise to the fourth power.)
  }
  function QuarticPower(const AQuantity: TQuantity): TQuantity;

  { Returns the fifth power of the quantity: @code(AQuantity⁵).
    The resulting dimension is the fifth power of the original dimension.
    @param(AQuantity The quantity to raise to the fifth power.)
  }
  function QuinticPower(const AQuantity: TQuantity): TQuantity;

  { Returns the sixth power of the quantity: @code(AQuantity⁶).
    The resulting dimension is the sixth power of the original dimension.
    @param(AQuantity The quantity to raise to the sixth power.)
  }
  function SexticPower(const AQuantity: TQuantity): TQuantity;

  { Returns the square root of the quantity: @code(AQuantity^(1/2)).
    The resulting dimension has all exponents halved.
    @raises(Exception if any dimension exponent is odd.)
    @param(AQuantity The quantity whose square root is computed.)
  }
  function SquareRoot(const AQuantity: TQuantity): TQuantity;

  { Returns the cube root of the quantity: @code(AQuantity^(1/3)).
    The resulting dimension has all exponents divided by 3.
    @raises(Exception if any dimension exponent is not divisible by 3.)
    @param(AQuantity The quantity whose cube root is computed.)
  }
  function CubicRoot(const AQuantity: TQuantity): TQuantity;

  { Returns the fourth root of the quantity: @code(AQuantity^(1/4)).
    The resulting dimension has all exponents divided by 4.
    @raises(Exception if any dimension exponent is not divisible by 4.)
    @param(AQuantity The quantity whose fourth root is computed.)
  }
  function QuarticRoot(const AQuantity: TQuantity): TQuantity;

  { Returns the fifth root of the quantity: @code(AQuantity^(1/5)).
    The resulting dimension has all exponents divided by 5.
    @raises(Exception if any dimension exponent is not divisible by 5.)
    @param(AQuantity The quantity whose fifth root is computed.)
  }
  function QuinticRoot(const AQuantity: TQuantity): TQuantity;

  { Returns the sixth root of the quantity: @code(AQuantity^(1/6)).
    The resulting dimension has all exponents divided by 6.
    @raises(Exception if any dimension exponent is not divisible by 6.)
    @param(AQuantity The quantity whose sixth root is computed.)
  }
  function SexticRoot(const AQuantity: TQuantity): TQuantity;

  { Returns the cosine of the angle quantity.
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(double).
    @param(AQuantity The angle quantity in radians.)
  }
  function Cos(const AQuantity: TQuantity): double;

  { Returns the sine of the angle quantity.
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(double).
    @param(AQuantity The angle quantity in radians.)
  }
  function Sin(const AQuantity: TQuantity): double;

  { Returns the tangent of the angle quantity.
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(double).
    @param(AQuantity The angle quantity in radians.)
  }
  function Tan(const AQuantity: TQuantity): double;

  { Returns the cotangent of the angle quantity: @code(cos(θ)/sin(θ)).
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(double).
    @param(AQuantity The angle quantity in radians.)
  }
  function Cotan(const AQuantity: TQuantity): double;

  { Returns the secant of the angle quantity: @code(1/cos(θ)).
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(double).
    @param(AQuantity The angle quantity in radians.)
  }
  function Secant(const AQuantity: TQuantity): double;

  { Returns the cosecant of the angle quantity: @code(1/sin(θ)).
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(double).
    @param(AQuantity The angle quantity in radians.)
  }
  function Cosecant(const AQuantity: TQuantity): double;

  { Returns the arc cosine of @code(AValue) as an angle quantity in radians.
    @code(AValue) must be in the range @code([-1, 1]).
    The result has the dimension of an angle (radians).
    @param(AValue The dimensionless cosine value.)
  }
  function ArcCos(const AValue: double): TQuantity;

  { Returns the arc sine of @code(AValue) as an angle quantity in radians.
    @code(AValue) must be in the range @code([-1, 1]).
    The result has the dimension of an angle (radians).
    @param(AValue The dimensionless sine value.)
  }
  function ArcSin(const AValue: double): TQuantity;

  { Returns the arc tangent of @code(AValue) as an angle quantity in radians.
    The result is in the range @code((-π/2, π/2)).
    The result has the dimension of an angle (radians).
    @param(AValue The dimensionless tangent value.)
  }
  function ArcTan(const AValue: double): TQuantity;

  { Returns the arc tangent of @code(y/x) as an angle quantity in radians,
    using the signs of both arguments to determine the correct quadrant.
    The result is in the range @code((-π, π]).
    The result has the dimension of an angle (radians).
    @param(x The dimensionless x-coordinate.)
    @param(y The dimensionless y-coordinate.)
  }
  function ArcTan2(const x, y: double): TQuantity;

  { Returns the smaller of two quantities.
    Both operands must have the same dimension.
    @param(ALeft  The first quantity.)
    @param(ARight The second quantity.)
  }
  function Min(const ALeft, ARight: TQuantity): TQuantity;

  { Returns the larger of two quantities.
    Both operands must have the same dimension.
    @param(ALeft  The first quantity.)
    @param(ARight The second quantity.)
  }
  function Max(const ALeft, ARight: TQuantity): TQuantity;

  { Returns @code(e^AQuantity) as a dimensioned quantity.
    The argument must be dimensionless; the result has the same dimension as the argument.
    @param(AQuantity The dimensionless exponent quantity.)
  }
  function Exp(const AQuantity: TQuantity): TQuantity;

  { Returns the base-10 logarithm of the quantity as a dimensionless @code(double).
    The argument must be dimensionless and positive.
    @param(AQuantity The dimensionless positive quantity.)
  }
  function Log10(const AQuantity: TQuantity): double;

  { Returns the base-2 logarithm of the quantity as a dimensionless @code(double).
    The argument must be dimensionless and positive.
    @param(AQuantity The dimensionless positive quantity.)
  }
  function Log2(const AQuantity: TQuantity): double;

  { Returns the base-@code(ABase) logarithm of the quantity as a dimensionless @code(double).
    The argument must be dimensionless and positive.
    @param(ABase     The integer logarithm base.)
    @param(AQuantity The dimensionless positive quantity.)
  }
  function LogN(ABase: longint; const AQuantity: TQuantity): double;

  { Returns the logarithm of @code(AQuantity) in the base @code(ABase) as a dimensionless @code(double).
    Both arguments must be dimensionless and positive.
    @param(ABase     The dimensionless base quantity.)
    @param(AQuantity The dimensionless positive quantity.)
  }
  function LogN(const ABase, AQuantity: TQuantity): double;

  { Returns @code(ABase^AExponent) as a dimensionless @code(double).
    The base must be dimensionless. Used for fractional or real exponents
    where dimensional consistency cannot be verified at compile time.
    @param(ABase     The dimensionless base quantity.)
    @param(AExponent The real exponent.)
  }
  function Power(const ABase: TQuantity; AExponent: double): double;

  { Returns @true if the quantity is less than or equal to zero.
    The quantity must be dimensionless or the comparison must be meaningful
    within its dimension context.
    @param(AQuantity The quantity to test.)
  }
  function LessThanOrEqualToZero(const AQuantity: TQuantity): boolean;

  { Returns @true if the quantity is strictly less than zero.
    @param(AQuantity The quantity to test.)
  }
  function LessThanZero(const AQuantity: TQuantity): boolean;

  { Returns @true if the quantity is equal to zero within the default floating point tolerance.
    @param(AQuantity The quantity to test.)
  }
  function EqualToZero(const AQuantity: TQuantity): boolean;

  { Returns @true if the quantity is not equal to zero within the default floating point tolerance.
    @param(AQuantity The quantity to test.)
  }
  function NotEqualToZero(const AQuantity: TQuantity): boolean;

  { Returns @true if the quantity is greater than or equal to zero.
    @param(AQuantity The quantity to test.)
  }
  function GreaterThanOrEqualToZero(const AQuantity: TQuantity): boolean;

  { Returns @true if the quantity is strictly greater than zero.
    @param(AQuantity The quantity to test.)
  }
  function GreaterThanZero(const AQuantity: TQuantity): boolean;

  { Returns the zero vector of @code(ℂ²). All 2 components are set to @code(TComplex(Re=0, Im=0)). }
  function C2NullVector: TC2Vector;

  { Returns the zero vector of @code(ℂ³). All 3 components are set to @code(TComplex(Re=0, Im=0)). }
  function C3NullVector: TC3Vector;

  { Returns the zero vector of @code(ℂ⁴). All 4 components are set to @code(TComplex(Re=0, Im=0)). }
  function C4NullVector: TC4Vector;

  { Returns the 2×2 zero matrix over @code(ℂ). All elements are set to @code(TComplex(Re=0, Im=0)). }
  function C2NullMatrix: TC2Matrix;

  { Returns the 3×3 zero matrix over @code(ℂ). All elements are set to @code(TComplex(Re=0, Im=0)). }
  function C3NullMatrix: TC3Matrix;

  { Returns the 4×4 zero matrix over @code(ℂ). All elements are set to @code(TComplex(Re=0, Im=0)). }
  function C4NullMatrix: TC4Matrix;

  { Returns the 2×2 identity matrix over @code(ℂ).
    Diagonal elements are @code(TComplex(Re=1, Im=0)); all off-diagonal elements are zero.
    Satisfies @code(I·A = A·I = A) for any conforming 2×2 complex matrix @code(A).
  }
  function C2IdentityMatrix: TC2Matrix;

  { Returns the 3×3 identity matrix over @code(ℂ).
    Diagonal elements are @code(TComplex(Re=1, Im=0)); all off-diagonal elements are zero.
    Satisfies @code(I·A = A·I = A) for any conforming 3×3 complex matrix @code(A).
  }
  function C3IdentityMatrix: TC3Matrix;

  { Returns the 4×4 identity matrix over @code(ℂ).
    Diagonal elements are @code(TComplex(Re=1, Im=0)); all off-diagonal elements are zero.
    Satisfies @code(I·A = A·I = A) for any conforming 4×4 complex matrix @code(A).
  }
  function C4IdentityMatrix: TC4Matrix;

const
  { Avogadro constant @code(Nₐ = 6.02214076 × 10²³ mol⁻¹).
    Number of constituent particles per mole of substance. }
  AvogadroConstant               : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole: -60; FCandela: 0; FSteradian: 0); FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}

  { Bohr magneton @code(μB = 9.2740100657 × 10⁻²⁴ J·T⁻¹).
    Natural unit of electronic magnetic dipole moment. }
  BohrMagneton                   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:  120; FSecond:    0; FAmpere:   60; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}

  { Bohr radius @code(a₀ = 5.29177210903 × 10⁻¹¹ m).
    Most probable distance between the electron and nucleus in a hydrogen atom ground state. }
  BohrRadius                     : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}

  { Boltzmann constant @code(kB = 1.380649 × 10⁻²³ J·K⁻¹).
    Relates the average kinetic energy of particles in a gas to the thermodynamic temperature. }
  BoltzmannConstant              : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond: -120; FAmpere:    0; FKelvin: -60; FMole:   0; FCandela: 0; FSteradian: 0); FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}

  { Compton wavelength @code(λC = 2.42631023867 × 10⁻¹² m).
    Quantum mechanical property of the electron; sets the scale at which quantum field effects become significant. }
  ComptonWaveLength              : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}

  { Coulomb constant @code(ke = 8.9875517923 × 10⁹ N·m²·C⁻²).
    Proportionality constant in Coulomb's law of electrostatic force. }
  CoulombConstant                : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  180; FSecond: -240; FAmpere: -120; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}

  { Deuteron mass @code(m_d = 3.3435837768 × 10⁻²⁷ kg).
    Rest mass of the deuteron (nucleus of deuterium, one proton and one neutron). }
  DeuteronMass                   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}

  { Electric permittivity of free space @code(ε₀ = 8.8541878188 × 10⁻¹² F·m⁻¹).
    Relates electric field to electric displacement field in a vacuum. }
  ElectricPermittivity           : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter: -180; FSecond:  240; FAmpere:  120; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     8.8541878188E-12); {$ELSE} (    8.8541878188E-12); {$ENDIF}

  { Electron rest mass @code(m_e = 9.1093837015 × 10⁻³¹ kg).
    Rest mass of the electron. }
  ElectronMass                   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}

  { Elementary charge @code(e = 1.602176634 × 10⁻¹⁹ C).
      Electric charge carried by a single proton; the fundamental unit of electric charge. }
  ElectronCharge                 : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:   60; FAmpere:   60; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}

  { Fine-structure constant @code(α = 7.2973525643 × 10⁻³) (dimensionless).
    Characterises the strength of the electromagnetic interaction between elementary charged particles. }
  FineStructureConstant          : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      7.2973525643E-3); {$ELSE} (     7.2973525643E-3); {$ENDIF}

  { Inverse fine-structure constant @code(α⁻¹ = 137.035999177) (dimensionless).
    Reciprocal of the fine-structure constant; often used in quantum electrodynamics. }
  InverseFineStructureConstant   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:        137.035999177); {$ELSE} (       137.035999177); {$ENDIF}

  { Magnetic permeability of free space @code(μ₀ = 1.25663706212 × 10⁻⁶ H·m⁻¹).
    Relates magnetic field intensity to magnetic flux density in a vacuum. }
  MagneticPermeability           : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:   60; FSecond: -120; FAmpere: -120; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}

  { Molar gas constant @code(R = 8.314462618 J·mol⁻¹·K⁻¹).
    Relates energy to temperature and amount of substance in the ideal gas law. }
  MolarGasConstant               : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond:  120; FAmpere:    0; FKelvin: -60; FMole: -60; FCandela: 0; FSteradian: 0); FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}

  { Neutron rest mass @code(m_n = 1.67492750056 × 10⁻²⁷ kg).
    Rest mass of the neutron. }
  NeutronRestMass                : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}

  { Newtonian constant of gravitation @code(G = 6.67430 × 10⁻¹¹ m³·kg⁻¹·s⁻²).
    Proportionality constant in Newton's law of universal gravitation. }
  NewtonianConstantOfGravitation : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter:  180; FSecond: -120; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}

  { Planck constant @code(h = 6.62607015 × 10⁻³⁴ J·s).
    Relates the energy of a photon to its frequency; fundamental constant of quantum mechanics. }
  PlanckConstant                 : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond:  -60; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}

  { Proton rest mass @code(m_p = 1.67262192595 × 10⁻²⁷ kg).
    Rest mass of the proton. }
  ProtonMass                     : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}

  { Rydberg constant @code(R∞ = 10973731.568157 m⁻¹).
    Relates the wavelengths of spectral lines of the hydrogen atom. }
  RydbergConstant                : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:  -60; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}

  { Speed of light in vacuum @code(c = 299792458 m·s⁻¹).
    Exact defined value; maximum speed of propagation of any physical interaction. }
  SpeedOfLight                   : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond:  -60; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}

  { Squared speed of light in vacuum @code(c² = 8.98755178736818 × 10¹⁶ m²·s⁻²).
    Appears in the mass-energy equivalence relation @code(E = mc²). }
  SquaredSpeedOfLight            : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:  120; FSecond: -120; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}

  { Standard acceleration of gravity @code(g = 9.80665 m·s⁻²).
    Conventional standard value of the acceleration due to Earth's gravity at sea level. }
  StandardAccelerationOfGravity  : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond: -120; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}

  { Reduced Planck constant @code(ℏ = h / (2π) = 1.054571817 × 10⁻³⁴ J·s).
    Also called the Dirac constant; appears in quantum mechanics wherever angular frequency is used. }
  ReducedPlanckConstant          : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond:  -60; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}

  { Unified atomic mass unit @code(u = 1.66053906892 × 10⁻²⁷ kg).
    Defined as one twelfth of the mass of a carbon-12 atom at rest. }
  UnifiedAtomicMassUnit          : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}

  { Reference sound intensity @code(I₀ = 10⁻¹² W·m⁻²).
    Conventional threshold of human hearing at 1 kHz; used as the reference level
    for the decibel scale of sound intensity. }
  SoundIntensityReference        : TQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond: -180; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:                1E-12); {$ELSE} (               1E-12); {$ENDIF}

{ Prefix Table }

const
  PrefixTable: array[pQuetta..pQuecto] of
    record  Symbol, Name: string; Exponent: longint end = (
    (Symbol: 'Q';   Name: 'quetta';  Exponent: +30),
    (Symbol: 'R';   Name: 'ronna';   Exponent: +27),
    (Symbol: 'Y';   Name: 'yotta';   Exponent: +24),
    (Symbol: 'Z';   Name: 'zetta';   Exponent: +21),
    (Symbol: 'E';   Name: 'exa';     Exponent: +18),
    (Symbol: 'P';   Name: 'peta';    Exponent: +15),
    (Symbol: 'T';   Name: 'tera';    Exponent: +12),
    (Symbol: 'G';   Name: 'giga';    Exponent: +09),
    (Symbol: 'M';   Name: 'mega';    Exponent: +06),
    (Symbol: 'k';   Name: 'kilo';    Exponent: +03),
    (Symbol: 'h';   Name: 'hecto';   Exponent: +02),
    (Symbol: 'da';  Name: 'deca';    Exponent: +01),
    (Symbol: '';    Name: '';        Exponent:  00),
    (Symbol: 'd';   Name: 'deci';    Exponent: -01),
    (Symbol: 'c';   Name: 'centi';   Exponent: -02),
    (Symbol: 'm';   Name: 'milli';   Exponent: -03),
    (Symbol: 'μ';   Name: 'micro';   Exponent: -06),
    (Symbol: 'n';   Name: 'nano';    Exponent: -09),
    (Symbol: 'p';   Name: 'pico';    Exponent: -12),
    (Symbol: 'f';   Name: 'femto';   Exponent: -15),
    (Symbol: 'a';   Name: 'atto';    Exponent: -18),
    (Symbol: 'z';   Name: 'zepto';   Exponent: -21),
    (Symbol: 'y';   Name: 'yocto';   Exponent: -24),
    (Symbol: 'r';   Name: 'ronto';   Exponent: -27),
    (Symbol: 'q';   Name: 'quecto';  Exponent: -30)
  );

{ Default Epsilon }

var

  DefaultEpsilon : double = 1E-12;

implementation

uses Math;

// Format routines

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

// TQuantity

{$IFNDEF ADIMOFF}
function TQuantity.Reciprocal: TQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := 1/FValue;
end;

class operator TQuantity.+(const ASelf: TQuantity): TQuantity;
begin
  result.FDim := ASelf.FDim;
  result.FValue := ASelf.FValue;
end;

class operator TQuantity.-(const ASelf: TQuantity): TQuantity;
begin
  result.FDim := ASelf.FDim;
  result.FValue := -ASelf.FValue;
end;

class operator TQuantity.+(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.-(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.*(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity.*(const ALeft: double; const ARight: TQuantity): TQuantity;
begin
  result.FDim := CheckMul(ScalarUnit.FDim, ARight.FDim);
  result.FValue:= ALeft * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: double): TQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue:= ALeft.FValue * ARight;
end;

class operator TQuantity./(const ALeft: double; const ARight: TQuantity): TQuantity;
begin
  result.FDim := -ARight.FDim;
  result.FValue:= ALeft / ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: double): TQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue:= ALeft.FValue / ARight;
end;

class operator TQuantity.=(const ALeft, ARight: TQuantity): boolean; inline;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TQuantity.<(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue < ARight.FValue;
end;

class operator TQuantity.>(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue > ARight.FValue;
end;

class operator TQuantity.<=(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <= ARight.FValue;
end;

class operator TQuantity.>=(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue >= ARight.FValue;
end;

class operator TQuantity.<>(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TQuantity.:=(const AValue: double): TQuantity;
const
  Scalar : TDimension = (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
begin
  result.FDim := Scalar;
  result.FValue := AValue;
end;
{$ENDIF}

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
  result := SameValueEx(fRe, 0) and
            SameValueEx(fIm, 0);
end;

function TComplex.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TComplex.Norm: double;
begin
  result := hypot(fRe, fIm);
end;

function TComplex.Reciprocal: TComplex;
begin
  result := Conjugate / SquaredNorm;
end;

function TComplex.SquaredNorm: double;
begin
  result := sqr(fRe) + sqr(fIm);
end;

function TComplex.ToString: string;
var
  sign: array[boolean] of string = ('+', '-');
begin
  if (not SameValueEx(fRe, 0)) and
     (not SameValueEx(fIm, 0)) then
  begin
    if (SameValueEx(Abs(fIm), 1)) then
      result := Format('%s %si', [FloatToStr(fRe), sign[fIm < 0]])
    else
      result := Format('%s %s%s∙i', [FloatToStr(fRe), sign[fIm < 0], FloatToStr(Abs(fIm))]);
  end else
    if (not SameValueEx(fRe, 0)) then
      result := Format('%s', [FloatToStr(fRe)])
    else
      if (not SameValueEx(fIm, 0)) then
      begin
        if (SameValueEx(fIm, 1)) then
          result := 'i'
        else if (SameValueEx(fIm, -1)) then
          result := '-i'
        else
          result := Format('%s∙i', [FloatToStr(fIm)])
      end else
        result := '0';
end;

function TComplex.ToString(APrecision, ADigits: integer): string;
var
  sign: array[boolean] of string = ('+', '-');
begin
  if (not SameValueEx(fRe, 0)) and
     (not SameValueEx(fIm, 0)) then
  begin
    if (SameValueEx(Abs(fIm), 1)) then
      result := Format('%s %si', [FloatToStrF(fRe, ffGeneral, APrecision, ADigits), sign[fIm < 0]])
    else
      result := Format('%s %s%s∙i', [FloatToStrF(fRe,      ffGeneral, APrecision, ADigits), sign[fIm < 0],
                                     FloatToStrF(Abs(fIm), ffGeneral, APrecision, ADigits)]);
  end else
    if (not SameValueEx(fRe, 0)) then
      result := Format('%s', [FloatToStrF(fRe, ffGeneral, APrecision, ADigits)])
    else
      if (not SameValueEx(fIm, 0)) then
      begin
        if (SameValueEx(fIm, 1)) then
          result := 'i'
        else if (SameValueEx(fIm, -1)) then
          result := '-i'
        else
          result := Format('%s∙i', [FloatToStrF(fIm, ffGeneral, APrecision, ADigits)])
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
  result := (ALeft.fRe = ARight.fRe) and
            (ALeft.fIm = ARight.fIm);
end;

class operator TComplex.<>(const ALeft, ARight: TComplex): boolean;
begin
  result := (ALeft.fRe <> ARight.fRe) or
            (ALeft.fIm <> ARight.fIm);
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

class operator TComplex.-(const ALeft: double; const ARight: TComplex): TComplex; inline;
begin
  result.fRe := ALeft - ARight.fRe;
  result.fIm :=       - ARight.fIm;;
end;

class operator TComplex.-(const ALeft: TComplex; const ARight: double): TComplex; inline;
begin
  result.fRe := ALeft.fRe - ARight;
  result.fIm := ALeft.fIm;
end;

class operator TComplex.*(const ALeft, ARight: TComplex): TComplex;
begin
  result.fRe := ALeft.fRe * ARight.fRe - ALeft.fIm * ARight.fIm;
  result.fIm := ALeft.fRe * ARight.fIm + ALeft.fIm * ARight.fRe;
end;

class operator TComplex.*(const ALeft: double; const ARight: TComplex): TComplex; inline;
begin
  result.fRe := ALeft * ARight.fRe;
  result.fIm := ALeft * ARight.fIm;
end;

class operator TComplex.*(const ALeft: TComplex; const ARight: double): TComplex; inline;
begin
  result.fRe := ALeft.fRe * ARight;
  result.fIm := ALeft.fIm * ARight;
end;

class operator TComplex./(const ALeft, ARight: TComplex): TComplex;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TComplex./(const ALeft: double; const ARight: TComplex): TComplex; inline;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TComplex./(const ALeft: TComplex; const ARight: double): TComplex; inline;
begin
  result.fRe := ALeft.fRe / ARight;
  result.fIm := ALeft.fIm / ARight;
end;

// TComplexQuantity

{$IFNDEF ADIMOFF}
class operator TComplexQuantity.:=(const AQuantity: TQuantity): TComplexQuantity;
begin
  result.FDim := AQuantity.FDim;
  result.FValue := AQuantity.FValue;
end;

class operator TComplexQuantity.=(const ALeft, ARight: TComplexQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TComplexQuantity.<>(const ALeft, ARight: TComplexQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TComplexQuantity.+(const AValue: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TComplexQuantity.+(const ALeft, ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TComplexQuantity.-(const AValue: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
end;

class operator TComplexQuantity.-(const ALeft, ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft, ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

class operator TComplexQuantity./(const ALeft, ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TComplexQuantity./(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := -ARight.FDim;
  result.FValue := ALeft / ARight.FValue;
end;

class operator TComplexQuantity./(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

class operator TComplexQuantity.+(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TComplexQuantity.+(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TComplexQuantity.-(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TComplexQuantity.-(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TComplexQuantity./(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TComplexQuantity./(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

// TImaginayUnit

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
  result.fRe := ALeft;
  result.fIm := -1;
end;

class operator TImaginaryUnit.-(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
begin
  result.fRe := -ARight;
  result.fIm := 1;
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
  result.fRe :=   -ARight.fRe;
  result.fIm := 1 -ARight.fIm;
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
  result.fIm := 1/ARight;
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
  denom := ARight.SquaredNorm;
  result.fRe :=  ARight.fIm / denom;
  result.fIm :=  ARight.fRe / denom;
end;

{$IFNDEF ADIMOFF}
class operator TImaginaryUnit.*(const ALeft: TQuantity; const ARight: TImaginaryUnit): TComplexQuantity;
const
  i: TImaginaryUnit = ();
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * i;
end;

class operator TImaginaryUnit.*(const ALeft: TImaginaryUnit; const ARight: TQuantity): TComplexQuantity;
const
  i: TImaginaryUnit = ();
begin
  result.FDim := ARight.FDim;
  result.FValue := ARight.FValue * i;
end;

class operator TImaginaryUnit./(const ALeft: TQuantity; const ARight: TImaginaryUnit): TComplexQuantity;
const
  i: TImaginaryUnit = ();
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / i;
end;

class operator TImaginaryUnit./(const ALeft: TImaginaryUnit; const ARight: TQuantity): TComplexQuantity;
const
  i: TImaginaryUnit = ();
begin
  result.FDim := -ARight.FDim;
  result.FValue := i / ARight.FValue;
end;
{$ENDIF}

// TRMatrix

procedure TRMatrix.Put(ARow, ACol: longint; AValue: double);
begin
  fm[ARow, ACol] := AValue;
end;

function TRMatrix.Get(ARow, ACol: longint): double;
begin
  result := fm[ARow, ACol];
end;

function TRMatrix.IsNull: boolean;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      if not SameValueEx(fm[i, j], 0) then Exit(False);
    end;
  result := True;
end;

function TRMatrix.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TRMatrix.RowReduction: TRMatrix;
var
  ratio: double;
  var i, j, k, maxRow: longint;
begin
  result := Self;
  // Step 1: Forward elimination (Gaussian elimination)
  for i := 1 to TSpace.N do
  begin
    // Find the row with the largest absolute value in the current column (Partial Pivoting)
    maxRow := i;
    for j := i + 1 to TSpace.N do
      if Abs(result[j ,i]) > Abs(result[maxRow, i]) then maxRow := j;

    // Swap the current row with the row having the largest pivot
    if maxRow <> i then
      result.Swap(maxRow, i);

    if not SameValueEx(result[i, i], 0) then
    begin
      // Normalize the pivot row (Make the pivot element 1)
      for j := i + 1 to TSpace.N do
        result[i, j] := result[i, j] / result[i, i];
      result[i, i] := 1;
      // Eliminate elements below the pivot (Create upper triangular form)
      for j := i + 1 to TSpace.N do
        if not SameValueEx(result[j, i], 0) then
        begin
          // Factor to eliminate the element
          ratio := result[j, i];

          for k := i + 1 to TSpace.N do
          begin
            result[j, k] := result[j, k] - ratio*result[i, k]
          end;
          // Explicitly set to zero for numerical stability
          result[j , i] := 0;
        end;
    end;
  end;

  // Step 2: Back-substitution (Convert to reduced row echelon form)
  for i := TSpace.N downto 1 do
    if not SameValueEx(result[i, i], 0) then
    begin
      // Eliminate elements above the pivot
      for j := i - 1 downto 1 do
      begin
        // Factor to eliminate the element
        ratio := result[j, i];

        for k := i to TSpace.N do
          result[j, k] := result[j, k] - ratio * result[i, k];
        // Explicitly set to zero
        result[j, i] := 0;
      end;
    end;
end;

procedure TRMatrix.Swap(ARow1, ARow2: longint);
var
  i: longint;
  r: array[1..TSpace.N] of double;
begin
  for i := 1 to TSpace.N do r[i]           := Self[ARow1, i];
  for i := 1 to TSpace.N do Self[ARow1, i] := Self[ARow2, i];
  for i := 1 to TSpace.N do Self[ARow2, i] := r[i];
end;

function TRMatrix.Trace: double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + fm[i, i];
end;

function TRMatrix.Transpose: TRMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := fm[j, i];
    end;
end;

class operator TRMatrix.<>(const ALeft, ARight: TRMatrix): boolean;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      if ALeft[i, j] <> ARight[i, j] then Exit(True);
    end;

  result := False;
end;

class operator TRMatrix.=(const ALeft, ARight: TRMatrix): boolean;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      if ALeft[i, j] <> ARight[i, j] then Exit(False);
    end;

  result := True;
end;

class operator TRMatrix.+(const ALeft, ARight: TRMatrix): TRMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] + ARight[i, j];
    end;
end;

class operator TRMatrix.-(const ALeft, ARight: TRMatrix): TRMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] - ARight[i, j];
    end;
end;

class operator TRMatrix.*(const ALeft, ARight: TRMatrix): TRMatrix;
var
  i, j, k: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := 0;
      for k := 1 to TSpace.N do
        result[i, j] := result[i, j] + ALeft[i, k] * ARight[k, j];
    end;
end;

class operator TRMatrix.*(const ALeft: double; const ARight: TRMatrix): TRMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft * ARight[i, j];
    end;
end;

class operator TRMatrix.*(const ALeft: TRMatrix; const ARight: double): TRMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] * ARight;
    end;
end;

class operator TRMatrix./(const ALeft: TRMatrix; const ARight: double): TRMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] / ARight;
    end;
end;

// TCMatrix

procedure TCMatrix.Put(ARow, ACol: longint; AValue: TComplex);
begin
  fm[ARow, ACol] := AValue;
end;

function TCMatrix.Get(ARow, ACol: longint): TComplex;
begin
  result := fm[ARow, ACol];
end;

function TCMatrix.IsNull: boolean;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      if not SameValueEx(fm[i, j], 0) then Exit(False);
    end;
  result := True;
end;

function TCMatrix.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TCMatrix.RowReduction: TCMatrix;
var
  ratio: TComplex;
  var i, j, k, maxRow: longint;
begin
  result := Self;
  // Step 1: Forward elimination (Gaussian elimination)
  for i := 1 to TSpace.N do
  begin
    // Find the row with the largest absolute value in the current column (Partial Pivoting)
    maxRow := i;
    for j := i + 1 to TSpace.N do
      if Abs(result[j ,i]) > Abs(result[maxRow, i]) then maxRow := j;

    // Swap the current row with the row having the largest pivot
    if maxRow <> i then
      result.Swap(maxRow, i);

    if result[i, i].IsNotNull then
    begin
      // Normalize the pivot row (Make the pivot element 1)
      for j := i + 1 to TSpace.N do
        result[i, j] := result[i, j] / result[i, i];
      result[i, i] := 1;
      // Eliminate elements below the pivot (Create upper triangular form)
      for j := i + 1 to TSpace.N do
        if result[j, i].IsNotNull then
        begin
          // Factor to eliminate the element
          ratio := result[j, i];

          for k := i + 1 to TSpace.N do
          begin
            result[j, k] := result[j, k] - ratio*result[i, k]
          end;
          // Explicitly set to zero for numerical stability
          result[j , i] := 0;
        end;
    end;
  end;

  // Step 2: Back-substitution (Convert to reduced row echelon form)
  for i := TSpace.N downto 1 do
    if result[i, i].IsNotNull then
    begin
      // Eliminate elements above the pivot
      for j := i - 1 downto 1 do
      begin
        // Factor to eliminate the element
        ratio := result[j, i];

        for k := i to TSpace.N do
          result[j, k] := result[j, k] - ratio * result[i, k];
        // Explicitly set to zero
        result[j, i] := 0;
      end;
    end;
end;

procedure TCMatrix.Swap(ARow1, ARow2: longint);
var
  i: longint;
  r: array[1..TSpace.N] of TComplex;
begin
  for i := 1 to TSpace.N do r[i]           := Self[ARow1, i];
  for i := 1 to TSpace.N do Self[ARow1, i] := Self[ARow2, i];
  for i := 1 to TSpace.N do Self[ARow2, i] := r[i];
end;

function TCMatrix.Trace: TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + fm[i, i];
end;

function TCMatrix.Transpose: TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := fm[j, i];
    end;
end;

class operator TCMatrix.:=(const AMatrix: TRMatrix): TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := AMatrix[j, i];
    end;
end;

class operator TCMatrix.<>(const ALeft, ARight: TCMatrix): boolean;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      if ALeft[i, j] <> ARight[i, j] then Exit(True);
    end;

  result := False;
end;

class operator TCMatrix.=(const ALeft, ARight: TCMatrix): boolean;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      if ALeft[i, j] <> ARight[i, j] then Exit(False);
    end;

  result := True;
end;

class operator TCMatrix.+(const ALeft, ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] + ARight[i, j];
    end;
end;

class operator TCMatrix.-(const ALeft, ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] - ARight[i, j];
    end;
end;

class operator TCMatrix.*(const ALeft, ARight: TCMatrix): TCMatrix;
var
  i, j, k: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := 0;
      for k := 1 to TSpace.N do
        result[i, j] := result[i, j] + ALeft[i, k] * ARight[k, j];
    end;
end;

class operator TCMatrix.*(const ALeft: TComplex; const ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft * ARight[i, j];
    end;
end;

class operator TCMatrix.*(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] * ARight;
    end;
end;

class operator TCMatrix./(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] / ARight;
    end;
end;

// TRMatrixQuantity

{$IFNDEF ADIMOFF}
procedure TRMatrixQuantity.Put(ARow, ACol: longint; AQuantity: TQuantity);
begin
  Check(FDim, AQuantity.FDim);
  FValue[ARow, ACol] := AQuantity.FValue;
end;

function TRMatrixQuantity.Get(ARow, ACol: longint): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue[ARow, ACol];
end;

class operator TRMatrixQuantity.:=(const AMatrix: TRMatrix): TRMatrixQuantity;
var
  i, j: longint;
begin
  result.FDim := ScalarUnit.FDim;
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
      result.FValue[i, j] := AMatrix[i, j];
end;

class operator TRMatrixQuantity.<>(const ALeft, ARight: TRMatrixQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TRMatrixQuantity.=(const ALeft, ARight: TRMatrixQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TRMatrixQuantity.+(const ALeft, ARight: TRMatrixQuantity): TRMatrixQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TRMatrixQuantity.-(const ALeft, ARight: TRMatrixQuantity): TRMatrixQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TRMatrixQuantity.*(const ALeft, ARight: TRMatrixQuantity): TRMatrixQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRMatrixQuantity.*(const ALeft: TQuantity; const ARight: TRMatrixQuantity): TRMatrixQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRMatrixQuantity.*(const ALeft: TRMatrixQuantity; const ARight: TQuantity): TRMatrixQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRMatrixQuantity./(const ALeft: TRMatrixQuantity; const ARight: TQuantity): TRMatrixQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

// TCMatrixQuantity

{$IFNDEF ADIMOFF}
procedure TCMatrixQuantity.Put(ARow, ACol: longint; AQuantity: TComplexQuantity);
begin
  Check(FDim, AQuantity.FDim);
  FValue[ARow, ACol] := AQuantity.FValue;
end;

function TCMatrixQuantity.Get(ARow, ACol: longint): TComplexQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue[ARow, ACol];
end;

class operator TCMatrixQuantity.:=(const AMatrix: TCMatrix): TCMatrixQuantity;
var
  i, j: longint;
begin
  result.FDim := ScalarUnit.FDim;
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
      result.FValue[i, j] := AMatrix[i, j];
end;

class operator TCMatrixQuantity.<>(const ALeft, ARight: TCMatrixQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCMatrixQuantity.=(const ALeft, ARight: TCMatrixQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCMatrixQuantity.+(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCMatrixQuantity.-(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCMatrixQuantity.*(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCMatrixQuantity.*(const ALeft: TComplexQuantity; const ARight: TCMatrixQuantity): TCMatrixQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCMatrixQuantity.*(const ALeft: TCMatrixQuantity; const ARight: TComplexQuantity): TCMatrixQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCMatrixQuantity./(const ALeft: TCMatrixQuantity; const ARight: TComplexQuantity): TCMatrixQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

// TRVector

procedure TRVector.Put(ARow: longint; AValue: double);
begin
  fm[ARow] := AValue;
end;

function TRVector.Get(ARow: longint): double;
begin
  result := fm[ARow];
end;

function TRVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
  begin
    if not SameValueEx(fm[i], 0) then Exit(False);
  end;
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
  for i := 1 to TSpace.N do
    result[i] := fm[i] / n;
end;

function TRVector.Reciprocal: TRVector;
var
  i: longint;
  sn: double;
begin
  sn := SquaredNorm;
  for i := 1 to Tspace.N do
    result[i] := fm[i] / sn;
end;

function TRVector.SquaredNorm: double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + sqr(fm[i]);
end;

class operator TRVector.<>(const ALeft, ARight: TRVector): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(True);
  result := False;
end;

class operator TRVector.=(const ALeft, ARight: TRVector): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(False);
  result := True;
end;

class operator TRVector.+(const ASelf: TRVector): TRVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ASelf[i];
end;

class operator TRVector.+(const ALeft, ARight: TRVector): TRVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] + ARight[i];
end;

class operator TRVector.-(const ASelf: TRVector): TRVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := -ASelf[i];
end;

class operator TRVector.-(const ALeft, ARight: TRVector): TRVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] - ARight[i];
end;

class operator TRVector.*(const ALeft, ARight: TRVector): double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + ALeft[i] * ARight[i];
end;

class operator TRVector.*(const ALeft: double; const ARight: TRVector): TRVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft * ARight[i];
end;

class operator TRVector.*(const ALeft: TRVector; const ARight: double): TRVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] * ARight;
end;

class operator TRVector.*(const ALeft: TRVector; const ARight: TRMatrix): TRVector;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
  begin
    result[i] := 0;
    for j := 1 to TSpace.N do
    begin
      result[i] := result[i] + ALeft[j] * ARight[j, i];
    end;
  end;
end;

class operator TRVector.*(const ALeft: TRMatrix; const ARight: TRVector): TRVector;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
  begin
    result[i] := 0;
    for j := 1 to TSpace.N do
    begin
      result[i] := result[i] + ALeft[i, j] * ARight[j];
    end;
  end;
end;

class operator TRVector./(const ALeft: TRVector; const ARight: double): TRVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] / ARight;
end;

class operator TRVector./(const ALeft: double; const ARight: TRVector): TRVector;
var
  i: longint;
  AReciprocal: TRVector;
begin
  AReciprocal := ARight.Reciprocal;
  for i := 1 to TSpace.N do
    result[i] := ALeft * AReciprocal[i];
end;

// TCVector

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
  for i := 1 to TSpace.N do
  begin
    if not SameValueEx(fm[i], 0) then Exit(False);
  end;
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
  for i := 1 to TSpace.N do
    result[i] := fm[i] / n;
end;

function TCVector.Reciprocal: TCVector;
var
  i: longint;
  sn: double;
begin
  sn := SquaredNorm;
  for i := 1 to Tspace.N do
    result[i] := fm[i] / sn;
end;

function TCVector.SquaredNorm: double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + fm[i].SquaredNorm;
end;

class operator TCVector.:=(const ASelf: TRVector): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ASelf[i];
end;

class operator TCVector.<>(const ALeft, ARight: TCVector): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(True);
  result := False;
end;

class operator TCVector.=(const ALeft, ARight: TCVector): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(False);
  result := True;
end;

class operator TCVector.+(const ASelf: TCVector): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ASelf[i];
end;

class operator TCVector.+(const ALeft, ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] + ARight[i];
end;

class operator TCVector.-(const ASelf: TCVector): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := -ASelf[i];
end;

class operator TCVector.-(const ALeft, ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] - ARight[i];
end;

class operator TCVector.*(const ALeft, ARight: TCVector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + ALeft[i] * ARight[i];
end;

class operator TCVector.*(const ALeft: double; const ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft * ARight[i];
end;

class operator TCVector.*(const ALeft: TCVector; const ARight: double): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] * ARight;
end;

class operator TCVector.*(const ALeft: TComplex; const ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft * ARight[i];
end;

class operator TCVector.*(const ALeft: TCVector; const ARight: TComplex): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] * ARight;
end;

class operator TCVector.*(const ALeft: TCVector; const ARight: TCMatrix): TCVector;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
  begin
    result[i] := 0;
    for j := 1 to TSpace.N do
    begin
      result[i] := result[i] + ALeft[j] * ARight[j, i];
    end;
  end;
end;

class operator TCVector.*(const ALeft: TCMatrix; const ARight: TCVector): TCVector;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
  begin
    result[i] := 0;
    for j := 1 to TSpace.N do
    begin
      result[i] := result[i] + ALeft[i, j] * ARight[j];
    end;
  end;
end;

class operator TCVector./(const ALeft: TCVector; const ARight: double): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] / ARight;
end;

class operator TCVector./(const ALeft: double; const ARight: TCVector): TCVector;
var
  i: longint;
  AReciprocal: TCVector;
begin
  AReciprocal := ARight.Reciprocal;
  for i := 1 to TSpace.N do
    result[i] := ALeft * AReciprocal[i];
end;

class operator TCVector./(const ALeft: TCVector; const ARight: TComplex): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] / ARight;
end;

class operator TCVector./(const ALeft: TComplex; const ARight: TCVector): TCVector;
var
  i: longint;
  AReciprocal: TCVector;
begin
  AReciprocal := ARight.Reciprocal;
  for i := 1 to TSpace.N do
    result[i] := ALeft * AReciprocal[i];
end;

// TRVecQuantity

{$IFNDEF ADIMOFF}
procedure TRVecQuantity.Put(ARow: longint; const AQuantity: TQuantity);
begin
  Check(FDim, AQuantity.FDim);
  FValue[ARow] := AQuantity.FValue;
end;

function TRVecQuantity.Get(ARow: longint): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue[ARow];
end;

function TRVecQuantity.Normalize: TRVecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue / FValue.Norm;
end;

class operator TRVecQuantity.<>(const ALeft, ARight: TRVecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim );
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TRVecQuantity.=(const ALeft, ARight: TRVecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim );
  result := ALeft.FValue = ARight.FValue;
end;

class operator TRVecQuantity.+(const AValue: TRVecQuantity): TRVecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TRVecQuantity.+(const ALeft, ARight: TRVecQuantity): TRVecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TRVecQuantity.-(const AValue: TRVecQuantity): TRVecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
end;

class operator TRVecQuantity.-(const ALeft, ARight: TRVecQuantity): TRVecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TRVecQuantity.*(const ALeft: TRMatrixQuantity; const ARight: TRVecQuantity): TRVecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRVecQuantity.*(const ALeft, ARight: TRVecQuantity): TQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRVecQuantity.*(const ALeft: TQuantity; const ARight: TRVecQuantity): TRVecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRVecQuantity.*(const ALeft: TRVecQuantity; const ARight: TQuantity): TRVecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRVecQuantity./(const ALeft: TQuantity; const ARight: TRVecQuantity): TRVecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TRVecQuantity./(const ALeft: TRVecQuantity; const ARight: TQuantity): TRVecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

// TCVecQuantity

{$IFNDEF ADIMOFF}
function TCVecQuantity.Get(ARow: longint): TComplexQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue[ARow];
end;

procedure TCVecQuantity.Put(ARow: longint; const AQuantity: TComplexQuantity);
begin
  Check(FDim, AQuantity.FDim);
  FValue[ARow] := AQuantity.FValue;
end;

function TCVecQuantity.Normalize: TCVecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue / FValue.Norm;
end;

class operator TCVecQuantity.:=(const AValue: TCVector): TCVecQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;

class operator TCVecQuantity.<>(const ALeft, ARight: TCVecQuantity): boolean;
begin
  if ALeft.FDim <> ARight.FDim then Exit(True);
  if ALeft.FValue <> ARight.FValue then Exit(True);
  result := False;
end;

class operator TCVecQuantity.=(const ALeft, ARight: TCVecQuantity): boolean;
begin
  if ALeft.FDim <> ARight.FDim then Exit(False);
  if ALeft.FValue <> ARight.FValue then Exit(False);
  result := True;
end;

class operator TCVecQuantity.+(const AValue: TCVecQuantity): TCVecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TCVecQuantity.+(const ALeft, ARight: TCVecQuantity): TCVecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCVecQuantity.-(const AValue: TCVecQuantity): TCVecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
end;

class operator TCVecQuantity.-(const ALeft, ARight: TCVecQuantity): TCVecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft, ARight: TCVecQuantity): TComplexQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TCVecQuantity; const ARight: TCMatrixQuantity): TCVecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TCMatrixQuantity; const ARight: TCVecQuantity): TCVecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TCVector; const ARight: TCVecQuantity): TComplexQuantity;
begin
  result.FDim := CheckMul(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft * ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TQuantity; const ARight: TCVecQuantity): TCVecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TCVecQuantity; const ARight: TQuantity): TCVecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCVecQuantity./(const ALeft: TQuantity; const ARight: TCVecQuantity): TCVecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCVecQuantity./(const ALeft: TCVecQuantity; const ARight: TQuantity): TCVecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

// TR2MatrixHelper

function TR2MatrixHelper.Determinant: double;
begin
  result := fm[1,1]*fm[2,2] - fm[1,2]*fm[2,1];
end;

function TR2MatrixHelper.Reciprocal(const ADeterminant: double): TR2Matrix;
begin
  result[1,1] :=  fm[2,2]/ADeterminant;
  result[1,2] := -fm[1,2]/ADeterminant;
  result[2,1] := -fm[2,1]/ADeterminant;
  result[2,2] :=  fm[1,1]/ADeterminant;
end;

function TR2MatrixHelper.Transpose: TR2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
    begin
      result[i,j] := fm[j,i];
    end;
end;

function TR2MatrixHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm[1,1].ToString, fm[1,2].ToString,
    fm[2,1].ToString, fm[2,2].ToString]);
end;

function TR2MatrixHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm[1,1].ToString(ffGeneral, APrecision, ADigits),
    fm[1,2].ToString(ffGeneral, APrecision, ADigits),

    fm[2,1].ToString(ffGeneral, APrecision, ADigits),
    fm[2,2].ToString(ffGeneral, APrecision, ADigits)]);
end;

// TR3MatrixHelper

function TR3MatrixHelper.Determinant: double;
begin
  result :=  fm[1,1]*(fm[2,2]*fm[3,3]-fm[2,3]*fm[3,2])
            +fm[1,2]*(fm[2,3]*fm[3,1]-fm[2,1]*fm[3,3])
            +fm[1,3]*(fm[2,1]*fm[3,2]-fm[2,2]*fm[3,1]);
end;

function TR3MatrixHelper.Reciprocal(const ADeterminant: double): TR3Matrix;
begin
  result.fm[1,1] :=  (fm[2,2]*fm[3,3] -fm[2,3]*fm[3,2]) / ADeterminant;
  result.fm[1,2] := -(fm[1,2]*fm[3,3] -fm[1,3]*fm[3,2]) / ADeterminant;
  result.fm[1,3] :=  (fm[1,2]*fm[2,3] -fm[1,3]*fm[2,2]) / ADeterminant;
  result.fm[2,1] := -(fm[2,1]*fm[3,3] -fm[2,3]*fm[3,1]) / ADeterminant;
  result.fm[2,2] :=  (fm[1,1]*fm[3,3] -fm[1,3]*fm[3,1]) / ADeterminant;
  result.fm[2,3] := -(fm[1,1]*fm[2,3] -fm[1,3]*fm[2,1]) / ADeterminant;
  result.fm[3,1] :=  (fm[2,1]*fm[3,2] -fm[2,2]*fm[3,1]) / ADeterminant;
  result.fm[3,2] := -(fm[1,1]*fm[3,2] -fm[1,2]*fm[3,1]) / ADeterminant;
  result.fm[3,3] :=  (fm[1,1]*fm[2,2] -fm[1,2]*fm[2,1]) / ADeterminant;
end;

function TR3MatrixHelper.Transpose: TR3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
    begin
      result[i,j] := fm[j,i];
    end;
end;

function TR3MatrixHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString, fm[1,2].ToString, fm[1,3].ToString,
    fm[2,1].ToString, fm[2,2].ToString, fm[2,3].ToString,
    fm[3,1].ToString, fm[3,2].ToString, fm[3,3].ToString]);
end;

function TR3MatrixHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString(ffGeneral, APrecision, ADigits),
    fm[1,2].ToString(ffGeneral, APrecision, ADigits),
    fm[1,3].ToString(ffGeneral, APrecision, ADigits),

    fm[2,1].ToString(ffGeneral, APrecision, ADigits),
    fm[2,2].ToString(ffGeneral, APrecision, ADigits),
    fm[2,3].ToString(ffGeneral, APrecision, ADigits),

    fm[3,1].ToString(ffGeneral, APrecision, ADigits),
    fm[3,2].ToString(ffGeneral, APrecision, ADigits),
    fm[3,3].ToString(ffGeneral, APrecision, ADigits)]);
end;

// TR4MatrixHelper

function TR4MatrixHelper.Determinant: double;
begin
  result := (fm[1,1]*fm[2,2]-fm[1,2]*fm[2,1])*(fm[3,3]*fm[4,4]-fm[3,4]*fm[4,3]) -
            (fm[1,1]*fm[2,3]-fm[1,3]*fm[2,1])*(fm[3,2]*fm[4,4]-fm[3,4]*fm[4,2]) +
            (fm[1,1]*fm[2,4]-fm[1,4]*fm[2,1])*(fm[3,2]*fm[4,3]-fm[3,3]*fm[4,2]) +
            (fm[1,2]*fm[2,3]-fm[1,3]*fm[2,2])*(fm[3,1]*fm[4,4]-fm[3,4]*fm[4,1]) -
            (fm[1,2]*fm[2,4]-fm[1,4]*fm[2,2])*(fm[3,1]*fm[4,3]-fm[3,3]*fm[4,1]) +
            (fm[1,3]*fm[2,4]-fm[1,4]*fm[2,3])*(fm[3,1]*fm[4,2]-fm[3,2]*fm[4,1]) ;
end;

function TR4MatrixHelper.Reciprocal(const ADeterminant: double): TR4Matrix;
begin
  result[1,1]:= (fm[2,2]*(fm[3,3]*fm[4,4]-fm[3,4]*fm[4,3])+
                 fm[2,3]*(fm[3,4]*fm[4,2]-fm[3,2]*fm[4,4])+
                 fm[2,4]*(fm[3,2]*fm[4,3]-fm[3,3]*fm[4,2]))/Adeterminant;
  result[1,2]:= (fm[3,2]*(fm[1,3]*fm[4,4]-fm[1,4]*fm[4,3])+
                 fm[3,3]*(fm[1,4]*fm[4,2]-fm[1,2]*fm[4,4])+
                 fm[3,4]*(fm[1,2]*fm[4,3]-fm[1,3]*fm[4,2]))/Adeterminant;
  result[1,3]:= (fm[4,2]*(fm[1,3]*fm[2,4]-fm[1,4]*fm[2,3])+
                 fm[4,3]*(fm[1,4]*fm[2,2]-fm[1,2]*fm[2,4])+
                 fm[4,4]*(fm[1,2]*fm[2,3]-fm[1,3]*fm[2,2]))/Adeterminant;
  result[1,4]:= (fm[1,2]*(fm[2,4]*fm[3,3]-fm[2,3]*fm[3,4])+
                 fm[1,3]*(fm[2,2]*fm[3,4]-fm[2,4]*fm[3,2])+
                 fm[1,4]*(fm[2,3]*fm[3,2]-fm[2,2]*fm[3,3]))/Adeterminant;
  result[2,1]:= (fm[2,3]*(fm[3,1]*fm[4,4]-fm[3,4]*fm[4,1])+
                 fm[2,4]*(fm[3,3]*fm[4,1]-fm[3,1]*fm[4,3])+
                 fm[2,1]*(fm[3,4]*fm[4,3]-fm[3,3]*fm[4,4]))/Adeterminant;
  result[2,2]:= (fm[3,3]*(fm[1,1]*fm[4,4]-fm[1,4]*fm[4,1])+
                 fm[3,4]*(fm[1,3]*fm[4,1]-fm[1,1]*fm[4,3])+
                 fm[3,1]*(fm[1,4]*fm[4,3]-fm[1,3]*fm[4,4]))/Adeterminant;
  result[2,3]:= (fm[4,3]*(fm[1,1]*fm[2,4]-fm[1,4]*fm[2,1])+
                 fm[4,4]*(fm[1,3]*fm[2,1]-fm[1,1]*fm[2,3])+
                 fm[4,1]*(fm[1,4]*fm[2,3]-fm[1,3]*fm[2,4]))/Adeterminant;
  result[2,4]:= (fm[1,3]*(fm[2,4]*fm[3,1]-fm[2,1]*fm[3,4])+
                 fm[1,4]*(fm[2,1]*fm[3,3]-fm[2,3]*fm[3,1])+
                 fm[1,1]*(fm[2,3]*fm[3,4]-fm[2,4]*fm[3,3]))/Adeterminant;
  result[3,1]:= (fm[2,4]*(fm[3,1]*fm[4,2]-fm[3,2]*fm[4,1])+
                 fm[2,1]*(fm[3,2]*fm[4,4]-fm[3,4]*fm[4,2])+
                 fm[2,2]*(fm[3,4]*fm[4,1]-fm[3,1]*fm[4,4]))/Adeterminant;
  result[3,2]:= (fm[3,4]*(fm[1,1]*fm[4,2]-fm[1,2]*fm[4,1])+
                 fm[3,1]*(fm[1,2]*fm[4,4]-fm[1,4]*fm[4,2])+
                 fm[3,2]*(fm[1,4]*fm[4,1]-fm[1,1]*fm[4,4]))/Adeterminant;
  result[3,3]:= (fm[4,4]*(fm[1,1]*fm[2,2]-fm[1,2]*fm[2,1])+
                 fm[4,1]*(fm[1,2]*fm[2,4]-fm[1,4]*fm[2,2])+
                 fm[4,2]*(fm[1,4]*fm[2,1]-fm[1,1]*fm[2,4]))/Adeterminant;
  result[3,4]:= (fm[1,4]*(fm[2,2]*fm[3,1]-fm[2,1]*fm[3,2])+
                 fm[1,1]*(fm[2,4]*fm[3,2]-fm[2,2]*fm[3,4])+
                 fm[1,2]*(fm[2,1]*fm[3,4]-fm[2,4]*fm[3,1]))/Adeterminant;
  result[4,1]:= (fm[2,1]*(fm[3,3]*fm[4,2]-fm[3,2]*fm[4,3])+
                 fm[2,2]*(fm[3,1]*fm[4,3]-fm[3,3]*fm[4,1])+
                 fm[2,3]*(fm[3,2]*fm[4,1]-fm[3,1]*fm[4,2]))/Adeterminant;
  result[4,2]:= (fm[3,1]*(fm[1,3]*fm[4,2]-fm[1,2]*fm[4,3])+
                 fm[3,2]*(fm[1,1]*fm[4,3]-fm[1,3]*fm[4,1])+
                 fm[3,3]*(fm[1,2]*fm[4,1]-fm[1,1]*fm[4,2]))/Adeterminant;
  result[4,3]:= (fm[4,1]*(fm[1,3]*fm[2,2]-fm[1,2]*fm[2,3])+
                 fm[4,2]*(fm[1,1]*fm[2,3]-fm[1,3]*fm[2,1])+
                 fm[4,3]*(fm[1,2]*fm[2,1]-fm[1,1]*fm[2,2]))/Adeterminant;
  result[4,4]:= (fm[1,1]*(fm[2,2]*fm[3,3]-fm[2,3]*fm[3,2])+
                 fm[1,2]*(fm[2,3]*fm[3,1]-fm[2,1]*fm[3,3])+
                 fm[1,3]*(fm[2,1]*fm[3,2]-fm[2,2]*fm[3,1]))/Adeterminant;
end;

function TR4MatrixHelper.Transpose: TR4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      result[i,j] := fm[j,i];
    end;
end;

function TR4MatrixHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString, fm[1,2].ToString, fm[1,3].ToString, fm[1,4].ToString,
    fm[2,1].ToString, fm[2,2].ToString, fm[2,3].ToString, fm[2,4].ToString,
    fm[3,1].ToString, fm[3,2].ToString, fm[3,3].ToString, fm[3,4].ToString,
    fm[4,1].ToString, fm[4,2].ToString, fm[4,3].ToString, fm[4,4].ToString]);
end;

function TR4MatrixHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString(ffGeneral, APrecision, ADigits),
    fm[1,2].ToString(ffGeneral, APrecision, ADigits),
    fm[1,3].ToString(ffGeneral, APrecision, ADigits),
    fm[1,4].ToString(ffGeneral, APrecision, ADigits),

    fm[2,1].ToString(ffGeneral, APrecision, ADigits),
    fm[2,2].ToString(ffGeneral, APrecision, ADigits),
    fm[2,3].ToString(ffGeneral, APrecision, ADigits),
    fm[2,4].ToString(ffGeneral, APrecision, ADigits),

    fm[3,1].ToString(ffGeneral, APrecision, ADigits),
    fm[3,2].ToString(ffGeneral, APrecision, ADigits),
    fm[3,3].ToString(ffGeneral, APrecision, ADigits),
    fm[3,4].ToString(ffGeneral, APrecision, ADigits),

    fm[4,1].ToString(ffGeneral, APrecision, ADigits),
    fm[4,2].ToString(ffGeneral, APrecision, ADigits),
    fm[4,3].ToString(ffGeneral, APrecision, ADigits),
    fm[4,4].ToString(ffGeneral, APrecision, ADigits)]);
end;

// TC2MatrixHelper

function TC2MatrixHelper.Diagonalize(const AEigenValues: TC2ArrayOfComplex): TC2Matrix;
begin
  result[1,1] := AEigenValues[1];
  result[1,2] := 0;
  result[2,1] := 0;
  result[2,2] := AEigenValues[2];
end;

function TC2MatrixHelper.Conjugate: TC2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
    begin
      result[i,j] := fm[i,j].Conjugate;
    end;
end;

function TC2MatrixHelper.Determinant: TComplex;
begin
  result := fm[1,1]*fm[2,2] - fm[1,2]*fm[2,1];
end;

function TC2MatrixHelper.Reciprocal(const ADeterminant: TComplex): TC2Matrix;
begin
  result[1,1] :=  fm[2,2]/ADeterminant;
  result[1,2] := -fm[1,2]/ADeterminant;
  result[2,1] := -fm[2,1]/ADeterminant;
  result[2,2] :=  fm[1,1]/ADeterminant;
end;

function TC2MatrixHelper.EigenValues: TC2ArrayOfComplex;
var
  detA, TrA, TrA2: TComplex;
begin
  detA := Determinant;
  TrA  := fm[1,1] + fm[2,2];
  TrA2 := SquarePower(TrA);

  result[1] := 0.5*(TrA+SquareRoot(TrA2-4*detA)[1]);
  result[2] := 0.5*(TrA+SquareRoot(TrA2-4*detA)[2]);
end;

function TC2MatrixHelper.Eigenvectors(const AEigenValues: TC2ArrayOfComplex): TC2ArrayOfVector;
var
  A: TC2Matrix;
  i, j, Multiplicity: longint;
begin
  for i := Low(result) to High(result) do
  begin
    A := (Self - AEigenvalues[i] * C2IdentityMatrix).RowReduction;

    Multiplicity := 1;
    // Calculate algebraic multiplicity of eigenvalues
    for j := (i - 1) downto Low(AEigenvalues) do
      if SameValueEx(AEigenvalues[j], AEigenvalues[i]) then
        Inc(Multiplicity);

    // Assign a value to free parameter, ensuring only one assignment
    for j := Low(AEigenvalues) to High(AEigenvalues) do
    begin
      result[i].fm[j]:= 0;
      if A[j, j].IsNull then
      begin
        if Multiplicity = 1 then
          result[i].fm[j]:= 1;

        Dec(Multiplicity);
      end;
    end;

    // Solve linear system
    if A[1,1].IsNotNull then
    begin
      result[i].fm[1] := -(A[1,2]*result[i].fm[2])/A[1,1];
    end;
  end;
end;

function TC2MatrixHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm[1,1].ToString, fm[1,2].ToString,
    fm[2,1].ToString, fm[2,2].ToString]);
end;

function TC2MatrixHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm[1,1].ToString(APrecision, ADigits), fm[1,2].ToString(APrecision, ADigits),
    fm[2,1].ToString(APrecision, ADigits), fm[2,2].ToString(APrecision, ADigits)]);
end;

function TC2MatrixHelper.Transpose: TC2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
    begin
      result[i,j] := fm[j,i];
    end;
end;

function TC2MatrixHelper.TransposeConjugate: TC2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
    begin
      result[i,j] := fm[j,i].Conjugate;
    end;
end;

// TC3MatrixHelper

function TC3MatrixHelper.Diagonalize(const AEigenValues: TC3ArrayOfComplex): TC3Matrix;
begin
  result[1,1] := AEigenValues[1];
  result[1,2] := 0;
  result[1,3] := 0;

  result[2,1] := 0;
  result[2,2] := AEigenValues[2];
  result[2,3] := 0;

  result[3,1] := 0;
  result[3,2] := 0;
  result[3,3] := AEigenValues[3];
end;

function TC3MatrixHelper.Conjugate: TC3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
    begin
      result[i,j] := fm[i,j].Conjugate;
    end;
end;

function TC3MatrixHelper.Determinant: TComplex;
begin
  result :=  fm[1,1]*(fm[2,2]*fm[3,3]-fm[2,3]*fm[3,2])
            +fm[1,2]*(fm[2,3]*fm[3,1]-fm[2,1]*fm[3,3])
            +fm[1,3]*(fm[2,1]*fm[3,2]-fm[2,2]*fm[3,1]);
end;

function TC3MatrixHelper.Eigenvalues: TC3ArrayOfComplex;
var
  C1, C2, C3: TComplex;
  t1, t2, t3: TComplex;
begin
  t1 := Trace;
  t2 := (Self*Self).Trace;
  t3 := (Self*Self*Self).Trace;

  C1 := -t1;
  C2 := -(C1*t1+t2)/2;
  C3 := -(C2*t1+C1*t2+t3)/3;

  result := SolveEquation(C1, C2, C3);
end;

function TC3MatrixHelper.Eigenvectors(const AEigenvalues: TC3ArrayOfComplex): TC3ArrayOfVector;
var
  A: TC3Matrix;
  i, j, Multiplicity: longint;
begin
  for i := Low(AEigenvalues) to High(AEigenvalues) do
  begin
    A := (Self - AEigenvalues[i] * C3IdentityMatrix).RowReduction;

    Multiplicity := 1;
    // Calculate algebraic multiplicity of eigenvalues
    for j := (i - 1) downto Low(AEigenvalues) do
      if SameValueEx(AEigenvalues[j], AEigenvalues[i]) then
        Inc(Multiplicity);

    // Assign a value to free parameter, ensuring only one assignment
    for j := Low(AEigenvalues) to High(AEigenvalues) do
    begin
      result[i].fm[j]:= 0;
      if A[j, j].IsNull then
      begin
        if Multiplicity = 1 then
          result[i].fm[j]:= 1;

        Dec(Multiplicity);
      end;
    end;

    // Solve linear system
    if A[2,2].IsNotNull then
      result[i].fm[2] := -(A[2,3] * result[i].fm[3]) / A[2,2];

    if A[1,1].IsNotNull then
    begin
      result[i].fm[1] := -(A[1,2] * result[i].fm[2] + A[1,3] * result[i].fm[3]) / A[1,1];
    end else
      if A[1,2].IsNotNull then
      begin
        result[i].fm[2] := -(A[1,3] * result[i].fm[3]) / A[1,2];
      end;
  end;
end;

function TC3MatrixHelper.Reciprocal(const ADeterminant: TComplex): TC3Matrix;
begin
  result.fm[1,1] :=  (fm[2,2]*fm[3,3] -fm[2,3]*fm[3,2]) / ADeterminant;
  result.fm[1,2] := -(fm[1,2]*fm[3,3] -fm[1,3]*fm[3,2]) / ADeterminant;
  result.fm[1,3] :=  (fm[1,2]*fm[2,3] -fm[1,3]*fm[2,2]) / ADeterminant;
  result.fm[2,1] := -(fm[2,1]*fm[3,3] -fm[2,3]*fm[3,1]) / ADeterminant;
  result.fm[2,2] :=  (fm[1,1]*fm[3,3] -fm[1,3]*fm[3,1]) / ADeterminant;
  result.fm[2,3] := -(fm[1,1]*fm[2,3] -fm[1,3]*fm[2,1]) / ADeterminant;
  result.fm[3,1] :=  (fm[2,1]*fm[3,2] -fm[2,2]*fm[3,1]) / ADeterminant;
  result.fm[3,2] := -(fm[1,1]*fm[3,2] -fm[1,2]*fm[3,1]) / ADeterminant;
  result.fm[3,3] :=  (fm[1,1]*fm[2,2] -fm[1,2]*fm[2,1]) / ADeterminant;
end;

function TC3MatrixHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString, fm[1,2].ToString, fm[1,3].ToString,
    fm[2,1].ToString, fm[2,2].ToString, fm[2,3].ToString,
    fm[3,1].ToString, fm[3,2].ToString, fm[3,3].ToString]);
end;

function TC3MatrixHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString(APrecision, ADigits), fm[1,2].ToString(APrecision, ADigits), fm[1,3].ToString(APrecision, ADigits),
    fm[2,1].ToString(APrecision, ADigits), fm[2,2].ToString(APrecision, ADigits), fm[2,3].ToString(APrecision, ADigits),
    fm[3,1].ToString(APrecision, ADigits), fm[3,2].ToString(APrecision, ADigits), fm[3,3].ToString(APrecision, ADigits)]);
end;

function TC3MatrixHelper.Transpose: TC3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
    begin
      result[i,j] := fm[j,i];
    end;
end;

function TC3MatrixHelper.TransposeConjugate: TC3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
    begin
      result[i,j] := fm[j,i].Conjugate;
    end;
end;

// TC4MatrixHelper

function TC4MatrixHelper.Diagonalize(const AEigenValues: TC4ArrayOfComplex): TC4Matrix;
begin
  result[1,1] := AEigenValues[1];
  result[1,2] := 0;
  result[1,3] := 0;
  result[1,4] := 0;

  result[2,1] := 0;
  result[2,2] := AEigenValues[2];
  result[2,3] := 0;
  result[2,4] := 0;

  result[3,1] := 0;
  result[3,2] := 0;
  result[3,3] := AEigenValues[3];
  result[3,4] := 0;

  result[4,1] := 0;
  result[4,2] := 0;
  result[4,3] := 0;
  result[4,4] := AEigenValues[4];
end;

function TC4MatrixHelper.Conjugate: TC4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      result[i,j] := fm[i,j].Conjugate;
    end;
end;

function TC4MatrixHelper.Determinant: TComplex;
begin
  result := (fm[1,1]*fm[2,2]-fm[1,2]*fm[2,1])*(fm[3,3]*fm[4,4]-fm[3,4]*fm[4,3]) -
            (fm[1,1]*fm[2,3]-fm[1,3]*fm[2,1])*(fm[3,2]*fm[4,4]-fm[3,4]*fm[4,2]) +
            (fm[1,1]*fm[2,4]-fm[1,4]*fm[2,1])*(fm[3,2]*fm[4,3]-fm[3,3]*fm[4,2]) +
            (fm[1,2]*fm[2,3]-fm[1,3]*fm[2,2])*(fm[3,1]*fm[4,4]-fm[3,4]*fm[4,1]) -
            (fm[1,2]*fm[2,4]-fm[1,4]*fm[2,2])*(fm[3,1]*fm[4,3]-fm[3,3]*fm[4,1]) +
            (fm[1,3]*fm[2,4]-fm[1,4]*fm[2,3])*(fm[3,1]*fm[4,2]-fm[3,2]*fm[4,1]) ;
end;

function TC4MatrixHelper.Eigenvalues: TC4ArrayOfComplex;
var
  C1, C2, C3, C4: TComplex;
  t1, t2, t3, t4: TComplex;
begin
  t1 := Trace;
  t2 := (Self*Self).Trace;
  t3 := (Self*Self*Self).Trace;
  t4 := (Self*Self*Self*Self).Trace;

  C1 := -(t1);
  C2 := -(C1*t1+t2)/2;
  C3 := -(C2*t1+C1*t2+t3)/3;
  C4 := -(C3*t1+C2*t2+C1*t3+t4)/4;

  result := SolveEquation(C1, C2, C3, C4);
end;

function TC4MatrixHelper.Eigenvectors(const AEigenvalues: TC4ArrayOfComplex): TC4ArrayOfVector;
var
  A: TC4Matrix;
  i, j, Multiplicity: longint;
begin
  for i := Low(AEigenvalues) to High(AEigenvalues) do
  begin
    A := (Self - AEigenvalues[i] * C4IdentityMatrix).RowReduction;

    Multiplicity := 1;
    // Calculate algebraic multiplicity of eigenvalues
    for j := (i - 1) downto Low(AEigenvalues) do
      if SameValueEx(AEigenvalues[j], AEigenvalues[i]) then
        Inc(Multiplicity);

    // Assign a value to free parameter, ensuring only one assignment
    for j := Low(AEigenvalues) to High(AEigenvalues) do
    begin
      result[i].fm[j]:= 0;
      if A[j, j].IsNull then
      begin
        if Multiplicity = 1 then
          result[i].fm[j]:= 1;

        Dec(Multiplicity);
      end;
    end;

    // Solve linear system
    if A[3,3].IsNotNull and A[3,4].IsNotNull then
      result[i].fm[3] := -(A[3,4] * result[i].fm[4]) / A[3,3];

    if A[2,2].IsNotNull then
    begin
      result[i].fm[2] := -(A[2,3] * result[i].fm[3] + A[2,4] * result[i].fm[4]) / A[2,2];
    end else
      if A[2,3].IsNotNull then
      begin
        result[i].fm[3] := -(A[2,4] * result[i].fm[4]) / A[2,3];
      end;

    if A[1,1].IsNotNull then
    begin
      result[i].fm[1] := -(A[1,2] * result[i].fm[2] + A[1,3] * result[i].fm[3] + A[1,4] * result[i].fm[4]) / A[1,1];
    end else
      if A[1,2].IsNotNull then
      begin
        result[i].fm[2] := -(A[1,3] * result[i].fm[3] + A[1,4] * result[i].fm[4]) / A[1,2];
      end else
        if A[1,3].IsNotNull then
        begin
          result[i].fm[3] := -(A[1,4] * result[i].fm[4]) / A[1,3];
        end;
  end;
end;

function TC4MatrixHelper.Reciprocal(const ADeterminant: TComplex): TC4Matrix;
begin
  result[1,1]:= (fm[2,2]*(fm[3,3]*fm[4,4]-fm[3,4]*fm[4,3])+
                 fm[2,3]*(fm[3,4]*fm[4,2]-fm[3,2]*fm[4,4])+
                 fm[2,4]*(fm[3,2]*fm[4,3]-fm[3,3]*fm[4,2]))/Adeterminant;
  result[1,2]:= (fm[3,2]*(fm[1,3]*fm[4,4]-fm[1,4]*fm[4,3])+
                 fm[3,3]*(fm[1,4]*fm[4,2]-fm[1,2]*fm[4,4])+
                 fm[3,4]*(fm[1,2]*fm[4,3]-fm[1,3]*fm[4,2]))/Adeterminant;
  result[1,3]:= (fm[4,2]*(fm[1,3]*fm[2,4]-fm[1,4]*fm[2,3])+
                 fm[4,3]*(fm[1,4]*fm[2,2]-fm[1,2]*fm[2,4])+
                 fm[4,4]*(fm[1,2]*fm[2,3]-fm[1,3]*fm[2,2]))/Adeterminant;
  result[1,4]:= (fm[1,2]*(fm[2,4]*fm[3,3]-fm[2,3]*fm[3,4])+
                 fm[1,3]*(fm[2,2]*fm[3,4]-fm[2,4]*fm[3,2])+
                 fm[1,4]*(fm[2,3]*fm[3,2]-fm[2,2]*fm[3,3]))/Adeterminant;
  result[2,1]:= (fm[2,3]*(fm[3,1]*fm[4,4]-fm[3,4]*fm[4,1])+
                 fm[2,4]*(fm[3,3]*fm[4,1]-fm[3,1]*fm[4,3])+
                 fm[2,1]*(fm[3,4]*fm[4,3]-fm[3,3]*fm[4,4]))/Adeterminant;
  result[2,2]:= (fm[3,3]*(fm[1,1]*fm[4,4]-fm[1,4]*fm[4,1])+
                 fm[3,4]*(fm[1,3]*fm[4,1]-fm[1,1]*fm[4,3])+
                 fm[3,1]*(fm[1,4]*fm[4,3]-fm[1,3]*fm[4,4]))/Adeterminant;
  result[2,3]:= (fm[4,3]*(fm[1,1]*fm[2,4]-fm[1,4]*fm[2,1])+
                 fm[4,4]*(fm[1,3]*fm[2,1]-fm[1,1]*fm[2,3])+
                 fm[4,1]*(fm[1,4]*fm[2,3]-fm[1,3]*fm[2,4]))/Adeterminant;
  result[2,4]:= (fm[1,3]*(fm[2,4]*fm[3,1]-fm[2,1]*fm[3,4])+
                 fm[1,4]*(fm[2,1]*fm[3,3]-fm[2,3]*fm[3,1])+
                 fm[1,1]*(fm[2,3]*fm[3,4]-fm[2,4]*fm[3,3]))/Adeterminant;
  result[3,1]:= (fm[2,4]*(fm[3,1]*fm[4,2]-fm[3,2]*fm[4,1])+
                 fm[2,1]*(fm[3,2]*fm[4,4]-fm[3,4]*fm[4,2])+
                 fm[2,2]*(fm[3,4]*fm[4,1]-fm[3,1]*fm[4,4]))/Adeterminant;
  result[3,2]:= (fm[3,4]*(fm[1,1]*fm[4,2]-fm[1,2]*fm[4,1])+
                 fm[3,1]*(fm[1,2]*fm[4,4]-fm[1,4]*fm[4,2])+
                 fm[3,2]*(fm[1,4]*fm[4,1]-fm[1,1]*fm[4,4]))/Adeterminant;
  result[3,3]:= (fm[4,4]*(fm[1,1]*fm[2,2]-fm[1,2]*fm[2,1])+
                 fm[4,1]*(fm[1,2]*fm[2,4]-fm[1,4]*fm[2,2])+
                 fm[4,2]*(fm[1,4]*fm[2,1]-fm[1,1]*fm[2,4]))/Adeterminant;
  result[3,4]:= (fm[1,4]*(fm[2,2]*fm[3,1]-fm[2,1]*fm[3,2])+
                 fm[1,1]*(fm[2,4]*fm[3,2]-fm[2,2]*fm[3,4])+
                 fm[1,2]*(fm[2,1]*fm[3,4]-fm[2,4]*fm[3,1]))/Adeterminant;
  result[4,1]:= (fm[2,1]*(fm[3,3]*fm[4,2]-fm[3,2]*fm[4,3])+
                 fm[2,2]*(fm[3,1]*fm[4,3]-fm[3,3]*fm[4,1])+
                 fm[2,3]*(fm[3,2]*fm[4,1]-fm[3,1]*fm[4,2]))/Adeterminant;
  result[4,2]:= (fm[3,1]*(fm[1,3]*fm[4,2]-fm[1,2]*fm[4,3])+
                 fm[3,2]*(fm[1,1]*fm[4,3]-fm[1,3]*fm[4,1])+
                 fm[3,3]*(fm[1,2]*fm[4,1]-fm[1,1]*fm[4,2]))/Adeterminant;
  result[4,3]:= (fm[4,1]*(fm[1,3]*fm[2,2]-fm[1,2]*fm[2,3])+
                 fm[4,2]*(fm[1,1]*fm[2,3]-fm[1,3]*fm[2,1])+
                 fm[4,3]*(fm[1,2]*fm[2,1]-fm[1,1]*fm[2,2]))/Adeterminant;
  result[4,4]:= (fm[1,1]*(fm[2,2]*fm[3,3]-fm[2,3]*fm[3,2])+
                 fm[1,2]*(fm[2,3]*fm[3,1]-fm[2,1]*fm[3,3])+
                 fm[1,3]*(fm[2,1]*fm[3,2]-fm[2,2]*fm[3,1]))/Adeterminant;
end;

function TC4MatrixHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString, fm[1,2].ToString, fm[1,3].ToString, fm[1,4].ToString,
    fm[2,1].ToString, fm[2,2].ToString, fm[2,3].ToString, fm[2,4].ToString,
    fm[3,1].ToString, fm[3,2].ToString, fm[3,3].ToString, fm[3,4].ToString,
    fm[4,1].ToString, fm[4,2].ToString, fm[4,3].ToString, fm[4,4].ToString]);
end;

function TC4MatrixHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString(APrecision, ADigits), fm[1,2].ToString(APrecision, ADigits), fm[1,3].ToString, fm[1,4].ToString(APrecision, ADigits),
    fm[2,1].ToString(APrecision, ADigits), fm[2,2].ToString(APrecision, ADigits), fm[2,3].ToString, fm[2,4].ToString(APrecision, ADigits),
    fm[3,1].ToString(APrecision, ADigits), fm[3,2].ToString(APrecision, ADigits), fm[3,3].ToString, fm[3,4].ToString(APrecision, ADigits),
    fm[4,1].ToString(APrecision, ADigits), fm[4,2].ToString(APrecision, ADigits), fm[4,3].ToString, fm[4,4].ToString(APrecision, ADigits)]);
end;

function TC4MatrixHelper.Transpose: TC4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      result[i,j] := fm[j,i];
    end;
end;

function TC4MatrixHelper.TransposeConjugate: TC4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      result[i,j] := fm[j,i].Conjugate;
    end;
end;

// TC2VectorHelper

function TC2VectorHelper.Dot(const AVector: TC2Vector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to 2 do
    result := result + fm[i] * AVector[i];
end;

function TC2VectorHelper.Conjugate: TC2Vector;
var
  i: longint;
begin
  for i := 1 to 2 do
    result[i] := fm[i].Conjugate;
end;

function TC2VectorHelper.ToString: string;
begin
  result := Format('(%s, %s)', [
    fm[1].ToString,
    fm[2].ToString]);
end;

function TC2VectorHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s)', [
    fm[1].ToString(APrecision, ADigits),
    fm[2].ToString(APrecision, ADigits)]);
end;

// TC3VectorHelper

function TC3VectorHelper.Conjugate: TC3Vector;
var
  i: longint;
begin
  for i := 1 to 3 do
    result[i] := fm[i].Conjugate;
end;

function TC3VectorHelper.Dot(const AVector: TC3Vector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to 3 do
    result := result + fm[i] * AVector[i];
end;

function TC3VectorHelper.ToString: string;
begin
  result := Format('(%s, %s, %s)', [
    fm[1].ToString,
    fm[2].ToString,
    fm[3].ToString]);
end;

function TC3VectorHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s)', [
    fm[1].ToString(APrecision, ADigits),
    fm[2].ToString(APrecision, ADigits),
    fm[3].ToString(APrecision, ADigits)]);
end;

// TC4VectorHelper

function TC4VectorHelper.Conjugate: TC4Vector;
var
  i: longint;
begin
  for i := 1 to 4 do
    result[i] := fm[i].Conjugate;
end;

function TC4VectorHelper.Dot(const AVector: TC4Vector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to 4 do
    result := result + fm[i] * AVector[i];
end;

function TC4VectorHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm[1].ToString,
    fm[2].ToString,
    fm[3].ToString,
    fm[4].ToString]);
end;

function TC4VectorHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm[1].ToString(APrecision, ADigits),
    fm[2].ToString(APrecision, ADigits),
    fm[3].ToString(APrecision, ADigits),
    fm[4].ToString(APrecision, ADigits)]);
end;

// TR2VectorHelper

function TR2VectorHelper.Dot(const AVector: TR2Vector): double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to 2 do
    result := result + fm[i] * AVector[i];
end;

function TR2VectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm[1], 0.0) then result := result + Fmt(fm[1]) + 'e1 ';
  if not SameValueEx(fm[2], 0.0) then result := result + Fmt(fm[2]) + 'e2 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

function TR2VectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm[1], 0) then result := result + Fmt(fm[1],  APrecision, ADigits) + 'e1 ';
  if not SameValueEx(fm[2], 0) then result := result + Fmt(fm[2],  APrecision, ADigits) + 'e2 ';

    i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

// TR3VectorHelper

function TR3VectorHelper.Dot(const AVector: TR3Vector): double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to 3 do
    result := result + fm[i] * AVector[i];
end;

function TR3VectorHelper.Cross(const AVector: TR3Vector): TR3Vector;
begin
  result[1] :=  fm[2]*AVector[3] - fm[3]*AVector[2];
  result[2] :=  fm[1]*AVector[3] - fm[3]*AVector[1];
  result[3] :=  fm[1]*AVector[2] - fm[2]*AVector[1];
end;

function TR3VectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm[1], 0.0) then result := result + Fmt(fm[1]) + 'e1 ';
  if not SameValueEx(fm[2], 0.0) then result := result + Fmt(fm[2]) + 'e2 ';
  if not SameValueEx(fm[3], 0.0) then result := result + Fmt(fm[3]) + 'e3 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

function TR3VectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm[1], 0) then result := result + Fmt(fm[1],  APrecision, ADigits) + 'e1 ';
  if not SameValueEx(fm[2], 0) then result := result + Fmt(fm[2],  APrecision, ADigits) + 'e2 ';
  if not SameValueEx(fm[3], 0) then result := result + Fmt(fm[3],  APrecision, ADigits) + 'e3 ';

    i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

// TR4VectorHelper

function TR4VectorHelper.Dot(const AVector: TR4Vector): double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to 4 do
    result := result + fm[i] * AVector[i];
end;

function TR4VectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm[1], 0.0) then result := result + Fmt(fm[1]) + 'e1 ';
  if not SameValueEx(fm[2], 0.0) then result := result + Fmt(fm[2]) + 'e2 ';
  if not SameValueEx(fm[3], 0.0) then result := result + Fmt(fm[3]) + 'e3 ';
  if not SameValueEx(fm[4], 0.0) then result := result + Fmt(fm[4]) + 'e4 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

function TR4VectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm[1], 0) then result := result + Fmt(fm[1],  APrecision, ADigits) + 'e1 ';
  if not SameValueEx(fm[2], 0) then result := result + Fmt(fm[2],  APrecision, ADigits) + 'e2 ';
  if not SameValueEx(fm[3], 0) then result := result + Fmt(fm[3],  APrecision, ADigits) + 'e3 ';
  if not SameValueEx(fm[4], 0) then result := result + Fmt(fm[4],  APrecision, ADigits) + 'e4 ';

    i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

// TCL3Multivector

class operator TCL3Multivector.:=(const AValue: double): TCL3Multivector;
begin
  result.fm0   := AValue;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

class operator TCL3Multivector.:=(const AValue: TCL3Multivector): double;
begin
  result := AValue;
end;

class operator TCL3Multivector.<>(const ALeft, ARight: TCL3Multivector): boolean;
begin
  result := (ALeft.fm0   <> ARight.fm0  ) or
            (ALeft.fm1   <> ARight.fm1  ) or
            (ALeft.fm2   <> ARight.fm2  ) or
            (ALeft.fm3   <> ARight.fm3  ) or
            (ALeft.fm12  <> ARight.fm12 ) or
            (ALeft.fm13  <> ARight.fm13 ) or
            (ALeft.fm23  <> ARight.fm23 ) or
            (ALeft.fm123 <> ARight.fm123);
end;

class operator TCL3Multivector.<>(const ALeft: TCL3Multivector; const ARight: double): boolean;
begin
  result := (ALeft.fm0   <> ARight) or
            (ALeft.fm1   <>    0.0) or
            (ALeft.fm2   <>    0.0) or
            (ALeft.fm3   <>    0.0) or
            (ALeft.fm12  <>    0.0) or
            (ALeft.fm13  <>    0.0) or
            (ALeft.fm23  <>    0.0) or
            (ALeft.fm123 <>    0.0);
end;

class operator TCL3Multivector.<>(const ALeft: double; const ARight: TCL3Multivector): boolean;
begin
  result := (ALeft <> ARight.fm0  ) or
            (0.0   <> ARight.fm1  ) or
            (0.0   <> ARight.fm2  ) or
            (0.0   <> ARight.fm3  ) or
            (0.0   <> ARight.fm12 ) or
            (0.0   <> ARight.fm13 ) or
            (0.0   <> ARight.fm23 ) or
            (0.0   <> ARight.fm123);
end;

class operator TCL3Multivector.=(const ALeft: TCL3Multivector; const ARight: double): boolean;
begin
  result := (ARight <> ALeft.fm0  ) or
            (0.0    <> ALeft.fm1  ) or
            (0.0    <> ALeft.fm2  ) or
            (0.0    <> ALeft.fm3  ) or
            (0.0    <> ALeft.fm12 ) or
            (0.0    <> ALeft.fm13 ) or
            (0.0    <> ALeft.fm23 ) or
            (0.0    <> ALeft.fm123);
end;

class operator TCL3Multivector.=(const ALeft: double; const ARight: TCL3Multivector): boolean;
begin
  result := (ALeft = ARight.fm0  ) or
            (0.0   = ARight.fm1  ) or
            (0.0   = ARight.fm2  ) or
            (0.0   = ARight.fm3  ) or
            (0.0   = ARight.fm12 ) or
            (0.0   = ARight.fm13 ) or
            (0.0   = ARight.fm23 ) or
            (0.0   = ARight.fm123);
end;

class operator TCL3Multivector.=(const ALeft, ARight: TCL3Multivector): boolean;
begin
  result := (ALeft.fm0   = ARight.fm0  ) or
            (ALeft.fm1   = ARight.fm1  ) or
            (ALeft.fm2   = ARight.fm2  ) or
            (ALeft.fm3   = ARight.fm3  ) or
            (ALeft.fm12  = ARight.fm12 ) or
            (ALeft.fm13  = ARight.fm13 ) or
            (ALeft.fm23  = ARight.fm23 ) or
            (ALeft.fm123 = ARight.fm123);
end;

class operator TCL3Multivector.+(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0 + ARight;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Multivector.+(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ARight.fm0 + ALeft;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Multivector.+(const ALeft, ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0   + ARight.fm0;
  result.fm1   := ALeft.fm1   + ARight.fm1;
  result.fm2   := ALeft.fm2   + ARight.fm2;
  result.fm3   := ALeft.fm3   + ARight.fm3;
  result.fm12  := ALeft.fm12  + ARight.fm12;
  result.fm13  := ALeft.fm13  + ARight.fm13;
  result.fm23  := ALeft.fm23  + ARight.fm23;
  result.fm123 := ALeft.fm123 + ARight.fm123;
end;

class operator TCL3Multivector.-(const ASelf: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := -ASelf.fm0;
  result.fm1   := -ASelf.fm1;
  result.fm2   := -ASelf.fm2;
  result.fm3   := -ASelf.fm3;
  result.fm12  := -ASelf.fm12;
  result.fm13  := -ASelf.fm13;
  result.fm23  := -ASelf.fm23;
  result.fm123 := -ASelf.fm123;
end;

class operator TCL3Multivector.-(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0 - ARight;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Multivector.-(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ALeft - ARight.fm0;
  result.fm1   :=       - ARight.fm1;
  result.fm2   :=       - ARight.fm2;
  result.fm3   :=       - ARight.fm3;
  result.fm12  :=       - ARight.fm12;
  result.fm13  :=       - ARight.fm13;
  result.fm23  :=       - ARight.fm23;
  result.fm123 :=       - ARight.fm123;
end;

class operator TCL3Multivector.-(const ALeft, ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0   - ARight.fm0;
  result.fm1   := ALeft.fm1   - ARight.fm1;
  result.fm2   := ALeft.fm2   - ARight.fm2;
  result.fm3   := ALeft.fm3   - ARight.fm3;
  result.fm12  := ALeft.fm12  - ARight.fm12;
  result.fm13  := ALeft.fm13  - ARight.fm13;
  result.fm23  := ALeft.fm23  - ARight.fm23;
  result.fm123 := ALeft.fm123 - ARight.fm123;
end;

class operator TCL3Multivector.*(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0   * ARight;
  result.fm1   := ALeft.fm1   * ARight;
  result.fm2   := ALeft.fm2   * ARight;
  result.fm3   := ALeft.fm3   * ARight;
  result.fm12  := ALeft.fm12  * ARight;
  result.fm13  := ALeft.fm13  * ARight;
  result.fm23  := ALeft.fm23  * ARight;
  result.fm123 := ALeft.fm123 * ARight;
end;

class operator TCL3Multivector.*(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ALeft * ARight.fm0;
  result.fm1   := ALeft * ARight.fm1;
  result.fm2   := ALeft * ARight.fm2;
  result.fm3   := ALeft * ARight.fm3;
  result.fm12  := ALeft * ARight.fm12;
  result.fm13  := ALeft * ARight.fm13;
  result.fm23  := ALeft * ARight.fm23;
  result.fm123 := ALeft * ARight.fm123;
end;

class operator TCL3Multivector.*(const ALeft, ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0 :=     ALeft.fm0   * ARight.fm0
                  + ALeft.fm1   * ARight.fm1
                  + ALeft.fm2   * ARight.fm2
                  + ALeft.fm3   * ARight.fm3
                  - ALeft.fm12  * ARight.fm12
                  - ALeft.fm13  * ARight.fm13
                  - ALeft.fm23  * ARight.fm23
                  - ALeft.fm123 * ARight.fm123;

  result.fm1 :=     ALeft.fm0   * ARight.fm1
                  + ALeft.fm1   * ARight.fm0
                  - ALeft.fm2   * ARight.fm12
                  - ALeft.fm3   * ARight.fm13
                  + ALeft.fm12  * ARight.fm2
                  + ALeft.fm13  * ARight.fm3
                  - ALeft.fm23  * ARight.fm123
                  - ALeft.fm123 * ARight.fm23;

  result.fm2 :=     ALeft.fm0   * ARight.fm2
                  + ALeft.fm1   * ARight.fm12
                  + ALeft.fm2   * ARight.fm0
                  - ALeft.fm3   * ARight.fm23
                  - ALeft.fm12  * ARight.fm1
                  + ALeft.fm13  * ARight.fm123
                  + ALeft.fm23  * ARight.fm3
                  + ALeft.fm123 * ARight.fm13;

  result.fm3 :=     ALeft.fm0   * ARight.fm3
                  + ALeft.fm1   * ARight.fm13
                  + ALeft.fm2   * ARight.fm23
                  + ALeft.fm3   * ARight.fm0
                  - ALeft.fm12  * ARight.fm123
                  - ALeft.fm13  * ARight.fm1
                  - ALeft.fm23  * ARight.fm2
                  - ALeft.fm123 * ARight.fm12;

  result.fm12 :=    ALeft.fm0   * ARight.fm12
                  + ALeft.fm1   * ARight.fm2
                  - ALeft.fm2   * ARight.fm1
                  + ALeft.fm3   * ARight.fm123
                  + ALeft.fm12  * ARight.fm0
                  - ALeft.fm13  * ARight.fm23
                  + ALeft.fm23  * ARight.fm13
                  + ALeft.fm123 * ARight.fm3;

  result.fm23 :=    ALeft.fm0   * ARight.fm23
                  + ALeft.fm1   * ARight.fm123
                  + ALeft.fm2   * ARight.fm3
                  - ALeft.fm3   * ARight.fm2
                  - ALeft.fm12  * ARight.fm13
                  + ALeft.fm13  * ARight.fm12
                  + ALeft.fm23  * ARight.fm0
                  + ALeft.fm123 * ARight.fm1;

  result.fm13  :=   ALeft.fm0   * ARight.fm13
                  + ALeft.fm1   * ARight.fm3
                  - ALeft.fm2   * ARight.fm123
                  - ALeft.fm3   * ARight.fm1
                  + ALeft.fm12  * ARight.fm23
                  + ALeft.fm13  * ARight.fm0
                  - ALeft.fm23  * ARight.fm12
                  - ALeft.fm123 * ARight.fm2;

  result.fm123 := + ALeft.fm0   * ARight.fm123
                  + ALeft.fm1   * ARight.fm23
                  - ALeft.fm2   * ARight.fm13
                  + ALeft.fm3   * ARight.fm12
                  + ALeft.fm12  * ARight.fm3
                  - ALeft.fm13  * ARight.fm2
                  + ALeft.fm23  * ARight.fm1
                  + ALeft.fm123 * ARight.fm0;
end;

class operator TCL3Multivector./(const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0   / ARight;
  result.fm1   := ALeft.fm1   / ARight;
  result.fm2   := ALeft.fm2   / ARight;
  result.fm3   := ALeft.fm3   / ARight;
  result.fm12  := ALeft.fm12  / ARight;
  result.fm13  := ALeft.fm13  / ARight;
  result.fm23  := ALeft.fm23  / ARight;
  result.fm123 := ALeft.fm123 / ARight;
end;

class operator TCL3Multivector./(const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Multivector./(const ALeft, ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

// TCL3Trivector

class operator TCL3Trivector.:=(const AValue: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := AValue.fm123;
end;

class operator TCL3Trivector.:=(const AValue: TCL3Multivector): TCL3Trivector;
begin
  result.fm123 := AValue.fm123;
end;

class operator TCL3Trivector.<>(const ALeft, ARight: TCL3Trivector): boolean;
begin
  result := ALeft.fm123 <> ARight.fm123;
end;

class operator TCL3Trivector.<>(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): boolean;
begin
  result := (ALeft.fm0   <>          0.0) or
            (ALeft.fm1   <>          0.0) or
            (ALeft.fm2   <>          0.0) or
            (ALeft.fm3   <>          0.0) or
            (ALeft.fm12  <>          0.0) or
            (ALeft.fm13  <>          0.0) or
            (ALeft.fm23  <>          0.0) or
            (ALeft.fm123 <> ARight.fm123);
end;

class operator TCL3Trivector.<>(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): boolean;
begin
  result := (0.0         <> ARight.fm0  ) or
            (0.0         <> ARight.fm1  ) or
            (0.0         <> ARight.fm2  ) or
            (0.0         <> ARight.fm3  ) or
            (0.0         <> ARight.fm12 ) or
            (0.0         <> ARight.fm13 ) or
            (0.0         <> ARight.fm23 ) or
            (ALeft.fm123 <> ARight.fm123);
end;

class operator TCL3Trivector.=(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): boolean;
begin
  result := (ALeft.fm0   =          0.0) or
            (ALeft.fm1   =          0.0) or
            (ALeft.fm2   =          0.0) or
            (ALeft.fm3   =          0.0) or
            (ALeft.fm12  =          0.0) or
            (ALeft.fm13  =          0.0) or
            (ALeft.fm23  =          0.0) or
            (ALeft.fm123 = ARight.fm123);
end;

class operator TCL3Trivector.=(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): boolean;
begin
  result := (0.0         = ARight.fm0  ) or
            (0.0         = ARight.fm1  ) or
            (0.0         = ARight.fm2  ) or
            (0.0         = ARight.fm3  ) or
            (0.0         = ARight.fm12 ) or
            (0.0         = ARight.fm13 ) or
            (0.0         = ARight.fm23 ) or
            (ALeft.fm123 = ARight.fm123);
end;

class operator TCL3Trivector.=(const ALeft, ARight: TCL3Trivector): boolean;
begin
  result := ALeft.fm123 = ARight.fm123;
end;

class operator TCL3Trivector.+(const ALeft, ARight: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := ALeft.fm123 + ARight.fm123;
end;

class operator TCL3Trivector.+(const ALeft: TCL3Trivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ARight;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Trivector.+(const ALeft: double; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := ALeft;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Trivector.+(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123 + ARight.fm123;
end;

class operator TCL3Trivector.+(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ARight.fm0;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := ARight.fm123 + ALeft.fm123;
end;

class operator TCL3Trivector.-(const ASelf: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := -ASelf.fm123;
end;

class operator TCL3Trivector.-(const ALeft, ARight: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := ALeft.fm123 - ARight.fm123;
end;

class operator TCL3Trivector.-(const ALeft: TCL3Trivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := -ARight;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 :=  ALeft.fm123;
end;

class operator TCL3Trivector.-(const ALeft: double; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   :=  ALeft;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 := -ARight.fm123;
end;

class operator TCL3Trivector.-(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123 - ARight.fm123;
end;

class operator TCL3Trivector.-(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=             - ARight.fm0;
  result.fm1   :=             - ARight.fm1;
  result.fm2   :=             - ARight.fm2;
  result.fm3   :=             - ARight.fm3;
  result.fm12  :=             - ARight.fm12;
  result.fm13  :=             - ARight.fm13;
  result.fm23  :=             - ARight.fm23;
  result.fm123 := ALeft.fm123 - ARight.fm123;
end;

class operator TCL3Trivector.*(const ALeft: double; const ARight: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := ALeft * ARight.fm123;
end;

class operator TCL3Trivector.*(const ALeft: TCL3Trivector; const ARight: double): TCL3Trivector;
begin
  result.fm123 := ALeft.fm123 * ARight;
end;

class operator TCL3Trivector.*(const ALeft, ARight: TCL3Trivector): double;
begin
  result := -ALeft.fm123 * ARight.fm123;
end;

class operator TCL3Trivector.*(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := -ALeft.fm123 * ARight.fm123;
  result.fm1   := -ALeft.fm23  * ARight.fm123;
  result.fm2   :=  ALeft.fm13  * ARight.fm123;
  result.fm3   := -ALeft.fm12  * ARight.fm123;
  result.fm12  :=  ALeft.fm3   * ARight.fm123;
  result.fm13  := -ALeft.fm2   * ARight.fm123;
  result.fm23  :=  ALeft.fm1   * ARight.fm123;
  result.fm123 :=  ALeft.fm0   * ARight.fm123;
end;

class operator TCL3Trivector.*(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := -ALeft.fm123 * ARight.fm123;
  result.fm1   := -ALeft.fm123 * ARight.fm23;
  result.fm2   :=  ALeft.fm123 * ARight.fm13;
  result.fm3   := -ALeft.fm123 * ARight.fm12;
  result.fm12  :=  ALeft.fm123 * ARight.fm3;
  result.fm13  := -ALeft.fm123 * ARight.fm2;
  result.fm23  :=  ALeft.fm123 * ARight.fm1;
  result.fm123 :=  ALeft.fm123 * ARight.fm0;
end;

class operator TCL3Trivector./(const ALeft, ARight: TCL3Trivector): double;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Trivector./(const ALeft: TCL3Trivector; const ARight: double): TCL3Trivector;
begin
  result.fm123 := ALeft.fm123 / ARight;
end;

class operator TCL3Trivector./(const ALeft: double; const ARight: TCL3Trivector): TCL3Trivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Trivector./(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Trivector./(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

// TCL3Bivector

class operator TCL3Bivector.:=(const AValue: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := AValue.fm12;
  result.fm13  := AValue.fm13;
  result.fm23  := AValue.fm23;
  result.fm123 := 0.0;
end;

class operator TCL3Bivector.:=(const AValue: TCL3Multivector): TCL3Bivector;
begin
  result.fm12 := AValue.fm12;
  result.fm13 := AValue.fm13;
  result.fm23 := AValue.fm23;
end;

class operator TCL3Bivector.<>(const ALeft, ARight: TCL3Bivector): boolean;
begin
  result := (ALeft.fm12 <> ARight.fm12) or
            (ALeft.fm13 <> ARight.fm13) or
            (ALeft.fm23 <> ARight.fm23);
end;

class operator TCL3Bivector.<>(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): boolean;
begin
  result := (ALeft.fm0   <>         0.0) or
            (ALeft.fm1   <>         0.0) or
            (ALeft.fm2   <>         0.0) or
            (ALeft.fm3   <>         0.0) or
            (ALeft.fm12  <> ARight.fm12) or
            (ALeft.fm13  <> ARight.fm13) or
            (ALeft.fm23  <> ARight.fm23) or
            (ALeft.fm123 <>         0.0);
end;

class operator TCL3Bivector.<>(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): boolean;
begin
  result := (ARight.fm0   <>        0.0) or
            (ARight.fm1   <>        0.0) or
            (ARight.fm2   <>        0.0) or
            (ARight.fm3   <>        0.0) or
            (ARight.fm12  <> ALeft.fm12) or
            (ARight.fm13  <> ALeft.fm13) or
            (ARight.fm23  <> ALeft.fm23) or
            (ARight.fm123 <>        0.0);
end;

class operator TCL3Bivector.=(const ALeft, ARight: TCL3Bivector): boolean;
begin
  result := (ALeft.fm12 = ARight.fm12) or
            (ALeft.fm13 = ARight.fm13) or
            (ALeft.fm23 = ARight.fm23);
end;

class operator TCL3Bivector.=(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): boolean;
begin
  result := (ALeft.fm0   =         0.0) or
            (ALeft.fm1   =         0.0) or
            (ALeft.fm2   =         0.0) or
            (ALeft.fm3   =         0.0) or
            (ALeft.fm12  = ARight.fm12) or
            (ALeft.fm13  = ARight.fm13) or
            (ALeft.fm23  = ARight.fm23) or
            (ALeft.fm123 =         0.0);
end;

class operator TCL3Bivector.=(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): boolean;
begin
  result := (ARight.fm0   =        0.0) or
            (ARight.fm1   =        0.0) or
            (ARight.fm2   =        0.0) or
            (ARight.fm3   =        0.0) or
            (ARight.fm12  = ALeft.fm12) or
            (ARight.fm13  = ALeft.fm13) or
            (ARight.fm23  = ALeft.fm23) or
            (ARight.fm123 =        0.0);
end;

class operator TCL3Bivector.+(const ALeft, ARight: TCL3Bivector): TCL3Bivector;
begin
  result.fm12 := ALeft.fm12 + ARight.fm12;
  result.fm13 := ALeft.fm13 + ARight.fm13;
  result.fm23 := ALeft.fm23 + ARight.fm23;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Bivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ARight;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := 0.0;
end;

class operator TCL3Bivector.+(const ALeft: double; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := ALeft;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := 0.0;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ARight.fm0;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := ARight.fm12 + ALeft.fm12;
  result.fm13  := ARight.fm13 + ALeft.fm13;
  result.fm23  := ARight.fm23 + ALeft.fm23;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Bivector.+(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12 + ARight.fm12;
  result.fm13  := ALeft.fm13 + ARight.fm13;
  result.fm23  := ALeft.fm23 + ARight.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Bivector.-(const ASelf: TCL3Bivector): TCL3Bivector;
begin
  result.fm12 := -ASelf.fm12;
  result.fm13 := -ASelf.fm13;
  result.fm23 := -ASelf.fm23;
end;

class operator TCL3Bivector.-(const ALeft, ARight: TCL3Bivector): TCL3Bivector;
begin
  result.fm12  := ALeft.fm12 - ARight.fm12;
  result.fm13  := ALeft.fm13 - ARight.fm13;
  result.fm23  := ALeft.fm23 - ARight.fm23;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Bivector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := -ARight;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  ALeft.fm12;
  result.fm13  :=  ALeft.fm13;
  result.fm23  :=  ALeft.fm23;
  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.-(const ALeft: double; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  ALeft;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  := -ARight.fm12;
  result.fm13  := -ARight.fm13;
  result.fm23  := -ARight.fm23;
  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  ALeft.fm12;
  result.fm13  :=  ALeft.fm13;
  result.fm23  :=  ALeft.fm23;
  result.fm123 := -ARight.fm123;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  := -ARight.fm12;
  result.fm13  := -ARight.fm13;
  result.fm23  := -ARight.fm23;
  result.fm123 :=  ALeft.fm123;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=             - ARight.fm0;
  result.fm1   :=             - ARight.fm1;
  result.fm2   :=             - ARight.fm2;
  result.fm3   :=             - ARight.fm3;
  result.fm12  :=  ALeft.fm12 - ARight.fm12;
  result.fm13  :=  ALeft.fm13 - ARight.fm13;
  result.fm23  :=  ALeft.fm23 - ARight.fm23;
  result.fm123 :=             - ARight.fm123;
end;

class operator TCL3Bivector.-(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ALeft.fm12 - ARight.fm12;
  result.fm13  := ALeft.fm13 - ARight.fm13;
  result.fm23  := ALeft.fm23 - ARight.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Bivector.*(const ALeft: double; const ARight: TCL3Bivector): TCL3Bivector;
begin
  result.fm12 := ALeft * ARight.fm12;
  result.fm13 := ALeft * ARight.fm13;
  result.fm23 := ALeft * ARight.fm23;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Bivector; const ARight: double): TCL3Bivector;
begin
  result.fm12 := ARight * ALeft.fm12;
  result.fm13 := ARight * ALeft.fm13;
  result.fm23 := ARight * ALeft.fm23;
end;

class operator TCL3Bivector.*(const ALeft, ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := -ALeft.fm12 * ARight.fm12
                  -ALeft.fm13 * ARight.fm13
                  -ALeft.fm23 * ARight.fm23;

  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;

  result.fm12  := -ALeft.fm13 * ARight.fm23
                  +ALeft.fm23 * ARight.fm13;

  result.fm13  := +ALeft.fm12 * ARight.fm23
                  -ALeft.fm23 * ARight.fm12;

  result.fm23  := -ALeft.fm12 * ARight.fm13
                  +ALeft.fm13 * ARight.fm12;

  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0 :=   -ALeft.fm12 * ARight.fm12
                  -ALeft.fm13 * ARight.fm13
                  -ALeft.fm23 * ARight.fm23;

  result.fm1 :=    ALeft.fm12 * ARight.fm2
                  +ALeft.fm13 * ARight.fm3
                  -ALeft.fm23 * ARight.fm123;

  result.fm2 :=   -ALeft.fm12 * ARight.fm1
                  +ALeft.fm13 * ARight.fm123
                  +ALeft.fm23 * ARight.fm3;

  result.fm3 :=   -ALeft.fm12 * ARight.fm123
                  -ALeft.fm13 * ARight.fm1
                  -ALeft.fm23 * ARight.fm2;

  result.fm12 :=   ALeft.fm12 * ARight.fm0
                  -ALeft.fm13 * ARight.fm23
                  +ALeft.fm23 * ARight.fm13;

  result.fm23 :=  -ALeft.fm12 * ARight.fm13
                  +ALeft.fm13 * ARight.fm12
                  +ALeft.fm23 * ARight.fm0;

  result.fm13 :=  +ALeft.fm12 * ARight.fm23
                  +ALeft.fm13 * ARight.fm0
                  -ALeft.fm23 * ARight.fm12;

  result.fm123 :=  ALeft.fm12 * ARight.fm3
                  -ALeft.fm13 * ARight.fm2
                  +ALeft.fm23 * ARight.fm1;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   := -ALeft.fm23 * ARight.fm123;
  result.fm2   :=  ALeft.fm13 * ARight.fm123;
  result.fm3   := -ALeft.fm12 * ARight.fm123;
  result.fm12  :=  0.0;
  result.fm23  :=  0.0;
  result.fm13  :=  0.0;
  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   := -ARight.fm23 * ALeft.fm123;
  result.fm2   :=  ARight.fm13 * ALeft.fm123;
  result.fm3   := -ARight.fm12 * ALeft.fm123;
  result.fm12  :=  0.0;
  result.fm23  :=  0.0;
  result.fm13  :=  0.0;
  result.fm123 :=  0.0;
end;

class operator TCL3Bivector.*(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0 :=   -ALeft.fm12  * ARight.fm12
                  -ALeft.fm13  * ARight.fm13
                  -ALeft.fm23  * ARight.fm23;

  result.fm1 :=   -ALeft.fm2   * ARight.fm12
                  -ALeft.fm3   * ARight.fm13
                  -ALeft.fm123 * ARight.fm23;

  result.fm2 :=    ALeft.fm1   * ARight.fm12
                  -ALeft.fm3   * ARight.fm23
                  +ALeft.fm123 * ARight.fm13;

  result.fm3 :=    ALeft.fm1   * ARight.fm13
                  +ALeft.fm2   * ARight.fm23
                  -ALeft.fm123 * ARight.fm12;

  result.fm12 :=   ALeft.fm0   * ARight.fm12
                  -ALeft.fm13  * ARight.fm23
                  +ALeft.fm23  * ARight.fm13;

  result.fm23 :=   ALeft.fm0   * ARight.fm23
                  -ALeft.fm12  * ARight.fm13
                  +ALeft.fm13  * ARight.fm12;

  result.fm13 :=   ALeft.fm0   * ARight.fm13
                  +ALeft.fm12  * ARight.fm23
                  -ALeft.fm23  * ARight.fm12;

  result.fm123 :=  ALeft.fm1   * ARight.fm23
                  -ALeft.fm2   * ARight.fm13
                  +ALeft.fm3   * ARight.fm12;
end;

class operator TCL3Bivector./(const ALeft, ARight: TCL3Bivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Bivector; const ARight: double): TCL3Bivector;
begin
  result.fm12 := ALeft.fm12 / ARight;
  result.fm13 := ALeft.fm13 / ARight;
  result.fm23 := ALeft.fm23 / ARight;
end;

class operator TCL3Bivector./(const ALeft: double; const ARight: TCL3Bivector): TCL3Bivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Bivector./(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

// TCL3Vector

class operator TCL3Vector.:=(const AValue: TCL3Vector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := AValue.fm1;
  result.fm2   := AValue.fm2;
  result.fm3   := AValue.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

class operator TCL3Vector.:=(const AValue: TCL3Multivector): TCL3Vector;
begin
  result.fm1 := AValue.fm1;
  result.fm2 := AValue.fm2;
  result.fm3 := AValue.fm3;
end;

class operator TCL3Vector.<>(const ALeft, ARight: TCL3Vector): boolean;
begin
  result := (ALeft.fm1 <> ARight.fm1) or
            (ALeft.fm2 <> ARight.fm2) or
            (ALeft.fm3 <> ARight.fm3);
end;

class operator TCL3Vector.<>(const ALeft: TCL3Multivector; const ARight: TCL3Vector): boolean;
begin
  result := (ALeft.fm0   <>        0.0) or
            (ALeft.fm1   <> ARight.fm1) or
            (ALeft.fm2   <> ARight.fm2) or
            (ALeft.fm3   <> ARight.fm3) or
            (ALeft.fm12  <>        0.0) or
            (ALeft.fm13  <>        0.0) or
            (ALeft.fm23  <>        0.0) or
            (ALeft.fm123 <>        0.0);
end;

class operator TCL3Vector.<>(const ALeft: TCL3Vector; const ARight: TCL3Multivector): boolean;
begin
  result := (ARight.fm0   <>       0.0) or
            (ARight.fm1   <> ALeft.fm1) or
            (ARight.fm2   <> ALeft.fm2) or
            (ARight.fm3   <> ALeft.fm3) or
            (ARight.fm12  <>       0.0) or
            (ARight.fm13  <>       0.0) or
            (ARight.fm23  <>       0.0) or
            (ARight.fm123 <>       0.0);
end;

class operator TCL3Vector.=(const ALeft, ARight: TCL3Vector): boolean;
begin
  result := (ALeft.fm1 = ARight.fm1) or
            (ALeft.fm2 = ARight.fm2) or
            (ALeft.fm3 = ARight.fm3);
end;

class operator TCL3Vector.=(const ALeft: TCL3Vector; const ARight: TCL3Multivector): boolean;
begin
  result := (ARight.fm0   =       0.0) or
            (ARight.fm1   = ALeft.fm1) or
            (ARight.fm2   = ALeft.fm2) or
            (ARight.fm3   = ALeft.fm3) or
            (ARight.fm12  =       0.0) or
            (ARight.fm13  =       0.0) or
            (ARight.fm23  =       0.0) or
            (ARight.fm123 =       0.0);
end;

class operator TCL3Vector.=(const ALeft: TCL3Multivector; const ARight: TCL3Vector): boolean;
begin
  result := (ALeft.fm0   =        0.0) or
            (ALeft.fm1   = ARight.fm1) or
            (ALeft.fm2   = ARight.fm2) or
            (ALeft.fm3   = ARight.fm3) or
            (ALeft.fm12  =        0.0) or
            (ALeft.fm13  =        0.0) or
            (ALeft.fm23  =        0.0) or
            (ALeft.fm123 =        0.0);
end;

class operator TCL3Vector.+(const ALeft, ARight: TCL3Vector): TCL3Vector;
begin
  result.fm1 := ALeft.fm1 + ARight.fm1;
  result.fm2 := ALeft.fm2 + ARight.fm2;
  result.fm3 := ALeft.fm3 + ARight.fm3;
end;

class operator TCL3Vector.+(const ALeft: TCL3Vector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := ARight;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

class operator TCL3Vector.+(const ALeft: double; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   := ALeft;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

class operator TCL3Vector.+(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := 0.0;
end;

class operator TCL3Vector.+(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := 0.0;
end;

class operator TCL3Vector.+(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := ALeft.fm1;
  result.fm2   := ALeft.fm2;
  result.fm3   := ALeft.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Vector.+(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := ARight.fm1;
  result.fm2   := ARight.fm2;
  result.fm3   := ARight.fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Vector.+(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := ARight.fm0;
  result.fm1   := ARight.fm1 + ALeft.fm1;
  result.fm2   := ARight.fm2 + ALeft.fm2;
  result.fm3   := ARight.fm3 + ALeft.fm3;
  result.fm12  := ARight.fm12;
  result.fm13  := ARight.fm13;
  result.fm23  := ARight.fm23;
  result.fm123 := ARight.fm123;
end;

class operator TCL3Vector.+(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1 + ARight.fm1;
  result.fm2   := ALeft.fm2 + ARight.fm2;
  result.fm3   := ALeft.fm3 + ARight.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Vector.-(const ASelf: TCL3Vector): TCL3Vector;
begin
  result.fm1 := -ASelf.fm1;
  result.fm2 := -ASelf.fm2;
  result.fm3 := -ASelf.fm3;
end;

class operator TCL3Vector.-(const ALeft, ARight: TCL3Vector): TCL3Vector;
begin
  result.fm1 := ALeft.fm1 - ARight.fm1;
  result.fm2 := ALeft.fm2 - ARight.fm2;
  result.fm3 := ALeft.fm3 - ARight.fm3;
end;

class operator TCL3Vector.-(const ALeft: TCL3Vector; const ARight: double): TCL3Multivector;
begin
  result.fm0   := -ARight;
  result.fm1   :=  ALeft.fm1;
  result.fm2   :=  ALeft.fm2;
  result.fm3   :=  ALeft.fm3;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 :=  0.0;
end;

class operator TCL3Vector.-(const ALeft: double; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  ALeft;
  result.fm1   := -ARight.fm1;
  result.fm2   := -ARight.fm2;
  result.fm3   := -ARight.fm3;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 :=  0.0;
end;

class operator TCL3Vector.-(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  ALeft.fm1;
  result.fm2   :=  ALeft.fm2;
  result.fm3   :=  ALeft.fm3;
  result.fm12  := -ARight.fm12;
  result.fm13  := -ARight.fm13;
  result.fm23  := -ARight.fm23;
  result.fm123 :=  0.0;
end;

class operator TCL3Vector.-(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   := -ARight.fm1;
  result.fm2   := -ARight.fm2;
  result.fm3   := -ARight.fm3;
  result.fm12  :=  ALeft.fm12;
  result.fm13  :=  ALeft.fm13;
  result.fm23  :=  ALeft.fm23;
  result.fm123 :=  0.0;
end;

class operator TCL3Vector.-(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  ALeft.fm1;
  result.fm2   :=  ALeft.fm2;
  result.fm3   :=  ALeft.fm3;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 := -ARight.fm123;
end;

class operator TCL3Vector.-(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   := -ARight.fm1;
  result.fm2   := -ARight.fm2;
  result.fm3   := -ARight.fm3;
  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;
  result.fm123 :=  ALeft.fm123;
end;

class operator TCL3Vector.-(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=            - ARight.fm0;
  result.fm1   :=  ALeft.fm1 - ARight.fm1;
  result.fm2   :=  ALeft.fm2 - ARight.fm2;
  result.fm3   :=  ALeft.fm3 - ARight.fm3;
  result.fm12  :=            - ARight.fm12;
  result.fm13  :=            - ARight.fm13;
  result.fm23  :=            - ARight.fm23;
  result.fm123 :=            - ARight.fm123;
end;

class operator TCL3Vector.-(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   := ALeft.fm0;
  result.fm1   := ALeft.fm1 - ARight.fm1;
  result.fm2   := ALeft.fm2 - ARight.fm2;
  result.fm3   := ALeft.fm3 - ARight.fm3;
  result.fm12  := ALeft.fm12;
  result.fm13  := ALeft.fm13;
  result.fm23  := ALeft.fm23;
  result.fm123 := ALeft.fm123;
end;

class operator TCL3Vector.*(const ALeft: double; const ARight: TCL3Vector): TCL3Vector;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TCL3Vector.*(const ALeft: TCL3Vector; const ARight: double): TCL3Vector;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TCL3Vector.*(const ALeft, ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  ALeft.fm1 * ARight.fm1
                  +ALeft.fm2 * ARight.fm2
                  +ALeft.fm3 * ARight.fm3;

  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;

  result.fm12  :=  ALeft.fm1 * ARight.fm2
                  -ALeft.fm2 * ARight.fm1;

  result.fm13  :=  ALeft.fm1 * ARight.fm3
                  -ALeft.fm3 * ARight.fm1;

  result.fm23  :=  ALeft.fm2 * ARight.fm3
                  -ALeft.fm3 * ARight.fm2;

  result.fm123 :=  0.0;
end;

class operator TCL3Vector.*(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;

  result.fm1   := -ALeft.fm2 * ARight.fm12
                  -ALeft.fm3 * ARight.fm13;

  result.fm2   :=  ALeft.fm1 * ARight.fm12
                  -ALeft.fm3 * ARight.fm23;

  result.fm3   :=  ALeft.fm1 * ARight.fm13
                  +ALeft.fm2 * ARight.fm23;

  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;

  result.fm123 :=  ALeft.fm1 * ARight.fm23
                  -ALeft.fm2 * ARight.fm13
                  +ALeft.fm3 * ARight.fm12;
end;

class operator TCL3Vector.*(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  ALeft.fm12 * ARight.fm2
                  +ALeft.fm13 * ARight.fm3;

  result.fm2   := -ALeft.fm12 * ARight.fm1
                  +ALeft.fm23 * ARight.fm3;

  result.fm3   := -ALeft.fm13 * ARight.fm1
                  -ALeft.fm23 * ARight.fm2;

  result.fm12  :=  0.0;
  result.fm13  :=  0.0;
  result.fm23  :=  0.0;

  result.fm123 :=  ALeft.fm12 * ARight.fm3
                  -ALeft.fm13 * ARight.fm2
                  +ALeft.fm23 * ARight.fm1;
end;

class operator TCL3Vector.*(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Bivector;
begin
  result.fm12 :=  ALeft.fm3 * ARight.fm123;
  result.fm13 := -ALeft.fm2 * ARight.fm123;
  result.fm23 :=  ALeft.fm1 * ARight.fm123;
end;

class operator TCL3Vector.*(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Bivector;
begin
  result.fm12 :=  ALeft.fm123 * ARight.fm3;
  result.fm13 := -ALeft.fm123 * ARight.fm2;
  result.fm23 :=  ALeft.fm123 * ARight.fm1;
end;

class operator TCL3Vector.*(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  ALeft.fm1 * ARight.fm1
                  +ALeft.fm2 * ARight.fm2
                  +ALeft.fm3 * ARight.fm3;

  result.fm1   :=  ALeft.fm1 * ARight.fm0
                  -ALeft.fm2 * ARight.fm12
                  -ALeft.fm3 * ARight.fm13;

  result.fm2   :=  ALeft.fm1 * ARight.fm12
                  +ALeft.fm2 * ARight.fm0
                  -ALeft.fm3 * ARight.fm23;

  result.fm3   :=  ALeft.fm1 * ARight.fm13
                  +ALeft.fm2 * ARight.fm23
                  +ALeft.fm3 * ARight.fm0;

  result.fm12  :=  ALeft.fm1 * ARight.fm2
                  -ALeft.fm2 * ARight.fm1
                  +ALeft.fm3 * ARight.fm123;

  result.fm23  :=  ALeft.fm1 * ARight.fm123
                  +ALeft.fm2 * ARight.fm3
                  -ALeft.fm3 * ARight.fm2;

  result.fm13  :=  ALeft.fm1 * ARight.fm3
                  -ALeft.fm2 * ARight.fm123
                  -ALeft.fm3 * ARight.fm1;

  result.fm123 :=  ALeft.fm1 * ARight.fm23
                  -ALeft.fm2 * ARight.fm13
                  +ALeft.fm3 * ARight.fm12;
end;

class operator TCL3Vector.*(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  ALeft.fm1   * ARight.fm1
                  +ALeft.fm2   * ARight.fm2
                  +ALeft.fm3   * ARight.fm3;

  result.fm1   :=  ALeft.fm0   * ARight.fm1
                  +ALeft.fm12  * ARight.fm2
                  +ALeft.fm13  * ARight.fm3;

  result.fm2   :=  ALeft.fm0   * ARight.fm2
                  -ALeft.fm12  * ARight.fm1
                  +ALeft.fm23  * ARight.fm3;

  result.fm3   :=  ALeft.fm0   * ARight.fm3
                  -ALeft.fm13  * ARight.fm1
                  -ALeft.fm23  * ARight.fm2;

  result.fm12  :=  ALeft.fm1   * ARight.fm2
                  -ALeft.fm2   * ARight.fm1
                  +ALeft.fm123 * ARight.fm3;

  result.fm23  :=  ALeft.fm2   * ARight.fm3
                  -ALeft.fm3   * ARight.fm2
                  +ALeft.fm123 * ARight.fm1;

  result.fm13  :=  ALeft.fm1   * ARight.fm3
                  -ALeft.fm3   * ARight.fm1
                  -ALeft.fm123 * ARight.fm2;

  result.fm123 :=  ALeft.fm12  * ARight.fm3
                  -ALeft.fm13  * ARight.fm2
                  +ALeft.fm23  * ARight.fm1;
end;

class operator TCL3Vector./(const ALeft, ARight: TCL3Vector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Vector./ (const ALeft: TCL3Vector; const ARight: double): TCL3Vector;
begin
  result.fm1 := ALeft.fm1 / ARight;
  result.fm2 := ALeft.fm2 / ARight;
  result.fm3 := ALeft.fm3 / ARight;
end;

class operator TCL3Vector./(const ALeft: double; const ARight: TCL3Vector): TCL3Vector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Vector./(const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Vector./(const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Vector./(const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Bivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Vector./(const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Bivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Vector./(const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TCL3Vector./(const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;
begin
  result := ALeft * ARight.Reciprocal;
end;

// TCL3MultivectorHelper

function TCL3MultivectorHelper.Dual: TCL3Multivector;
begin
  result.fm0   := -fm123;
  result.fm1   := -fm23;
  result.fm2   :=  fm13;
  result.fm3   := -fm12;
  result.fm12  :=  fm3;
  result.fm13  := -fm2;
  result.fm23  :=  fm1;
  result.fm123 :=  fm0;
end;

function TCL3MultivectorHelper.Inverse: TCL3Multivector;
begin
  result.fm0   :=  fm0;
  result.fm1   := -fm1;
  result.fm2   := -fm2;
  result.fm3   := -fm3;
  result.fm12  :=  fm12;
  result.fm13  :=  fm13;
  result.fm23  :=  fm23;
  result.fm123 := -fm123;
end;

function TCL3MultivectorHelper.Reverse: TCL3Multivector;
begin
  result.fm0   :=  fm0;
  result.fm1   :=  fm1;
  result.fm2   :=  fm2;
  result.fm3   :=  fm3;
  result.fm12  := -fm12;
  result.fm13  := -fm13;
  result.fm23  := -fm23;
  result.fm123 := -fm123;
end;

function TCL3MultivectorHelper.Conjugate: TCL3Multivector;
begin
  result.fm0   :=  fm0;
  result.fm1   := -fm1;
  result.fm2   := -fm2;
  result.fm3   := -fm3;
  result.fm12  := -fm12;
  result.fm13  := -fm13;
  result.fm23  := -fm23;
  result.fm123 :=  fm123;
end;

function TCL3MultivectorHelper.Reciprocal: TCL3Multivector;
var
  Numerator: TCL3Multivector;
begin
  if ((fm0  <>0) and ((fm1 <>0) or (fm2 <>0) or (fm3 <>0))) or
     ((fm123<>0) and ((fm12<>0) or (fm23<>0) or (fm13<>0))) then
  begin
    Numerator := Conjugate * Inverse * Reverse;
    result    := Numerator / (Self*Numerator).fm0;
  end else
    result := Reverse / SquaredNorm;
end;

function TCL3MultivectorHelper.LeftReciprocal: TCL3Multivector;
begin
  if ((fm0  <>0) and ((fm1 <>0) or (fm2 <>0) or (fm3 <>0))) or
     ((fm123<>0) and ((fm12<>0) or (fm23<>0) or (fm13<>0))) then
  begin
    result := (Inverse*Reverse*Conjugate) / (Self*Conjugate*Inverse*Reverse).fm0;
  end else
    result := Reverse / SquaredNorm;
end;

function TCL3MultivectorHelper.Normalized: TCL3Multivector;
begin
  result := Self / Norm;
end;

function TCL3MultivectorHelper.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TCL3MultivectorHelper.SquaredNorm: double;
begin
  result := fm0*fm0 +fm1*fm1 +fm2*fm2 +fm3*fm3 +fm12*fm12 +fm23*fm23 +fm13*fm13 +fm123*fm123;
end;

function TCL3MultivectorHelper.Dot(const AVector: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  fm1   * AVector.fm1
                  +fm2   * AVector.fm2
                  +fm3   * AVector.fm3;

  result.fm1   :=  fm0   * AVector.fm1
                  +fm12  * AVector.fm2
                  +fm13  * AVector.fm3;

  result.fm2   :=  fm0   * AVector.fm2
                  -fm12  * AVector.fm1
                  +fm23  * AVector.fm3;

  result.fm3   :=  fm0   * AVector.fm3
                  -fm23  * AVector.fm2
                  -fm13  * AVector.fm1;

  result.fm12  :=  fm123 * AVector.fm3;
  result.fm13  := -fm123 * AVector.fm2;
  result.fm23  :=  fm123 * AVector.fm1;
  result.fm123 :=  0.0;
end;

function TCL3MultivectorHelper.Dot(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   := -fm12  * AVector.fm12
                  -fm13  * AVector.fm13
                  -fm23  * AVector.fm23;

  result.fm1   := -fm2   * AVector.fm12
                  -fm3   * AVector.fm13
                  -fm123 * AVector.fm23;

  result.fm2   :=  fm1   * AVector.fm12
                  -fm3   * AVector.fm23
                  +fm123 * AVector.fm13;

  result.fm3   :=  fm1   * AVector.fm13
                  +fm2   * AVector.fm23
                  -fm123 * AVector.fm12;

  result.fm12  :=  fm0   * AVector.fm12;
  result.fm13  :=  fm0   * AVector.fm13;
  result.fm23  :=  fm0   * AVector.fm23;
  result.fm123 :=  0;
end;

function TCL3MultivectorHelper.Dot(const AVector: TCL3Trivector): TCL3Multivector;
begin
  result.fm0   := -fm123 * AVector.fm123;
  result.fm1   := -fm23  * AVector.fm123;
  result.fm2   :=  fm13  * AVector.fm123;
  result.fm3   := -fm12  * AVector.fm123;
  result.fm12  :=  fm3   * AVector.fm123;
  result.fm13  := -fm2   * AVector.fm123;
  result.fm23  :=  fm1   * AVector.fm123;
  result.fm123 :=  fm0   * AVector.fm123;
end;

function TCL3MultivectorHelper.Dot(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0 :=    fm0   * AVector.fm0
                  +fm1   * AVector.fm1
                  +fm2   * AVector.fm2
                  +fm3   * AVector.fm3
                  -fm12  * AVector.fm12
                  -fm13  * AVector.fm13
                  -fm23  * AVector.fm23
                  -fm123 * AVector.fm123;

  result.fm1 :=    fm0   * AVector.fm1
                  +fm1   * AVector.fm0
                  -fm2   * AVector.fm12
                  -fm3   * AVector.fm13
                  +fm12  * AVector.fm2
                  +fm13  * AVector.fm3
                  -fm23  * AVector.fm123
                  -fm123 * AVector.fm23;

  result.fm2 :=    fm0   * AVector.fm2
                  +fm1   * AVector.fm12
                  +fm2   * AVector.fm0
                  -fm3   * AVector.fm23
                  -fm12  * AVector.fm1
                  +fm13  * AVector.fm123
                  +fm23  * AVector.fm3
                  +fm123 * AVector.fm13;

  result.fm3 :=    fm0   * AVector.fm3
                  +fm1   * AVector.fm13
                  +fm2   * AVector.fm23
                  +fm3   * AVector.fm0
                  -fm12  * AVector.fm123
                  -fm13  * AVector.fm1
                  -fm23  * AVector.fm2
                  -fm123 * AVector.fm12;

  result.fm12 :=   fm0   * AVector.fm12
                  +fm3   * AVector.fm123
                  +fm12  * AVector.fm0
                  +fm123 * AVector.fm3;

  result.fm23 :=   fm0   * AVector.fm23
                  +fm1   * Avector.fm123
                  +fm23  * AVector.fm0
                  +fm123 * AVector.fm1;

  result.fm13 :=   fm0   * AVector.fm13
                  -fm2   * AVector.fm123
                  +fm13  * AVector.fm0
                  -fm123 * AVector.fm2;

  result.fm123 :=  fm0   * AVector.fm123
                  +fm123 * AVector.fm0;
end;

function TCL3MultivectorHelper.Wedge(const AVector: TCL3Vector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  fm0  * AVector.fm1;
  result.fm2   :=  fm0  * AVector.fm2;
  result.fm3   :=  fm0  * AVector.fm3;

  result.fm12  :=  fm1  * AVector.fm2
                  -fm2  * AVector.fm1;

  result.fm23  :=  fm2  * AVector.fm3
                  -fm3  * AVector.fm2;

  result.fm13  := +fm1  * AVector.fm3
                  -fm3  * AVector.fm1;

  result.fm123 :=  fm12 * AVector.fm3
                  -fm13 * AVector.fm2
                  +fm23 * AVector.fm1;
end;

function TCL3MultivectorHelper.Wedge(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  fm0 * AVector.fm12;
  result.fm23  :=  fm0 * AVector.fm23;
  result.fm13  :=  fm0 * AVector.fm13;

  result.fm123 :=  fm1 * AVector.fm23
                  -fm2 * AVector.fm13
                  +fm3 * AVector.fm12
end;

function TCL3MultivectorHelper.Wedge(const AVector: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := fm0 * AVector.fm123;
end;

function TCL3MultivectorHelper.Wedge(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  fm0   * AVector.fm0;

  result.fm1   :=  fm0   * AVector.fm1
                  +fm1   * AVector.fm0;

  result.fm2   :=  fm0   * AVector.fm2
                  +fm2   * AVector.fm0;

  result.fm3   :=  fm0   * AVector.fm3
                  +fm3   * AVector.fm0;

  result.fm12  :=  fm0   * AVector.fm12
                  +fm1   * AVector.fm2
                  -fm2   * AVector.fm1
                  +fm12  * AVector.fm0;

  result.fm23  :=  fm0   * AVector.fm23
                  +fm2   * AVector.fm3
                  -fm3   * AVector.fm2
                  +fm23  * AVector.fm0;

  result.fm13  :=  fm0   * AVector.fm13
                  +fm1   * AVector.fm3
                  -fm3   * AVector.fm1
                  +fm13  * AVector.fm0;

  result.fm123 := +fm0   * AVector.fm123
                  +fm1   * AVector.fm23
                  -fm2   * AVector.fm13
                  +fm3   * AVector.fm12
                  +fm12  * AVector.fm3
                  -fm13  * AVector.fm2
                  +fm23  * AVector.fm1
                  +fm123 * AVector.fm0;
end;

function TCL3MultivectorHelper.Projection(const AVector: TCL3Vector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Projection(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Projection(const AVector: TCL3Trivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Projection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rejection(const AVector: TCL3Vector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rejection(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rejection(const AVector: TCL3Trivector): double;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rejection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Reflection(const AVector: TCL3Vector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Reflection(const AVector: TCL3Bivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Reflection(const AVector: TCL3Trivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Reflection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3MultivectorHelper.Rotation(const AVector1, AVector2: TCL3Vector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3MultivectorHelper.Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3MultivectorHelper.Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3MultivectorHelper.Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3MultivectorHelper.SameValue(const AValue: TCL3Multivector): boolean;
begin
  result := SameValueEx(fm0,   AValue.fm0  ) and
            SameValueEx(fm1,   AValue.fm1  ) and
            SameValueEx(fm2,   AValue.fm2  ) and
            SameValueEx(fm3,   AValue.fm3  ) and
            SameValueEx(fm12,  AValue.fm12 ) and
            SameValueEx(fm13,  AValue.fm13 ) and
            SameValueEx(fm23,  AValue.fm23 ) and
            SameValueEx(fm123, AValue.fm123);
end;

function TCL3MultivectorHelper.SameValue(const AValue: TCL3Trivector): boolean;
begin
  result := SameValueEx(fm0,            0.0) and
            SameValueEx(fm1,            0.0) and
            SameValueEx(fm2,            0.0) and
            SameValueEx(fm3,            0.0) and
            SameValueEx(fm12,           0.0) and
            SameValueEx(fm23,           0.0) and
            SameValueEx(fm13,           0.0) and
            SameValueEx(fm123, AValue.fm123);
end;

function TCL3MultivectorHelper.SameValue(const AValue: TCL3Bivector): boolean;
begin
  result := SameValueEx(fm0,           0.0) and
            SameValueEx(fm1,           0.0) and
            SameValueEx(fm2,           0.0) and
            SameValueEx(fm3,           0.0) and
            SameValueEx(fm12,  AValue.fm12) and
            SameValueEx(fm13,  AValue.fm13) and
            SameValueEx(fm23,  AValue.fm23) and
            SameValueEx(fm123,         0.0);
end;

function TCL3MultivectorHelper.SameValue(const AValue: TCL3Vector): boolean;
begin
  result := SameValueEx(fm0,          0.0) and
            SameValueEx(fm1,   AValue.fm1) and
            SameValueEx(fm2,   AValue.fm2) and
            SameValueEx(fm3,   AValue.fm3) and
            SameValueEx(fm12,         0.0) and
            SameValueEx(fm23,         0.0) and
            SameValueEx(fm13,         0.0) and
            SameValueEx(fm123,        0.0);
end;

function TCL3MultivectorHelper.SameValue(const AValue: double): boolean;
begin
  result := SameValueEx(fm0,   AValue) and
            SameValueEx(fm1,      0.0) and
            SameValueEx(fm2,      0.0) and
            SameValueEx(fm3,      0.0) and
            SameValueEx(fm12,     0.0) and
            SameValueEx(fm23,     0.0) and
            SameValueEx(fm13,     0.0) and
            SameValueEx(fm123,    0.0);
end;

function TCL3MultivectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm0,   0.0) then result := result + Fmt(fm0,   APrecision, ADigits) + ' ';
  if not SameValueEx(fm1,   0.0) then result := result + Fmt(fm1,   APrecision, ADigits) + 'e1 ';
  if not SameValueEx(fm2,   0.0) then result := result + Fmt(fm2,   APrecision, ADigits) + 'e2 ';
  if not SameValueEx(fm3,   0.0) then result := result + Fmt(fm3,   APrecision, ADigits) + 'e3 ';
  if not SameValueEx(fm12,  0.0) then result := result + Fmt(fm12,  APrecision, ADigits) + 'e12 ';
  if not SameValueEx(fm23,  0.0) then result := result + Fmt(fm23,  APrecision, ADigits) + 'e23 ';
  if not SameValueEx(fm13,  0.0) then result := result + Fmt(fm13,  APrecision, ADigits) + 'e31 ';
  if not SameValueEx(fm123, 0.0) then result := result + Fmt(fm123, APrecision, ADigits) + 'e123 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0';

  result := '(' + result + ')';
end;

function TCL3MultivectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm0,   0.0) then result := result + Fmt(fm0  ) + ' ';
  if not SameValueEx(fm1,   0.0) then result := result + Fmt(fm1  ) + 'e1 ';
  if not SameValueEx(fm2,   0.0) then result := result + Fmt(fm2  ) + 'e2 ';
  if not SameValueEx(fm3,   0.0) then result := result + Fmt(fm3  ) + 'e3 ';
  if not SameValueEx(fm12,  0.0) then result := result + Fmt(fm12 ) + 'e12 ';
  if not SameValueEx(fm23,  0.0) then result := result + Fmt(fm23 ) + 'e23 ';
  if not SameValueEx(fm13,  0.0) then result := result + Fmt(fm13 ) + 'e31 ';
  if not SameValueEx(fm123, 0.0) then result := result + Fmt(fm123) + 'e123 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0';

  result := '(' + result + ')';
end;

function TCL3MultivectorHelper.ExtractMultivector(AComponents: TCL3MultivectorComponents): TCL3Multivector;
begin
  Result := CL3NullMultivector;
  if mcm0   in AComponents then result.fm0   := fm0;
  if mcm1   in AComponents then result.fm1   := fm1;
  if mcm2   in AComponents then result.fm2   := fm2;
  if mcm3   in AComponents then result.fm3   := fm3;
  if mcm12  in AComponents then result.fm12  := fm12;
  if mcm13  in AComponents then result.fm13  := fm13;
  if mcm23  in AComponents then result.fm23  := fm23;
  if mcm123 in AComponents then result.fm123 := fm123;
end;

function TCL3MultivectorHelper.ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3Bivector;
begin
  Result := CL3NullBivector;
  if mcm12 in AComponents then result.fm12 := fm12;
  if mcm13 in AComponents then result.fm13 := fm13;
  if mcm23 in AComponents then result.fm23 := fm23;
end;

function TCL3MultivectorHelper.ExtractVector(AComponents: TCL3MultivectorComponents): TCL3Vector;
begin
  Result := CL3NullVector;
  if mcm1 in AComponents then result.fm1 := fm1;
  if mcm2 in AComponents then result.fm2 := fm2;
  if mcm3 in AComponents then result.fm3 := fm3;
end;

function TCL3MultivectorHelper.ExtractTrivector: TCL3Trivector;
begin
  result.fm123 := fm123;
end;

function TCL3MultivectorHelper.ExtractBivector: TCL3Bivector;
begin
  result.fm12 := fm12;
  result.fm13 := fm13;
  result.fm23 := fm23;
end;

function TCL3MultivectorHelper.ExtractVector: TCL3Vector;
begin
  result.fm1 := fm1;
  result.fm2 := fm2;
  result.fm3 := fm3;
end;

function TCL3MultivectorHelper.ExtractScalar: double;
begin
  result := fm0;
end;

function TCL3MultivectorHelper.IsNull: boolean;
begin
  result := SameValue(CL3NullMultivector);
end;

function TCL3MultivectorHelper.IsScalar: boolean;
begin
  result := (not SameValueEx(fm0,   0.0)) and
            (    SameValueEx(fm1,   0.0)) and
            (    SameValueEx(fm2,   0.0)) and
            (    SameValueEx(fm3,   0.0)) and
            (    SameValueEx(fm12,  0.0)) and
            (    SameValueEx(fm23,  0.0)) and
            (    SameValueEx(fm13,  0.0)) and
            (    SameValueEx(fm123, 0.0));
end;

function TCL3MultivectorHelper.IsVector: boolean;
begin
  result :=  (    SameValueEx(fm0,   0.0))  and
            ((not SameValueEx(fm1,   0.0))  or
             (not SameValueEx(fm2,   0.0))  or
             (not SameValueEx(fm3,   0.0))) and
             (    SameValueEx(fm12,  0.0))  and
             (    SameValueEx(fm23,  0.0))  and
             (    SameValueEx(fm13,  0.0))  and
             (    SameValueEx(fm123, 0.0));
end;

function TCL3MultivectorHelper.IsBiVector: boolean;
begin
  result :=  (    SameValueEx(fm0,   0.0))  and
             (    SameValueEx(fm1,   0.0))  and
             (    SameValueEx(fm2,   0.0))  and
             (    SameValueEx(fm3,   0.0))  and
            ((not SameValueEx(fm12,  0.0))  or
             (not SameValueEx(fm23,  0.0))  or
             (not SameValueEx(fm13,  0.0))) and
             (    SameValueEx(fm123, 0.0));
end;

function TCL3MultivectorHelper.IsTrivector: boolean;
begin
  result := (    SameValueEx(fm0,   0.0)) and
            (    SameValueEx(fm1,   0.0)) and
            (    SameValueEx(fm2,   0.0)) and
            (    SameValueEx(fm3,   0.0)) and
            (    SameValueEx(fm12,  0.0)) and
            (    SameValueEx(fm23,  0.0)) and
            (    SameValueEx(fm13,  0.0)) and
            (not SameValueEx(fm123, 0.0));
end;

function TCL3MultivectorHelper.IsA: string;
begin
  if IsNull      then Result := 'Null'       else
  if IsTrivector then Result := 'TCL3Trivector' else
  if IsBivector  then Result := 'TCL3Bivector'  else
  if IsVector    then Result := 'TCL3Vector'    else
  if IsScalar    then Result := 'TScalar'    else Result := 'TCL3Multivector';
end;

// TCL3TrivectorHelper

function TCL3TrivectorHelper.Dual: double;
begin
  // Self * e123
  result := -fm123;
end;

function TCL3TrivectorHelper.Inverse: TCL3Trivector;
begin
  result.fm123 := -fm123;
end;

function TCL3TrivectorHelper.Reverse: TCL3Trivector;
begin
  result.fm123 := -fm123;
end;

function TCL3TrivectorHelper.Conjugate: TCL3Trivector;
begin
  result.fm123 := fm123;
end;

function TCL3TrivectorHelper.Reciprocal: TCL3Trivector;
begin
  result := Reverse / SquaredNorm;
end;

function TCL3TrivectorHelper.Normalized: TCL3Trivector;
begin
  result := Self / Norm;
end;

function TCL3TrivectorHelper.Norm: double;
begin
  result := abs(fm123);
end;

function TCL3TrivectorHelper.SquaredNorm: double;
begin
  result := fm123 * fm123;
end;

function TCL3TrivectorHelper.Dot(const AVector: TCL3Vector): TCL3Bivector;
begin
  result.fm12 :=  fm123 * AVector.fm3;
  result.fm13 := -fm123 * AVector.fm2;
  result.fm23 :=  fm123 * AVector.fm1;
end;

function TCL3TrivectorHelper.Dot(const AVector: TCL3Bivector): TCL3Vector;
begin
  result.fm1 := -fm123 * AVector.fm23;
  result.fm2 :=  fm123 * AVector.fm13;
  result.fm3 := -fm123 * AVector.fm12;
end;

function TCL3TrivectorHelper.Dot(const AVector: TCL3Trivector): double;
begin
  result := -fm123 * AVector.fm123;
end;

function TCL3TrivectorHelper.Dot(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := -fm123 * AVector.fm123;
  result.fm1   := -fm123 * AVector.fm23;
  result.fm2   :=  fm123 * AVector.fm13;
  result.fm3   := -fm123 * AVector.fm12;
  result.fm12  :=  fm123 * AVector.fm3;
  result.fm13  := -fm123 * AVector.fm2;
  result.fm23  :=  fm123 * AVector.fm1;
  result.fm123 :=  fm123 * AVector.fm0;
end;

function TCL3TrivectorHelper.Wedge(const AVector: TCL3Vector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Wedge(const AVector: TCL3Bivector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Wedge(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Wedge(const AVector: TCL3Multivector): TCL3Trivector;
begin
  result.fm123 := fm123 * AVector.fm0;
end;

function TCL3TrivectorHelper.Projection(const AVector: TCL3Vector): TCL3Trivector;
begin
  result.fm123 := fm123 * AVector.Norm;
end;

function TCL3TrivectorHelper.Projection(const AVector: TCL3Bivector): TCL3Trivector;
begin
  result.fm123 := fm123 * AVector.Norm;
end;

function TCL3TrivectorHelper.Projection(const AVector: TCL3Trivector): TCL3Trivector;
begin
  result.fm123 := fm123 * AVector.Norm;
end;

function TCL3TrivectorHelper.Projection(const AVector: TCL3Multivector): TCL3Trivector;
begin
  // inplicit ExtracTCL3Trivector
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Rejection(const AVector: TCL3Vector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Rejection(const AVector: TCL3Bivector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Rejection(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3TrivectorHelper.Rejection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Reflection(const AVector: TCL3Vector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Reflection(const AVector: TCL3Bivector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Reflection(const AVector: TCL3Trivector): TCL3Trivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Reflection(const AVector: TCL3Multivector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3TrivectorHelper.Rotation(const AVector1, AVector2: TCL3Vector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3TrivectorHelper.Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3TrivectorHelper.Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Trivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3TrivectorHelper.Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Trivector;
begin
  // implicit ExtracTCL3Trivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3TrivectorHelper.SameValue(const AValue: TCL3Multivector): boolean;
begin
  result := SameValueEx(0.0,   AValue.fm0  ) and
            SameValueEx(0.0,   AValue.fm1  ) and
            SameValueEx(0.0,   AValue.fm2  ) and
            SameValueEx(0.0,   AValue.fm3  ) and
            SameValueEx(0.0,   AValue.fm12 ) and
            SameValueEx(0.0,   AValue.fm13 ) and
            SameValueEx(0.0,   AValue.fm23 ) and
            SameValueEx(fm123, AValue.fm123);
end;

function TCL3TrivectorHelper.SameValue(const AValue: TCL3Trivector): boolean;
begin
  result := SameValueEx(fm123, AValue.fm123);
end;

function TCL3TrivectorHelper.ToString(APrecision, ADigits: longint): string;
begin
  if not SameValueEx(fm123, 0.0) then
    result := Fmt(fm123, APrecision, ADigits) + 'e123'
  else
    result := '0e123';

  result := '(' + result + ')';
end;

function TCL3TrivectorHelper.ToString: string;
begin
  if not SameValueEx(fm123, 0.0) then
    result := Fmt(fm123) + 'e123'
  else
    result := '0e123';

  result := '(' + result + ')';
end;

function TCL3TrivectorHelper.ToMultivector: TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := fm123;
end;

// TCL3BivectorHelper

function TCL3BivectorHelper.Dual: TCL3Vector;
begin
  result.fm1 := -fm23;
  result.fm2 :=  fm13;
  result.fm3 := -fm12;
end;

function TCL3BivectorHelper.Inverse: TCL3Bivector;
begin
  result.fm12 := fm12;
  result.fm13 := fm13;
  result.fm23 := fm23;
end;

function TCL3BivectorHelper.Conjugate: TCL3Bivector;
begin
  result.fm12 := -fm12;
  result.fm13 := -fm13;
  result.fm23 := -fm23;
end;

function TCL3BivectorHelper.Reverse: TCL3Bivector;
begin
  result.fm12 := -fm12;
  result.fm13 := -fm13;
  result.fm23 := -fm23;
end;

function TCL3BivectorHelper.Reciprocal: TCL3Bivector;
begin
  result := Reverse / SquaredNorm;
end;

function TCL3BivectorHelper.Normalized: TCL3Bivector;
begin
  result := Self / Norm;
end;

function TCL3BivectorHelper.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TCL3BivectorHelper.SquaredNorm: double;
begin
  result := fm12*fm12 + fm13*fm13 + fm23*fm23;
end;

function TCL3BivectorHelper.Dot(const AVector: TCL3Vector): TCL3Vector;
begin
  result.fm1 :=  fm12 * AVector.fm2
                +fm13 * AVector.fm3;

  result.fm2 :=  fm23 * AVector.fm3
                -fm12 * AVector.fm1;

  result.fm3 := -fm13 * AVector.fm1
                -fm23 * AVector.fm2;
end;

function TCL3BivectorHelper.Dot(const AVector: TCL3Bivector): double;
begin
  result := -fm12 * AVector.fm12
            -fm13 * AVector.fm13
            -fm23 * AVector.fm23;
end;

function TCL3BivectorHelper.Dot(const AVector: TCL3Trivector): TCL3Vector;
begin
  result.fm1 := -fm23 * AVector.fm123;
  result.fm2 :=  fm13 * AVector.fm123;
  result.fm3 := -fm12 * AVector.fm123;
end;

function TCL3BivectorHelper.Dot(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   := -fm12 * AVector.fm12
                  -fm13 * AVector.fm13
                  -fm23 * AVector.fm23;

  result.fm1   :=  fm12 * AVector.fm2
                  -fm23 * AVector.fm123
                  +fm13 * AVector.fm3;

  result.fm2   := -fm12 * AVector.fm1
                  +fm13 * AVector.fm123
                  +fm23 * AVector.fm3;

  result.fm3   := -fm12 * AVector.fm123
                  -fm23 * AVector.fm2
                  -fm13 * AVector.fm1;

  result.fm12  :=  fm12 * AVector.fm0;
  result.fm13  :=  fm13 * AVector.fm0;
  result.fm23  :=  fm23 * AVector.fm0;
  result.fm123 :=  0.0;
end;

function TCL3BivectorHelper.Wedge(const AVector: TCL3Vector): TCL3Trivector;
begin
  result.fm123 :=  fm12 * AVector.fm3
                  -fm13 * AVector.fm2
                  +fm23 * AVector.fm1;
end;

function TCL3BivectorHelper.Wedge(const AVector: TCL3Bivector): double;
begin
  result := 0.0;
end;

function TCL3BivectorHelper.Wedge(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3BivectorHelper.Wedge (const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  0.0;
  result.fm2   :=  0.0;
  result.fm3   :=  0.0;
  result.fm12  :=  fm12 * AVector.fm0;
  result.fm13  :=  fm13 * AVector.fm0;
  result.fm23  :=  fm23 * AVector.fm0;

  result.fm123 :=  fm12 * AVector.fm3
                  +fm23 * AVector.fm1
                  -fm13 * AVector.fm2;
end;

function TCL3BivectorHelper.Projection(const AVector: TCL3Vector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Projection(const AVector: TCL3Bivector): TCL3Bivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Projection(const AVector: TCL3Trivector): TCL3Bivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Projection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Rejection(const AVector: TCL3Vector): TCL3Bivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Rejection (const AVector: TCL3Bivector): double;
begin
  result := 0.0;
end;

function TCL3BivectorHelper.Rejection (const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3BivectorHelper.Rejection (const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Reflection(const AVector: TCL3Vector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Reflection(const AVector: TCL3Bivector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Reflection(const AVector: TCL3Trivector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Reflection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3BivectorHelper.Rotation(const AVector1, AVector2: TCL3Vector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3BivectorHelper.Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3BivectorHelper.Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Bivector;
begin
  // implicit ExtracTCL3Bivector
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3BivectorHelper.Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3BivectorHelper.SameValue(const AValue: TCL3Multivector): boolean;
begin
  result := SameValueEx(0.0,  AValue.fm0  ) and
            SameValueEx(0.0,  AValue.fm1  ) and
            SameValueEx(0.0,  AValue.fm2  ) and
            SameValueEx(0.0,  AValue.fm3  ) and
            SameValueEx(fm12, AValue.fm12 ) and
            SameValueEx(fm13, AValue.fm13 ) and
            SameValueEx(fm23, AValue.fm23 ) and
            SameValueEx(0.0,  AValue.fm123);
end;

function TCL3BivectorHelper.SameValue(const AValue: TCL3Bivector): boolean;
begin
  result := SameValueEx(fm12, AValue.fm12) and
            SameValueEx(fm13, AValue.fm13) and
            SameValueEx(fm23, AValue.fm23);
end;

function TCL3BivectorHelper.ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3Bivector;
begin
  Result := CL3NullBivector;
  if mcm12 in AComponents then result.fm12 := fm12;
  if mcm13 in AComponents then result.fm13 := fm13;
  if mcm23 in AComponents then result.fm23 := fm23;
end;

function TCL3BivectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm12, 0.0) then result := result + Fmt(fm12,  APrecision, ADigits) + 'e12 ';
  if not SameValueEx(fm13, 0.0) then result := result + Fmt(fm13,  APrecision, ADigits) + 'e13 ';
  if not SameValueEx(fm23, 0.0) then result := result + Fmt(fm23,  APrecision, ADigits) + 'e23 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e12';

  result := '(' + result + ')';
end;

function TCL3BivectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm12, 0.0) then result := result + Fmt(fm12) + 'e12 ';
  if not SameValueEx(fm13, 0.0) then result := result + Fmt(fm13) + 'e13 ';
  if not SameValueEx(fm23, 0.0) then result := result + Fmt(fm23) + 'e23 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e12';

  result := '(' + result + ')';
end;

function TCL3BivectorHelper.ToMultivector: TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := 0.0;
  result.fm2   := 0.0;
  result.fm3   := 0.0;
  result.fm12  := fm12;
  result.fm13  := fm13;
  result.fm23  := fm23;
  result.fm123 := 0.0;
end;

// TCL3VectorHelper

function TCL3VectorHelper.Dual: TCL3Bivector;
begin
  result.fm12 :=  fm3;
  result.fm13 := -fm2;
  result.fm23 :=  fm1;
end;

function TCL3VectorHelper.Inverse: TCL3Vector;
begin
  result.fm1 := -fm1;
  result.fm2 := -fm2;
  result.fm3 := -fm3;
end;

function TCL3VectorHelper.Reverse: TCL3Vector;
begin
  result.fm1 := fm1;
  result.fm2 := fm2;
  result.fm3 := fm3;
end;

function TCL3VectorHelper.Conjugate: TCL3Vector;
begin
  result.fm1 := -fm1;
  result.fm2 := -fm2;
  result.fm3 := -fm3;
end;

function TCL3VectorHelper.Reciprocal: TCL3Vector;
begin
  result := Reverse / SquaredNorm;
end;

function TCL3VectorHelper.Normalized: TCL3Vector;
begin
  result := Self / Norm;
end;

function TCL3VectorHelper.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TCL3VectorHelper.SquaredNorm: double;
begin
  result := fm1*fm1 + fm2*fm2 + fm3*fm3;
end;

function TCL3VectorHelper.Dot(const AVector: TCL3Vector): double;
begin
 result :=  fm1 * AVector.fm1
           +fm2 * AVector.fm2
           +fm3 * AVector.fm3;
end;

function TCL3VectorHelper.Dot(const AVector: TCL3Bivector): TCL3Vector;
begin
  result.fm1 := -fm3 * AVector.fm13
                -fm2 * AVector.fm12;

  result.fm2 :=  fm1 * AVector.fm12
                -fm3 * AVector.fm23;

  result.fm3 :=  fm2 * AVector.fm23
                +fm1 * AVector.fm13;
end;

function TCL3VectorHelper.Dot(const AVector: TCL3Trivector): TCL3Bivector;
begin
  result.fm12 :=  fm3 * AVector.fm123;
  result.fm13 := -fm2 * AVector.fm123;
  result.fm23 :=  fm1 * Avector.fm123;
end;

function TCL3VectorHelper.Dot(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  fm1 * AVector.fm1
                  +fm2 * AVector.fm2
                  +fm3 * AVector.fm3;

  result.fm1   :=  fm1 * AVector.fm0
                  -fm2 * AVector.fm12
                  -fm3 * AVector.fm13;

  result.fm2   :=  fm1 * AVector.fm12
                  +fm2 * AVector.fm0
                  -fm3 * AVector.fm23;

  result.fm3   :=  fm1 * AVector.fm13
                  +fm2 * AVector.fm23
                  +fm3 * AVector.fm0;

  result.fm12  :=  fm3 * AVector.fm123;
  result.fm13  := -fm2 * AVector.fm123;
  result.fm23  :=  fm1 * Avector.fm123;
  result.fm123 :=  0.0;
end;

function TCL3VectorHelper.Wedge(const AVector: TCL3Vector): TCL3Bivector;
begin
  result.fm12 :=  fm1 * AVector.fm2
                 -fm2 * AVector.fm1;

  result.fm13 :=  fm1 * AVector.fm3
                 -fm3 * AVector.fm1;

  result.fm23 :=  fm2 * AVector.fm3
                 -fm3 * AVector.fm2;
end;

function TCL3VectorHelper.Wedge(const AVector: TCL3Bivector): TCL3Trivector;
begin
  result.fm123 :=  fm1 * AVector.fm23
                  -fm2 * AVector.fm13
                  +fm3 * AVector.fm12;
end;

function TCL3VectorHelper.Wedge(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3VectorHelper.Wedge(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result.fm0   :=  0.0;
  result.fm1   :=  fm1 * AVector.fm0;
  result.fm2   :=  fm2 * AVector.fm0;
  result.fm3   :=  fm3 * AVector.fm0;

  result.fm12  :=  fm1 * AVector.fm2
                  -fm2 * AVector.fm1;

  result.fm13  :=  fm1 * AVector.fm3
                  -fm3 * AVector.fm1;

  result.fm23  :=  fm2 * AVector.fm3
                  -fm3 * AVector.fm2;

  result.fm123 :=  fm1 * AVector.fm23
                  -fm2 * AVector.fm13
                  +fm3 * AVector.fm12;
end;

function TCL3VectorHelper.Projection(const AVector: TCL3Vector): TCL3Vector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3VectorHelper.Projection(const AVector: TCL3Bivector): TCL3Vector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3VectorHelper.Projection(const AVector: TCL3Trivector): TCL3Vector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3VectorHelper.Projection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TCL3VectorHelper.Rejection(const AVector: TCL3Vector): TCL3Vector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function  TCL3VectorHelper.Rejection(const AVector: TCL3Bivector): TCL3Vector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3VectorHelper.Rejection(const AVector: TCL3Trivector): double;
begin
  result := 0.0;
end;

function TCL3VectorHelper.Rejection (const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := Wedge(AVector) * AVector.Reciprocal;
end;

function TCL3VectorHelper.Reflection(const AVector: TCL3Vector): TCL3Vector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3VectorHelper.Reflection(const AVector: TCL3Bivector): TCL3Vector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3VectorHelper.Reflection(const AVector: TCL3Trivector): TCL3Vector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3VectorHelper.Reflection(const AVector: TCL3Multivector): TCL3Multivector;
begin
  result := AVector * Self * AVector.Reciprocal;
end;

function TCL3VectorHelper.Rotation(const AVector1, AVector2: TCL3Vector): TCL3Vector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal * AVector2.Reciprocal;
end;

function TCL3VectorHelper.Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Vector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal  * AVector2.Reciprocal;
end;

function TCL3VectorHelper.Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Vector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal  * AVector2.Reciprocal;
end;

function TCL3VectorHelper.Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector;
begin
  result := AVector2 * AVector1 * Self * AVector1.Reciprocal  * AVector2.Reciprocal;
end;

function TCL3VectorHelper.Cross(const AVector: TCL3Vector): TCL3Vector;
begin
  result.fm1 :=  fm2*AVector.fm3
                -fm3*AVector.fm2;

  result.fm2 :=  fm1*AVector.fm3
                -fm3*AVector.fm1;

  result.fm3 :=  fm1*AVector.fm2
                -fm2*AVector.fm1;
end;

function TCL3VectorHelper.SameValue(const AValue: TCL3Multivector): boolean;
begin
  result := SameValueEx(0.0, AValue.fm0  ) and
            SameValueEx(fm1, AValue.fm1  ) and
            SameValueEx(fm2, AValue.fm2  ) and
            SameValueEx(fm3, AValue.fm3  ) and
            SameValueEx(0.0, AValue.fm12 ) and
            SameValueEx(0.0, AValue.fm13 ) and
            SameValueEx(0.0, AValue.fm23 ) and
            SameValueEx(0.0, AValue.fm123);
end;

function TCL3VectorHelper.SameValue(const AValue: TCL3Vector): boolean;
begin
  result := SameValueEx(fm1, AValue.fm1) and
            SameValueEx(fm2, AValue.fm2) and
            SameValueEx(fm3, AValue.fm3);
end;

function TCL3VectorHelper.ExtractVector(AComponents: TCL3MultivectorComponents): TCL3Vector;
begin
  Result := CL3NullVector;
  if mcm1 in AComponents then result.fm1 := fm1;
  if mcm2 in AComponents then result.fm2 := fm2;
  if mcm3 in AComponents then result.fm3 := fm3;
end;

function TCL3VectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm1, 0.0) then result := result + Fmt(fm1,  APrecision, ADigits) + 'e1 ';
  if not SameValueEx(fm2, 0.0) then result := result + Fmt(fm2,  APrecision, ADigits) + 'e2 ';
  if not SameValueEx(fm3, 0.0) then result := result + Fmt(fm3,  APrecision, ADigits) + 'e3 ';

    i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

function TCL3VectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm1, 0.0) then result := result + Fmt(fm1) + 'e1 ';
  if not SameValueEx(fm2, 0.0) then result := result + Fmt(fm2) + 'e2 ';
  if not SameValueEx(fm3, 0.0) then result := result + Fmt(fm3) + 'e3 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

function TCL3VectorHelper.ToMultivector: TCL3Multivector;
begin
  result.fm0   := 0.0;
  result.fm1   := fm1;
  result.fm2   := fm2;
  result.fm3   := fm3;
  result.fm12  := 0.0;
  result.fm13  := 0.0;
  result.fm23  := 0.0;
  result.fm123 := 0.0;
end;

// TCL3Versors

class operator TCL3Versor1.*(const AValue: double; const ASelf: TCL3Versor1): TCL3Vector;
begin
  result.fm1 := AValue;
  result.fm2 := 0.0;
  result.fm3 := 0.0;
end;

class operator TCL3Versor2.*(const AValue: double; const ASelf: TCL3Versor2): TCL3Vector;
begin
  result.fm1 := 0.0;
  result.fm2 := AValue;
  result.fm3 := 0.0;
end;

class operator TCL3Versor3.*(const AValue: double; const ASelf: TCL3Versor3): TCL3Vector;
begin
  result.fm1 := 0.0;
  result.fm2 := 0.0;
  result.fm3 := AValue;
end;

// TCL3Biversors

class operator TCL3Biversor12.*(const AValue: double; const ASelf: TCL3Biversor12): TCL3Bivector;
begin
  result.fm12 := AValue;
  result.fm13 := 0.0;
  result.fm23 := 0.0;
end;

class operator TCL3Biversor13.*(const AValue: double; const ASelf: TCL3Biversor13): TCL3Bivector;
begin
  result.fm12 := 0.0;
  result.fm13 := AValue;
  result.fm23 := 0.0;
end;

class operator TCL3Biversor23.*(const AValue: double; const ASelf: TCL3Biversor23): TCL3Bivector;
begin
  result.fm12 := 0.0;
  result.fm13 := 0.0;
  result.fm23 := AValue;
end;

// TCL3Triversor

class operator TCL3Triversor123.*(const AValue: double; const ASelf: TCL3Triversor123): TCL3Trivector;
begin
  result.fm123 := AValue;
end;

{$IFNDEF ADIMOFF}
class operator TCL3MultivecQuantity.<>(const ALeft, ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3MultivecQuantity.=(const ALeft, ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3MultivecQuantity.+(const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3MultivecQuantity.-(const ASelf: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := ASelf.FDim;
  result.FValue := -ASelf.FValue;
end;

class operator TCL3MultivecQuantity.-(const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3MultivecQuantity.*(const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3MultivecQuantity./(const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3MultivecQuantity./(const ALeft: double; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft * ARight.FValue.Reciprocal;
end;

class operator TCL3MultivecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: double): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL3MultivecQuantity.<>(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3MultivecQuantity.<>(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3MultivecQuantity.=(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3MultivecQuantity.=(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3MultivecQuantity.+(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3MultivecQuantity.+(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3MultivecQuantity.-(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3MultivecQuantity.-(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3MultivecQuantity.*(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3MultivecQuantity.*(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3MultivecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3MultivecQuantity./(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TCL3TrivecQuantity

{$IFNDEF ADIMOFF}

class operator TCL3TrivecQuantity.:=(const AValue: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft, ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft, ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft, ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ASelf: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := ASelf.FDim;
  result.FValue := -ASelf.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft, ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: double; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft * ARight.FValue.Reciprocal;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: double): TCL3TrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft, ARight: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft, ARight: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

{$ENDIF}

// TCL3BivecQuantity

{$IFNDEF ADIMOFF}
class operator TCL3BivecQuantity.:=(const AValue: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TCL3BivecQuantity.<>(const ALeft, ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3BivecQuantity.<>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3BivecQuantity.<>(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3BivecQuantity.=(const ALeft, ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3BivecQuantity.=(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3BivecQuantity.=(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft, ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ASelf: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := ASelf.FDim;
  result.FValue := -ASelf.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft, ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft, ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft, ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3BivecQuantity./(const ALeft: double; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft * ARight.FValue.Reciprocal;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: double): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue * ARight;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3BivecQuantity.+(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TCL3VecQuantity

{$IFNDEF ADIMOFF}
class operator TCL3VecQuantity.:=(const AValue: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TCL3VecQuantity.<>(const ALeft, ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3VecQuantity.<>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3VecQuantity.<>(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3VecQuantity.=(const ALeft, ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3VecQuantity.=(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3VecQuantity.=(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft, ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ASelf: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := ASelf.FDim;
  result.FValue := -ASelf.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft, ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft, ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity./(const ALeft, ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./(const ALeft: double; const ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3VecQuantity; const ARight: double): TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue * ARight;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity.+(const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity./ (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3VecQuantity./(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TComplexQuantityHelper

{$IFNDEF ADIMOFF}
function TComplexQuantityHelper.Conjugate: TComplexQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TComplexQuantityHelper.Reciprocal: TComplexQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Reciprocal;
end;

function TComplexQuantityHelper.Norm: TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TComplexQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;
{$ENDIF}

// TC2MatrixQuantityHelper

{$IFNDEF ADIMOFF}
function TC2MatrixQuantityHelper.Diagonalize(const AEigenvalues: TC2ArrayOfQuantity): TC2MatrixQuantity;
var
  EigenVals: TC2ArrayOfComplex;
begin
  EigenVals[1] := AEigenvalues[1].FValue;
  EigenVals[2] := AEigenvalues[2].FValue;

  result.FDim := FDim;
  result.FValue := FValue.Diagonalize(EigenVals);
end;

function TC2MatrixQuantityHelper.Conjugate: TC2MatrixQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TC2MatrixQuantityHelper.Determinant: TComplexQuantity;
begin
  result.FDim := FDim*2;
  result.FValue := FValue.Determinant;
end;

function TC2MatrixQuantityHelper.Eigenvalues: TC2ArrayOfQuantity;
var
  i: longint;
  EigenVals: TC2ArrayOfComplex;
begin
  EigenVals := FValue.Eigenvalues;
  for i := 1 to 2 do
  begin
    result[i].FDim := FDim;
    result[i].FValue := EigenVals[i];
  end;
end;

function TC2MatrixQuantityHelper.Eigenvectors(const AEigenValues: TC2ArrayOfQuantity): TC2ArrayOfVector;
var
  i: longint;
  EigenVals: TC2ArrayOfComplex;
  EigenVecs: TC2ArrayOfVector;
begin
  EigenVals[1] := AEigenValues[1].FValue;
  EigenVals[2] := AEigenValues[2].FValue;

  EigenVecs := FValue.EigenVectors(EigenVals);
  for i := 1 to 2 do
  begin
    result[i] := EigenVecs[i];
  end;
end;

function TC2MatrixQuantityHelper.Reciprocal(const ADeterminant: TComplexQuantity): TC2MatrixQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Reciprocal(ADeterminant.FValue);
end;

function TC2MatrixQuantityHelper.TransposeConjugate: TC2MatrixQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.TransposeConjugate;
end;
{$ENDIF}

// TC2VecQuantityHelper

{$IFNDEF ADIMOFF}
function TC2VecQuantityHelper.Dot(const AVector: TC2VecQuantity): TComplexQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TC2VecQuantityHelper.Conjugate: TC2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue:= FValue.Conjugate;
end;
{$ENDIF}

// TC3VecQuantityHelper

{$IFNDEF ADIMOFF}
function TC3VecQuantityHelper.Dot(const AVector: TC3VecQuantity): TComplexQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TC3VecQuantityHelper.Conjugate: TC3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue:= FValue.Conjugate;
end;
{$ENDIF}

// TC4VecQuantityHelper

{$IFNDEF ADIMOFF}
function TC4VecQuantityHelper.Dot(const AVector: TC4VecQuantity): TComplexQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TC4VecQuantityHelper.Conjugate: TC4VecQuantity;
begin
  result.FDim := FDim;
  result.FValue:= FValue.Conjugate;
end;
{$ENDIF}

// TR2VecQuantityHelper

{$IFNDEF ADIMOFF}
function TR2VecQuantityHelper.Dot(const AVector: TR2VecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;
{$ENDIF}

// TR3VecQuantityHelper

{$IFNDEF ADIMOFF}
function TR3VecQuantityHelper.Dot(const AVector: TR3VecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TR3VecQuantityHelper.Cross(const AVector: TR3VecQuantity): TR3VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Cross(AVector.FValue);
end;
{$ENDIF}

// TR4VecQuantityHelper

{$IFNDEF ADIMOFF}
function TR4VecQuantityHelper.Dot(const AVector: TR4VecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;
{$ENDIF}

// TCL3MultivecQuantityHelper

{$IFNDEF ADIMOFF}
function TCL3MultivecQuantityHelper.Dual: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL3MultivecQuantityHelper.Inverse: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Inverse;
end;

function TCL3MultivecQuantityHelper.Reverse: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL3MultivecQuantityHelper.Conjugate: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL3MultivecQuantityHelper.Reciprocal: TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Reciprocal;
end;

function TCL3MultivecQuantityHelper.LeftReciprocal: TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.LeftReciprocal;
end;

function TCL3MultivecQuantityHelper.Normalized: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL3MultivecQuantityHelper.Norm: TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL3MultivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL3MultivecQuantityHelper.Dot(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Dot(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Wedge(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Projection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Projection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rejection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Reflection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Reflection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TCL3MultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TCL3TrivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TCL3BivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TCL3VecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.ExtractMultivector(AComponents: TCL3MultivectorComponents): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractMultivector(AComponents);
end;

function TCL3MultivecQuantityHelper.ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractBivector(AComponents);
end;

function TCL3MultivecQuantityHelper.ExtractVector(AComponents: TCL3MultivectorComponents): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractVector(AComponents);
end;

function TCL3MultivecQuantityHelper.ExtractTrivector: TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractTrivector;
end;

function TCL3MultivecQuantityHelper.ExtractBivector: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractBivector;
end;

function TCL3MultivecQuantityHelper.ExtractVector: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractVector;
end;

function TCL3MultivecQuantityHelper.ExtractScalar: TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractScalar;
end;

function TCL3MultivecQuantityHelper.IsNull: boolean;
begin
  result := FValue.SameValue(CL3NullMultivector);
end;

function TCL3MultivecQuantityHelper.IsScalar: boolean;
begin
  result := FValue.IsScalar;
end;

function TCL3MultivecQuantityHelper.IsVector: boolean;
begin
  result := FValue.IsVector;
end;

function TCL3MultivecQuantityHelper.IsBiVector: boolean;
begin
  result := FValue.IsBiVector;
end;

function TCL3MultivecQuantityHelper.IsTrivector: boolean;
begin
  result := FValue.IsTrivector;
end;

function TCL3MultivecQuantityHelper.IsA: string;
begin
  result := FValue.IsA;
end;
{$ENDIF}

// TCL3TrivecQuantityHelper

{$IFNDEF ADIMOFF}
function TCL3TrivecQuantityHelper.Dual: TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL3TrivecQuantityHelper.Inverse: TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Inverse;
end;

function TCL3TrivecQuantityHelper.Reverse: TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL3TrivecQuantityHelper.Conjugate: TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL3TrivecQuantityHelper.Reciprocal: TCL3TrivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Reciprocal;
end;

function TCL3TrivecQuantityHelper.Normalized: TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL3TrivecQuantityHelper.Norm: TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL3TrivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3VecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TCL3VecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3VecQuantity): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TCL3VecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.SameValue(const AVector: TCL3MultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.SameValue(const AVector: TCL3TrivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.ToMultivector: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TCL3BivecQuantityHelper

{$IFNDEF ADIMOFF}
function TCL3BivecQuantityHelper.Dual: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL3BivecQuantityHelper.Inverse: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Inverse;
end;

function TCL3BivecQuantityHelper.Conjugate: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL3BivecQuantityHelper.Reverse: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL3BivecQuantityHelper.Reciprocal: TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Reciprocal;
end;

function TCL3BivecQuantityHelper.Normalized: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL3BivecQuantityHelper.Norm: TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL3BivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL3BivecQuantityHelper.Dot(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Dot(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3VecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := 0.0;
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := 0.0;
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Projection(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Projection(const AVector: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Reflection(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Reflection(const AVector: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.SameValue(const AVector: TCL3MultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3BivecQuantityHelper.SameValue(const AVector: TCL3BivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3BivecQuantityHelper.ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractBivector(AComponents);
end;

function TCL3BivecQuantityHelper.ToMultivector: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TCL3VecQuantityHelper

{$IFNDEF ADIMOFF}
function TCL3VecQuantityHelper.Dual: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL3VecQuantityHelper.Inverse: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Inverse;
end;

function TCL3VecQuantityHelper.Reverse: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL3VecQuantityHelper.Conjugate: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL3VecQuantityHelper.Reciprocal: TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Reciprocal;
end;

function TCL3VecQuantityHelper.Normalized: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL3VecQuantityHelper.Norm: TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL3VecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL3VecQuantityHelper.Dot(const AVector: TCL3VecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3VecQuantityHelper.Dot(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3VecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3VecQuantityHelper.Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3VecQuantityHelper.Wedge(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3VecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3VecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := 0.0;
end;

function TCL3VecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3VecQuantityHelper.Projection(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Projection(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Rejection(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function  TCL3VecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3VecQuantityHelper.Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Reflection(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Reflection(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Cross(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Cross(AVector.FValue);
end;

function TCL3VecQuantityHelper.SameValue(const AVector: TCL3MultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3VecQuantityHelper.SameValue(const AVector: TCL3VecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3VecQuantityHelper.ExtractVector(AComponents: TCL3MultivectorComponents): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractVector(AComponents);
end;

function TCL3VecQuantityHelper.ToMultivector: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// Versors

class operator TR2Versor1.*(const AValue: double; const ASelf: TR2Versor1): TR2Vector;
begin
  result[1] := AValue;
  result[2] := 0;
end;

class operator TR2Versor2.*(const AValue: double; const ASelf: TR2Versor2): TR2Vector;
begin
  result[1] := 0;
  result[2] := AValue;
end;

class operator TR3Versor1.*(const AValue: double; const ASelf: TR3Versor1): TR3Vector;
begin
  result[1] := AValue;
  result[2] := 0;
  result[3] := 0;
end;

class operator TR3Versor2.*(const AValue: double; const ASelf: TR3Versor2): TR3Vector;
begin
  result[1] := 0;
  result[2] := AValue;
  result[3] := 0;
end;

class operator TR3Versor3.*(const AValue: double; const ASelf: TR3Versor3): TR3Vector;
begin
  result[1] := 0;
  result[2] := 0;
  result[3] := AValue;
end;

class operator TR4Versor1.*(const AValue: double; const ASelf: TR4Versor1): TR4Vector;
begin
  result[1] := AValue;
  result[2] := 0;
  result[3] := 0;
  result[4] := 0;
end;

class operator TR4Versor2.*(const AValue: double; const ASelf: TR4Versor2): TR4Vector;
begin
  result[1] := 0;
  result[2] := AValue;
  result[3] := 0;
  result[4] := 0;
end;

class operator TR4Versor3.*(const AValue: double; const ASelf: TR4Versor3): TR4Vector;
begin
  result[1] := 0;
  result[2] := 0;
  result[3] := AValue;
  result[4] := 0;
end;

class operator TR4Versor4.*(const AValue: double; const ASelf: TR4Versor4): TR4Vector;
begin
  result[1] := 0;
  result[2] := 0;
  result[3] := 0;
  result[4] := AValue;
end;

// External operators

{$IFNDEF ADIMOFF}
operator * (const ALeft: TQuantity; const ARight: TR2Matrix): TR2MatrixQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator * (const ALeft: TR2Matrix; const ARight: TQuantity): TR2MatrixQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator * (const ALeft: TQuantity; const ARight: TR3Matrix): TR3MatrixQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator * (const ALeft: TR3Matrix; const ARight: TQuantity): TR3MatrixQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator * (const ALeft: TQuantity; const ARight: TR4Matrix): TR4MatrixQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator * (const ALeft: TR4Matrix; const ARight: TQuantity): TR4MatrixQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator * (const ALeft: TQuantity; const ARight: TC2Matrix): TC2MatrixQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator * (const ALeft: TC2Matrix; const ARight: TQuantity): TC2MatrixQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator * (const ALeft: TQuantity; const ARight: TC3Matrix): TC3MatrixQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator * (const ALeft: TC3Matrix; const ARight: TQuantity): TC3MatrixQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator * (const ALeft: TQuantity; const ARight: TC4Matrix): TC4MatrixQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator * (const ALeft: TC4Matrix; const ARight: TQuantity): TC4MatrixQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;
{$ENDIF}

// Power and root functions

function SquarePower(const AValue: TComplex): TComplex;
begin
  result := AValue*AValue;
end;

function CubicPower(const AValue: TComplex): TComplex;
begin
  result := AValue*AValue*AValue;
end;

function QuarticPower(const AValue: TComplex): TComplex;
begin
  result := AValue*AValue*AValue*AValue;
end;

function SquareRoot(const AValue: TComplex): TC2ArrayOfComplex;
var
  norm: double;
begin
  norm := hypot(AValue.fRe, AValue.fIm);
  result[1].fRe := sqrt(0.5*(norm + AValue.fRe));
  if AValue.fIm >= 0 then
    result[1].fIm := sqrt(0.5*(norm - AValue.fRe))
  else
    result[1].fIm := -sqrt(0.5*(norm - AValue.fRe));
  result[2] := -result[1];
end;

function CubicRoot(const AValue: TComplex): TC3ArrayOfComplex;
const
  i: TImaginaryUnit = ();
var
  theta, rootModulus, rootArgument: double;
begin
  rootModulus := Power(AValue.Norm, 1/3);
  theta := Math.ArcTan2(AValue.fIm, AValue.fRe);

  rootArgument := (theta)/3;
  result[1] := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);

  rootArgument := (theta+2*Pi)/3;
  result[2] := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);

  rootArgument := (theta+4*Pi)/3;
  result[3] := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);
end;

function QuarticRoot(const AValue: TComplex): TC4ArrayOfComplex;
const
  i: TImaginaryUnit = ();
var
  theta, rootModulus, rootArgument: double;
begin
  rootModulus := Power(AValue.Norm, 1/4);
  theta := Math.ArcTan2(AValue.fIm, AValue.fRe);

  rootArgument := (theta)/4;
  result[1] := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);

  rootArgument := (theta+2*Pi)/4;
  result[2] := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);

  rootArgument := (theta+4*Pi)/4;
  result[3] := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);

  rootArgument := (theta+6*Pi)/4;
  result[4] := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);
end;

{$IFNDEF ADIMOFF}
function SquarePower(const AQuantity: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := 2 * AQuantity.FDim;
  result.FValue := AQuantity.FValue*AQuantity.FValue;
end;

function CubicPower(const AQuantity: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := 3 * AQuantity.FDim;
  result.FValue := AQuantity.FValue*AQuantity.FValue*AQuantity.FValue;
end;

function QuarticPower(const AQuantity: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := 4 * AQuantity.FDim;
  result.FValue := AQuantity.FValue*AQuantity.FValue*AQuantity.FValue*AQuantity.FValue;
end;
{$ENDIF}

// Usefull routines

function ToComplex(const AValue: double): TComplex;
begin
  result.FRe := AValue;
  result.FIm := 0;
end;

function Abs(const AValue: double): double;
begin
  result := System.Abs(AValue);
end;

function Abs(const AValue: TComplex): double;
begin
  result := AValue.Norm;
end;

function Commutator(const ALeft, ARight: TC2Matrix): TC2Matrix;
begin
  result := ALeft*ARight - ARight*ALeft;
end;

function Commutator(const ALeft, ARight: TC3Matrix): TC3Matrix;
begin
  result := ALeft*ARight - ARight*ALeft;
end;

function Commutator(const ALeft, ARight: TC4Matrix): TC4Matrix;
begin
  result := ALeft*ARight - ARight*ALeft;
end;

function SameValueEx(const AValue1, AValue2: double): boolean;
begin
  result := Math.SameValue(AValue1, AValue2, DefaultEpsilon);
end;

{$IFNDEF ADIMOFF}
function SameValueEx(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := SameValueEx(ALeft.FValue, ARight.FValue);
end;
{$ENDIF}

function SameValueEx(const AValue1, AValue2: TComplex): boolean;
begin
  result := SameValueEx(AValue1.fRe, AValue2.fRe) and
            SameValueEx(AValue1.fIm, AValue2.fIm);
end;

function SameValueEx(const AValue1, AValue2: TC2Vector): boolean;
begin
  result := SameValueEx(AValue1.fm[1], AValue2.fm[1]) and
            SameValueEx(AValue1.fm[2], AValue2.fm[2]);
end;

function SameValueEx(const AValue1, AValue2: TC3Vector): boolean;
begin
  result := SameValueEx(AValue1.fm[1], AValue2.fm[1]) and
            SameValueEx(AValue1.fm[2], AValue2.fm[2]) and
            SameValueEx(AValue1.fm[3], AValue2.fm[3]);
end;

function SameValueEx(const AValue1, AValue2: TC4Vector): boolean;
begin
  result := SameValueEx(AValue1.fm[1], AValue2.fm[1]) and
            SameValueEx(AValue1.fm[2], AValue2.fm[2]) and
            SameValueEx(AValue1.fm[3], AValue2.fm[3]) and
            SameValueEx(AValue1.fm[4], AValue2.fm[4]);
end;

function SameValueEx(const AValue1, AValue2: TC2Matrix): boolean;
begin
  result := SameValueEx(AValue1.fm[1,1], AValue2.fm[1,1]) and
            SameValueEx(AValue1.fm[1,2], AValue2.fm[1,2]) and

            SameValueEx(AValue1.fm[2,1], AValue2.fm[2,1]) and
            SameValueEx(AValue1.fm[2,2], AValue2.fm[2,2]);
end;

function SameValueEx(const AValue1, AValue2: TC3Matrix): boolean;
begin
  result := SameValueEx(AValue1.fm[1,1], AValue2.fm[1,1]) and
            SameValueEx(AValue1.fm[1,2], AValue2.fm[1,2]) and
            SameValueEx(AValue1.fm[1,3], AValue2.fm[1,3]) and

            SameValueEx(AValue1.fm[2,1], AValue2.fm[2,1]) and
            SameValueEx(AValue1.fm[2,2], AValue2.fm[2,2]) and
            SameValueEx(AValue1.fm[2,3], AValue2.fm[2,3]) and

            SameValueEx(AValue1.fm[3,1], AValue2.fm[3,1]) and
            SameValueEx(AValue1.fm[3,2], AValue2.fm[3,2]) and
            SameValueEx(AValue1.fm[3,3], AValue2.fm[3,3]);
end;

function SameValueEx(const AValue1, AValue2: TC4Matrix): boolean;
begin
  result := SameValueEx(AValue1.fm[1,1], AValue2.fm[1,1]) and
            SameValueEx(AValue1.fm[1,2], AValue2.fm[1,2]) and
            SameValueEx(AValue1.fm[1,3], AValue2.fm[1,3]) and
            SameValueEx(AValue1.fm[1,4], AValue2.fm[1,4]) and

            SameValueEx(AValue1.fm[2,1], AValue2.fm[2,1]) and
            SameValueEx(AValue1.fm[2,2], AValue2.fm[2,2]) and
            SameValueEx(AValue1.fm[2,3], AValue2.fm[2,3]) and
            SameValueEx(AValue1.fm[2,4], AValue2.fm[2,4]) and

            SameValueEx(AValue1.fm[3,1], AValue2.fm[3,1]) and
            SameValueEx(AValue1.fm[3,2], AValue2.fm[3,2]) and
            SameValueEx(AValue1.fm[3,3], AValue2.fm[3,3]) and
            SameValueEx(AValue1.fm[3,4], AValue2.fm[3,4]) and

            SameValueEx(AValue1.fm[4,1], AValue2.fm[4,1]) and
            SameValueEx(AValue1.fm[4,2], AValue2.fm[4,2]) and
            SameValueEx(AValue1.fm[4,3], AValue2.fm[4,3]) and
            SameValueEx(AValue1.fm[4,4], AValue2.fm[4,4]);
end;

// Solvers for linear, quadratic, cubic and quartic equation

function SolveEquation(const a: double): double;
begin
  result := -a;
end;

function SolveEquation(const a: TComplex): TComplex;
begin
  result := -a;
end;

function SolveEquation(const a, b: TComplex): TC2ArrayOfComplex;
var
  delta: TComplex;
begin
  delta := SquareRoot(SquarePower(a) - 4*b)[1];
  result[1] := (-a + delta)/2;
  result[2] := (-a - delta)/2;
end;

function SolveEquation(const a, b, c: TComplex): TC3ArrayOfComplex;
var
  p, q, s1, t: TComplex;

  u: TC3ArrayOfComplex;
  v: TC2ArrayOfComplex;
begin
  p := 9*b -3*SquarePower(a);
  q := 27*c -9*a*b +2*CubicPower(a);

  if p.IsNotNull and q.IsNotNull then
  begin
    s1 := -q/2 + SquareRoot(SquarePower(q)/4 + CubicPower(p)/27)[1];
  //s2 := -q/2 - SquareRoot(SquarePower(q)/4 + CubicPower(p)/27)[2];
    u := CubicRoot(s1);
    t := u[1] - p/(3*u[1]); result[1] := (t - a)/3;
    t := u[2] - p/(3*u[2]); result[2] := (t - a)/3;
    t := u[3] - p/(3*u[3]); result[3] := (t - a)/3;
  end else
    if p.IsNull and q.IsNull then
    begin
      result[1] := -a/3;
      result[2] := -a/3;
      result[3] := -a/3;
    end else
      if q.IsNull then
      begin
        v := SquareRoot(p);
        result[1] := 0;
        result[2] := v[1];
        result[3] := v[2];
      end else
      begin
        u := CubicRoot(q);
        result[1] := u[1];
        result[2] := u[2];
        result[3] := u[3];
      end;
end;

function SolveEquation(const a, b, c, d: TComplex): TC4ArrayOfComplex;
var
  p, q, r: TComplex;
  u1, u2, u3: TC2ArrayOfComplex;
  v1: TC3ArrayOfComplex;
  v2, v3: TC2ArrayOfComplex;

  alpha: TComplex;
  beta: TComplex;
  gamma: Tcomplex;
begin
  p := 16*b -6*SquarePower(a);
  q := 64*c -32*a*b +8*CubicPower(a);
  r := 256*d -64*a*c +16*b*SquarePower(a) -3*QuarticPower(a);

  if q.IsNull then
  begin
    u1 := SolveEquation(p, r);
    u2 := SquareRoot(u1[1]);
    u3 := SquareRoot(u1[2]);

    result[1] := (u2[1] -a)/4;
    result[2] := (u2[2] -a)/4;
    result[3] := (u3[1] -a)/4;
    result[4] := (u3[2] -a)/4;
  end else
  begin
    v1 := SolveEquation(2*p, SquarePower(p)-4*r, -SquarePower(q));

    alpha := SquareRoot(v1[1])[1];
    beta  := ((alpha*alpha*alpha)+p*alpha-q)/(2*alpha);
    gamma := ((alpha*alpha*alpha)+p*alpha+q)/(2*alpha);

    v2 := SolveEquation( alpha,  beta);
    v3 := SolveEquation(-alpha, gamma);

    result[1] := (v2[1] -a)/4;
    result[2] := (v2[2] -a)/4;
    result[3] := (v3[1] -a)/4;
    result[4] := (v3[2] -a)/4;
  end;
end;

// Internal check routines

{$IFNDEF ADIMOFF}
  {$ASSERTIONS ON}
{$ENDIF}

procedure Check(ALeft, ARight: TDimension);
begin
  Assert(ALeft = ARight, Format('Wrong units of measurement detected, %s expected but %s found', [ALeft.ToString, ARight.ToString]));
end;

function CheckEqual(ALeft, ARight: TDimension): TDimension;
begin
  Assert(ALeft = ARight, Format('Wrong units of measurement detected, %s expected but %s found', [ALeft.ToString, ARight.ToString]));
  result := ALeft;
end;

function CheckSum(ALeft, ARight: TDimension): TDimension;
begin
  Assert(ALeft = ARight, Format('Wrong units of measurement detected, %s expected but %s found', [ALeft.ToString, ARight.ToString]));
  result := ALeft;
end;

function CheckSub(ALeft, ARight: TDimension): TDimension;
begin
  Assert(ALeft = ARight, Format('Wrong units of measurement detected, "%s" expected but "%s" found', [ALeft.ToString, ARight.ToString]));
  result := ALeft;
end;

function CheckMul(ALeft, ARight: TDimension): TDimension;
begin
  result := ALeft + ARight;
end;

function CheckDiv(ALeft, ARight: TDimension): TDimension;
begin
  result := ALeft - ARight;
end;

// TUnit

class operator TUnit.*(const AValue: double; const ASelf: TUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: double; const ASelf: TUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit.*(const AValue: TComplex; const ASelf: TUnit): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckMul(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TComplex; const ASelf: TUnit): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit.*(const AVector: TR2Vector; const ASelf: TUnit): TR2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit.*(const AVector: TR3Vector; const ASelf: TUnit): TR3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit.*(const AVector: TR4Vector; const ASelf: TUnit): TR4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TR2Vector; const ASelf: TUnit): TR2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TR3Vector; const ASelf: TUnit): TR3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TR4Vector; const ASelf: TUnit): TR4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit.*(const AVector: TC2Vector; const ASelf: TUnit): TC2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit.*(const AVector: TC3Vector; const ASelf: TUnit): TC3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit.*(const AVector: TC4Vector; const ASelf: TUnit): TC4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TC2Vector; const ASelf: TUnit): TC2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TC3Vector; const ASelf: TUnit): TC3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TC4Vector; const ASelf: TUnit): TC4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit.*(const AMatrix: TR2Matrix; const ASelf: TUnit): TR2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit.*(const AMatrix: TR3Matrix; const ASelf: TUnit): TR3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit.*(const AMatrix: TR4Matrix; const ASelf: TUnit): TR4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit./(const AMatrix: TR2Matrix; const ASelf: TUnit): TR2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit./(const AMatrix: TR3Matrix; const ASelf: TUnit): TR3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit./(const AMatrix: TR4Matrix; const ASelf: TUnit): TR4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit.*(const AMatrix: TC2Matrix; const ASelf: TUnit): TC2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit.*(const AMatrix: TC3Matrix; const ASelf: TUnit): TC3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit.*(const AMatrix: TC4Matrix; const ASelf: TUnit): TC4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit./(const AMatrix: TC2Matrix; const ASelf: TUnit): TC2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit./(const AMatrix: TC3Matrix; const ASelf: TUnit): TC3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit./(const AMatrix: TC4Matrix; const ASelf: TUnit): TC4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit.*(const AVector: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit.*(const ABivector: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := ABivector;
{$ELSE}
  result := ABivector;
{$ENDIF}
end;

class operator TUnit./(const ABivector: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := ABivector;
{$ELSE}
  result := ABivector;
{$ENDIF}
end;

class operator TUnit.*(const ATrivector: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := ATrivector;
{$ELSE}
  result := ATrivector;
{$ENDIF}
end;

class operator TUnit./(const ATrivector: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := ATrivector;
{$ELSE}
  result := ATrivector;
{$ENDIF}
end;

class operator TUnit.*(const AMultivector: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMultivector;
{$ELSE}
  result := AMultivector;
{$ENDIF}
end;

class operator TUnit./(const AMultivector: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMultivector;
{$ELSE}
  result := AMultivector;
{$ENDIF}
end;

{$IFNDEF ADIMOFF}

class operator TUnit.*(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TQuantity; const ASelf: TUnit): TQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckMul(ASelf.FDim, AQuantity.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckDiv(ASelf.FDim, AQuantity.FDim);
  result.FValue := AQuantity.FValue.Reciprocal;
end;

class operator TUnit.*(const AQuantity: TR2VecQuantity; const ASelf: TUnit): TR2VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TR3VecQuantity; const ASelf: TUnit): TR3VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TR4VecQuantity; const ASelf: TUnit): TR4VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TR2VecQuantity; const ASelf: TUnit): TR2VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TR3VecQuantity; const ASelf: TUnit): TR3VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TR4VecQuantity; const ASelf: TUnit): TR4VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TC2VecQuantity; const ASelf: TUnit): TC2VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TC3VecQuantity; const ASelf: TUnit): TC3VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TC4VecQuantity; const ASelf: TUnit): TC4VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TC2VecQuantity; const ASelf: TUnit): TC2VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TC3VecQuantity; const ASelf: TUnit): TC3VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TC4VecQuantity; const ASelf: TUnit): TC4VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TR2MatrixQuantity; const ASelf: TUnit): TR2MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TR3MatrixQuantity; const ASelf: TUnit): TR3MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TR4MatrixQuantity; const ASelf: TUnit): TR4MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TR2MatrixQuantity; const ASelf: TUnit): TR2MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TR3MatrixQuantity; const ASelf: TUnit): TR3MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TR4MatrixQuantity; const ASelf: TUnit): TR4MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TC2MatrixQuantity; const ASelf: TUnit): TC2MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TC3MatrixQuantity; const ASelf: TUnit): TC3MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TC4MatrixQuantity; const ASelf: TUnit): TC4MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TC2MatrixQuantity; const ASelf: TUnit): TC2MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TC3MatrixQuantity; const ASelf: TUnit): TC3MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TC4MatrixQuantity; const ASelf: TUnit): TC4MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;
{$ENDIF}

// TFactoredUnit

class operator TFactoredUnit.*(const AValue: double; const ASelf: TFactoredUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue * ASelf.FFactor;
{$ELSE}
  result := AValue * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AValue: double; const ASelf: TFactoredUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue / ASelf.FFactor;
{$ELSE}
  result := AValue / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AValue: TComplex; const ASelf: TFactoredUnit): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckMul(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue * ASelf.FFactor;
{$ELSE}
  result := AValue * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AValue: TComplex; const ASelf: TFactoredUnit): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue / ASelf.FFactor;
{$ELSE}
  result := AValue / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AVector: TR2Vector; const ASelf: TFactoredUnit): TR2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector * ASelf.FFactor;
{$ELSE}
  result := AVector * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AVector: TR3Vector; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector * ASelf.FFactor;
{$ELSE}
  result := AVector * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AVector: TR4Vector; const ASelf: TFactoredUnit): TR4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector * ASelf.FFactor;
{$ELSE}
  result := AVector * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AVector: TR2Vector; const ASelf: TFactoredUnit): TR2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector / ASelf.FFactor;
{$ELSE}
  result := AVector / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AVector: TR3Vector; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector / ASelf.FFactor;
{$ELSE}
  result := AVector / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AVector: TR4Vector; const ASelf: TFactoredUnit): TR4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector / ASelf.FFactor;
{$ELSE}
  result := AVector / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AVector: TC2Vector; const ASelf: TFactoredUnit): TC2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector * ASelf.FFactor;
{$ELSE}
  result := AVector * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AVector: TC3Vector; const ASelf: TFactoredUnit): TC3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector * ASelf.FFactor;
{$ELSE}
  result := AVector * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AVector: TC4Vector; const ASelf: TFactoredUnit): TC4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector * ASelf.FFactor;
{$ELSE}
  result := AVector * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AVector: TC2Vector; const ASelf: TFactoredUnit): TC2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector / ASelf.FFactor;
{$ELSE}
  result := AVector / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AVector: TC3Vector; const ASelf: TFactoredUnit): TC3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector / ASelf.FFactor;
{$ELSE}
  result := AVector / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AVector: TC4Vector; const ASelf: TFactoredUnit): TC4VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector / ASelf.FFactor;
{$ELSE}
  result := AVector / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AMatrix: TR2Matrix; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix * ASelf.FFactor;
{$ELSE}
  result := AMatrix * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AMatrix: TR3Matrix; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix * ASelf.FFactor;
{$ELSE}
  result := AMatrix * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AMatrix: TR4Matrix; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix * ASelf.FFactor;
{$ELSE}
  result := AMatrix * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AMatrix: TR2Matrix; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix / ASelf.FFactor;
{$ELSE}
  result := AMatrix / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AMatrix: TR3Matrix; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix / ASelf.FFactor;
{$ELSE}
  result := AMatrix / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AMatrix: TR4Matrix; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix / ASelf.FFactor;
{$ELSE}
  result := AMatrix / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AMatrix: TC2Matrix; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix * ASelf.FFactor;
{$ELSE}
  result := AMatrix * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AMatrix: TC3Matrix; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix * ASelf.FFactor;
{$ELSE}
  result := AMatrix * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AMatrix: TC4Matrix; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix * ASelf.FFactor;
{$ELSE}
  result := AMatrix * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AMatrix: TC2Matrix; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix / ASelf.FFactor;
{$ELSE}
  result := AMatrix / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AMatrix: TC3Matrix; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix / ASelf.FFactor;
{$ELSE}
  result := AMatrix / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AMatrix: TC4Matrix; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix / ASelf.FFactor;
{$ELSE}
  result := AMatrix / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

{$IFNDEF ADIMOFF}

class operator TFactoredUnit.*(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TComplexQuantity; const ASelf: TFactoredUnit): TComplexQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TComplexQuantity; const ASelf: TFactoredUnit): TComplexQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TR2VecQuantity; const ASelf: TFactoredUnit): TR2VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TR2VecQuantity; const ASelf: TFactoredUnit): TR2VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TR3VecQuantity; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TR3VecQuantity; const ASelf: TFactoredUnit): TR3VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TR4VecQuantity; const ASelf: TFactoredUnit): TR4VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TR4VecQuantity; const ASelf: TFactoredUnit): TR4VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TC2VecQuantity; const ASelf: TFactoredUnit): TC2VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TC2VecQuantity; const ASelf: TFactoredUnit): TC2VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TC3VecQuantity; const ASelf: TFactoredUnit): TC3VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TC3VecQuantity; const ASelf: TFactoredUnit): TC3VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TC4VecQuantity; const ASelf: TFactoredUnit): TC4VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TC4VecQuantity; const ASelf: TFactoredUnit): TC4VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TR2MatrixQuantity; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TR2MatrixQuantity; const ASelf: TFactoredUnit): TR2MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TR3MatrixQuantity; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TR3MatrixQuantity; const ASelf: TFactoredUnit): TR3MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TR4MatrixQuantity; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TR4MatrixQuantity; const ASelf: TFactoredUnit): TR4MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TC2MatrixQuantity; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TC2MatrixQuantity; const ASelf: TFactoredUnit): TC2MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TC3MatrixQuantity; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TC3MatrixQuantity; const ASelf: TFactoredUnit): TC3MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TC4MatrixQuantity; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TC4MatrixQuantity; const ASelf: TFactoredUnit): TC4MatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

{$ENDIF}

// TDegreeCelsiusUnit

class operator TDegreeCelsiusUnit.*(const AValue: double; const ASelf: TDegreeCelsiusUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue + 273.15;
{$ELSE}
  result := AValue + 273.15;
{$ENDIF}
end;

// TDegreeFahrenheitUnit

class operator TDegreeFahrenheitUnit.*(const AValue: double; const ASelf: TDegreeFahrenheitUnit): TQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := 5/9 * (AValue - 32) + 273.15;
{$ELSE}
  result := 5/9 * (AValue - 32) + 273.15;
{$ENDIF}
end;

// TUnitHelper

function TUnitHelper.GetName(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0: result := FName;
    1: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name]);
    2: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name]);
    3: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name]);
    4: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name]);
    5: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name,
         PrefixTable[Prefixes[4]].Name]);
    6: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name,
         PrefixTable[Prefixes[4]].Name,
         PrefixTable[Prefixes[5]].Name]);
    7: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name,
         PrefixTable[Prefixes[4]].Name,
         PrefixTable[Prefixes[5]].Name,
         PrefixTable[Prefixes[6]].Name]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TUnitHelper.GetPluralName(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0: result := FPluralName;
    1: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name]);
    2: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name]);
    3: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name]);
    4: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name]);
    5: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name,
         PrefixTable[Prefixes[4]].Name]);
    6: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name,
         PrefixTable[Prefixes[4]].Name,
         PrefixTable[Prefixes[5]].Name]);
    7: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name,
         PrefixTable[Prefixes[4]].Name,
         PrefixTable[Prefixes[5]].Name,
         PrefixTable[Prefixes[6]].Name]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TUnitHelper.GetSymbol(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0: result := FSymbol;
    1: result := Format(FSymbol, [
         PrefixTable[Prefixes[0]].Symbol]);
    2: result := Format(FSymbol, [
         PrefixTable[Prefixes[0]].Symbol,
         PrefixTable[Prefixes[1]].Symbol]);
    3: result := Format(FSymbol, [
         PrefixTable[Prefixes[0]].Symbol,
         PrefixTable[Prefixes[1]].Symbol,
         PrefixTable[Prefixes[2]].Symbol]);
    4: result := Format(FSymbol, [
         PrefixTable[Prefixes[0]].Symbol,
         PrefixTable[Prefixes[1]].Symbol,
         PrefixTable[Prefixes[2]].Symbol,
         PrefixTable[Prefixes[3]].Symbol]);
    5: result := Format(FSymbol, [
         PrefixTable[Prefixes[0]].Symbol,
         PrefixTable[Prefixes[1]].Symbol,
         PrefixTable[Prefixes[2]].Symbol,
         PrefixTable[Prefixes[3]].Symbol,
         PrefixTable[Prefixes[4]].Symbol]);
    6: result := Format(FSymbol, [
         PrefixTable[Prefixes[0]].Symbol,
         PrefixTable[Prefixes[1]].Symbol,
         PrefixTable[Prefixes[2]].Symbol,
         PrefixTable[Prefixes[3]].Symbol,
         PrefixTable[Prefixes[4]].Symbol,
         PrefixTable[Prefixes[5]].Symbol]);
    7: result := Format(FSymbol, [
         PrefixTable[Prefixes[0]].Symbol,
         PrefixTable[Prefixes[1]].Symbol,
         PrefixTable[Prefixes[2]].Symbol,
         PrefixTable[Prefixes[3]].Symbol,
         PrefixTable[Prefixes[4]].Symbol,
         PrefixTable[Prefixes[5]].Symbol,
         PrefixTable[Prefixes[6]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TUnitHelper.GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
var
  I: longint;
  Exponent: longint;
  PrefixCount: longint;
begin
  PrefixCount := Length(APrefixes);
  if PrefixCount = Length(FPrefixes) then
  begin
    Exponent := 0;
    for I := 0 to PrefixCount -1 do
      Inc(Exponent, PrefixTable[FPrefixes[I]].Exponent * FExponents[I]);

    for I := 0 to PrefixCount -1 do
      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * FExponents[I]);

    if Exponent <> 0 then
      result := AQuantity * IntPower(10, Exponent)
    else
      result := AQuantity;

  end else
    if PrefixCount = 0 then
      result := AQuantity
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

function TUnitHelper.GetValue(const AQuantity: TComplex; const APrefixes: TPrefixes): TComplex;
begin
  result.fRe := GetValue(AQuantity.fRe, APrefixes);
  result.fIm := GetValue(AQuantity.fIm, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TR2Vector; const APrefixes: TPrefixes): TR2Vector;
begin
  result[1] := GetValue(AQuantity[1], APrefixes);
  result[2] := GetValue(AQuantity[2], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TR3Vector; const APrefixes: TPrefixes): TR3Vector;
begin
  result[1] := GetValue(AQuantity[1], APrefixes);
  result[2] := GetValue(AQuantity[2], APrefixes);
  result[3] := GetValue(AQuantity[3], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TR4Vector; const APrefixes: TPrefixes): TR4Vector;
begin
  result[1] := GetValue(AQuantity[1], APrefixes);
  result[2] := GetValue(AQuantity[2], APrefixes);
  result[3] := GetValue(AQuantity[3], APrefixes);
  result[4] := GetValue(AQuantity[4], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TC2Vector; const APrefixes: TPrefixes): TC2Vector;
begin
  result[1] := GetValue(AQuantity[1], APrefixes);
  result[2] := GetValue(AQuantity[2], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TC3Vector; const APrefixes: TPrefixes): TC3Vector;
begin
  result[1] := GetValue(AQuantity[1], APrefixes);
  result[2] := GetValue(AQuantity[2], APrefixes);
  result[3] := GetValue(AQuantity[3], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TC4Vector; const APrefixes: TPrefixes): TC4Vector;
begin
  result[1] := GetValue(AQuantity[1], APrefixes);
  result[2] := GetValue(AQuantity[2], APrefixes);
  result[3] := GetValue(AQuantity[3], APrefixes);
  result[4] := GetValue(AQuantity[4], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TR2Matrix; const APrefixes: TPrefixes): TR2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TR3Matrix; const APrefixes: TPrefixes): TR3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TR4Matrix; const APrefixes: TPrefixes): TR4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TC2Matrix; const APrefixes: TPrefixes): TC2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TC3Matrix; const APrefixes: TPrefixes): TC3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TC4Matrix; const APrefixes: TPrefixes): TC4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL3Vector; const APrefixes: TPrefixes): TCL3Vector;
begin
  result.fm1 := GetValue(AQuantity.fm1, APrefixes);
  result.fm2 := GetValue(AQuantity.fm2, APrefixes);
  result.fm3 := GetValue(AQuantity.fm3, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL3Bivector; const APrefixes: TPrefixes): TCL3Bivector;
begin
  result.fm12 := GetValue(AQuantity.fm12, APrefixes);
  result.fm13 := GetValue(AQuantity.fm13, APrefixes);
  result.fm23 := GetValue(AQuantity.fm23, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL3Trivector; const APrefixes: TPrefixes): TCL3Trivector;
begin
  result.fm123 := GetValue(AQuantity.fm123, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL3Multivector; const APrefixes: TPrefixes): TCL3Multivector;
begin
  result.fm0 := GetValue(AQuantity.fm0, APrefixes);
  result.fm1 := GetValue(AQuantity.fm1, APrefixes);
  result.fm2 := GetValue(AQuantity.fm2, APrefixes);
  result.fm3 := GetValue(AQuantity.fm3, APrefixes);
  result.fm12 := GetValue(AQuantity.fm12, APrefixes);
  result.fm13 := GetValue(AQuantity.fm13, APrefixes);
  result.fm23 := GetValue(AQuantity.fm23, APrefixes);
  result.fm123 := GetValue(AQuantity.fm123, APrefixes);
end;

function TUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := FloatToStr(AQuantity.FValue) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;

function TUnitHelper.ToVerboseString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  if (AQuantity.FValue > -1) and (AQuantity.FValue < 1) then
    result := FloatToStr(AQuantity.FValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(AQuantity.FValue) + ' ' + GetPluralName(FPrefixes);
{$ELSE}
  if (AQuantity > -1) and (AQuantity < 1) then
    result := FloatToStr(AQuantity) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(AQuantity) + ' ' + GetPluralName(FPrefixes);
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(FPRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPRefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(APRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TUnitHelper.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(FPRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(FPRefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(APRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TUnitHelper.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

function TUnitHelper.ToComplex(const AQuantity: TComplexQuantity): TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToComplex(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TComplexQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TComplexQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TComplexQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetPluralName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPRefixes)
  else
    result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TComplexQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(FPrefixes)
  else
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVector(const AQuantity: TR2VecQuantity): TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TR3VecQuantity): TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TR4VecQuantity): TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR2VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR4VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR2VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR4VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVector(const AQuantity: TC2VecQuantity): TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TC3VecQuantity): TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TC4VecQuantity): TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC2VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC4VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC2VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC4VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToMatrix(const AQuantity: TR2MatrixQuantity): TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TR3MatrixQuantity): TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TR4MatrixQuantity): TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR2MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR3MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR4MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue : TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue : TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue : TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR2MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR3MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR4MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToMatrix(const AQuantity: TC2MatrixQuantity): TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TC3MatrixQuantity): TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TC4MatrixQuantity): TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC2MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC3MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC4MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue : TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue : TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue : TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC2MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC3MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC4MatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPRefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APRefixes);
end;

function TUnitHelper.ToString(const AQuantity: TCL3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3BivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3TrivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3MultivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TUnitHelper.ToString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TUnitHelper.ToString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TUnitHelper.ToString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetPluralName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3BivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetPluralName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetPluralName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetPluralName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

// TFactoredUnitHelper

function TFactoredUnitHelper.GetName(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0: result := FName;
    1: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name]);
    2: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name]);
    3: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name]);
    4: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name]);
    5: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name,
         PrefixTable[Prefixes[4]].Name]);
    6: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name,
         PrefixTable[Prefixes[4]].Name,
         PrefixTable[Prefixes[5]].Name]);
    7: result := Format(FName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name,
         PrefixTable[Prefixes[4]].Name,
         PrefixTable[Prefixes[5]].Name,
         PrefixTable[Prefixes[6]].Name]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TFactoredUnitHelper.GetPluralName(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0: result := FPluralName;
    1: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name]);
    2: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name]);
    3: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name]);
    4: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name]);
    5: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name,
         PrefixTable[Prefixes[4]].Name]);
    6: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name,
         PrefixTable[Prefixes[4]].Name,
         PrefixTable[Prefixes[5]].Name]);
    7: result := Format(FPluralName, [
         PrefixTable[Prefixes[0]].Name,
         PrefixTable[Prefixes[1]].Name,
         PrefixTable[Prefixes[2]].Name,
         PrefixTable[Prefixes[3]].Name,
         PrefixTable[Prefixes[4]].Name,
         PrefixTable[Prefixes[5]].Name,
         PrefixTable[Prefixes[6]].Name]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TFactoredUnitHelper.GetSymbol(Prefixes: TPrefixes): string;
begin
  if Length(Prefixes) = 0 then
  begin
    Prefixes := FPrefixes;
  end else
    if Length(Prefixes) <> Length(FPrefixes) then
      raise Exception.Create('Wrong number of prefixes.');

  case Length(Prefixes) of
    0: result := FSymbol;
    1: result := Format(FSymbol, [
         PrefixTable[Prefixes[0]].Symbol]);
    2: result := Format(FSymbol, [
         PrefixTable[Prefixes[0]].Symbol,
         PrefixTable[Prefixes[1]].Symbol]);
    3: result := Format(FSymbol, [
         PrefixTable[Prefixes[0]].Symbol,
         PrefixTable[Prefixes[1]].Symbol,
         PrefixTable[Prefixes[2]].Symbol]);
    4: result := Format(FSymbol, [
         PrefixTable[Prefixes[0]].Symbol,
         PrefixTable[Prefixes[1]].Symbol,
         PrefixTable[Prefixes[2]].Symbol,
         PrefixTable[Prefixes[3]].Symbol]);
    5: result := Format(FSymbol, [
         PrefixTable[Prefixes[0]].Symbol,
         PrefixTable[Prefixes[1]].Symbol,
         PrefixTable[Prefixes[2]].Symbol,
         PrefixTable[Prefixes[3]].Symbol,
         PrefixTable[Prefixes[4]].Symbol]);
    6: result := Format(FSymbol, [
         PrefixTable[Prefixes[0]].Symbol,
         PrefixTable[Prefixes[1]].Symbol,
         PrefixTable[Prefixes[2]].Symbol,
         PrefixTable[Prefixes[3]].Symbol,
         PrefixTable[Prefixes[4]].Symbol,
         PrefixTable[Prefixes[5]].Symbol]);
    7: result := Format(FSymbol, [
         PrefixTable[Prefixes[0]].Symbol,
         PrefixTable[Prefixes[1]].Symbol,
         PrefixTable[Prefixes[2]].Symbol,
         PrefixTable[Prefixes[3]].Symbol,
         PrefixTable[Prefixes[4]].Symbol,
         PrefixTable[Prefixes[5]].Symbol,
         PrefixTable[Prefixes[6]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TFactoredUnitHelper.GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
var
  I: longint;
  Exponent: longint;
  PrefixCount: longint;
begin
  PrefixCount := Length(APrefixes);
  if PrefixCount = Length(FPrefixes) then
  begin
    Exponent := 0;
    for I := 0 to PrefixCount -1 do
      Inc(Exponent, PrefixTable[FPrefixes[I]].Exponent * FExponents[I]);

    for I := 0 to PrefixCount -1 do
      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * FExponents[I]);

    if Exponent <> 0 then
      result := AQuantity * IntPower(10, Exponent)
    else
      result := AQuantity;

  end else
    if PrefixCount = 0 then
      result := AQuantity
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TComplex; const APrefixes: TPrefixes): TComplex;
begin
  result.FRe := GetValue(AQuantity.FRe, APrefixes);
  result.FIm := GetValue(AQuantity.FIm, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TR2Vector; const APrefixes: TPrefixes): TR2Vector;
var
  i: longint;
begin
  for i := 1 to 2 do
    result[i] := GetValue(AQuantity[i], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TR3Vector; const APrefixes: TPrefixes): TR3Vector;
var
  i: longint;
begin
  for i := 1 to 3 do
    result[i] := GetValue(AQuantity[i], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TR4Vector; const APrefixes: TPrefixes): TR4Vector;
var
  i: longint;
begin
  for i := 1 to 4 do
    result[i] := GetValue(AQuantity[i], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TC2Vector; const APrefixes: TPrefixes): TC2Vector;
var
  i: longint;
begin
  for i := 1 to 2 do
    result[i] := GetValue(AQuantity[i], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TC3Vector; const APrefixes: TPrefixes): TC3Vector;
var
  i: longint;
begin
  for i := 1 to 3 do
    result[i] := GetValue(AQuantity[i], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TC4Vector; const APrefixes: TPrefixes): TC4Vector;
var
  i: longint;
begin
  for i := 1 to 4 do
    result[i] := GetValue(AQuantity[i], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TR2Matrix; const APrefixes: TPrefixes): TR2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TR3Matrix; const APrefixes: TPrefixes): TR3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TR4Matrix; const APrefixes: TPrefixes): TR4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TC2Matrix; const APrefixes: TPrefixes): TC2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TC3Matrix; const APrefixes: TPrefixes): TC3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TC4Matrix; const APrefixes: TPrefixes): TC4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
      result[i,j] := GetValue(AQuantity[i,j], APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL3Vector; const APrefixes: TPrefixes): TCL3Vector;
begin
  result.fm1 := GetValue(AQuantity.fm1, APrefixes);
  result.fm2 := GetValue(AQuantity.fm2, APrefixes);
  result.fm3 := GetValue(AQuantity.fm3, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL3Bivector; const APrefixes: TPrefixes): TCL3Bivector;
begin
  result.fm12 := GetValue(AQuantity.fm12, APrefixes);
  result.fm13 := GetValue(AQuantity.fm13, APrefixes);
  result.fm23 := GetValue(AQuantity.fm23, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL3Trivector; const APrefixes: TPrefixes): TCL3Trivector;
begin
  result.fm123 := GetValue(AQuantity.fm123, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL3Multivector; const APrefixes: TPrefixes): TCL3Multivector;
begin
  result.fm0 := GetValue(AQuantity.fm0, APrefixes);
  result.fm1 := GetValue(AQuantity.fm1, APrefixes);
  result.fm2 := GetValue(AQuantity.fm2, APrefixes);
  result.fm3 := GetValue(AQuantity.fm3, APrefixes);
  result.fm12 := GetValue(AQuantity.fm12, APrefixes);
  result.fm13 := GetValue(AQuantity.fm13, APrefixes);
  result.fm23 := GetValue(AQuantity.fm23, APrefixes);
  result.fm123 := GetValue(AQuantity.fm123, APrefixes);
end;

function TFactoredUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := FloatToStr(AQuantity.FValue / FFactor) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity / FFactor) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
   Check(FDim, AQuantity.FDim);
   FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
   FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TQuantity): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(APRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(APRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

function TFactoredUnitHelper.ToComplex(const AQuantity: TComplexQuantity): TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToComplex(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TComplexQuantity): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
  else
    result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TComplexQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(FPrefixes)
  else
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TComplexQuantity): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TComplexQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
  else
    result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TComplexQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplex;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(FPrefixes)
  else
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TR2VecQuantity): TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TR3VecQuantity): TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TR4VecQuantity): TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR2VecQuantity): string;
var
  FactoredValue: TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR3VecQuantity): string;
var
  FactoredValue: TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR4VecQuantity): string;
var
  FactoredValue: TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR2VecQuantity): string;
var
  FactoredValue: TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR3VecQuantity): string;
var
  FactoredValue: TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR4VecQuantity): string;
var
  FactoredValue: TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TC2VecQuantity): TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TC3VecQuantity): TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TC4VecQuantity): TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC2VecQuantity): string;
var
  FactoredValue: TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC3VecQuantity): string;
var
  FactoredValue: TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC4VecQuantity): string;
var
  FactoredValue: TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC2VecQuantity): string;
var
  FactoredValue: TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC3VecQuantity): string;
var
  FactoredValue: TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC4VecQuantity): string;
var
  FactoredValue: TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC4VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC4Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TR2MatrixQuantity): TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TR3MatrixQuantity): TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TR4MatrixQuantity): TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR2MatrixQuantity): string;
var
  FactoredValue: TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR3MatrixQuantity): string;
var
  FactoredValue: TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR4MatrixQuantity): string;
var
  FactoredValue: TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR2MatrixQuantity): string;
var
  FactoredValue: TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR3MatrixQuantity): string;
var
  FactoredValue: TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR4MatrixQuantity): string;
var
  FactoredValue: TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TR4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TR4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TC2MatrixQuantity): TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TC3MatrixQuantity): TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TC4MatrixQuantity): TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC2MatrixQuantity): string;
var
  FactoredValue: TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC3MatrixQuantity): string;
var
  FactoredValue: TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC4MatrixQuantity): string;
var
  FactoredValue: TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC2MatrixQuantity): string;
var
  FactoredValue: TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC3MatrixQuantity): string;
var
  FactoredValue: TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC4MatrixQuantity): string;
var
  FactoredValue: TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC2MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC2Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC3MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC3Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TC4MatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TC4Matrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
  else
    result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3VecQuantity): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3BivecQuantity): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3TrivecQuantity): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3MultivecQuantity): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3VecQuantity): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3BivecQuantity): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

// TDegreeCelsiusUnitHelper

function TDegreeCelsiusUnitHelper.GetName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FName;
    1:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TDegreeCelsiusUnitHelper.GetPluralName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FPluralName;
    1:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TDegreeCelsiusUnitHelper.GetSymbol(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FSymbol;
    1:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TDegreeCelsiusUnitHelper.GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
var
  I: longint;
  Exponent: longint;
  PrefixCount: longint;
begin
  PrefixCount := Length(APrefixes);
  if PrefixCount = Length(FPrefixes) then
  begin
    Exponent := 0;
    for I := 0 to PrefixCount -1 do
      Inc(Exponent, PrefixTable[FPrefixes[I]].Exponent * FExponents[I]);

    for I := 0 to PrefixCount -1 do
      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * FExponents[I]);

    if Exponent <> 0 then
      result := AQuantity * IntPower(10, Exponent)
    else
      result := AQuantity;

  end else
    if PrefixCount = 0 then
      result := AQuantity
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

function TDegreeCelsiusUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue - 273.15;
{$ELSE}
  result := AQuantity - 273.15;
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  result := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := FloatToStr(AQuantity.FValue - 273.15) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity - 273.15) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TQuantity): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue - 273.15;
{$ELSE}
  FactoredValue := AQuantity - 273.15;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(APRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(APRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue - 273.15, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity - 273.15, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

// TDegreeFahrenheitUnitHelper

function TDegreeFahrenheitUnitHelper.GetName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FName;
    1:  result := Format(FName, [
          PrefixTable[Prefixes[0]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TDegreeFahrenheitUnitHelper.GetPluralName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FPluralName;
    1:  result := Format(FPluralName, [
          PrefixTable[Prefixes[0]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TDegreeFahrenheitUnitHelper.GetSymbol(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := FSymbol;
    1:  result := Format(FSymbol, [
          PrefixTable[Prefixes[0]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TDegreeFahrenheitUnitHelper.GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
var
  I: longint;
  Exponent: longint;
  PrefixCount: longint;
begin
  PrefixCount := Length(APrefixes);
  if PrefixCount = Length(FPrefixes) then
  begin
    Exponent := 0;
    for I := 0 to PrefixCount -1 do
      Inc(Exponent, PrefixTable[FPrefixes[I]].Exponent * FExponents[I]);

    for I := 0 to PrefixCount -1 do
      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * FExponents[I]);

    if Exponent <> 0 then
      result := AQuantity * IntPower(10, Exponent)
    else
      result := AQuantity;

  end else
    if PrefixCount = 0 then
      result := AQuantity
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

function TDegreeFahrenheitUnitHelper.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := 9/5 * AQuantity.FValue - 459.67;
{$ELSE}
  result := 9/5 * AQuantity - 459.67;
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  result := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := FloatToStr(9/5 * AQuantity.FValue - 459.67) + ' ' + GetSymbol(FPrefixes);
{$ELSE}
  result := FloatToStr(9/5 * AQuantity - 459.67) + ' ' + GetSymbol(FPrefixes);
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
  FactoredTol   := GetValue(9/5 * ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
  FactoredTol   := GetValue(9/5 * ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TQuantity): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := 9/5 * AQuantity.FValue - 459.67;
{$ELSE}
  FactoredValue := 9/5 * AQuantity - 459.67;
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(APRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(FPrefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(APRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(9/5 * AQuantity.FValue - 459.67, APrefixes);
  FactoredTol   := GetValue(9/5 * ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(9/5 * AQuantity - 459.67, APrefixes);
  FactoredTol   := GetValue(9/5 * ATolerance, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

{ Power functions }

function SquarePower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 2;
  result.FValue := IntPower(AQuantity.FValue, 2);
{$ELSE}
  result := IntPower(AQuantity, 2);
{$ENDIF}
end;

function CubicPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 3;
  result.FValue := IntPower(AQuantity.FValue, 3);
{$ELSE}
  result := IntPower(AQuantity, 3);
{$ENDIF}
end;

function QuarticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 4;
  result.FValue := IntPower(AQuantity.FValue, 4);
{$ELSE}
  result := IntPower(AQuantity, 4);
{$ENDIF}
end;

function QuinticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 5;
  result.FValue := IntPower(AQuantity.FValue, 5);
{$ELSE}
  result := IntPower(AQuantity, 5);
{$ENDIF}
end;

function SexticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 6;
  result.FValue := IntPower(AQuantity.FValue, 6);
{$ELSE}
  result := IntPower(AQuantity, 6);
{$ENDIF}
end;

function SquareRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 2;
  result.FValue := Power(AQuantity.FValue, 1/2);
{$ELSE};
  result := Power(AQuantity, 1/2);
{$ENDIF}
end;

function CubicRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 3;
  result.FValue := Power(AQuantity.FValue, 1/3);
{$ELSE}
  result := Power(AQuantity, 1/3);
{$ENDIF}
end;

function QuarticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 4;
  result.FValue := Power(AQuantity.FValue, 1/4);
{$ELSE}
  result := Power(AQuantity, 1/4);
{$ENDIF}
end;

function QuinticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 5;
  result.FValue := Power(AQuantity.FValue, 1/5);
{$ELSE}
  result := Power(AQuantity, 1/5);
{$ENDIF}
end;

function SexticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 6;
  result.FValue := Power(AQuantity.FValue, 1/6);
{$ELSE}
  result := Power(AQuantity, 1/6);
{$ENDIF}
end;

{ Trigonometric functions }

function Cos(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := System.Cos(AQuantity.FValue);
{$ELSE}
  result := System.Cos(AQuantity);
{$ENDIF}
end;

function Sin(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := System.Sin(AQuantity.FValue);
{$ELSE}
  result := System.Sin(AQuantity);
{$ENDIF}
end;

function Tan(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Tan(AQuantity.FValue);
{$ELSE}
  result := Math.Tan(AQuantity);
{$ENDIF}
end;

function Cotan(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Cotan(AQuantity.FValue);
{$ELSE}
  result := Math.Cotan(AQuantity);
{$ENDIF}
end;

function Secant(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Secant(AQuantity.FValue);
{$ELSE}
  result := Math.Secant(AQuantity);
{$ENDIF}
end;

function Cosecant(const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Cosecant(AQuantity.FValue);
{$ELSE}
  result := Math.Cosecant(AQuantity);
{$ENDIF}
end;

function ArcCos(const AValue: double): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ScalarUnit.FDim;
  result.FValue := Math.ArcCos(AValue);
{$ELSE}
  result := Math.ArcCos(AValue);
{$ENDIF}
end;

function ArcSin(const AValue: double): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ScalarUnit.FDim;
  result.FValue := Math.ArcSin(AValue);
{$ELSE}
  result := Math.ArcSin(AValue);
{$ENDIF}
end;

function ArcTan(const AValue: double): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ScalarUnit.FDim;
  result.FValue := System.ArcTan(AValue);
{$ELSE}
  result := System.ArcTan(AValue);
{$ENDIF}
end;

function ArcTan2(const x, y: double): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ScalarUnit.FDim;
  result.FValue := Math.ArcTan2(x, y);
{$ELSE}
  result := Math.ArcTan2(x, y);
{$ENDIF}
end;

{ Math functions }

function Min(const ALeft, ARight: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := Math.Min(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.Min(ALeft, ARight);
{$ENDIF}
end;

function Max(const ALeft, ARight: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := Math.Max(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.Max(ALeft, ARight);
{$ENDIF}
end;

function Exp(const AQuantity: TQuantity): TQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckSum(ScalarUnit.FDim, AQuantity.FDim);
  result.FValue := System.Exp(AQuantity.FValue);
{$ELSE}
  result := System.Exp(AQuantity);
{$ENDIF}
end;

function Log10(const AQuantity : TQuantity) : double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Log10(AQuantity.FValue);
{$ELSE}
  result := Math.Log10(AQuantity);
{$ENDIF}
end;

function Log2(const AQuantity : TQuantity) : double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Log2(AQuantity.FValue);
{$ELSE}
  result := Math.Log2(AQuantity);
{$ENDIF}
end;

function LogN(ABase: longint; const AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.LogN(ABase, AQuantity.FValue);
{$ELSE}
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function LogN(const ABase, AQuantity: TQuantity): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, ABase.FDim);
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.LogN(ABase.FValue, AQuantity.FValue);
{$ELSE}
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function Power(const ABase: TQuantity; AExponent: double): double;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, ABase.FDim);
  result := Math.Power(ABase.FValue, AExponent);
{$ELSE}
  result := Math.Power(ABase, AExponent);
{$ENDIF}
end;

{ Helper functions }

function LessThanOrEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue <= 0;
{$ELSE}
  result := AQuantity <= 0;
{$ENDIF}
end;

function LessThanZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue < 0;
{$ELSE}
  result := AQuantity < 0;
{$ENDIF}
end;

function EqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue = 0;
{$ELSE}
  result := AQuantity = 0;
{$ENDIF}
end;

function NotEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue <> 0;
{$ELSE}
  result := AQuantity <> 0;
{$ENDIF}
end;

function GreaterThanOrEqualToZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue >= 0;
{$ELSE}
  result := AQuantity >= 0;
{$ENDIF}
end;

function GreaterThanZero(const AQuantity: TQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue > 0;
{$ELSE}
  result := AQuantity > 0;
{$ENDIF}
end;

function NullComplex: TComplex;
begin
  result.FRe := 0;
  result.FIm := 0;
end;

function C2NullVector: TC2Vector;
begin
  result[1] := 0;
  result[2] := 0;
end;

function C3NullVector: TC3Vector;
begin
  result[1] := 0;
  result[2] := 0;
  result[3] := 0;
end;

function C4NullVector: TC4Vector;
begin
  result[1] := 0;
  result[2] := 0;

  result[3] := 0;
  result[4] := 0;
end;

function C2NullMatrix: TC2Matrix;
begin
  result[1,1] := 0;
  result[1,2] := 0;
  result[2,1] := 0;
  result[2,2] := 0;
end;

function C3NullMatrix: TC3Matrix;
begin
  result[1,1] := 0;
  result[1,2] := 0;
  result[1,3] := 0;

  result[2,1] := 0;
  result[2,2] := 0;
  result[2,3] := 0;

  result[3,1] := 0;
  result[3,2] := 0;
  result[3,3] := 0;
end;

function C4NullMatrix: TC4Matrix;
begin
  result[1,1] := 0;
  result[1,2] := 0;
  result[1,3] := 0;
  result[1,4] := 0;

  result[2,1] := 0;
  result[2,2] := 0;
  result[2,3] := 0;
  result[2,4] := 0;

  result[3,1] := 0;
  result[3,2] := 0;
  result[3,3] := 0;
  result[3,4] := 0;

  result[4,1] := 0;
  result[4,2] := 0;
  result[4,3] := 0;
  result[4,4] := 0;
end;

function C2IdentityMatrix: TC2Matrix;
begin
  result[1,1] := 1;
  result[1,2] := 0;

  result[2,1] := 0;
  result[2,2] := 1;
end;

function C3IdentityMatrix: TC3Matrix;
begin
  result[1,1] := 1;
  result[1,2] := 0;
  result[1,3] := 0;

  result[2,1] := 0;
  result[2,2] := 1;
  result[2,3] := 0;

  result[3,1] := 0;
  result[3,2] := 0;
  result[3,3] := 1;
end;

function C4IdentityMatrix: TC4Matrix;
begin
  result[1,1] := 1;
  result[1,2] := 0;
  result[1,3] := 0;
  result[1,4] := 0;

  result[2,1] := 0;
  result[2,2] := 1;
  result[2,3] := 0;
  result[2,4] := 0;

  result[3,1] := 0;
  result[3,2] := 0;
  result[3,3] := 1;
  result[3,4] := 0;

  result[4,1] := 0;
  result[4,2] := 0;
  result[4,3] := 0;
  result[4,4] := 1;
end;

end.

