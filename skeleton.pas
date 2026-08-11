{
  ADim - Automatic Dimensional Analysis run-time library.

  ADim is a Free Pascal library for run-time dimensional analysis of
  physical quantities. It provides:

  @unorderedList(
    @item(The @link(TRealQuantity) type, which associates a @code(TReal) value
          with a @link(TDimension) carrying the full SI exponent signature.)
    @item(Arithmetic operators that propagate and verify physical dimensions
          at run time, raising exceptions on dimensional mismatches.)
    @item(Support for complex quantities (@link(TComplexQuantity)), real and
          complex vectors and matrices up to 4 dimensions, and Clifford algebra
          @code(Cl(3,0)) multivector quantities.)
    @item(A comprehensive set of SI base and derived units (@link(TUnit),
          @link(TFactoredUnit)) with prefix support.)
    @item(Fundamental physical constants expressed as @link(TRealQuantity) values.)
    @item(Mathematical functions (trigonometric, power, logarithm) that are
          dimensionally aware.)
  )

  When the compiler symbol @code(ADIMOFF) is defined, all dimensional
  checking is disabled and every quantity type degenerates to its underlying
  numerical type (@code(TReal), @link(TComplex), etc.), incurring zero
  run-time overhead.

  @author Melchiorre Caruso (melchiorrecaruso@@gmail.com)
  @copyright 2024-2026 Melchiorre Caruso
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

unit Skeleton;

{$H+}{$J-}
{$modeswitch advancedrecords}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function''s return value.
{$WARN 6058 OFF} // Suppress warning for function marked as inline that cannot be inlined.

{#HEADER}

interface

uses
  ADimCL3, ADimCommon, ADimMath, ADimRes, SysUtils;

type
  { TPrefix }

  TPrefix = (pQuetta, pRonna, pYotta, pZetta, pExa, pPeta, pTera, pGiga, pMega, pKilo, pHecto, pDeca,
    pNone, pDeci, pCenti, pMilli, pMicro, pNano, pPico, pFemto, pAtto, pZepto, pYocto, pRonto, pQuecto);

  { TPrefixes }

  TPrefixes = array of TPrefix;

  { TExponents }

  TExponents = array of longint;

  { Represents a physical quantity with dimension checking at runtime.

    Combines a @code(TReal) value with a @link(TDimension), ensuring that
    arithmetic operations are dimensionally consistent. Incompatible dimensions
    raise an exception at runtime.
    When the symbol @code(ADIMOFF) is defined, this type degenerates to @code(TReal)
    and all dimension checking is disabled.
  }
  {$IFNDEF ADIMOFF}
  generic TQuantity<T> = record
  private
    FDim: TDimension;
    FValue: T;
  public
    { Returns the reciprocal of the quantity: @code(1 / self).
      The resulting dimension is the inverse of the original dimension. }
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
    class operator *(const ALeft: T; const ARight: TQuantity): TQuantity;

    { Returns the product of a quantity and a dimensionless real scalar. The dimension is preserved. }
    class operator *(const ALeft: TQuantity; const ARight: T): TQuantity;

    { Returns the quotient of two quantities. The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft, ARight: TQuantity): TQuantity;

    { Returns the quotient of a dimensionless real scalar divided by a quantity.
      The resulting dimension is the inverse of @code(ARight). }
    { Returns the quotient of a quantity divided by a dimensionless scalar. }
    class operator /(const ALeft: TQuantity; const ARight: T): TQuantity;

    { Returns @true if both operands have the same dimension and equal values. }
    class operator =(const ALeft, ARight: TQuantity): boolean;

    { Returns @true if @code(ALeft) is dimensionally compatible with @code(ARight) and its value is strictly less. }
    class operator <>(const ALeft, ARight: TQuantity): boolean;

    { Implicit conversion from a dimensionless real value to a @link(TRealQuantity).
      The resulting quantity has a scalar (dimensionless) dimension. }
    class operator :=(const AValue: T): TQuantity;
  end;

  TRealQuantity = specialize TQuantity<TReal>;
  TComplexQuantity = specialize TQuantity<TComplex>;

  TRealQuantityHelper = record helper for TRealQuantity
    function SameValue(const AQuantity: TRealQuantity): boolean;
  end;

  TComplexQuantityHelper = record helper for TComplexQuantity
    function Conjugate: TComplexQuantity;
    function Norm: TRealQuantity;
    function SameValue(const AQuantity: TComplexQuantity): boolean;
    function SquaredNorm: TRealQuantity;
  end;
  {$ELSE}
  TRealQuantity = TReal;
  TComplexQuantity = TComplex;
  {$ENDIF}

  TArrayOfQuantity = array of TRealQuantity;

  TArrayOfComplexQuantity = array of TComplexQuantity;

  {$IFNDEF ADIMOFF}
  operator :=(const AValue: TRealQuantity): TComplexQuantity;
  operator <(const ALeft, ARight: TRealQuantity): boolean;
  operator >(const ALeft, ARight: TRealQuantity): boolean;
  operator <=(const ALeft, ARight: TRealQuantity): boolean;
  operator >=(const ALeft, ARight: TRealQuantity): boolean;
  operator /(const ALeft: TReal; const ARight: TRealQuantity): TRealQuantity;
  operator /(const ALeft: TComplex; const ARight: TComplexQuantity): TComplexQuantity;
  operator +(const ALeft: TRealQuantity; const ARight: TComplexQuantity): TComplexQuantity;
  operator +(const ALeft: TComplexQuantity; const ARight: TRealQuantity): TComplexQuantity;
  operator -(const ALeft: TRealQuantity; const ARight: TComplexQuantity): TComplexQuantity;
  operator -(const ALeft: TComplexQuantity; const ARight: TRealQuantity): TComplexQuantity;
  operator *(const ALeft: TRealQuantity; const ARight: TComplexQuantity): TComplexQuantity;
  operator *(const ALeft: TComplexQuantity; const ARight: TRealQuantity): TComplexQuantity;
  operator /(const ALeft: TRealQuantity; const ARight: TComplexQuantity): TComplexQuantity;
  operator /(const ALeft: TComplexQuantity; const ARight: TRealQuantity): TComplexQuantity;

  { Returns the product of a dimensional quantity and the imaginary unit. The dimension is preserved. }
  operator *(const ALeft: TRealQuantity; const ARight: TImaginaryUnit): TComplexQuantity;

  { Returns the product of the imaginary unit and a dimensional quantity. The dimension is preserved. }
  operator *(const ALeft: TImaginaryUnit; const ARight: TRealQuantity): TComplexQuantity;

  { Returns the quotient of the imaginary unit divided by a dimensional quantity. The resulting dimension is the inverse of @code(ARight). }
  operator /(const ALeft: TImaginaryUnit; const ARight: TRealQuantity): TComplexQuantity;

  { Returns the quotient of a dimensional quantity divided by the imaginary unit. The dimension is preserved. }
  operator /(const ALeft: TRealQuantity; const ARight: TImaginaryUnit): TComplexQuantity;
  {$ENDIF}

type
  {$IFNDEF ADIMOFF}
  generic TVectorQuantity<T> = record
  type
    TValueVector = specialize TVector<T>;
    TScalarQuantity = specialize TQuantity<T>;
  private
    FDim: TDimension;
    FValue: TValueVector;
    function Get(AIndex: longint): TScalarQuantity;
    procedure Put(AIndex: longint; const AQuantity: TScalarQuantity);
  public
    function Size: longint;
    function Dot(const AVector: TVectorQuantity): TScalarQuantity;
    function IsNull: boolean;
    function IsNotNull: boolean;
    function Norm: TRealQuantity;
    function SquaredNorm: TRealQuantity;
    function Normalize: TValueVector;
    function Reciprocal: TVectorQuantity;
    function ToString: string;

    class operator =(const ALeft, ARight: TVectorQuantity): boolean;
    class operator <>(const ALeft, ARight: TVectorQuantity): boolean;
    class operator +(const ASelf: TVectorQuantity): TVectorQuantity;
    class operator -(const ASelf: TVectorQuantity): TVectorQuantity;
    class operator +(const ALeft, ARight: TVectorQuantity): TVectorQuantity;
    class operator -(const ALeft, ARight: TVectorQuantity): TVectorQuantity;
    class operator *(const ALeft, ARight: TVectorQuantity): TScalarQuantity;
    class operator *(const ALeft: TScalarQuantity; const ARight: TVectorQuantity): TVectorQuantity;
    class operator *(const ALeft: TVectorQuantity; const ARight: TScalarQuantity): TVectorQuantity;
    class operator /(const ALeft: TVectorQuantity; const ARight: TScalarQuantity): TVectorQuantity;

    property A[AIndex: longint]: TScalarQuantity read Get write Put; default;
  end;

  TRealVectorQuantity = specialize TVectorQuantity<TReal>;
  TComplexVectorQuantity = specialize TVectorQuantity<TComplex>;

  TRealVectorQuantityHelper = record helper for TRealVectorQuantity
    function Cross(const AVector: TRealVectorQuantity): TRealVectorQuantity;
    function SameValue(const AVector: TRealVectorQuantity): boolean;
    function ToComplex: TComplexVectorQuantity;
  end;

  TComplexVectorQuantityHelper = record helper for TComplexVectorQuantity
    function Conjugate: TComplexVectorQuantity;
    function SameValue(const AVector: TComplexVectorQuantity): boolean;
  end;

  generic TMatrixQuantity<T> = record
  type
    TValueMatrix = specialize TMatrix<T>;
    TScalarQuantity = specialize TQuantity<T>;
    TVectorQuantityType = specialize TVectorQuantity<T>;
  private
    FDim: TDimension;
    FValue: TValueMatrix;
    function Get(ARow, ACol: longint): TScalarQuantity;
    procedure Put(ARow, ACol: longint; const AQuantity: TScalarQuantity);
  public
    function Order: longint;
    function SolveLinear(const AData: TVectorQuantityType): TVectorQuantityType;
    function Identity: TValueMatrix;
    function Null: TMatrixQuantity;
    function Diagonalize(const ADiagonal: TVectorQuantityType): TMatrixQuantity;
    function IsNull: boolean;
    function IsNotNull: boolean;
    function Determinant: TScalarQuantity;
    function Norm: TRealQuantity;
    function Rank: longint;
    function Trace: TScalarQuantity;
    function Clone: TMatrixQuantity;
    function Transpose: TMatrixQuantity;
    function Inverse: TMatrixQuantity;
    function RowReduction: TValueMatrix;
    procedure Swap(ARow1, ARow2: longint);
    function ToString: string;
    function ToString(APrecision, ADigits: integer): string;

    class operator =(const ALeft, ARight: TMatrixQuantity): boolean;
    class operator <>(const ALeft, ARight: TMatrixQuantity): boolean;
    class operator +(const ALeft, ARight: TMatrixQuantity): TMatrixQuantity;
    class operator -(const ALeft, ARight: TMatrixQuantity): TMatrixQuantity;
    class operator *(const ALeft: TScalarQuantity; const ARight: TMatrixQuantity): TMatrixQuantity;
    class operator *(const ALeft: TMatrixQuantity; const ARight: TScalarQuantity): TMatrixQuantity;
    class operator /(const ALeft: TMatrixQuantity; const ARight: TScalarQuantity): TMatrixQuantity;

    property A[ARow, ACol: longint]: TScalarQuantity read Get write Put; default;
  end;

  TRealMatrixQuantity = specialize TMatrixQuantity<TReal>;
  TComplexMatrixQuantity = specialize TMatrixQuantity<TComplex>;

  TRealMatrixQuantityHelper = record helper for TRealMatrixQuantity
    function IsOrthogonal: boolean;
    function SameValue(const AMatrix: TRealMatrixQuantity): boolean;
    function ToComplex: TComplexMatrixQuantity;
    function Eigenvalues: TComplexVectorQuantity;
    function Eigenvectors(const AEigenvalues: TComplexVectorQuantity): TComplexMatrix;
  end;

  TComplexMatrixQuantityHelper = record helper for TComplexMatrixQuantity
    function Conjugate: TComplexMatrixQuantity;
    function Eigenvalues: TComplexVectorQuantity;
    function Eigenvectors(const AEigenvalues: TComplexVectorQuantity): TComplexMatrix;
    function IsHermitian: boolean;
    function IsUnitary: boolean;
    function SameValue(const AMatrix: TComplexMatrixQuantity): boolean;
    function TransposeConjugate: TComplexMatrixQuantity;
  end;

  operator *(const ALeft, ARight: TRealMatrixQuantity): TRealMatrixQuantity;
  operator *(const ALeft, ARight: TComplexMatrixQuantity): TComplexMatrixQuantity;
  operator *(const ALeft: TRealMatrixQuantity; const ARight: TRealVectorQuantity): TRealVectorQuantity;
  operator *(const ALeft: TRealVectorQuantity; const ARight: TRealMatrixQuantity): TRealVectorQuantity;
  operator *(const ALeft: TComplexMatrixQuantity; const ARight: TComplexVectorQuantity): TComplexVectorQuantity;
  operator *(const ALeft: TComplexVectorQuantity; const ARight: TComplexMatrixQuantity): TComplexVectorQuantity;
  {$ELSE}
  TRealVectorQuantity = TRealVector;
  TComplexVectorQuantity = TComplexVector;
  TRealMatrixQuantity = TRealMatrix;
  TComplexMatrixQuantity = TComplexMatrix;
  {$ENDIF}


type
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
    class operator /(const ALeft: TReal; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a multivector quantity divided by a dimensionless real scalar.
      Each component is divided by @code(ARight). The dimension is preserved.
    }
    class operator /(const ALeft: TCL3MultivecQuantity; const ARight: TReal): TCL3MultivecQuantity;

    { Returns @true if the multivector quantity and the real quantity differ in dimension or in any component. }
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the real quantity and the multivector quantity differ in dimension or in any component. }
    class operator <>(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the multivector quantity equals the real quantity,
      i.e. all non-scalar components are negligible.
    }
    class operator =(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the real quantity equals the multivector quantity,
      i.e. all non-scalar components are negligible.
    }
    class operator =(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns the sum of a multivector quantity and a real quantity.
      Both operands must have the same dimension.
    }
    class operator +(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the sum of a real quantity and a multivector quantity.
      Both operands must have the same dimension.
    }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a multivector quantity and a real quantity.
      Both operands must have the same dimension.
    }
    class operator -(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the difference of a real quantity and a multivector quantity.
      Both operands must have the same dimension.
    }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a multivector quantity and a real quantity.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the geometric product of a real quantity and a multivector quantity.
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a multivector quantity divided by a real quantity: @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient of a real quantity divided by a multivector quantity: @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
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
    class operator *(const ALeft, ARight: TCL3TrivecQuantity): TRealQuantity;

    { Returns the geometric product of a real quantity scalar and a trivector quantity.
      The coefficient @code(m123) is scaled by @code(ALeft).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the geometric product of a trivector quantity and a real quantity scalar.
      The coefficient @code(m123) is scaled by @code(ARight).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): TCL3TrivecQuantity;

    { Returns the geometric quotient of two trivector quantities: @code(ALeft * ARight⁻¹).
      Since @code(e₁₂₃² = -1), the result is a scalar quantity:
      @code((m123₁·e₁₂₃) / (m123₂·e₁₂₃) = -m123₁/m123₂).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft, ARight: TCL3TrivecQuantity): TRealQuantity;

    { Returns the geometric quotient of a dimensionless real scalar divided by a trivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the inverse of @code(ARight).
    }
    class operator /(const ALeft: TReal; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the geometric quotient of a trivector quantity divided by a dimensionless real scalar.
      The coefficient @code(m123) is divided by @code(ARight). The dimension is preserved.
    }
    class operator /(const ALeft: TCL3TrivecQuantity; const ARight: TReal): TCL3TrivecQuantity;

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
    class operator /(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): TCL3TrivecQuantity;

    { Returns the geometric quotient of a real quantity scalar divided by a trivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the sum of a trivector quantity and a real quantity. Both operands must have the same dimension.
      The result is a full multivector quantity with the scalar part from @code(ARight) and grade-3 part from @code(ALeft).
    }
    class operator +(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the sum of a real quantity and a trivector quantity. Both operands must have the same dimension.
      The result is a full multivector quantity with the scalar part from @code(ALeft) and grade-3 part from @code(ARight).
    }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a trivector quantity and a real quantity. Both operands must have the same dimension.
      The result is a full multivector quantity with negated scalar part from @code(ARight) and grade-3 part from @code(ALeft).
    }
    class operator -(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the difference of a real quantity and a trivector quantity. Both operands must have the same dimension.
      The result is a full multivector quantity with scalar part from @code(ALeft) and negated grade-3 part from @code(ARight).
    }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
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
    class operator *(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the geometric product of a bivector quantity and a real quantity scalar.
      Each component is scaled by @code(ARight).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): TCL3BivecQuantity;

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
    class operator /(const ALeft: TReal; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the geometric quotient of a bivector quantity divided by a dimensionless real scalar.
      Each component is divided by @code(ARight). The dimension is preserved.
    }
    class operator /(const ALeft: TCL3BivecQuantity; const ARight: TReal): TCL3BivecQuantity;

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
    class operator /(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): TCL3BivecQuantity;

    { Returns the geometric quotient of a real quantity scalar divided by a bivector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the sum of a bivector quantity and a real quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = ARight) and the bivector components of @code(ALeft).
    }
    class operator +(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the sum of a real quantity and a bivector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = ALeft) and the bivector components of @code(ARight).
    }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a bivector quantity and a real quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = -ARight) and the bivector components of @code(ALeft).
    }
    class operator -(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the difference of a real quantity and a bivector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = ALeft) and negated bivector components of @code(ARight).
    }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
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
    class operator *(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the geometric product of a vector quantity and a real quantity scalar.
      Each component is scaled by @code(ARight).
      The resulting dimension is the product of the two dimensions.
    }
    class operator *(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): TCL3VecQuantity;

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
    class operator /(const ALeft: TReal; const ARight: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the geometric quotient of a vector quantity divided by a dimensionless real scalar.
      Each component is divided by @code(ARight). The dimension is preserved.
    }
    class operator /(const ALeft: TCL3VecQuantity; const ARight: TReal): TCL3VecQuantity;

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
    class operator /(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): TCL3VecQuantity;

    { Returns the geometric quotient of a real quantity scalar divided by a vector quantity:
      @code(ALeft * ARight⁻¹).
      The resulting dimension is the ratio of the two dimensions.
    }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the sum of a vector quantity and a real quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = ARight) and the vector components of @code(ALeft).
    }
    class operator +(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the sum of a real quantity and a vector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = ALeft) and the vector components of @code(ARight).
    }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the difference of a vector quantity and a real quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = -ARight) and the vector components of @code(ALeft).
    }
    class operator -(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the difference of a real quantity and a vector quantity.
      Both operands must have the same dimension. The result is a full multivector
      quantity with @code(m0 = ALeft) and negated vector components of @code(ARight).
    }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
  end;
  {$ELSE}
  TCL3VecQuantity = TCL3Vector;
  {$ENDIF}

type
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
      For a general multivector: @code(M̃ = m0 + m₁·e₁ + m₂·e₂ + m₃·e₃
      - m₁₂·e₁₂ - m₁₃·e₁₃ - m₂₃·e₂₃ - m₁₂₃·e₁₂₃).
      The physical dimension is preserved.
    }
    function Reverse: TCL3MultivecQuantity;

    { Returns the Clifford conjugate of the multivector quantity.
      Combines reversion and grade involution:
      @code(M† = m0 - m₁·e₁ - m₂·e₂ - m₃·e₃ - m₁₂·e₁₂ - m₁₃·e₁₃ - m₂₃·e₂₃ + m₁₂₃·e₁₂₃).
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
    function Norm: TRealQuantity;

    { Returns the squared norm of the multivector quantity: @code(|M|² = M · M̃).
      The resulting dimension is the square of the original dimension.
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: TRealQuantity;

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
    function Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity; overload;

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
    function SameValue(const AVector: TRealQuantity): boolean;

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

    { Returns the grade-0 (scalar) component of the multivector quantity as a @link(TRealQuantity).
      All other grade components are discarded.
    }
    function ExtractScalar: TRealQuantity;

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
    function Dual: TRealQuantity;

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
    function Norm: TRealQuantity;

    { Returns the squared norm of the trivector quantity: @code(|T|² = m123² [dim²]).
      The resulting dimension is the square of the original dimension.
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: TRealQuantity;

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
    function Dot(const AVector: TCL3TrivecQuantity): TRealQuantity; overload;

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
    function Wedge(const AVector: TCL3VecQuantity): TRealQuantity; overload;

    { Returns the outer (wedge) product of the trivector quantity and a bivector quantity.
      Always zero in @code(ℝ³): @code(grade(3) ∧ grade(2) → grade(5) = 0).
      The result is a scalar quantity equal to zero.
      @param(AVector The grade-2 right operand.)
    }
    function Wedge(const AVector: TCL3BivecQuantity): TRealQuantity; overload;

    { Returns the outer (wedge) product of two trivector quantities.
      Always zero in @code(ℝ³): @code(grade(3) ∧ grade(3) → grade(6) = 0).
      The result is a scalar quantity equal to zero.
      @param(AVector The grade-3 right operand.)
    }
    function Wedge(const AVector: TCL3TrivecQuantity): TRealQuantity; overload;

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
    function Rejection(const AVector: TCL3VecQuantity): TRealQuantity; overload;

    { Returns the rejection of the trivector quantity from a bivector quantity subspace.
      Defined as: @code(rej(T, B) = T - proj(T, B)).
      In @code(ℝ³) the rejection of a trivector from a bivector is a scalar quantity.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The bivector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3BivecQuantity): TRealQuantity; overload;

    { Returns the rejection of the trivector quantity from another trivector quantity subspace.
      Defined as: @code(rej(T₁, T₂) = T₁ - proj(T₁, T₂)).
      In @code(ℝ³) the rejection of a trivector from a trivector is a scalar quantity.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The trivector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity; overload;

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
    function Norm: TRealQuantity;

    { Returns the squared norm of the bivector quantity:
      @code(|B|² = m12² + m13² + m23² [dim²]).
      The resulting dimension is the square of the original dimension.
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: TRealQuantity;

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
    function Dot(const AVector: TCL3BivecQuantity): TRealQuantity; overload;

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
    function Wedge(const AVector: TCL3BivecQuantity): TRealQuantity; overload;

    { Returns the outer (wedge) product of the bivector quantity and a trivector quantity.
      Always zero in @code(ℝ³): @code(grade(2) ∧ grade(3) → grade(5) = 0).
      The result is a scalar quantity equal to zero.
      @param(AVector The grade-3 right operand.)
    }
    function Wedge(const AVector: TCL3TrivecQuantity): TRealQuantity; overload;

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
    function Rejection(const AVector: TCL3BivecQuantity): TRealQuantity; overload;

    { Returns the rejection of the bivector quantity from a trivector quantity subspace.
      Defined as: @code(rej(B, T) = B - proj(B, T)).
      In @code(ℝ³) the rejection of a bivector from a trivector is a scalar quantity.
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The trivector quantity defining the subspace to reject from.)
    }
    function Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity; overload;

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
    function Norm: TRealQuantity;

    { Returns the squared Euclidean norm of the vector quantity:
      @code(|v|² = m1² + m2² + m3² [dim²]).
      The resulting dimension is the square of the original dimension.
      Avoids the square root computation of @link(Norm).
    }
    function SquaredNorm: TRealQuantity;

    { Returns the inner (dot) product of two vector quantities.
      Lowers the grade: @code(grade(1) · grade(1) → grade(0) = scalar quantity).
      Result: @code(u · v = m1₁·m1₂ + m2₁·m2₂ + m3₁·m3₂ [dim₁·dim₂]).
      The resulting dimension is the product of the two operand dimensions.
      @param(AVector The grade-1 right operand.)
    }
    function Dot(const AVector: TCL3VecQuantity): TRealQuantity; overload;

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
    function Wedge(const AVector: TCL3TrivecQuantity): TRealQuantity; overload;

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
    function Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity; overload;

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
    @code(var v: TRealQuantity := 9.81 * MetrePerSquareSecond;)
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
    class operator *(const AValue: TReal; const ASelf: TUnit): TRealQuantity; inline;

    { Returns the real quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TReal; const ASelf: TUnit): TRealQuantity; inline;

    { Returns the complex quantity @code(AValue [unit]). }
    class operator *(const AValue: TComplex; const ASelf: TUnit): TComplexQuantity; inline;

    { Returns the complex quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TComplex; const ASelf: TUnit): TComplexQuantity; inline;

    { Returns the 2-component real vector quantity @code(AVector [unit]). }
    class operator *(const AVector: TRealVector; const ASelf: TUnit): TRealVectorQuantity; inline;

    { Returns the 2-component real vector quantity @code(AVector / [unit]), with inverted dimension. }
    class operator /(const AVector: TRealVector; const ASelf: TUnit): TRealVectorQuantity; inline;

    { Returns the 2-component complex vector quantity @code(AVector [unit]). }
    class operator *(const AVector: TComplexVector; const ASelf: TUnit): TComplexVectorQuantity; inline;

    { Returns the 2-component complex vector quantity @code(AVector / [unit]), with inverted dimension. }
    class operator /(const AVector: TComplexVector; const ASelf: TUnit): TComplexVectorQuantity; inline;

    { Returns the 2×2 real matrix quantity @code(AMatrix [unit]). }
    class operator *(const AMatrix: TRealMatrix; const ASelf: TUnit): TRealMatrixQuantity; inline;

    { Returns the 2×2 real matrix quantity @code(AMatrix / [unit]), with inverted dimension. }
    class operator /(const AMatrix: TRealMatrix; const ASelf: TUnit): TRealMatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity @code(AMatrix [unit]). }
    class operator *(const AMatrix: TComplexMatrix; const ASelf: TUnit): TComplexMatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity @code(AMatrix / [unit]), with inverted dimension. }
    class operator /(const AMatrix: TComplexMatrix; const ASelf: TUnit): TComplexMatrixQuantity; inline;

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
    class operator *(const AQuantity: TRealQuantity; const ASelf: TUnit): TRealQuantity; inline;

    { Returns the real quantity with dimension divided by @code([unit]).
      Used for unit conversion: @code(1000.0*m / km = 1).
    }
    class operator /(const AQuantity: TRealQuantity; const ASelf: TUnit): TRealQuantity; inline;

    { Returns the complex quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;

    { Returns the complex quantity with dimension scaled by @code([unit]) (unit on the left). }
    class operator *(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;

    { Returns the complex quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;

    { Returns the complex quantity with dimension inverted relative to @code([unit]). }
    class operator /(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;

    { Returns the 2-component real vector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TRealVectorQuantity; const ASelf: TUnit): TRealVectorQuantity; inline;

    { Returns the 2-component real vector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TRealVectorQuantity; const ASelf: TUnit): TRealVectorQuantity; inline;

    { Returns the 2-component complex vector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TComplexVectorQuantity; const ASelf: TUnit): TComplexVectorQuantity; inline;

    { Returns the 2-component complex vector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TComplexVectorQuantity; const ASelf: TUnit): TComplexVectorQuantity; inline;

    { Returns the 2×2 real matrix quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TRealMatrixQuantity; const ASelf: TUnit): TRealMatrixQuantity; inline;

    { Returns the 2×2 real matrix quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TRealMatrixQuantity; const ASelf: TUnit): TRealMatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TComplexMatrixQuantity; const ASelf: TUnit): TComplexMatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TComplexMatrixQuantity; const ASelf: TUnit): TComplexMatrixQuantity; inline;

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
    @link(TRealQuantity) is always expressed in SI base units internally.

    Example idiomatic usage:
    @code(var d: TRealQuantity := 5.0 * Kilometre;   // stores 5000.0 m internally)
    @code(var a: TRealQuantity := 90.0 * Degree;     // stores π/2 rad internally)

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
    FFactor: TReal;
  public
    {
      Returns the real quantity @code(AValue * FFactor [dim]).
      The value is converted to SI base units using @code(FFactor).
    }
    class operator *(const AValue: TReal; const ASelf: TFactoredUnit): TRealQuantity; inline;

    { Returns the real quantity @code(AValue / FFactor [dim⁻¹]).
      The value is converted to SI base units using @code(FFactor).
    }
    class operator /(const AValue: TReal; const ASelf: TFactoredUnit): TRealQuantity; inline;

    { Returns the complex quantity @code(AValue * FFactor [dim]).
      Each component is scaled by @code(FFactor).
    }
    class operator *(const AValue: TComplex; const ASelf: TFactoredUnit): TComplexQuantity; inline;

    { Returns the complex quantity @code(AValue / FFactor [dim⁻¹]).
      Each component is scaled by @code(1/FFactor).
    }
    class operator /(const AValue: TComplex; const ASelf: TFactoredUnit): TComplexQuantity; inline;

    { Returns the 2-component real vector quantity @code(AVector * FFactor [dim]). }
    class operator *(const AVector: TRealVector; const ASelf: TFactoredUnit): TRealVectorQuantity; inline;

    { Returns the 2-component real vector quantity @code(AVector / FFactor [dim⁻¹]). }
    class operator /(const AVector: TRealVector; const ASelf: TFactoredUnit): TRealVectorQuantity; inline;

    { Returns the 2-component complex vector quantity @code(AVector * FFactor [dim]). }
    class operator *(const AVector: TComplexVector; const ASelf: TFactoredUnit): TComplexVectorQuantity; inline;

    { Returns the 2-component complex vector quantity @code(AVector / FFactor [dim⁻¹]). }
    class operator /(const AVector: TComplexVector; const ASelf: TFactoredUnit): TComplexVectorQuantity; inline;

    { Returns the 2×2 real matrix quantity @code(AMatrix * FFactor [dim]). }
    class operator *(const AMatrix: TRealMatrix; const ASelf: TFactoredUnit): TRealMatrixQuantity; inline;

    { Returns the 2×2 real matrix quantity @code(AMatrix / FFactor [dim⁻¹]). }
    class operator /(const AMatrix: TRealMatrix; const ASelf: TFactoredUnit): TRealMatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity @code(AMatrix * FFactor [dim]). }
    class operator *(const AMatrix: TComplexMatrix; const ASelf: TFactoredUnit): TComplexMatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity @code(AMatrix / FFactor [dim⁻¹]). }
    class operator /(const AMatrix: TComplexMatrix; const ASelf: TFactoredUnit): TComplexMatrixQuantity; inline;

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
    class operator *(const AQuantity: TRealQuantity; const ASelf: TFactoredUnit): TRealQuantity; inline;

    { Returns the real quantity with dimension and value rescaled by @code(1/FFactor).
      Used for unit conversion: @code(5000.0*m / km → 5.0).
    }
    class operator /(const AQuantity: TRealQuantity; const ASelf: TFactoredUnit): TRealQuantity; inline;

    { Returns the complex quantity with dimension and value rescaled by @code(FFactor). }
    class operator *(const AQuantity: TComplexQuantity; const ASelf: TFactoredUnit): TComplexQuantity; inline;

    { Returns the complex quantity with dimension and value rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TComplexQuantity; const ASelf: TFactoredUnit): TComplexQuantity; inline;

    { Returns the 2-component real vector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TRealVectorQuantity; const ASelf: TFactoredUnit): TRealVectorQuantity; inline;

    { Returns the 2-component real vector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TRealVectorQuantity; const ASelf: TFactoredUnit): TRealVectorQuantity; inline;

    { Returns the 2-component complex vector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TComplexVectorQuantity; const ASelf: TFactoredUnit): TComplexVectorQuantity; inline;

    { Returns the 2-component complex vector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TComplexVectorQuantity; const ASelf: TFactoredUnit): TComplexVectorQuantity; inline;

    { Returns the 2×2 real matrix quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TRealMatrixQuantity; const ASelf: TFactoredUnit): TRealMatrixQuantity; inline;

    { Returns the 2×2 real matrix quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TRealMatrixQuantity; const ASelf: TFactoredUnit): TRealMatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TComplexMatrixQuantity; const ASelf: TFactoredUnit): TComplexMatrixQuantity; inline;

    { Returns the 2×2 complex matrix quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TComplexMatrixQuantity; const ASelf: TFactoredUnit): TComplexMatrixQuantity; inline;

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
    the resulting @link(TRealQuantity) is always expressed in kelvin internally.

    Example:
    @code(var T: TRealQuantity := 100.0 * DegreeCelsius;  // stores 373.15 K internally)

    This affine unit represents an absolute point on the Celsius scale. Use the
    generated @code(DeltaDegreeCelsius) or @code(deltaDegC) factored unit for
    temperature differences and tolerances, because intervals have no offset.
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
    { Converts a temperature value in degrees Celsius to a @link(TRealQuantity) in kelvin.
      Applies the offset: @code(T[K] = AValue + 273.15).
      The resulting quantity has the thermodynamic temperature dimension @code([K]).
    }
    class operator *(const AValue: TReal; const ASelf: TDegreeCelsiusUnit): TRealQuantity; inline;
  end;

  { Represents the degree Fahrenheit temperature unit (@code(°F)).

    The Fahrenheit scale has both a scale factor and an offset relative to kelvin:
    @code(T[K] = (T[°F] + 459.67) × 5/9).
    The multiplication operator applies this full conversion, so that
    the resulting @link(TRealQuantity) is always expressed in kelvin internally.

    Example:
    @code(var T: TRealQuantity := 212.0 * DegreeFahrenheit;  // stores 373.15 K internally)

    This affine unit represents an absolute point on the Fahrenheit scale. Use
    the generated @code(DeltaDegreeFahrenheit) or @code(deltaDegF) factored unit
    for temperature differences and tolerances, because intervals have no offset.
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
    { Converts a temperature value in degrees Fahrenheit to a @link(TRealQuantity) in kelvin.
      Applies the affine conversion: @code(T[K] = (AValue + 459.67) × 5/9).
      The resulting quantity has the thermodynamic temperature dimension @code([K]).
    }
    class operator *(const AValue: TReal; const ASelf: TDegreeFahrenheitUnit): TRealQuantity; inline;
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
    function GetValue(const AQuantity: TReal; const APrefixes: TPrefixes): TReal;

    { Returns the complex value scaled for the given prefix.
      @param(AQuantity The dimensionless complex value to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TComplex; const APrefixes: TPrefixes): TComplex;

    { Returns the 2-component real vector scaled for the given prefix.
      @param(AQuantity The dimensionless vector to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TRealVector; const APrefixes: TPrefixes): TRealVector;

    { Returns the 2-component complex vector scaled for the given prefix.
      @param(AQuantity The dimensionless complex vector to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TComplexVector; const APrefixes: TPrefixes): TComplexVector;

    { Returns the 2×2 real matrix scaled for the given prefix.
      @param(AQuantity The dimensionless matrix to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TRealMatrix; const APrefixes: TPrefixes): TRealMatrix;

    { Returns the 2×2 complex matrix scaled for the given prefix.
      @param(AQuantity The dimensionless complex matrix to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TComplexMatrix; const APrefixes: TPrefixes): TComplexMatrix;

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
    function ToFloat(const AQuantity: TRealQuantity): TReal;

    { Returns the numerical value of the real quantity expressed in this unit
      with the given prefix applied.
      @param(AQuantity  The real quantity to extract the value from.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToFloat(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): TReal;

    { Returns a compact string representation of the real quantity in this unit.
      Format: @code('<value> <symbol>'), e.g. @code('9.81 m/s²').
      @param(AQuantity The real quantity to format.)
    }
    function ToString(const AQuantity: TRealQuantity): string;

    { Returns a compact string representation of the real quantity in this unit
      with the given prefix applied.
      @param(AQuantity  The real quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the real quantity with controlled precision.
      @param(AQuantity   The real quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the real quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> <symbol>').
      @param(AQuantity   The central real quantity to format.)
      @param(ATolerance  The tolerance quantity to display alongside the value.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real quantity in this unit.
      Format: @code('<value> <plural name>'), e.g. @code('9.81 metres per square second').
      @param(AQuantity The real quantity to format.)
    }
    function ToVerboseString(const AQuantity: TRealQuantity): string;

    { Returns a verbose string representation of the real quantity with the given prefix.
      @param(AQuantity  The real quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real quantity with controlled precision.
      @param(AQuantity   The real quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> <plural name>').
      @param(AQuantity   The central real quantity to format.)
      @param(ATolerance  The tolerance quantity to display alongside the value.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

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
    function ToVector(const AQuantity: TRealVectorQuantity): TRealVector;

    { Returns the dimensionless @link(TR2Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): TRealVector;

    { Returns a compact string representation of the 2-component real vector quantity in this unit. }
    function ToString(const AQuantity: TRealVectorQuantity): string;

    { Returns a compact string representation of the 2-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2-component real vector quantity in this unit. }
    function ToVerboseString(const AQuantity: TRealVectorQuantity): string;

    { Returns a verbose string representation of the 2-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TC2Vector) of the 2-component complex vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TComplexVectorQuantity): TComplexVector;

    { Returns the dimensionless @link(TC2Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): TComplexVector;

    { Returns a compact string representation of the 2-component complex vector quantity in this unit. }
    function ToString(const AQuantity: TComplexVectorQuantity): string;

    { Returns a compact string representation of the 2-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2-component complex vector quantity in this unit. }
    function ToVerboseString(const AQuantity: TComplexVectorQuantity): string;

    { Returns a verbose string representation of the 2-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TR2Matrix) of the 2×2 real matrix quantity expressed in this unit. }
    function ToMatrix(const AQuantity: TRealMatrixQuantity): TRealMatrix;

    { Returns the dimensionless @link(TR2Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): TRealMatrix;

    { Returns a compact string representation of the 2×2 real matrix quantity in this unit. }
    function ToString(const AQuantity: TRealMatrixQuantity): string;

    { Returns a compact string representation of the 2×2 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2×2 real matrix quantity in this unit. }
    function ToVerboseString(const AQuantity: TRealMatrixQuantity): string;

    { Returns a verbose string representation of the 2×2 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TC2Matrix) of the 2×2 complex matrix quantity expressed in this unit. }
    function ToMatrix(const AQuantity: TComplexMatrixQuantity): TComplexMatrix;

    { Returns the dimensionless @link(TC2Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): TComplexMatrix;

    { Returns a compact string representation of the 2×2 complex matrix quantity in this unit. }
    function ToString(const AQuantity: TComplexMatrixQuantity): string;

    { Returns a compact string representation of the 2×2 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2×2 complex matrix quantity in this unit. }
    function ToVerboseString(const AQuantity: TComplexMatrixQuantity): string;

    { Returns a verbose string representation of the 2×2 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): string;

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
    function GetValue(const AQuantity: TReal; const APrefixes: TPrefixes): TReal;

    { Returns the complex value scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless complex value to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TComplex; const APrefixes: TPrefixes): TComplex;

    { Returns the 2-component real vector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless vector to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TRealVector; const APrefixes: TPrefixes): TRealVector;

    { Returns the 2-component complex vector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless complex vector to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TComplexVector; const APrefixes: TPrefixes): TComplexVector;

    { Returns the 2×2 real matrix scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless matrix to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TRealMatrix; const APrefixes: TPrefixes): TRealMatrix;

    { Returns the 2×2 complex matrix scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless complex matrix to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TComplexMatrix; const APrefixes: TPrefixes): TComplexMatrix;

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
    function ToFloat(const AQuantity: TRealQuantity): TReal;

    { Returns the numerical value of the real quantity expressed in this factored unit
      with the given prefix applied.
      @param(AQuantity  The real quantity to extract the value from.)
      @param(APrefixes  The SI prefixes defining additional output scaling.)
    }
    function ToFloat(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): TReal;

    { Returns a compact string representation of the real quantity in this factored unit.
      Format: @code('<value> <symbol>'), e.g. @code('5 km'), @code('90 °').
      @param(AQuantity The real quantity to format.)
    }
    function ToString(const AQuantity: TRealQuantity): string;

    { Returns a compact string representation of the real quantity in this factored unit
      with the given prefix applied.
      @param(AQuantity  The real quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the real quantity with controlled precision.
      @param(AQuantity   The real quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the real quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> <symbol>').
      @param(AQuantity   The central real quantity to format.)
      @param(ATolerance  The tolerance quantity to display alongside the value.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real quantity in this factored unit.
      Format: @code('<value> <plural name>'), e.g. @code('5 kilometres').
      @param(AQuantity The real quantity to format.)
    }
    function ToVerboseString(const AQuantity: TRealQuantity): string;

    { Returns a verbose string representation of the real quantity with the given prefix.
      @param(AQuantity  The real quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real quantity with controlled precision.
      @param(AQuantity   The real quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> <plural name>').
      @param(AQuantity   The central real quantity to format.)
      @param(ATolerance  The tolerance quantity to display alongside the value.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

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
    function ToVector(const AQuantity: TRealVectorQuantity): TRealVector;

    { Returns the dimensionless @link(TR2Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): TRealVector;

    { Returns a compact string representation of the 2-component real vector quantity in this factored unit. }
    function ToString(const AQuantity: TRealVectorQuantity): string;

    { Returns a compact string representation of the 2-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2-component real vector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TRealVectorQuantity): string;

    { Returns a verbose string representation of the 2-component real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TC2Vector) of the 2-component complex vector quantity expressed in this factored unit. }
    function ToVector(const AQuantity: TComplexVectorQuantity): TComplexVector;

    { Returns the dimensionless @link(TC2Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): TComplexVector;

    { Returns a compact string representation of the 2-component complex vector quantity in this factored unit. }
    function ToString(const AQuantity: TComplexVectorQuantity): string;

    { Returns a compact string representation of the 2-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2-component complex vector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TComplexVectorQuantity): string;

    { Returns a verbose string representation of the 2-component complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TR2Matrix) of the 2×2 real matrix quantity expressed in this factored unit. }
    function ToMatrix(const AQuantity: TRealMatrixQuantity): TRealMatrix;

    { Returns the dimensionless @link(TR2Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): TRealMatrix;

    { Returns a compact string representation of the 2×2 real matrix quantity in this factored unit. }
    function ToString(const AQuantity: TRealMatrixQuantity): string;

    { Returns a compact string representation of the 2×2 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2×2 real matrix quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TRealMatrixQuantity): string;

    { Returns a verbose string representation of the 2×2 real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TC2Matrix) of the 2×2 complex matrix quantity expressed in this factored unit. }
    function ToMatrix(const AQuantity: TComplexMatrixQuantity): TComplexMatrix;

    { Returns the dimensionless @link(TC2Matrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): TComplexMatrix;

    { Returns a compact string representation of the 2×2 complex matrix quantity in this factored unit. }
    function ToString(const AQuantity: TComplexMatrixQuantity): string;

    { Returns a compact string representation of the 2×2 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the 2×2 complex matrix quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TComplexMatrixQuantity): string;

    { Returns a verbose string representation of the 2×2 complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): string;

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
    function GetValue(const AQuantity: TReal; const APrefixes: TPrefixes): TReal;

  public

    { Returns the numerical value of the real quantity expressed in degrees Celsius.
      Applies the inverse offset conversion: @code(T[°C] = T[K] - 273.15).
      @param(AQuantity The real temperature quantity stored internally in kelvin.)
    }
    function ToFloat(const AQuantity: TRealQuantity): TReal;

    { Returns the numerical value of the real quantity expressed in degrees Celsius
      with the given prefix applied.
      @param(AQuantity  The real temperature quantity stored internally in kelvin.)
      @param(APrefixes  The SI prefixes defining additional output scaling.)
    }
    function ToFloat(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): TReal;

    { Returns a compact string representation of the temperature quantity in degrees Celsius.
      Format: @code('<value> °C'), e.g. @code('100 °C').
      @param(AQuantity The real temperature quantity to format.)
    }
    function ToString(const AQuantity: TRealQuantity): string;

    { Returns a compact string representation of the temperature quantity in degrees Celsius
      with the given prefix applied.
      @param(AQuantity  The real temperature quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the temperature quantity with controlled precision.
      @param(AQuantity   The real temperature quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the temperature quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> °C').
      @param(AQuantity   The central temperature quantity to format.)
      @param(ATolerance  A temperature interval, normally constructed with
                         @code(DeltaDegreeCelsius), @code(deltaDegC), or kelvin.
                         No Celsius offset is applied to this value.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the temperature quantity in degrees Celsius.
      Format: @code('<value> degrees Celsius'), e.g. @code('100 degrees Celsius').
      @param(AQuantity The real temperature quantity to format.)
    }
    function ToVerboseString(const AQuantity: TRealQuantity): string;

    { Returns a verbose string representation of the temperature quantity with the given prefix.
      @param(AQuantity  The real temperature quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the temperature quantity with controlled precision.
      @param(AQuantity   The real temperature quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the temperature quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> degrees Celsius').
      @param(AQuantity   The central temperature quantity to format.)
      @param(ATolerance  A temperature interval, normally constructed with
                         @code(DeltaDegreeCelsius), @code(deltaDegC), or kelvin.
                         No Celsius offset is applied to this value.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
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
    function GetValue(const AQuantity: TReal; const APrefixes: TPrefixes): TReal;

  public

    { Returns the numerical value of the real quantity expressed in degrees Fahrenheit.
      Applies the inverse affine conversion: @code(T[°F] = T[K] × 9/5 - 459.67).
      @param(AQuantity The real temperature quantity stored internally in kelvin.)
    }
    function ToFloat(const AQuantity: TRealQuantity): TReal;

    { Returns the numerical value of the real quantity expressed in degrees Fahrenheit
      with the given prefix applied.
      @param(AQuantity  The real temperature quantity stored internally in kelvin.)
      @param(APrefixes  The SI prefixes defining additional output scaling.)
    }
    function ToFloat(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): TReal;

    { eturns a compact string representation of the temperature quantity in degrees Fahrenheit.
      Format: @code('<value> °F'), e.g. @code('212 °F').
      @param(AQuantity The real temperature quantity to format.)
    }
    function ToString(const AQuantity: TRealQuantity): string;

    { Returns a compact string representation of the temperature quantity in degrees Fahrenheit
      with the given prefix applied.
      @param(AQuantity  The real temperature quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the temperature quantity with controlled precision.
      @param(AQuantity   The real temperature quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the temperature quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> °F').
      @param(AQuantity   The central temperature quantity to format.)
      @param(ATolerance  A temperature interval, normally constructed with
                         @code(DeltaDegreeFahrenheit), @code(deltaDegF), or kelvin.
                         Only the Fahrenheit scale factor is applied.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the temperature quantity in degrees Fahrenheit.
      Format: @code('<value> degrees Fahrenheit'), e.g. @code('212 degrees Fahrenheit').
      @param(AQuantity The real temperature quantity to format.)
    }
    function ToVerboseString(const AQuantity: TRealQuantity): string;

    { Returns a verbose string representation of the temperature quantity with the given prefix.
      @param(AQuantity  The real temperature quantity to format.)
      @param(APrefixes  The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the temperature quantity with controlled precision.
      @param(AQuantity   The real temperature quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the temperature quantity with a tolerance range.
      Format: @code('<value> ± <tolerance> degrees Fahrenheit').
      @param(AQuantity   The central temperature quantity to format.)
      @param(ATolerance  A temperature interval, normally constructed with
                         @code(DeltaDegreeFahrenheit), @code(deltaDegF), or kelvin.
                         Only the Fahrenheit scale factor is applied.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
  end;

{ TScalar } { @exclude }

const
  ScalarUnit : TUnit = (
    FDim        : (FKilogram: 0; FMeter: 0; FSecond: 0; FAmpere: 0; FKelvin: 0; FMole: 0; FCandela: 0; FSteradian: 0);
    FSymbol     : rsScalarSymbol;
    FName       : rsScalarName;
    FPluralName : rsScalarPluralName;
    FPrefixes   : ();
    FExponents  : ());

{#UNITSOFMEASUREMENT}

  { External operator overloads for multiplying @link(TRealQuantity) scalars with
    dimensionless matrix types, producing the corresponding matrix quantity types.

    These operators are necessary because Free Pascal does not allow operator
    overloads between two different record types to be defined inside either record
    when neither owns the other. They bridge @link(TRealQuantity) (defined in the
    dimensional analysis layer) with the generic matrix types (defined in the
    linear algebra layer).

    All operators follow the rule: the resulting dimension equals the dimension
    of the @link(TRealQuantity) operand, and the numerical values of the matrix
    elements are scaled accordingly.

    Only available when @code(ADIMOFF) is not defined.
  }

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

  {$IFNDEF ADIMOFF}
  { Returns @true if two real physical quantities are equal within the default floating point tolerance.
    Both operands must have the same dimension; an exception is raised if they differ.
    @param(ALeft  The first quantity.)
    @param(ARight The second quantity.)
  }
  function SameValueEx(const ALeft, ARight: TRealQuantity): boolean;
  {$ENDIF}

  { Returns the square of the quantity: @code(AQuantity²).
    The resulting dimension is the square of the original dimension.
    @param(AQuantity The quantity to square.)
    @exclude
  }
  function SquarePower(const AQuantity: TRealQuantity): TRealQuantity;

  { Returns the cube of the quantity: @code(AQuantity³).
    The resulting dimension is the cube of the original dimension.
    @param(AQuantity The quantity to cube.)
  }
  function CubicPower(const AQuantity: TRealQuantity): TRealQuantity;

  { Returns the fourth power of the quantity: @code(AQuantity⁴).
    The resulting dimension is the fourth power of the original dimension.
    @param(AQuantity The quantity to raise to the fourth power.)
  }
  function QuarticPower(const AQuantity: TRealQuantity): TRealQuantity;

  { Returns the fifth power of the quantity: @code(AQuantity⁵).
    The resulting dimension is the fifth power of the original dimension.
    @param(AQuantity The quantity to raise to the fifth power.)
  }
  function QuinticPower(const AQuantity: TRealQuantity): TRealQuantity;

  { Returns the sixth power of the quantity: @code(AQuantity⁶).
    The resulting dimension is the sixth power of the original dimension.
    @param(AQuantity The quantity to raise to the sixth power.)
  }
  function SexticPower(const AQuantity: TRealQuantity): TRealQuantity;

  { Returns the square root of the quantity: @code(AQuantity^(1/2)).
    The resulting dimension has all exponents halved.
    @raises(Exception if any dimension exponent is odd.)
    @param(AQuantity The quantity whose square root is computed.)
  }
  function SquareRoot(const AQuantity: TRealQuantity): TRealQuantity;

  { Returns the cube root of the quantity: @code(AQuantity^(1/3)).
    The resulting dimension has all exponents divided by 3.
    @raises(Exception if any dimension exponent is not divisible by 3.)
    @param(AQuantity The quantity whose cube root is computed.)
  }
  function CubicRoot(const AQuantity: TRealQuantity): TRealQuantity;

  { Returns the fourth root of the quantity: @code(AQuantity^(1/4)).
    The resulting dimension has all exponents divided by 4.
    @raises(Exception if any dimension exponent is not divisible by 4.)
    @param(AQuantity The quantity whose fourth root is computed.)
  }
  function QuarticRoot(const AQuantity: TRealQuantity): TRealQuantity;

  { Returns the fifth root of the quantity: @code(AQuantity^(1/5)).
    The resulting dimension has all exponents divided by 5.
    @raises(Exception if any dimension exponent is not divisible by 5.)
    @param(AQuantity The quantity whose fifth root is computed.)
  }
  function QuinticRoot(const AQuantity: TRealQuantity): TRealQuantity;

  { Returns the sixth root of the quantity: @code(AQuantity^(1/6)).
    The resulting dimension has all exponents divided by 6.
    @raises(Exception if any dimension exponent is not divisible by 6.)
    @param(AQuantity The quantity whose sixth root is computed.)
  }
  function SexticRoot(const AQuantity: TRealQuantity): TRealQuantity;

  { Returns the cosine of the angle quantity.
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(TReal).
    @param(AQuantity The angle quantity in radians.)
  }
  function Cos(const AQuantity: TRealQuantity): TReal;

  { Returns the sine of the angle quantity.
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(TReal).
    @param(AQuantity The angle quantity in radians.)
  }
  function Sin(const AQuantity: TRealQuantity): TReal;

  { Returns the tangent of the angle quantity.
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(TReal).
    @param(AQuantity The angle quantity in radians.)
  }
  function Tan(const AQuantity: TRealQuantity): TReal;

  { Returns the cotangent of the angle quantity: @code(cos(θ)/sin(θ)).
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(TReal).
    @param(AQuantity The angle quantity in radians.)
  }
  function Cotan(const AQuantity: TRealQuantity): TReal;

  { Returns the secant of the angle quantity: @code(1/cos(θ)).
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(TReal).
    @param(AQuantity The angle quantity in radians.)
  }
  function Secant(const AQuantity: TRealQuantity): TReal;

  { Returns the cosecant of the angle quantity: @code(1/sin(θ)).
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(TReal).
    @param(AQuantity The angle quantity in radians.)
  }
  function Cosecant(const AQuantity: TRealQuantity): TReal;

  { Returns the arc cosine of @code(AValue) as an angle quantity in radians.
    @code(AValue) must be in the range @code([-1, 1]).
    The result has the dimension of an angle (radians).
    @param(AValue The dimensionless cosine value.)
  }
  function ArcCos(const AValue: TReal): TRealQuantity;

  { Returns the arc sine of @code(AValue) as an angle quantity in radians.
    @code(AValue) must be in the range @code([-1, 1]).
    The result has the dimension of an angle (radians).
    @param(AValue The dimensionless sine value.)
  }
  function ArcSin(const AValue: TReal): TRealQuantity;

  { Returns the arc tangent of @code(AValue) as an angle quantity in radians.
    The result is in the range @code((-π/2, π/2)).
    The result has the dimension of an angle (radians).
    @param(AValue The dimensionless tangent value.)
  }
  function ArcTan(const AValue: TReal): TRealQuantity;

  { Returns the arc tangent of @code(y/x) as an angle quantity in radians,
    using the signs of both arguments to determine the correct quadrant.
    The result is in the range @code([-π, π]).
    The result has the dimension of an angle (radians).
    @param(AY The dimensionless y-coordinate.)
    @param(AX The dimensionless x-coordinate.)
  }
  function ArcTan2(const AY, AX: TReal): TRealQuantity;

  { Returns the smaller of two quantities.
    Both operands must have the same dimension.
    @param(ALeft  The first quantity.)
    @param(ARight The second quantity.)
  }
  function Min(const ALeft, ARight: TRealQuantity): TRealQuantity;

  { Returns the larger of two quantities.
    Both operands must have the same dimension.
    @param(ALeft  The first quantity.)
    @param(ARight The second quantity.)
  }
  function Max(const ALeft, ARight: TRealQuantity): TRealQuantity;

  { Returns @code(e^AQuantity) as a dimensioned quantity.
    The argument must be dimensionless; the result has the same dimension as the argument.
    @param(AQuantity The dimensionless exponent quantity.)
  }
  function Exp(const AQuantity: TRealQuantity): TRealQuantity;

  { Returns the base-10 logarithm of the quantity as a dimensionless @code(TReal).
    The argument must be dimensionless and positive.
    @param(AQuantity The dimensionless positive quantity.)
  }
  function Log10(const AQuantity: TRealQuantity): TReal;

  { Returns the base-2 logarithm of the quantity as a dimensionless @code(TReal).
    The argument must be dimensionless and positive.
    @param(AQuantity The dimensionless positive quantity.)
  }
  function Log2(const AQuantity: TRealQuantity): TReal;

  { Returns the base-@code(ABase) logarithm of the quantity as a dimensionless @code(TReal).
    The argument must be dimensionless and positive.
    @param(ABase     The integer logarithm base.)
    @param(AQuantity The dimensionless positive quantity.)
  }
  function LogN(ABase: longint; const AQuantity: TRealQuantity): TReal;

  { Returns the logarithm of @code(AQuantity) in the base @code(ABase) as a dimensionless @code(TReal).
    Both arguments must be dimensionless and positive.
    @param(ABase     The dimensionless base quantity.)
    @param(AQuantity The dimensionless positive quantity.)
  }
  function LogN(const ABase, AQuantity: TRealQuantity): TReal;

  { Returns @code(ABase^AExponent) as a dimensionless @code(TReal).
    The base must be dimensionless. Used for fractional or real exponents
    where dimensional consistency cannot be verified at compile time.
    @param(ABase     The dimensionless base quantity.)
    @param(AExponent The real exponent.)
  }
  function Power(const ABase: TRealQuantity; AExponent: TReal): TReal;

  { Returns @true if the quantity is less than or equal to zero.
    The quantity must be dimensionless or the comparison must be meaningful
    within its dimension context.
    @param(AQuantity The quantity to test.)
  }
  function LessThanOrEqualToZero(const AQuantity: TRealQuantity): boolean;

  { Returns @true if the quantity is strictly less than zero.
    @param(AQuantity The quantity to test.)
  }
  function LessThanZero(const AQuantity: TRealQuantity): boolean;

  { Returns @true if the quantity is equal to zero within the default floating point tolerance.
    @param(AQuantity The quantity to test.)
  }
  function EqualToZero(const AQuantity: TRealQuantity): boolean;

  { Returns @true if the quantity is not equal to zero within the default floating point tolerance.
    @param(AQuantity The quantity to test.)
  }
  function NotEqualToZero(const AQuantity: TRealQuantity): boolean;

  { Returns @true if the quantity is greater than or equal to zero.
    @param(AQuantity The quantity to test.)
  }
  function GreaterThanOrEqualToZero(const AQuantity: TRealQuantity): boolean;

  { Returns @true if the quantity is strictly greater than zero.
    @param(AQuantity The quantity to test.)
  }
  function GreaterThanZero(const AQuantity: TRealQuantity): boolean;

const
  { Avogadro constant @code(Nₐ = 6.02214076 × 10²³ mol⁻¹).
    Number of constituent particles per mole of substance.
  }
  AvogadroConstant               : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole: -60; FCandela: 0; FSteradian: 0); FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}

  { Bohr magneton @code(μB = 9.2740100657 × 10⁻²⁴ J·T⁻¹).
    Natural unit of electronic magnetic dipole moment.
  }
  BohrMagneton                   : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:  120; FSecond:    0; FAmpere:   60; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}

  { Bohr radius @code(a₀ = 5.29177210903 × 10⁻¹¹ m).
    Most probable distance between the electron and nucleus in a hydrogen atom ground state.
  }
  BohrRadius                     : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}

  { Boltzmann constant @code(kB = 1.380649 × 10⁻²³ J·K⁻¹).
    Relates the average kinetic energy of particles in a gas to the thermodynamic temperature.
  }
  BoltzmannConstant              : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond: -120; FAmpere:    0; FKelvin: -60; FMole:   0; FCandela: 0; FSteradian: 0); FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}

  { Compton wavelength @code(λC = 2.42631023867 × 10⁻¹² m).
    Quantum mechanical property of the electron; sets the scale at which quantum field effects become significant.
  }
  ComptonWaveLength              : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}

  { Coulomb constant @code(ke = 8.9875517923 × 10⁹ N·m²·C⁻²).
    Proportionality constant in Coulomb's law of electrostatic force.
  }
  CoulombConstant                : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  180; FSecond: -240; FAmpere: -120; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}

  { Deuteron mass @code(m_d = 3.3435837768 × 10⁻²⁷ kg).
    Rest mass of the deuteron (nucleus of deuterium, one proton and one neutron).
  }
  DeuteronMass                   : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}

  { Electric permittivity of free space @code(ε₀ = 8.8541878188 × 10⁻¹² F·m⁻¹).
    Relates electric field to electric displacement field in a vacuum.
  }
  ElectricPermittivity           : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter: -180; FSecond:  240; FAmpere:  120; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     8.8541878188E-12); {$ELSE} (    8.8541878188E-12); {$ENDIF}

  { Electron rest mass @code(m_e = 9.1093837015 × 10⁻³¹ kg).
    Rest mass of the electron.
  }
  ElectronMass                   : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}

  { Elementary charge @code(e = 1.602176634 × 10⁻¹⁹ C).
      Electric charge carried by a single proton; the fundamental unit of electric charge.
  }
  ElectronCharge                 : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:   60; FAmpere:   60; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}

  { Fine-structure constant @code(α = 7.2973525643 × 10⁻³) (dimensionless).
    Characterises the strength of the electromagnetic interaction between elementary charged particles.
  }
  FineStructureConstant          : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      7.2973525643E-3); {$ELSE} (     7.2973525643E-3); {$ENDIF}

  { Inverse fine-structure constant @code(α⁻¹ = 137.035999177) (dimensionless).
    Reciprocal of the fine-structure constant; often used in quantum electrodynamics.
  }
  InverseFineStructureConstant   : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:        137.035999177); {$ELSE} (       137.035999177); {$ENDIF}

  { Magnetic permeability of free space @code(μ₀ = 1.25663706212 × 10⁻⁶ H·m⁻¹).
    Relates magnetic field intensity to magnetic flux density in a vacuum.
  }
  MagneticPermeability           : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:   60; FSecond: -120; FAmpere: -120; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}

  { Molar gas constant @code(R = 8.314462618 J·mol⁻¹·K⁻¹).
    Relates energy to temperature and amount of substance in the ideal gas law.
  }
  MolarGasConstant               : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond: -120; FAmpere:    0; FKelvin: -60; FMole: -60; FCandela: 0; FSteradian: 0); FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}

  { Neutron rest mass @code(m_n = 1.67492750056 × 10⁻²⁷ kg).
    Rest mass of the neutron.
  }
  NeutronRestMass                : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}

  { Newtonian constant of gravitation @code(G = 6.67430 × 10⁻¹¹ m³·kg⁻¹·s⁻²).
    Proportionality constant in Newton's law of universal gravitation.
  }
  NewtonianConstantOfGravitation : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram: -60; FMeter:  180; FSecond: -120; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}

  { Planck constant @code(h = 6.62607015 × 10⁻³⁴ J·s).
    Relates the energy of a photon to its frequency; fundamental constant of quantum mechanics.
  }
  PlanckConstant                 : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond:  -60; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}

  { Proton rest mass @code(m_p = 1.67262192595 × 10⁻²⁷ kg).
    Rest mass of the proton.
  }
  ProtonRestMass                 : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}

  { Rydberg constant @code(R∞ = 10973731.568157 m⁻¹).
    Relates the wavelengths of spectral lines of the hydrogen atom.
  }
  RydbergConstant                : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:  -60; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}

  { Speed of light in vacuum @code(c = 299792458 m·s⁻¹).
    Exact defined value; maximum speed of propagation of any physical interaction.
  }
  SpeedOfLight                   : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond:  -60; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}

  { Squared speed of light in vacuum @code(c² = 8.98755178736818 × 10¹⁶ m²·s⁻²).
    Appears in the mass-energy equivalence relation @code(E = mc²).
  }
  SquaredSpeedOfLight            : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:  120; FSecond: -120; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}

  { Standard acceleration of gravity @code(g = 9.80665 m·s⁻²).
    Conventional standard value of the acceleration due to Earth's gravity at sea level.
  }
  StandardAccelerationOfGravity  : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:   0; FMeter:   60; FSecond: -120; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}

  { Reduced Planck constant @code(ℏ = h / (2π) = 1.054571817 × 10⁻³⁴ J·s).
    Also called the Dirac constant; appears in quantum mechanics wherever angular frequency is used.
  }
  ReducedPlanckConstant          : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:  120; FSecond:  -60; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}

  { Unified atomic mass unit @code(u = 1.66053906892 × 10⁻²⁷ kg).
    Defined as one twelfth of the mass of a carbon-12 atom at rest.
  }
  UnifiedAtomicMassUnit          : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond:    0; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}

  { Reference sound intensity @code(I₀ = 10⁻¹² W·m⁻²).
    Conventional threshold of human hearing at 1 kHz; used as the reference level
    for the decibel scale of sound intensity.
  }
  SoundIntensityReference        : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FKilogram:  60; FMeter:    0; FSecond: -180; FAmpere:    0; FKelvin:   0; FMole:   0; FCandela: 0; FSteradian: 0); FValue:                1E-12); {$ELSE} (               1E-12); {$ENDIF}

const
  { Prefix Table } { @exclude }

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




{ @exclude } function  CheckEqual(ALeft, ARight: TDimension): TDimension; inline;
{ @exclude } function  CheckSum  (ALeft, ARight: TDimension): TDimension; inline;
{ @exclude } function  CheckSub  (ALeft, ARight: TDimension): TDimension; inline;
{ @exclude } function  CheckMul  (ALeft, ARight: TDimension): TDimension; inline;
{ @exclude } function  CheckDiv  (ALeft, ARight: TDimension): TDimension; inline;
{ @exclude } procedure Check     (ALeft, ARight: TDimension); inline;

implementation

uses Math;

function UseSingularUnitName(const AValue: TReal): boolean; inline;
begin
  result := Math.SameValue(System.Abs(AValue), 1.0, DefaultEpsilon);
end;

function OddRoot(const AValue: TReal; const ADegree: longint): TReal; inline;
begin
  if AValue < 0 then
    result := -Math.Power(-AValue, 1.0 / ADegree)
  else
    result := Math.Power(AValue, 1.0 / ADegree);
end;

const
  CelsiusZeroInKelvin: TReal = 273.15;
  FahrenheitFreezingPoint: TReal = 32.0;
  FahrenheitZeroInDegrees: TReal = 459.67;
  KelvinPerFahrenheitDegree: TReal = 5.0 / 9.0;
  FahrenheitDegreesPerKelvin: TReal = 9.0 / 5.0;

function CelsiusPointToKelvin(const AValue: TReal): TReal; inline;
begin
  result := AValue + CelsiusZeroInKelvin;
end;

function KelvinPointToCelsius(const AValue: TReal): TReal; inline;
begin
  result := AValue - CelsiusZeroInKelvin;
end;

function FahrenheitPointToKelvin(const AValue: TReal): TReal; inline;
begin
  result := (AValue - FahrenheitFreezingPoint) * KelvinPerFahrenheitDegree +
    CelsiusZeroInKelvin;
end;

function KelvinPointToFahrenheit(const AValue: TReal): TReal; inline;
begin
  result := AValue * FahrenheitDegreesPerKelvin - FahrenheitZeroInDegrees;
end;

function KelvinIntervalToCelsius(const AValue: TReal): TReal; inline;
begin
  result := AValue;
end;

function KelvinIntervalToFahrenheit(const AValue: TReal): TReal; inline;
begin
  result := AValue * FahrenheitDegreesPerKelvin;
end;

function FormatPrefixTemplate(const ATemplate: string;
  const APrefixes: TPrefixes; const AUseSymbols: boolean): string;

  function PrefixText(const AIndex: longint): string; inline;
  begin
    if AUseSymbols then
      result := PrefixTable[APrefixes[AIndex]].Symbol
    else
      result := PrefixTable[APrefixes[AIndex]].Name;
  end;

begin
  case Length(APrefixes) of
    0: result := ATemplate;
    1: result := Format(ATemplate, [PrefixText(0)]);
    2: result := Format(ATemplate, [PrefixText(0), PrefixText(1)]);
    3: result := Format(ATemplate, [PrefixText(0), PrefixText(1),
         PrefixText(2)]);
    4: result := Format(ATemplate, [PrefixText(0), PrefixText(1),
         PrefixText(2), PrefixText(3)]);
    5: result := Format(ATemplate, [PrefixText(0), PrefixText(1),
         PrefixText(2), PrefixText(3), PrefixText(4)]);
    6: result := Format(ATemplate, [PrefixText(0), PrefixText(1),
         PrefixText(2), PrefixText(3), PrefixText(4), PrefixText(5)]);
    7: result := Format(ATemplate, [PrefixText(0), PrefixText(1),
         PrefixText(2), PrefixText(3), PrefixText(4), PrefixText(5),
         PrefixText(6)]);
  else
    raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function FormatUnitText(const ATemplate: string; const APrefixes,
  ADefaultPrefixes: TPrefixes; const AUseSymbols: boolean): string;
var
  LPrefixes: TPrefixes;
begin
  LPrefixes := APrefixes;
  if Length(LPrefixes) = 0 then
    LPrefixes := ADefaultPrefixes
  else if Length(LPrefixes) <> Length(ADefaultPrefixes) then
    raise Exception.Create('Wrong number of prefixes.');
  result := FormatPrefixTemplate(ATemplate, LPrefixes, AUseSymbols);
end;

function FormatAffineUnitText(const ATemplate: string;
  const APrefixes: TPrefixes; const AUseSymbols: boolean): string;
begin
  if Length(APrefixes) > 1 then
    raise Exception.Create('Wrong number of prefixes.');
  result := FormatPrefixTemplate(ATemplate, APrefixes, AUseSymbols);
end;

function PrefixScale(const AUnitPrefixes: TPrefixes;
  const AExponents: TExponents; const APrefixes: TPrefixes): TReal;
var
  I: longint;
  LExponent: longint;
begin
  if Length(APrefixes) = 0 then Exit(1);
  if Length(APrefixes) <> Length(AUnitPrefixes) then
    raise Exception.Create('Wrong number of prefixes.');

  LExponent := 0;
  for I := 0 to High(APrefixes) do
    Inc(LExponent, (PrefixTable[AUnitPrefixes[I]].Exponent -
      PrefixTable[APrefixes[I]].Exponent) * AExponents[I]);

  if LExponent = 0 then
    result := 1
  else
    result := IntPower(10, LExponent);
end;

function FormatCompactValue(const AValue: TReal;
  const AUnitSymbol: string): string; inline;
begin
  result := FloatToStr(AValue) + ' ' + AUnitSymbol;
end;

function FormatCompactValueWithPrecision(const AValue: TReal;
  const APrecision, ADigits: longint; const AUnitSymbol: string): string; inline;
begin
  result := FloatToStrF(AValue, ffGeneral, APrecision, ADigits) + ' ' +
    AUnitSymbol;
end;

function FormatCompactTolerance(const AValue, ATolerance: TReal;
  const APrecision, ADigits: longint; const AUnitSymbol: string): string; inline;
begin
  result := FloatToStrF(AValue, ffGeneral, APrecision, ADigits) + ' ± ' +
    FloatToStrF(ATolerance, ffGeneral, APrecision, ADigits) + ' ' + AUnitSymbol;
end;

function FormatVerboseValue(const AValue: TReal; const AUnitName,
  AUnitPluralName: string): string; inline;
begin
  if UseSingularUnitName(AValue) then
    result := FloatToStr(AValue) + ' ' + AUnitName
  else
    result := FloatToStr(AValue) + ' ' + AUnitPluralName;
end;

function FormatVerboseValueWithPrecision(const AValue: TReal;
  const APrecision, ADigits: longint; const AUnitName,
  AUnitPluralName: string): string; inline;
begin
  if UseSingularUnitName(AValue) then
    result := FloatToStrF(AValue, ffGeneral, APrecision, ADigits) + ' ' + AUnitName
  else
    result := FloatToStrF(AValue, ffGeneral, APrecision, ADigits) + ' ' +
      AUnitPluralName;
end;

function FormatVerboseTolerance(const AValue, ATolerance: TReal;
  const APrecision, ADigits: longint; const AUnitName,
  AUnitPluralName: string): string; inline;
var
  LUnitText: string;
begin
  if UseSingularUnitName(AValue) then
    LUnitText := AUnitName
  else
    LUnitText := AUnitPluralName;
  result := FloatToStrF(AValue, ffGeneral, APrecision, ADigits) + ' ± ' +
    FloatToStrF(ATolerance, ffGeneral, APrecision, ADigits) + ' ' + LUnitText;
end;

{$IFNDEF ADIMOFF}

{ FPC 3.2.2 does not resolve ADimMath helpers through a field of a generic
  specialization. These adapters keep the input passed by reference and avoid
  the deep copies that a local TRealVector/TMatrix assignment would trigger. }

function RawRealVectorCross(constref ALeft, ARight: TRealVector): TRealVector; inline;
begin
  result := ALeft.Cross(ARight);
end;

function RawRealVectorToComplex(constref AValue: TRealVector): TComplexVector; inline;
begin
  result := AValue.ToComplex;
end;

function RawComplexVectorConjugate(constref AValue: TComplexVector): TComplexVector; inline;
begin
  result := AValue.Conjugate;
end;

function RawRealMatrixIsOrthogonal(constref AValue: TRealMatrix): boolean; inline;
begin
  result := AValue.IsOrthogonal;
end;

function RawRealMatrixToComplex(constref AValue: TRealMatrix): TComplexMatrix; inline;
begin
  result := AValue.ToComplex;
end;

function RawRealMatrixEigenvalues(constref AValue: TRealMatrix): TComplexVector; inline;
begin
  result := AValue.Eigenvalues;
end;

function RawRealMatrixEigenvectors(constref AValue: TRealMatrix;
  constref AEigenvalues: TComplexVector): TComplexMatrix; inline;
begin
  result := AValue.Eigenvectors(AEigenvalues);
end;

function RawComplexMatrixConjugate(constref AValue: TComplexMatrix): TComplexMatrix; inline;
begin
  result := AValue.Conjugate;
end;

function RawComplexMatrixEigenvalues(constref AValue: TComplexMatrix): TComplexVector; inline;
begin
  result := AValue.Eigenvalues;
end;

function RawComplexMatrixEigenvectors(constref AValue: TComplexMatrix;
  constref AEigenvalues: TComplexVector): TComplexMatrix; inline;
begin
  result := AValue.Eigenvectors(AEigenvalues);
end;

function RawComplexMatrixIsUnitary(constref AValue: TComplexMatrix): boolean; inline;
begin
  result := AValue.IsUnitary;
end;

function RawComplexMatrixTransposeConjugate(
  constref AValue: TComplexMatrix): TComplexMatrix; inline;
begin
  result := AValue.TransposeConjugate;
end;

{ TQuantity<T> }

function TQuantity.Reciprocal: TQuantity;
begin
  result.FDim := -FDim;
  result.FValue := 1 / FValue;
end;

class operator TQuantity.:=(const AValue: T): TQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;

class operator TQuantity.=(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TQuantity.<>(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
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

class operator TQuantity.*(const ALeft: T; const ARight: TQuantity): TQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: T): TQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

class operator TQuantity./(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: T): TQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

{ Scalar specializations }

function TRealQuantityHelper.SameValue(const AQuantity: TRealQuantity): boolean;
begin
  Check(Self.FDim, AQuantity.FDim);
  result := Math.SameValue(Self.FValue, AQuantity.FValue, DefaultEpsilon);
end;

function TComplexQuantityHelper.Conjugate: TComplexQuantity;
begin
  result.FDim := Self.FDim;
  result.FValue := Self.FValue.Conjugate;
end;

function TComplexQuantityHelper.Norm: TRealQuantity;
begin
  result.FDim := Self.FDim;
  result.FValue := Self.FValue.Norm;
end;

function TComplexQuantityHelper.SameValue(const AQuantity: TComplexQuantity): boolean;
begin
  Check(Self.FDim, AQuantity.FDim);
  result := Self.FValue.SameValue(AQuantity.FValue);
end;

function TComplexQuantityHelper.SquaredNorm: TRealQuantity;
begin
  result.FDim := Self.FDim * 2;
  result.FValue := Self.FValue.SquaredNorm;
end;

operator :=(const AValue: TRealQuantity): TComplexQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

operator <(const ALeft, ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue < ARight.FValue;
end;

operator >(const ALeft, ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue > ARight.FValue;
end;

operator <=(const ALeft, ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <= ARight.FValue;
end;

operator >=(const ALeft, ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue >= ARight.FValue;
end;

operator /(const ALeft: TReal; const ARight: TRealQuantity): TRealQuantity;
begin
  result.FDim := -ARight.FDim;
  result.FValue := ALeft / ARight.FValue;
end;

operator /(const ALeft: TComplex; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := -ARight.FDim;
  result.FValue := ALeft / ARight.FValue;
end;

operator +(const ALeft: TRealQuantity; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

operator +(const ALeft: TComplexQuantity; const ARight: TRealQuantity): TComplexQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

operator -(const ALeft: TRealQuantity; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

operator -(const ALeft: TComplexQuantity; const ARight: TRealQuantity): TComplexQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

operator *(const ALeft: TComplexQuantity; const ARight: TRealQuantity): TComplexQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

operator /(const ALeft: TRealQuantity; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

operator /(const ALeft: TComplexQuantity; const ARight: TRealQuantity): TComplexQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TImaginaryUnit): TComplexQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TImaginaryUnit; const ARight: TRealQuantity): TComplexQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator /(const ALeft: TRealQuantity; const ARight: TImaginaryUnit): TComplexQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

operator /(const ALeft: TImaginaryUnit; const ARight: TRealQuantity): TComplexQuantity;
begin
  result.FDim := -ARight.FDim;
  result.FValue := ALeft / ARight.FValue;
end;

{ TVectorQuantity<T> }

function TVectorQuantity.Get(AIndex: longint): TScalarQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue[AIndex];
end;

procedure TVectorQuantity.Put(AIndex: longint; const AQuantity: TScalarQuantity);
begin
  Check(FDim, AQuantity.FDim);
  FValue[AIndex] := AQuantity.FValue;
end;

function TVectorQuantity.Size: longint;
begin
  result := FValue.Size;
end;

function TVectorQuantity.Dot(const AVector: TVectorQuantity): TScalarQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVectorQuantity.IsNull: boolean;
begin
  result := FValue.IsNull;
end;

function TVectorQuantity.IsNotNull: boolean;
begin
  result := FValue.IsNotNull;
end;

function TVectorQuantity.Norm: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TVectorQuantity.SquaredNorm: TRealQuantity;
begin
  result.FDim := FDim * 2;
  result.FValue := FValue.SquaredNorm;
end;

function TVectorQuantity.Normalize: TValueVector;
begin
  result := FValue.Normalize;
end;

function TVectorQuantity.Reciprocal: TVectorQuantity;
begin
  result.FDim := -FDim;
  result.FValue := FValue.Reciprocal;
end;

function TVectorQuantity.ToString: string;
begin
  result := FValue.ToString;
end;

class operator TVectorQuantity.=(const ALeft, ARight: TVectorQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TVectorQuantity.<>(const ALeft, ARight: TVectorQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVectorQuantity.+(const ASelf: TVectorQuantity): TVectorQuantity;
begin
  result.FDim := ASelf.FDim;
  result.FValue := ASelf.FValue;
end;

class operator TVectorQuantity.-(const ASelf: TVectorQuantity): TVectorQuantity;
begin
  result.FDim := ASelf.FDim;
  result.FValue := -ASelf.FValue;
end;

class operator TVectorQuantity.+(const ALeft, ARight: TVectorQuantity): TVectorQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVectorQuantity.-(const ALeft, ARight: TVectorQuantity): TVectorQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVectorQuantity.*(const ALeft, ARight: TVectorQuantity): TScalarQuantity;
begin
  result := ALeft.Dot(ARight);
end;

class operator TVectorQuantity.*(const ALeft: TScalarQuantity; const ARight: TVectorQuantity): TVectorQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVectorQuantity.*(const ALeft: TVectorQuantity; const ARight: TScalarQuantity): TVectorQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVectorQuantity./(const ALeft: TVectorQuantity; const ARight: TScalarQuantity): TVectorQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

function TRealVectorQuantityHelper.Cross(const AVector: TRealVectorQuantity): TRealVectorQuantity;
begin
  result.FDim := CheckMul(Self.FDim, AVector.FDim);
  result.FValue := RawRealVectorCross(Self.FValue, AVector.FValue);
end;

function TRealVectorQuantityHelper.SameValue(const AVector: TRealVectorQuantity): boolean;
var
  LIndex: longint;
begin
  Check(Self.FDim, AVector.FDim);
  if Self.Size <> AVector.Size then Exit(False);
  for LIndex := 0 to Self.Size - 1 do
    if not Math.SameValue(Self.FValue[LIndex], AVector.FValue[LIndex], DefaultEpsilon) then
      Exit(False);
  result := True;
end;

function TRealVectorQuantityHelper.ToComplex: TComplexVectorQuantity;
begin
  result.FDim := Self.FDim;
  result.FValue := RawRealVectorToComplex(Self.FValue);
end;

function TComplexVectorQuantityHelper.Conjugate: TComplexVectorQuantity;
begin
  result.FDim := Self.FDim;
  result.FValue := RawComplexVectorConjugate(Self.FValue);
end;

function TComplexVectorQuantityHelper.SameValue(const AVector: TComplexVectorQuantity): boolean;
var
  LIndex: longint;
begin
  Check(Self.FDim, AVector.FDim);
  if Self.Size <> AVector.Size then Exit(False);
  for LIndex := 0 to Self.Size - 1 do
    if not Self.FValue[LIndex].SameValue(AVector.FValue[LIndex]) then Exit(False);
  result := True;
end;

{ TMatrixQuantity<T> }

function TMatrixQuantity.Get(ARow, ACol: longint): TScalarQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue[ARow, ACol];
end;

procedure TMatrixQuantity.Put(ARow, ACol: longint; const AQuantity: TScalarQuantity);
begin
  Check(FDim, AQuantity.FDim);
  FValue[ARow, ACol] := AQuantity.FValue;
end;

function TMatrixQuantity.Order: longint;
begin
  result := FValue.Order;
end;

function TMatrixQuantity.SolveLinear(const AData: TVectorQuantityType): TVectorQuantityType;
begin
  result.FDim := CheckDiv(AData.FDim, FDim);
  result.FValue := FValue.SolveLinear(AData.FValue);
end;

function TMatrixQuantity.Identity: TValueMatrix;
begin
  result := FValue.Identity;
end;

function TMatrixQuantity.Null: TMatrixQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Null;
end;

function TMatrixQuantity.Diagonalize(const ADiagonal: TVectorQuantityType): TMatrixQuantity;
begin
  result.FDim := ADiagonal.FDim;
  result.FValue := FValue.Diagonalize(ADiagonal.FValue);
end;

function TMatrixQuantity.IsNull: boolean;
begin
  result := FValue.IsNull;
end;

function TMatrixQuantity.IsNotNull: boolean;
begin
  result := FValue.IsNotNull;
end;

function TMatrixQuantity.Determinant: TScalarQuantity;
begin
  result.FDim := FDim * Order;
  result.FValue := FValue.Determinant;
end;

function TMatrixQuantity.Norm: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TMatrixQuantity.Rank: longint;
begin
  result := FValue.Rank;
end;

function TMatrixQuantity.Trace: TScalarQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Trace;
end;

function TMatrixQuantity.Clone: TMatrixQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Clone;
end;

function TMatrixQuantity.Transpose: TMatrixQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Transpose;
end;

function TMatrixQuantity.Inverse: TMatrixQuantity;
begin
  result.FDim := -FDim;
  result.FValue := FValue.Inverse;
end;

function TMatrixQuantity.RowReduction: TValueMatrix;
begin
  result := FValue.RowReduction;
end;

procedure TMatrixQuantity.Swap(ARow1, ARow2: longint);
begin
  FValue.Swap(ARow1, ARow2);
end;

function TMatrixQuantity.ToString: string;
begin
  result := FValue.ToString;
end;

function TMatrixQuantity.ToString(APrecision, ADigits: integer): string;
begin
  result := FValue.ToString(APrecision, ADigits);
end;

class operator TMatrixQuantity.=(const ALeft, ARight: TMatrixQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TMatrixQuantity.<>(const ALeft, ARight: TMatrixQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TMatrixQuantity.+(const ALeft, ARight: TMatrixQuantity): TMatrixQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TMatrixQuantity.-(const ALeft, ARight: TMatrixQuantity): TMatrixQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TMatrixQuantity.*(const ALeft: TScalarQuantity; const ARight: TMatrixQuantity): TMatrixQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TMatrixQuantity.*(const ALeft: TMatrixQuantity; const ARight: TScalarQuantity): TMatrixQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TMatrixQuantity./(const ALeft: TMatrixQuantity; const ARight: TScalarQuantity): TMatrixQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

function TRealMatrixQuantityHelper.IsOrthogonal: boolean;
begin
  Check(Self.FDim, ScalarUnit.FDim);
  result := RawRealMatrixIsOrthogonal(Self.FValue);
end;

function TRealMatrixQuantityHelper.SameValue(const AMatrix: TRealMatrixQuantity): boolean;
begin
  Check(Self.FDim, AMatrix.FDim);
  result := Self.FValue.SameValue(AMatrix.FValue);
end;

function TRealMatrixQuantityHelper.ToComplex: TComplexMatrixQuantity;
begin
  result.FDim := Self.FDim;
  result.FValue := RawRealMatrixToComplex(Self.FValue);
end;

function TRealMatrixQuantityHelper.Eigenvalues: TComplexVectorQuantity;
begin
  result.FDim := Self.FDim;
  result.FValue := RawRealMatrixEigenvalues(Self.FValue);
end;

function TRealMatrixQuantityHelper.Eigenvectors(const AEigenvalues: TComplexVectorQuantity): TComplexMatrix;
begin
  Check(Self.FDim, AEigenvalues.FDim);
  result := RawRealMatrixEigenvectors(Self.FValue, AEigenvalues.FValue);
end;

function TComplexMatrixQuantityHelper.Conjugate: TComplexMatrixQuantity;
begin
  result.FDim := Self.FDim;
  result.FValue := RawComplexMatrixConjugate(Self.FValue);
end;

function TComplexMatrixQuantityHelper.Eigenvalues: TComplexVectorQuantity;
begin
  result.FDim := Self.FDim;
  result.FValue := RawComplexMatrixEigenvalues(Self.FValue);
end;

function TComplexMatrixQuantityHelper.Eigenvectors(const AEigenvalues: TComplexVectorQuantity): TComplexMatrix;
begin
  Check(Self.FDim, AEigenvalues.FDim);
  result := RawComplexMatrixEigenvectors(Self.FValue, AEigenvalues.FValue);
end;

function TComplexMatrixQuantityHelper.IsHermitian: boolean;
var
  LRow, LColumn: longint;
begin
  for LRow := 0 to Self.Order - 1 do
    for LColumn := LRow to Self.Order - 1 do
      if not Self.FValue[LRow, LColumn].SameValue(
        Self.FValue[LColumn, LRow].Conjugate) then Exit(False);
  result := True;
end;

function TComplexMatrixQuantityHelper.IsUnitary: boolean;
begin
  Check(Self.FDim, ScalarUnit.FDim);
  result := RawComplexMatrixIsUnitary(Self.FValue);
end;

function TComplexMatrixQuantityHelper.SameValue(const AMatrix: TComplexMatrixQuantity): boolean;
begin
  Check(Self.FDim, AMatrix.FDim);
  result := Self.FValue.SameValue(AMatrix.FValue);
end;

function TComplexMatrixQuantityHelper.TransposeConjugate: TComplexMatrixQuantity;
begin
  result.FDim := Self.FDim;
  result.FValue := RawComplexMatrixTransposeConjugate(Self.FValue);
end;

operator *(const ALeft, ARight: TRealMatrixQuantity): TRealMatrixQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

operator *(const ALeft, ARight: TComplexMatrixQuantity): TComplexMatrixQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

operator *(const ALeft: TRealMatrixQuantity; const ARight: TRealVectorQuantity): TRealVectorQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

operator *(const ALeft: TRealVectorQuantity; const ARight: TRealMatrixQuantity): TRealVectorQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

operator *(const ALeft: TComplexMatrixQuantity; const ARight: TComplexVectorQuantity): TComplexVectorQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

operator *(const ALeft: TComplexVectorQuantity; const ARight: TComplexMatrixQuantity): TComplexVectorQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

{$ENDIF}


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

class operator TCL3MultivecQuantity./(const ALeft: TReal; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft * ARight.FValue.Reciprocal;
end;

class operator TCL3MultivecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TReal): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL3MultivecQuantity.<>(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3MultivecQuantity.<>(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3MultivecQuantity.=(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3MultivecQuantity.=(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3MultivecQuantity.+(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3MultivecQuantity.+(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3MultivecQuantity.-(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3MultivecQuantity.-(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3MultivecQuantity.*(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3MultivecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3MultivecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3MultivecQuantity./(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
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

class operator TCL3TrivecQuantity./(const ALeft: TReal; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft * ARight.FValue.Reciprocal;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TReal): TCL3TrivecQuantity;
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

class operator TCL3TrivecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft, ARight: TCL3TrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft, ARight: TCL3TrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
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

class operator TCL3BivecQuantity./(const ALeft: TReal; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft * ARight.FValue.Reciprocal;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TReal): TCL3BivecQuantity;
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

class operator TCL3BivecQuantity.+(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
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

class operator TCL3VecQuantity./(const ALeft: TReal; const ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3VecQuantity; const ARight: TReal): TCL3VecQuantity;
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

class operator TCL3VecQuantity.+(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity./ (const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3VecQuantity./(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
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

function TCL3MultivecQuantityHelper.Norm: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL3MultivecQuantityHelper.SquaredNorm: TRealQuantity;
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

function TCL3MultivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity;
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

function TCL3MultivecQuantityHelper.SameValue(const AVector: TRealQuantity): boolean;
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

function TCL3MultivecQuantityHelper.ExtractScalar: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractScalar;
end;

function TCL3MultivecQuantityHelper.IsNull: boolean;
begin
  result := FValue.IsNull;
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
function TCL3TrivecQuantityHelper.Dual: TRealQuantity;
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

function TCL3TrivecQuantityHelper.Norm: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL3TrivecQuantityHelper.SquaredNorm: TRealQuantity;
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

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3VecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TRealQuantity;
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

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3VecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity;
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

function TCL3BivecQuantityHelper.Norm: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL3BivecQuantityHelper.SquaredNorm: TRealQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL3BivecQuantityHelper.Dot(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Dot(const AVector: TCL3BivecQuantity): TRealQuantity;
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

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := 0.0;
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TRealQuantity;
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

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity;
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

function TCL3VecQuantityHelper.Norm: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL3VecQuantityHelper.SquaredNorm: TRealQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL3VecQuantityHelper.Dot(const AVector: TCL3VecQuantity): TRealQuantity;
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

function TCL3VecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TRealQuantity;
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

function TCL3VecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity;
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

{$IFNDEF ADIMOFF}
function SameValueEx(const ALeft, ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ADimMath.SameValueEx(ALeft.FValue, ARight.FValue);
end;
{$ENDIF}





{$IFNDEF ADIMOFF}
  {$ASSERTIONS ON}
{$ENDIF}

// TUnit

class operator TUnit.*(const AValue: TReal; const ASelf: TUnit): TRealQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TReal; const ASelf: TUnit): TRealQuantity; inline;
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

class operator TUnit.*(const AVector: TRealVector; const ASelf: TUnit): TRealVectorQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TRealVector; const ASelf: TUnit): TRealVectorQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit.*(const AVector: TComplexVector; const ASelf: TUnit): TComplexVectorQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit./(const AVector: TComplexVector; const ASelf: TUnit): TComplexVectorQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector;
{$ELSE}
  result := AVector;
{$ENDIF}
end;

class operator TUnit.*(const AMatrix: TRealMatrix; const ASelf: TUnit): TRealMatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit./(const AMatrix: TRealMatrix; const ASelf: TUnit): TRealMatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit.*(const AMatrix: TComplexMatrix; const ASelf: TUnit): TComplexMatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix;
{$ELSE}
  result := AMatrix;
{$ENDIF}
end;

class operator TUnit./(const AMatrix: TComplexMatrix; const ASelf: TUnit): TComplexMatrixQuantity; inline;
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

class operator TUnit.*(const AQuantity: TRealQuantity; const ASelf: TUnit): TRealQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TRealQuantity; const ASelf: TUnit): TRealQuantity; inline;
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

class operator TUnit.*(const AQuantity: TRealVectorQuantity; const ASelf: TUnit): TRealVectorQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TRealVectorQuantity; const ASelf: TUnit): TRealVectorQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TComplexVectorQuantity; const ASelf: TUnit): TComplexVectorQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TComplexVectorQuantity; const ASelf: TUnit): TComplexVectorQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TRealMatrixQuantity; const ASelf: TUnit): TRealMatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TRealMatrixQuantity; const ASelf: TUnit): TRealMatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TComplexMatrixQuantity; const ASelf: TUnit): TComplexMatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TComplexMatrixQuantity; const ASelf: TUnit): TComplexMatrixQuantity; inline;
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

class operator TFactoredUnit.*(const AValue: TReal; const ASelf: TFactoredUnit): TRealQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue * ASelf.FFactor;
{$ELSE}
  result := AValue * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AValue: TReal; const ASelf: TFactoredUnit): TRealQuantity; inline;
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

class operator TFactoredUnit.*(const AVector: TRealVector; const ASelf: TFactoredUnit): TRealVectorQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector * ASelf.FFactor;
{$ELSE}
  result := AVector * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AVector: TRealVector; const ASelf: TFactoredUnit): TRealVectorQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector / ASelf.FFactor;
{$ELSE}
  result := AVector / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AVector: TComplexVector; const ASelf: TFactoredUnit): TComplexVectorQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AVector * ASelf.FFactor;
{$ELSE}
  result := AVector * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AVector: TComplexVector; const ASelf: TFactoredUnit): TComplexVectorQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AVector / ASelf.FFactor;
{$ELSE}
  result := AVector / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AMatrix: TRealMatrix; const ASelf: TFactoredUnit): TRealMatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix * ASelf.FFactor;
{$ELSE}
  result := AMatrix * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AMatrix: TRealMatrix; const ASelf: TFactoredUnit): TRealMatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AMatrix / ASelf.FFactor;
{$ELSE}
  result := AMatrix / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AMatrix: TComplexMatrix; const ASelf: TFactoredUnit): TComplexMatrixQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AMatrix * ASelf.FFactor;
{$ELSE}
  result := AMatrix * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AMatrix: TComplexMatrix; const ASelf: TFactoredUnit): TComplexMatrixQuantity; inline;
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

class operator TFactoredUnit.*(const AQuantity: TRealQuantity; const ASelf: TFactoredUnit): TRealQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TRealQuantity; const ASelf: TFactoredUnit): TRealQuantity; inline;
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

class operator TFactoredUnit.*(const AQuantity: TRealVectorQuantity; const ASelf: TFactoredUnit): TRealVectorQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TRealVectorQuantity; const ASelf: TFactoredUnit): TRealVectorQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TComplexVectorQuantity; const ASelf: TFactoredUnit): TComplexVectorQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TComplexVectorQuantity; const ASelf: TFactoredUnit): TComplexVectorQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TRealMatrixQuantity; const ASelf: TFactoredUnit): TRealMatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TRealMatrixQuantity; const ASelf: TFactoredUnit): TRealMatrixQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TComplexMatrixQuantity; const ASelf: TFactoredUnit): TComplexMatrixQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TComplexMatrixQuantity; const ASelf: TFactoredUnit): TComplexMatrixQuantity; inline;
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

class operator TDegreeCelsiusUnit.*(const AValue: TReal; const ASelf: TDegreeCelsiusUnit): TRealQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := CelsiusPointToKelvin(AValue);
{$ELSE}
  result := CelsiusPointToKelvin(AValue);
{$ENDIF}
end;

// TDegreeFahrenheitUnit

class operator TDegreeFahrenheitUnit.*(const AValue: TReal; const ASelf: TDegreeFahrenheitUnit): TRealQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := FahrenheitPointToKelvin(AValue);
{$ELSE}
  result := FahrenheitPointToKelvin(AValue);
{$ENDIF}
end;

// TUnitHelper

function TUnitHelper.GetName(Prefixes: TPrefixes): string;
begin
  result := FormatUnitText(FName, Prefixes, FPrefixes, False);
end;

function TUnitHelper.GetPluralName(Prefixes: TPrefixes): string;
begin
  result := FormatUnitText(FPluralName, Prefixes, FPrefixes, False);
end;

function TUnitHelper.GetSymbol(Prefixes: TPrefixes): string;
begin
  result := FormatUnitText(FSymbol, Prefixes, FPrefixes, True);
end;

function TUnitHelper.GetValue(const AQuantity: TReal; const APrefixes: TPrefixes): TReal;
begin
  result := AQuantity * PrefixScale(FPrefixes, FExponents, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TComplex; const APrefixes: TPrefixes): TComplex;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TRealVector; const APrefixes: TPrefixes): TRealVector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TComplexVector; const APrefixes: TPrefixes): TComplexVector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TRealMatrix; const APrefixes: TPrefixes): TRealMatrix;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TComplexMatrix; const APrefixes: TPrefixes): TComplexMatrix;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL3Vector; const APrefixes: TPrefixes): TCL3Vector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL3Bivector; const APrefixes: TPrefixes): TCL3Bivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL3Trivector; const APrefixes: TPrefixes): TCL3Trivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL3Multivector; const APrefixes: TPrefixes): TCL3Multivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.ToFloat(const AQuantity: TRealQuantity): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToFloat(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TRealQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := FormatCompactValue(AQuantity.FValue, GetSymbol(FPrefixes));
{$ELSE}
  result := FormatCompactValue(AQuantity, GetSymbol(FPrefixes));
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  result := FormatCompactValue(FactoredValue, GetSymbol(APrefixes));
end;

function TUnitHelper.ToString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  result := FormatCompactValueWithPrecision(FactoredValue, APrecision,
    ADigits, GetSymbol(APrefixes));
end;

function TUnitHelper.ToString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: TReal;
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  Check(FDim, ATolerance.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

  result := FormatCompactTolerance(FactoredValue, FactoredTol, APrecision,
    ADigits, GetSymbol(APrefixes));
end;

function TUnitHelper.ToVerboseString(const AQuantity: TRealQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := FormatVerboseValue(AQuantity.FValue, GetName(FPrefixes),
    GetPluralName(FPrefixes));
{$ELSE}
  result := FormatVerboseValue(AQuantity, GetName(FPrefixes),
    GetPluralName(FPrefixes));
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  result := FormatVerboseValue(FactoredValue, GetName(APrefixes),
    GetPluralName(APrefixes));
end;

function TUnitHelper.ToVerboseString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  result := FormatVerboseValueWithPrecision(FactoredValue, APrecision,
    ADigits, GetName(APrefixes), GetPluralName(APrefixes));
end;

function TUnitHelper.ToVerboseString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: TReal;
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  Check(FDim, ATolerance.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

  result := FormatVerboseTolerance(FactoredValue, FactoredTol, APrecision,
    ADigits, GetName(APrefixes), GetPluralName(APrefixes));
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

function TUnitHelper.ToVector(const AQuantity: TRealVectorQuantity): TRealVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): TRealVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TRealVectorQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealVector;
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

function TUnitHelper.ToVerboseString(const AQuantity: TRealVectorQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealVector;
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

function TUnitHelper.ToVector(const AQuantity: TComplexVectorQuantity): TComplexVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): TComplexVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TComplexVectorQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexVector;
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

function TUnitHelper.ToVerboseString(const AQuantity: TComplexVectorQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexVector;
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

function TUnitHelper.ToMatrix(const AQuantity: TRealMatrixQuantity): TRealMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): TRealMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TRealMatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue : TRealMatrix;
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

function TUnitHelper.ToVerboseString(const AQuantity: TRealMatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealMatrix;
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

function TUnitHelper.ToMatrix(const AQuantity: TComplexMatrixQuantity): TComplexMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMatrix(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): TComplexMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);;
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TComplexMatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetSymbol(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue : TComplexMatrix;
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

function TUnitHelper.ToVerboseString(const AQuantity: TComplexMatrixQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue.ToString + ' ' + GetName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexMatrix;
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
  result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes)
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
  result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes)
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
  result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes)
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
  result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes)
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
  result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes)
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
  result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes)
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
  result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes)
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
  result := FactoredValue.ToString + ' ' + GetPluralName(APrefixes)
end;

// TFactoredUnitHelper

function TFactoredUnitHelper.GetName(Prefixes: TPrefixes): string;
begin
  result := FormatUnitText(FName, Prefixes, FPrefixes, False);
end;

function TFactoredUnitHelper.GetPluralName(Prefixes: TPrefixes): string;
begin
  result := FormatUnitText(FPluralName, Prefixes, FPrefixes, False);
end;

function TFactoredUnitHelper.GetSymbol(Prefixes: TPrefixes): string;
begin
  result := FormatUnitText(FSymbol, Prefixes, FPrefixes, True);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TReal; const APrefixes: TPrefixes): TReal;
begin
  result := AQuantity * PrefixScale(FPrefixes, FExponents, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TComplex; const APrefixes: TPrefixes): TComplex;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TRealVector; const APrefixes: TPrefixes): TRealVector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TComplexVector; const APrefixes: TPrefixes): TComplexVector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TRealMatrix; const APrefixes: TPrefixes): TRealMatrix;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TComplexMatrix; const APrefixes: TPrefixes): TComplexMatrix;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL3Vector; const APrefixes: TPrefixes): TCL3Vector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL3Bivector; const APrefixes: TPrefixes): TCL3Bivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL3Trivector; const APrefixes: TPrefixes): TCL3Trivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL3Multivector; const APrefixes: TPrefixes): TCL3Multivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.ToFloat(const AQuantity: TRealQuantity): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToFloat(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TRealQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := FormatCompactValue(AQuantity.FValue / FFactor, GetSymbol(FPrefixes));
{$ELSE}
  result := FormatCompactValue(AQuantity / FFactor, GetSymbol(FPrefixes));
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  result := FormatCompactValue(FactoredValue, GetSymbol(APrefixes));
end;

function TFactoredUnitHelper.ToString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
   Check(FDim, AQuantity.FDim);
   FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
   FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  result := FormatCompactValueWithPrecision(FactoredValue, APrecision,
    ADigits, GetSymbol(APrefixes));
end;

function TFactoredUnitHelper.ToString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: TReal;
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  Check(FDim, ATolerance.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance / FFactor, APrefixes);
{$ENDIF}

  result := FormatCompactTolerance(FactoredValue, FactoredTol, APrecision,
    ADigits, GetSymbol(APrefixes));
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TRealQuantity): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}

  result := FormatVerboseValue(FactoredValue, GetName(FPrefixes),
    GetPluralName(FPrefixes));
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  result := FormatVerboseValue(FactoredValue, GetName(APrefixes),
    GetPluralName(APrefixes));
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}

  result := FormatVerboseValueWithPrecision(FactoredValue, APrecision,
    ADigits, GetName(APrefixes), GetPluralName(APrefixes));
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: TReal;
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  Check(FDim, ATolerance.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
  FactoredTol   := GetValue(ATolerance / FFactor, APrefixes);
{$ENDIF}

  result := FormatVerboseTolerance(FactoredValue, FactoredTol, APrecision,
    ADigits, GetName(APrefixes), GetPluralName(APrefixes));
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

function TFactoredUnitHelper.ToVector(const AQuantity: TRealVectorQuantity): TRealVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): TRealVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TRealVectorQuantity): string;
var
  FactoredValue: TRealVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TRealVectorQuantity): string;
var
  FactoredValue: TRealVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealVector;
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

function TFactoredUnitHelper.ToVector(const AQuantity: TComplexVectorQuantity): TComplexVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): TComplexVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TComplexVectorQuantity): string;
var
  FactoredValue: TComplexVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TComplexVectorQuantity): string;
var
  FactoredValue: TComplexVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexVector;
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

function TFactoredUnitHelper.ToMatrix(const AQuantity: TRealMatrixQuantity): TRealMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): TRealMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TRealMatrixQuantity): string;
var
  FactoredValue: TRealMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TRealMatrixQuantity): string;
var
  FactoredValue: TRealMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealMatrix;
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

function TFactoredUnitHelper.ToMatrix(const AQuantity: TComplexMatrixQuantity): TComplexMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMatrix(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): TComplexMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TComplexMatrixQuantity): string;
var
  FactoredValue: TComplexMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TComplexMatrixQuantity): string;
var
  FactoredValue: TComplexMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := FactoredValue.ToString + ' ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexMatrix;
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
  result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes)
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
  result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes)
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
  result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes)
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
  result := FactoredValue.ToString + ' ' + GetSymbol(APrefixes)
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
begin
  result := FormatAffineUnitText(FName, Prefixes, False);
end;

function TDegreeCelsiusUnitHelper.GetPluralName(const Prefixes: TPrefixes): string;
begin
  result := FormatAffineUnitText(FPluralName, Prefixes, False);
end;

function TDegreeCelsiusUnitHelper.GetSymbol(const Prefixes: TPrefixes): string;
begin
  result := FormatAffineUnitText(FSymbol, Prefixes, True);
end;

function TDegreeCelsiusUnitHelper.GetValue(const AQuantity: TReal; const APrefixes: TPrefixes): TReal;
begin
  result := AQuantity * PrefixScale(FPrefixes, FExponents, APrefixes);
end;

function TDegreeCelsiusUnitHelper.ToFloat(const AQuantity: TRealQuantity): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := KelvinPointToCelsius(AQuantity.FValue);
{$ELSE}
  result := KelvinPointToCelsius(AQuantity);
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToFloat(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(KelvinPointToCelsius(AQuantity.FValue), APrefixes);
{$ELSE}
  result := GetValue(KelvinPointToCelsius(AQuantity), APrefixes);
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TRealQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := FormatCompactValue(KelvinPointToCelsius(AQuantity.FValue),
    GetSymbol(FPrefixes));
{$ELSE}
  result := FormatCompactValue(KelvinPointToCelsius(AQuantity),
    GetSymbol(FPrefixes));
{$ENDIF}
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(KelvinPointToCelsius(AQuantity.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(KelvinPointToCelsius(AQuantity), APrefixes);
{$ENDIF}

  result := FormatCompactValue(FactoredValue, GetSymbol(APrefixes));
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(KelvinPointToCelsius(AQuantity.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(KelvinPointToCelsius(AQuantity), APrefixes);
{$ENDIF}

  result := FormatCompactValueWithPrecision(FactoredValue, APrecision,
    ADigits, GetSymbol(APrefixes));
end;

function TDegreeCelsiusUnitHelper.ToString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: TReal;
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  Check(FDim, ATolerance.FDim);
  FactoredValue := GetValue(KelvinPointToCelsius(AQuantity.FValue), APrefixes);
  FactoredTol   := GetValue(KelvinIntervalToCelsius(ATolerance.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(KelvinPointToCelsius(AQuantity), APrefixes);
  FactoredTol   := GetValue(KelvinIntervalToCelsius(ATolerance), APrefixes);
{$ENDIF}

  result := FormatCompactTolerance(FactoredValue, FactoredTol, APrecision,
    ADigits, GetSymbol(APrefixes));
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TRealQuantity): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := KelvinPointToCelsius(AQuantity.FValue);
{$ELSE}
  FactoredValue := KelvinPointToCelsius(AQuantity);
{$ENDIF}

  result := FormatVerboseValue(FactoredValue, GetName(FPrefixes),
    GetPluralName(FPrefixes));
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(KelvinPointToCelsius(AQuantity.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(KelvinPointToCelsius(AQuantity), APrefixes);
{$ENDIF}

  result := FormatVerboseValue(FactoredValue, GetName(APrefixes),
    GetPluralName(APrefixes));
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(KelvinPointToCelsius(AQuantity.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(KelvinPointToCelsius(AQuantity), APrefixes);
{$ENDIF}

  result := FormatVerboseValueWithPrecision(FactoredValue, APrecision,
    ADigits, GetName(APrefixes), GetPluralName(APrefixes));
end;

function TDegreeCelsiusUnitHelper.ToVerboseString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: TReal;
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  Check(FDim, ATolerance.FDim);
  FactoredValue := GetValue(KelvinPointToCelsius(AQuantity.FValue), APrefixes);
  FactoredTol   := GetValue(KelvinIntervalToCelsius(ATolerance.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(KelvinPointToCelsius(AQuantity), APrefixes);
  FactoredTol   := GetValue(KelvinIntervalToCelsius(ATolerance), APrefixes);
{$ENDIF}

  result := FormatVerboseTolerance(FactoredValue, FactoredTol, APrecision,
    ADigits, GetName(APrefixes), GetPluralName(APrefixes));
end;

// TDegreeFahrenheitUnitHelper

function TDegreeFahrenheitUnitHelper.GetName(const Prefixes: TPrefixes): string;
begin
  result := FormatAffineUnitText(FName, Prefixes, False);
end;

function TDegreeFahrenheitUnitHelper.GetPluralName(const Prefixes: TPrefixes): string;
begin
  result := FormatAffineUnitText(FPluralName, Prefixes, False);
end;

function TDegreeFahrenheitUnitHelper.GetSymbol(const Prefixes: TPrefixes): string;
begin
  result := FormatAffineUnitText(FSymbol, Prefixes, True);
end;

function TDegreeFahrenheitUnitHelper.GetValue(const AQuantity: TReal; const APrefixes: TPrefixes): TReal;
begin
  result := AQuantity * PrefixScale(FPrefixes, FExponents, APrefixes);
end;

function TDegreeFahrenheitUnitHelper.ToFloat(const AQuantity: TRealQuantity): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := KelvinPointToFahrenheit(AQuantity.FValue);
{$ELSE}
  result := KelvinPointToFahrenheit(AQuantity);
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToFloat(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(KelvinPointToFahrenheit(AQuantity.FValue), APrefixes);
{$ELSE}
  result := GetValue(KelvinPointToFahrenheit(AQuantity), APrefixes);
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TRealQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := FormatCompactValue(KelvinPointToFahrenheit(AQuantity.FValue),
    GetSymbol(FPrefixes));
{$ELSE}
  result := FormatCompactValue(KelvinPointToFahrenheit(AQuantity),
    GetSymbol(FPrefixes));
{$ENDIF}
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(KelvinPointToFahrenheit(AQuantity.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(KelvinPointToFahrenheit(AQuantity), APrefixes);
{$ENDIF}

  result := FormatCompactValue(FactoredValue, GetSymbol(APrefixes));
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(KelvinPointToFahrenheit(AQuantity.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(KelvinPointToFahrenheit(AQuantity), APrefixes);
{$ENDIF}

  result := FormatCompactValueWithPrecision(FactoredValue, APrecision,
    ADigits, GetSymbol(APrefixes));
end;

function TDegreeFahrenheitUnitHelper.ToString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: TReal;
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  Check(FDim, ATolerance.FDim);
  FactoredValue := GetValue(KelvinPointToFahrenheit(AQuantity.FValue), APrefixes);
  FactoredTol   := GetValue(KelvinIntervalToFahrenheit(ATolerance.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(KelvinPointToFahrenheit(AQuantity), APrefixes);
  FactoredTol   := GetValue(KelvinIntervalToFahrenheit(ATolerance), APrefixes);
{$ENDIF}

  result := FormatCompactTolerance(FactoredValue, FactoredTol, APrecision,
    ADigits, GetSymbol(APrefixes));
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TRealQuantity): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := KelvinPointToFahrenheit(AQuantity.FValue);
{$ELSE}
  FactoredValue := KelvinPointToFahrenheit(AQuantity);
{$ENDIF}

  result := FormatVerboseValue(FactoredValue, GetName(FPrefixes),
    GetPluralName(FPrefixes));
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TRealQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(KelvinPointToFahrenheit(AQuantity.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(KelvinPointToFahrenheit(AQuantity), APrefixes);
{$ENDIF}

  result := FormatVerboseValue(FactoredValue, GetName(APrefixes),
    GetPluralName(APrefixes));
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(KelvinPointToFahrenheit(AQuantity.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(KelvinPointToFahrenheit(AQuantity), APrefixes);
{$ENDIF}

  result := FormatVerboseValueWithPrecision(FactoredValue, APrecision,
    ADigits, GetName(APrefixes), GetPluralName(APrefixes));
end;

function TDegreeFahrenheitUnitHelper.ToVerboseString(const AQuantity, ATolerance: TRealQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: TReal;
  FactoredValue: TReal;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  Check(FDim, ATolerance.FDim);
  FactoredValue := GetValue(KelvinPointToFahrenheit(AQuantity.FValue), APrefixes);
  FactoredTol   := GetValue(KelvinIntervalToFahrenheit(ATolerance.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(KelvinPointToFahrenheit(AQuantity), APrefixes);
  FactoredTol   := GetValue(KelvinIntervalToFahrenheit(ATolerance), APrefixes);
{$ENDIF}

  result := FormatVerboseTolerance(FactoredValue, FactoredTol, APrecision,
    ADigits, GetName(APrefixes), GetPluralName(APrefixes));
end;

{ Power functions }

function SquarePower(const AQuantity: TRealQuantity): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 2;
  result.FValue := IntPower(AQuantity.FValue, 2);
{$ELSE}
  result := IntPower(AQuantity, 2);
{$ENDIF}
end;

function CubicPower(const AQuantity: TRealQuantity): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 3;
  result.FValue := IntPower(AQuantity.FValue, 3);
{$ELSE}
  result := IntPower(AQuantity, 3);
{$ENDIF}
end;

function QuarticPower(const AQuantity: TRealQuantity): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 4;
  result.FValue := IntPower(AQuantity.FValue, 4);
{$ELSE}
  result := IntPower(AQuantity, 4);
{$ENDIF}
end;

function QuinticPower(const AQuantity: TRealQuantity): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 5;
  result.FValue := IntPower(AQuantity.FValue, 5);
{$ELSE}
  result := IntPower(AQuantity, 5);
{$ENDIF}
end;

function SexticPower(const AQuantity: TRealQuantity): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim * 6;
  result.FValue := IntPower(AQuantity.FValue, 6);
{$ELSE}
  result := IntPower(AQuantity, 6);
{$ENDIF}
end;

function SquareRoot(const AQuantity: TRealQuantity): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 2;
  result.FValue := Power(AQuantity.FValue, 1/2);

  Check(result.FDim * 2, AQuantity.FDim);
{$ELSE};
  result := Power(AQuantity, 1/2);
{$ENDIF}
end;

function CubicRoot(const AQuantity: TRealQuantity): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 3;
  Check(result.FDim * 3, AQuantity.FDim);
  result.FValue := OddRoot(AQuantity.FValue, 3);
{$ELSE}
  result := OddRoot(AQuantity, 3);
{$ENDIF}
end;

function QuarticRoot(const AQuantity: TRealQuantity): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 4;
  result.FValue := Power(AQuantity.FValue, 1/4);

  Check(result.FDim * 4, AQuantity.FDim);
{$ELSE}
  result := Power(AQuantity, 1/4);
{$ENDIF}
end;

function QuinticRoot(const AQuantity: TRealQuantity): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 5;
  Check(result.FDim * 5, AQuantity.FDim);
  result.FValue := OddRoot(AQuantity.FValue, 5);
{$ELSE}
  result := OddRoot(AQuantity, 5);
{$ENDIF}
end;

function SexticRoot(const AQuantity: TRealQuantity): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := AQuantity.FDim div 6;
  result.FValue := Power(AQuantity.FValue, 1/6);

  Check(result.FDim * 6, AQuantity.FDim);
{$ELSE}
  result := Power(AQuantity, 1/6);
{$ENDIF}
end;

{ Trigonometric functions }

function Cos(const AQuantity: TRealQuantity): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := System.Cos(AQuantity.FValue);
{$ELSE}
  result := System.Cos(AQuantity);
{$ENDIF}
end;

function Sin(const AQuantity: TRealQuantity): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := System.Sin(AQuantity.FValue);
{$ELSE}
  result := System.Sin(AQuantity);
{$ENDIF}
end;

function Tan(const AQuantity: TRealQuantity): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Tan(AQuantity.FValue);
{$ELSE}
  result := Math.Tan(AQuantity);
{$ENDIF}
end;

function Cotan(const AQuantity: TRealQuantity): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Cotan(AQuantity.FValue);
{$ELSE}
  result := Math.Cotan(AQuantity);
{$ENDIF}
end;

function Secant(const AQuantity: TRealQuantity): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Secant(AQuantity.FValue);
{$ELSE}
  result := Math.Secant(AQuantity);
{$ENDIF}
end;

function Cosecant(const AQuantity: TRealQuantity): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Cosecant(AQuantity.FValue);
{$ELSE}
  result := Math.Cosecant(AQuantity);
{$ENDIF}
end;

function ArcCos(const AValue: TReal): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ScalarUnit.FDim;
  result.FValue := Math.ArcCos(AValue);
{$ELSE}
  result := Math.ArcCos(AValue);
{$ENDIF}
end;

function ArcSin(const AValue: TReal): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ScalarUnit.FDim;
  result.FValue := Math.ArcSin(AValue);
{$ELSE}
  result := Math.ArcSin(AValue);
{$ENDIF}
end;

function ArcTan(const AValue: TReal): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ScalarUnit.FDim;
  result.FValue := System.ArcTan(AValue);
{$ELSE}
  result := System.ArcTan(AValue);
{$ENDIF}
end;

function ArcTan2(const AY, AX: TReal): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ScalarUnit.FDim;
  result.FValue := Math.ArcTan2(AY, AX);
{$ELSE}
  result := Math.ArcTan2(AY, AX);
{$ENDIF}
end;

{ Math functions }

function Min(const ALeft, ARight: TRealQuantity): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := Math.Min(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.Min(ALeft, ARight);
{$ENDIF}
end;

function Max(const ALeft, ARight: TRealQuantity): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := Math.Max(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.Max(ALeft, ARight);
{$ENDIF}
end;

function Exp(const AQuantity: TRealQuantity): TRealQuantity;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckSum(ScalarUnit.FDim, AQuantity.FDim);
  result.FValue := System.Exp(AQuantity.FValue);
{$ELSE}
  result := System.Exp(AQuantity);
{$ENDIF}
end;

function Log10(const AQuantity : TRealQuantity) : TReal;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Log10(AQuantity.FValue);
{$ELSE}
  result := Math.Log10(AQuantity);
{$ENDIF}
end;

function Log2(const AQuantity : TRealQuantity) : TReal;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.Log2(AQuantity.FValue);
{$ELSE}
  result := Math.Log2(AQuantity);
{$ENDIF}
end;

function LogN(ABase: longint; const AQuantity: TRealQuantity): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.LogN(ABase, AQuantity.FValue);
{$ELSE}
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function LogN(const ABase, AQuantity: TRealQuantity): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, ABase.FDim);
  Check(ScalarUnit.FDim, AQuantity.FDim);
  result := Math.LogN(ABase.FValue, AQuantity.FValue);
{$ELSE}
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function Power(const ABase: TRealQuantity; AExponent: TReal): TReal;
begin
{$IFNDEF ADIMOFF}
  Check(ScalarUnit.FDim, ABase.FDim);
  result := Math.Power(ABase.FValue, AExponent);
{$ELSE}
  result := Math.Power(ABase, AExponent);
{$ENDIF}
end;

{ Helper functions }

function LessThanOrEqualToZero(const AQuantity: TRealQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue <= 0;
{$ELSE}
  result := AQuantity <= 0;
{$ENDIF}
end;

function LessThanZero(const AQuantity: TRealQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue < 0;
{$ELSE}
  result := AQuantity < 0;
{$ENDIF}
end;

function EqualToZero(const AQuantity: TRealQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue = 0;
{$ELSE}
  result := AQuantity = 0;
{$ENDIF}
end;

function NotEqualToZero(const AQuantity: TRealQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue <> 0;
{$ELSE}
  result := AQuantity <> 0;
{$ENDIF}
end;

function GreaterThanOrEqualToZero(const AQuantity: TRealQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue >= 0;
{$ELSE}
  result := AQuantity >= 0;
{$ENDIF}
end;

function GreaterThanZero(const AQuantity: TRealQuantity): boolean;
begin
{$IFNDEF ADIMOFF}
  result := AQuantity.FValue > 0;
{$ELSE}
  result := AQuantity > 0;
{$ENDIF}
end;

function CheckEqual(ALeft, ARight: TDimension): TDimension;
begin
  if ALeft <> ARight then
    raise EDimensionError.CreateFmt(
      'Incompatible physical dimensions: %s expected, %s found.',
      [ALeft.ToString, ARight.ToString]);
  result := ALeft;
end;

function CheckSum(ALeft, ARight: TDimension): TDimension;
begin
  if ALeft <> ARight then
    raise EDimensionError.CreateFmt(
      'Cannot add quantities with dimensions %s and %s.',
      [ALeft.ToString, ARight.ToString]);
  result := ALeft;
end;

function CheckSub(ALeft, ARight: TDimension): TDimension;
begin
  if ALeft <> ARight then
    raise EDimensionError.CreateFmt(
      'Cannot subtract quantities with dimensions %s and %s.',
      [ALeft.ToString, ARight.ToString]);
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

procedure Check(ALeft, ARight: TDimension);
begin
  if ALeft <> ARight then
    raise EDimensionError.CreateFmt(
      'Incompatible physical dimensions: %s and %s.',
      [ALeft.ToString, ARight.ToString]);
end;

end.

