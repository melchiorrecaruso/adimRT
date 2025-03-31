
{ Matrix and vector quantity interface }

  {$IFNDEF ADIMOFF}
  generic TCMatrixQuantity<TSpace> = record
  type
    TSelf = specialize TCMatrixQuantity<TSpace>;
    TMatrix = specialize TCMatrix<TSpace>;
  private
    FID: longint;
    FValue: TMatrix;
  public

  end;

  generic TRMatrixQuantity<TSpace> = record
  type
    TSelf = specialize TRMatrixQuantity<TSpace>;
    TMatrix = specialize TRMatrix<TSpace>;
  private
    FID: longint;
    FValue: TMatrix;
  public

  end;

  TC2MatrixQuantity = specialize TCMatrixQuantity<T2DSpace>;
  TC3MatrixQuantity = specialize TCMatrixQuantity<T3DSpace>;
  TC4MatrixQuantity = specialize TCMatrixQuantity<T4DSpace>;
  TR2MatrixQuantity = specialize TRMatrixQuantity<T2DSpace>;
  TR3MatrixQuantity = specialize TRMatrixQuantity<T3DSpace>;
  TR4MatrixQuantity = specialize TRMatrixQuantity< T4DSpace>;
  {$ELSE}
  TC2MatrixQuantity = specialize TCMatrix<T2DSpace>;
  TC3MatrixQuantity = specialize TCMatrix<T3DSpace>;
  TC4MatrixQuantity = specialize TCMatrix<T4DSpace>;
  TR2MatrixQuantity = specialize TRMatrix<T2DSpace>;
  TR3MatrixQuantity = specialize TRMatrix<T3DSpace>;
  TR4MatrixQuantity = specialize TRMatrix<T4DSpace>;
  {$ENDIF}

  // TVecQuantity

  {$IFNDEF ADIMOFF}
  generic TCVecQuantity<TSpace> = record
  type
    TSelf = specialize TCVecQuantity<TSpace>;
    TVector = specialize TCVector<TSpace>;
  private
    FID: longint;
    FValue: TVector;
  public
    class operator <>(const ALeft, ARight: TSelf): boolean;
    class operator = (const ALeft, ARight: TSelf): boolean;
    class operator + (const AValue: TSelf): TSelf;
    class operator + (const ALeft, ARight: TSelf): TSelf;
    class operator - (const AValue: TSelf): TSelf;
    class operator - (const ALeft, ARight: TSelf): TSelf;
    class operator * (const ALeft: TQuantity; const ARight: TSelf): TSelf;
    class operator * (const ALeft: TSelf; const ARight: TQuantity): TSelf;
    class operator / (const ALeft: TQuantity; const ARight: TSelf): TSelf;
    class operator / (const ALeft: TSelf; const ARight: TQuantity): TSelf;
  end;

  generic TRVecQuantity<TSpace> = record
  type
    TSelf = specialize TRVecQuantity<TSpace>;
    TVector = specialize TRVector<TSpace>;
  private
    FID: longint;
    FValue: TVector;
  public
    class operator <>(const ALeft, ARight: TSelf): boolean;
    class operator = (const ALeft, ARight: TSelf): boolean;
    class operator + (const AValue: TSelf): TSelf;
    class operator + (const ALeft, ARight: TSelf): TSelf;
    class operator - (const AValue: TSelf): TSelf;
    class operator - (const ALeft, ARight: TSelf): TSelf;
    class operator * (const ALeft: TQuantity; const ARight: TSelf): TSelf;
    class operator * (const ALeft: TSelf; const ARight: TQuantity): TSelf;
    class operator / (const ALeft: TQuantity; const ARight: TSelf): TSelf;
    class operator / (const ALeft: TSelf; const ARight: TQuantity): TSelf;
  end;

  TC2VecQuantity = specialize TCVecQuantity<T2DSpace>;
  TC3VecQuantity = specialize TCVecQuantity<T3DSpace>;
  TC4VecQuantity = specialize TCVecQuantity<T4DSpace>;
  TR2VecQuantity = specialize TRVecQuantity<T2DSpace>;
  TR3VecQuantity = specialize TRVecQuantity<T3DSpace>;
  TR4VecQuantity = specialize TRVecQuantity<T4DSpace>;
  {$ELSE}
  TC2VecQuantity = specialize TCVector<T2DSpace>;
  TC3VecQuantity = specialize TCVector<T3DSpace>;
  TC4VecQuantity = specialize TCVector<T4DSpace>;
  TR2VecQuantity = specialize TRVector<T2DSpace>;
  TR3VecQuantity = specialize TRVector<T3DSpace>;
  TR4VecQuantity = specialize TRVector<T4DSpace>;
  {$ENDIF}

  // TTransposedVecQuantity

  {$IFNDEF ADIMOFF}
  generic TCTransposedVecQuantity<TSpace> = record
  type
    TSelf = specialize TCTransposedVecQuantity<TSpace>;
    TVector = specialize TCVector<TSpace>;
  private
    FID: longint;
    FValue: TVector;
  public
  end;

  generic TRTransposedVecQuantity<TSpace> = record
  type
    TSelf = specialize TRTransposedVecQuantity<TSpace>;
    TVector = specialize TRVector<TSpace>;
  private
    FID: longint;
    FValue: TVector;
  public
  end;

  TC2TransposedVecQuantity = specialize TCTransposedVector<T2DSpace>;
  TC3TransposedVecQuantity = specialize TCTransposedVector<T3DSpace>;
  TC4TransposedVecQuantity = specialize TCTransposedVector<T4DSpace>;
  TR2TransposedVecQuantity = specialize TRTransposedVector<T2DSpace>;
  TR3TransposedVecQuantity = specialize TRTransposedVector<T3DSpace>;
  TR4TransposedVecQuantity = specialize TRTransposedVector<T4DSpace>;
  {$ELSE}
  TC2TransposedVecQuantity = specialize TCTransposedVector<T2DSpace>;
  TC3TransposedVecQuantity = specialize TCTransposedVector<T3DSpace>;
  TC4TransposedVecQuantity = specialize TCTransposedVector<T4DSpace>;
  TR2TransposedVecQuantity = specialize TRTransposedVector<T2DSpace>;
  TR3TransposedVecQuantity = specialize TRTransposedVector<T3DSpace>;
  TR4TransposedVecQuantity = specialize TRTransposedVector<T4DSpace>;
  {$ENDIF}

  // TR3VecQuantityHelper

  {$IFNDEF ADIMOFF}
  TR3VecQuantityHelper = record helper for TR3VecQuantity
    function Dot(const AVector: TR3VecQuantity): TQuantity;
    function Cross(const AVector: TR3VecQuantity): TR3VecQuantity;
    function Projection(const AVersor: TR3Vector): TR3VecQuantity;
    function Rejection(const AVersor: TR3Vector): TR3VecQuantity; overload;
    function Reflection(const AVersor: TR3Vector): TR3VecQuantity; overload;
  end;
  {$ENDIF}



