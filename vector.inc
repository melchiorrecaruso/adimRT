type
  
  // TVectorComponents
  
  TVectorComponent  = (vc1, vc2, vc3);
  TVectorComponents = set of TVectorComponent;

  // TVector
  
  TVector = record
  private
    fm1: double;
    fm2: double;
    fm3: double;
  public
    class operator <>(const ALeft, ARight: TVector): boolean;
    class operator = (const ALeft, ARight: TVector): boolean;
    class operator + (const AVaLue: TVector): TVector;
    class operator + (const ALeft, ARight: TVector): TVector;
    class operator - (const AVaLue: TVector): TVector;
    class operator - (const ALeft, ARight: TVector): TVector;
    class operator * (const ALeft: double; const ARight: TVector): TVector;
    class operator * (const ALeft: TVector; const ARight: double): TVector;
    class operator / (const ALeft: double; const ARight: TVector): TVector;
    class operator / (const ALeft: TVector; const ARight: double): TVector;
  end;

  // TVectorHelper
  
  TVectorHelper = record helper for TVector
    function Reciprocal: TVector;
    function Normalized: TVector;
    function Norm: double;
    function SquaredNorm: double;

    function Dot(const AVector: TVector): double;
    function Cross(const AVector: TVector): TVector;
    function Projection(const AVector: TVector): TVector; overload;
    function Rejection(const AVector: TVector): TVector; overload;
    function Reflection(const AVector: TVector): TVector; overload;

    function SameValue(const AValue: TVector): boolean;
    function ExtractVector(AComponents: TVectorComponents): TVector;

    function ToString(APrecision, ADigits: longint): string;
    function ToString: string;
  end;

  // TVersor
  TVersor1 = record class operator *(const AValue: double; const ASelf: TVersor1): TVector; end;
  TVersor2 = record class operator *(const AValue: double; const ASelf: TVersor2): TVector; end;
  TVersor3 = record class operator *(const AValue: double; const ASelf: TVersor3): TVector; end;

const
  e1 : TVersor1 = ();
  e2 : TVersor2 = ();
  e3 : TVersor3 = ();

  u1 : TVector = (fm1:1.0; fm2:0.0; fm3:0.0);
  u2 : TVector = (fm1:0.0; fm2:1.0; fm3:0.0);
  u3 : TVector = (fm1:0.0; fm2:0.0; fm3:1.0);

  NullVector : TVector = (fm1: 0.0; fm2: 0.0; fm3: 0.0);
  NullScalar : double  = (0.0);    
  
 
