{ Matrix interface }

type
  T2DSpace = record const N = 2; end;
  T3DSpace = record const N = 3; end;
  T4DSpace = record const N = 4; end;

  // TCMatrix

  generic TCMatrix<TSpace> = record
  type
    TSelf = specialize TCMatrix<TSpace>;
  private
    fm: array[1..TSpace.N, 1..TSpace.N] of TComplex;
    procedure Put(ARow, ACol: longint; AValue: TComplex);
    function Get(ARow, ACol: longint): TComplex;
  public
    function IsNull: boolean;
    function IsNotNull: boolean;
    function RowReduction: TCMatrix;
    procedure Swap(ARow1, ARow2: longint);
    function Trace: TComplex;
    function Transpose: TSelf;
    class operator<>(const ALeft, ARight: TSelf): boolean;
    class operator =(const ALeft, ARight: TSelf): boolean;
    class operator +(const ALeft, ARight: TSelf): TSelf;
    class operator -(const ALeft, ARight: TSelf): TSelf;
    class operator *(const ALeft: TComplex; const ARight: TSelf): TSelf;
    class operator *(const ALeft: TSelf; const ARight: TComplex): TSelf;
    class operator *(const ALeft, ARight: TSelf): TSelf;
    class operator /(const ALeft: TSelf; const ARight: TComplex): TSelf;
  public
    property a[ARow, ACol: longint]: TComplex read Get write Put; default;
  end;

  // TRMatrix

  generic TRMatrix<TSpace> = record
  type
    TSelf = specialize TRMatrix<TSpace>;
    TCMatrix = specialize TCMatrix<TSpace>;
  private
    fm: array[1..TSpace.N, 1..TSpace.N] of double;
    procedure Put(ARow, ACol: longint; AValue: double);
    function Get(ARow, ACol: longint): double;
  public
    function IsNull: boolean;
    function IsNotNull: boolean;
    function RowReduction: TRMatrix;
    procedure Swap(ARow1, ARow2: longint);
    function Trace: double;
    function Transpose: TSelf;
    class operator<>(const ALeft, ARight: TSelf): boolean;
    class operator =(const ALeft, ARight: TSelf): boolean;
    class operator +(const ALeft, ARight: TSelf): TSelf;
    class operator -(const ALeft, ARight: TSelf): TSelf;
    class operator *(const ALeft: double; const ARight: TSelf): TSelf;
    class operator *(const ALeft: TSelf; const ARight: double): TSelf;
    class operator *(const ALeft, ARight: TSelf): TSelf;
    class operator /(const ALeft: TSelf; const ARight: double): TSelf;
  public
    property a[ARow, ACol: longint]: double read Get write Put; default;
  end;

  TC2Matrix = specialize TCMatrix<T2DSpace>;
  TC3Matrix = specialize TCMatrix<T3DSpace>;
  TC4Matrix = specialize TCMatrix<T4DSpace>;

  TR2Matrix = specialize TRMatrix<T2DSpace>;
  TR3Matrix = specialize TRMatrix<T3DSpace>;
  TR4Matrix = specialize TRMatrix<T4DSpace>;

  {$IFNDEF ADIMOFF}
  generic TCMatrixQuantity<TSpace> = record
  type
    TSelf = specialize TCMatrixQuantity<TSpace>;
    TMatrix = specialize TCMatrix<TSpace>;
  private
    FID: longint;
    FValue: TMatrix;
  public
    class operator:=(const AMatrix: TMatrix): TSelf;
    class operator +(const ALeft, ARight: TSelf): TSelf;
    class operator -(const ALeft, ARight: TSelf): TSelf;
    class operator *(const ALeft, ARight: TSelf): TSelf;
  end;

  generic TRMatrixQuantity<TSpace> = record
  type
    TSelf = specialize TRMatrixQuantity<TSpace>;
    TMatrix = specialize TRMatrix<TSpace>;
  private
    FID: longint;
    FValue: TMatrix;
  public
    class operator :=(const AMatrix: TMatrix): TSelf;
    class operator  +(const ALeft, ARight: TSelf): TSelf;
    class operator  -(const ALeft, ARight: TSelf): TSelf;
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

