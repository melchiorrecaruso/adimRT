{ CL3 interface }

type

  // TMultivectorComponents
  
  TMultivectorComponent  = (clc0, clc1, clc2, clc3, clc12, clc13, clc23, clc123);
  TMultivectorComponents = set of TMultivectorComponent;

  // TMultivector
  
  TMultivector = record
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
    class operator :=(const AValue: double): TMultivector;
    class operator :=(const AValue: TMultivector): double;
    class operator <>(const ALeft, ARight: TMultivector): boolean;
    class operator <>(const ALeft: TMultivector; const ARight: double): boolean;
    class operator <>(const ALeft: double; const ARight: TMultivector): boolean;

    class operator = (const ALeft, ARight: TMultivector): boolean;
    class operator = (const ALeft: TMultivector; const ARight: double): boolean;
    class operator = (const ALeft: double; const ARight: TMultivector): boolean;

    class operator + (const ALeft, ARight: TMultivector): TMultivector;
    class operator + (const ALeft: TMultivector; const ARight: double): TMultivector;
    class operator + (const ALeft: double; const ARight: TMultivector): TMultivector;

    class operator - (const ASelf: TMultivector): TMultivector;
    class operator - (const ALeft, ARight: TMultivector): TMultivector;
    class operator - (const ALeft: TMultivector; const ARight: double): TMultivector;
    class operator - (const ALeft: double; const ARight: TMultivector): TMultivector;

    class operator * (const ALeft, ARight: TMultivector): TMultivector;
    class operator * (const ALeft: TMultivector; const ARight: double): TMultivector;
    class operator * (const ALeft: double; const ARight: TMultivector): TMultivector;

    class operator / (const ALeft, ARight: TMultivector): TMultivector;
    class operator / (const ALeft: TMultivector; const ARight: double): TMultivector;
    class operator / (const ALeft: double; const ARight: TMultivector): TMultivector;
  end;

  // TTrivector
  
  TTrivector = record
  private
    fm123: double;
  public
    class operator :=(const AValue: TTrivector): TMultivector;
    class operator :=(const AValue: TMultivector): TTrivector;
    class operator <>(const ALeft, ARight: TTrivector): boolean;
    class operator <>(const ALeft: TTrivector; const ARight: TMultivector): boolean;
    class operator <>(const ALeft: TMultivector; const ARight: TTrivector): boolean;

    class operator = (const ALeft, ARight: TTrivector): boolean;
    class operator = (const ALeft: TTrivector; const ARight: TMultivector): boolean;
    class operator = (const ALeft: TMultivector; const ARight: TTrivector): boolean;

    class operator + (const ALeft, ARight: TTrivector): TTrivector;
    class operator + (const ALeft: TTrivector; const ARight: double): TMultivector;
    class operator + (const ALeft: double; const ARight: TTrivector): TMultivector;
    class operator + (const ALeft: TTrivector; const ARight: TMultivector): TMultivector;
    class operator + (const ALeft: TMultivector; const ARight: TTrivector): TMultivector;

    class operator - (const ASelf: TTrivector): TTrivector;
    class operator - (const ALeft, ARight: TTrivector): TTrivector;
    class operator - (const ALeft: TTrivector; const ARight: double): TMultivector;
    class operator - (const ALeft: double; const ARight: TTrivector): TMultivector;
    class operator - (const ALeft: TTrivector; const ARight: TMultivector): TMultivector;
    class operator - (const ALeft: TMultivector; const ARight: TTrivector): TMultivector;

    class operator * (const ALeft, ARight: TTrivector): double;
    class operator * (const ALeft: double; const ARight: TTrivector): TTrivector;
    class operator * (const ALeft: TTrivector; const ARight: double): TTrivector;
    class operator * (const ALeft: TTrivector; const ARight: TMultivector): TMultivector;
    class operator * (const ALeft: TMultivector; const ARight: TTrivector): TMultivector;

    class operator / (const ALeft, ARight: TTrivector): double;
    class operator / (const ALeft: TTrivector; const ARight: double): TTrivector;
    class operator / (const ALeft: double; const ARight: TTrivector): TTrivector;
    class operator / (const ALeft: TTrivector; const ARight: TMultivector): TMultivector;
    class operator / (const ALeft: TMultivector; const ARight: TTrivector): TMultivector;
  end;

  // TBivector
  
  TBivector = record
  private
    fm12: double;
    fm13: double;
    fm23: double;
  public
    class operator :=(const AValue: TBivector): TMultivector;
    class operator :=(const AValue: TMultivector): TBivector;
    class operator <>(const ALeft, ARight: TBivector): boolean;
    class operator <>(const ALeft: TBivector; const ARight: TMultivector): boolean;
    class operator <>(const ALeft: TMultivector; const ARight: TBivector): boolean;

    class operator = (const ALeft, ARight: TBivector): boolean;
    class operator = (const ALeft: TBivector; const ARight: TMultivector): boolean;
    class operator = (const ALeft: TMultivector; const ARight: TBivector): boolean;

    class operator + (const ALeft, ARight: TBivector): TBivector;
    class operator + (const ALeft: TBivector; const ARight: double): TMultivector;
    class operator + (const ALeft: double; const ARight: TBivector): TMultivector;
    class operator + (const ALeft: TBivector; const ARight: TTrivector): TMultivector;
    class operator + (const ALeft: TTrivector; const ARight: TBivector): TMultivector;
    class operator + (const ALeft: TBivector; const ARight: TMultivector): TMultivector;
    class operator + (const ALeft: TMultivector; const ARight: TBivector): TMultivector;

    class operator - (const ASelf: TBivector): TBivector;
    class operator - (const ALeft, ARight: TBivector): TBivector;
    class operator - (const ALeft: TBivector; const ARight: double): TMultivector;
    class operator - (const ALeft: double; const ARight: TBivector): TMultivector;
    class operator - (const ALeft: TBivector; const ARight: TTrivector): TMultivector;
    class operator - (const ALeft: TTrivector; const ARight: TBivector): TMultivector;
    class operator - (const ALeft: TBivector; const ARight: TMultivector): TMultivector;
    class operator - (const ALeft: TMultivector; const ARight: TBivector): TMultivector;

    class operator * (const ALeft, ARight: TBivector): TMultivector;
    class operator * (const ALeft: double; const ARight: TBivector): TBivector;
    class operator * (const ALeft: TBivector; const ARight: double): TBivector;
    class operator * (const ALeft: TBivector; const ARight: TMultivector): TMultivector;
    class operator * (const ALeft: TBivector; const ARight: TTrivector): TMultivector;
    class operator * (const ALeft: TTrivector; const ARight: TBivector): TMultivector;
    class operator * (const ALeft: TMultivector; const ARight: TBivector): TMultivector;

    class operator / (const ALeft, ARight: TBivector): TMultivector;
    class operator / (const ALeft: TBivector; const ARight: double): TBivector;
    class operator / (const ALeft: double; const ARight: TBivector): TBivector;
    class operator / (const ALeft: TBivector; const ARight: TTrivector): TMultivector;
    class operator / (const ALeft: TTrivector; const ARight: TBivector): TMultivector;
    class operator / (const ALeft: TBivector; const ARight: TMultivector): TMultivector;
    class operator / (const ALeft: TMultivector; const ARight: TBivector): TMultivector;
  end;

  // TVector
  
  TVector = record
  private
    fm1: double;
    fm2: double;
    fm3: double;
  public
    class operator :=(const AValue: TVector): TMultivector;
    class operator :=(const AValue: TMultivector): TVector;
    class operator <>(const ALeft, ARight: TVector): boolean;
    class operator <>(const ALeft: TVector; const ARight: TMultivector): boolean;
    class operator <>(const ALeft: TMultivector; const ARight: TVector): boolean;

    class operator = (const ALeft, ARight: TVector): boolean;
    class operator = (const ALeft: TVector; const ARight: TMultivector): boolean;
    class operator = (const ALeft: TMultivector; const ARight: TVector): boolean;

    class operator + (const ALeft, ARight: TVector): TVector;
    class operator + (const ALeft: TVector; const ARight: double): TMultivector;
    class operator + (const ALeft: double; const ARight: TVector): TMultivector;
    class operator + (const ALeft: TVector; const ARight: TBivector): TMultivector;
    class operator + (const ALeft: TBivector; const ARight: TVector): TMultivector;
    class operator + (const ALeft: TVector; const ARight: TTrivector): TMultivector;
    class operator + (const ALeft: TTrivector; const ARight: TVector): TMultivector;
    class operator + (const ALeft: TVector; const ARight: TMultivector): TMultivector;
    class operator + (const ALeft: TMultivector; const ARight: TVector): TMultivector;

    class operator - (const ASelf: TVector): TVector;
    class operator - (const ALeft, ARight: TVector): TVector;
    class operator - (const ALeft: TVector; const ARight: double): TMultivector;
    class operator - (const ALeft: double; const ARight: TVector): TMultivector;
    class operator - (const ALeft: TVector; const ARight: TBivector): TMultivector;
    class operator - (const ALeft: TBivector; const ARight: TVector): TMultivector;
    class operator - (const ALeft: TVector; const ARight: TTrivector): TMultivector;
    class operator - (const ALeft: TTrivector; const ARight: TVector): TMultivector;
    class operator - (const ALeft: TVector; const ARight: TMultivector): TMultivector;
    class operator - (const ALeft: TMultivector; const ARight: TVector): TMultivector;

    class operator * (const ALeft, ARight: TVector): TMultivector;
    class operator * (const ALeft: double; const ARight: TVector): TVector;
    class operator * (const ALeft: TVector; const ARight: double): TVector;
    class operator * (const ALeft: TVector; const ARight: TBivector): TMultivector;
    class operator * (const ALeft: TVector; const ARight: TTrivector): TBivector;
    class operator * (const ALeft: TVector; const ARight: TMultivector): TMultivector;
    class operator * (const ALeft: TBivector; const ARight: TVector): TMultivector;
    class operator * (const ALeft: TTrivector; const ARight: TVector): TBivector;
    class operator * (const ALeft: TMultivector; const ARight: TVector): TMultivector;

    class operator / (const ALeft: double; const ARight: TVector): TVector;
    class operator / (const ALeft: TVector; const ARight: double): TVector;
    class operator / (const ALeft, ARight: TVector): TMultivector;
    class operator / (const ALeft: TVector; const ARight: TBivector): TMultivector;
    class operator / (const ALeft: TVector; const ARight: TTrivector): TBivector;
    class operator / (const ALeft: TVector; const ARight: TMultivector): TMultivector;
    class operator / (const ALeft: TBivector; const ARight: TVector): TMultivector;
    class operator / (const ALeft: TTrivector; const ARight: TVector): TBivector;
    class operator / (const ALeft: TMultivector; const ARight: TVector): TMultivector;
  end;

  // TMultivectorHelper
  
  TMultivectorHelper = record helper for TMultivector
    function Dual: TMultivector;
    function Inverse: TMultivector;
    function Reverse: TMultivector;
    function Conjugate: TMultivector;
    function Reciprocal: TMultivector;
    function LeftReciprocal: TMultivector;
    function Normalized: TMultivector;
    function Norm: double;
    function SquaredNorm: double;

    function Dot(const AVector: TVector): TMultivector; overload;
    function Dot(const AVector: TBivector): TMultivector; overload;
    function Dot(const AVector: TTrivector): TMultivector; overload;
    function Dot(const AVector: TMultivector): TMultivector; overload;

    function Wedge(const AVector: TVector): TMultivector; overload;
    function Wedge(const AVector: TBivector): TMultivector; overload;
    function Wedge(const AVector: TTrivector): TTrivector; overload;
    function Wedge(const AVector: TMultivector): TMultivector; overload;

    function Projection(const AVector: TVector): TMultivector; overload;
    function Projection(const AVector: TBivector): TMultivector; overload;
    function Projection(const AVector: TTrivector): TMultivector; overload;
    function Projection(const AVector: TMultivector): TMultivector; overload;

    function Rejection(const AVector: TVector): TMultivector; overload;
    function Rejection(const AVector: TBivector): TMultivector; overload;
    function Rejection(const AVector: TTrivector): double; overload;
    function Rejection(const AVector: TMultivector): TMultivector; overload;

    function Reflection(const AVector: TVector): TMultivector; overload;
    function Reflection(const AVector: TBivector): TMultivector; overload;
    function Reflection(const AVector: TTrivector): TMultivector; overload;
    function Reflection(const AVector: TMultivector): TMultivector; overload;

    function Rotation(const AVector1, AVector2: TVector): TMultivector; overload;
    function Rotation(const AVector1, AVector2: TBivector): TMultivector; overload;
    function Rotation(const AVector1, AVector2: TTrivector): TMultivector; overload;
    function Rotation(const AVector1, AVector2: TMultivector): TMultivector;overload;

    function SameValue(const AValue: TMultivector): boolean;
    function SameValue(const AValue: TTrivector): boolean;
    function SameValue(const AValue: TBivector): boolean;
    function SameValue(const AValue: TVector): boolean;
    function SameValue(const AValue: double): boolean;

    function ExtractMultivector(AComponents: TMultivectorComponents): TMultivector;
    function ExtractBivector(AComponents: TMultivectorComponents): TBivector;
    function ExtractVector(AComponents: TMultivectorComponents): TVector;

    function ExtractTrivector: TTrivector;
    function ExtractBivector: TBivector;
    function ExtractVector: TVector;
    function ExtractScalar: double;

    function IsNull: boolean;
    function IsScalar: boolean;
    function IsVector: boolean;
    function IsBiVector: boolean;
    function IsTrivector: boolean;
    function IsA: string;

    function ToString(APrecision, ADigits: longint): string;
    function ToString: string;
  end;

  // TTrivectorHelper
  
  TTrivectorHelper = record helper for TTrivector
    function Dual: double;
    function Inverse: TTrivector;
    function Reverse: TTrivector;
    function Conjugate: TTrivector;
    function Reciprocal: TTrivector;
    function Normalized: TTrivector;
    function Norm: double;
    function SquaredNorm: double;

    function Dot(const AVector: TVector): TBivector; overload;
    function Dot(const AVector: TBivector): TVector; overload;
    function Dot(const AVector: TTrivector): double; overload;
    function Dot(const AVector: TMultivector): TMultivector; overload;

    function Wedge(const AVector: TVector): double; overload;
    function Wedge(const AVector: TBivector): double; overload;
    function Wedge(const AVector: TTrivector): double; overload;
    function Wedge(const AVector: TMultivector): TTrivector; overload;

    function Projection(const AVector: TVector): TTrivector; overload;
    function Projection(const AVector: TBivector): TTrivector; overload;
    function Projection(const AVector: TTrivector): TTrivector; overload;
    function Projection(const AVector: TMultivector): TTrivector; overload;

    function Rejection(const AVector: TVector): double; overload;
    function Rejection(const AVector: TBivector): double; overload;
    function Rejection(const AVector: TTrivector): double; overload;
    function Rejection(const AVector: TMultivector): TMultivector; overload;

    function Reflection(const AVector: TVector): TTrivector; overload;
    function Reflection(const AVector: TBivector): TTrivector; overload;
    function Reflection(const AVector: TTrivector): TTrivector; overload;
    function Reflection(const AVector: TMultivector): TTrivector; overload;

    function Rotation(const AVector1, AVector2: TVector): TTrivector; overload;
    function Rotation(const AVector1, AVector2: TBivector): TTrivector; overload;
    function Rotation(const AVector1, AVector2: TTrivector): TTrivector; overload;
    function Rotation(const AVector1, AVector2: TMultivector): TTrivector; overload;

    function SameValue(const AValue: TMultivector): boolean;
    function SameValue(const AValue: TTrivector): boolean;

    function ToMultivector: TMultivector;
    function ToString(APrecision, ADigits: longint): string;
    function ToString: string;
  end;

  // TBivectorHelper
  
  TBivectorHelper = record helper for TBivector
    function Dual: TVector;
    function Inverse: TBivector;
    function Reverse: TBivector;
    function Conjugate: TBivector;
    function Reciprocal: TBivector;
    function Normalized: TBivector;
    function Norm: double;
    function SquaredNorm: double;

    function Dot(const AVector: TVector): TVector; overload;
    function Dot(const AVector: TBivector): double; overload;
    function Dot(const AVector: TTrivector): TVector; overload;
    function Dot(const AVector: TMultivector): TMultivector; overload;

    function Wedge(const AVector: TVector): TTrivector; overload;
    function Wedge(const AVector: TBivector): double; overload;
    function Wedge(const AVector: TTrivector): double; overload;
    function Wedge(const AVector: TMultivector): TMultivector; overload;

    function Projection(const AVector: TVector): TBivector; overload;
    function Projection(const AVector: TBivector): TBivector; overload;
    function Projection(const AVector: TTrivector): TBivector; overload;
    function Projection(const AVector: TMultivector): TMultivector; overload;

    function Rejection(const AVector: TVector): TBivector; overload;
    function Rejection(const AVector: TBivector): double; overload;
    function Rejection(const AVector: TTrivector): double; overload;
    function Rejection(const AVector: TMultivector): TMultivector; overload;

    function Reflection(const AVector: TVector): TBivector; overload;
    function Reflection(const AVector: TBivector): TBivector; overload;
    function Reflection(const AVector: TTrivector): TBivector; overload;
    function Reflection(const AVector: TMultivector): TMultivector; overload;

    function Rotation(const AVector1, AVector2: TVector): TBivector; overload;
    function Rotation(const AVector1, AVector2: TBivector): TBivector; overload;
    function Rotation(const AVector1, AVector2: TTrivector): TBivector; overload;
    function Rotation(const AVector1, AVector2: TMultivector): TMultivector; overload;

    function SameValue(const AValue: TMultivector): boolean;
    function SameValue(const AValue: TBivector): boolean;

    function ExtractBivector(AComponents: TMultivectorComponents): TBivector;

    function ToMultivector: TMultivector;
    function ToString(APrecision, ADigits: longint): string;
    function ToString: string;
  end;

  // TVectorHelper
  
  TVectorHelper = record helper for TVector
    function Dual: TBivector;
    function Inverse: TVector;
    function Reverse: TVector;
    function Conjugate: TVector;
    function Reciprocal: TVector;
    function Normalized: TVector;
    function Norm: double;
    function SquaredNorm: double;

    function Dot(const AVector: TVector): double; overload;
    function Dot(const AVector: TBivector): TVector; overload;
    function Dot(const AVector: TTrivector): TBivector; overload;
    function Dot(const AVector: TMultivector): TMultivector; overload;

    function Wedge(const AVector: TVector): TBivector; overload;
    function Wedge(const AVector: TBivector): TTrivector; overload;
    function Wedge(const AVector: TTrivector): double; overload;
    function Wedge(const AVector: TMultivector): TMultivector; overload;

    function Cross(const AVector: TVector): TVector;

    function Projection(const AVector: TVector): TVector; overload;
    function Projection(const AVector: TBivector): TVector; overload;
    function Projection(const AVector: TTrivector): TVector; overload;
    function Projection(const AVector: TMultivector): TMultivector; overload;

    function Rejection(const AVector: TVector): TVector; overload;
    function Rejection(const AVector: TBivector): TVector; overload;
    function Rejection(const AVector: TTrivector): double; overload;
    function Rejection(const AVector: TMultivector): TMultivector; overload;

    function Reflection(const AVector: TVector): TVector; overload;
    function Reflection(const AVector: TBivector): TVector; overload;
    function Reflection(const AVector: TTrivector): TVector; overload;
    function Reflection(const AVector: TMultivector): TMultivector; overload;

    function Rotation(const AVector1, AVector2: TVector): TVector; overload;
    function Rotation(const AVector1, AVector2: TBivector): TVector; overload;
    function Rotation(const AVector1, AVector2: TTrivector): TVector; overload;
    function Rotation(const AVector1, AVector2: TMultivector): TMultivector; overload;

    function SameValue(const AValue: TMultivector): boolean;
    function SameValue(const AValue: TVector): boolean;

    function ExtractVector(AComponents: TMultivectorComponents): TVector;

    function ToMultivector: TMultivector;
    function ToString(APrecision, ADigits: longint): string;
    function ToString: string;
  end;

  // TVersor
  
  TVersor1 = record class operator *(const AValue: double; const ASelf: TVersor1): TVector; end;
  TVersor2 = record class operator *(const AValue: double; const ASelf: TVersor2): TVector; end;
  TVersor3 = record class operator *(const AValue: double; const ASelf: TVersor3): TVector; end;

  // TBiversor
  
  TBiversor12 = record class operator *(const AValue: double; const ASelf: TBiversor12): TBivector; end;
  TBiversor13 = record class operator *(const AValue: double; const ASelf: TBiversor13): TBivector; end;
  TBiversor23 = record class operator *(const AValue: double; const ASelf: TBiversor23): TBivector; end;

  // TTriversor
  
  TTriversor123 = record class operator *(const AValue: double; const ASelf: TTriversor123): TTrivector; end;

const
  e1   : TVersor1 = ();
  e2   : TVersor2 = ();
  e3   : TVersor3 = ();
  e12  : TBiversor12 = ();
  e13  : TBiversor13 = ();
  e23  : TBiversor23 = ();
  e123 : TTriversor123 = ();

  u1   : TVector = (fm1:1.0; fm2:0.0; fm3:0.0);
  u2   : TVector = (fm1:0.0; fm2:1.0; fm3:0.0);
  u3   : TVector = (fm1:0.0; fm2:0.0; fm3:1.0);

  u12  : TBivector = (fm12:1.0; fm13:0.0; fm23:0.0);
  u13  : TBivector = (fm12:0.0; fm13:1.0; fm23:0.0);
  u23  : TBivector = (fm12:0.0; fm13:0.0; fm23:1.0);

  u123 : TTrivector = (fm123:1.0);

  NullMultivector : TMultivector = (fm0:0.0; fm1:0.0; fm2:0.0; fm3:0.0; fm12:0.0; fm13:0.0; fm23:0.0; fm123:0.0);
  NullTrivector   : TTrivector   = (fm123:0.0);
  NullBivector    : TBivector    = (fm12:0.0; fm13:0.0; fm23:0.0);
  NullVector      : TVector      = (fm1: 0.0; fm2: 0.0; fm3: 0.0);
  NullScalar      : double       = (0.0);
  
