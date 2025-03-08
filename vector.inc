{ Vector interface }

type
  
  // TVectorComponents
  
  TVectorComponent  = (vcm1, vcm2, vcm3);
  TVectorComponents = set of TVectorComponent;

  // TVector
  
  TVector = record
  private
    fm1, fm2, fm3: double;
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
  public
    property m1: double read fm1 write fm1;
    property m2: double read fm2 write fm2;
    property m3: double read fm3 write fm3;
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

  // T2x2Matrix

  T2x2Matrix = record
  private
    fm11, fm12,
    fm21, fm22: double;
  public
    function Transpose: T2x2Matrix;
    function Determinant: double;
    function Reciprocal(const ADeterminant: double): T2x2Matrix;
    function ToString: string;
    class operator:=(const ASelf: T2x2Matrix): TC2Matrix;
    class operator +(const ALeft, ARight: T2x2Matrix): T2x2Matrix;
    class operator -(const ALeft, ARight: T2x2Matrix): T2x2Matrix;
    class operator *(const ALeft: double; const ARight: T2x2Matrix): T2x2Matrix;
    class operator *(const ALeft: T2x2Matrix; const ARight: double): T2x2Matrix;
    class operator *(const ALeft, ARight: T2x2Matrix): T2x2Matrix;
    class operator /(const ALeft: T2x2Matrix; const ARight: double): T2x2Matrix;
    class operator /(const ALeft: double; const ARight: T2x2Matrix): T2x2Matrix;
    class operator /(const ALeft, ARight: T2x2Matrix): T2x2Matrix;
  public
    property a11: double read fm11 write fm11;
    property a12: double read fm12 write fm12;

    property a21: double read fm21 write fm21;
    property a22: double read fm22 write fm22;
  end;

  // T3x3Matrix

  T3x3Matrix = record
  private
    fm11, fm12, fm13,
    fm21, fm22, fm23,
    fm31, fm32, fm33: double;
  public
    function Transpose: T3x3Matrix;
    function Determinant: double;
    function Reciprocal(const ADeterminant: double): T3x3Matrix;
    function ToString: string;
    class operator:=(const ASelf: T3x3Matrix): TC3Matrix;
    class operator +(const ALeft, ARight: T3x3Matrix): T3x3Matrix;
    class operator -(const ALeft, ARight: T3x3Matrix): T3x3Matrix;
    class operator *(const ALeft: double; const ARight: T3x3Matrix): T3x3Matrix;
    class operator *(const ALeft: T3x3Matrix; const ARight: double): T3x3Matrix;
    class operator *(const ALeft, ARight: T3x3Matrix): T3x3Matrix;
    class operator /(const ALeft: T3x3Matrix; const ARight: double): T3x3Matrix;
    class operator /(const ALeft: double; const ARight: T3x3Matrix): T3x3Matrix;
    class operator /(const ALeft, ARight: T3x3Matrix): T3x3Matrix;
  public
    property a11: double read fm11 write fm11;
    property a12: double read fm12 write fm12;
    property a13: double read fm13 write fm13;

    property a21: double read fm21 write fm21;
    property a22: double read fm22 write fm22;
    property a23: double read fm23 write fm23;

    property a31: double read fm31 write fm31;
    property a32: double read fm32 write fm32;
    property a33: double read fm33 write fm33;
  end;

  // T4x4Matrix

  T4x4Matrix = record
  private
    fm11, fm12, fm13, fm14,
    fm21, fm22, fm23, fm24,
    fm31, fm32, fm33, fm34,
    fm41, fm42, fm43, fm44: double;
  public
    function Transpose: T4x4Matrix;
    function Determinant: double;
    function Reciprocal(const ADeterminant: double): T4x4Matrix;
    function ToString: string;
    class operator +(const ALeft, ARight: T4x4Matrix): T4x4Matrix;
    class operator -(const ALeft, ARight: T4x4Matrix): T4x4Matrix;
    class operator *(const ALeft: double; const ARight: T4x4Matrix): T4x4Matrix;
    class operator *(const ALeft: T4x4Matrix; const ARight: double): T4x4Matrix;
    class operator *(const ALeft, ARight: T4x4Matrix): T4x4Matrix;
    class operator /(const ALeft: T4x4Matrix; const ARight: double): T4x4Matrix;
    class operator /(const ALeft: double; const ARight: T4x4Matrix): T4x4Matrix;
    class operator /(const ALeft, ARight: T4x4Matrix): T4x4Matrix;
  public
    property a11: double read fm11 write fm11;
    property a12: double read fm12 write fm12;
    property a13: double read fm13 write fm13;
    property a14: double read fm14 write fm14;

    property a21: double read fm21 write fm21;
    property a22: double read fm22 write fm22;
    property a23: double read fm23 write fm23;
    property a24: double read fm24 write fm24;

    property a31: double read fm31 write fm31;
    property a32: double read fm32 write fm32;
    property a33: double read fm33 write fm33;
    property a34: double read fm34 write fm34;

    property a41: double read fm41 write fm41;
    property a42: double read fm42 write fm42;
    property a43: double read fm43 write fm43;
    property a44: double read fm44 write fm44;
  end;


const
  e1 : TVersor1 = ();
  e2 : TVersor2 = ();
  e3 : TVersor3 = ();

  u1 : TVector = (fm1:1.0; fm2:0.0; fm3:0.0);
  u2 : TVector = (fm1:0.0; fm2:1.0; fm3:0.0);
  u3 : TVector = (fm1:0.0; fm2:0.0; fm3:1.0);

  NullVector : TVector = (fm1: 0.0; fm2: 0.0; fm3: 0.0);
  NullScalar : double  = (0.0);

function Vector(const m1, m2, m3: double): TVector;
function Matrix(const m11, m12, m21, m22: double): T2x2Matrix;
function Matrix(const m11, m12, m13, m21, m22, m23, m31, m32, m33: double): T3x3Matrix;
function Matrix(const m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44: double): T4x4Matrix;

