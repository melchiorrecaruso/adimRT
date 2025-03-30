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
  generic TMatrixQuantity<TType, TSpace> = record
  type
    TSelf = specialize TMatrixQuantity<TType, TSpace>;
    TMatrix = specialize TMatrix<TType, TSpace>;
  private
    FID: longint;
    FValue: TMatrix;
  public

  end;

  TC2MatrixQuantity = specialize TMatrixQuantity<TComplex, T2DSpace>;
  TC3MatrixQuantity = specialize TMatrixQuantity<TComplex, T3DSpace>;
  TC4MatrixQuantity = specialize TMatrixQuantity<TComplex, T4DSpace>;
  {$ELSE}
  TC2MatrixQuantity = specialize TMatrix<TComplex, T2DSpace>;
  TC3MatrixQuantity = specialize TMatrix<TComplex, T3DSpace>;
  TC4MatrixQuantity = specialize TMatrix<TComplex, T4DSpace>;
  {$ENDIF}

  // TVecQuantity for Hilbert space

  {$IFNDEF ADIMOFF}
  generic TVecQuantity<TType, TSpace> = record
  type
    TSelf = specialize TVecQuantity<TType, TSpace>;
    TVector = specialize TVector<TType, TSpace>;
  private
    FID: longint;
    FValue: TVector;
  public
  end;

  TC2VecQuantity = specialize TVecQuantity<TComplex, T2DSpace>;
  TC3VecQuantity = specialize TVecQuantity<TComplex, T3DSpace>;
  TC4VecQuantity = specialize TVecQuantity<TComplex, T4DSpace>;
  {$ELSE}
  TC2VecQuantity = specialize TVector<TComplex, T2DSpace>;
  TC3VecQuantity = specialize TVector<TComplex, T3DSpace>;
  TC4VecQuantity = specialize TVector<TComplex, T4DSpace>;
  {$ENDIF}

  // TTransposedVecQuantity for Hilbert space

  {$IFNDEF ADIMOFF}
  generic TTransposedVecQuantity<TType, TSpace> = record
  type
    TSelf = specialize TVecQuantity<TType, TSpace>;
    TVector = specialize TTransposedVector<TType, TSpace>;
  private
    FID: longint;
    FValue: TVector;
  public
  end;

  TC2TransposedVecQuantity = specialize TTransposedVector<TComplex, T2DSpace>;
  TC3TransposedVecQuantity = specialize TTransposedVector<TComplex, T3DSpace>;
  TC4TransposedVecQuantity = specialize TTransposedVector<TComplex, T4DSpace>;
  {$ELSE}
  TC2TransposedVecQuantity = specialize TTransposedVector<TComplex, T2DSpace>;
  TC3TransposedVecQuantity = specialize TTransposedVector<TComplex, T3DSpace>;
  TC4TransposedVecQuantity = specialize TTransposedVector<TComplex, T4DSpace>;
  {$ENDIF}

{$IFNDEF ADIMOFF}
operator *(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;
operator *(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;
operator /(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;
operator /(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;
{$ENDIF}
