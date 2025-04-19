{ Matrix interface }

type
  T2DSpace = record const N = 2; end;
  T3DSpace = record const N = 3; end;
  T4DSpace = record const N = 4; end;

  // TRMatrix

  generic TRMatrix<TSpace> = record
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
    function Transpose: TRMatrix;
    class operator<>(const ALeft, ARight: TRMatrix): boolean;
    class operator =(const ALeft, ARight: TRMatrix): boolean;
    class operator +(const ALeft, ARight: TRMatrix): TRMatrix;
    class operator -(const ALeft, ARight: TRMatrix): TRMatrix;

    class operator *(const ALeft, ARight: TRMatrix): TRMatrix;
    class operator *(const ALeft: double; const ARight: TRMatrix): TRMatrix;
    class operator *(const ALeft: TRMatrix; const ARight: double): TRMatrix;
    class operator /(const ALeft: TRMatrix; const ARight: double): TRMatrix;
  public
    property a[ARow, ACol: longint]: double read Get write Put; default;
  end;

  // TCMatrix

  generic TCMatrix<TSpace> = record
  type
    TRMatrix = specialize TRMatrix<TSpace>;
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
    function Transpose: TCMatrix;
    class operator:=(const AMatrix: TRMatrix): TCMatrix;
    class operator<>(const ALeft, ARight: TCMatrix): boolean;
    class operator =(const ALeft, ARight: TCMatrix): boolean;
    class operator +(const ALeft, ARight: TCMatrix): TCMatrix;
    class operator -(const ALeft, ARight: TCMatrix): TCMatrix;

    class operator *(const ALeft, ARight: TCMatrix): TCMatrix;
    class operator *(const ALeft: TComplex; const ARight: TCMatrix): TCMatrix;
    class operator *(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;
    class operator /(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;
  public
    property a[ARow, ACol: longint]: TComplex read Get write Put; default;
  end;

  TR2Matrix = specialize TRMatrix<T2DSpace>;
  TR3Matrix = specialize TRMatrix<T3DSpace>;
  TR4Matrix = specialize TRMatrix<T4DSpace>;

  TC2Matrix = specialize TCMatrix<T2DSpace>;
  TC3Matrix = specialize TCMatrix<T3DSpace>;
  TC4Matrix = specialize TCMatrix<T4DSpace>;

  {$IFNDEF ADIMOFF}
  generic TRMatrixQuantity<TSpace> = record
  type
    TRMatrix = specialize TRMatrix<TSpace>;
  private
    FID: longint;
    FValue: TRMatrix;
    procedure Put(ARow, ACol: longint; AQuantity: TQuantity);
    function Get(ARow, ACol: longint): TQuantity;
  public
    class operator:=(const AMatrix: TRMatrix): TRMatrixQuantity;
    class operator<>(const ALeft, ARight: TRMatrixQuantity): boolean;
    class operator =(const ALeft, ARight: TRMatrixQuantity): boolean;
    class operator +(const ALeft, ARight: TRMatrixQuantity): TRMatrixQuantity;
    class operator -(const ALeft, ARight: TRMatrixQuantity): TRMatrixQuantity;

    class operator *(const ALeft, ARight: TRMatrixQuantity): TRMatrixQuantity;
    class operator *(const ALeft: TQuantity; const ARight: TRMatrixQuantity): TRMatrixQuantity;
    class operator *(const ALeft: TRMatrixQuantity; const ARight: TQuantity): TRMatrixQuantity;
    class operator /(const ALeft: TRMatrixQuantity; const ARight: TQuantity): TRMatrixQuantity;
  end;

  generic TCMatrixQuantity<TSpace> = record
  type
    TCMatrix = specialize TCMatrix<TSpace>;
  private
    FID: longint;
    FValue: TCMatrix;
    procedure Put(ARow, ACol: longint; AQuantity: TComplexQuantity);
    function Get(ARow, ACol: longint): TComplexQuantity;
  public
    class operator:=(const AMatrix: TCMatrix): TCMatrixQuantity;
    class operator<>(const ALeft, ARight: TCMatrixQuantity): boolean;
    class operator =(const ALeft, ARight: TCMatrixQuantity): boolean;
    class operator +(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;
    class operator -(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;

    class operator *(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;
    class operator *(const ALeft: TComplexQuantity; const ARight: TCMatrixQuantity): TCMatrixQuantity;
    class operator *(const ALeft: TCMatrixQuantity; const ARight: TComplexQuantity): TCMatrixQuantity;
    class operator /(const ALeft: TCMatrixQuantity; const ARight: TComplexQuantity): TCMatrixQuantity;
  public
    property a[ARow, ACol: longint]: TComplexQuantity read Get write Put; default;
  end;

  TR2MatrixQuantity = specialize TRMatrixQuantity<T2DSpace>;
  TR3MatrixQuantity = specialize TRMatrixQuantity<T3DSpace>;
  TR4MatrixQuantity = specialize TRMatrixQuantity<T4DSpace>;

  TC2MatrixQuantity = specialize TCMatrixQuantity<T2DSpace>;
  TC3MatrixQuantity = specialize TCMatrixQuantity<T3DSpace>;
  TC4MatrixQuantity = specialize TCMatrixQuantity<T4DSpace>;
  {$ELSE}
  TR2MatrixQuantity = specialize TRMatrix<T2DSpace>;
  TR3MatrixQuantity = specialize TRMatrix<T3DSpace>;
  TR4MatrixQuantity = specialize TRMatrix<T4DSpace>;

  TC2MatrixQuantity = specialize TCMatrix<T2DSpace>;
  TC3MatrixQuantity = specialize TCMatrix<T3DSpace>;
  TC4MatrixQuantity = specialize TCMatrix<T4DSpace>;
  {$ENDIF}

  {$IFNDEF ADIMOFF}
  operator * (const ALeft: TQuantity; const ARight: TR2Matrix): TR2MatrixQuantity;
  operator * (const ALeft: TR2Matrix; const ARight: TQuantity): TR2MatrixQuantity;
  operator * (const ALeft: TQuantity; const ARight: TR3Matrix): TR3MatrixQuantity;
  operator * (const ALeft: TR3Matrix; const ARight: TQuantity): TR3MatrixQuantity;
  operator * (const ALeft: TQuantity; const ARight: TR4Matrix): TR4MatrixQuantity;
  operator * (const ALeft: TR4Matrix; const ARight: TQuantity): TR4MatrixQuantity;

  operator * (const ALeft: TQuantity; const ARight: TC2Matrix): TC2MatrixQuantity;
  operator * (const ALeft: TC2Matrix; const ARight: TQuantity): TC2MatrixQuantity;
  operator * (const ALeft: TQuantity; const ARight: TC3Matrix): TC3MatrixQuantity;
  operator * (const ALeft: TC3Matrix; const ARight: TQuantity): TC3MatrixQuantity;
  operator * (const ALeft: TQuantity; const ARight: TC4Matrix): TC4MatrixQuantity;
  operator * (const ALeft: TC4Matrix; const ARight: TQuantity): TC4MatrixQuantity;
  {$ENDIF}

