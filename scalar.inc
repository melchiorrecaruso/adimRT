
  (**
    Represents a physical quantity with dimension checking at runtime.

    Combines a @code(double) value with a @link(TDimension), ensuring that
    arithmetic operations are dimensionally consistent. Incompatible dimensions
    raise an exception at runtime.
    When the symbol @code(ADIMOFF) is defined, this type degenerates to @code(double)
    and all dimension checking is disabled.
  *)
  {$IFNDEF ADIMOFF}
  TQuantity = record
  private
    FDim: TDimension;
    FValue: double;
  public
    (**
      Returns the reciprocal of the quantity: @code(1 / self).
      The resulting dimension is the inverse of the original dimension.
    *)
    function Reciprocal: TQuantity;

    (** Unary plus. Returns the quantity unchanged. *)
    class operator +(const ASelf: TQuantity): TQuantity;

    (** Unary minus. Returns the negation of the quantity. *)
    class operator -(const ASelf: TQuantity): TQuantity;

    (** Returns the sum of two quantities. Both operands must have the same dimension. *)
    class operator +(const ALeft, ARight: TQuantity): TQuantity;

    (** Returns the difference of two quantities. Both operands must have the same dimension. *)
    class operator -(const ALeft, ARight: TQuantity): TQuantity;

    (** Returns the product of two quantities. The resulting dimension is the product of the two dimensions. *)
    class operator *(const ALeft, ARight: TQuantity): TQuantity;

    (** Returns the product of a dimensionless real scalar and a quantity. The dimension is preserved. *)
    class operator *(const ALeft: double; const ARight: TQuantity): TQuantity;

    (** Returns the product of a quantity and a dimensionless real scalar. The dimension is preserved. *)
    class operator *(const ALeft: TQuantity; const ARight: double): TQuantity;

    (** Returns the quotient of two quantities. The resulting dimension is the ratio of the two dimensions. *)
    class operator /(const ALeft, ARight: TQuantity): TQuantity;

    (**
      Returns the quotient of a dimensionless real scalar divided by a quantity.
      The resulting dimension is the inverse of @code(ARight).
    *)
    class operator /(const ALeft: double; const ARight: TQuantity): TQuantity;

    (** Returns the quotient of a quantity divided by a dimensionless real scalar. The dimension is preserved. *)
    class operator /(const ALeft: TQuantity; const ARight: double): TQuantity;

    (** Returns @true if both operands have the same dimension and equal values. *)
    class operator =(const ALeft, ARight: TQuantity): boolean;

    (** Returns @true if @code(ALeft) is dimensionally compatible with @code(ARight) and its value is strictly less. *)
    class operator <(const ALeft, ARight: TQuantity): boolean;

    (** Returns @true if @code(ALeft) is dimensionally compatible with @code(ARight) and its value is strictly greater. *)
    class operator >(const ALeft, ARight: TQuantity): boolean;

    (** Returns @true if @code(ALeft) is dimensionally compatible with @code(ARight) and its value is less than or equal. *)
    class operator <=(const ALeft, ARight: TQuantity): boolean;

    (** Returns @true if @code(ALeft) is dimensionally compatible with @code(ARight) and its value is greater than or equal. *)
    class operator >=(const ALeft, ARight: TQuantity): boolean;

    (** Returns @true if the operands differ in dimension or in value. *)
    class operator <>(const ALeft, ARight: TQuantity): boolean;

    (**
      Implicit conversion from a dimensionless real value to a @link(TQuantity).
      The resulting quantity has a scalar (dimensionless) dimension.
    *)
    class operator :=(const AValue: double): TQuantity;
  end;
  {$ELSE}
  TQuantity = double;
  {$ENDIF}

