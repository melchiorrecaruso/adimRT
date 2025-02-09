{ CL3 quantity interface }

type

  { TMultivecQuantity }

  {$IFNDEF ADIMOFF}
  TMultivecQuantity = record
  private
    FID: longint;
    FValue: TMultivector;
  public
    class operator :=(const AValue: TQuantity): TMultivecQuantity;
    class operator <>(const ALeft, ARight: TMultivecQuantity): boolean;
    class operator <>(const ALeft: TMultivecQuantity; const ARight: TQuantity): boolean;
    class operator <>(const ALeft: TQuantity; const ARight: TMultivecQuantity): boolean;

    class operator = (const ALeft, ARight: TMultivecQuantity): boolean;
    class operator = (const ALeft: TMultivecQuantity; const ARight: TQuantity): boolean;
    class operator = (const ALeft: TQuantity; const ARight: TMultivecQuantity): boolean;

    class operator + (const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;

    class operator - (const ASelf: TMultivecQuantity): TMultivecQuantity;
    class operator - (const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;

    class operator * (const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;

    class operator / (const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
  end;
  {$ELSE}
  TMultivecQuantity = TMultivector;
  {$ENDIF}

  { TTrivecQuantity }

  {$IFNDEF ADIMOFF}
  TTrivecQuantity = record
  private
    FID: longint;
    FValue: TTrivector;
  public
    class operator :=(const AValue: TTrivecQuantity): TMultivecQuantity;
    class operator <>(const ALeft, ARight: TTrivecQuantity): boolean;
    class operator <>(const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): boolean;
    class operator <>(const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): boolean;

    class operator = (const ALeft, ARight: TTrivecQuantity): boolean;
    class operator = (const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): boolean;
    class operator = (const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): boolean;

    class operator + (const ALeft, ARight: TTrivecQuantity): TTrivecQuantity;
    class operator + (const ALeft: TTrivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;

    class operator - (const ASelf: TTrivecQuantity): TTrivecQuantity;
    class operator - (const ALeft, ARight: TTrivecQuantity): TTrivecQuantity;
    class operator - (const ALeft: TTrivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;

    class operator * (const ALeft, ARight: TTrivecQuantity): TQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TTrivecQuantity): TTrivecQuantity;
    class operator * (const ALeft: TTrivecQuantity; const ARight: TQuantity): TTrivecQuantity;
    class operator * (const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;

    class operator / (const ALeft, ARight: TTrivecQuantity): TQuantity;
    class operator / (const ALeft: TTrivecQuantity; const ARight: TQuantity): TTrivecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TTrivecQuantity): TTrivecQuantity;
    class operator / (const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
  end;
  {$ELSE}
  TTrivecQuantity = TTrivector;
  {$ENDIF}

  { TBivecQuantity }

  {$IFNDEF ADIMOFF}
  TBivecQuantity = record
  private
    FID: longint;
    FValue: TBivector;
  public
    class operator :=(const AValue: TBivecQuantity): TMultivecQuantity;
    class operator <>(const ALeft, ARight: TBivecQuantity): boolean;
    class operator <>(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): boolean;
    class operator <>(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): boolean;

    class operator = (const ALeft, ARight: TBivecQuantity): boolean;
    class operator = (const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): boolean;
    class operator = (const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): boolean;

    class operator + (const ALeft, ARight: TBivecQuantity): TBivecQuantity;
    class operator + (const ALeft: TBivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;

    class operator - (const ASelf: TBivecQuantity): TBivecQuantity;
    class operator - (const ALeft, ARight: TBivecQuantity): TBivecQuantity;
    class operator - (const ALeft: TBivecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;

    class operator * (const ALeft, ARight: TBivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TBivecQuantity): TBivecQuantity;
    class operator * (const ALeft: TBivecQuantity; const ARight: TQuantity): TBivecQuantity;
    class operator * (const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;

    class operator / (const ALeft, ARight: TBivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TBivecQuantity; const ARight: TQuantity): TBivecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TBivecQuantity): TBivecQuantity;
    class operator / (const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
  end;
  {$ELSE}
  TBivecQuantity = TBivector;
  {$ENDIF}

  { TVecQuantity }

  {$IFNDEF ADIMOFF}
  TVecQuantity = record
  private
    FID: longint;
    FValue: TVector;
  public
    class operator :=(const AValue: TVecQuantity): TMultivecQuantity;
    class operator <>(const ALeft, ARight: TVecQuantity): boolean;
    class operator <>(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): boolean;
    class operator <>(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): boolean;

    class operator = (const ALeft, ARight: TVecQuantity): boolean;
    class operator = (const ALeft: TVecQuantity; const ARight: TMultivecQuantity): boolean;
    class operator = (const ALeft: TMultivecQuantity; const ARight: TVecQuantity): boolean;

    class operator + (const ALeft, ARight: TVecQuantity): TVecQuantity;
    class operator + (const ALeft: TVecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator + (const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;

    class operator - (const ASelf: TVecQuantity): TVecQuantity;
    class operator - (const ALeft, ARight: TVecQuantity): TVecQuantity;
    class operator - (const ALeft: TVecQuantity; const ARight: TQuantity): TMultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator - (const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;

    class operator * (const ALeft, ARight: TVecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TVecQuantity): TVecQuantity;
    class operator * (const ALeft: TVecQuantity; const ARight: TQuantity): TVecQuantity;
    class operator * (const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TBivecQuantity;
    class operator * (const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator * (const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TBivecQuantity;
    class operator * (const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;

    class operator / (const ALeft: TQuantity; const ARight: TVecQuantity): TVecQuantity;
    class operator / (const ALeft: TVecQuantity; const ARight: TQuantity): TVecQuantity;
    class operator / (const ALeft, ARight: TVecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TBivecQuantity;
    class operator / (const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
    class operator / (const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TBivecQuantity;
    class operator / (const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
  end;
  {$ELSE}
  TVecQuantity = TVector;
  {$ENDIF}

  { TMultivecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TMultivecQuantityHelper = record helper for TMultivecQuantity
    function Dual: TMultivecQuantity;
    function Inverse: TMultivecQuantity;
    function Reverse: TMultivecQuantity;
    function Conjugate: TMultivecQuantity;
    function Reciprocal: TMultivecQuantity;
    function LeftReciprocal: TMultivecQuantity;
    function Normalized: TMultivecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TVecQuantity): TMultivecQuantity; overload;
    function Dot(const AVector: TBivecQuantity): TMultivecQuantity; overload;
    function Dot(const AVector: TTrivecQuantity): TMultivecQuantity; overload;
    function Dot(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Wedge(const AVector: TVecQuantity): TMultivecQuantity; overload;
    function Wedge(const AVector: TBivecQuantity): TMultivecQuantity; overload;
    function Wedge(const AVector: TTrivecQuantity): TTrivecQuantity; overload;
    function Wedge(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Projection(const AVector: TVecQuantity): TMultivecQuantity; overload;
    function Projection(const AVector: TBivecQuantity): TMultivecQuantity; overload;
    function Projection(const AVector: TTrivecQuantity): TMultivecQuantity; overload;
    function Projection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Rejection(const AVector: TVecQuantity): TMultivecQuantity; overload;
    function Rejection(const AVector: TBivecQuantity): TMultivecQuantity; overload;
    function Rejection(const AVector: TTrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Reflection(const AVector: TVecQuantity): TMultivecQuantity; overload;
    function Reflection(const AVector: TBivecQuantity): TMultivecQuantity; overload;
    function Reflection(const AVector: TTrivecQuantity): TMultivecQuantity; overload;
    function Reflection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TVecQuantity): TMultivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TBivecQuantity): TMultivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TTrivecQuantity): TMultivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TMultivecQuantity): TMultivecQuantity;overload;

    function SameValue(const AVector: TMultivecQuantity): boolean;
    function SameValue(const AVector: TTrivecQuantity): boolean;
    function SameValue(const AVector: TBivecQuantity): boolean;
    function SameValue(const AVector: TVecQuantity): boolean;
    function SameValue(const AVector: TQuantity): boolean;

    function ExtractMultivector(AComponents: TMultivectorComponents): TMultivecQuantity;
    function ExtractBivector(AComponents: TMultivectorComponents): TBivecQuantity;
    function ExtractVector(AComponents: TMultivectorComponents): TVecQuantity;

    function ExtractTrivector: TTrivecQuantity;
    function ExtractBivector: TBivecQuantity;
    function ExtractVector: TVecQuantity;
    function ExtractScalar: TQuantity;

    function IsNull: boolean;
    function IsScalar: boolean;
    function IsVector: boolean;
    function IsBiVector: boolean;
    function IsTrivector: boolean;
    function IsA: string;
  end;
  {$ENDIF}

  { TTrivecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TTrivecQuantityHelper = record helper for TTrivecQuantity
    function Dual: TQuantity;
    function Inverse: TTrivecQuantity;
    function Reverse: TTrivecQuantity;
    function Conjugate: TTrivecQuantity;
    function Reciprocal: TTrivecQuantity;
    function Normalized: TTrivecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TVecQuantity): TBivecQuantity; overload;
    function Dot(const AVector: TBivecQuantity): TVecQuantity; overload;
    function Dot(const AVector: TTrivecQuantity): TQuantity; overload;
    function Dot(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Wedge(const AVector: TVecQuantity): TQuantity; overload;
    function Wedge(const AVector: TBivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TTrivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TMultivecQuantity): TTrivecQuantity; overload;

    function Projection(const AVector: TVecQuantity): TTrivecQuantity; overload;
    function Projection(const AVector: TBivecQuantity): TTrivecQuantity; overload;
    function Projection(const AVector: TTrivecQuantity): TTrivecQuantity; overload;
    function Projection(const AVector: TMultivecQuantity): TTrivecQuantity; overload;

    function Rejection(const AVector: TVecQuantity): TQuantity; overload;
    function Rejection(const AVector: TBivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TTrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Reflection(const AVector: TVecQuantity): TTrivecQuantity; overload;
    function Reflection(const AVector: TBivecQuantity): TTrivecQuantity; overload;
    function Reflection(const AVector: TTrivecQuantity): TTrivecQuantity; overload;
    function Reflection(const AVector: TMultivecQuantity): TTrivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TVecQuantity): TTrivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TBivecQuantity): TTrivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TTrivecQuantity): TTrivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TMultivecQuantity): TTrivecQuantity; overload;

    function SameValue(const AVector: TMultivecQuantity): boolean;
    function SameValue(const AVector: TTrivecQuantity): boolean;

    function ToMultivector: TMultivecQuantity;
  end;
  {$ENDIF}

  { TBivecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TBivecQuantityHelper = record helper for TBivecQuantity
    function Dual: TVecQuantity;
    function Inverse: TBivecQuantity;
    function Reverse: TBivecQuantity;
    function Conjugate: TBivecQuantity;
    function Reciprocal: TBivecQuantity;
    function Normalized: TBivecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TVecQuantity): TVecQuantity; overload;
    function Dot(const AVector: TBivecQuantity): TQuantity; overload;
    function Dot(const AVector: TTrivecQuantity): TVecQuantity; overload;
    function Dot(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Wedge(const AVector: TVecQuantity): TTrivecQuantity; overload;
    function Wedge(const AVector: TBivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TTrivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Projection(const AVector: TVecQuantity): TBivecQuantity; overload;
    function Projection(const AVector: TBivecQuantity): TBivecQuantity; overload;
    function Projection(const AVector: TTrivecQuantity): TBivecQuantity; overload;
    function Projection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Rejection(const AVector: TVecQuantity): TBivecQuantity; overload;
    function Rejection(const AVector: TBivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TTrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Reflection(const AVector: TVecQuantity): TBivecQuantity; overload;
    function Reflection(const AVector: TBivecQuantity): TBivecQuantity; overload;
    function Reflection(const AVector: TTrivecQuantity): TBivecQuantity; overload;
    function Reflection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TVecQuantity): TBivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TBivecQuantity): TBivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TTrivecQuantity): TBivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TMultivecQuantity): TMultivecQuantity; overload;

    function SameValue(const AVector: TMultivecQuantity): boolean;
    function SameValue(const AVector: TBivecQuantity): boolean;

    function ExtractBivector(AComponents: TMultivectorComponents): TBivecQuantity;

    function ToMultivector: TMultivecQuantity;
  end;
  {$ENDIF}

  { TVecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TVecQuantityHelper = record helper for TVecQuantity
    function Dual: TBivecQuantity;
    function Inverse: TVecQuantity;
    function Reverse: TVecQuantity;
    function Conjugate: TVecQuantity;
    function Reciprocal: TVecQuantity;
    function Normalized: TVecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TVecQuantity): TQuantity; overload;
    function Dot(const AVector: TBivecQuantity): TVecQuantity; overload;
    function Dot(const AVector: TTrivecQuantity): TBivecQuantity; overload;
    function Dot(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Wedge(const AVector: TVecQuantity): TBivecQuantity; overload;
    function Wedge(const AVector: TBivecQuantity): TTrivecQuantity; overload;
    function Wedge(const AVector: TTrivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Cross(const AVector: TVecQuantity): TVecQuantity;

    function Projection(const AVector: TVecQuantity): TVecQuantity; overload;
    function Projection(const AVector: TBivecQuantity): TVecQuantity; overload;
    function Projection(const AVector: TTrivecQuantity): TVecQuantity; overload;
    function Projection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Rejection(const AVector: TVecQuantity): TVecQuantity; overload;
    function Rejection(const AVector: TBivecQuantity): TVecQuantity; overload;
    function Rejection(const AVector: TTrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Reflection(const AVector: TVecQuantity): TVecQuantity; overload;
    function Reflection(const AVector: TBivecQuantity): TVecQuantity; overload;
    function Reflection(const AVector: TTrivecQuantity): TVecQuantity; overload;
    function Reflection(const AVector: TMultivecQuantity): TMultivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TVecQuantity): TVecQuantity; overload;
    function Rotation(const AVector1, AVector2: TBivecQuantity): TVecQuantity; overload;
    function Rotation(const AVector1, AVector2: TTrivecQuantity): TVecQuantity; overload;
    function Rotation(const AVector1, AVector2: TMultivecQuantity): TMultivecQuantity; overload;

    function SameValue(const AVector: TMultivecQuantity): boolean;
    function SameValue(const AVector: TVecQuantity): boolean;

    function ExtractVector(AComponents: TMultivectorComponents): TVecQuantity;

    function ToMultivector: TMultivecQuantity;
  end;
  {$ENDIF}

