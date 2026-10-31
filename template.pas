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
  @license MIT License, see the file LICENSE.

  This unit is part of the ADim library, distributed under the MIT License
  (see the file LICENSE).
}

unit Template;

{$H+}{$J-}
{$modeswitch advancedrecords}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function''s return value.
{$WARN 6058 OFF} // Suppress warning for function marked as inline that cannot be inlined.
{$STACKFRAMES ON} // Dimension checks walk the call stack to report the caller's line.

{#HEADER}

interface

uses
  ADimCL2, ADimCL3, ADimCL13, ADimCommon, ADimMath, ADimRes, SysUtils;

type
  { Identifies an SI decimal prefix from quetta (@code(10^30)) to quecto
    (@code(10^-30)). @code(pNone) represents the absence of a prefix. }
  TPrefix = (pQuetta, pRonna, pYotta, pZetta, pExa, pPeta, pTera, pGiga, pMega, pKilo, pHecto, pDeca,
    pNone, pDeci, pCenti, pMilli, pMicro, pNano, pPico, pFemto, pAtto, pZepto, pYocto, pRonto, pQuecto);

  { Ordered list of SI prefixes applied to the factors of a compound unit.
    Its length must match the number of prefix placeholders supported by that
    unit. An empty array selects the unit's default prefixes. }
  TPrefixes = array of TPrefix;

  { Exponents associated with the prefix placeholders of a unit. They determine
    how each decimal prefix contributes to the overall conversion factor. }
  TExponents = array of longint;

  { Represents a physical quantity with dimension checking at runtime.

    Combines a value of generic scalar type @code(T) with a @link(TDimension).
    The supported specializations use @link(TReal) and @link(TComplex).
    Arithmetic operations preserve or combine dimensions as appropriate, while
    incompatible additive operations raise @link(EDimensionError) at runtime.
    When @code(ADIMOFF) is defined, the public specializations become aliases of
    their underlying mathematical scalar types and dimension checking is disabled.
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

    { Returns the product of a mathematical scalar and a quantity. }
    class operator *(const ALeft: T; const ARight: TQuantity): TQuantity;

    { Returns the product of a quantity and a mathematical scalar. }
    class operator *(const ALeft: TQuantity; const ARight: T): TQuantity;

    { Returns the quotient of two quantities. The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft, ARight: TQuantity): TQuantity;

    { Returns the quotient of a quantity divided by a mathematical scalar. }
    class operator /(const ALeft: TQuantity; const ARight: T): TQuantity;

    { Returns @true if both operands have the same dimension and equal values. }
    class operator =(const ALeft, ARight: TQuantity): boolean;

    { Returns @true if the operands have compatible dimensions and different
      scalar values. }
    class operator <>(const ALeft, ARight: TQuantity): boolean;

    { Converts a mathematical scalar to a dimensionless quantity. }
    class operator :=(const AValue: T): TQuantity;
  end;

  { Real-valued physical quantity with runtime dimensional information. }
  TRealQuantity = specialize TQuantity<TReal>;

  { Complex-valued physical quantity with runtime dimensional information. }
  TComplexQuantity = specialize TQuantity<TComplex>;

  { Adds real-specific operations to @link(TRealQuantity). }
  TRealQuantityHelper = record helper for TRealQuantity
    { Returns the quantity itself, the conjugate of a real number. }
    function Conjugate: TRealQuantity;

    { Returns the absolute value with the same physical dimension. }
    function Norm: TRealQuantity;

    { Returns @true when both quantities have the same dimension and their
      values differ by no more than @link(DefaultEpsilon). }
    function SameValue(const AQuantity: TRealQuantity): boolean;

    { Returns the square of the value. The physical dimension is squared. }
    function SquaredNorm: TRealQuantity;
  end;

  { Adds complex-specific operations to @link(TComplexQuantity). }
  TComplexQuantityHelper = record helper for TComplexQuantity
    { Returns the argument in radians. It does not depend on the dimension. }
    function Arg: TReal;

    { Returns the complex conjugate. }
    function Conjugate: TComplexQuantity;

    { Returns @true if the real or the imaginary part is not zero. }
    function IsNotNull: boolean;

    { Returns @true if both the real and the imaginary parts are zero. }
    function IsNull: boolean;

    { Returns the complex modulus with the same physical dimension. }
    function Norm: TRealQuantity;

    { Returns @true when both quantities have the same dimension and their real
      and imaginary components agree within @link(DefaultEpsilon). }
    function SameValue(const AQuantity: TComplexQuantity): boolean;

    { Returns the squared modulus. The physical dimension is squared. }
    function SquaredNorm: TRealQuantity;
  end;
  {$ELSE}
  { Real scalar used in place of a dimensioned quantity when dimensional checks
    are disabled. }
  TRealQuantity = TReal;

  { Complex scalar used in place of a dimensioned quantity when dimensional
    checks are disabled. }
  TComplexQuantity = TComplex;
  {$ENDIF}

  {$IFNDEF ADIMOFF}
  { Converts a real quantity to a complex quantity with zero imaginary part. }
  operator :=(const AValue: TRealQuantity): TComplexQuantity;

  { Returns @true if @code(ALeft) is smaller than @code(ARight). The operands
    must have the same physical dimension. }
  operator <(const ALeft, ARight: TRealQuantity): boolean;

  { Returns @true if @code(ALeft) is greater than @code(ARight). The operands
    must have the same physical dimension. }
  operator >(const ALeft, ARight: TRealQuantity): boolean;

  { Returns @true if @code(ALeft) is smaller than or equal to @code(ARight).
    The operands must have the same physical dimension. }
  operator <=(const ALeft, ARight: TRealQuantity): boolean;

  { Returns @true if @code(ALeft) is greater than or equal to @code(ARight).
    The operands must have the same physical dimension. }
  operator >=(const ALeft, ARight: TRealQuantity): boolean;

  { Divides a mathematical real scalar by a real quantity. }
  operator /(const ALeft: TReal; const ARight: TRealQuantity): TRealQuantity;

  { Divides a mathematical complex scalar by a complex quantity. }
  operator /(const ALeft: TComplex; const ARight: TComplexQuantity): TComplexQuantity;

  { Divides a mathematical real scalar by a complex quantity. }
  operator /(const ALeft: TReal; const ARight: TComplexQuantity): TComplexQuantity;

  { Adds compatible real and complex quantities and returns a complex quantity. }
  operator +(const ALeft: TRealQuantity; const ARight: TComplexQuantity): TComplexQuantity;

  { Adds compatible complex and real quantities and returns a complex quantity. }
  operator +(const ALeft: TComplexQuantity; const ARight: TRealQuantity): TComplexQuantity;

  { Subtracts a complex quantity from a compatible real quantity. }
  operator -(const ALeft: TRealQuantity; const ARight: TComplexQuantity): TComplexQuantity;

  { Subtracts a real quantity from a compatible complex quantity. }
  operator -(const ALeft: TComplexQuantity; const ARight: TRealQuantity): TComplexQuantity;

  { Multiplies real and complex quantities. }
  operator *(const ALeft: TRealQuantity; const ARight: TComplexQuantity): TComplexQuantity;

  { Multiplies complex and real quantities. }
  operator *(const ALeft: TComplexQuantity; const ARight: TRealQuantity): TComplexQuantity;

  { Divides a real quantity by a complex quantity. }
  operator /(const ALeft: TRealQuantity; const ARight: TComplexQuantity): TComplexQuantity;

  { Divides a complex quantity by a real quantity. }
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
  { Represents a dynamically sized vector whose coefficients share one physical
    dimension. @code(T) is the mathematical coefficient type, normally
    @link(TReal) or @link(TComplex). Vector sizes are determined by the
    underlying @link(TVector) value, and binary operations require equal sizes. }
  generic TVectorQuantity<T> = record
  type
    { Mathematical vector type used to store the coefficients. }
    TValueVector = specialize TVector<T>;
    { Scalar physical quantity returned for individual coefficients and scalar
      products. }
    TScalarQuantity = specialize TQuantity<T>;
  private
    FDim: TDimension;
    FValue: TValueVector;
    { @exclude }
    function Get(AIndex: longint): TScalarQuantity;
    { @exclude }
    procedure Put(AIndex: longint; const AQuantity: TScalarQuantity);
  public
    { Returns the number of vector coefficients. }
    function Size: longint;

    { Returns the dot product with @code(AVector). Both vectors must have the
      same size. }
    function Dot(const AVector: TVectorQuantity): TScalarQuantity;

    { Returns @true if every coefficient is numerically zero. }
    function IsNull: boolean;

    { Returns @true if at least one coefficient is non-zero. }
    function IsNotNull: boolean;

    { Returns the Euclidean norm with the same physical dimension as the vector. }
    function Norm: TRealQuantity;

    { Returns the squared Euclidean norm. The physical dimension is squared. }
    function SquaredNorm: TRealQuantity;

    { Returns the dimensionless mathematical unit vector in the same direction.
      The original quantity vector is not modified. }
    function Normalize: TValueVector;

    { Returns the component-wise reciprocal vector. }
    function Reciprocal: TVectorQuantity;

    { Returns the mathematical coefficients in their default string form. The
      unit symbol is intentionally omitted. }
    function ToString: string;

    { Returns @true when dimensions, sizes and all coefficients are exactly equal. }
    class operator =(const ALeft, ARight: TVectorQuantity): boolean;

    { Returns @true when dimensions, sizes or any coefficients differ. }
    class operator <>(const ALeft, ARight: TVectorQuantity): boolean;

    { Unary plus. Returns the vector quantity unchanged. }
    class operator +(const ASelf: TVectorQuantity): TVectorQuantity;

    { Unary minus. Negates every coefficient. }
    class operator -(const ASelf: TVectorQuantity): TVectorQuantity;

    { Adds two same-sized vector quantities with equal physical dimensions. }
    class operator +(const ALeft, ARight: TVectorQuantity): TVectorQuantity;

    { Subtracts two same-sized vector quantities with equal physical dimensions. }
    class operator -(const ALeft, ARight: TVectorQuantity): TVectorQuantity;

    { Returns the dot product of two same-sized vector quantities. }
    class operator *(const ALeft, ARight: TVectorQuantity): TScalarQuantity;

    { Multiplies a scalar quantity by a vector quantity. }
    class operator *(const ALeft: TScalarQuantity; const ARight: TVectorQuantity): TVectorQuantity;

    { Multiplies a vector quantity by a scalar quantity. }
    class operator *(const ALeft: TVectorQuantity; const ARight: TScalarQuantity): TVectorQuantity;

    { Divides a vector quantity by a scalar quantity. }
    class operator /(const ALeft: TVectorQuantity; const ARight: TScalarQuantity): TVectorQuantity;

    { Provides zero-based indexed access to vector coefficients as physical
      quantities. Assigned coefficients must have the vector's dimension. }
    property A[AIndex: longint]: TScalarQuantity read Get write Put; default;
  end;

  { Real-valued dynamically sized vector quantity. }
  TRealVectorQuantity = specialize TVectorQuantity<TReal>;

  { Complex-valued dynamically sized vector quantity. }
  TComplexVectorQuantity = specialize TVectorQuantity<TComplex>;

  { Adds operations specific to real vector quantities. }
  TRealVectorQuantityHelper = record helper for TRealVectorQuantity
    { Returns the three-dimensional cross product with @code(AVector). }
    function Cross(const AVector: TRealVectorQuantity): TRealVectorQuantity;

    { Returns @true when dimensions and sizes agree and corresponding
      coefficients differ by no more than @link(DefaultEpsilon). }
    function SameValue(const AVector: TRealVectorQuantity): boolean;

    { Converts every real coefficient to a complex coefficient with zero
      imaginary part. }
    function ToComplex: TComplexVectorQuantity;
  end;

  { Adds operations specific to complex vector quantities. }
  TComplexVectorQuantityHelper = record helper for TComplexVectorQuantity
    { Returns the component-wise complex conjugate. }
    function Conjugate: TComplexVectorQuantity;

    { Returns @true when dimensions and sizes agree and corresponding complex
      coefficients agree within @link(DefaultEpsilon). }
    function SameValue(const AVector: TComplexVectorQuantity): boolean;
  end;

  { Represents a dynamically sized square matrix whose coefficients share one
    physical dimension. @code(T) is the mathematical coefficient type, normally
    @link(TReal) or @link(TComplex). Matrix order is determined by the underlying
    @link(TMatrix) value. }
  generic TMatrixQuantity<T> = record
  type
    { Mathematical square-matrix type used to store the coefficients. }
    TValueMatrix = specialize TMatrix<T>;
    { Scalar physical quantity used for coefficients and scalar results. }
    TScalarQuantity = specialize TQuantity<T>;
    { Vector quantity compatible with the matrix coefficient type. }
    TVectorQuantityType = specialize TVectorQuantity<T>;
  private
    FDim: TDimension;
    FValue: TValueMatrix;
    { @exclude }
    function Get(ARow, ACol: longint): TScalarQuantity;
    { @exclude }
    procedure Put(ARow, ACol: longint; const AQuantity: TScalarQuantity);
  public
    { Returns the number of rows and columns of the square matrix. }
    function Order: longint;

    { Solves @code(Self * X = AData). The result dimension is
      @code(AData.Dimension / Self.Dimension). }
    function SolveLinear(const AData: TVectorQuantityType): TVectorQuantityType;

    { Returns a dimensionless mathematical identity matrix of the same order. }
    function Identity: TValueMatrix;

    { Returns a zero matrix quantity of the same order and physical dimension. }
    function Null: TMatrixQuantity;

    { Returns a diagonal matrix quantity whose diagonal coefficients come from
      @code(ADiagonal). Its physical dimension is the vector dimension. }
    function Diagonalize(const ADiagonal: TVectorQuantityType): TMatrixQuantity;

    { Returns @true if every matrix coefficient is numerically zero. }
    function IsNull: boolean;

    { Returns @true if at least one matrix coefficient is non-zero. }
    function IsNotNull: boolean;

    { Returns the determinant. For order @code(N), its physical dimension is
      the matrix dimension raised to @code(N). }
    function Determinant: TScalarQuantity;

    { Returns the matrix norm with the same physical dimension as its coefficients. }
    function Norm: TRealQuantity;

    { Returns the numerical rank of the underlying mathematical matrix. }
    function Rank: longint;

    { Returns the trace with the same physical dimension as the coefficients. }
    function Trace: TScalarQuantity;

    { Returns an independent copy of the matrix quantity. }
    function Clone: TMatrixQuantity;

    { Returns the transpose while preserving the physical dimension. }
    function Transpose: TMatrixQuantity;

    { Returns the inverse matrix. The physical dimension is inverted. }
    function Inverse: TMatrixQuantity;

    { Exchanges rows @code(ARow1) and @code(ARow2) in place. }
    procedure Swap(ARow1, ARow2: longint);

    { Returns the mathematical coefficients in their default string form. }
    function ToString: string;

    { Returns the mathematical coefficients using the requested floating-point
      precision and digit count. }
    function ToString(APrecision, ADigits: integer): string;

    { Returns @true when dimensions, orders and all coefficients are exactly equal. }
    class operator =(const ALeft, ARight: TMatrixQuantity): boolean;

    { Returns @true when dimensions, orders or any coefficients differ. }
    class operator <>(const ALeft, ARight: TMatrixQuantity): boolean;

    { Unary plus. Returns the matrix quantity unchanged. }
    class operator +(const ASelf: TMatrixQuantity): TMatrixQuantity;

    { Unary minus. Negates every coefficient. }
    class operator -(const ASelf: TMatrixQuantity): TMatrixQuantity;

    { Adds two matrices of equal order and physical dimension. }
    class operator +(const ALeft, ARight: TMatrixQuantity): TMatrixQuantity;

    { Subtracts two matrices of equal order and physical dimension. }
    class operator -(const ALeft, ARight: TMatrixQuantity): TMatrixQuantity;

    { Multiplies a scalar quantity by a matrix quantity. }
    class operator *(const ALeft: TScalarQuantity; const ARight: TMatrixQuantity): TMatrixQuantity;

    { Multiplies a matrix quantity by a scalar quantity. }
    class operator *(const ALeft: TMatrixQuantity; const ARight: TScalarQuantity): TMatrixQuantity;

    { Divides a matrix quantity by a scalar quantity. }
    class operator /(const ALeft: TMatrixQuantity; const ARight: TScalarQuantity): TMatrixQuantity;

    { Provides zero-based indexed access to coefficients as physical quantities.
      Assigned coefficients must have the matrix's dimension. }
    property A[ARow, ACol: longint]: TScalarQuantity read Get write Put; default;
  end;

  { Real-valued dynamically sized square-matrix quantity. }
  TRealMatrixQuantity = specialize TMatrixQuantity<TReal>;

  { Complex-valued dynamically sized square-matrix quantity. }
  TComplexMatrixQuantity = specialize TMatrixQuantity<TComplex>;

  { Adds real-matrix algorithms to @link(TRealMatrixQuantity). }
  TRealMatrixQuantityHelper = record helper for TRealMatrixQuantity
    { Returns @true if the matrix is dimensionless and orthogonal. }
    function IsOrthogonal: boolean;

    { Returns @true when dimensions and matrix coefficients agree within
      @link(DefaultEpsilon). }
    function SameValue(const AMatrix: TRealMatrixQuantity): boolean;

    { Converts every coefficient to complex form. }
    function ToComplex: TComplexMatrixQuantity;

    { Returns dimensioned complex eigenvalues and dimensionless eigenvectors
      with matching array indices. }
    procedure Eigenpairs(out AValues: TComplexVectorQuantity;
      out AVectors: TComplexMatrix);

    { Returns the dimensioned real eigenvalues, in ascending order, and the
      dimensionless orthonormal eigenvectors of a symmetric matrix. }
    procedure SymmetricEigenpairs(out AValues: TRealVectorQuantity;
      out AVectors: TRealMatrix);
  end;

  { Adds complex-matrix algorithms to @link(TComplexMatrixQuantity). }
  TComplexMatrixQuantityHelper = record helper for TComplexMatrixQuantity
    { Returns the component-wise complex conjugate. }
    function Conjugate: TComplexMatrixQuantity;

    { Returns dimensioned complex eigenvalues and dimensionless eigenvectors
      with matching array indices. }
    procedure Eigenpairs(out AValues: TComplexVectorQuantity;
      out AVectors: TComplexMatrix);

    { Returns the dimensioned real eigenvalues, in ascending order, and the
      dimensionless orthonormal eigenvectors of a Hermitian matrix. }
    procedure HermitianEigenpairs(out AValues: TRealVectorQuantity;
      out AVectors: TComplexMatrix);

    { Returns @true if the matrix equals its conjugate transpose. }
    function IsHermitian: boolean;

    { Returns @true if the matrix is dimensionless and unitary. }
    function IsUnitary: boolean;

    { Returns @true when dimensions and complex coefficients agree within
      @link(DefaultEpsilon). }
    function SameValue(const AMatrix: TComplexMatrixQuantity): boolean;

    { Returns the conjugate transpose. }
    function TransposeConjugate: TComplexMatrixQuantity;
  end;

  { Returns the product of two real matrix quantities. Matrix orders must agree. }
  operator *(const ALeft, ARight: TRealMatrixQuantity): TRealMatrixQuantity;

  { Returns the product of two complex matrix quantities. Matrix orders must agree. }
  operator *(const ALeft, ARight: TComplexMatrixQuantity): TComplexMatrixQuantity;

  { Returns a real matrix-vector product. Sizes must agree. }
  operator *(const ALeft: TRealMatrixQuantity; const ARight: TRealVectorQuantity): TRealVectorQuantity;

  { Returns a real row-vector/matrix product. Sizes must agree. }
  operator *(const ALeft: TRealVectorQuantity; const ARight: TRealMatrixQuantity): TRealVectorQuantity;

  { Returns a complex matrix-vector product. Sizes must agree. }
  operator *(const ALeft: TComplexMatrixQuantity; const ARight: TComplexVectorQuantity): TComplexVectorQuantity;

  { Returns a complex row-vector/matrix product. Sizes must agree. }
  operator *(const ALeft: TComplexVectorQuantity; const ARight: TComplexMatrixQuantity): TComplexVectorQuantity;

  { Returns the real vector quantity @code(ALeft · ARight). The dimension is taken from @code(ALeft). }
  operator *(const ALeft: TRealQuantity; const ARight: TRealVector): TRealVectorQuantity;

  { Returns the real vector quantity @code(ALeft · ARight). The dimension is taken from @code(ARight). }
  operator *(const ALeft: TRealVector; const ARight: TRealQuantity): TRealVectorQuantity;

  { Returns the real vector quantity @code(ALeft / ARight). The dimension is the inverse of the one of @code(ARight). }
  operator /(const ALeft: TRealVector; const ARight: TRealQuantity): TRealVectorQuantity;

  { Returns the real matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ALeft). }
  operator *(const ALeft: TRealQuantity; const ARight: TRealMatrix): TRealMatrixQuantity;

  { Returns the real matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ARight). }
  operator *(const ALeft: TRealMatrix; const ARight: TRealQuantity): TRealMatrixQuantity;

  { Returns the real matrix quantity @code(ALeft / ARight). The dimension is the inverse of the one of @code(ARight). }
  operator /(const ALeft: TRealMatrix; const ARight: TRealQuantity): TRealMatrixQuantity;

  { Returns the complex vector quantity @code(ALeft · ARight). The dimension is taken from @code(ALeft). }
  operator *(const ALeft: TComplexQuantity; const ARight: TComplexVector): TComplexVectorQuantity;

  { Returns the complex vector quantity @code(ALeft · ARight). The dimension is taken from @code(ARight). }
  operator *(const ALeft: TComplexVector; const ARight: TComplexQuantity): TComplexVectorQuantity;

  { Returns the complex vector quantity @code(ALeft / ARight). The dimension is the inverse of the one of @code(ARight). }
  operator /(const ALeft: TComplexVector; const ARight: TComplexQuantity): TComplexVectorQuantity;

  { Returns the complex matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ALeft). }
  operator *(const ALeft: TComplexQuantity; const ARight: TComplexMatrix): TComplexMatrixQuantity;

  { Returns the complex matrix quantity @code(ALeft · ARight). The dimension is taken from @code(ARight). }
  operator *(const ALeft: TComplexMatrix; const ARight: TComplexQuantity): TComplexMatrixQuantity;

  { Returns the complex matrix quantity @code(ALeft / ARight). The dimension is the inverse of the one of @code(ARight). }
  operator /(const ALeft: TComplexMatrix; const ARight: TComplexQuantity): TComplexMatrixQuantity;
  {$ELSE}
  { Mathematical real vector used when dimensional checks are disabled. }
  TRealVectorQuantity = TRealVector;
  { Mathematical complex vector used when dimensional checks are disabled. }
  TComplexVectorQuantity = TComplexVector;
  { Mathematical real square matrix used when dimensional checks are disabled. }
  TRealMatrixQuantity = TRealMatrix;
  { Mathematical complex square matrix used when dimensional checks are disabled. }
  TComplexMatrixQuantity = TComplexMatrix;
  {$ENDIF}


type
  { Represents a multivector of @code(Cl(2,0)) with a physical dimension.

    Combines a @link(TCL2Multivector) value with a @link(TDimension) shared by all
    its components. Arithmetic follows both the rules of the algebra and the
    rules of dimensional analysis: incompatible dimensions raise
    @link(EDimensionError) at run time. When the symbol @code(ADIMOFF) is
    defined, this type is an alias of @link(TCL2Multivector).
  }
  {$IFNDEF ADIMOFF}
  TCL2MultivecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL2Multivector;
  public
    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL2MultivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TRealQuantity; const ARight: TCL2MultivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL2MultivecQuantity; const ARight: TCL2MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL2MultivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TRealQuantity; const ARight: TCL2MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL2MultivecQuantity; const ARight: TCL2MultivecQuantity): boolean;

    { Returns the opposite of the quantity. The dimension is preserved. }
    class operator -(const AValue: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL2MultivecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL2MultivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL2MultivecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL2MultivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL2MultivecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TRealQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL2MultivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2MultivecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2MultivecQuantity; const ARight: TReal): TCL2MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TReal; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2MultivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Converts a mathematical multivector to a dimensionless quantity. }
    class operator :=(const AValue: TCL2Multivector): TCL2MultivecQuantity;
  end;
  {$ELSE}
  { Mathematical @code(Cl(2,0)) multivector used when dimensional checks are disabled. }
  TCL2MultivecQuantity = TCL2Multivector;
  {$ENDIF}

  { Represents a vector of @code(Cl(2,0)) with a physical dimension.

    Combines a @link(TCL2Vector) value with a @link(TDimension) shared by all
    its components. Arithmetic follows both the rules of the algebra and the
    rules of dimensional analysis: incompatible dimensions raise
    @link(EDimensionError) at run time. When the symbol @code(ADIMOFF) is
    defined, this type is an alias of @link(TCL2Vector).
  }
  {$IFNDEF ADIMOFF}
  TCL2VecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL2Vector;
  public
    { Widens the quantity to a @link(TCL2MultivecQuantity). The dimension is preserved. }
    class operator :=(const AValue: TCL2VecQuantity): TCL2MultivecQuantity;

    { Keeps the vector components of a multivector quantity and discards the others. The dimension is preserved. }
    class operator Explicit(const AValue: TCL2MultivecQuantity): TCL2VecQuantity;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL2VecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TRealQuantity; const ARight: TCL2VecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL2VecQuantity; const ARight: TCL2VecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL2VecQuantity; const ARight: TCL2MultivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL2MultivecQuantity; const ARight: TCL2VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL2VecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TRealQuantity; const ARight: TCL2VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL2VecQuantity; const ARight: TCL2VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL2VecQuantity; const ARight: TCL2MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL2MultivecQuantity; const ARight: TCL2VecQuantity): boolean;

    { Returns the opposite of the quantity. The dimension is preserved. }
    class operator -(const AValue: TCL2VecQuantity): TCL2VecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL2VecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL2VecQuantity; const ARight: TCL2VecQuantity): TCL2VecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL2VecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL2MultivecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL2VecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL2VecQuantity; const ARight: TCL2VecQuantity): TCL2VecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL2VecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL2MultivecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL2VecQuantity; const ARight: TRealQuantity): TCL2VecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TRealQuantity; const ARight: TCL2VecQuantity): TCL2VecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL2VecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL2VecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL2MultivecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2VecQuantity; const ARight: TRealQuantity): TCL2VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2VecQuantity; const ARight: TReal): TCL2VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL2VecQuantity): TCL2VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TReal; const ARight: TCL2VecQuantity): TCL2VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2VecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2VecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2MultivecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;

    { Converts a mathematical vector to a dimensionless quantity. }
    class operator :=(const AValue: TCL2Vector): TCL2VecQuantity;
  end;
  {$ELSE}
  { Mathematical @code(Cl(2,0)) vector used when dimensional checks are disabled. }
  TCL2VecQuantity = TCL2Vector;
  {$ENDIF}

  { Represents a bivector of @code(Cl(2,0)) with a physical dimension.

    Combines a @link(TCL2Bivector) value with a @link(TDimension) shared by all
    its components. Arithmetic follows both the rules of the algebra and the
    rules of dimensional analysis: incompatible dimensions raise
    @link(EDimensionError) at run time. When the symbol @code(ADIMOFF) is
    defined, this type is an alias of @link(TCL2Bivector).
  }
  {$IFNDEF ADIMOFF}
  TCL2BivecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL2Bivector;
  public
    { Widens the quantity to a @link(TCL2MultivecQuantity). The dimension is preserved. }
    class operator :=(const AValue: TCL2BivecQuantity): TCL2MultivecQuantity;

    { Keeps the bivector components of a multivector quantity and discards the others. The dimension is preserved. }
    class operator Explicit(const AValue: TCL2MultivecQuantity): TCL2BivecQuantity;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL2BivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TRealQuantity; const ARight: TCL2BivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL2BivecQuantity; const ARight: TCL2BivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL2BivecQuantity; const ARight: TCL2VecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL2VecQuantity; const ARight: TCL2BivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL2BivecQuantity; const ARight: TCL2MultivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL2MultivecQuantity; const ARight: TCL2BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL2BivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TRealQuantity; const ARight: TCL2BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL2BivecQuantity; const ARight: TCL2BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL2BivecQuantity; const ARight: TCL2VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL2VecQuantity; const ARight: TCL2BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL2BivecQuantity; const ARight: TCL2MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL2MultivecQuantity; const ARight: TCL2BivecQuantity): boolean;

    { Returns the opposite of the quantity. The dimension is preserved. }
    class operator -(const AValue: TCL2BivecQuantity): TCL2BivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL2BivecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL2BivecQuantity; const ARight: TCL2BivecQuantity): TCL2BivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL2BivecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL2VecQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL2BivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL2MultivecQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL2BivecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL2BivecQuantity; const ARight: TCL2BivecQuantity): TCL2BivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL2BivecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL2VecQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL2BivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL2MultivecQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL2BivecQuantity; const ARight: TRealQuantity): TCL2BivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TRealQuantity; const ARight: TCL2BivecQuantity): TCL2BivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL2BivecQuantity; const ARight: TCL2BivecQuantity): TRealQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL2BivecQuantity; const ARight: TCL2VecQuantity): TCL2VecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL2VecQuantity; const ARight: TCL2BivecQuantity): TCL2VecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL2BivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL2MultivecQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2BivecQuantity; const ARight: TRealQuantity): TCL2BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2BivecQuantity; const ARight: TReal): TCL2BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL2BivecQuantity): TCL2BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TReal; const ARight: TCL2BivecQuantity): TCL2BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2BivecQuantity; const ARight: TCL2BivecQuantity): TRealQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2BivecQuantity; const ARight: TCL2VecQuantity): TCL2VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2VecQuantity; const ARight: TCL2BivecQuantity): TCL2VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2BivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL2MultivecQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;

    { Converts a mathematical bivector to a dimensionless quantity. }
    class operator :=(const AValue: TCL2Bivector): TCL2BivecQuantity;
  end;
  {$ELSE}
  { Mathematical @code(Cl(2,0)) bivector used when dimensional checks are disabled. }
  TCL2BivecQuantity = TCL2Bivector;
  {$ENDIF}

  { Record helper for @link(TCL2MultivecQuantity): the methods of @link(TCL2Multivector) on dimensioned values.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL2MultivecQuantityHelper = record helper for TCL2MultivecQuantity
    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL2MultivectorComponents): TCL2MultivecQuantity;

    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL2BivectorComponents): TCL2BivecQuantity;

    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL2VectorComponents): TCL2VecQuantity;

    { Returns the bivector part. The dimension is preserved. }
    function ExtractBivector: TCL2BivecQuantity;

    { Returns the vector part. The dimension is preserved. }
    function ExtractVector: TCL2VecQuantity;

    { Returns the scalar part. The dimension is preserved. }
    function ExtractScalar: TRealQuantity;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL2MultivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL2BivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL2VecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TRealQuantity): boolean;

    { Returns @true if all the components are zero. }
    function IsNull: boolean;

    { Returns @true if only the scalar components are non-zero. }
    function IsScalar: boolean;

    { Returns @true if only the vector components are non-zero. }
    function IsVector: boolean;

    { Returns @true if only the bivector components are non-zero. }
    function IsBivector: boolean;

    { Returns the name of the smallest value type that holds the value. }
    function IsA: string;

    { Returns the norm @code(Sqrt(Abs(SquaredNorm))). The dimension is preserved. }
    function Norm: TRealQuantity;

    { Returns the squared norm @code(<X ~X>₀). The resulting dimension is the square of the original dimension. }
    function SquaredNorm: TRealQuantity;

    { Returns the dual @code(X * I), with @code(I) the unit pseudoscalar. The dimension is preserved. }
    function Dual: TCL2MultivecQuantity;

    { Returns the grade involution: every grade-@code(k) component is multiplied by @code((-1)^k). The dimension is preserved. }
    function Involute: TCL2MultivecQuantity;

    { Returns the reverse: every grade-@code(k) component is multiplied by @code((-1)^(k(k-1)/2)). The dimension is preserved. }
    function Reverse: TCL2MultivecQuantity;

    { Returns the Clifford conjugate, the reverse of the grade involution. The dimension is preserved. }
    function Conjugate: TCL2MultivecQuantity;

    { Returns the multiplicative inverse, @code(X⁻¹ * X = X * X⁻¹ = 1). The resulting dimension is the inverse of the original dimension. Raises a floating-point exception if the value is not invertible. }
    function Inverse: TCL2MultivecQuantity;

    { Returns a mask with bit @code(g) set when some component of grade @code(g) is non-zero. }
    function GradeMask: longword;

    { Returns the value divided by its norm. The dimension is preserved. }
    function Normalized: TCL2MultivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL2BivecQuantity): TCL2MultivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL2BivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL2BivecQuantity): TCL2MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL2VecQuantity; const AVector2: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL2BivecQuantity; const AVector2: TCL2BivecQuantity): TCL2MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL2MultivecQuantity; const AVector2: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns @code(ARotor X ~ARotor), the rotation by the rotor @code(ARotor) (@code(ARotor ~ARotor = 1)). The result keeps the type of the value; the components of other grades, zero for a rotor, are dropped. The resulting dimension is the original dimension times the square of the dimension of the rotor. }
    function Rotate(const ARotor: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL2BivecQuantity): TCL2MultivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL2VecQuantity): TCL2MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL2BivecQuantity): TCL2BivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TCL2VecQuantity): the methods of @link(TCL2Vector) on dimensioned values.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL2VecQuantityHelper = record helper for TCL2VecQuantity
    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL2VectorComponents): TCL2VecQuantity;

    { Returns the value as a multivector quantity. The dimension is preserved. }
    function ToMultivector: TCL2MultivecQuantity;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL2MultivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL2VecQuantity): boolean;

    { Returns the norm @code(Sqrt(Abs(SquaredNorm))). The dimension is preserved. }
    function Norm: TRealQuantity;

    { Returns the squared norm @code(<X ~X>₀). The resulting dimension is the square of the original dimension. }
    function SquaredNorm: TRealQuantity;

    { Returns the dual @code(X * I), with @code(I) the unit pseudoscalar. The dimension is preserved. }
    function Dual: TCL2VecQuantity;

    { Returns the grade involution: every grade-@code(k) component is multiplied by @code((-1)^k). The dimension is preserved. }
    function Involute: TCL2VecQuantity;

    { Returns the reverse: every grade-@code(k) component is multiplied by @code((-1)^(k(k-1)/2)). The dimension is preserved. }
    function Reverse: TCL2VecQuantity;

    { Returns the Clifford conjugate, the reverse of the grade involution. The dimension is preserved. }
    function Conjugate: TCL2VecQuantity;

    { Returns the multiplicative inverse, @code(X⁻¹ * X = X * X⁻¹ = 1). The resulting dimension is the inverse of the original dimension. Raises a floating-point exception if the value is not invertible. }
    function Inverse: TCL2VecQuantity;

    { Returns the value divided by its norm. The dimension is preserved. }
    function Normalized: TCL2VecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL2VecQuantity): TCL2VecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL2BivecQuantity): TCL2VecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL2VecQuantity): TCL2VecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL2BivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL2VecQuantity): TCL2VecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL2BivecQuantity): TCL2VecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL2VecQuantity; const AVector2: TCL2VecQuantity): TCL2VecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL2BivecQuantity; const AVector2: TCL2BivecQuantity): TCL2VecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL2MultivecQuantity; const AVector2: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns @code(ARotor X ~ARotor), the rotation by the rotor @code(ARotor) (@code(ARotor ~ARotor = 1)). The result keeps the type of the value; the components of other grades, zero for a rotor, are dropped. The resulting dimension is the original dimension times the square of the dimension of the rotor. }
    function Rotate(const ARotor: TCL2MultivecQuantity): TCL2VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL2VecQuantity): TRealQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL2BivecQuantity): TCL2VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL2VecQuantity): TCL2BivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL2BivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TCL2BivecQuantity): the methods of @link(TCL2Bivector) on dimensioned values.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL2BivecQuantityHelper = record helper for TCL2BivecQuantity
    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL2BivectorComponents): TCL2BivecQuantity;

    { Returns the value as a multivector quantity. The dimension is preserved. }
    function ToMultivector: TCL2MultivecQuantity;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL2MultivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL2BivecQuantity): boolean;

    { Returns the norm @code(Sqrt(Abs(SquaredNorm))). The dimension is preserved. }
    function Norm: TRealQuantity;

    { Returns the squared norm @code(<X ~X>₀). The resulting dimension is the square of the original dimension. }
    function SquaredNorm: TRealQuantity;

    { Returns the dual @code(X * I), with @code(I) the unit pseudoscalar. The dimension is preserved. }
    function Dual: TRealQuantity;

    { Returns the grade involution: every grade-@code(k) component is multiplied by @code((-1)^k). The dimension is preserved. }
    function Involute: TCL2BivecQuantity;

    { Returns the reverse: every grade-@code(k) component is multiplied by @code((-1)^(k(k-1)/2)). The dimension is preserved. }
    function Reverse: TCL2BivecQuantity;

    { Returns the Clifford conjugate, the reverse of the grade involution. The dimension is preserved. }
    function Conjugate: TCL2BivecQuantity;

    { Returns the multiplicative inverse, @code(X⁻¹ * X = X * X⁻¹ = 1). The resulting dimension is the inverse of the original dimension. Raises a floating-point exception if the value is not invertible. }
    function Inverse: TCL2BivecQuantity;

    { Returns the value divided by its norm. The dimension is preserved. }
    function Normalized: TCL2BivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL2VecQuantity): TCL2BivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL2BivecQuantity): TCL2BivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL2MultivecQuantity): TCL2BivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL2VecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL2BivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL2VecQuantity): TCL2BivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL2BivecQuantity): TCL2BivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL2VecQuantity; const AVector2: TCL2VecQuantity): TCL2BivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL2BivecQuantity; const AVector2: TCL2BivecQuantity): TCL2BivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL2MultivecQuantity; const AVector2: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns @code(ARotor X ~ARotor), the rotation by the rotor @code(ARotor) (@code(ARotor ~ARotor = 1)). The result keeps the type of the value; the components of other grades, zero for a rotor, are dropped. The resulting dimension is the original dimension times the square of the dimension of the rotor. }
    function Rotate(const ARotor: TCL2MultivecQuantity): TCL2BivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL2VecQuantity): TCL2VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL2BivecQuantity): TRealQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL2VecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL2BivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL2MultivecQuantity): TCL2BivecQuantity;
  end;
  {$ENDIF}

  { Represents a multivector of @code(Cl(3,0)) with a physical dimension.

    Combines a @link(TCL3Multivector) value with a @link(TDimension) shared by all
    its components. Arithmetic follows both the rules of the algebra and the
    rules of dimensional analysis: incompatible dimensions raise
    @link(EDimensionError) at run time. When the symbol @code(ADIMOFF) is
    defined, this type is an alias of @link(TCL3Multivector).
  }
  {$IFNDEF ADIMOFF}
  TCL3MultivecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL3Multivector;
  public
    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3MultivecQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns the opposite of the quantity. The dimension is preserved. }
    class operator -(const AValue: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3MultivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3MultivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3MultivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3MultivecQuantity; const ARight: TReal): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TReal; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3MultivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Converts a mathematical multivector to a dimensionless quantity. }
    class operator :=(const AValue: TCL3Multivector): TCL3MultivecQuantity;
  end;
  {$ELSE}
  { Mathematical @code(Cl(3,0)) multivector used when dimensional checks are disabled. }
  TCL3MultivecQuantity = TCL3Multivector;
  {$ENDIF}

  { Represents a vector of @code(Cl(3,0)) with a physical dimension.

    Combines a @link(TCL3Vector) value with a @link(TDimension) shared by all
    its components. Arithmetic follows both the rules of the algebra and the
    rules of dimensional analysis: incompatible dimensions raise
    @link(EDimensionError) at run time. When the symbol @code(ADIMOFF) is
    defined, this type is an alias of @link(TCL3Vector).
  }
  {$IFNDEF ADIMOFF}
  TCL3VecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL3Vector;
  public
    { Widens the quantity to a @link(TCL3MultivecQuantity). The dimension is preserved. }
    class operator :=(const AValue: TCL3VecQuantity): TCL3MultivecQuantity;

    { Keeps the vector components of a multivector quantity and discards the others. The dimension is preserved. }
    class operator Explicit(const AValue: TCL3MultivecQuantity): TCL3VecQuantity;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3VecQuantity; const ARight: TCL3VecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3VecQuantity; const ARight: TCL3VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): boolean;

    { Returns the opposite of the quantity. The dimension is preserved. }
    class operator -(const AValue: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3VecQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3VecQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): TCL3VecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3VecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): TCL3VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3VecQuantity; const ARight: TReal): TCL3VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TReal; const ARight: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3VecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Converts a mathematical vector to a dimensionless quantity. }
    class operator :=(const AValue: TCL3Vector): TCL3VecQuantity;
  end;
  {$ELSE}
  { Mathematical @code(Cl(3,0)) vector used when dimensional checks are disabled. }
  TCL3VecQuantity = TCL3Vector;
  {$ENDIF}

  { Represents a bivector of @code(Cl(3,0)) with a physical dimension.

    Combines a @link(TCL3Bivector) value with a @link(TDimension) shared by all
    its components. Arithmetic follows both the rules of the algebra and the
    rules of dimensional analysis: incompatible dimensions raise
    @link(EDimensionError) at run time. When the symbol @code(ADIMOFF) is
    defined, this type is an alias of @link(TCL3Bivector).
  }
  {$IFNDEF ADIMOFF}
  TCL3BivecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL3Bivector;
  public
    { Widens the quantity to a @link(TCL3MultivecQuantity). The dimension is preserved. }
    class operator :=(const AValue: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Keeps the bivector components of a multivector quantity and discards the others. The dimension is preserved. }
    class operator Explicit(const AValue: TCL3MultivecQuantity): TCL3BivecQuantity;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3BivecQuantity; const ARight: TCL3BivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3BivecQuantity; const ARight: TCL3BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): boolean;

    { Returns the opposite of the quantity. The dimension is preserved. }
    class operator -(const AValue: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3BivecQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3BivecQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): TCL3BivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3BivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): TCL3BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3BivecQuantity; const ARight: TReal): TCL3BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TReal; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3BivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Converts a mathematical bivector to a dimensionless quantity. }
    class operator :=(const AValue: TCL3Bivector): TCL3BivecQuantity;
  end;
  {$ELSE}
  { Mathematical @code(Cl(3,0)) bivector used when dimensional checks are disabled. }
  TCL3BivecQuantity = TCL3Bivector;
  {$ENDIF}

  { Represents a trivector of @code(Cl(3,0)) with a physical dimension.

    Combines a @link(TCL3Trivector) value with a @link(TDimension) shared by all
    its components. Arithmetic follows both the rules of the algebra and the
    rules of dimensional analysis: incompatible dimensions raise
    @link(EDimensionError) at run time. When the symbol @code(ADIMOFF) is
    defined, this type is an alias of @link(TCL3Trivector).
  }
  {$IFNDEF ADIMOFF}
  TCL3TrivecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL3Trivector;
  public
    { Widens the quantity to a @link(TCL3MultivecQuantity). The dimension is preserved. }
    class operator :=(const AValue: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Keeps the trivector components of a multivector quantity and discards the others. The dimension is preserved. }
    class operator Explicit(const AValue: TCL3MultivecQuantity): TCL3TrivecQuantity;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3TrivecQuantity; const ARight: TCL3TrivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3TrivecQuantity; const ARight: TCL3TrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): boolean;

    { Returns the opposite of the quantity. The dimension is preserved. }
    class operator -(const AValue: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3TrivecQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3TrivecQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): TCL3TrivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3TrivecQuantity; const ARight: TCL3TrivecQuantity): TRealQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3BivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3BivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3VecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3VecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): TCL3TrivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3TrivecQuantity; const ARight: TReal): TCL3TrivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TReal; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3TrivecQuantity; const ARight: TCL3TrivecQuantity): TRealQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Converts a mathematical trivector to a dimensionless quantity. }
    class operator :=(const AValue: TCL3Trivector): TCL3TrivecQuantity;
  end;
  {$ELSE}
  { Mathematical @code(Cl(3,0)) trivector used when dimensional checks are disabled. }
  TCL3TrivecQuantity = TCL3Trivector;
  {$ENDIF}

  { Record helper for @link(TCL3MultivecQuantity): the methods of @link(TCL3Multivector) on dimensioned values.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL3MultivecQuantityHelper = record helper for TCL3MultivecQuantity
    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL3MultivectorComponents): TCL3MultivecQuantity;

    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL3TrivectorComponents): TCL3TrivecQuantity;

    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL3BivectorComponents): TCL3BivecQuantity;

    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL3VectorComponents): TCL3VecQuantity;

    { Returns the trivector part. The dimension is preserved. }
    function ExtractTrivector: TCL3TrivecQuantity;

    { Returns the bivector part. The dimension is preserved. }
    function ExtractBivector: TCL3BivecQuantity;

    { Returns the vector part. The dimension is preserved. }
    function ExtractVector: TCL3VecQuantity;

    { Returns the scalar part. The dimension is preserved. }
    function ExtractScalar: TRealQuantity;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL3MultivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL3TrivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL3BivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL3VecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TRealQuantity): boolean;

    { Returns @true if all the components are zero. }
    function IsNull: boolean;

    { Returns @true if only the scalar components are non-zero. }
    function IsScalar: boolean;

    { Returns @true if only the vector components are non-zero. }
    function IsVector: boolean;

    { Returns @true if only the bivector components are non-zero. }
    function IsBivector: boolean;

    { Returns @true if only the trivector components are non-zero. }
    function IsTrivector: boolean;

    { Returns the name of the smallest value type that holds the value. }
    function IsA: string;

    { Returns the norm @code(Sqrt(Abs(SquaredNorm))). The dimension is preserved. }
    function Norm: TRealQuantity;

    { Returns the squared norm @code(<X ~X>₀). The resulting dimension is the square of the original dimension. }
    function SquaredNorm: TRealQuantity;

    { Returns the dual @code(X * I), with @code(I) the unit pseudoscalar. The dimension is preserved. }
    function Dual: TCL3MultivecQuantity;

    { Returns the grade involution: every grade-@code(k) component is multiplied by @code((-1)^k). The dimension is preserved. }
    function Involute: TCL3MultivecQuantity;

    { Returns the reverse: every grade-@code(k) component is multiplied by @code((-1)^(k(k-1)/2)). The dimension is preserved. }
    function Reverse: TCL3MultivecQuantity;

    { Returns the Clifford conjugate, the reverse of the grade involution. The dimension is preserved. }
    function Conjugate: TCL3MultivecQuantity;

    { Returns the multiplicative inverse, @code(X⁻¹ * X = X * X⁻¹ = 1). The resulting dimension is the inverse of the original dimension. Raises a floating-point exception if the value is not invertible. }
    function Inverse: TCL3MultivecQuantity;

    { Returns a mask with bit @code(g) set when some component of grade @code(g) is non-zero. }
    function GradeMask: longword;

    { Returns the value divided by its norm. The dimension is preserved. }
    function Normalized: TCL3MultivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3VecQuantity; const AVector2: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3BivecQuantity; const AVector2: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3TrivecQuantity; const AVector2: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3MultivecQuantity; const AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns @code(ARotor X ~ARotor), the rotation by the rotor @code(ARotor) (@code(ARotor ~ARotor = 1)). The result keeps the type of the value; the components of other grades, zero for a rotor, are dropped. The resulting dimension is the original dimension times the square of the dimension of the rotor. }
    function Rotate(const ARotor: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TCL3VecQuantity): the methods of @link(TCL3Vector) on dimensioned values.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL3VecQuantityHelper = record helper for TCL3VecQuantity
    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL3VectorComponents): TCL3VecQuantity;

    { Returns the value as a multivector quantity. The dimension is preserved. }
    function ToMultivector: TCL3MultivecQuantity;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL3MultivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL3VecQuantity): boolean;

    { Returns the norm @code(Sqrt(Abs(SquaredNorm))). The dimension is preserved. }
    function Norm: TRealQuantity;

    { Returns the squared norm @code(<X ~X>₀). The resulting dimension is the square of the original dimension. }
    function SquaredNorm: TRealQuantity;

    { Returns the dual @code(X * I), with @code(I) the unit pseudoscalar. The dimension is preserved. }
    function Dual: TCL3BivecQuantity;

    { Returns the grade involution: every grade-@code(k) component is multiplied by @code((-1)^k). The dimension is preserved. }
    function Involute: TCL3VecQuantity;

    { Returns the reverse: every grade-@code(k) component is multiplied by @code((-1)^(k(k-1)/2)). The dimension is preserved. }
    function Reverse: TCL3VecQuantity;

    { Returns the Clifford conjugate, the reverse of the grade involution. The dimension is preserved. }
    function Conjugate: TCL3VecQuantity;

    { Returns the multiplicative inverse, @code(X⁻¹ * X = X * X⁻¹ = 1). The resulting dimension is the inverse of the original dimension. Raises a floating-point exception if the value is not invertible. }
    function Inverse: TCL3VecQuantity;

    { Returns the value divided by its norm. The dimension is preserved. }
    function Normalized: TCL3VecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3BivecQuantity): TCL3VecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3TrivecQuantity): TCL3VecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3BivecQuantity): TCL3VecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3BivecQuantity): TCL3VecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3VecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3VecQuantity; const AVector2: TCL3VecQuantity): TCL3VecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3BivecQuantity; const AVector2: TCL3BivecQuantity): TCL3VecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3TrivecQuantity; const AVector2: TCL3TrivecQuantity): TCL3VecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3MultivecQuantity; const AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns @code(ARotor X ~ARotor), the rotation by the rotor @code(ARotor) (@code(ARotor ~ARotor = 1)). The result keeps the type of the value; the components of other grades, zero for a rotor, are dropped. The resulting dimension is the original dimension times the square of the dimension of the rotor. }
    function Rotate(const ARotor: TCL3MultivecQuantity): TCL3VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3VecQuantity): TRealQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3BivecQuantity): TCL3VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3VecQuantity): TCL3BivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3TrivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the cross product, the dual of the wedge product with the opposite sign. The resulting dimension is the product of the two dimensions. }
    function Cross(const AVector: TCL3VecQuantity): TCL3VecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TCL3BivecQuantity): the methods of @link(TCL3Bivector) on dimensioned values.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL3BivecQuantityHelper = record helper for TCL3BivecQuantity
    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL3BivectorComponents): TCL3BivecQuantity;

    { Returns the value as a multivector quantity. The dimension is preserved. }
    function ToMultivector: TCL3MultivecQuantity;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL3MultivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL3BivecQuantity): boolean;

    { Returns the norm @code(Sqrt(Abs(SquaredNorm))). The dimension is preserved. }
    function Norm: TRealQuantity;

    { Returns the squared norm @code(<X ~X>₀). The resulting dimension is the square of the original dimension. }
    function SquaredNorm: TRealQuantity;

    { Returns the dual @code(X * I), with @code(I) the unit pseudoscalar. The dimension is preserved. }
    function Dual: TCL3VecQuantity;

    { Returns the grade involution: every grade-@code(k) component is multiplied by @code((-1)^k). The dimension is preserved. }
    function Involute: TCL3BivecQuantity;

    { Returns the reverse: every grade-@code(k) component is multiplied by @code((-1)^(k(k-1)/2)). The dimension is preserved. }
    function Reverse: TCL3BivecQuantity;

    { Returns the Clifford conjugate, the reverse of the grade involution. The dimension is preserved. }
    function Conjugate: TCL3BivecQuantity;

    { Returns the multiplicative inverse, @code(X⁻¹ * X = X * X⁻¹ = 1). The resulting dimension is the inverse of the original dimension. Raises a floating-point exception if the value is not invertible. }
    function Inverse: TCL3BivecQuantity;

    { Returns the value divided by its norm. The dimension is preserved. }
    function Normalized: TCL3BivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3VecQuantity): TCL3BivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3VecQuantity): TCL3BivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3BivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3VecQuantity): TCL3BivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3VecQuantity; const AVector2: TCL3VecQuantity): TCL3BivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3BivecQuantity; const AVector2: TCL3BivecQuantity): TCL3BivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3TrivecQuantity; const AVector2: TCL3TrivecQuantity): TCL3BivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3MultivecQuantity; const AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns @code(ARotor X ~ARotor), the rotation by the rotor @code(ARotor) (@code(ARotor ~ARotor = 1)). The result keeps the type of the value; the components of other grades, zero for a rotor, are dropped. The resulting dimension is the original dimension times the square of the dimension of the rotor. }
    function Rotate(const ARotor: TCL3MultivecQuantity): TCL3BivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3VecQuantity): TCL3VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3BivecQuantity): TRealQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3TrivecQuantity): TCL3VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3VecQuantity): TCL3TrivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3BivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3TrivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TCL3TrivecQuantity): the methods of @link(TCL3Trivector) on dimensioned values.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL3TrivecQuantityHelper = record helper for TCL3TrivecQuantity
    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL3TrivectorComponents): TCL3TrivecQuantity;

    { Returns the value as a multivector quantity. The dimension is preserved. }
    function ToMultivector: TCL3MultivecQuantity;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL3MultivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL3TrivecQuantity): boolean;

    { Returns the norm @code(Sqrt(Abs(SquaredNorm))). The dimension is preserved. }
    function Norm: TRealQuantity;

    { Returns the squared norm @code(<X ~X>₀). The resulting dimension is the square of the original dimension. }
    function SquaredNorm: TRealQuantity;

    { Returns the dual @code(X * I), with @code(I) the unit pseudoscalar. The dimension is preserved. }
    function Dual: TRealQuantity;

    { Returns the grade involution: every grade-@code(k) component is multiplied by @code((-1)^k). The dimension is preserved. }
    function Involute: TCL3TrivecQuantity;

    { Returns the reverse: every grade-@code(k) component is multiplied by @code((-1)^(k(k-1)/2)). The dimension is preserved. }
    function Reverse: TCL3TrivecQuantity;

    { Returns the Clifford conjugate, the reverse of the grade involution. The dimension is preserved. }
    function Conjugate: TCL3TrivecQuantity;

    { Returns the multiplicative inverse, @code(X⁻¹ * X = X * X⁻¹ = 1). The resulting dimension is the inverse of the original dimension. Raises a floating-point exception if the value is not invertible. }
    function Inverse: TCL3TrivecQuantity;

    { Returns the value divided by its norm. The dimension is preserved. }
    function Normalized: TCL3TrivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3VecQuantity): TCL3TrivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3VecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3BivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3VecQuantity): TCL3TrivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3VecQuantity; const AVector2: TCL3VecQuantity): TCL3TrivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3BivecQuantity; const AVector2: TCL3BivecQuantity): TCL3TrivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3TrivecQuantity; const AVector2: TCL3TrivecQuantity): TCL3TrivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL3MultivecQuantity; const AVector2: TCL3MultivecQuantity): TCL3TrivecQuantity;

    { Returns @code(ARotor X ~ARotor), the rotation by the rotor @code(ARotor) (@code(ARotor ~ARotor = 1)). The result keeps the type of the value; the components of other grades, zero for a rotor, are dropped. The resulting dimension is the original dimension times the square of the dimension of the rotor. }
    function Rotate(const ARotor: TCL3MultivecQuantity): TCL3TrivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3VecQuantity): TCL3BivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3BivecQuantity): TCL3VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3TrivecQuantity): TRealQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3VecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3BivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3TrivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity;
  end;
  {$ENDIF}

  { Represents a multivector of @code(Cl(1,3)) with a physical dimension.

    Combines a @link(TCL13Multivector) value with a @link(TDimension) shared by all
    its components. Arithmetic follows both the rules of the algebra and the
    rules of dimensional analysis: incompatible dimensions raise
    @link(EDimensionError) at run time. When the symbol @code(ADIMOFF) is
    defined, this type is an alias of @link(TCL13Multivector).
  }
  {$IFNDEF ADIMOFF}
  TCL13MultivecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL13Multivector;
  public
    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13MultivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TRealQuantity; const ARight: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13MultivecQuantity; const ARight: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13MultivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TRealQuantity; const ARight: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13MultivecQuantity; const ARight: TCL13MultivecQuantity): boolean;

    { Returns the opposite of the quantity. The dimension is preserved. }
    class operator -(const AValue: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13MultivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13MultivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13MultivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13MultivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13MultivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TRealQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13MultivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13MultivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13MultivecQuantity; const ARight: TReal): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TReal; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13MultivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Converts a mathematical multivector to a dimensionless quantity. }
    class operator :=(const AValue: TCL13Multivector): TCL13MultivecQuantity;
  end;
  {$ELSE}
  { Mathematical @code(Cl(1,3)) multivector used when dimensional checks are disabled. }
  TCL13MultivecQuantity = TCL13Multivector;
  {$ENDIF}

  { Represents a vector of @code(Cl(1,3)) with a physical dimension.

    Combines a @link(TCL13Vector) value with a @link(TDimension) shared by all
    its components. Arithmetic follows both the rules of the algebra and the
    rules of dimensional analysis: incompatible dimensions raise
    @link(EDimensionError) at run time. When the symbol @code(ADIMOFF) is
    defined, this type is an alias of @link(TCL13Vector).
  }
  {$IFNDEF ADIMOFF}
  TCL13VecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL13Vector;
  public
    { Widens the quantity to a @link(TCL13MultivecQuantity). The dimension is preserved. }
    class operator :=(const AValue: TCL13VecQuantity): TCL13MultivecQuantity;

    { Keeps the vector components of a multivector quantity and discards the others. The dimension is preserved. }
    class operator Explicit(const AValue: TCL13MultivecQuantity): TCL13VecQuantity;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13VecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TRealQuantity; const ARight: TCL13VecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13VecQuantity; const ARight: TCL13VecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13VecQuantity; const ARight: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13MultivecQuantity; const ARight: TCL13VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13VecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TRealQuantity; const ARight: TCL13VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13VecQuantity; const ARight: TCL13VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13VecQuantity; const ARight: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13MultivecQuantity; const ARight: TCL13VecQuantity): boolean;

    { Returns the opposite of the quantity. The dimension is preserved. }
    class operator -(const AValue: TCL13VecQuantity): TCL13VecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13VecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13VecQuantity; const ARight: TCL13VecQuantity): TCL13VecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13VecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13MultivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13VecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13VecQuantity; const ARight: TCL13VecQuantity): TCL13VecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13VecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13MultivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13VecQuantity; const ARight: TRealQuantity): TCL13VecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TRealQuantity; const ARight: TCL13VecQuantity): TCL13VecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13VecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13VecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13MultivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13VecQuantity; const ARight: TRealQuantity): TCL13VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13VecQuantity; const ARight: TReal): TCL13VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL13VecQuantity): TCL13VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TReal; const ARight: TCL13VecQuantity): TCL13VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13VecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13VecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13MultivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Converts a mathematical vector to a dimensionless quantity. }
    class operator :=(const AValue: TCL13Vector): TCL13VecQuantity;
  end;
  {$ELSE}
  { Mathematical @code(Cl(1,3)) vector used when dimensional checks are disabled. }
  TCL13VecQuantity = TCL13Vector;
  {$ENDIF}

  { Represents a bivector of @code(Cl(1,3)) with a physical dimension.

    Combines a @link(TCL13Bivector) value with a @link(TDimension) shared by all
    its components. Arithmetic follows both the rules of the algebra and the
    rules of dimensional analysis: incompatible dimensions raise
    @link(EDimensionError) at run time. When the symbol @code(ADIMOFF) is
    defined, this type is an alias of @link(TCL13Bivector).
  }
  {$IFNDEF ADIMOFF}
  TCL13BivecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL13Bivector;
  public
    { Widens the quantity to a @link(TCL13MultivecQuantity). The dimension is preserved. }
    class operator :=(const AValue: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Keeps the bivector components of a multivector quantity and discards the others. The dimension is preserved. }
    class operator Explicit(const AValue: TCL13MultivecQuantity): TCL13BivecQuantity;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13BivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TRealQuantity; const ARight: TCL13BivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13BivecQuantity; const ARight: TCL13BivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13BivecQuantity; const ARight: TCL13VecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13VecQuantity; const ARight: TCL13BivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13BivecQuantity; const ARight: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13MultivecQuantity; const ARight: TCL13BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13BivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TRealQuantity; const ARight: TCL13BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13BivecQuantity; const ARight: TCL13BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13BivecQuantity; const ARight: TCL13VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13VecQuantity; const ARight: TCL13BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13BivecQuantity; const ARight: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13MultivecQuantity; const ARight: TCL13BivecQuantity): boolean;

    { Returns the opposite of the quantity. The dimension is preserved. }
    class operator -(const AValue: TCL13BivecQuantity): TCL13BivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13BivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13BivecQuantity; const ARight: TCL13BivecQuantity): TCL13BivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13BivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13VecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13BivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13MultivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13BivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13BivecQuantity; const ARight: TCL13BivecQuantity): TCL13BivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13BivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13VecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13BivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13MultivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13BivecQuantity; const ARight: TRealQuantity): TCL13BivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TRealQuantity; const ARight: TCL13BivecQuantity): TCL13BivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13BivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13BivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13VecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13BivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13MultivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13BivecQuantity; const ARight: TRealQuantity): TCL13BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13BivecQuantity; const ARight: TReal): TCL13BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL13BivecQuantity): TCL13BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TReal; const ARight: TCL13BivecQuantity): TCL13BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13BivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13BivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13VecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13BivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13MultivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Converts a mathematical bivector to a dimensionless quantity. }
    class operator :=(const AValue: TCL13Bivector): TCL13BivecQuantity;
  end;
  {$ELSE}
  { Mathematical @code(Cl(1,3)) bivector used when dimensional checks are disabled. }
  TCL13BivecQuantity = TCL13Bivector;
  {$ENDIF}

  { Represents a trivector of @code(Cl(1,3)) with a physical dimension.

    Combines a @link(TCL13Trivector) value with a @link(TDimension) shared by all
    its components. Arithmetic follows both the rules of the algebra and the
    rules of dimensional analysis: incompatible dimensions raise
    @link(EDimensionError) at run time. When the symbol @code(ADIMOFF) is
    defined, this type is an alias of @link(TCL13Trivector).
  }
  {$IFNDEF ADIMOFF}
  TCL13TrivecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL13Trivector;
  public
    { Widens the quantity to a @link(TCL13MultivecQuantity). The dimension is preserved. }
    class operator :=(const AValue: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Keeps the trivector components of a multivector quantity and discards the others. The dimension is preserved. }
    class operator Explicit(const AValue: TCL13MultivecQuantity): TCL13TrivecQuantity;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13TrivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TRealQuantity; const ARight: TCL13TrivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13TrivecQuantity; const ARight: TCL13TrivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13TrivecQuantity; const ARight: TCL13VecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13VecQuantity; const ARight: TCL13TrivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13TrivecQuantity; const ARight: TCL13BivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13BivecQuantity; const ARight: TCL13TrivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13TrivecQuantity; const ARight: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13MultivecQuantity; const ARight: TCL13TrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13TrivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TRealQuantity; const ARight: TCL13TrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13TrivecQuantity; const ARight: TCL13TrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13TrivecQuantity; const ARight: TCL13VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13VecQuantity; const ARight: TCL13TrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13TrivecQuantity; const ARight: TCL13BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13BivecQuantity; const ARight: TCL13TrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13TrivecQuantity; const ARight: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13MultivecQuantity; const ARight: TCL13TrivecQuantity): boolean;

    { Returns the opposite of the quantity. The dimension is preserved. }
    class operator -(const AValue: TCL13TrivecQuantity): TCL13TrivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13TrivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13TrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13TrivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13TrivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13VecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13TrivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13BivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13TrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13MultivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13TrivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13TrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13TrivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13TrivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13VecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13TrivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13BivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13TrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13MultivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13TrivecQuantity; const ARight: TRealQuantity): TCL13TrivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TRealQuantity; const ARight: TCL13TrivecQuantity): TCL13TrivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13TrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13TrivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13VecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13TrivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13BivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13TrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13MultivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13TrivecQuantity; const ARight: TRealQuantity): TCL13TrivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13TrivecQuantity; const ARight: TReal): TCL13TrivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL13TrivecQuantity): TCL13TrivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TReal; const ARight: TCL13TrivecQuantity): TCL13TrivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13TrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13TrivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13VecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13TrivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13BivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13TrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13MultivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Converts a mathematical trivector to a dimensionless quantity. }
    class operator :=(const AValue: TCL13Trivector): TCL13TrivecQuantity;
  end;
  {$ELSE}
  { Mathematical @code(Cl(1,3)) trivector used when dimensional checks are disabled. }
  TCL13TrivecQuantity = TCL13Trivector;
  {$ENDIF}

  { Represents a quadrivector of @code(Cl(1,3)) with a physical dimension.

    Combines a @link(TCL13Quadrivector) value with a @link(TDimension) shared by all
    its components. Arithmetic follows both the rules of the algebra and the
    rules of dimensional analysis: incompatible dimensions raise
    @link(EDimensionError) at run time. When the symbol @code(ADIMOFF) is
    defined, this type is an alias of @link(TCL13Quadrivector).
  }
  {$IFNDEF ADIMOFF}
  TCL13QuadrivecQuantity = record
  private
    FDim: TDimension;
    FValue: TCL13Quadrivector;
  public
    { Widens the quantity to a @link(TCL13MultivecQuantity). The dimension is preserved. }
    class operator :=(const AValue: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Keeps the quadrivector components of a multivector quantity and discards the others. The dimension is preserved. }
    class operator Explicit(const AValue: TCL13MultivecQuantity): TCL13QuadrivecQuantity;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13QuadrivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TRealQuantity; const ARight: TCL13QuadrivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13VecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13VecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13BivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13BivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13TrivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13TrivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities have equal components. Both operands must have the same dimension. }
    class operator =(const ALeft: TCL13MultivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13QuadrivecQuantity; const ARight: TRealQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TRealQuantity; const ARight: TCL13QuadrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13VecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13VecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13BivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13BivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13TrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13TrivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities differ in some component. Both operands must have the same dimension. }
    class operator <>(const ALeft: TCL13MultivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;

    { Returns the opposite of the quantity. The dimension is preserved. }
    class operator -(const AValue: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13QuadrivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TRealQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13VecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13BivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13TrivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the sum of two quantities. Both operands must have the same dimension. }
    class operator +(const ALeft: TCL13MultivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13QuadrivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TRealQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13VecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13BivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13TrivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the difference of two quantities. Both operands must have the same dimension. }
    class operator -(const ALeft: TCL13MultivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13QuadrivecQuantity; const ARight: TRealQuantity): TCL13QuadrivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TRealQuantity; const ARight: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13QuadrivecQuantity): TRealQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13VecQuantity): TCL13TrivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13VecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13TrivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13BivecQuantity): TCL13BivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13BivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13BivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13VecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13TrivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13VecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric product. The resulting dimension is the product of the two dimensions. }
    class operator *(const ALeft: TCL13MultivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13QuadrivecQuantity; const ARight: TRealQuantity): TCL13QuadrivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13QuadrivecQuantity; const ARight: TReal): TCL13QuadrivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TRealQuantity; const ARight: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TReal; const ARight: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13QuadrivecQuantity): TRealQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13VecQuantity): TCL13TrivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13VecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13TrivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13BivecQuantity): TCL13BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13BivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13BivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13TrivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13VecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the geometric quotient @code(ALeft * ARight⁻¹). The resulting dimension is the ratio of the two dimensions. }
    class operator /(const ALeft: TCL13MultivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Converts a mathematical quadrivector to a dimensionless quantity. }
    class operator :=(const AValue: TCL13Quadrivector): TCL13QuadrivecQuantity;
  end;
  {$ELSE}
  { Mathematical @code(Cl(1,3)) quadrivector used when dimensional checks are disabled. }
  TCL13QuadrivecQuantity = TCL13Quadrivector;
  {$ENDIF}

  { Record helper for @link(TCL13MultivecQuantity): the methods of @link(TCL13Multivector) on dimensioned values.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL13MultivecQuantityHelper = record helper for TCL13MultivecQuantity
    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL13MultivectorComponents): TCL13MultivecQuantity;

    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL13QuadrivectorComponents): TCL13QuadrivecQuantity;

    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL13TrivectorComponents): TCL13TrivecQuantity;

    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL13BivectorComponents): TCL13BivecQuantity;

    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL13VectorComponents): TCL13VecQuantity;

    { Returns the quadrivector part. The dimension is preserved. }
    function ExtractQuadrivector: TCL13QuadrivecQuantity;

    { Returns the trivector part. The dimension is preserved. }
    function ExtractTrivector: TCL13TrivecQuantity;

    { Returns the bivector part. The dimension is preserved. }
    function ExtractBivector: TCL13BivecQuantity;

    { Returns the vector part. The dimension is preserved. }
    function ExtractVector: TCL13VecQuantity;

    { Returns the scalar part. The dimension is preserved. }
    function ExtractScalar: TRealQuantity;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL13QuadrivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL13TrivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL13BivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL13VecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TRealQuantity): boolean;

    { Returns @true if all the components are zero. }
    function IsNull: boolean;

    { Returns @true if only the scalar components are non-zero. }
    function IsScalar: boolean;

    { Returns @true if only the vector components are non-zero. }
    function IsVector: boolean;

    { Returns @true if only the bivector components are non-zero. }
    function IsBivector: boolean;

    { Returns @true if only the trivector components are non-zero. }
    function IsTrivector: boolean;

    { Returns @true if only the quadrivector components are non-zero. }
    function IsQuadrivector: boolean;

    { Returns the name of the smallest value type that holds the value. }
    function IsA: string;

    { Returns the norm @code(Sqrt(Abs(SquaredNorm))). The dimension is preserved. }
    function Norm: TRealQuantity;

    { Returns the squared norm @code(<X ~X>₀). The resulting dimension is the square of the original dimension. }
    function SquaredNorm: TRealQuantity;

    { Returns the dual @code(X * I), with @code(I) the unit pseudoscalar. The dimension is preserved. }
    function Dual: TCL13MultivecQuantity;

    { Returns the grade involution: every grade-@code(k) component is multiplied by @code((-1)^k). The dimension is preserved. }
    function Involute: TCL13MultivecQuantity;

    { Returns the reverse: every grade-@code(k) component is multiplied by @code((-1)^(k(k-1)/2)). The dimension is preserved. }
    function Reverse: TCL13MultivecQuantity;

    { Returns the Clifford conjugate, the reverse of the grade involution. The dimension is preserved. }
    function Conjugate: TCL13MultivecQuantity;

    { Returns the multiplicative inverse, @code(X⁻¹ * X = X * X⁻¹ = 1). The resulting dimension is the inverse of the original dimension. Raises a floating-point exception if the value is not invertible. }
    function Inverse: TCL13MultivecQuantity;

    { Returns a mask with bit @code(g) set when some component of grade @code(g) is non-zero. }
    function GradeMask: longword;

    { Returns the value divided by its norm. The dimension is preserved. }
    function Normalized: TCL13MultivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13QuadrivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13VecQuantity; const AVector2: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13BivecQuantity; const AVector2: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13TrivecQuantity; const AVector2: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13QuadrivecQuantity; const AVector2: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13MultivecQuantity; const AVector2: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns @code(ARotor X ~ARotor), the rotation by the rotor @code(ARotor) (@code(ARotor ~ARotor = 1)). The result keeps the type of the value; the components of other grades, zero for a rotor, are dropped. The resulting dimension is the original dimension times the square of the dimension of the rotor. }
    function Rotate(const ARotor: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13QuadrivecQuantity): TCL13MultivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13VecQuantity): TCL13MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13TrivecQuantity): TCL13MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TCL13VecQuantity): the methods of @link(TCL13Vector) on dimensioned values.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL13VecQuantityHelper = record helper for TCL13VecQuantity
    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL13VectorComponents): TCL13VecQuantity;

    { Returns the value as a multivector quantity. The dimension is preserved. }
    function ToMultivector: TCL13MultivecQuantity;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL13VecQuantity): boolean;

    { Returns the norm @code(Sqrt(Abs(SquaredNorm))). The dimension is preserved. }
    function Norm: TRealQuantity;

    { Returns the squared norm @code(<X ~X>₀). The resulting dimension is the square of the original dimension. }
    function SquaredNorm: TRealQuantity;

    { Returns the dual @code(X * I), with @code(I) the unit pseudoscalar. The dimension is preserved. }
    function Dual: TCL13TrivecQuantity;

    { Returns the grade involution: every grade-@code(k) component is multiplied by @code((-1)^k). The dimension is preserved. }
    function Involute: TCL13VecQuantity;

    { Returns the reverse: every grade-@code(k) component is multiplied by @code((-1)^(k(k-1)/2)). The dimension is preserved. }
    function Reverse: TCL13VecQuantity;

    { Returns the Clifford conjugate, the reverse of the grade involution. The dimension is preserved. }
    function Conjugate: TCL13VecQuantity;

    { Returns the multiplicative inverse, @code(X⁻¹ * X = X * X⁻¹ = 1). The resulting dimension is the inverse of the original dimension. Raises a floating-point exception if the value is not invertible. }
    function Inverse: TCL13VecQuantity;

    { Returns the value divided by its norm. The dimension is preserved. }
    function Normalized: TCL13VecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13VecQuantity): TCL13VecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13TrivecQuantity): TCL13VecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13QuadrivecQuantity): TCL13VecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13VecQuantity): TCL13VecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13TrivecQuantity): TCL13VecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13QuadrivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13VecQuantity): TCL13VecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13TrivecQuantity): TCL13VecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13QuadrivecQuantity): TCL13VecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13VecQuantity; const AVector2: TCL13VecQuantity): TCL13VecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13BivecQuantity; const AVector2: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13TrivecQuantity; const AVector2: TCL13TrivecQuantity): TCL13VecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13QuadrivecQuantity; const AVector2: TCL13QuadrivecQuantity): TCL13VecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13MultivecQuantity; const AVector2: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns @code(ARotor X ~ARotor), the rotation by the rotor @code(ARotor) (@code(ARotor ~ARotor = 1)). The result keeps the type of the value; the components of other grades, zero for a rotor, are dropped. The resulting dimension is the original dimension times the square of the dimension of the rotor. }
    function Rotate(const ARotor: TCL13MultivecQuantity): TCL13VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13VecQuantity): TRealQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13BivecQuantity): TCL13VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13TrivecQuantity): TCL13BivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13QuadrivecQuantity): TCL13TrivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13VecQuantity): TCL13BivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13BivecQuantity): TCL13TrivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13TrivecQuantity): TCL13QuadrivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13QuadrivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TCL13BivecQuantity): the methods of @link(TCL13Bivector) on dimensioned values.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL13BivecQuantityHelper = record helper for TCL13BivecQuantity
    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL13BivectorComponents): TCL13BivecQuantity;

    { Returns the value as a multivector quantity. The dimension is preserved. }
    function ToMultivector: TCL13MultivecQuantity;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL13BivecQuantity): boolean;

    { Returns the norm @code(Sqrt(Abs(SquaredNorm))). The dimension is preserved. }
    function Norm: TRealQuantity;

    { Returns the squared norm @code(<X ~X>₀). The resulting dimension is the square of the original dimension. }
    function SquaredNorm: TRealQuantity;

    { Returns the dual @code(X * I), with @code(I) the unit pseudoscalar. The dimension is preserved. }
    function Dual: TCL13BivecQuantity;

    { Returns the grade involution: every grade-@code(k) component is multiplied by @code((-1)^k). The dimension is preserved. }
    function Involute: TCL13BivecQuantity;

    { Returns the reverse: every grade-@code(k) component is multiplied by @code((-1)^(k(k-1)/2)). The dimension is preserved. }
    function Reverse: TCL13BivecQuantity;

    { Returns the Clifford conjugate, the reverse of the grade involution. The dimension is preserved. }
    function Conjugate: TCL13BivecQuantity;

    { Returns the multiplicative inverse, @code(X⁻¹ * X = X * X⁻¹ = 1). The resulting dimension is the inverse of the original dimension. Raises a floating-point exception if the value is not invertible. }
    function Inverse: TCL13BivecQuantity;

    { Returns the value divided by its norm. The dimension is preserved. }
    function Normalized: TCL13BivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13VecQuantity): TCL13BivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13BivecQuantity): TCL13BivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13TrivecQuantity): TCL13BivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13QuadrivecQuantity): TCL13BivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13VecQuantity): TCL13BivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13BivecQuantity): TCL13BivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13TrivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13QuadrivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13VecQuantity): TCL13BivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13BivecQuantity): TCL13BivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13TrivecQuantity): TCL13BivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13QuadrivecQuantity): TCL13BivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13VecQuantity; const AVector2: TCL13VecQuantity): TCL13BivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13BivecQuantity; const AVector2: TCL13BivecQuantity): TCL13BivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13TrivecQuantity; const AVector2: TCL13TrivecQuantity): TCL13BivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13QuadrivecQuantity; const AVector2: TCL13QuadrivecQuantity): TCL13BivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13MultivecQuantity; const AVector2: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns @code(ARotor X ~ARotor), the rotation by the rotor @code(ARotor) (@code(ARotor ~ARotor = 1)). The result keeps the type of the value; the components of other grades, zero for a rotor, are dropped. The resulting dimension is the original dimension times the square of the dimension of the rotor. }
    function Rotate(const ARotor: TCL13MultivecQuantity): TCL13BivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13VecQuantity): TCL13VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13BivecQuantity): TRealQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13TrivecQuantity): TCL13VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13QuadrivecQuantity): TCL13BivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13VecQuantity): TCL13TrivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13BivecQuantity): TCL13QuadrivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13TrivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13QuadrivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TCL13TrivecQuantity): the methods of @link(TCL13Trivector) on dimensioned values.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL13TrivecQuantityHelper = record helper for TCL13TrivecQuantity
    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL13TrivectorComponents): TCL13TrivecQuantity;

    { Returns the value as a multivector quantity. The dimension is preserved. }
    function ToMultivector: TCL13MultivecQuantity;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL13TrivecQuantity): boolean;

    { Returns the norm @code(Sqrt(Abs(SquaredNorm))). The dimension is preserved. }
    function Norm: TRealQuantity;

    { Returns the squared norm @code(<X ~X>₀). The resulting dimension is the square of the original dimension. }
    function SquaredNorm: TRealQuantity;

    { Returns the dual @code(X * I), with @code(I) the unit pseudoscalar. The dimension is preserved. }
    function Dual: TCL13VecQuantity;

    { Returns the grade involution: every grade-@code(k) component is multiplied by @code((-1)^k). The dimension is preserved. }
    function Involute: TCL13TrivecQuantity;

    { Returns the reverse: every grade-@code(k) component is multiplied by @code((-1)^(k(k-1)/2)). The dimension is preserved. }
    function Reverse: TCL13TrivecQuantity;

    { Returns the Clifford conjugate, the reverse of the grade involution. The dimension is preserved. }
    function Conjugate: TCL13TrivecQuantity;

    { Returns the multiplicative inverse, @code(X⁻¹ * X = X * X⁻¹ = 1). The resulting dimension is the inverse of the original dimension. Raises a floating-point exception if the value is not invertible. }
    function Inverse: TCL13TrivecQuantity;

    { Returns the value divided by its norm. The dimension is preserved. }
    function Normalized: TCL13TrivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13VecQuantity): TCL13TrivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13TrivecQuantity): TCL13TrivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13QuadrivecQuantity): TCL13TrivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13VecQuantity): TCL13TrivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13BivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13TrivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13QuadrivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13VecQuantity): TCL13TrivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13TrivecQuantity): TCL13TrivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13QuadrivecQuantity): TCL13TrivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13VecQuantity; const AVector2: TCL13VecQuantity): TCL13TrivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13BivecQuantity; const AVector2: TCL13BivecQuantity): TCL13MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13TrivecQuantity; const AVector2: TCL13TrivecQuantity): TCL13TrivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13QuadrivecQuantity; const AVector2: TCL13QuadrivecQuantity): TCL13TrivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13MultivecQuantity; const AVector2: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns @code(ARotor X ~ARotor), the rotation by the rotor @code(ARotor) (@code(ARotor ~ARotor = 1)). The result keeps the type of the value; the components of other grades, zero for a rotor, are dropped. The resulting dimension is the original dimension times the square of the dimension of the rotor. }
    function Rotate(const ARotor: TCL13MultivecQuantity): TCL13TrivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13VecQuantity): TCL13BivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13BivecQuantity): TCL13VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13TrivecQuantity): TRealQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13QuadrivecQuantity): TCL13VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13VecQuantity): TCL13QuadrivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13BivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13TrivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13QuadrivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
  end;
  {$ENDIF}

  { Record helper for @link(TCL13QuadrivecQuantity): the methods of @link(TCL13Quadrivector) on dimensioned values.
    Only available when @code(ADIMOFF) is not defined.
  }
  {$IFNDEF ADIMOFF}
  TCL13QuadrivecQuantityHelper = record helper for TCL13QuadrivecQuantity
    { Returns the components listed in @code(AComponents); the others are zero. The dimension is preserved. }
    function Extract(AComponents: TCL13QuadrivectorComponents): TCL13QuadrivecQuantity;

    { Returns the value as a multivector quantity. The dimension is preserved. }
    function ToMultivector: TCL13MultivecQuantity;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL13MultivecQuantity): boolean;

    { Returns @true if the two quantities are equal within the default tolerance. Both operands must have the same dimension. }
    function SameValue(const AValue: TCL13QuadrivecQuantity): boolean;

    { Returns the norm @code(Sqrt(Abs(SquaredNorm))). The dimension is preserved. }
    function Norm: TRealQuantity;

    { Returns the squared norm @code(<X ~X>₀). The resulting dimension is the square of the original dimension. }
    function SquaredNorm: TRealQuantity;

    { Returns the dual @code(X * I), with @code(I) the unit pseudoscalar. The dimension is preserved. }
    function Dual: TRealQuantity;

    { Returns the grade involution: every grade-@code(k) component is multiplied by @code((-1)^k). The dimension is preserved. }
    function Involute: TCL13QuadrivecQuantity;

    { Returns the reverse: every grade-@code(k) component is multiplied by @code((-1)^(k(k-1)/2)). The dimension is preserved. }
    function Reverse: TCL13QuadrivecQuantity;

    { Returns the Clifford conjugate, the reverse of the grade involution. The dimension is preserved. }
    function Conjugate: TCL13QuadrivecQuantity;

    { Returns the multiplicative inverse, @code(X⁻¹ * X = X * X⁻¹ = 1). The resulting dimension is the inverse of the original dimension. Raises a floating-point exception if the value is not invertible. }
    function Inverse: TCL13QuadrivecQuantity;

    { Returns the value divided by its norm. The dimension is preserved. }
    function Normalized: TCL13QuadrivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13VecQuantity): TCL13QuadrivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13BivecQuantity): TCL13QuadrivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13TrivecQuantity): TCL13QuadrivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;

    { Returns the projection on @code(AVector). The dimension is preserved. }
    function Projection(const AVector: TCL13MultivecQuantity): TCL13QuadrivecQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13VecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13BivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13TrivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13QuadrivecQuantity): TRealQuantity;

    { Returns the rejection from @code(AVector). The dimension is preserved. }
    function Rejection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13VecQuantity): TCL13QuadrivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13BivecQuantity): TCL13QuadrivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13TrivecQuantity): TCL13QuadrivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;

    { Returns the reflection @code(AVector * X * AVector⁻¹). The dimension is preserved. }
    function Reflection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13VecQuantity; const AVector2: TCL13VecQuantity): TCL13QuadrivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13BivecQuantity; const AVector2: TCL13BivecQuantity): TCL13QuadrivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13TrivecQuantity; const AVector2: TCL13TrivecQuantity): TCL13QuadrivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13QuadrivecQuantity; const AVector2: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;

    { Returns @code(AVector2 AVector1 X AVector1⁻¹ AVector2⁻¹): the rotation in the plane @code(AVector1 ∧ AVector2) by twice the angle between them. The dimension is preserved. }
    function Rotation(const AVector1: TCL13MultivecQuantity; const AVector2: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns @code(ARotor X ~ARotor), the rotation by the rotor @code(ARotor) (@code(ARotor ~ARotor = 1)). The result keeps the type of the value; the components of other grades, zero for a rotor, are dropped. The resulting dimension is the original dimension times the square of the dimension of the rotor. }
    function Rotate(const ARotor: TCL13MultivecQuantity): TCL13QuadrivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13VecQuantity): TCL13TrivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13BivecQuantity): TCL13BivecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13TrivecQuantity): TCL13VecQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13QuadrivecQuantity): TRealQuantity;

    { Returns the "fat" dot product. The resulting dimension is the product of the two dimensions. }
    function Dot(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13VecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13BivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13TrivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13QuadrivecQuantity): TRealQuantity;

    { Returns the exterior (wedge) product. The resulting dimension is the product of the two dimensions. }
    function Wedge(const AVector: TCL13MultivecQuantity): TCL13QuadrivecQuantity;
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

    { Returns the real vector quantity @code(AVector [unit]). }
    class operator *(const AVector: TRealVector; const ASelf: TUnit): TRealVectorQuantity; inline;

    { Returns the real vector quantity @code(AVector / [unit]), with inverted dimension. }
    class operator /(const AVector: TRealVector; const ASelf: TUnit): TRealVectorQuantity; inline;

    { Returns the complex vector quantity @code(AVector [unit]). }
    class operator *(const AVector: TComplexVector; const ASelf: TUnit): TComplexVectorQuantity; inline;

    { Returns the complex vector quantity @code(AVector / [unit]), with inverted dimension. }
    class operator /(const AVector: TComplexVector; const ASelf: TUnit): TComplexVectorQuantity; inline;

    { Returns the real matrix quantity @code(AMatrix [unit]). }
    class operator *(const AMatrix: TRealMatrix; const ASelf: TUnit): TRealMatrixQuantity; inline;

    { Returns the real matrix quantity @code(AMatrix / [unit]), with inverted dimension. }
    class operator /(const AMatrix: TRealMatrix; const ASelf: TUnit): TRealMatrixQuantity; inline;

    { Returns the complex matrix quantity @code(AMatrix [unit]). }
    class operator *(const AMatrix: TComplexMatrix; const ASelf: TUnit): TComplexMatrixQuantity; inline;

    { Returns the complex matrix quantity @code(AMatrix / [unit]), with inverted dimension. }
    class operator /(const AMatrix: TComplexMatrix; const ASelf: TUnit): TComplexMatrixQuantity; inline;

    { Returns the real quantity @code([unit] · AQuantity) (unit on the left). }
    class operator *(const ASelf: TUnit; const AQuantity: TRealQuantity): TRealQuantity; inline;

    { Returns the real quantity @code([unit] / AQuantity) (unit on the left). }
    class operator /(const ASelf: TUnit; const AQuantity: TRealQuantity): TRealQuantity; inline;

    { Returns the complex quantity @code([unit] · AQuantity) (unit on the left). }
    class operator *(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;

    { Returns the complex quantity @code([unit] / AQuantity) (unit on the left). }
    class operator /(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;

    { Returns the @code(Cl(2,0)) multivector quantity @code(AValue [unit]). }
    class operator *(const AValue: TCL2Multivector; const ASelf: TUnit): TCL2MultivecQuantity; inline;

    { Returns the @code(Cl(2,0)) multivector quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TCL2Multivector; const ASelf: TUnit): TCL2MultivecQuantity; inline;

    { Returns the @code(Cl(2,0)) vector quantity @code(AValue [unit]). }
    class operator *(const AValue: TCL2Vector; const ASelf: TUnit): TCL2VecQuantity; inline;

    { Returns the @code(Cl(2,0)) vector quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TCL2Vector; const ASelf: TUnit): TCL2VecQuantity; inline;

    { Returns the @code(Cl(2,0)) bivector quantity @code(AValue [unit]). }
    class operator *(const AValue: TCL2Bivector; const ASelf: TUnit): TCL2BivecQuantity; inline;

    { Returns the @code(Cl(2,0)) bivector quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TCL2Bivector; const ASelf: TUnit): TCL2BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity @code(AValue [unit]). }
    class operator *(const AValue: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity @code(AValue [unit]). }
    class operator *(const AValue: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity @code(AValue [unit]). }
    class operator *(const AValue: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity @code(AValue [unit]). }
    class operator *(const AValue: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) multivector quantity @code(AValue [unit]). }
    class operator *(const AValue: TCL13Multivector; const ASelf: TUnit): TCL13MultivecQuantity; inline;

    { Returns the @code(Cl(1,3)) multivector quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TCL13Multivector; const ASelf: TUnit): TCL13MultivecQuantity; inline;

    { Returns the @code(Cl(1,3)) vector quantity @code(AValue [unit]). }
    class operator *(const AValue: TCL13Vector; const ASelf: TUnit): TCL13VecQuantity; inline;

    { Returns the @code(Cl(1,3)) vector quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TCL13Vector; const ASelf: TUnit): TCL13VecQuantity; inline;

    { Returns the @code(Cl(1,3)) bivector quantity @code(AValue [unit]). }
    class operator *(const AValue: TCL13Bivector; const ASelf: TUnit): TCL13BivecQuantity; inline;

    { Returns the @code(Cl(1,3)) bivector quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TCL13Bivector; const ASelf: TUnit): TCL13BivecQuantity; inline;

    { Returns the @code(Cl(1,3)) trivector quantity @code(AValue [unit]). }
    class operator *(const AValue: TCL13Trivector; const ASelf: TUnit): TCL13TrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) trivector quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TCL13Trivector; const ASelf: TUnit): TCL13TrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) quadrivector quantity @code(AValue [unit]). }
    class operator *(const AValue: TCL13Quadrivector; const ASelf: TUnit): TCL13QuadrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) quadrivector quantity @code(AValue / [unit]), with inverted dimension. }
    class operator /(const AValue: TCL13Quadrivector; const ASelf: TUnit): TCL13QuadrivecQuantity; inline;

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

    { Returns the complex quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TComplexQuantity; const ASelf: TUnit): TComplexQuantity; inline;

    { Returns the real vector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TRealVectorQuantity; const ASelf: TUnit): TRealVectorQuantity; inline;

    { Returns the real vector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TRealVectorQuantity; const ASelf: TUnit): TRealVectorQuantity; inline;

    { Returns the complex vector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TComplexVectorQuantity; const ASelf: TUnit): TComplexVectorQuantity; inline;

    { Returns the complex vector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TComplexVectorQuantity; const ASelf: TUnit): TComplexVectorQuantity; inline;

    { Returns the real matrix quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TRealMatrixQuantity; const ASelf: TUnit): TRealMatrixQuantity; inline;

    { Returns the real matrix quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TRealMatrixQuantity; const ASelf: TUnit): TRealMatrixQuantity; inline;

    { Returns the complex matrix quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TComplexMatrixQuantity; const ASelf: TUnit): TComplexMatrixQuantity; inline;

    { Returns the complex matrix quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TComplexMatrixQuantity; const ASelf: TUnit): TComplexMatrixQuantity; inline;

    { Returns the @code(Cl(2,0)) multivector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL2MultivecQuantity; const ASelf: TUnit): TCL2MultivecQuantity; inline;

    { Returns the @code(Cl(2,0)) multivector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL2MultivecQuantity; const ASelf: TUnit): TCL2MultivecQuantity; inline;

    { Returns the @code(Cl(2,0)) vector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL2VecQuantity; const ASelf: TUnit): TCL2VecQuantity; inline;

    { Returns the @code(Cl(2,0)) vector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL2VecQuantity; const ASelf: TUnit): TCL2VecQuantity; inline;

    { Returns the @code(Cl(2,0)) bivector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL2BivecQuantity; const ASelf: TUnit): TCL2BivecQuantity; inline;

    { Returns the @code(Cl(2,0)) bivector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL2BivecQuantity; const ASelf: TUnit): TCL2BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) multivector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL13MultivecQuantity; const ASelf: TUnit): TCL13MultivecQuantity; inline;

    { Returns the @code(Cl(1,3)) multivector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL13MultivecQuantity; const ASelf: TUnit): TCL13MultivecQuantity; inline;

    { Returns the @code(Cl(1,3)) vector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL13VecQuantity; const ASelf: TUnit): TCL13VecQuantity; inline;

    { Returns the @code(Cl(1,3)) vector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL13VecQuantity; const ASelf: TUnit): TCL13VecQuantity; inline;

    { Returns the @code(Cl(1,3)) bivector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL13BivecQuantity; const ASelf: TUnit): TCL13BivecQuantity; inline;

    { Returns the @code(Cl(1,3)) bivector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL13BivecQuantity; const ASelf: TUnit): TCL13BivecQuantity; inline;

    { Returns the @code(Cl(1,3)) trivector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL13TrivecQuantity; const ASelf: TUnit): TCL13TrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) trivector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL13TrivecQuantity; const ASelf: TUnit): TCL13TrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) quadrivector quantity with dimension scaled by @code([unit]). }
    class operator *(const AQuantity: TCL13QuadrivecQuantity; const ASelf: TUnit): TCL13QuadrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) quadrivector quantity with dimension divided by @code([unit]). }
    class operator /(const AQuantity: TCL13QuadrivecQuantity; const ASelf: TUnit): TCL13QuadrivecQuantity; inline;

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

    { Returns the real vector quantity @code(AVector * FFactor [dim]). }
    class operator *(const AVector: TRealVector; const ASelf: TFactoredUnit): TRealVectorQuantity; inline;

    { Returns the real vector quantity @code(AVector / FFactor [dim⁻¹]). }
    class operator /(const AVector: TRealVector; const ASelf: TFactoredUnit): TRealVectorQuantity; inline;

    { Returns the complex vector quantity @code(AVector * FFactor [dim]). }
    class operator *(const AVector: TComplexVector; const ASelf: TFactoredUnit): TComplexVectorQuantity; inline;

    { Returns the complex vector quantity @code(AVector / FFactor [dim⁻¹]). }
    class operator /(const AVector: TComplexVector; const ASelf: TFactoredUnit): TComplexVectorQuantity; inline;

    { Returns the real matrix quantity @code(AMatrix * FFactor [dim]). }
    class operator *(const AMatrix: TRealMatrix; const ASelf: TFactoredUnit): TRealMatrixQuantity; inline;

    { Returns the real matrix quantity @code(AMatrix / FFactor [dim⁻¹]). }
    class operator /(const AMatrix: TRealMatrix; const ASelf: TFactoredUnit): TRealMatrixQuantity; inline;

    { Returns the complex matrix quantity @code(AMatrix * FFactor [dim]). }
    class operator *(const AMatrix: TComplexMatrix; const ASelf: TFactoredUnit): TComplexMatrixQuantity; inline;

    { Returns the complex matrix quantity @code(AMatrix / FFactor [dim⁻¹]). }
    class operator /(const AMatrix: TComplexMatrix; const ASelf: TFactoredUnit): TComplexMatrixQuantity; inline;

    { Returns the real quantity @code([unit] · AQuantity) (unit on the left). }
    class operator *(const ASelf: TFactoredUnit; const AQuantity: TRealQuantity): TRealQuantity; inline;

    { Returns the real quantity @code([unit] / AQuantity) (unit on the left). }
    class operator /(const ASelf: TFactoredUnit; const AQuantity: TRealQuantity): TRealQuantity; inline;

    { Returns the complex quantity @code([unit] · AQuantity) (unit on the left). }
    class operator *(const ASelf: TFactoredUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;

    { Returns the complex quantity @code([unit] / AQuantity) (unit on the left). }
    class operator /(const ASelf: TFactoredUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;

    { Returns the @code(Cl(2,0)) multivector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL2Multivector; const ASelf: TFactoredUnit): TCL2MultivecQuantity; inline;

    { Returns the @code(Cl(2,0)) multivector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL2Multivector; const ASelf: TFactoredUnit): TCL2MultivecQuantity; inline;

    { Returns the @code(Cl(2,0)) vector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL2Vector; const ASelf: TFactoredUnit): TCL2VecQuantity; inline;

    { Returns the @code(Cl(2,0)) vector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL2Vector; const ASelf: TFactoredUnit): TCL2VecQuantity; inline;

    { Returns the @code(Cl(2,0)) bivector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL2Bivector; const ASelf: TFactoredUnit): TCL2BivecQuantity; inline;

    { Returns the @code(Cl(2,0)) bivector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL2Bivector; const ASelf: TFactoredUnit): TCL2BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) multivector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL13Multivector; const ASelf: TFactoredUnit): TCL13MultivecQuantity; inline;

    { Returns the @code(Cl(1,3)) multivector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL13Multivector; const ASelf: TFactoredUnit): TCL13MultivecQuantity; inline;

    { Returns the @code(Cl(1,3)) vector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL13Vector; const ASelf: TFactoredUnit): TCL13VecQuantity; inline;

    { Returns the @code(Cl(1,3)) vector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL13Vector; const ASelf: TFactoredUnit): TCL13VecQuantity; inline;

    { Returns the @code(Cl(1,3)) bivector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL13Bivector; const ASelf: TFactoredUnit): TCL13BivecQuantity; inline;

    { Returns the @code(Cl(1,3)) bivector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL13Bivector; const ASelf: TFactoredUnit): TCL13BivecQuantity; inline;

    { Returns the @code(Cl(1,3)) trivector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL13Trivector; const ASelf: TFactoredUnit): TCL13TrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) trivector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL13Trivector; const ASelf: TFactoredUnit): TCL13TrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) quadrivector quantity @code(AQuantity * FFactor [dim]). }
    class operator *(const AQuantity: TCL13Quadrivector; const ASelf: TFactoredUnit): TCL13QuadrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) quadrivector quantity @code(AQuantity / FFactor [dim⁻¹]). }
    class operator /(const AQuantity: TCL13Quadrivector; const ASelf: TFactoredUnit): TCL13QuadrivecQuantity; inline;

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

    { Returns the real vector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TRealVectorQuantity; const ASelf: TFactoredUnit): TRealVectorQuantity; inline;

    { Returns the real vector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TRealVectorQuantity; const ASelf: TFactoredUnit): TRealVectorQuantity; inline;

    { Returns the complex vector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TComplexVectorQuantity; const ASelf: TFactoredUnit): TComplexVectorQuantity; inline;

    { Returns the complex vector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TComplexVectorQuantity; const ASelf: TFactoredUnit): TComplexVectorQuantity; inline;

    { Returns the real matrix quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TRealMatrixQuantity; const ASelf: TFactoredUnit): TRealMatrixQuantity; inline;

    { Returns the real matrix quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TRealMatrixQuantity; const ASelf: TFactoredUnit): TRealMatrixQuantity; inline;

    { Returns the complex matrix quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TComplexMatrixQuantity; const ASelf: TFactoredUnit): TComplexMatrixQuantity; inline;

    { Returns the complex matrix quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TComplexMatrixQuantity; const ASelf: TFactoredUnit): TComplexMatrixQuantity; inline;

    { Returns the @code(Cl(2,0)) multivector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL2MultivecQuantity; const ASelf: TFactoredUnit): TCL2MultivecQuantity; inline;

    { Returns the @code(Cl(2,0)) multivector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL2MultivecQuantity; const ASelf: TFactoredUnit): TCL2MultivecQuantity; inline;

    { Returns the @code(Cl(2,0)) vector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL2VecQuantity; const ASelf: TFactoredUnit): TCL2VecQuantity; inline;

    { Returns the @code(Cl(2,0)) vector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL2VecQuantity; const ASelf: TFactoredUnit): TCL2VecQuantity; inline;

    { Returns the @code(Cl(2,0)) bivector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL2BivecQuantity; const ASelf: TFactoredUnit): TCL2BivecQuantity; inline;

    { Returns the @code(Cl(2,0)) bivector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL2BivecQuantity; const ASelf: TFactoredUnit): TCL2BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;

    { Returns the @code(Cl(3,0)) multivector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) vector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) bivector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(3,0)) trivector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) multivector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL13MultivecQuantity; const ASelf: TFactoredUnit): TCL13MultivecQuantity; inline;

    { Returns the @code(Cl(1,3)) multivector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL13MultivecQuantity; const ASelf: TFactoredUnit): TCL13MultivecQuantity; inline;

    { Returns the @code(Cl(1,3)) vector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL13VecQuantity; const ASelf: TFactoredUnit): TCL13VecQuantity; inline;

    { Returns the @code(Cl(1,3)) vector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL13VecQuantity; const ASelf: TFactoredUnit): TCL13VecQuantity; inline;

    { Returns the @code(Cl(1,3)) bivector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL13BivecQuantity; const ASelf: TFactoredUnit): TCL13BivecQuantity; inline;

    { Returns the @code(Cl(1,3)) bivector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL13BivecQuantity; const ASelf: TFactoredUnit): TCL13BivecQuantity; inline;

    { Returns the @code(Cl(1,3)) trivector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL13TrivecQuantity; const ASelf: TFactoredUnit): TCL13TrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) trivector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL13TrivecQuantity; const ASelf: TFactoredUnit): TCL13TrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) quadrivector quantity rescaled by @code(FFactor). }
    class operator *(const AQuantity: TCL13QuadrivecQuantity; const ASelf: TFactoredUnit): TCL13QuadrivecQuantity; inline;

    { Returns the @code(Cl(1,3)) quadrivector quantity rescaled by @code(1/FFactor). }
    class operator /(const AQuantity: TCL13QuadrivecQuantity; const ASelf: TFactoredUnit): TCL13QuadrivecQuantity; inline;

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

    { Returns the real vector scaled for the given prefix.
      @param(AQuantity The dimensionless vector to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TRealVector; const APrefixes: TPrefixes): TRealVector;

    { Returns the complex vector scaled for the given prefix.
      @param(AQuantity The dimensionless complex vector to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TComplexVector; const APrefixes: TPrefixes): TComplexVector;

    { Returns the real matrix scaled for the given prefix.
      @param(AQuantity The dimensionless matrix to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TRealMatrix; const APrefixes: TPrefixes): TRealMatrix;

    { Returns the complex matrix scaled for the given prefix.
      @param(AQuantity The dimensionless complex matrix to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TComplexMatrix; const APrefixes: TPrefixes): TComplexMatrix;

    { Returns the @code(Cl(2,0)) multivector scaled for the given prefix.
      @param(AQuantity The dimensionless @link(TCL2Multivector) to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TCL2Multivector; const APrefixes: TPrefixes): TCL2Multivector;

    { Returns the @code(Cl(2,0)) vector scaled for the given prefix.
      @param(AQuantity The dimensionless @link(TCL2Vector) to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TCL2Vector; const APrefixes: TPrefixes): TCL2Vector;

    { Returns the @code(Cl(2,0)) bivector scaled for the given prefix.
      @param(AQuantity The dimensionless @link(TCL2Bivector) to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TCL2Bivector; const APrefixes: TPrefixes): TCL2Bivector;

    { Returns the @code(Cl(3,0)) multivector scaled for the given prefix.
      @param(AQuantity The dimensionless @link(TCL3Multivector) to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TCL3Multivector; const APrefixes: TPrefixes): TCL3Multivector;

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

    { Returns the @code(Cl(1,3)) multivector scaled for the given prefix.
      @param(AQuantity The dimensionless @link(TCL13Multivector) to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TCL13Multivector; const APrefixes: TPrefixes): TCL13Multivector;

    { Returns the @code(Cl(1,3)) vector scaled for the given prefix.
      @param(AQuantity The dimensionless @link(TCL13Vector) to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TCL13Vector; const APrefixes: TPrefixes): TCL13Vector;

    { Returns the @code(Cl(1,3)) bivector scaled for the given prefix.
      @param(AQuantity The dimensionless @link(TCL13Bivector) to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TCL13Bivector; const APrefixes: TPrefixes): TCL13Bivector;

    { Returns the @code(Cl(1,3)) trivector scaled for the given prefix.
      @param(AQuantity The dimensionless @link(TCL13Trivector) to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TCL13Trivector; const APrefixes: TPrefixes): TCL13Trivector;

    { Returns the @code(Cl(1,3)) quadrivector scaled for the given prefix.
      @param(AQuantity The dimensionless @link(TCL13Quadrivector) to scale.)
      @param(APrefixes  The SI prefixes defining the scaling factor.)
    }
    function GetValue(const AQuantity: TCL13Quadrivector; const APrefixes: TPrefixes): TCL13Quadrivector;

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

    { Returns the dimensionless @link(TRealVector) of the real vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TRealVectorQuantity): TRealVector;

    { Returns the dimensionless @link(TRealVector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): TRealVector;

    { Returns a compact string representation of the real vector quantity in this unit. }
    function ToString(const AQuantity: TRealVectorQuantity): string;

    { Returns a compact string representation of the real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real vector quantity in this unit. }
    function ToVerboseString(const AQuantity: TRealVectorQuantity): string;

    { Returns a verbose string representation of the real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the real vector quantity with controlled precision.
      @param(AQuantity   The real vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TRealVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real vector quantity with controlled precision.
      @param(AQuantity   The real vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TRealVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TComplexVector) of the complex vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TComplexVectorQuantity): TComplexVector;

    { Returns the dimensionless @link(TComplexVector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): TComplexVector;

    { Returns a compact string representation of the complex vector quantity in this unit. }
    function ToString(const AQuantity: TComplexVectorQuantity): string;

    { Returns a compact string representation of the complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the complex vector quantity in this unit. }
    function ToVerboseString(const AQuantity: TComplexVectorQuantity): string;

    { Returns a verbose string representation of the complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the complex vector quantity with controlled precision.
      @param(AQuantity   The complex vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TComplexVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the complex vector quantity with controlled precision.
      @param(AQuantity   The complex vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TComplexVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TRealMatrix) of the real matrix quantity expressed in this unit. }
    function ToMatrix(const AQuantity: TRealMatrixQuantity): TRealMatrix;

    { Returns the dimensionless @link(TRealMatrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): TRealMatrix;

    { Returns a compact string representation of the real matrix quantity in this unit. }
    function ToString(const AQuantity: TRealMatrixQuantity): string;

    { Returns a compact string representation of the real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real matrix quantity in this unit. }
    function ToVerboseString(const AQuantity: TRealMatrixQuantity): string;

    { Returns a verbose string representation of the real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the real matrix quantity with controlled precision.
      @param(AQuantity   The real matrix quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TRealMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real matrix quantity with controlled precision.
      @param(AQuantity   The real matrix quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TRealMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TComplexMatrix) of the complex matrix quantity expressed in this unit. }
    function ToMatrix(const AQuantity: TComplexMatrixQuantity): TComplexMatrix;

    { Returns the dimensionless @link(TComplexMatrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): TComplexMatrix;

    { Returns a compact string representation of the complex matrix quantity in this unit. }
    function ToString(const AQuantity: TComplexMatrixQuantity): string;

    { Returns a compact string representation of the complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the complex matrix quantity in this unit. }
    function ToVerboseString(const AQuantity: TComplexMatrixQuantity): string;

    { Returns a verbose string representation of the complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the complex matrix quantity with controlled precision.
      @param(AQuantity   The complex matrix quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TComplexMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the complex matrix quantity with controlled precision.
      @param(AQuantity   The complex matrix quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TComplexMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(2,0)) multivector quantity in this unit. }
    function ToString(const AQuantity: TCL2MultivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(2,0)) multivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL2MultivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) multivector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL2MultivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) multivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL2MultivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL2Multivector) of the @code(Cl(2,0)) multivector quantity expressed in this unit. }
    function ToMultivector(const AQuantity: TCL2MultivecQuantity): TCL2Multivector;

    { Returns the dimensionless @link(TCL2Multivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMultivector(const AQuantity: TCL2MultivecQuantity; const APrefixes: TPrefixes): TCL2Multivector;

    { Returns a compact string representation of the @code(Cl(2,0)) multivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(2,0)) multivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL2MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) multivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(2,0)) multivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL2MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(2,0)) vector quantity in this unit. }
    function ToString(const AQuantity: TCL2VecQuantity): string;

    { Returns a compact string representation of the @code(Cl(2,0)) vector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL2VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) vector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL2VecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) vector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL2VecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL2Vector) of the @code(Cl(2,0)) vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TCL2VecQuantity): TCL2Vector;

    { Returns the dimensionless @link(TCL2Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TCL2VecQuantity; const APrefixes: TPrefixes): TCL2Vector;

    { Returns a compact string representation of the @code(Cl(2,0)) vector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(2,0)) vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL2VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) vector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(2,0)) vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL2VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(2,0)) bivector quantity in this unit. }
    function ToString(const AQuantity: TCL2BivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(2,0)) bivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL2BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) bivector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL2BivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) bivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL2BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL2Bivector) of the @code(Cl(2,0)) bivector quantity expressed in this unit. }
    function ToBivector(const AQuantity: TCL2BivecQuantity): TCL2Bivector;

    { Returns the dimensionless @link(TCL2Bivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToBivector(const AQuantity: TCL2BivecQuantity; const APrefixes: TPrefixes): TCL2Bivector;

    { Returns a compact string representation of the @code(Cl(2,0)) bivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(2,0)) bivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL2BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) bivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(2,0)) bivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL2BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) multivector quantity in this unit. }
    function ToString(const AQuantity: TCL3MultivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) multivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) multivector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) multivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL3Multivector) of the @code(Cl(3,0)) multivector quantity expressed in this unit. }
    function ToMultivector(const AQuantity: TCL3MultivecQuantity): TCL3Multivector;

    { Returns the dimensionless @link(TCL3Multivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMultivector(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): TCL3Multivector;

    { Returns a compact string representation of the @code(Cl(3,0)) multivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) multivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL3MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) multivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) multivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) vector quantity in this unit. }
    function ToString(const AQuantity: TCL3VecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) vector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) vector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL3VecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) vector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL3Vector) of the @code(Cl(3,0)) vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TCL3VecQuantity): TCL3Vector;

    { Returns the dimensionless @link(TCL3Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): TCL3Vector;

    { Returns a compact string representation of the @code(Cl(3,0)) vector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL3VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) vector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL3VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) bivector quantity in this unit. }
    function ToString(const AQuantity: TCL3BivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) bivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) bivector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL3BivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) bivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL3Bivector) of the @code(Cl(3,0)) bivector quantity expressed in this unit. }
    function ToBivector(const AQuantity: TCL3BivecQuantity): TCL3Bivector;

    { Returns the dimensionless @link(TCL3Bivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToBivector(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): TCL3Bivector;

    { Returns a compact string representation of the @code(Cl(3,0)) bivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) bivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL3BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) bivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) bivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL3BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) trivector quantity in this unit. }
    function ToString(const AQuantity: TCL3TrivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) trivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) trivector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) trivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL3Trivector) of the @code(Cl(3,0)) trivector quantity expressed in this unit. }
    function ToTrivector(const AQuantity: TCL3TrivecQuantity): TCL3Trivector;

    { Returns the dimensionless @link(TCL3Trivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToTrivector(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): TCL3Trivector;

    { Returns a compact string representation of the @code(Cl(3,0)) trivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) trivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL3TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) trivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) trivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(1,3)) multivector quantity in this unit. }
    function ToString(const AQuantity: TCL13MultivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(1,3)) multivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL13MultivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) multivector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL13MultivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) multivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL13MultivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL13Multivector) of the @code(Cl(1,3)) multivector quantity expressed in this unit. }
    function ToMultivector(const AQuantity: TCL13MultivecQuantity): TCL13Multivector;

    { Returns the dimensionless @link(TCL13Multivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMultivector(const AQuantity: TCL13MultivecQuantity; const APrefixes: TPrefixes): TCL13Multivector;

    { Returns a compact string representation of the @code(Cl(1,3)) multivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) multivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL13MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) multivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) multivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL13MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(1,3)) vector quantity in this unit. }
    function ToString(const AQuantity: TCL13VecQuantity): string;

    { Returns a compact string representation of the @code(Cl(1,3)) vector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL13VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) vector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL13VecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) vector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL13VecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL13Vector) of the @code(Cl(1,3)) vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TCL13VecQuantity): TCL13Vector;

    { Returns the dimensionless @link(TCL13Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TCL13VecQuantity; const APrefixes: TPrefixes): TCL13Vector;

    { Returns a compact string representation of the @code(Cl(1,3)) vector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL13VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) vector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL13VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(1,3)) bivector quantity in this unit. }
    function ToString(const AQuantity: TCL13BivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(1,3)) bivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL13BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) bivector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL13BivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) bivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL13BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL13Bivector) of the @code(Cl(1,3)) bivector quantity expressed in this unit. }
    function ToBivector(const AQuantity: TCL13BivecQuantity): TCL13Bivector;

    { Returns the dimensionless @link(TCL13Bivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToBivector(const AQuantity: TCL13BivecQuantity; const APrefixes: TPrefixes): TCL13Bivector;

    { Returns a compact string representation of the @code(Cl(1,3)) bivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) bivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL13BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) bivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) bivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL13BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(1,3)) trivector quantity in this unit. }
    function ToString(const AQuantity: TCL13TrivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(1,3)) trivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL13TrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) trivector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL13TrivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) trivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL13TrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL13Trivector) of the @code(Cl(1,3)) trivector quantity expressed in this unit. }
    function ToTrivector(const AQuantity: TCL13TrivecQuantity): TCL13Trivector;

    { Returns the dimensionless @link(TCL13Trivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToTrivector(const AQuantity: TCL13TrivecQuantity; const APrefixes: TPrefixes): TCL13Trivector;

    { Returns a compact string representation of the @code(Cl(1,3)) trivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) trivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL13TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) trivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) trivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL13TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(1,3)) quadrivector quantity in this unit. }
    function ToString(const AQuantity: TCL13QuadrivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(1,3)) quadrivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL13QuadrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) quadrivector quantity in this unit. }
    function ToVerboseString(const AQuantity: TCL13QuadrivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) quadrivector quantity in this unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL13QuadrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL13Quadrivector) of the @code(Cl(1,3)) quadrivector quantity expressed in this unit. }
    function ToQuadrivector(const AQuantity: TCL13QuadrivecQuantity): TCL13Quadrivector;

    { Returns the dimensionless @link(TCL13Quadrivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToQuadrivector(const AQuantity: TCL13QuadrivecQuantity; const APrefixes: TPrefixes): TCL13Quadrivector;

    { Returns a compact string representation of the @code(Cl(1,3)) quadrivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) quadrivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL13QuadrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) quadrivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) quadrivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL13QuadrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

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

    { Returns the real vector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless vector to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TRealVector; const APrefixes: TPrefixes): TRealVector;

    { Returns the complex vector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless complex vector to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TComplexVector; const APrefixes: TPrefixes): TComplexVector;

    { Returns the real matrix scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless matrix to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TRealMatrix; const APrefixes: TPrefixes): TRealMatrix;

    { Returns the complex matrix scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless complex matrix to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TComplexMatrix; const APrefixes: TPrefixes): TComplexMatrix;

    { Returns the @code(Cl(2,0)) multivector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless @link(TCL2Multivector) to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TCL2Multivector; const APrefixes: TPrefixes): TCL2Multivector;

    { Returns the @code(Cl(2,0)) vector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless @link(TCL2Vector) to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TCL2Vector; const APrefixes: TPrefixes): TCL2Vector;

    { Returns the @code(Cl(2,0)) bivector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless @link(TCL2Bivector) to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TCL2Bivector; const APrefixes: TPrefixes): TCL2Bivector;

    { Returns the @code(Cl(3,0)) multivector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless @link(TCL3Multivector) to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TCL3Multivector; const APrefixes: TPrefixes): TCL3Multivector;

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

    { Returns the @code(Cl(1,3)) multivector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless @link(TCL13Multivector) to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TCL13Multivector; const APrefixes: TPrefixes): TCL13Multivector;

    { Returns the @code(Cl(1,3)) vector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless @link(TCL13Vector) to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TCL13Vector; const APrefixes: TPrefixes): TCL13Vector;

    { Returns the @code(Cl(1,3)) bivector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless @link(TCL13Bivector) to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TCL13Bivector; const APrefixes: TPrefixes): TCL13Bivector;

    { Returns the @code(Cl(1,3)) trivector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless @link(TCL13Trivector) to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TCL13Trivector; const APrefixes: TPrefixes): TCL13Trivector;

    { Returns the @code(Cl(1,3)) quadrivector scaled by @code(FFactor) and the given prefix.
      @param(AQuantity The dimensionless @link(TCL13Quadrivector) to scale.)
      @param(APrefixes  The SI prefixes defining additional scaling.)
    }
    function GetValue(const AQuantity: TCL13Quadrivector; const APrefixes: TPrefixes): TCL13Quadrivector;

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

    { Returns the dimensionless @link(TRealVector) of the real vector quantity expressed in this factored unit. }
    function ToVector(const AQuantity: TRealVectorQuantity): TRealVector;

    { Returns the dimensionless @link(TRealVector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): TRealVector;

    { Returns a compact string representation of the real vector quantity in this factored unit. }
    function ToString(const AQuantity: TRealVectorQuantity): string;

    { Returns a compact string representation of the real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real vector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TRealVectorQuantity): string;

    { Returns a verbose string representation of the real vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TRealVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the real vector quantity with controlled precision.
      @param(AQuantity   The real vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TRealVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real vector quantity with controlled precision.
      @param(AQuantity   The real vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TRealVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TComplexVector) of the complex vector quantity expressed in this factored unit. }
    function ToVector(const AQuantity: TComplexVectorQuantity): TComplexVector;

    { Returns the dimensionless @link(TComplexVector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): TComplexVector;

    { Returns a compact string representation of the complex vector quantity in this factored unit. }
    function ToString(const AQuantity: TComplexVectorQuantity): string;

    { Returns a compact string representation of the complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the complex vector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TComplexVectorQuantity): string;

    { Returns a verbose string representation of the complex vector quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TComplexVectorQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the complex vector quantity with controlled precision.
      @param(AQuantity   The complex vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TComplexVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the complex vector quantity with controlled precision.
      @param(AQuantity   The complex vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TComplexVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TRealMatrix) of the real matrix quantity expressed in this factored unit. }
    function ToMatrix(const AQuantity: TRealMatrixQuantity): TRealMatrix;

    { Returns the dimensionless @link(TRealMatrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): TRealMatrix;

    { Returns a compact string representation of the real matrix quantity in this factored unit. }
    function ToString(const AQuantity: TRealMatrixQuantity): string;

    { Returns a compact string representation of the real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real matrix quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TRealMatrixQuantity): string;

    { Returns a verbose string representation of the real matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TRealMatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the real matrix quantity with controlled precision.
      @param(AQuantity   The real matrix quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TRealMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the real matrix quantity with controlled precision.
      @param(AQuantity   The real matrix quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TRealMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TComplexMatrix) of the complex matrix quantity expressed in this factored unit. }
    function ToMatrix(const AQuantity: TComplexMatrixQuantity): TComplexMatrix;

    { Returns the dimensionless @link(TComplexMatrix) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMatrix(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): TComplexMatrix;

    { Returns a compact string representation of the complex matrix quantity in this factored unit. }
    function ToString(const AQuantity: TComplexMatrixQuantity): string;

    { Returns a compact string representation of the complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the complex matrix quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TComplexMatrixQuantity): string;

    { Returns a verbose string representation of the complex matrix quantity with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TComplexMatrixQuantity; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the complex matrix quantity with controlled precision.
      @param(AQuantity   The complex matrix quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TComplexMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the complex matrix quantity with controlled precision.
      @param(AQuantity   The complex matrix quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TComplexMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(2,0)) multivector quantity in this factored unit. }
    function ToString(const AQuantity: TCL2MultivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(2,0)) multivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL2MultivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) multivector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL2MultivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) multivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL2MultivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL2Multivector) of the @code(Cl(2,0)) multivector quantity expressed in this unit. }
    function ToMultivector(const AQuantity: TCL2MultivecQuantity): TCL2Multivector;

    { Returns the dimensionless @link(TCL2Multivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMultivector(const AQuantity: TCL2MultivecQuantity; const APrefixes: TPrefixes): TCL2Multivector;

    { Returns a compact string representation of the @code(Cl(2,0)) multivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(2,0)) multivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL2MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) multivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(2,0)) multivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL2MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(2,0)) vector quantity in this factored unit. }
    function ToString(const AQuantity: TCL2VecQuantity): string;

    { Returns a compact string representation of the @code(Cl(2,0)) vector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL2VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) vector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL2VecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) vector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL2VecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL2Vector) of the @code(Cl(2,0)) vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TCL2VecQuantity): TCL2Vector;

    { Returns the dimensionless @link(TCL2Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TCL2VecQuantity; const APrefixes: TPrefixes): TCL2Vector;

    { Returns a compact string representation of the @code(Cl(2,0)) vector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(2,0)) vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL2VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) vector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(2,0)) vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL2VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(2,0)) bivector quantity in this factored unit. }
    function ToString(const AQuantity: TCL2BivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(2,0)) bivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL2BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) bivector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL2BivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) bivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL2BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL2Bivector) of the @code(Cl(2,0)) bivector quantity expressed in this unit. }
    function ToBivector(const AQuantity: TCL2BivecQuantity): TCL2Bivector;

    { Returns the dimensionless @link(TCL2Bivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToBivector(const AQuantity: TCL2BivecQuantity; const APrefixes: TPrefixes): TCL2Bivector;

    { Returns a compact string representation of the @code(Cl(2,0)) bivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(2,0)) bivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL2BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(2,0)) bivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(2,0)) bivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL2BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) multivector quantity in this factored unit. }
    function ToString(const AQuantity: TCL3MultivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) multivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) multivector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) multivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL3Multivector) of the @code(Cl(3,0)) multivector quantity expressed in this unit. }
    function ToMultivector(const AQuantity: TCL3MultivecQuantity): TCL3Multivector;

    { Returns the dimensionless @link(TCL3Multivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMultivector(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): TCL3Multivector;

    { Returns a compact string representation of the @code(Cl(3,0)) multivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) multivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL3MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) multivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) multivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL3MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) vector quantity in this factored unit. }
    function ToString(const AQuantity: TCL3VecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) vector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) vector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL3VecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) vector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL3Vector) of the @code(Cl(3,0)) vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TCL3VecQuantity): TCL3Vector;

    { Returns the dimensionless @link(TCL3Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): TCL3Vector;

    { Returns a compact string representation of the @code(Cl(3,0)) vector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL3VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) vector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL3VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) bivector quantity in this factored unit. }
    function ToString(const AQuantity: TCL3BivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) bivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) bivector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL3BivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) bivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL3Bivector) of the @code(Cl(3,0)) bivector quantity expressed in this unit. }
    function ToBivector(const AQuantity: TCL3BivecQuantity): TCL3Bivector;

    { Returns the dimensionless @link(TCL3Bivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToBivector(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): TCL3Bivector;

    { Returns a compact string representation of the @code(Cl(3,0)) bivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) bivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL3BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) bivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) bivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL3BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(3,0)) trivector quantity in this factored unit. }
    function ToString(const AQuantity: TCL3TrivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(3,0)) trivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) trivector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) trivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL3Trivector) of the @code(Cl(3,0)) trivector quantity expressed in this unit. }
    function ToTrivector(const AQuantity: TCL3TrivecQuantity): TCL3Trivector;

    { Returns the dimensionless @link(TCL3Trivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToTrivector(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): TCL3Trivector;

    { Returns a compact string representation of the @code(Cl(3,0)) trivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) trivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL3TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(3,0)) trivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(3,0)) trivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL3TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(1,3)) multivector quantity in this factored unit. }
    function ToString(const AQuantity: TCL13MultivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(1,3)) multivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL13MultivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) multivector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL13MultivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) multivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL13MultivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL13Multivector) of the @code(Cl(1,3)) multivector quantity expressed in this unit. }
    function ToMultivector(const AQuantity: TCL13MultivecQuantity): TCL13Multivector;

    { Returns the dimensionless @link(TCL13Multivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToMultivector(const AQuantity: TCL13MultivecQuantity; const APrefixes: TPrefixes): TCL13Multivector;

    { Returns a compact string representation of the @code(Cl(1,3)) multivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) multivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL13MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) multivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) multivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL13MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(1,3)) vector quantity in this factored unit. }
    function ToString(const AQuantity: TCL13VecQuantity): string;

    { Returns a compact string representation of the @code(Cl(1,3)) vector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL13VecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) vector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL13VecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) vector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL13VecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL13Vector) of the @code(Cl(1,3)) vector quantity expressed in this unit. }
    function ToVector(const AQuantity: TCL13VecQuantity): TCL13Vector;

    { Returns the dimensionless @link(TCL13Vector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVector(const AQuantity: TCL13VecQuantity; const APrefixes: TPrefixes): TCL13Vector;

    { Returns a compact string representation of the @code(Cl(1,3)) vector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL13VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) vector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) vector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL13VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(1,3)) bivector quantity in this factored unit. }
    function ToString(const AQuantity: TCL13BivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(1,3)) bivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL13BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) bivector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL13BivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) bivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL13BivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL13Bivector) of the @code(Cl(1,3)) bivector quantity expressed in this unit. }
    function ToBivector(const AQuantity: TCL13BivecQuantity): TCL13Bivector;

    { Returns the dimensionless @link(TCL13Bivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToBivector(const AQuantity: TCL13BivecQuantity; const APrefixes: TPrefixes): TCL13Bivector;

    { Returns a compact string representation of the @code(Cl(1,3)) bivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) bivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL13BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) bivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) bivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL13BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(1,3)) trivector quantity in this factored unit. }
    function ToString(const AQuantity: TCL13TrivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(1,3)) trivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL13TrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) trivector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL13TrivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) trivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL13TrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL13Trivector) of the @code(Cl(1,3)) trivector quantity expressed in this unit. }
    function ToTrivector(const AQuantity: TCL13TrivecQuantity): TCL13Trivector;

    { Returns the dimensionless @link(TCL13Trivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToTrivector(const AQuantity: TCL13TrivecQuantity; const APrefixes: TPrefixes): TCL13Trivector;

    { Returns a compact string representation of the @code(Cl(1,3)) trivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) trivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL13TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) trivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) trivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL13TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a compact string representation of the @code(Cl(1,3)) quadrivector quantity in this factored unit. }
    function ToString(const AQuantity: TCL13QuadrivecQuantity): string;

    { Returns a compact string representation of the @code(Cl(1,3)) quadrivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToString(const AQuantity: TCL13QuadrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) quadrivector quantity in this factored unit. }
    function ToVerboseString(const AQuantity: TCL13QuadrivecQuantity): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) quadrivector quantity in this factored unit with the given prefix. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToVerboseString(const AQuantity: TCL13QuadrivecQuantity; const APrefixes: TPrefixes): string;

    { Returns the dimensionless @link(TCL13Quadrivector) of the @code(Cl(1,3)) quadrivector quantity expressed in this unit. }
    function ToQuadrivector(const AQuantity: TCL13QuadrivecQuantity): TCL13Quadrivector;

    { Returns the dimensionless @link(TCL13Quadrivector) with the given prefix applied. @param(APrefixes The SI prefixes defining the output scaling.) }
    function ToQuadrivector(const AQuantity: TCL13QuadrivecQuantity; const APrefixes: TPrefixes): TCL13Quadrivector;

    { Returns a compact string representation of the @code(Cl(1,3)) quadrivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) quadrivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToString(const AQuantity: TCL13QuadrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

    { Returns a verbose string representation of the @code(Cl(1,3)) quadrivector quantity with controlled precision.
      @param(AQuantity   The @code(Cl(1,3)) quadrivector quantity to format.)
      @param(APrecision  Number of significant digits.)
      @param(ADigits     Minimum number of digits in the output.)
      @param(APrefixes   The SI prefixes defining the output scaling.)
    }
    function ToVerboseString(const AQuantity: TCL13QuadrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;

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

    { Returns a compact string representation of the temperature quantity in degrees Fahrenheit.
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
    FDim        : (FExponents: (0, 0, 0, 0, 0, 0, 0, 0));
    FSymbol     : rsScalarSymbol;
    FName       : rsScalarName;
    FPluralName : rsScalarPluralName;
    FPrefixes   : ();
    FExponents  : ());

{#UNITSOFMEASUREMENT}

  {$IFNDEF ADIMOFF}
  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL2Multivector; const ARight: TRealQuantity): TCL2MultivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL2Multivector): TCL2MultivecQuantity;

  { Returns the quotient of a dimensionless value by a real quantity. The dimension is the inverse of the one of the real quantity. }
  operator /(const ALeft: TCL2Multivector; const ARight: TRealQuantity): TCL2MultivecQuantity;

  { Returns the quotient of a real quantity by a dimensionless value. The dimension is the one of the real quantity. }
  operator /(const ALeft: TRealQuantity; const ARight: TCL2Multivector): TCL2MultivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL2Vector; const ARight: TRealQuantity): TCL2VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL2Vector): TCL2VecQuantity;

  { Returns the quotient of a dimensionless value by a real quantity. The dimension is the inverse of the one of the real quantity. }
  operator /(const ALeft: TCL2Vector; const ARight: TRealQuantity): TCL2VecQuantity;

  { Returns the quotient of a real quantity by a dimensionless value. The dimension is the one of the real quantity. }
  operator /(const ALeft: TRealQuantity; const ARight: TCL2Vector): TCL2VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL2Bivector; const ARight: TRealQuantity): TCL2BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL2Bivector): TCL2BivecQuantity;

  { Returns the quotient of a dimensionless value by a real quantity. The dimension is the inverse of the one of the real quantity. }
  operator /(const ALeft: TCL2Bivector; const ARight: TRealQuantity): TCL2BivecQuantity;

  { Returns the quotient of a real quantity by a dimensionless value. The dimension is the one of the real quantity. }
  operator /(const ALeft: TRealQuantity; const ARight: TCL2Bivector): TCL2BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL2Versor1): TCL2VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL2Versor1; const ARight: TRealQuantity): TCL2VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL2Versor2): TCL2VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL2Versor2; const ARight: TRealQuantity): TCL2VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL2Biversor12): TCL2BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL2Biversor12; const ARight: TRealQuantity): TCL2BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL3Multivector; const ARight: TRealQuantity): TCL3MultivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL3Multivector): TCL3MultivecQuantity;

  { Returns the quotient of a dimensionless value by a real quantity. The dimension is the inverse of the one of the real quantity. }
  operator /(const ALeft: TCL3Multivector; const ARight: TRealQuantity): TCL3MultivecQuantity;

  { Returns the quotient of a real quantity by a dimensionless value. The dimension is the one of the real quantity. }
  operator /(const ALeft: TRealQuantity; const ARight: TCL3Multivector): TCL3MultivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL3Vector; const ARight: TRealQuantity): TCL3VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL3Vector): TCL3VecQuantity;

  { Returns the quotient of a dimensionless value by a real quantity. The dimension is the inverse of the one of the real quantity. }
  operator /(const ALeft: TCL3Vector; const ARight: TRealQuantity): TCL3VecQuantity;

  { Returns the quotient of a real quantity by a dimensionless value. The dimension is the one of the real quantity. }
  operator /(const ALeft: TRealQuantity; const ARight: TCL3Vector): TCL3VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL3Bivector; const ARight: TRealQuantity): TCL3BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL3Bivector): TCL3BivecQuantity;

  { Returns the quotient of a dimensionless value by a real quantity. The dimension is the inverse of the one of the real quantity. }
  operator /(const ALeft: TCL3Bivector; const ARight: TRealQuantity): TCL3BivecQuantity;

  { Returns the quotient of a real quantity by a dimensionless value. The dimension is the one of the real quantity. }
  operator /(const ALeft: TRealQuantity; const ARight: TCL3Bivector): TCL3BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL3Trivector; const ARight: TRealQuantity): TCL3TrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL3Trivector): TCL3TrivecQuantity;

  { Returns the quotient of a dimensionless value by a real quantity. The dimension is the inverse of the one of the real quantity. }
  operator /(const ALeft: TCL3Trivector; const ARight: TRealQuantity): TCL3TrivecQuantity;

  { Returns the quotient of a real quantity by a dimensionless value. The dimension is the one of the real quantity. }
  operator /(const ALeft: TRealQuantity; const ARight: TCL3Trivector): TCL3TrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL3Versor1): TCL3VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL3Versor1; const ARight: TRealQuantity): TCL3VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL3Versor2): TCL3VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL3Versor2; const ARight: TRealQuantity): TCL3VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL3Versor3): TCL3VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL3Versor3; const ARight: TRealQuantity): TCL3VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL3Biversor12): TCL3BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL3Biversor12; const ARight: TRealQuantity): TCL3BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL3Biversor13): TCL3BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL3Biversor13; const ARight: TRealQuantity): TCL3BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL3Biversor23): TCL3BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL3Biversor23; const ARight: TRealQuantity): TCL3BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL3Triversor123): TCL3TrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL3Triversor123; const ARight: TRealQuantity): TCL3TrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Multivector; const ARight: TRealQuantity): TCL13MultivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Multivector): TCL13MultivecQuantity;

  { Returns the quotient of a dimensionless value by a real quantity. The dimension is the inverse of the one of the real quantity. }
  operator /(const ALeft: TCL13Multivector; const ARight: TRealQuantity): TCL13MultivecQuantity;

  { Returns the quotient of a real quantity by a dimensionless value. The dimension is the one of the real quantity. }
  operator /(const ALeft: TRealQuantity; const ARight: TCL13Multivector): TCL13MultivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Vector; const ARight: TRealQuantity): TCL13VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Vector): TCL13VecQuantity;

  { Returns the quotient of a dimensionless value by a real quantity. The dimension is the inverse of the one of the real quantity. }
  operator /(const ALeft: TCL13Vector; const ARight: TRealQuantity): TCL13VecQuantity;

  { Returns the quotient of a real quantity by a dimensionless value. The dimension is the one of the real quantity. }
  operator /(const ALeft: TRealQuantity; const ARight: TCL13Vector): TCL13VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Bivector; const ARight: TRealQuantity): TCL13BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Bivector): TCL13BivecQuantity;

  { Returns the quotient of a dimensionless value by a real quantity. The dimension is the inverse of the one of the real quantity. }
  operator /(const ALeft: TCL13Bivector; const ARight: TRealQuantity): TCL13BivecQuantity;

  { Returns the quotient of a real quantity by a dimensionless value. The dimension is the one of the real quantity. }
  operator /(const ALeft: TRealQuantity; const ARight: TCL13Bivector): TCL13BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Trivector; const ARight: TRealQuantity): TCL13TrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Trivector): TCL13TrivecQuantity;

  { Returns the quotient of a dimensionless value by a real quantity. The dimension is the inverse of the one of the real quantity. }
  operator /(const ALeft: TCL13Trivector; const ARight: TRealQuantity): TCL13TrivecQuantity;

  { Returns the quotient of a real quantity by a dimensionless value. The dimension is the one of the real quantity. }
  operator /(const ALeft: TRealQuantity; const ARight: TCL13Trivector): TCL13TrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Quadrivector; const ARight: TRealQuantity): TCL13QuadrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Quadrivector): TCL13QuadrivecQuantity;

  { Returns the quotient of a dimensionless value by a real quantity. The dimension is the inverse of the one of the real quantity. }
  operator /(const ALeft: TCL13Quadrivector; const ARight: TRealQuantity): TCL13QuadrivecQuantity;

  { Returns the quotient of a real quantity by a dimensionless value. The dimension is the one of the real quantity. }
  operator /(const ALeft: TRealQuantity; const ARight: TCL13Quadrivector): TCL13QuadrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Versor0): TCL13VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Versor0; const ARight: TRealQuantity): TCL13VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Versor1): TCL13VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Versor1; const ARight: TRealQuantity): TCL13VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Versor2): TCL13VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Versor2; const ARight: TRealQuantity): TCL13VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Versor3): TCL13VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Versor3; const ARight: TRealQuantity): TCL13VecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Biversor01): TCL13BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Biversor01; const ARight: TRealQuantity): TCL13BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Biversor02): TCL13BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Biversor02; const ARight: TRealQuantity): TCL13BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Biversor03): TCL13BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Biversor03; const ARight: TRealQuantity): TCL13BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Biversor12): TCL13BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Biversor12; const ARight: TRealQuantity): TCL13BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Biversor13): TCL13BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Biversor13; const ARight: TRealQuantity): TCL13BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Biversor23): TCL13BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Biversor23; const ARight: TRealQuantity): TCL13BivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Triversor012): TCL13TrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Triversor012; const ARight: TRealQuantity): TCL13TrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Triversor013): TCL13TrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Triversor013; const ARight: TRealQuantity): TCL13TrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Triversor023): TCL13TrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Triversor023; const ARight: TRealQuantity): TCL13TrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Triversor123): TCL13TrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Triversor123; const ARight: TRealQuantity): TCL13TrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TRealQuantity; const ARight: TCL13Quadriversor0123): TCL13QuadrivecQuantity;

  { Returns the product of a real quantity and a dimensionless value. The dimension is the one of the real quantity. }
  operator *(const ALeft: TCL13Quadriversor0123; const ARight: TRealQuantity): TCL13QuadrivecQuantity;

  {$ENDIF}

  {$IFNDEF ADIMOFF}
  { Returns the square of the complex quantity @code(AQuantity).
    The resulting dimension is the square of the original dimension.
    @param(AQuantity The complex quantity to square.)
  }
  function SquarePower(const AQuantity: TComplexQuantity): TComplexQuantity; overload;

  { Returns the cube of the complex quantity @code(AQuantity).
    The resulting dimension is the cube of the original dimension.
    @param(AQuantity The complex quantity to cube.)
  }
  function CubicPower(const AQuantity: TComplexQuantity): TComplexQuantity; overload;

  { Returns the fourth power of the complex quantity @code(AQuantity).
    The resulting dimension is the fourth power of the original dimension.
    @param(AQuantity The complex quantity to raise to the fourth power.)
  }
  function QuarticPower(const AQuantity: TComplexQuantity): TComplexQuantity; overload;

  { Returns the fifth power of the complex quantity @code(AQuantity).
    The resulting dimension is the fifth power of the original dimension.
    @param(AQuantity The complex quantity to raise to the fifth power.)
  }
  function QuinticPower(const AQuantity: TComplexQuantity): TComplexQuantity; overload;

  { Returns the sixth power of the complex quantity @code(AQuantity).
    The resulting dimension is the sixth power of the original dimension.
    @param(AQuantity The complex quantity to raise to the sixth power.)
  }
  function SexticPower(const AQuantity: TComplexQuantity): TComplexQuantity; overload;
  {$ENDIF}

  {$IFNDEF ADIMOFF}
  { Returns @true if two real physical quantities are equal within the default floating point tolerance.
    Both operands must have the same dimension; an exception is raised if they differ.
    @param(ALeft  The first quantity.)
    @param(ARight The second quantity.)
  }
  function SameValueEx(const ALeft, ARight: TRealQuantity): boolean; overload;

  { Returns @true if two complex physical quantities are equal within the default floating point tolerance.
    Both operands must have the same dimension; an exception is raised if they differ.
    @param(ALeft  The first quantity.)
    @param(ARight The second quantity.)
  }
  function SameValueEx(const ALeft, ARight: TComplexQuantity): boolean; overload;

  { Returns the absolute value of the quantity. The dimension is preserved.
    @param(AQuantity The quantity.)
  }
  function Abs(const AQuantity: TRealQuantity): TRealQuantity; overload;
  {$ENDIF}

  { Returns the square of the quantity: @code(AQuantity²).
    The resulting dimension is the square of the original dimension.
    @param(AQuantity The quantity to square.)
    @exclude
  }
  function SquarePower(const AQuantity: TRealQuantity): TRealQuantity; overload;

  { Returns the cube of the quantity: @code(AQuantity³).
    The resulting dimension is the cube of the original dimension.
    @param(AQuantity The quantity to cube.)
  }
  function CubicPower(const AQuantity: TRealQuantity): TRealQuantity; overload;

  { Returns the fourth power of the quantity: @code(AQuantity⁴).
    The resulting dimension is the fourth power of the original dimension.
    @param(AQuantity The quantity to raise to the fourth power.)
  }
  function QuarticPower(const AQuantity: TRealQuantity): TRealQuantity; overload;

  { Returns the fifth power of the quantity: @code(AQuantity⁵).
    The resulting dimension is the fifth power of the original dimension.
    @param(AQuantity The quantity to raise to the fifth power.)
  }
  function QuinticPower(const AQuantity: TRealQuantity): TRealQuantity; overload;

  { Returns the sixth power of the quantity: @code(AQuantity⁶).
    The resulting dimension is the sixth power of the original dimension.
    @param(AQuantity The quantity to raise to the sixth power.)
  }
  function SexticPower(const AQuantity: TRealQuantity): TRealQuantity; overload;

  { Returns the square root of the quantity: @code(AQuantity^(1/2)).
    The resulting dimension has all exponents halved.
    @raises(Exception if any dimension exponent is odd.)
    @param(AQuantity The quantity whose square root is computed.)
  }
  function SquareRoot(const AQuantity: TRealQuantity): TRealQuantity; overload;

  { Returns the cube root of the quantity: @code(AQuantity^(1/3)).
    The resulting dimension has all exponents divided by 3.
    @raises(Exception if any dimension exponent is not divisible by 3.)
    @param(AQuantity The quantity whose cube root is computed.)
  }
  function CubicRoot(const AQuantity: TRealQuantity): TRealQuantity; overload;

  { Returns the fourth root of the quantity: @code(AQuantity^(1/4)).
    The resulting dimension has all exponents divided by 4.
    @raises(Exception if any dimension exponent is not divisible by 4.)
    @param(AQuantity The quantity whose fourth root is computed.)
  }
  function QuarticRoot(const AQuantity: TRealQuantity): TRealQuantity; overload;

  { Returns the fifth root of the quantity: @code(AQuantity^(1/5)).
    The resulting dimension has all exponents divided by 5.
    @raises(Exception if any dimension exponent is not divisible by 5.)
    @param(AQuantity The quantity whose fifth root is computed.)
  }
  function QuinticRoot(const AQuantity: TRealQuantity): TRealQuantity; overload;

  { Returns the sixth root of the quantity: @code(AQuantity^(1/6)).
    The resulting dimension has all exponents divided by 6.
    @raises(Exception if any dimension exponent is not divisible by 6.)
    @param(AQuantity The quantity whose sixth root is computed.)
  }
  function SexticRoot(const AQuantity: TRealQuantity): TRealQuantity; overload;

  { Returns the cosine of the angle quantity.
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(TReal).
    @param(AQuantity The angle quantity in radians.)
  }
  function Cos(const AQuantity: TRealQuantity): TReal; overload;

  { Returns the sine of the angle quantity.
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(TReal).
    @param(AQuantity The angle quantity in radians.)
  }
  function Sin(const AQuantity: TRealQuantity): TReal; overload;

  { Returns the tangent of the angle quantity.
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(TReal).
    @param(AQuantity The angle quantity in radians.)
  }
  function Tan(const AQuantity: TRealQuantity): TReal; overload;

  { Returns the cotangent of the angle quantity: @code(cos(θ)/sin(θ)).
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(TReal).
    @param(AQuantity The angle quantity in radians.)
  }
  function Cotan(const AQuantity: TRealQuantity): TReal; overload;

  { Returns the secant of the angle quantity: @code(1/cos(θ)).
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(TReal).
    @param(AQuantity The angle quantity in radians.)
  }
  function Secant(const AQuantity: TRealQuantity): TReal; overload;

  { Returns the cosecant of the angle quantity: @code(1/sin(θ)).
    The quantity must have the dimension of an angle (radians).
    The result is a dimensionless @code(TReal).
    @param(AQuantity The angle quantity in radians.)
  }
  function Cosecant(const AQuantity: TRealQuantity): TReal; overload;

  { Returns the arc cosine of @code(AValue) as an angle quantity in radians.
    @code(AValue) must be in the range @code([-1, 1]).
    The result has the dimension of an angle (radians).
    @param(AValue The dimensionless cosine value.)
  }
  function ArcCos(const AValue: TReal): TRealQuantity; overload;

  { Returns the arc sine of @code(AValue) as an angle quantity in radians.
    @code(AValue) must be in the range @code([-1, 1]).
    The result has the dimension of an angle (radians).
    @param(AValue The dimensionless sine value.)
  }
  function ArcSin(const AValue: TReal): TRealQuantity; overload;

  { Returns the arc tangent of @code(AValue) as an angle quantity in radians.
    The result is in the range @code((-π/2, π/2)).
    The result has the dimension of an angle (radians).
    @param(AValue The dimensionless tangent value.)
  }
  function ArcTan(const AValue: TReal): TRealQuantity; overload;

  { Returns the arc tangent of @code(y/x) as an angle quantity in radians,
    using the signs of both arguments to determine the correct quadrant.
    The result is in the range @code([-π, π]).
    The result has the dimension of an angle (radians).
    @param(AY The dimensionless y-coordinate.)
    @param(AX The dimensionless x-coordinate.)
  }
  function ArcTan2(const AY, AX: TReal): TRealQuantity; overload;

  { Returns the smaller of two quantities.
    Both operands must have the same dimension.
    @param(ALeft  The first quantity.)
    @param(ARight The second quantity.)
  }
  function Min(const ALeft, ARight: TRealQuantity): TRealQuantity; overload;

  { Returns the larger of two quantities.
    Both operands must have the same dimension.
    @param(ALeft  The first quantity.)
    @param(ARight The second quantity.)
  }
  function Max(const ALeft, ARight: TRealQuantity): TRealQuantity; overload;

  { Returns @code(e^AQuantity) as a dimensioned quantity.
    The argument must be dimensionless; the result has the same dimension as the argument.
    @param(AQuantity The dimensionless exponent quantity.)
  }
  function Exp(const AQuantity: TRealQuantity): TRealQuantity; overload;

  { Returns the base-10 logarithm of the quantity as a dimensionless @code(TReal).
    The argument must be dimensionless and positive.
    @param(AQuantity The dimensionless positive quantity.)
  }
  function Log10(const AQuantity: TRealQuantity): TReal; overload;

  { Returns the base-2 logarithm of the quantity as a dimensionless @code(TReal).
    The argument must be dimensionless and positive.
    @param(AQuantity The dimensionless positive quantity.)
  }
  function Log2(const AQuantity: TRealQuantity): TReal; overload;

  { Returns the base-@code(ABase) logarithm of the quantity as a dimensionless @code(TReal).
    The argument must be dimensionless and positive.
    @param(ABase     The integer logarithm base.)
    @param(AQuantity The dimensionless positive quantity.)
  }
  function LogN(ABase: longint; const AQuantity: TRealQuantity): TReal; overload;

  { Returns the logarithm of @code(AQuantity) in the base @code(ABase) as a dimensionless @code(TReal).
    Both arguments must be dimensionless and positive.
    @param(ABase     The dimensionless base quantity.)
    @param(AQuantity The dimensionless positive quantity.)
  }
  function LogN(const ABase, AQuantity: TRealQuantity): TReal; overload;

  { Returns @code(ABase^AExponent) as a dimensionless @code(TReal).
    The base must be dimensionless. Used for fractional or real exponents
    where dimensional consistency cannot be verified at compile time.
    @param(ABase     The dimensionless base quantity.)
    @param(AExponent The real exponent.)
  }
  function Power(const ABase: TRealQuantity; AExponent: TReal): TReal; overload;

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
  AvogadroConstant               : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (   0,    0,    0,    0,    0,  -60,    0,    0)); FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}

  { Bohr magneton @code(μB = 9.2740100657 × 10⁻²⁴ J·T⁻¹).
    Natural unit of electronic magnetic dipole moment.
  }
  BohrMagneton                   : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (   0,  120,    0,   60,    0,    0,    0,    0)); FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}

  { Bohr radius @code(a₀ = 5.29177210903 × 10⁻¹¹ m).
    Most probable distance between the electron and nucleus in a hydrogen atom ground state.
  }
  BohrRadius                     : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (   0,   60,    0,    0,    0,    0,    0,    0)); FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}

  { Boltzmann constant @code(kB = 1.380649 × 10⁻²³ J·K⁻¹).
    Relates the average kinetic energy of particles in a gas to the thermodynamic temperature.
  }
  BoltzmannConstant              : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (  60,  120, -120,    0,  -60,    0,    0,    0)); FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}

  { Compton wavelength @code(λC = 2.42631023867 × 10⁻¹² m).
    Quantum mechanical property of the electron; sets the scale at which quantum field effects become significant.
  }
  ComptonWaveLength              : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (   0,   60,    0,    0,    0,    0,    0,    0)); FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}

  { Coulomb constant @code(ke = 8.9875517923 × 10⁹ N·m²·C⁻²).
    Proportionality constant in Coulomb's law of electrostatic force.
  }
  CoulombConstant                : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (  60,  180, -240, -120,    0,    0,    0,    0)); FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}

  { Deuteron mass @code(m_d = 3.3435837768 × 10⁻²⁷ kg).
    Rest mass of the deuteron (nucleus of deuterium, one proton and one neutron).
  }
  DeuteronMass                   : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (  60,    0,    0,    0,    0,    0,    0,    0)); FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}

  { Electric permittivity of free space @code(ε₀ = 8.8541878188 × 10⁻¹² F·m⁻¹).
    Relates electric field to electric displacement field in a vacuum.
  }
  ElectricPermittivity           : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: ( -60, -180,  240,  120,    0,    0,    0,    0)); FValue:     8.8541878188E-12); {$ELSE} (    8.8541878188E-12); {$ENDIF}

  { Electron rest mass @code(m_e = 9.1093837015 × 10⁻³¹ kg).
    Rest mass of the electron.
  }
  ElectronMass                   : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (  60,    0,    0,    0,    0,    0,    0,    0)); FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}

  { Elementary charge @code(e = 1.602176634 × 10⁻¹⁹ C).
      Electric charge carried by a single proton; the fundamental unit of electric charge.
  }
  ElectronCharge                 : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (   0,    0,   60,   60,    0,    0,    0,    0)); FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}

  { Fine-structure constant @code(α = 7.2973525643 × 10⁻³) (dimensionless).
    Characterises the strength of the electromagnetic interaction between elementary charged particles.
  }
  FineStructureConstant          : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (   0,    0,    0,    0,    0,    0,    0,    0)); FValue:      7.2973525643E-3); {$ELSE} (     7.2973525643E-3); {$ENDIF}

  { Inverse fine-structure constant @code(α⁻¹ = 137.035999177) (dimensionless).
    Reciprocal of the fine-structure constant; often used in quantum electrodynamics.
  }
  InverseFineStructureConstant   : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (   0,    0,    0,    0,    0,    0,    0,    0)); FValue:        137.035999177); {$ELSE} (       137.035999177); {$ENDIF}

  { Magnetic permeability of free space @code(μ₀ = 1.25663706212 × 10⁻⁶ H·m⁻¹).
    Relates magnetic field intensity to magnetic flux density in a vacuum.
  }
  MagneticPermeability           : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (  60,   60, -120, -120,    0,    0,    0,    0)); FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}

  { Molar gas constant @code(R = 8.314462618 J·mol⁻¹·K⁻¹).
    Relates energy to temperature and amount of substance in the ideal gas law.
  }
  MolarGasConstant               : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (  60,  120, -120,    0,  -60,  -60,    0,    0)); FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}

  { Neutron rest mass @code(m_n = 1.67492750056 × 10⁻²⁷ kg).
    Rest mass of the neutron.
  }
  NeutronRestMass                : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (  60,    0,    0,    0,    0,    0,    0,    0)); FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}

  { Newtonian constant of gravitation @code(G = 6.67430 × 10⁻¹¹ m³·kg⁻¹·s⁻²).
    Proportionality constant in Newton's law of universal gravitation.
  }
  NewtonianConstantOfGravitation : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: ( -60,  180, -120,    0,    0,    0,    0,    0)); FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}

  { Planck constant @code(h = 6.62607015 × 10⁻³⁴ J·s).
    Relates the energy of a photon to its frequency; fundamental constant of quantum mechanics.
  }
  PlanckConstant                 : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (  60,  120,  -60,    0,    0,    0,    0,    0)); FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}

  { Proton rest mass @code(m_p = 1.67262192595 × 10⁻²⁷ kg).
    Rest mass of the proton.
  }
  ProtonRestMass                 : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (  60,    0,    0,    0,    0,    0,    0,    0)); FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}

  { Rydberg constant @code(R∞ = 10973731.568157 m⁻¹).
    Relates the wavelengths of spectral lines of the hydrogen atom.
  }
  RydbergConstant                : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (   0,  -60,    0,    0,    0,    0,    0,    0)); FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}

  { Speed of light in vacuum @code(c = 299792458 m·s⁻¹).
    Exact defined value; maximum speed of propagation of any physical interaction.
  }
  SpeedOfLight                   : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (   0,   60,  -60,    0,    0,    0,    0,    0)); FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}

  { Squared speed of light in vacuum @code(c² = 8.98755178736818 × 10¹⁶ m²·s⁻²).
    Appears in the mass-energy equivalence relation @code(E = mc²).
  }
  SquaredSpeedOfLight            : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (   0,  120, -120,    0,    0,    0,    0,    0)); FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}

  { Standard acceleration of gravity @code(g = 9.80665 m·s⁻²).
    Conventional standard value of the acceleration due to Earth's gravity at sea level.
  }
  StandardAccelerationOfGravity  : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (   0,   60, -120,    0,    0,    0,    0,    0)); FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}

  { Reduced Planck constant @code(ℏ = h / (2π) = 1.054571817 × 10⁻³⁴ J·s).
    Also called the Dirac constant; appears in quantum mechanics wherever angular frequency is used.
  }
  ReducedPlanckConstant          : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (  60,  120,  -60,    0,    0,    0,    0,    0)); FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}

  { Unified atomic mass unit @code(u = 1.66053906892 × 10⁻²⁷ kg).
    Defined as one twelfth of the mass of a carbon-12 atom at rest.
  }
  UnifiedAtomicMassUnit          : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (  60,    0,    0,    0,    0,    0,    0,    0)); FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}

  { Reference sound intensity @code(I₀ = 10⁻¹² W·m⁻²).
    Conventional threshold of human hearing at 1 kHz; used as the reference level
    for the decibel scale of sound intensity.
  }
  SoundIntensityReference        : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: (FExponents: (  60,    0, -180,    0,    0,    0,    0,    0)); FValue:                1E-12); {$ELSE} (               1E-12); {$ENDIF}

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




{ CheckSum, CheckSub and Check must never be inlined: they report errors at
  the return address of their caller's caller (see RaiseDimensionError). }
{ @exclude } function  CheckSum  (ALeft, ARight: TDimension): TDimension;
{ @exclude } function  CheckSub  (ALeft, ARight: TDimension): TDimension;
{ @exclude } function  CheckMul  (ALeft, ARight: TDimension): TDimension; inline;
{ @exclude } function  CheckDiv  (ALeft, ARight: TDimension): TDimension; inline;
{ @exclude } procedure Check     (ALeft, ARight: TDimension);

implementation

uses Math;

{ Dimension checks. They are implemented first so that the routines below can
  inline CheckMul and CheckDiv: FPC only inlines a call when the body of the
  callee has already been compiled. }

{ Raises EDimensionError as if it originated in the routine that called the
  library routine owning ACheckFrame (the frame of a Check* function). This way
  debuggers and backtraces point at the user's expression, e.g. "a + b", rather
  than at the internals of the operator. }
procedure RaiseDimensionError(const AFormat: string; ALeft, ARight: TDimension;
  ACheckFrame: Pointer);
var
  LOwnerFrame: Pointer;
begin
  LOwnerFrame := get_caller_frame(ACheckFrame);
  raise EDimensionError.CreateFmt(AFormat, [ALeft.ToString, ARight.ToString])
    at get_caller_addr(LOwnerFrame), get_caller_frame(LOwnerFrame);
end;

function CheckSum(ALeft, ARight: TDimension): TDimension;
begin
  if ALeft <> ARight then
    RaiseDimensionError(
      'Cannot add quantities with dimensions %s and %s.',
      ALeft, ARight, get_frame);
  result := ALeft;
end;

function CheckSub(ALeft, ARight: TDimension): TDimension;
begin
  if ALeft <> ARight then
    RaiseDimensionError(
      'Cannot subtract quantities with dimensions %s and %s.',
      ALeft, ARight, get_frame);
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
    RaiseDimensionError(
      'Incompatible physical dimensions: %s and %s.',
      ALeft, ARight, get_frame);
end;

function UseSingularUnitName(const AValue: TReal): boolean; inline;
begin
  result := Math.SameValue(System.Abs(AValue), 1.0, DefaultEpsilon);
end;

function OddRoot(const AValue: TReal; const ADegree: longint): TReal; inline;
var
  LExponent: TReal;
begin
  { Computed in TReal: "1.0 / ADegree" would be evaluated in single precision,
    because FPC types the literal 1.0 as single. }
  LExponent := 1 / ADegree;
  if AValue < 0 then
    result := -Math.Power(-AValue, LExponent)
  else
    result := Math.Power(AValue, LExponent);
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

procedure RawRealMatrixEigenpairs(constref AValue: TRealMatrix;
  out AValues: TComplexVector;
  out AVectors: TComplexMatrix); inline;
begin
  AValue.Eigenpairs(AValues, AVectors);
end;

function RawComplexMatrixConjugate(constref AValue: TComplexMatrix): TComplexMatrix; inline;
begin
  result := AValue.Conjugate;
end;

procedure RawComplexMatrixEigenpairs(constref AValue: TComplexMatrix;
  out AValues: TComplexVector;
  out AVectors: TComplexMatrix); inline;
begin
  AValue.Eigenpairs(AValues, AVectors);
end;

procedure RawRealMatrixSymmetricEigenpairs(constref AValue: TRealMatrix;
  out AValues: TRealVector;
  out AVectors: TRealMatrix); inline;
begin
  AValue.SymmetricEigenpairs(AValues, AVectors);
end;

procedure RawComplexMatrixHermitianEigenpairs(constref AValue: TComplexMatrix;
  out AValues: TRealVector;
  out AVectors: TComplexMatrix); inline;
begin
  AValue.HermitianEigenpairs(AValues, AVectors);
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

function TRealQuantityHelper.Conjugate: TRealQuantity;
begin
  result := Self;
end;

function TRealQuantityHelper.Norm: TRealQuantity;
begin
  result.FDim := Self.FDim;
  result.FValue := System.Abs(Self.FValue);
end;

function TRealQuantityHelper.SameValue(const AQuantity: TRealQuantity): boolean;
begin
  Check(Self.FDim, AQuantity.FDim);
  result := Math.SameValue(Self.FValue, AQuantity.FValue, DefaultEpsilon);
end;

function TRealQuantityHelper.SquaredNorm: TRealQuantity;
begin
  result.FDim := Self.FDim * 2;
  result.FValue := Sqr(Self.FValue);
end;

function TComplexQuantityHelper.Arg: TReal;
begin
  result := Self.FValue.Arg;
end;

function TComplexQuantityHelper.Conjugate: TComplexQuantity;
begin
  result.FDim := Self.FDim;
  result.FValue := Self.FValue.Conjugate;
end;

function TComplexQuantityHelper.IsNotNull: boolean;
begin
  result := Self.FValue.IsNotNull;
end;

function TComplexQuantityHelper.IsNull: boolean;
begin
  result := Self.FValue.IsNull;
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

operator /(const ALeft: TReal; const ARight: TComplexQuantity): TComplexQuantity;
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

class operator TMatrixQuantity.+(const ASelf: TMatrixQuantity): TMatrixQuantity;
begin
  result.FDim := ASelf.FDim;
  result.FValue := ASelf.FValue;
end;

class operator TMatrixQuantity.-(const ASelf: TMatrixQuantity): TMatrixQuantity;
begin
  result.FDim := ASelf.FDim;
  result.FValue := -ASelf.FValue;
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

procedure TRealMatrixQuantityHelper.Eigenpairs(
  out AValues: TComplexVectorQuantity;
  out AVectors: TComplexMatrix);
var
  RawValues: TComplexVector;
begin
  RawRealMatrixEigenpairs(Self.FValue, RawValues, AVectors);
  AValues.FDim := Self.FDim;
  AValues.FValue := RawValues;
end;

procedure TRealMatrixQuantityHelper.SymmetricEigenpairs(
  out AValues: TRealVectorQuantity;
  out AVectors: TRealMatrix);
var
  RawValues: TRealVector;
begin
  RawRealMatrixSymmetricEigenpairs(Self.FValue, RawValues, AVectors);
  AValues.FDim := Self.FDim;
  AValues.FValue := RawValues;
end;

function TComplexMatrixQuantityHelper.Conjugate: TComplexMatrixQuantity;
begin
  result.FDim := Self.FDim;
  result.FValue := RawComplexMatrixConjugate(Self.FValue);
end;

procedure TComplexMatrixQuantityHelper.Eigenpairs(
  out AValues: TComplexVectorQuantity;
  out AVectors: TComplexMatrix);
var
  RawValues: TComplexVector;
begin
  RawComplexMatrixEigenpairs(Self.FValue, RawValues, AVectors);
  AValues.FDim := Self.FDim;
  AValues.FValue := RawValues;
end;

procedure TComplexMatrixQuantityHelper.HermitianEigenpairs(
  out AValues: TRealVectorQuantity;
  out AVectors: TComplexMatrix);
var
  RawValues: TRealVector;
begin
  RawComplexMatrixHermitianEigenpairs(Self.FValue, RawValues, AVectors);
  AValues.FDim := Self.FDim;
  AValues.FValue := RawValues;
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

operator *(const ALeft: TRealQuantity; const ARight: TRealVector): TRealVectorQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TRealVector; const ARight: TRealQuantity): TRealVectorQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator /(const ALeft: TRealVector; const ARight: TRealQuantity): TRealVectorQuantity;
begin
  result.FDim := -ARight.FDim;
  result.FValue := ALeft / ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TRealMatrix): TRealMatrixQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TRealMatrix; const ARight: TRealQuantity): TRealMatrixQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator /(const ALeft: TRealMatrix; const ARight: TRealQuantity): TRealMatrixQuantity;
begin
  result.FDim := -ARight.FDim;
  result.FValue := ALeft / ARight.FValue;
end;

operator *(const ALeft: TComplexQuantity; const ARight: TComplexVector): TComplexVectorQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TComplexVector; const ARight: TComplexQuantity): TComplexVectorQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator /(const ALeft: TComplexVector; const ARight: TComplexQuantity): TComplexVectorQuantity;
begin
  result.FDim := -ARight.FDim;
  result.FValue := ALeft / ARight.FValue;
end;

operator *(const ALeft: TComplexQuantity; const ARight: TComplexMatrix): TComplexMatrixQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TComplexMatrix; const ARight: TComplexQuantity): TComplexMatrixQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator /(const ALeft: TComplexMatrix; const ARight: TComplexQuantity): TComplexMatrixQuantity;
begin
  result.FDim := -ARight.FDim;
  result.FValue := ALeft / ARight.FValue;
end;

{$ENDIF}


{$IFNDEF ADIMOFF}
// TCL2MultivecQuantity

class operator TCL2MultivecQuantity.=(const ALeft: TCL2MultivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2MultivecQuantity.=(const ALeft: TRealQuantity; const ARight: TCL2MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2MultivecQuantity.=(const ALeft: TCL2MultivecQuantity; const ARight: TCL2MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2MultivecQuantity.<>(const ALeft: TCL2MultivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2MultivecQuantity.<>(const ALeft: TRealQuantity; const ARight: TCL2MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2MultivecQuantity.<>(const ALeft: TCL2MultivecQuantity; const ARight: TCL2MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2MultivecQuantity.-(const AValue: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
end;

class operator TCL2MultivecQuantity.+(const ALeft: TCL2MultivecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2MultivecQuantity.+(const ALeft: TRealQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2MultivecQuantity.+(const ALeft: TCL2MultivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2MultivecQuantity.-(const ALeft: TCL2MultivecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2MultivecQuantity.-(const ALeft: TRealQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2MultivecQuantity.-(const ALeft: TCL2MultivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2MultivecQuantity.*(const ALeft: TCL2MultivecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2MultivecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2MultivecQuantity.*(const ALeft: TCL2MultivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2MultivecQuantity./(const ALeft: TCL2MultivecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2MultivecQuantity./(const ALeft: TCL2MultivecQuantity; const ARight: TReal): TCL2MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL2MultivecQuantity./(const ALeft: TRealQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2MultivecQuantity./(const ALeft: TReal; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

class operator TCL2MultivecQuantity./(const ALeft: TCL2MultivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2MultivecQuantity.:=(const AValue: TCL2Multivector): TCL2MultivecQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;

// TCL2VecQuantity

class operator TCL2VecQuantity.:=(const AValue: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TCL2VecQuantity.Explicit(const AValue: TCL2MultivecQuantity): TCL2VecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := TCL2Vector(AValue.FValue);
end;

class operator TCL2VecQuantity.=(const ALeft: TCL2VecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2VecQuantity.=(const ALeft: TRealQuantity; const ARight: TCL2VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2VecQuantity.=(const ALeft: TCL2VecQuantity; const ARight: TCL2VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2VecQuantity.=(const ALeft: TCL2VecQuantity; const ARight: TCL2MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2VecQuantity.=(const ALeft: TCL2MultivecQuantity; const ARight: TCL2VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2VecQuantity.<>(const ALeft: TCL2VecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2VecQuantity.<>(const ALeft: TRealQuantity; const ARight: TCL2VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2VecQuantity.<>(const ALeft: TCL2VecQuantity; const ARight: TCL2VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2VecQuantity.<>(const ALeft: TCL2VecQuantity; const ARight: TCL2MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2VecQuantity.<>(const ALeft: TCL2MultivecQuantity; const ARight: TCL2VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2VecQuantity.-(const AValue: TCL2VecQuantity): TCL2VecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
end;

class operator TCL2VecQuantity.+(const ALeft: TCL2VecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2VecQuantity.+(const ALeft: TRealQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2VecQuantity.+(const ALeft: TCL2VecQuantity; const ARight: TCL2VecQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2VecQuantity.+(const ALeft: TCL2VecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2VecQuantity.+(const ALeft: TCL2MultivecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2VecQuantity.-(const ALeft: TCL2VecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2VecQuantity.-(const ALeft: TRealQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2VecQuantity.-(const ALeft: TCL2VecQuantity; const ARight: TCL2VecQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2VecQuantity.-(const ALeft: TCL2VecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2VecQuantity.-(const ALeft: TCL2MultivecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2VecQuantity.*(const ALeft: TCL2VecQuantity; const ARight: TRealQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2VecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL2VecQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2VecQuantity.*(const ALeft: TCL2VecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2VecQuantity.*(const ALeft: TCL2VecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2VecQuantity.*(const ALeft: TCL2MultivecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2VecQuantity./(const ALeft: TCL2VecQuantity; const ARight: TRealQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2VecQuantity./(const ALeft: TCL2VecQuantity; const ARight: TReal): TCL2VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL2VecQuantity./(const ALeft: TRealQuantity; const ARight: TCL2VecQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2VecQuantity./(const ALeft: TReal; const ARight: TCL2VecQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

class operator TCL2VecQuantity./(const ALeft: TCL2VecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2VecQuantity./(const ALeft: TCL2VecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2VecQuantity./(const ALeft: TCL2MultivecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2VecQuantity.:=(const AValue: TCL2Vector): TCL2VecQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;

// TCL2BivecQuantity

class operator TCL2BivecQuantity.:=(const AValue: TCL2BivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TCL2BivecQuantity.Explicit(const AValue: TCL2MultivecQuantity): TCL2BivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := TCL2Bivector(AValue.FValue);
end;

class operator TCL2BivecQuantity.=(const ALeft: TCL2BivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2BivecQuantity.=(const ALeft: TRealQuantity; const ARight: TCL2BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2BivecQuantity.=(const ALeft: TCL2BivecQuantity; const ARight: TCL2BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2BivecQuantity.=(const ALeft: TCL2BivecQuantity; const ARight: TCL2VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2BivecQuantity.=(const ALeft: TCL2VecQuantity; const ARight: TCL2BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2BivecQuantity.=(const ALeft: TCL2BivecQuantity; const ARight: TCL2MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2BivecQuantity.=(const ALeft: TCL2MultivecQuantity; const ARight: TCL2BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL2BivecQuantity.<>(const ALeft: TCL2BivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2BivecQuantity.<>(const ALeft: TRealQuantity; const ARight: TCL2BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2BivecQuantity.<>(const ALeft: TCL2BivecQuantity; const ARight: TCL2BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2BivecQuantity.<>(const ALeft: TCL2BivecQuantity; const ARight: TCL2VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2BivecQuantity.<>(const ALeft: TCL2VecQuantity; const ARight: TCL2BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2BivecQuantity.<>(const ALeft: TCL2BivecQuantity; const ARight: TCL2MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2BivecQuantity.<>(const ALeft: TCL2MultivecQuantity; const ARight: TCL2BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL2BivecQuantity.-(const AValue: TCL2BivecQuantity): TCL2BivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
end;

class operator TCL2BivecQuantity.+(const ALeft: TCL2BivecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2BivecQuantity.+(const ALeft: TRealQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2BivecQuantity.+(const ALeft: TCL2BivecQuantity; const ARight: TCL2BivecQuantity): TCL2BivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2BivecQuantity.+(const ALeft: TCL2BivecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2BivecQuantity.+(const ALeft: TCL2VecQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2BivecQuantity.+(const ALeft: TCL2BivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2BivecQuantity.+(const ALeft: TCL2MultivecQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL2BivecQuantity.-(const ALeft: TCL2BivecQuantity; const ARight: TRealQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2BivecQuantity.-(const ALeft: TRealQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2BivecQuantity.-(const ALeft: TCL2BivecQuantity; const ARight: TCL2BivecQuantity): TCL2BivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2BivecQuantity.-(const ALeft: TCL2BivecQuantity; const ARight: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2BivecQuantity.-(const ALeft: TCL2VecQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2BivecQuantity.-(const ALeft: TCL2BivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2BivecQuantity.-(const ALeft: TCL2MultivecQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL2BivecQuantity.*(const ALeft: TCL2BivecQuantity; const ARight: TRealQuantity): TCL2BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2BivecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL2BivecQuantity): TCL2BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2BivecQuantity.*(const ALeft: TCL2BivecQuantity; const ARight: TCL2BivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2BivecQuantity.*(const ALeft: TCL2BivecQuantity; const ARight: TCL2VecQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2BivecQuantity.*(const ALeft: TCL2VecQuantity; const ARight: TCL2BivecQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2BivecQuantity.*(const ALeft: TCL2BivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2BivecQuantity.*(const ALeft: TCL2MultivecQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL2BivecQuantity./(const ALeft: TCL2BivecQuantity; const ARight: TRealQuantity): TCL2BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2BivecQuantity./(const ALeft: TCL2BivecQuantity; const ARight: TReal): TCL2BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL2BivecQuantity./(const ALeft: TRealQuantity; const ARight: TCL2BivecQuantity): TCL2BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2BivecQuantity./(const ALeft: TReal; const ARight: TCL2BivecQuantity): TCL2BivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

class operator TCL2BivecQuantity./(const ALeft: TCL2BivecQuantity; const ARight: TCL2BivecQuantity): TRealQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2BivecQuantity./(const ALeft: TCL2BivecQuantity; const ARight: TCL2VecQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2BivecQuantity./(const ALeft: TCL2VecQuantity; const ARight: TCL2BivecQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2BivecQuantity./(const ALeft: TCL2BivecQuantity; const ARight: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2BivecQuantity./(const ALeft: TCL2MultivecQuantity; const ARight: TCL2BivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL2BivecQuantity.:=(const AValue: TCL2Bivector): TCL2BivecQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;

// TCL2MultivecQuantityHelper

function TCL2MultivecQuantityHelper.Extract(AComponents: TCL2MultivectorComponents): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL2MultivecQuantityHelper.Extract(AComponents: TCL2BivectorComponents): TCL2BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL2MultivecQuantityHelper.Extract(AComponents: TCL2VectorComponents): TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL2MultivecQuantityHelper.ExtractBivector: TCL2BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractBivector;
end;

function TCL2MultivecQuantityHelper.ExtractVector: TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractVector;
end;

function TCL2MultivecQuantityHelper.ExtractScalar: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractScalar;
end;

function TCL2MultivecQuantityHelper.SameValue(const AValue: TCL2MultivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL2MultivecQuantityHelper.SameValue(const AValue: TCL2BivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL2MultivecQuantityHelper.SameValue(const AValue: TCL2VecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL2MultivecQuantityHelper.SameValue(const AValue: TRealQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL2MultivecQuantityHelper.IsNull: boolean;
begin
  result := FValue.IsNull;
end;

function TCL2MultivecQuantityHelper.IsScalar: boolean;
begin
  result := FValue.IsScalar;
end;

function TCL2MultivecQuantityHelper.IsVector: boolean;
begin
  result := FValue.IsVector;
end;

function TCL2MultivecQuantityHelper.IsBivector: boolean;
begin
  result := FValue.IsBivector;
end;

function TCL2MultivecQuantityHelper.IsA: string;
begin
  result := FValue.IsA;
end;

function TCL2MultivecQuantityHelper.Norm: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL2MultivecQuantityHelper.SquaredNorm: TRealQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL2MultivecQuantityHelper.Dual: TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL2MultivecQuantityHelper.Involute: TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Involute;
end;

function TCL2MultivecQuantityHelper.Reverse: TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL2MultivecQuantityHelper.Conjugate: TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL2MultivecQuantityHelper.Inverse: TCL2MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Inverse;
end;

function TCL2MultivecQuantityHelper.GradeMask: longword;
begin
  result := FValue.GradeMask;
end;

function TCL2MultivecQuantityHelper.Normalized: TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL2MultivecQuantityHelper.Projection(const AVector: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL2MultivecQuantityHelper.Projection(const AVector: TCL2BivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL2MultivecQuantityHelper.Projection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL2MultivecQuantityHelper.Rejection(const AVector: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL2MultivecQuantityHelper.Rejection(const AVector: TCL2BivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL2MultivecQuantityHelper.Rejection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL2MultivecQuantityHelper.Reflection(const AVector: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL2MultivecQuantityHelper.Reflection(const AVector: TCL2BivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL2MultivecQuantityHelper.Reflection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL2MultivecQuantityHelper.Rotation(const AVector1: TCL2VecQuantity; const AVector2: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL2MultivecQuantityHelper.Rotation(const AVector1: TCL2BivecQuantity; const AVector2: TCL2BivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL2MultivecQuantityHelper.Rotation(const AVector1: TCL2MultivecQuantity; const AVector2: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL2MultivecQuantityHelper.Rotate(const ARotor: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, CheckMul(ARotor.FDim, ARotor.FDim));
  result.FValue := FValue.Rotate(ARotor.FValue);
end;

function TCL2MultivecQuantityHelper.Dot(const AVector: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL2MultivecQuantityHelper.Dot(const AVector: TCL2BivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL2MultivecQuantityHelper.Dot(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL2MultivecQuantityHelper.Wedge(const AVector: TCL2VecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL2MultivecQuantityHelper.Wedge(const AVector: TCL2BivecQuantity): TCL2BivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL2MultivecQuantityHelper.Wedge(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

// TCL2VecQuantityHelper

function TCL2VecQuantityHelper.Extract(AComponents: TCL2VectorComponents): TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL2VecQuantityHelper.ToMultivector: TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;

function TCL2VecQuantityHelper.SameValue(const AValue: TCL2MultivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL2VecQuantityHelper.SameValue(const AValue: TCL2VecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL2VecQuantityHelper.Norm: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL2VecQuantityHelper.SquaredNorm: TRealQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL2VecQuantityHelper.Dual: TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL2VecQuantityHelper.Involute: TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Involute;
end;

function TCL2VecQuantityHelper.Reverse: TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL2VecQuantityHelper.Conjugate: TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL2VecQuantityHelper.Inverse: TCL2VecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Inverse;
end;

function TCL2VecQuantityHelper.Normalized: TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL2VecQuantityHelper.Projection(const AVector: TCL2VecQuantity): TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL2VecQuantityHelper.Projection(const AVector: TCL2BivecQuantity): TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL2VecQuantityHelper.Projection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL2VecQuantityHelper.Rejection(const AVector: TCL2VecQuantity): TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL2VecQuantityHelper.Rejection(const AVector: TCL2BivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL2VecQuantityHelper.Rejection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL2VecQuantityHelper.Reflection(const AVector: TCL2VecQuantity): TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL2VecQuantityHelper.Reflection(const AVector: TCL2BivecQuantity): TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL2VecQuantityHelper.Reflection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL2VecQuantityHelper.Rotation(const AVector1: TCL2VecQuantity; const AVector2: TCL2VecQuantity): TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL2VecQuantityHelper.Rotation(const AVector1: TCL2BivecQuantity; const AVector2: TCL2BivecQuantity): TCL2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL2VecQuantityHelper.Rotation(const AVector1: TCL2MultivecQuantity; const AVector2: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL2VecQuantityHelper.Rotate(const ARotor: TCL2MultivecQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckMul(FDim, CheckMul(ARotor.FDim, ARotor.FDim));
  result.FValue := FValue.Rotate(ARotor.FValue);
end;

function TCL2VecQuantityHelper.Dot(const AVector: TCL2VecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL2VecQuantityHelper.Dot(const AVector: TCL2BivecQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL2VecQuantityHelper.Dot(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL2VecQuantityHelper.Wedge(const AVector: TCL2VecQuantity): TCL2BivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL2VecQuantityHelper.Wedge(const AVector: TCL2BivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL2VecQuantityHelper.Wedge(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

// TCL2BivecQuantityHelper

function TCL2BivecQuantityHelper.Extract(AComponents: TCL2BivectorComponents): TCL2BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL2BivecQuantityHelper.ToMultivector: TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;

function TCL2BivecQuantityHelper.SameValue(const AValue: TCL2MultivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL2BivecQuantityHelper.SameValue(const AValue: TCL2BivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL2BivecQuantityHelper.Norm: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL2BivecQuantityHelper.SquaredNorm: TRealQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL2BivecQuantityHelper.Dual: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL2BivecQuantityHelper.Involute: TCL2BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Involute;
end;

function TCL2BivecQuantityHelper.Reverse: TCL2BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL2BivecQuantityHelper.Conjugate: TCL2BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL2BivecQuantityHelper.Inverse: TCL2BivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Inverse;
end;

function TCL2BivecQuantityHelper.Normalized: TCL2BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL2BivecQuantityHelper.Projection(const AVector: TCL2VecQuantity): TCL2BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL2BivecQuantityHelper.Projection(const AVector: TCL2BivecQuantity): TCL2BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL2BivecQuantityHelper.Projection(const AVector: TCL2MultivecQuantity): TCL2BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL2BivecQuantityHelper.Rejection(const AVector: TCL2VecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL2BivecQuantityHelper.Rejection(const AVector: TCL2BivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL2BivecQuantityHelper.Rejection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL2BivecQuantityHelper.Reflection(const AVector: TCL2VecQuantity): TCL2BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL2BivecQuantityHelper.Reflection(const AVector: TCL2BivecQuantity): TCL2BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL2BivecQuantityHelper.Reflection(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL2BivecQuantityHelper.Rotation(const AVector1: TCL2VecQuantity; const AVector2: TCL2VecQuantity): TCL2BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL2BivecQuantityHelper.Rotation(const AVector1: TCL2BivecQuantity; const AVector2: TCL2BivecQuantity): TCL2BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL2BivecQuantityHelper.Rotation(const AVector1: TCL2MultivecQuantity; const AVector2: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL2BivecQuantityHelper.Rotate(const ARotor: TCL2MultivecQuantity): TCL2BivecQuantity;
begin
  result.FDim := CheckMul(FDim, CheckMul(ARotor.FDim, ARotor.FDim));
  result.FValue := FValue.Rotate(ARotor.FValue);
end;

function TCL2BivecQuantityHelper.Dot(const AVector: TCL2VecQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL2BivecQuantityHelper.Dot(const AVector: TCL2BivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL2BivecQuantityHelper.Dot(const AVector: TCL2MultivecQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL2BivecQuantityHelper.Wedge(const AVector: TCL2VecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL2BivecQuantityHelper.Wedge(const AVector: TCL2BivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL2BivecQuantityHelper.Wedge(const AVector: TCL2MultivecQuantity): TCL2BivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

{$ENDIF}

{$IFNDEF ADIMOFF}
// TCL3MultivecQuantity

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

class operator TCL3MultivecQuantity.=(const ALeft: TCL3MultivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
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

class operator TCL3MultivecQuantity.<>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3MultivecQuantity.-(const AValue: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
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

class operator TCL3MultivecQuantity.+(const ALeft: TCL3MultivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
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

class operator TCL3MultivecQuantity.-(const ALeft: TCL3MultivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
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

class operator TCL3MultivecQuantity.*(const ALeft: TCL3MultivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3MultivecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TRealQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3MultivecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TReal): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL3MultivecQuantity./(const ALeft: TRealQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3MultivecQuantity./(const ALeft: TReal; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

class operator TCL3MultivecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3MultivecQuantity.:=(const AValue: TCL3Multivector): TCL3MultivecQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;

// TCL3VecQuantity

class operator TCL3VecQuantity.:=(const AValue: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TCL3VecQuantity.Explicit(const AValue: TCL3MultivecQuantity): TCL3VecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := TCL3Vector(AValue.FValue);
end;

class operator TCL3VecQuantity.=(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3VecQuantity.=(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3VecQuantity.=(const ALeft: TCL3VecQuantity; const ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
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

class operator TCL3VecQuantity.<>(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3VecQuantity.<>(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3VecQuantity.<>(const ALeft: TCL3VecQuantity; const ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3VecQuantity.<>(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3VecQuantity.<>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3VecQuantity.-(const AValue: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
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

class operator TCL3VecQuantity.+(const ALeft: TCL3VecQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
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

class operator TCL3VecQuantity.-(const ALeft: TCL3VecQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
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

class operator TCL3VecQuantity.*(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3VecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
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

class operator TCL3VecQuantity./(const ALeft: TCL3VecQuantity; const ARight: TRealQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3VecQuantity; const ARight: TReal): TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL3VecQuantity./(const ALeft: TRealQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3VecQuantity./(const ALeft: TReal; const ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3VecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3VecQuantity.:=(const AValue: TCL3Vector): TCL3VecQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;

// TCL3BivecQuantity

class operator TCL3BivecQuantity.:=(const AValue: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TCL3BivecQuantity.Explicit(const AValue: TCL3MultivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := TCL3Bivector(AValue.FValue);
end;

class operator TCL3BivecQuantity.=(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3BivecQuantity.=(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3BivecQuantity.=(const ALeft: TCL3BivecQuantity; const ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3BivecQuantity.=(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3BivecQuantity.=(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3BivecQuantity.=(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3BivecQuantity.=(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3BivecQuantity.<>(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3BivecQuantity.<>(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3BivecQuantity.<>(const ALeft: TCL3BivecQuantity; const ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3BivecQuantity.<>(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3BivecQuantity.<>(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3BivecQuantity.<>(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3BivecQuantity.<>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const AValue: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
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

class operator TCL3BivecQuantity.+(const ALeft: TCL3BivecQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
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

class operator TCL3BivecQuantity.-(const ALeft: TCL3BivecQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
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

class operator TCL3BivecQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TRealQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TReal): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL3BivecQuantity./(const ALeft: TRealQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft: TReal; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3BivecQuantity.:=(const AValue: TCL3Bivector): TCL3BivecQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;

// TCL3TrivecQuantity

class operator TCL3TrivecQuantity.:=(const AValue: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TCL3TrivecQuantity.Explicit(const AValue: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := TCL3Trivector(AValue.FValue);
end;

class operator TCL3TrivecQuantity.=(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft: TCL3TrivecQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TCL3TrivecQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const AValue: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
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

class operator TCL3TrivecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
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

class operator TCL3TrivecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TCL3TrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TRealQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TReal): TCL3TrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL3TrivecQuantity./(const ALeft: TRealQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: TReal; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TCL3TrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3TrivecQuantity.:=(const AValue: TCL3Trivector): TCL3TrivecQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;

// TCL3MultivecQuantityHelper

function TCL3MultivecQuantityHelper.Extract(AComponents: TCL3MultivectorComponents): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL3MultivecQuantityHelper.Extract(AComponents: TCL3TrivectorComponents): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL3MultivecQuantityHelper.Extract(AComponents: TCL3BivectorComponents): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL3MultivecQuantityHelper.Extract(AComponents: TCL3VectorComponents): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
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

function TCL3MultivecQuantityHelper.SameValue(const AValue: TCL3MultivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AValue: TCL3TrivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AValue: TCL3BivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AValue: TCL3VecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AValue: TRealQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
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

function TCL3MultivecQuantityHelper.IsBivector: boolean;
begin
  result := FValue.IsBivector;
end;

function TCL3MultivecQuantityHelper.IsTrivector: boolean;
begin
  result := FValue.IsTrivector;
end;

function TCL3MultivecQuantityHelper.IsA: string;
begin
  result := FValue.IsA;
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

function TCL3MultivecQuantityHelper.Dual: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL3MultivecQuantityHelper.Involute: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Involute;
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

function TCL3MultivecQuantityHelper.Inverse: TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Inverse;
end;

function TCL3MultivecQuantityHelper.GradeMask: longword;
begin
  result := FValue.GradeMask;
end;

function TCL3MultivecQuantityHelper.Normalized: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
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

function TCL3MultivecQuantityHelper.Rotation(const AVector1: TCL3VecQuantity; const AVector2: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1: TCL3BivecQuantity; const AVector2: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1: TCL3TrivecQuantity; const AVector2: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1: TCL3MultivecQuantity; const AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.Rotate(const ARotor: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, CheckMul(ARotor.FDim, ARotor.FDim));
  result.FValue := FValue.Rotate(ARotor.FValue);
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

// TCL3VecQuantityHelper

function TCL3VecQuantityHelper.Extract(AComponents: TCL3VectorComponents): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL3VecQuantityHelper.ToMultivector: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;

function TCL3VecQuantityHelper.SameValue(const AValue: TCL3MultivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL3VecQuantityHelper.SameValue(const AValue: TCL3VecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
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

function TCL3VecQuantityHelper.Dual: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL3VecQuantityHelper.Involute: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Involute;
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

function TCL3VecQuantityHelper.Inverse: TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Inverse;
end;

function TCL3VecQuantityHelper.Normalized: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
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

function TCL3VecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
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

function TCL3VecQuantityHelper.Rotation(const AVector1: TCL3VecQuantity; const AVector2: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1: TCL3BivecQuantity; const AVector2: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1: TCL3TrivecQuantity; const AVector2: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1: TCL3MultivecQuantity; const AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Rotate(const ARotor: TCL3MultivecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(FDim, CheckMul(ARotor.FDim, ARotor.FDim));
  result.FValue := FValue.Rotate(ARotor.FValue);
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
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3VecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3VecQuantityHelper.Cross(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Cross(AVector.FValue);
end;

// TCL3BivecQuantityHelper

function TCL3BivecQuantityHelper.Extract(AComponents: TCL3BivectorComponents): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL3BivecQuantityHelper.ToMultivector: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;

function TCL3BivecQuantityHelper.SameValue(const AValue: TCL3MultivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL3BivecQuantityHelper.SameValue(const AValue: TCL3BivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
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

function TCL3BivecQuantityHelper.Dual: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL3BivecQuantityHelper.Involute: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Involute;
end;

function TCL3BivecQuantityHelper.Reverse: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL3BivecQuantityHelper.Conjugate: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL3BivecQuantityHelper.Inverse: TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Inverse;
end;

function TCL3BivecQuantityHelper.Normalized: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
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
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
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

function TCL3BivecQuantityHelper.Rotation(const AVector1: TCL3VecQuantity; const AVector2: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1: TCL3BivecQuantity; const AVector2: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1: TCL3TrivecQuantity; const AVector2: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1: TCL3MultivecQuantity; const AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.Rotate(const ARotor: TCL3MultivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(FDim, CheckMul(ARotor.FDim, ARotor.FDim));
  result.FValue := FValue.Rotate(ARotor.FValue);
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
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

// TCL3TrivecQuantityHelper

function TCL3TrivecQuantityHelper.Extract(AComponents: TCL3TrivectorComponents): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL3TrivecQuantityHelper.ToMultivector: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;

function TCL3TrivecQuantityHelper.SameValue(const AValue: TCL3MultivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL3TrivecQuantityHelper.SameValue(const AValue: TCL3TrivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
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

function TCL3TrivecQuantityHelper.Dual: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL3TrivecQuantityHelper.Involute: TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Involute;
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

function TCL3TrivecQuantityHelper.Inverse: TCL3TrivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Inverse;
end;

function TCL3TrivecQuantityHelper.Normalized: TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
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
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
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

function TCL3TrivecQuantityHelper.Rotation(const AVector1: TCL3VecQuantity; const AVector2: TCL3VecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1: TCL3BivecQuantity; const AVector2: TCL3BivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1: TCL3TrivecQuantity; const AVector2: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1: TCL3MultivecQuantity; const AVector2: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotate(const ARotor: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, CheckMul(ARotor.FDim, ARotor.FDim));
  result.FValue := FValue.Rotate(ARotor.FValue);
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
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

{$ENDIF}

{$IFNDEF ADIMOFF}
// TCL13MultivecQuantity

class operator TCL13MultivecQuantity.=(const ALeft: TCL13MultivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13MultivecQuantity.=(const ALeft: TRealQuantity; const ARight: TCL13MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13MultivecQuantity.=(const ALeft: TCL13MultivecQuantity; const ARight: TCL13MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13MultivecQuantity.<>(const ALeft: TCL13MultivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13MultivecQuantity.<>(const ALeft: TRealQuantity; const ARight: TCL13MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13MultivecQuantity.<>(const ALeft: TCL13MultivecQuantity; const ARight: TCL13MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13MultivecQuantity.-(const AValue: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
end;

class operator TCL13MultivecQuantity.+(const ALeft: TCL13MultivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13MultivecQuantity.+(const ALeft: TRealQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13MultivecQuantity.+(const ALeft: TCL13MultivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13MultivecQuantity.-(const ALeft: TCL13MultivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13MultivecQuantity.-(const ALeft: TRealQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13MultivecQuantity.-(const ALeft: TCL13MultivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13MultivecQuantity.*(const ALeft: TCL13MultivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13MultivecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13MultivecQuantity.*(const ALeft: TCL13MultivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13MultivecQuantity./(const ALeft: TCL13MultivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13MultivecQuantity./(const ALeft: TCL13MultivecQuantity; const ARight: TReal): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL13MultivecQuantity./(const ALeft: TRealQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13MultivecQuantity./(const ALeft: TReal; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

class operator TCL13MultivecQuantity./(const ALeft: TCL13MultivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13MultivecQuantity.:=(const AValue: TCL13Multivector): TCL13MultivecQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;

// TCL13VecQuantity

class operator TCL13VecQuantity.:=(const AValue: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TCL13VecQuantity.Explicit(const AValue: TCL13MultivecQuantity): TCL13VecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := TCL13Vector(AValue.FValue);
end;

class operator TCL13VecQuantity.=(const ALeft: TCL13VecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13VecQuantity.=(const ALeft: TRealQuantity; const ARight: TCL13VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13VecQuantity.=(const ALeft: TCL13VecQuantity; const ARight: TCL13VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13VecQuantity.=(const ALeft: TCL13VecQuantity; const ARight: TCL13MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13VecQuantity.=(const ALeft: TCL13MultivecQuantity; const ARight: TCL13VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13VecQuantity.<>(const ALeft: TCL13VecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13VecQuantity.<>(const ALeft: TRealQuantity; const ARight: TCL13VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13VecQuantity.<>(const ALeft: TCL13VecQuantity; const ARight: TCL13VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13VecQuantity.<>(const ALeft: TCL13VecQuantity; const ARight: TCL13MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13VecQuantity.<>(const ALeft: TCL13MultivecQuantity; const ARight: TCL13VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13VecQuantity.-(const AValue: TCL13VecQuantity): TCL13VecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
end;

class operator TCL13VecQuantity.+(const ALeft: TCL13VecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13VecQuantity.+(const ALeft: TRealQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13VecQuantity.+(const ALeft: TCL13VecQuantity; const ARight: TCL13VecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13VecQuantity.+(const ALeft: TCL13VecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13VecQuantity.+(const ALeft: TCL13MultivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13VecQuantity.-(const ALeft: TCL13VecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13VecQuantity.-(const ALeft: TRealQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13VecQuantity.-(const ALeft: TCL13VecQuantity; const ARight: TCL13VecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13VecQuantity.-(const ALeft: TCL13VecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13VecQuantity.-(const ALeft: TCL13MultivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13VecQuantity.*(const ALeft: TCL13VecQuantity; const ARight: TRealQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13VecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL13VecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13VecQuantity.*(const ALeft: TCL13VecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13VecQuantity.*(const ALeft: TCL13VecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13VecQuantity.*(const ALeft: TCL13MultivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13VecQuantity./(const ALeft: TCL13VecQuantity; const ARight: TRealQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13VecQuantity./(const ALeft: TCL13VecQuantity; const ARight: TReal): TCL13VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL13VecQuantity./(const ALeft: TRealQuantity; const ARight: TCL13VecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13VecQuantity./(const ALeft: TReal; const ARight: TCL13VecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

class operator TCL13VecQuantity./(const ALeft: TCL13VecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13VecQuantity./(const ALeft: TCL13VecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13VecQuantity./(const ALeft: TCL13MultivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13VecQuantity.:=(const AValue: TCL13Vector): TCL13VecQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;

// TCL13BivecQuantity

class operator TCL13BivecQuantity.:=(const AValue: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TCL13BivecQuantity.Explicit(const AValue: TCL13MultivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := TCL13Bivector(AValue.FValue);
end;

class operator TCL13BivecQuantity.=(const ALeft: TCL13BivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13BivecQuantity.=(const ALeft: TRealQuantity; const ARight: TCL13BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13BivecQuantity.=(const ALeft: TCL13BivecQuantity; const ARight: TCL13BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13BivecQuantity.=(const ALeft: TCL13BivecQuantity; const ARight: TCL13VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13BivecQuantity.=(const ALeft: TCL13VecQuantity; const ARight: TCL13BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13BivecQuantity.=(const ALeft: TCL13BivecQuantity; const ARight: TCL13MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13BivecQuantity.=(const ALeft: TCL13MultivecQuantity; const ARight: TCL13BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13BivecQuantity.<>(const ALeft: TCL13BivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13BivecQuantity.<>(const ALeft: TRealQuantity; const ARight: TCL13BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13BivecQuantity.<>(const ALeft: TCL13BivecQuantity; const ARight: TCL13BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13BivecQuantity.<>(const ALeft: TCL13BivecQuantity; const ARight: TCL13VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13BivecQuantity.<>(const ALeft: TCL13VecQuantity; const ARight: TCL13BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13BivecQuantity.<>(const ALeft: TCL13BivecQuantity; const ARight: TCL13MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13BivecQuantity.<>(const ALeft: TCL13MultivecQuantity; const ARight: TCL13BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13BivecQuantity.-(const AValue: TCL13BivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
end;

class operator TCL13BivecQuantity.+(const ALeft: TCL13BivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13BivecQuantity.+(const ALeft: TRealQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13BivecQuantity.+(const ALeft: TCL13BivecQuantity; const ARight: TCL13BivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13BivecQuantity.+(const ALeft: TCL13BivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13BivecQuantity.+(const ALeft: TCL13VecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13BivecQuantity.+(const ALeft: TCL13BivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13BivecQuantity.+(const ALeft: TCL13MultivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13BivecQuantity.-(const ALeft: TCL13BivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13BivecQuantity.-(const ALeft: TRealQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13BivecQuantity.-(const ALeft: TCL13BivecQuantity; const ARight: TCL13BivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13BivecQuantity.-(const ALeft: TCL13BivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13BivecQuantity.-(const ALeft: TCL13VecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13BivecQuantity.-(const ALeft: TCL13BivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13BivecQuantity.-(const ALeft: TCL13MultivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13BivecQuantity.*(const ALeft: TCL13BivecQuantity; const ARight: TRealQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13BivecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL13BivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13BivecQuantity.*(const ALeft: TCL13BivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13BivecQuantity.*(const ALeft: TCL13BivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13BivecQuantity.*(const ALeft: TCL13VecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13BivecQuantity.*(const ALeft: TCL13BivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13BivecQuantity.*(const ALeft: TCL13MultivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13BivecQuantity./(const ALeft: TCL13BivecQuantity; const ARight: TRealQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13BivecQuantity./(const ALeft: TCL13BivecQuantity; const ARight: TReal): TCL13BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL13BivecQuantity./(const ALeft: TRealQuantity; const ARight: TCL13BivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13BivecQuantity./(const ALeft: TReal; const ARight: TCL13BivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

class operator TCL13BivecQuantity./(const ALeft: TCL13BivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13BivecQuantity./(const ALeft: TCL13BivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13BivecQuantity./(const ALeft: TCL13VecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13BivecQuantity./(const ALeft: TCL13BivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13BivecQuantity./(const ALeft: TCL13MultivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13BivecQuantity.:=(const AValue: TCL13Bivector): TCL13BivecQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;

// TCL13TrivecQuantity

class operator TCL13TrivecQuantity.:=(const AValue: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TCL13TrivecQuantity.Explicit(const AValue: TCL13MultivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := TCL13Trivector(AValue.FValue);
end;

class operator TCL13TrivecQuantity.=(const ALeft: TCL13TrivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13TrivecQuantity.=(const ALeft: TRealQuantity; const ARight: TCL13TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13TrivecQuantity.=(const ALeft: TCL13TrivecQuantity; const ARight: TCL13TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13TrivecQuantity.=(const ALeft: TCL13TrivecQuantity; const ARight: TCL13VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13TrivecQuantity.=(const ALeft: TCL13VecQuantity; const ARight: TCL13TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13TrivecQuantity.=(const ALeft: TCL13TrivecQuantity; const ARight: TCL13BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13TrivecQuantity.=(const ALeft: TCL13BivecQuantity; const ARight: TCL13TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13TrivecQuantity.=(const ALeft: TCL13TrivecQuantity; const ARight: TCL13MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13TrivecQuantity.=(const ALeft: TCL13MultivecQuantity; const ARight: TCL13TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13TrivecQuantity.<>(const ALeft: TCL13TrivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13TrivecQuantity.<>(const ALeft: TRealQuantity; const ARight: TCL13TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13TrivecQuantity.<>(const ALeft: TCL13TrivecQuantity; const ARight: TCL13TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13TrivecQuantity.<>(const ALeft: TCL13TrivecQuantity; const ARight: TCL13VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13TrivecQuantity.<>(const ALeft: TCL13VecQuantity; const ARight: TCL13TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13TrivecQuantity.<>(const ALeft: TCL13TrivecQuantity; const ARight: TCL13BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13TrivecQuantity.<>(const ALeft: TCL13BivecQuantity; const ARight: TCL13TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13TrivecQuantity.<>(const ALeft: TCL13TrivecQuantity; const ARight: TCL13MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13TrivecQuantity.<>(const ALeft: TCL13MultivecQuantity; const ARight: TCL13TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13TrivecQuantity.-(const AValue: TCL13TrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
end;

class operator TCL13TrivecQuantity.+(const ALeft: TCL13TrivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13TrivecQuantity.+(const ALeft: TRealQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13TrivecQuantity.+(const ALeft: TCL13TrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13TrivecQuantity.+(const ALeft: TCL13TrivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13TrivecQuantity.+(const ALeft: TCL13VecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13TrivecQuantity.+(const ALeft: TCL13TrivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13TrivecQuantity.+(const ALeft: TCL13BivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13TrivecQuantity.+(const ALeft: TCL13TrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13TrivecQuantity.+(const ALeft: TCL13MultivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13TrivecQuantity.-(const ALeft: TCL13TrivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13TrivecQuantity.-(const ALeft: TRealQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13TrivecQuantity.-(const ALeft: TCL13TrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13TrivecQuantity.-(const ALeft: TCL13TrivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13TrivecQuantity.-(const ALeft: TCL13VecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13TrivecQuantity.-(const ALeft: TCL13TrivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13TrivecQuantity.-(const ALeft: TCL13BivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13TrivecQuantity.-(const ALeft: TCL13TrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13TrivecQuantity.-(const ALeft: TCL13MultivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13TrivecQuantity.*(const ALeft: TCL13TrivecQuantity; const ARight: TRealQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13TrivecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL13TrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13TrivecQuantity.*(const ALeft: TCL13TrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13TrivecQuantity.*(const ALeft: TCL13TrivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13TrivecQuantity.*(const ALeft: TCL13VecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13TrivecQuantity.*(const ALeft: TCL13TrivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13TrivecQuantity.*(const ALeft: TCL13BivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13TrivecQuantity.*(const ALeft: TCL13TrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13TrivecQuantity.*(const ALeft: TCL13MultivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13TrivecQuantity./(const ALeft: TCL13TrivecQuantity; const ARight: TRealQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13TrivecQuantity./(const ALeft: TCL13TrivecQuantity; const ARight: TReal): TCL13TrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL13TrivecQuantity./(const ALeft: TRealQuantity; const ARight: TCL13TrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13TrivecQuantity./(const ALeft: TReal; const ARight: TCL13TrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

class operator TCL13TrivecQuantity./(const ALeft: TCL13TrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13TrivecQuantity./(const ALeft: TCL13TrivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13TrivecQuantity./(const ALeft: TCL13VecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13TrivecQuantity./(const ALeft: TCL13TrivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13TrivecQuantity./(const ALeft: TCL13BivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13TrivecQuantity./(const ALeft: TCL13TrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13TrivecQuantity./(const ALeft: TCL13MultivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13TrivecQuantity.:=(const AValue: TCL13Trivector): TCL13TrivecQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;

// TCL13QuadrivecQuantity

class operator TCL13QuadrivecQuantity.:=(const AValue: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TCL13QuadrivecQuantity.Explicit(const AValue: TCL13MultivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := TCL13Quadrivector(AValue.FValue);
end;

class operator TCL13QuadrivecQuantity.=(const ALeft: TCL13QuadrivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.=(const ALeft: TRealQuantity; const ARight: TCL13QuadrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.=(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.=(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.=(const ALeft: TCL13VecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.=(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.=(const ALeft: TCL13BivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.=(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.=(const ALeft: TCL13TrivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.=(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.=(const ALeft: TCL13MultivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.<>(const ALeft: TCL13QuadrivecQuantity; const ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.<>(const ALeft: TRealQuantity; const ARight: TCL13QuadrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.<>(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.<>(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13VecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.<>(const ALeft: TCL13VecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.<>(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13BivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.<>(const ALeft: TCL13BivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.<>(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13TrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.<>(const ALeft: TCL13TrivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.<>(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13MultivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.<>(const ALeft: TCL13MultivecQuantity; const ARight: TCL13QuadrivecQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.-(const AValue: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
end;

class operator TCL13QuadrivecQuantity.+(const ALeft: TCL13QuadrivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.+(const ALeft: TRealQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.+(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.+(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.+(const ALeft: TCL13VecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.+(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.+(const ALeft: TCL13BivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.+(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.+(const ALeft: TCL13TrivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.+(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.+(const ALeft: TCL13MultivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.-(const ALeft: TCL13QuadrivecQuantity; const ARight: TRealQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.-(const ALeft: TRealQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.-(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.-(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.-(const ALeft: TCL13VecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.-(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.-(const ALeft: TCL13BivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.-(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.-(const ALeft: TCL13TrivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.-(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.-(const ALeft: TCL13MultivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.*(const ALeft: TCL13QuadrivecQuantity; const ARight: TRealQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.*(const ALeft: TRealQuantity; const ARight: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.*(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13QuadrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.*(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13VecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.*(const ALeft: TCL13VecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.*(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13BivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.*(const ALeft: TCL13BivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.*(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.*(const ALeft: TCL13TrivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.*(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.*(const ALeft: TCL13MultivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL13QuadrivecQuantity./(const ALeft: TCL13QuadrivecQuantity; const ARight: TRealQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13QuadrivecQuantity./(const ALeft: TCL13QuadrivecQuantity; const ARight: TReal): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TCL13QuadrivecQuantity./(const ALeft: TRealQuantity; const ARight: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13QuadrivecQuantity./(const ALeft: TReal; const ARight: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

class operator TCL13QuadrivecQuantity./(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13QuadrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13QuadrivecQuantity./(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13VecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13QuadrivecQuantity./(const ALeft: TCL13VecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13QuadrivecQuantity./(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13BivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13QuadrivecQuantity./(const ALeft: TCL13BivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13QuadrivecQuantity./(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13TrivecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13QuadrivecQuantity./(const ALeft: TCL13TrivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13QuadrivecQuantity./(const ALeft: TCL13QuadrivecQuantity; const ARight: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13QuadrivecQuantity./(const ALeft: TCL13MultivecQuantity; const ARight: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL13QuadrivecQuantity.:=(const AValue: TCL13Quadrivector): TCL13QuadrivecQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;

// TCL13MultivecQuantityHelper

function TCL13MultivecQuantityHelper.Extract(AComponents: TCL13MultivectorComponents): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL13MultivecQuantityHelper.Extract(AComponents: TCL13QuadrivectorComponents): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL13MultivecQuantityHelper.Extract(AComponents: TCL13TrivectorComponents): TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL13MultivecQuantityHelper.Extract(AComponents: TCL13BivectorComponents): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL13MultivecQuantityHelper.Extract(AComponents: TCL13VectorComponents): TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL13MultivecQuantityHelper.ExtractQuadrivector: TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractQuadrivector;
end;

function TCL13MultivecQuantityHelper.ExtractTrivector: TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractTrivector;
end;

function TCL13MultivecQuantityHelper.ExtractBivector: TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractBivector;
end;

function TCL13MultivecQuantityHelper.ExtractVector: TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractVector;
end;

function TCL13MultivecQuantityHelper.ExtractScalar: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractScalar;
end;

function TCL13MultivecQuantityHelper.SameValue(const AValue: TCL13MultivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL13MultivecQuantityHelper.SameValue(const AValue: TCL13QuadrivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL13MultivecQuantityHelper.SameValue(const AValue: TCL13TrivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL13MultivecQuantityHelper.SameValue(const AValue: TCL13BivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL13MultivecQuantityHelper.SameValue(const AValue: TCL13VecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL13MultivecQuantityHelper.SameValue(const AValue: TRealQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL13MultivecQuantityHelper.IsNull: boolean;
begin
  result := FValue.IsNull;
end;

function TCL13MultivecQuantityHelper.IsScalar: boolean;
begin
  result := FValue.IsScalar;
end;

function TCL13MultivecQuantityHelper.IsVector: boolean;
begin
  result := FValue.IsVector;
end;

function TCL13MultivecQuantityHelper.IsBivector: boolean;
begin
  result := FValue.IsBivector;
end;

function TCL13MultivecQuantityHelper.IsTrivector: boolean;
begin
  result := FValue.IsTrivector;
end;

function TCL13MultivecQuantityHelper.IsQuadrivector: boolean;
begin
  result := FValue.IsQuadrivector;
end;

function TCL13MultivecQuantityHelper.IsA: string;
begin
  result := FValue.IsA;
end;

function TCL13MultivecQuantityHelper.Norm: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL13MultivecQuantityHelper.SquaredNorm: TRealQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL13MultivecQuantityHelper.Dual: TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL13MultivecQuantityHelper.Involute: TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Involute;
end;

function TCL13MultivecQuantityHelper.Reverse: TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL13MultivecQuantityHelper.Conjugate: TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL13MultivecQuantityHelper.Inverse: TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Inverse;
end;

function TCL13MultivecQuantityHelper.GradeMask: longword;
begin
  result := FValue.GradeMask;
end;

function TCL13MultivecQuantityHelper.Normalized: TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL13MultivecQuantityHelper.Projection(const AVector: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Projection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Projection(const AVector: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Projection(const AVector: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Projection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Rejection(const AVector: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Rejection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Rejection(const AVector: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Rejection(const AVector: TCL13QuadrivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Rejection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Reflection(const AVector: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Reflection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Reflection(const AVector: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Reflection(const AVector: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Reflection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Rotation(const AVector1: TCL13VecQuantity; const AVector2: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13MultivecQuantityHelper.Rotation(const AVector1: TCL13BivecQuantity; const AVector2: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13MultivecQuantityHelper.Rotation(const AVector1: TCL13TrivecQuantity; const AVector2: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13MultivecQuantityHelper.Rotation(const AVector1: TCL13QuadrivecQuantity; const AVector2: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13MultivecQuantityHelper.Rotation(const AVector1: TCL13MultivecQuantity; const AVector2: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13MultivecQuantityHelper.Rotate(const ARotor: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, CheckMul(ARotor.FDim, ARotor.FDim));
  result.FValue := FValue.Rotate(ARotor.FValue);
end;

function TCL13MultivecQuantityHelper.Dot(const AVector: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Dot(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Dot(const AVector: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Dot(const AVector: TCL13QuadrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Dot(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Wedge(const AVector: TCL13VecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Wedge(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Wedge(const AVector: TCL13TrivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Wedge(const AVector: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13MultivecQuantityHelper.Wedge(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

// TCL13VecQuantityHelper

function TCL13VecQuantityHelper.Extract(AComponents: TCL13VectorComponents): TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL13VecQuantityHelper.ToMultivector: TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;

function TCL13VecQuantityHelper.SameValue(const AValue: TCL13MultivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL13VecQuantityHelper.SameValue(const AValue: TCL13VecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL13VecQuantityHelper.Norm: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL13VecQuantityHelper.SquaredNorm: TRealQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL13VecQuantityHelper.Dual: TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL13VecQuantityHelper.Involute: TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Involute;
end;

function TCL13VecQuantityHelper.Reverse: TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL13VecQuantityHelper.Conjugate: TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL13VecQuantityHelper.Inverse: TCL13VecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Inverse;
end;

function TCL13VecQuantityHelper.Normalized: TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL13VecQuantityHelper.Projection(const AVector: TCL13VecQuantity): TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Projection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Projection(const AVector: TCL13TrivecQuantity): TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Projection(const AVector: TCL13QuadrivecQuantity): TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Projection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Rejection(const AVector: TCL13VecQuantity): TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Rejection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Rejection(const AVector: TCL13TrivecQuantity): TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Rejection(const AVector: TCL13QuadrivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Rejection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Reflection(const AVector: TCL13VecQuantity): TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Reflection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Reflection(const AVector: TCL13TrivecQuantity): TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Reflection(const AVector: TCL13QuadrivecQuantity): TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Reflection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13VecQuantityHelper.Rotation(const AVector1: TCL13VecQuantity; const AVector2: TCL13VecQuantity): TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13VecQuantityHelper.Rotation(const AVector1: TCL13BivecQuantity; const AVector2: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13VecQuantityHelper.Rotation(const AVector1: TCL13TrivecQuantity; const AVector2: TCL13TrivecQuantity): TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13VecQuantityHelper.Rotation(const AVector1: TCL13QuadrivecQuantity; const AVector2: TCL13QuadrivecQuantity): TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13VecQuantityHelper.Rotation(const AVector1: TCL13MultivecQuantity; const AVector2: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13VecQuantityHelper.Rotate(const ARotor: TCL13MultivecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckMul(FDim, CheckMul(ARotor.FDim, ARotor.FDim));
  result.FValue := FValue.Rotate(ARotor.FValue);
end;

function TCL13VecQuantityHelper.Dot(const AVector: TCL13VecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13VecQuantityHelper.Dot(const AVector: TCL13BivecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13VecQuantityHelper.Dot(const AVector: TCL13TrivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13VecQuantityHelper.Dot(const AVector: TCL13QuadrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13VecQuantityHelper.Dot(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13VecQuantityHelper.Wedge(const AVector: TCL13VecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13VecQuantityHelper.Wedge(const AVector: TCL13BivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13VecQuantityHelper.Wedge(const AVector: TCL13TrivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13VecQuantityHelper.Wedge(const AVector: TCL13QuadrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13VecQuantityHelper.Wedge(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

// TCL13BivecQuantityHelper

function TCL13BivecQuantityHelper.Extract(AComponents: TCL13BivectorComponents): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL13BivecQuantityHelper.ToMultivector: TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;

function TCL13BivecQuantityHelper.SameValue(const AValue: TCL13MultivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL13BivecQuantityHelper.SameValue(const AValue: TCL13BivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL13BivecQuantityHelper.Norm: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL13BivecQuantityHelper.SquaredNorm: TRealQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL13BivecQuantityHelper.Dual: TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL13BivecQuantityHelper.Involute: TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Involute;
end;

function TCL13BivecQuantityHelper.Reverse: TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL13BivecQuantityHelper.Conjugate: TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL13BivecQuantityHelper.Inverse: TCL13BivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Inverse;
end;

function TCL13BivecQuantityHelper.Normalized: TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL13BivecQuantityHelper.Projection(const AVector: TCL13VecQuantity): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Projection(const AVector: TCL13BivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Projection(const AVector: TCL13TrivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Projection(const AVector: TCL13QuadrivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Projection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Rejection(const AVector: TCL13VecQuantity): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Rejection(const AVector: TCL13BivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Rejection(const AVector: TCL13TrivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Rejection(const AVector: TCL13QuadrivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Rejection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Reflection(const AVector: TCL13VecQuantity): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Reflection(const AVector: TCL13BivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Reflection(const AVector: TCL13TrivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Reflection(const AVector: TCL13QuadrivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Reflection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Rotation(const AVector1: TCL13VecQuantity; const AVector2: TCL13VecQuantity): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13BivecQuantityHelper.Rotation(const AVector1: TCL13BivecQuantity; const AVector2: TCL13BivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13BivecQuantityHelper.Rotation(const AVector1: TCL13TrivecQuantity; const AVector2: TCL13TrivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13BivecQuantityHelper.Rotation(const AVector1: TCL13QuadrivecQuantity; const AVector2: TCL13QuadrivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13BivecQuantityHelper.Rotation(const AVector1: TCL13MultivecQuantity; const AVector2: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13BivecQuantityHelper.Rotate(const ARotor: TCL13MultivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckMul(FDim, CheckMul(ARotor.FDim, ARotor.FDim));
  result.FValue := FValue.Rotate(ARotor.FValue);
end;

function TCL13BivecQuantityHelper.Dot(const AVector: TCL13VecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Dot(const AVector: TCL13BivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Dot(const AVector: TCL13TrivecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Dot(const AVector: TCL13QuadrivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Dot(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Wedge(const AVector: TCL13VecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Wedge(const AVector: TCL13BivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Wedge(const AVector: TCL13TrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Wedge(const AVector: TCL13QuadrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13BivecQuantityHelper.Wedge(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

// TCL13TrivecQuantityHelper

function TCL13TrivecQuantityHelper.Extract(AComponents: TCL13TrivectorComponents): TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL13TrivecQuantityHelper.ToMultivector: TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;

function TCL13TrivecQuantityHelper.SameValue(const AValue: TCL13MultivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL13TrivecQuantityHelper.SameValue(const AValue: TCL13TrivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL13TrivecQuantityHelper.Norm: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL13TrivecQuantityHelper.SquaredNorm: TRealQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL13TrivecQuantityHelper.Dual: TCL13VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL13TrivecQuantityHelper.Involute: TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Involute;
end;

function TCL13TrivecQuantityHelper.Reverse: TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL13TrivecQuantityHelper.Conjugate: TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL13TrivecQuantityHelper.Inverse: TCL13TrivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Inverse;
end;

function TCL13TrivecQuantityHelper.Normalized: TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL13TrivecQuantityHelper.Projection(const AVector: TCL13VecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Projection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Projection(const AVector: TCL13TrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Projection(const AVector: TCL13QuadrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Projection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Rejection(const AVector: TCL13VecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Rejection(const AVector: TCL13BivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Rejection(const AVector: TCL13TrivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Rejection(const AVector: TCL13QuadrivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Rejection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Reflection(const AVector: TCL13VecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Reflection(const AVector: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Reflection(const AVector: TCL13TrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Reflection(const AVector: TCL13QuadrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Reflection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Rotation(const AVector1: TCL13VecQuantity; const AVector2: TCL13VecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13TrivecQuantityHelper.Rotation(const AVector1: TCL13BivecQuantity; const AVector2: TCL13BivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13TrivecQuantityHelper.Rotation(const AVector1: TCL13TrivecQuantity; const AVector2: TCL13TrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13TrivecQuantityHelper.Rotation(const AVector1: TCL13QuadrivecQuantity; const AVector2: TCL13QuadrivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13TrivecQuantityHelper.Rotation(const AVector1: TCL13MultivecQuantity; const AVector2: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13TrivecQuantityHelper.Rotate(const ARotor: TCL13MultivecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, CheckMul(ARotor.FDim, ARotor.FDim));
  result.FValue := FValue.Rotate(ARotor.FValue);
end;

function TCL13TrivecQuantityHelper.Dot(const AVector: TCL13VecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Dot(const AVector: TCL13BivecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Dot(const AVector: TCL13TrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Dot(const AVector: TCL13QuadrivecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Dot(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Wedge(const AVector: TCL13VecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Wedge(const AVector: TCL13BivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Wedge(const AVector: TCL13TrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Wedge(const AVector: TCL13QuadrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13TrivecQuantityHelper.Wedge(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

// TCL13QuadrivecQuantityHelper

function TCL13QuadrivecQuantityHelper.Extract(AComponents: TCL13QuadrivectorComponents): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Extract(AComponents);
end;

function TCL13QuadrivecQuantityHelper.ToMultivector: TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;

function TCL13QuadrivecQuantityHelper.SameValue(const AValue: TCL13MultivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL13QuadrivecQuantityHelper.SameValue(const AValue: TCL13QuadrivecQuantity): boolean;
begin
  Check(FDim, AValue.FDim);
  result := FValue.SameValue(AValue.FValue);
end;

function TCL13QuadrivecQuantityHelper.Norm: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL13QuadrivecQuantityHelper.SquaredNorm: TRealQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL13QuadrivecQuantityHelper.Dual: TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL13QuadrivecQuantityHelper.Involute: TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Involute;
end;

function TCL13QuadrivecQuantityHelper.Reverse: TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL13QuadrivecQuantityHelper.Conjugate: TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL13QuadrivecQuantityHelper.Inverse: TCL13QuadrivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Inverse;
end;

function TCL13QuadrivecQuantityHelper.Normalized: TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL13QuadrivecQuantityHelper.Projection(const AVector: TCL13VecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Projection(const AVector: TCL13BivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Projection(const AVector: TCL13TrivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Projection(const AVector: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Projection(const AVector: TCL13MultivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Rejection(const AVector: TCL13VecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Rejection(const AVector: TCL13BivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Rejection(const AVector: TCL13TrivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Rejection(const AVector: TCL13QuadrivecQuantity): TRealQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Rejection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Reflection(const AVector: TCL13VecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Reflection(const AVector: TCL13BivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Reflection(const AVector: TCL13TrivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Reflection(const AVector: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Reflection(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Rotation(const AVector1: TCL13VecQuantity; const AVector2: TCL13VecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13QuadrivecQuantityHelper.Rotation(const AVector1: TCL13BivecQuantity; const AVector2: TCL13BivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13QuadrivecQuantityHelper.Rotation(const AVector1: TCL13TrivecQuantity; const AVector2: TCL13TrivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13QuadrivecQuantityHelper.Rotation(const AVector1: TCL13QuadrivecQuantity; const AVector2: TCL13QuadrivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13QuadrivecQuantityHelper.Rotation(const AVector1: TCL13MultivecQuantity; const AVector2: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL13QuadrivecQuantityHelper.Rotate(const ARotor: TCL13MultivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckMul(FDim, CheckMul(ARotor.FDim, ARotor.FDim));
  result.FValue := FValue.Rotate(ARotor.FValue);
end;

function TCL13QuadrivecQuantityHelper.Dot(const AVector: TCL13VecQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Dot(const AVector: TCL13BivecQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Dot(const AVector: TCL13TrivecQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Dot(const AVector: TCL13QuadrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Dot(const AVector: TCL13MultivecQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Wedge(const AVector: TCL13VecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Wedge(const AVector: TCL13BivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Wedge(const AVector: TCL13TrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Wedge(const AVector: TCL13QuadrivecQuantity): TRealQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL13QuadrivecQuantityHelper.Wedge(const AVector: TCL13MultivecQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

{$ENDIF}

{$IFNDEF ADIMOFF}
operator *(const ALeft: TCL2Multivector; const ARight: TRealQuantity): TCL2MultivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL2Multivector): TCL2MultivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator /(const ALeft: TCL2Multivector; const ARight: TRealQuantity): TCL2MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

operator /(const ALeft: TRealQuantity; const ARight: TCL2Multivector): TCL2MultivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

operator *(const ALeft: TCL2Vector; const ARight: TRealQuantity): TCL2VecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL2Vector): TCL2VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator /(const ALeft: TCL2Vector; const ARight: TRealQuantity): TCL2VecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

operator /(const ALeft: TRealQuantity; const ARight: TCL2Vector): TCL2VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

operator *(const ALeft: TCL2Bivector; const ARight: TRealQuantity): TCL2BivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL2Bivector): TCL2BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator /(const ALeft: TCL2Bivector; const ARight: TRealQuantity): TCL2BivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

operator /(const ALeft: TRealQuantity; const ARight: TCL2Bivector): TCL2BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL2Versor1): TCL2VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL2Versor1; const ARight: TRealQuantity): TCL2VecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL2Versor2): TCL2VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL2Versor2; const ARight: TRealQuantity): TCL2VecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL2Biversor12): TCL2BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL2Biversor12; const ARight: TRealQuantity): TCL2BivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TCL3Multivector; const ARight: TRealQuantity): TCL3MultivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL3Multivector): TCL3MultivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator /(const ALeft: TCL3Multivector; const ARight: TRealQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

operator /(const ALeft: TRealQuantity; const ARight: TCL3Multivector): TCL3MultivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

operator *(const ALeft: TCL3Vector; const ARight: TRealQuantity): TCL3VecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL3Vector): TCL3VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator /(const ALeft: TCL3Vector; const ARight: TRealQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

operator /(const ALeft: TRealQuantity; const ARight: TCL3Vector): TCL3VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

operator *(const ALeft: TCL3Bivector; const ARight: TRealQuantity): TCL3BivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL3Bivector): TCL3BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator /(const ALeft: TCL3Bivector; const ARight: TRealQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

operator /(const ALeft: TRealQuantity; const ARight: TCL3Bivector): TCL3BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

operator *(const ALeft: TCL3Trivector; const ARight: TRealQuantity): TCL3TrivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL3Trivector): TCL3TrivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator /(const ALeft: TCL3Trivector; const ARight: TRealQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

operator /(const ALeft: TRealQuantity; const ARight: TCL3Trivector): TCL3TrivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL3Versor1): TCL3VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL3Versor1; const ARight: TRealQuantity): TCL3VecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL3Versor2): TCL3VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL3Versor2; const ARight: TRealQuantity): TCL3VecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL3Versor3): TCL3VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL3Versor3; const ARight: TRealQuantity): TCL3VecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL3Biversor12): TCL3BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL3Biversor12; const ARight: TRealQuantity): TCL3BivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL3Biversor13): TCL3BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL3Biversor13; const ARight: TRealQuantity): TCL3BivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL3Biversor23): TCL3BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL3Biversor23; const ARight: TRealQuantity): TCL3BivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL3Triversor123): TCL3TrivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL3Triversor123; const ARight: TRealQuantity): TCL3TrivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TCL13Multivector; const ARight: TRealQuantity): TCL13MultivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Multivector): TCL13MultivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator /(const ALeft: TCL13Multivector; const ARight: TRealQuantity): TCL13MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

operator /(const ALeft: TRealQuantity; const ARight: TCL13Multivector): TCL13MultivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

operator *(const ALeft: TCL13Vector; const ARight: TRealQuantity): TCL13VecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Vector): TCL13VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator /(const ALeft: TCL13Vector; const ARight: TRealQuantity): TCL13VecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

operator /(const ALeft: TRealQuantity; const ARight: TCL13Vector): TCL13VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

operator *(const ALeft: TCL13Bivector; const ARight: TRealQuantity): TCL13BivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Bivector): TCL13BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator /(const ALeft: TCL13Bivector; const ARight: TRealQuantity): TCL13BivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

operator /(const ALeft: TRealQuantity; const ARight: TCL13Bivector): TCL13BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

operator *(const ALeft: TCL13Trivector; const ARight: TRealQuantity): TCL13TrivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Trivector): TCL13TrivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator /(const ALeft: TCL13Trivector; const ARight: TRealQuantity): TCL13TrivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

operator /(const ALeft: TRealQuantity; const ARight: TCL13Trivector): TCL13TrivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

operator *(const ALeft: TCL13Quadrivector; const ARight: TRealQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Quadrivector): TCL13QuadrivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator /(const ALeft: TCL13Quadrivector; const ARight: TRealQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

operator /(const ALeft: TRealQuantity; const ARight: TCL13Quadrivector): TCL13QuadrivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue / ARight;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Versor0): TCL13VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Versor0; const ARight: TRealQuantity): TCL13VecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Versor1): TCL13VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Versor1; const ARight: TRealQuantity): TCL13VecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Versor2): TCL13VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Versor2; const ARight: TRealQuantity): TCL13VecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Versor3): TCL13VecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Versor3; const ARight: TRealQuantity): TCL13VecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Biversor01): TCL13BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Biversor01; const ARight: TRealQuantity): TCL13BivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Biversor02): TCL13BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Biversor02; const ARight: TRealQuantity): TCL13BivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Biversor03): TCL13BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Biversor03; const ARight: TRealQuantity): TCL13BivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Biversor12): TCL13BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Biversor12; const ARight: TRealQuantity): TCL13BivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Biversor13): TCL13BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Biversor13; const ARight: TRealQuantity): TCL13BivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Biversor23): TCL13BivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Biversor23; const ARight: TRealQuantity): TCL13BivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Triversor012): TCL13TrivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Triversor012; const ARight: TRealQuantity): TCL13TrivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Triversor013): TCL13TrivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Triversor013; const ARight: TRealQuantity): TCL13TrivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Triversor023): TCL13TrivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Triversor023; const ARight: TRealQuantity): TCL13TrivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Triversor123): TCL13TrivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Triversor123; const ARight: TRealQuantity): TCL13TrivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
end;

operator *(const ALeft: TRealQuantity; const ARight: TCL13Quadriversor0123): TCL13QuadrivecQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue := ALeft.FValue * ARight;
end;

operator *(const ALeft: TCL13Quadriversor0123; const ARight: TRealQuantity): TCL13QuadrivecQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue := ALeft * ARight.FValue;
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

function QuinticPower(const AQuantity: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := 5 * AQuantity.FDim;
  result.FValue := ADimMath.QuinticPower(AQuantity.FValue);
end;

function SexticPower(const AQuantity: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := 6 * AQuantity.FDim;
  result.FValue := ADimMath.SexticPower(AQuantity.FValue);
end;
{$ENDIF}

{$IFNDEF ADIMOFF}
function SameValueEx(const ALeft, ARight: TRealQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ADimMath.SameValueEx(ALeft.FValue, ARight.FValue);
end;

function SameValueEx(const ALeft, ARight: TComplexQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ADimMath.SameValueEx(ALeft.FValue, ARight.FValue);
end;

function Abs(const AQuantity: TRealQuantity): TRealQuantity;
begin
  result.FDim := AQuantity.FDim;
  result.FValue := System.Abs(AQuantity.FValue);
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

class operator TUnit.*(const ASelf: TUnit; const AQuantity: TRealQuantity): TRealQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckMul(ASelf.FDim, AQuantity.FDim);
  result.FValue := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const ASelf: TUnit; const AQuantity: TRealQuantity): TRealQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ASelf.FDim, AQuantity.FDim);
  result.FValue := 1 / AQuantity.FValue;
{$ELSE}
  result := 1 / AQuantity;
{$ENDIF}
end;

class operator TUnit.*(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckMul(ASelf.FDim, AQuantity.FDim);
  result.FValue := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const ASelf: TUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ASelf.FDim, AQuantity.FDim);
  result.FValue := AQuantity.FValue.Reciprocal;
{$ELSE}
  result := AQuantity.Reciprocal;
{$ENDIF}
end;

class operator TUnit.*(const AValue: TCL2Multivector; const ASelf: TUnit): TCL2MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TCL2Multivector; const ASelf: TUnit): TCL2MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit.*(const AValue: TCL2Vector; const ASelf: TUnit): TCL2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TCL2Vector; const ASelf: TUnit): TCL2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit.*(const AValue: TCL2Bivector; const ASelf: TUnit): TCL2BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TCL2Bivector; const ASelf: TUnit): TCL2BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit.*(const AValue: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TCL3Multivector; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit.*(const AValue: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TCL3Vector; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit.*(const AValue: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TCL3Bivector; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit.*(const AValue: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TCL3Trivector; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit.*(const AValue: TCL13Multivector; const ASelf: TUnit): TCL13MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TCL13Multivector; const ASelf: TUnit): TCL13MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit.*(const AValue: TCL13Vector; const ASelf: TUnit): TCL13VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TCL13Vector; const ASelf: TUnit): TCL13VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit.*(const AValue: TCL13Bivector; const ASelf: TUnit): TCL13BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TCL13Bivector; const ASelf: TUnit): TCL13BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit.*(const AValue: TCL13Trivector; const ASelf: TUnit): TCL13TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TCL13Trivector; const ASelf: TUnit): TCL13TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit.*(const AValue: TCL13Quadrivector; const ASelf: TUnit): TCL13QuadrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: TCL13Quadrivector; const ASelf: TUnit): TCL13QuadrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AValue;
{$ELSE}
  result := AValue;
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

class operator TUnit.*(const AQuantity: TCL2MultivecQuantity; const ASelf: TUnit): TCL2MultivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL2MultivecQuantity; const ASelf: TUnit): TCL2MultivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL2VecQuantity; const ASelf: TUnit): TCL2VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL2VecQuantity; const ASelf: TUnit): TCL2VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL2BivecQuantity; const ASelf: TUnit): TCL2BivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL2BivecQuantity; const ASelf: TUnit): TCL2BivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3MultivecQuantity; const ASelf: TUnit): TCL3MultivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3VecQuantity; const ASelf: TUnit): TCL3VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3BivecQuantity; const ASelf: TUnit): TCL3BivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL3TrivecQuantity; const ASelf: TUnit): TCL3TrivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL13MultivecQuantity; const ASelf: TUnit): TCL13MultivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL13MultivecQuantity; const ASelf: TUnit): TCL13MultivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL13VecQuantity; const ASelf: TUnit): TCL13VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL13VecQuantity; const ASelf: TUnit): TCL13VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL13BivecQuantity; const ASelf: TUnit): TCL13BivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL13BivecQuantity; const ASelf: TUnit): TCL13BivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL13TrivecQuantity; const ASelf: TUnit): TCL13TrivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL13TrivecQuantity; const ASelf: TUnit): TCL13TrivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit.*(const AQuantity: TCL13QuadrivecQuantity; const ASelf: TUnit): TCL13QuadrivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TCL13QuadrivecQuantity; const ASelf: TUnit): TCL13QuadrivecQuantity; inline;
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

class operator TFactoredUnit.*(const ASelf: TFactoredUnit; const AQuantity: TRealQuantity): TRealQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckMul(ASelf.FDim, AQuantity.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const ASelf: TFactoredUnit; const AQuantity: TRealQuantity): TRealQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ASelf.FDim, AQuantity.FDim);
  result.FValue := ASelf.FFactor / AQuantity.FValue;
{$ELSE}
  result := ASelf.FFactor / AQuantity;
{$ENDIF}
end;

class operator TFactoredUnit.*(const ASelf: TFactoredUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckMul(ASelf.FDim, AQuantity.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const ASelf: TFactoredUnit; const AQuantity: TComplexQuantity): TComplexQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ASelf.FDim, AQuantity.FDim);
  result.FValue := ASelf.FFactor * AQuantity.FValue.Reciprocal;
{$ELSE}
  result := ASelf.FFactor * AQuantity.Reciprocal;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL2Multivector; const ASelf: TFactoredUnit): TCL2MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL2Multivector; const ASelf: TFactoredUnit): TCL2MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL2Vector; const ASelf: TFactoredUnit): TCL2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL2Vector; const ASelf: TFactoredUnit): TCL2VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL2Bivector; const ASelf: TFactoredUnit): TCL2BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL2Bivector; const ASelf: TFactoredUnit): TCL2BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
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

class operator TFactoredUnit./(const AQuantity: TCL3Multivector; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
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

class operator TFactoredUnit./(const AQuantity: TCL3Vector; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
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

class operator TFactoredUnit./(const AQuantity: TCL3Bivector; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
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

class operator TFactoredUnit./(const AQuantity: TCL3Trivector; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL13Multivector; const ASelf: TFactoredUnit): TCL13MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL13Multivector; const ASelf: TFactoredUnit): TCL13MultivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL13Vector; const ASelf: TFactoredUnit): TCL13VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL13Vector; const ASelf: TFactoredUnit): TCL13VecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL13Bivector; const ASelf: TFactoredUnit): TCL13BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL13Bivector; const ASelf: TFactoredUnit): TCL13BivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL13Trivector; const ASelf: TFactoredUnit): TCL13TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL13Trivector; const ASelf: TFactoredUnit): TCL13TrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := CheckDiv(ScalarUnit.FDim, ASelf.FDim);
  result.FValue := AQuantity / ASelf.FFactor;
{$ELSE}
  result := AQuantity / ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit.*(const AQuantity: TCL13Quadrivector; const ASelf: TFactoredUnit): TCL13QuadrivecQuantity; inline;
begin
{$IFNDEF ADIMOFF}
  result.FDim := ASelf.FDim;
  result.FValue := AQuantity * ASelf.FFactor;
{$ELSE}
  result := AQuantity * ASelf.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: TCL13Quadrivector; const ASelf: TFactoredUnit): TCL13QuadrivecQuantity; inline;
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

class operator TFactoredUnit.*(const AQuantity: TCL2MultivecQuantity; const ASelf: TFactoredUnit): TCL2MultivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL2MultivecQuantity; const ASelf: TFactoredUnit): TCL2MultivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL2VecQuantity; const ASelf: TFactoredUnit): TCL2VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL2VecQuantity; const ASelf: TFactoredUnit): TCL2VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL2BivecQuantity; const ASelf: TFactoredUnit): TCL2BivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL2BivecQuantity; const ASelf: TFactoredUnit): TCL2BivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3MultivecQuantity; const ASelf: TFactoredUnit): TCL3MultivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3VecQuantity; const ASelf: TFactoredUnit): TCL3VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3BivecQuantity; const ASelf: TFactoredUnit): TCL3BivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL3TrivecQuantity; const ASelf: TFactoredUnit): TCL3TrivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL13MultivecQuantity; const ASelf: TFactoredUnit): TCL13MultivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL13MultivecQuantity; const ASelf: TFactoredUnit): TCL13MultivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL13VecQuantity; const ASelf: TFactoredUnit): TCL13VecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL13VecQuantity; const ASelf: TFactoredUnit): TCL13VecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL13BivecQuantity; const ASelf: TFactoredUnit): TCL13BivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL13BivecQuantity; const ASelf: TFactoredUnit): TCL13BivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL13TrivecQuantity; const ASelf: TFactoredUnit): TCL13TrivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL13TrivecQuantity; const ASelf: TFactoredUnit): TCL13TrivecQuantity; inline;
begin
  result.FDim := CheckDiv(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue / ASelf.FFactor;
end;

class operator TFactoredUnit.*(const AQuantity: TCL13QuadrivecQuantity; const ASelf: TFactoredUnit): TCL13QuadrivecQuantity; inline;
begin
  result.FDim := CheckMul(AQuantity.FDim, ASelf.FDim);
  result.FValue := AQuantity.FValue * ASelf.FFactor;
end;

class operator TFactoredUnit./(const AQuantity: TCL13QuadrivecQuantity; const ASelf: TFactoredUnit): TCL13QuadrivecQuantity; inline;
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

function TUnitHelper.GetValue(const AQuantity: TCL2Multivector; const APrefixes: TPrefixes): TCL2Multivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL2Vector; const APrefixes: TPrefixes): TCL2Vector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL2Bivector; const APrefixes: TPrefixes): TCL2Bivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL3Multivector; const APrefixes: TPrefixes): TCL3Multivector;
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

function TUnitHelper.GetValue(const AQuantity: TCL13Multivector; const APrefixes: TPrefixes): TCL13Multivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL13Vector; const APrefixes: TPrefixes): TCL13Vector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL13Bivector; const APrefixes: TPrefixes): TCL13Bivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL13Trivector; const APrefixes: TPrefixes): TCL13Trivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TUnitHelper.GetValue(const AQuantity: TCL13Quadrivector; const APrefixes: TPrefixes): TCL13Quadrivector;
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
     result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
  else
    result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes);
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
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(FPrefixes)
  else
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
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
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(FPrefixes)
  else
    result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
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
  result := AQuantity.FValue.ToString + ' ' + GetPluralName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetPluralName(FPrefixes)
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

function TUnitHelper.ToString(const AQuantity: TRealVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TRealVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
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
  result := AQuantity.FValue.ToString + ' ' + GetPluralName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetPluralName(FPrefixes)
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

function TUnitHelper.ToString(const AQuantity: TComplexVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TComplexVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
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
  result := AQuantity.FValue.ToString + ' ' + GetPluralName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetPluralName(FPrefixes)
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

function TUnitHelper.ToString(const AQuantity: TRealMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TRealMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
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
  result := AQuantity.FValue.ToString + ' ' + GetPluralName(FPrefixes)
{$ELSE}
  result := AQuantity.ToString + ' ' + GetPluralName(FPrefixes)
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

function TUnitHelper.ToString(const AQuantity: TComplexMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TComplexMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TCL2MultivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL2MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL2MultivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetPluralName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL2MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TUnitHelper.ToMultivector(const AQuantity: TCL2MultivecQuantity): TCL2Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMultivector(const AQuantity: TCL2MultivecQuantity; const APrefixes: TPrefixes): TCL2Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL2MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL2MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TCL2VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL2VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetPluralName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TUnitHelper.ToVector(const AQuantity: TCL2VecQuantity): TCL2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TCL2VecQuantity; const APrefixes: TPrefixes): TCL2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL2VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL2VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TCL2BivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL2BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL2BivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetPluralName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL2BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TUnitHelper.ToBivector(const AQuantity: TCL2BivecQuantity): TCL2Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToBivector(const AQuantity: TCL2BivecQuantity; const APrefixes: TPrefixes): TCL2Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL2BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL2BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TCL3MultivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
{$ENDIF}
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
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3MultivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetPluralName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetPluralName(FPrefixes)
{$ENDIF}
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
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TUnitHelper.ToMultivector(const AQuantity: TCL3MultivecQuantity): TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMultivector(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TCL3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
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
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetPluralName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetPluralName(FPrefixes)
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
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TUnitHelper.ToVector(const AQuantity: TCL3VecQuantity): TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TCL3BivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
{$ENDIF}
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
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3BivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetPluralName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetPluralName(FPrefixes)
{$ENDIF}
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
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TUnitHelper.ToBivector(const AQuantity: TCL3BivecQuantity): TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToBivector(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TCL3TrivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
{$ENDIF}
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
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3TrivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetPluralName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetPluralName(FPrefixes)
{$ENDIF}
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
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TUnitHelper.ToTrivector(const AQuantity: TCL3TrivecQuantity): TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToTrivector(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL3TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL3TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TCL13MultivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL13MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13MultivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetPluralName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TUnitHelper.ToMultivector(const AQuantity: TCL13MultivecQuantity): TCL13Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToMultivector(const AQuantity: TCL13MultivecQuantity; const APrefixes: TPrefixes): TCL13Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL13MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TCL13VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL13VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13VecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetPluralName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TUnitHelper.ToVector(const AQuantity: TCL13VecQuantity): TCL13Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToVector(const AQuantity: TCL13VecQuantity; const APrefixes: TPrefixes): TCL13Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL13VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TCL13BivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL13BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13BivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetPluralName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TUnitHelper.ToBivector(const AQuantity: TCL13BivecQuantity): TCL13Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToBivector(const AQuantity: TCL13BivecQuantity; const APrefixes: TPrefixes): TCL13Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL13BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TCL13TrivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL13TrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13TrivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetPluralName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13TrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TUnitHelper.ToTrivector(const AQuantity: TCL13TrivecQuantity): TCL13Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToTrivector(const AQuantity: TCL13TrivecQuantity; const APrefixes: TPrefixes): TCL13Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL13TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TUnitHelper.ToString(const AQuantity: TCL13QuadrivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetSymbol(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetSymbol(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL13QuadrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Quadrivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13QuadrivecQuantity): string;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := '(' + AQuantity.FValue.ToString + ') ' + GetPluralName(FPrefixes)
{$ELSE}
  result := '(' + AQuantity.ToString + ') ' + GetPluralName(FPrefixes)
{$ENDIF}
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13QuadrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Quadrivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TUnitHelper.ToQuadrivector(const AQuantity: TCL13QuadrivecQuantity): TCL13Quadrivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnitHelper.ToQuadrivector(const AQuantity: TCL13QuadrivecQuantity; const APrefixes: TPrefixes): TCL13Quadrivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnitHelper.ToString(const AQuantity: TCL13QuadrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Quadrivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TUnitHelper.ToVerboseString(const AQuantity: TCL13QuadrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Quadrivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
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

function TFactoredUnitHelper.GetValue(const AQuantity: TCL2Multivector; const APrefixes: TPrefixes): TCL2Multivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL2Vector; const APrefixes: TPrefixes): TCL2Vector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL2Bivector; const APrefixes: TPrefixes): TCL2Bivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL3Multivector; const APrefixes: TPrefixes): TCL3Multivector;
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

function TFactoredUnitHelper.GetValue(const AQuantity: TCL13Multivector; const APrefixes: TPrefixes): TCL13Multivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL13Vector; const APrefixes: TPrefixes): TCL13Vector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL13Bivector; const APrefixes: TPrefixes): TCL13Bivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL13Trivector; const APrefixes: TPrefixes): TCL13Trivector;
begin
  result := AQuantity * GetValue(1, APrefixes);
end;

function TFactoredUnitHelper.GetValue(const AQuantity: TCL13Quadrivector; const APrefixes: TPrefixes): TCL13Quadrivector;
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
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
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

function TFactoredUnitHelper.ToString(const AQuantity: TRealVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TRealVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
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

function TFactoredUnitHelper.ToString(const AQuantity: TComplexVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TComplexVectorQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexVector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
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

function TFactoredUnitHelper.ToString(const AQuantity: TRealMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TRealMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TRealMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
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

function TFactoredUnitHelper.ToString(const AQuantity: TComplexMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TComplexMatrixQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TComplexMatrix;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := FactoredValue.ToString(APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL2MultivecQuantity): string;
var
  FactoredValue: TCL2Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL2MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL2MultivecQuantity): string;
var
  FactoredValue: TCL2Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL2MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TFactoredUnitHelper.ToMultivector(const AQuantity: TCL2MultivecQuantity): TCL2Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMultivector(const AQuantity: TCL2MultivecQuantity; const APrefixes: TPrefixes): TCL2Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL2MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL2MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL2VecQuantity): string;
var
  FactoredValue: TCL2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL2VecQuantity): string;
var
  FactoredValue: TCL2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL2VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TCL2VecQuantity): TCL2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TCL2VecQuantity; const APrefixes: TPrefixes): TCL2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL2VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL2VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL2BivecQuantity): string;
var
  FactoredValue: TCL2Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL2BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL2BivecQuantity): string;
var
  FactoredValue: TCL2Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL2BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TFactoredUnitHelper.ToBivector(const AQuantity: TCL2BivecQuantity): TCL2Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToBivector(const AQuantity: TCL2BivecQuantity; const APrefixes: TPrefixes): TCL2Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL2BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL2BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL2Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
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
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
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
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
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
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
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
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TFactoredUnitHelper.ToMultivector(const AQuantity: TCL3MultivecQuantity): TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMultivector(const AQuantity: TCL3MultivecQuantity; const APrefixes: TPrefixes): TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
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
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
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
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
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
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
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
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TCL3VecQuantity): TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TCL3VecQuantity; const APrefixes: TPrefixes): TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
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
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
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
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
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
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
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
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TFactoredUnitHelper.ToBivector(const AQuantity: TCL3BivecQuantity): TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToBivector(const AQuantity: TCL3BivecQuantity; const APrefixes: TPrefixes): TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
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
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
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
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
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
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
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
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TFactoredUnitHelper.ToTrivector(const AQuantity: TCL3TrivecQuantity): TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToTrivector(const AQuantity: TCL3TrivecQuantity; const APrefixes: TPrefixes): TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL3TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL3TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL3Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13MultivecQuantity): string;
var
  FactoredValue: TCL13Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13MultivecQuantity): string;
var
  FactoredValue: TCL13Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13MultivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TFactoredUnitHelper.ToMultivector(const AQuantity: TCL13MultivecQuantity): TCL13Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToMultivector(const AQuantity: TCL13MultivecQuantity; const APrefixes: TPrefixes): TCL13Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13MultivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Multivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13VecQuantity): string;
var
  FactoredValue: TCL13Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13VecQuantity): string;
var
  FactoredValue: TCL13Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13VecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TCL13VecQuantity): TCL13Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToVector(const AQuantity: TCL13VecQuantity; const APrefixes: TPrefixes): TCL13Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13VecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Vector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13BivecQuantity): string;
var
  FactoredValue: TCL13Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13BivecQuantity): string;
var
  FactoredValue: TCL13Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13BivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TFactoredUnitHelper.ToBivector(const AQuantity: TCL13BivecQuantity): TCL13Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToBivector(const AQuantity: TCL13BivecQuantity; const APrefixes: TPrefixes): TCL13Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13BivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Bivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13TrivecQuantity): string;
var
  FactoredValue: TCL13Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13TrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13TrivecQuantity): string;
var
  FactoredValue: TCL13Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13TrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TFactoredUnitHelper.ToTrivector(const AQuantity: TCL13TrivecQuantity): TCL13Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToTrivector(const AQuantity: TCL13TrivecQuantity; const APrefixes: TPrefixes): TCL13Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13TrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Trivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13QuadrivecQuantity): string;
var
  FactoredValue: TCL13Quadrivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(FPrefixes)
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13QuadrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Quadrivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetSymbol(APrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13QuadrivecQuantity): string;
var
  FactoredValue: TCL13Quadrivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := AQuantity.FValue / FFactor;
{$ELSE}
  FactoredValue := AQuantity / FFactor;
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(FPrefixes)
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13QuadrivecQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Quadrivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString + ') ' + GetPluralName(APrefixes)
end;

function TFactoredUnitHelper.ToQuadrivector(const AQuantity: TCL13QuadrivecQuantity): TCL13Quadrivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := AQuantity.FValue / FFactor;
{$ELSE}
  result := AQuantity / FFactor;
{$ENDIF}
end;

function TFactoredUnitHelper.ToQuadrivector(const AQuantity: TCL13QuadrivecQuantity; const APrefixes: TPrefixes): TCL13Quadrivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  result := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
end;

function TFactoredUnitHelper.ToString(const AQuantity: TCL13QuadrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Quadrivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetSymbol(APrefixes);
end;

function TFactoredUnitHelper.ToVerboseString(const AQuantity: TCL13QuadrivecQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: TCL13Quadrivector;
begin
{$IFNDEF ADIMOFF}
  Check(FDim, AQuantity.FDim);
  FactoredValue := GetValue(AQuantity.FValue / FFactor, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity / FFactor, APrefixes);
{$ENDIF}
  result := '(' + FactoredValue.ToString(APrecision, ADigits) + ') ' + GetPluralName(APrefixes);
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

end.

