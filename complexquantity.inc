{ Complex quantity interface }

type

  // TComplexQuantity

  {$IFNDEF ADIMOFF}
  TComplexQuantity = record
  private
    FID: longint;
    FValue: TComplex;
  public
    function Dual: TComplexQuantity;
    function Reciprocal: TComplexQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;
    class operator:=(const AValue: TComplex): TComplexQuantity;
    class operator =(const ALeft, ARight: TComplexQuantity): boolean; inline;
    class operator<>(const ALeft, ARight: TComplexQuantity): boolean; inline;

    class operator +(const AValue: TComplexQuantity): TComplexQuantity; inline;
    class operator +(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator +(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator +(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;

    class operator -(const AValue: TComplexQuantity): TComplexQuantity; inline;
    class operator -(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator -(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator -(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;

    class operator *(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator *(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator *(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity; inline;
    class operator *(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator *(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;

    class operator /(const ALeft, ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity; inline;
    class operator /(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
    class operator /(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
  end;
  {$ELSE}
  TComplexQuantity = TComplex;
  {$ENDIF}

  {$IFNDEF ADIMOFF}
  TC2MatrixQuantity = record
  private
    FID: longint;
    FValue: TC2Matrix;
  public
  end;
  {$ELSE}
  TC2MatrixQuantity = TC2Matrix;
  {$ENDIF}

  // TKet for Hilbert space

  {$IFNDEF ADIMOFF}
  TC2KetQuantity = record
  private
    FID: longint;
    FValue: TC2Ket;
  public
  end;
  {$ELSE}
  TC2KetQuantity = TC2Ket;
  {$ENDIF}

  // TBra for Hilbert space

  {$IFNDEF ADIMOFF}
  TC2BraQuantity = record
  private
    FID: longint;
    FValue: TC2Bra;
  public
  end;
  {$ELSE}
  TC2BraQuantity = TC2Bra;
  {$ENDIF}

{$IFNDEF ADIMOFF}
operator *(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;
operator *(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;
operator /(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;
operator /(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;
{$ENDIF}
