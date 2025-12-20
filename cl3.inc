{ CL3 interface }

type

  // TMultivectorComponents
  
  TCL3MultivectorComponent  = (mcm0, mcm1, mcm2, mcm3, mcm12, mcm13, mcm23, mcm123);
  TCL3MultivectorComponents = set of TCL3MultivectorComponent;

  // TCL3Multivector
  
  TCL3Multivector = record
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
    class operator :=(const AValue: double): TCL3Multivector;
    class operator :=(const AValue: TCL3Multivector): double;
    class operator <>(const ALeft, ARight: TCL3Multivector): boolean;
    class operator <>(const ALeft: TCL3Multivector; const ARight: double): boolean;
    class operator <>(const ALeft: double; const ARight: TCL3Multivector): boolean;

    class operator = (const ALeft, ARight: TCL3Multivector): boolean;
    class operator = (const ALeft: TCL3Multivector; const ARight: double): boolean;
    class operator = (const ALeft: double; const ARight: TCL3Multivector): boolean;

    class operator + (const ALeft, ARight: TCL3Multivector): TCL3Multivector;
    class operator + (const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
    class operator + (const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;

    class operator - (const ASelf: TCL3Multivector): TCL3Multivector;
    class operator - (const ALeft, ARight: TCL3Multivector): TCL3Multivector;
    class operator - (const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
    class operator - (const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;

    class operator * (const ALeft, ARight: TCL3Multivector): TCL3Multivector;
    class operator * (const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
    class operator * (const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;

    class operator / (const ALeft, ARight: TCL3Multivector): TCL3Multivector;
    class operator / (const ALeft: TCL3Multivector; const ARight: double): TCL3Multivector;
    class operator / (const ALeft: double; const ARight: TCL3Multivector): TCL3Multivector;
  end;

  // TCL3Trivector
  
  TCL3Trivector = record
  private
    fm123: double;
  public
    class operator :=(const AValue: TCL3Trivector): TCL3Multivector;
    class operator :=(const AValue: TCL3Multivector): TCL3Trivector;
    class operator <>(const ALeft, ARight: TCL3Trivector): boolean;
    class operator <>(const ALeft: TCL3Trivector; const ARight: TCL3Multivector): boolean;
    class operator <>(const ALeft: TCL3Multivector; const ARight: TCL3Trivector): boolean;

    class operator = (const ALeft, ARight: TCL3Trivector): boolean;
    class operator = (const ALeft: TCL3Trivector; const ARight: TCL3Multivector): boolean;
    class operator = (const ALeft: TCL3Multivector; const ARight: TCL3Trivector): boolean;

    class operator + (const ALeft, ARight: TCL3Trivector): TCL3Trivector;
    class operator + (const ALeft: TCL3Trivector; const ARight: double): TCL3Multivector;
    class operator + (const ALeft: double; const ARight: TCL3Trivector): TCL3Multivector;
    class operator + (const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
    class operator + (const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;

    class operator - (const ASelf: TCL3Trivector): TCL3Trivector;
    class operator - (const ALeft, ARight: TCL3Trivector): TCL3Trivector;
    class operator - (const ALeft: TCL3Trivector; const ARight: double): TCL3Multivector;
    class operator - (const ALeft: double; const ARight: TCL3Trivector): TCL3Multivector;
    class operator - (const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
    class operator - (const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;

    class operator * (const ALeft, ARight: TCL3Trivector): double;
    class operator * (const ALeft: double; const ARight: TCL3Trivector): TCL3Trivector;
    class operator * (const ALeft: TCL3Trivector; const ARight: double): TCL3Trivector;
    class operator * (const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
    class operator * (const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;

    class operator / (const ALeft, ARight: TCL3Trivector): double;
    class operator / (const ALeft: TCL3Trivector; const ARight: double): TCL3Trivector;
    class operator / (const ALeft: double; const ARight: TCL3Trivector): TCL3Trivector;
    class operator / (const ALeft: TCL3Trivector; const ARight: TCL3Multivector): TCL3Multivector;
    class operator / (const ALeft: TCL3Multivector; const ARight: TCL3Trivector): TCL3Multivector;
  end;

  // TCL3Bivector
  
  TCL3Bivector = record
  private
    fm12: double;
    fm13: double;
    fm23: double;
  public
    class operator :=(const AValue: TCL3Bivector): TCL3Multivector;
    class operator :=(const AValue: TCL3Multivector): TCL3Bivector;
    class operator <>(const ALeft, ARight: TCL3Bivector): boolean;
    class operator <>(const ALeft: TCL3Bivector; const ARight: TCL3Multivector): boolean;
    class operator <>(const ALeft: TCL3Multivector; const ARight: TCL3Bivector): boolean;

    class operator = (const ALeft, ARight: TCL3Bivector): boolean;
    class operator = (const ALeft: TCL3Bivector; const ARight: TCL3Multivector): boolean;
    class operator = (const ALeft: TCL3Multivector; const ARight: TCL3Bivector): boolean;

    class operator + (const ALeft, ARight: TCL3Bivector): TCL3Bivector;
    class operator + (const ALeft: TCL3Bivector; const ARight: double): TCL3Multivector;
    class operator + (const ALeft: double; const ARight: TCL3Bivector): TCL3Multivector;
    class operator + (const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
    class operator + (const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
    class operator + (const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
    class operator + (const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;

    class operator - (const ASelf: TCL3Bivector): TCL3Bivector;
    class operator - (const ALeft, ARight: TCL3Bivector): TCL3Bivector;
    class operator - (const ALeft: TCL3Bivector; const ARight: double): TCL3Multivector;
    class operator - (const ALeft: double; const ARight: TCL3Bivector): TCL3Multivector;
    class operator - (const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
    class operator - (const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
    class operator - (const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
    class operator - (const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;

    class operator * (const ALeft, ARight: TCL3Bivector): TCL3Multivector;
    class operator * (const ALeft: double; const ARight: TCL3Bivector): TCL3Bivector;
    class operator * (const ALeft: TCL3Bivector; const ARight: double): TCL3Bivector;
    class operator * (const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
    class operator * (const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
    class operator * (const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
    class operator * (const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;

    class operator / (const ALeft, ARight: TCL3Bivector): TCL3Multivector;
    class operator / (const ALeft: TCL3Bivector; const ARight: double): TCL3Bivector;
    class operator / (const ALeft: double; const ARight: TCL3Bivector): TCL3Bivector;
    class operator / (const ALeft: TCL3Bivector; const ARight: TCL3Trivector): TCL3Multivector;
    class operator / (const ALeft: TCL3Trivector; const ARight: TCL3Bivector): TCL3Multivector;
    class operator / (const ALeft: TCL3Bivector; const ARight: TCL3Multivector): TCL3Multivector;
    class operator / (const ALeft: TCL3Multivector; const ARight: TCL3Bivector): TCL3Multivector;
  end;

  // TCL3Vector
  
  TCL3Vector = record
  private
    fm1: double;
    fm2: double;
    fm3: double;
  public
    class operator :=(const AValue: TCL3Vector): TCL3Multivector;
    class operator :=(const AValue: TCL3Multivector): TCL3Vector;
    class operator <>(const ALeft, ARight: TCL3Vector): boolean;
    class operator <>(const ALeft: TCL3Vector; const ARight: TCL3Multivector): boolean;
    class operator <>(const ALeft: TCL3Multivector; const ARight: TCL3Vector): boolean;

    class operator = (const ALeft, ARight: TCL3Vector): boolean;
    class operator = (const ALeft: TCL3Vector; const ARight: TCL3Multivector): boolean;
    class operator = (const ALeft: TCL3Multivector; const ARight: TCL3Vector): boolean;

    class operator + (const ALeft, ARight: TCL3Vector): TCL3Vector;
    class operator + (const ALeft: TCL3Vector; const ARight: double): TCL3Multivector;
    class operator + (const ALeft: double; const ARight: TCL3Vector): TCL3Multivector;
    class operator + (const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;
    class operator + (const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;
    class operator + (const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Multivector;
    class operator + (const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Multivector;
    class operator + (const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;
    class operator + (const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;

    class operator - (const ASelf: TCL3Vector): TCL3Vector;
    class operator - (const ALeft, ARight: TCL3Vector): TCL3Vector;
    class operator - (const ALeft: TCL3Vector; const ARight: double): TCL3Multivector;
    class operator - (const ALeft: double; const ARight: TCL3Vector): TCL3Multivector;
    class operator - (const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;
    class operator - (const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;
    class operator - (const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Multivector;
    class operator - (const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Multivector;
    class operator - (const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;
    class operator - (const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;

    class operator * (const ALeft, ARight: TCL3Vector): TCL3Multivector;
    class operator * (const ALeft: double; const ARight: TCL3Vector): TCL3Vector;
    class operator * (const ALeft: TCL3Vector; const ARight: double): TCL3Vector;
    class operator * (const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;
    class operator * (const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Bivector;
    class operator * (const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;
    class operator * (const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;
    class operator * (const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Bivector;
    class operator * (const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;

    class operator / (const ALeft: double; const ARight: TCL3Vector): TCL3Vector;
    class operator / (const ALeft: TCL3Vector; const ARight: double): TCL3Vector;
    class operator / (const ALeft, ARight: TCL3Vector): TCL3Multivector;
    class operator / (const ALeft: TCL3Vector; const ARight: TCL3Bivector): TCL3Multivector;
    class operator / (const ALeft: TCL3Vector; const ARight: TCL3Trivector): TCL3Bivector;
    class operator / (const ALeft: TCL3Vector; const ARight: TCL3Multivector): TCL3Multivector;
    class operator / (const ALeft: TCL3Bivector; const ARight: TCL3Vector): TCL3Multivector;
    class operator / (const ALeft: TCL3Trivector; const ARight: TCL3Vector): TCL3Bivector;
    class operator / (const ALeft: TCL3Multivector; const ARight: TCL3Vector): TCL3Multivector;
  end;

  // TCL3MultivectorHelper

  TCL3MultivectorHelper = record helper for TCL3Multivector
    function Dual: TCL3Multivector;
    function Inverse: TCL3Multivector;
    function Reverse: TCL3Multivector;
    function Conjugate: TCL3Multivector;
    function Reciprocal: TCL3Multivector;
    function LeftReciprocal: TCL3Multivector;
    function Normalized: TCL3Multivector;
    function Norm: double;
    function SquaredNorm: double;

    function Dot(const AVector: TCL3Vector): TCL3Multivector; overload;
    function Dot(const AVector: TCL3Bivector): TCL3Multivector; overload;
    function Dot(const AVector: TCL3Trivector): TCL3Multivector; overload;
    function Dot(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Wedge(const AVector: TCL3Vector): TCL3Multivector; overload;
    function Wedge(const AVector: TCL3Bivector): TCL3Multivector; overload;
    function Wedge(const AVector: TCL3Trivector): TCL3Trivector; overload;
    function Wedge(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Projection(const AVector: TCL3Vector): TCL3Multivector; overload;
    function Projection(const AVector: TCL3Bivector): TCL3Multivector; overload;
    function Projection(const AVector: TCL3Trivector): TCL3Multivector; overload;
    function Projection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Rejection(const AVector: TCL3Vector): TCL3Multivector; overload;
    function Rejection(const AVector: TCL3Bivector): TCL3Multivector; overload;
    function Rejection(const AVector: TCL3Trivector): double; overload;
    function Rejection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Reflection(const AVector: TCL3Vector): TCL3Multivector; overload;
    function Reflection(const AVector: TCL3Bivector): TCL3Multivector; overload;
    function Reflection(const AVector: TCL3Trivector): TCL3Multivector; overload;
    function Reflection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Rotation(const AVector1, AVector2: TCL3Vector): TCL3Multivector; overload;
    function Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Multivector; overload;
    function Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Multivector; overload;
    function Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector;overload;

    function SameValue(const AValue: TCL3Multivector): boolean;
    function SameValue(const AValue: TCL3Trivector): boolean;
    function SameValue(const AValue: TCL3Bivector): boolean;
    function SameValue(const AValue: TCL3Vector): boolean;
    function SameValue(const AValue: double): boolean;

    function ExtractMultivector(AComponents: TCL3MultivectorComponents): TCL3Multivector;
    function ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3Bivector;
    function ExtractVector(AComponents: TCL3MultivectorComponents): TCL3Vector;

    function ExtractTrivector: TCL3Trivector;
    function ExtractBivector: TCL3Bivector;
    function ExtractVector: TCL3Vector;
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

  // TCL3TrivectorHelper

  TCL3TrivectorHelper = record helper for TCL3Trivector
    function Dual: double;
    function Inverse: TCL3Trivector;
    function Reverse: TCL3Trivector;
    function Conjugate: TCL3Trivector;
    function Reciprocal: TCL3Trivector;
    function Normalized: TCL3Trivector;
    function Norm: double;
    function SquaredNorm: double;

    function Dot(const AVector: TCL3Vector): TCL3Bivector; overload;
    function Dot(const AVector: TCL3Bivector): TCL3Vector; overload;
    function Dot(const AVector: TCL3Trivector): double; overload;
    function Dot(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Wedge(const AVector: TCL3Vector): double; overload;
    function Wedge(const AVector: TCL3Bivector): double; overload;
    function Wedge(const AVector: TCL3Trivector): double; overload;
    function Wedge(const AVector: TCL3Multivector): TCL3Trivector; overload;

    function Projection(const AVector: TCL3Vector): TCL3Trivector; overload;
    function Projection(const AVector: TCL3Bivector): TCL3Trivector; overload;
    function Projection(const AVector: TCL3Trivector): TCL3Trivector; overload;
    function Projection(const AVector: TCL3Multivector): TCL3Trivector; overload;

    function Rejection(const AVector: TCL3Vector): double; overload;
    function Rejection(const AVector: TCL3Bivector): double; overload;
    function Rejection(const AVector: TCL3Trivector): double; overload;
    function Rejection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Reflection(const AVector: TCL3Vector): TCL3Trivector; overload;
    function Reflection(const AVector: TCL3Bivector): TCL3Trivector; overload;
    function Reflection(const AVector: TCL3Trivector): TCL3Trivector; overload;
    function Reflection(const AVector: TCL3Multivector): TCL3Trivector; overload;

    function Rotation(const AVector1, AVector2: TCL3Vector): TCL3Trivector; overload;
    function Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Trivector; overload;
    function Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Trivector; overload;
    function Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Trivector; overload;

    function SameValue(const AValue: TCL3Multivector): boolean;
    function SameValue(const AValue: TCL3Trivector): boolean;

    function ToMultivector: TCL3Multivector;
    function ToString(APrecision, ADigits: longint): string;
    function ToString: string;
  end;

  // TCL3BivectorHelper

  TCL3BivectorHelper = record helper for TCL3Bivector
    function Dual: TCL3Vector;
    function Inverse: TCL3Bivector;
    function Reverse: TCL3Bivector;
    function Conjugate: TCL3Bivector;
    function Reciprocal: TCL3Bivector;
    function Normalized: TCL3Bivector;
    function Norm: double;
    function SquaredNorm: double;

    function Dot(const AVector: TCL3Vector): TCL3Vector; overload;
    function Dot(const AVector: TCL3Bivector): double; overload;
    function Dot(const AVector: TCL3Trivector): TCL3Vector; overload;
    function Dot(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Wedge(const AVector: TCL3Vector): TCL3Trivector; overload;
    function Wedge(const AVector: TCL3Bivector): double; overload;
    function Wedge(const AVector: TCL3Trivector): double; overload;
    function Wedge(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Projection(const AVector: TCL3Vector): TCL3Bivector; overload;
    function Projection(const AVector: TCL3Bivector): TCL3Bivector; overload;
    function Projection(const AVector: TCL3Trivector): TCL3Bivector; overload;
    function Projection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Rejection(const AVector: TCL3Vector): TCL3Bivector; overload;
    function Rejection(const AVector: TCL3Bivector): double; overload;
    function Rejection(const AVector: TCL3Trivector): double; overload;
    function Rejection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Reflection(const AVector: TCL3Vector): TCL3Bivector; overload;
    function Reflection(const AVector: TCL3Bivector): TCL3Bivector; overload;
    function Reflection(const AVector: TCL3Trivector): TCL3Bivector; overload;
    function Reflection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Rotation(const AVector1, AVector2: TCL3Vector): TCL3Bivector; overload;
    function Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Bivector; overload;
    function Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Bivector; overload;
    function Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector; overload;

    function SameValue(const AValue: TCL3Multivector): boolean;
    function SameValue(const AValue: TCL3Bivector): boolean;

    function ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3Bivector;

    function ToMultivector: TCL3Multivector;
    function ToString(APrecision, ADigits: longint): string;
    function ToString: string;
  end;

  // TCL3VectorHelper

  TCL3VectorHelper = record helper for TCL3Vector
    function Dual: TCL3Bivector;
    function Inverse: TCL3Vector;
    function Reverse: TCL3Vector;
    function Conjugate: TCL3Vector;
    function Reciprocal: TCL3Vector;
    function Normalized: TCL3Vector;
    function Norm: double;
    function SquaredNorm: double;

    function Dot(const AVector: TCL3Vector): double; overload;
    function Dot(const AVector: TCL3Bivector): TCL3Vector; overload;
    function Dot(const AVector: TCL3Trivector): TCL3Bivector; overload;
    function Dot(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Wedge(const AVector: TCL3Vector): TCL3Bivector; overload;
    function Wedge(const AVector: TCL3Bivector): TCL3Trivector; overload;
    function Wedge(const AVector: TCL3Trivector): double; overload;
    function Wedge(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Cross(const AVector: TCL3Vector): TCL3Vector;

    function Projection(const AVector: TCL3Vector): TCL3Vector; overload;
    function Projection(const AVector: TCL3Bivector): TCL3Vector; overload;
    function Projection(const AVector: TCL3Trivector): TCL3Vector; overload;
    function Projection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Rejection(const AVector: TCL3Vector): TCL3Vector; overload;
    function Rejection(const AVector: TCL3Bivector): TCL3Vector; overload;
    function Rejection(const AVector: TCL3Trivector): double; overload;
    function Rejection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Reflection(const AVector: TCL3Vector): TCL3Vector; overload;
    function Reflection(const AVector: TCL3Bivector): TCL3Vector; overload;
    function Reflection(const AVector: TCL3Trivector): TCL3Vector; overload;
    function Reflection(const AVector: TCL3Multivector): TCL3Multivector; overload;

    function Rotation(const AVector1, AVector2: TCL3Vector): TCL3Vector; overload;
    function Rotation(const AVector1, AVector2: TCL3Bivector): TCL3Vector; overload;
    function Rotation(const AVector1, AVector2: TCL3Trivector): TCL3Vector; overload;
    function Rotation(const AVector1, AVector2: TCL3Multivector): TCL3Multivector; overload;

    function SameValue(const AValue: TCL3Multivector): boolean;
    function SameValue(const AValue: TCL3Vector): boolean;

    function ExtractVector(AComponents: TCL3MultivectorComponents): TCL3Vector;

    function ToMultivector: TCL3Multivector;
    function ToString(APrecision, ADigits: longint): string;
    function ToString: string;
  end;

  // TCL3Versor
  
  TCL3Versor1 = record class operator *(const AValue: double; const ASelf: TCL3Versor1): TCL3Vector; end;
  TCL3Versor2 = record class operator *(const AValue: double; const ASelf: TCL3Versor2): TCL3Vector; end;
  TCL3Versor3 = record class operator *(const AValue: double; const ASelf: TCL3Versor3): TCL3Vector; end;

  // TCL3Biversor
  
  TCL3Biversor12 = record class operator *(const AValue: double; const ASelf: TCL3Biversor12): TCL3Bivector; end;
  TCL3Biversor13 = record class operator *(const AValue: double; const ASelf: TCL3Biversor13): TCL3Bivector; end;
  TCL3Biversor23 = record class operator *(const AValue: double; const ASelf: TCL3Biversor23): TCL3Bivector; end;

  // TCL3Triversor
  
  TCL3Triversor123 = record class operator *(const AValue: double; const ASelf: TCL3Triversor123): TCL3Trivector; end;

  { TCL3MultivecQuantity }

  {$IFNDEF ADIMOFF}
  TCL3MultivecQuantity = record
  private
    FID: TID;
    FValue: TCL3Multivector;
  public
    class operator <>(const ALeft, ARight: TCL3MultivecQuantity): boolean;
    class operator = (const ALeft, ARight: TCL3MultivecQuantity): boolean;
    class operator + (const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator - (const ASelf: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: double; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3MultivecQuantity; const ARight: double): TCL3MultivecQuantity;

    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): boolean;
    class operator <>(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): boolean;
    class operator = (const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): boolean;
    class operator = (const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): boolean;
    class operator + (const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
  end;
  {$ELSE}
  TCL3MultivecQuantity = TCL3Multivector;
  {$ENDIF}

  { TCL3TrivecQuantity }

  {$IFNDEF ADIMOFF}
  TCL3TrivecQuantity = record
  private
    FID: TID;
    FValue: TCL3Trivector;
  public
    class operator :=(const AValue: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator <>(const ALeft, ARight: TCL3TrivecQuantity): boolean;
    class operator <>(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): boolean;

    class operator = (const ALeft, ARight: TCL3TrivecQuantity): boolean;
    class operator = (const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
    class operator = (const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): boolean;

    class operator + (const ALeft, ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    class operator + (const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    class operator - (const ASelf: TCL3TrivecQuantity): TCL3TrivecQuantity;
    class operator - (const ALeft, ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;

    class operator - (const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    class operator * (const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    class operator / (const ALeft: double; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
    class operator / (const ALeft: TCL3TrivecQuantity; const ARight: double): TCL3TrivecQuantity;

    class operator / (const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    class operator + (const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft, ARight: TCL3TrivecQuantity): TQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
    class operator * (const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;
    class operator / (const ALeft, ARight: TCL3TrivecQuantity): TQuantity;
    class operator / (const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
  end;
  {$ELSE}
  TCL3TrivecQuantity = TCL3Trivector;
  {$ENDIF}

  { TCL3BivecQuantity }

  {$IFNDEF ADIMOFF}
  TCL3BivecQuantity = record
  private
    FID: TID;
    FValue: TCL3Bivector;
  public
    class operator :=(const AValue: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator <>(const ALeft, ARight: TCL3BivecQuantity): boolean;
    class operator <>(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): boolean;

    class operator = (const ALeft, ARight: TCL3BivecQuantity): boolean;
    class operator = (const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
    class operator = (const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): boolean;

    class operator + (const ALeft, ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    class operator + (const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    class operator - (const ASelf: TCL3BivecQuantity): TCL3BivecQuantity;
    class operator - (const ALeft, ARight: TCL3BivecQuantity): TCL3BivecQuantity;

    class operator - (const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    class operator * (const ALeft, ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    class operator * (const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    class operator / (const ALeft, ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    class operator / (const ALeft: double; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
    class operator / (const ALeft: TCL3BivecQuantity; const ARight: double): TCL3BivecQuantity;

    class operator / (const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;


    class operator + (const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
    class operator * (const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3BivecQuantity;
    class operator / (const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3BivecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
  end;
  {$ELSE}
  TCL3BivecQuantity = TCL3Bivector;
  {$ENDIF}

  { TCL3VecQuantity }

  {$IFNDEF ADIMOFF}
  TCL3VecQuantity = record
  private
    FID: TID;
    FValue: TCL3Vector;
  public
    class operator :=(const AValue: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator <>(const ALeft, ARight: TCL3VecQuantity): boolean;
    class operator <>(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): boolean;
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): boolean;

    class operator = (const ALeft, ARight: TCL3VecQuantity): boolean;
    class operator = (const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): boolean;
    class operator = (const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): boolean;

    class operator + (const ALeft, ARight: TCL3VecQuantity): TCL3VecQuantity;

    class operator + (const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    class operator - (const ASelf: TCL3VecQuantity): TCL3VecQuantity;
    class operator - (const ALeft, ARight: TCL3VecQuantity): TCL3VecQuantity;

    class operator - (const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    class operator * (const ALeft, ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    class operator * (const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3BivecQuantity;
    class operator * (const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3BivecQuantity;
    class operator * (const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    class operator / (const ALeft, ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    class operator / (const ALeft: double; const ARight: TCL3VecQuantity): TCL3VecQuantity;
    class operator / (const ALeft: TCL3VecQuantity; const ARight: double): TCL3VecQuantity;

    class operator / (const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3BivecQuantity;
    class operator / (const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3BivecQuantity;
    class operator / (const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    class operator + (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
    class operator * (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3VecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
    class operator / (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3VecQuantity;
  end;
  {$ELSE}
  TCL3VecQuantity = TCL3Vector;
  {$ENDIF}

const
  CL3NullMultivector : TCL3Multivector = (fm0:0.0; fm1:0.0; fm2:0.0; fm3:0.0; fm12:0.0; fm13:0.0; fm23:0.0; fm123:0.0);
  CL3NullTrivector   : TCL3Trivector   = (fm123:0.0);
  CL3NullBivector    : TCL3Bivector    = (fm12:0.0; fm13:0.0; fm23:0.0);
  CL3NullVector      : TCL3Vector      = (fm1: 0.0; fm2: 0.0; fm3: 0.0);
  CL3NullScalar      : double       = (0.0);
  
