{ Vector interface }

type
  
  // TVectorComponents
  
  TVectorComponent  = (vcm1, vcm2, vcm3);
  TVectorComponents = set of TVectorComponent;

  // TR3Vector
  
  TR3Vector = record
  private
    fm1, fm2, fm3: double;
  public
    class operator <>(const ALeft, ARight: TR3Vector): boolean;
    class operator = (const ALeft, ARight: TR3Vector): boolean;
    class operator + (const AVaLue: TR3Vector): TR3Vector;
    class operator + (const ALeft, ARight: TR3Vector): TR3Vector;
    class operator - (const AVaLue: TR3Vector): TR3Vector;
    class operator - (const ALeft, ARight: TR3Vector): TR3Vector;
    class operator * (const ALeft: double; const ARight: TR3Vector): TR3Vector;
    class operator * (const ALeft: TR3Vector; const ARight: double): TR3Vector;
    class operator / (const ALeft: double; const ARight: TR3Vector): TR3Vector;
    class operator / (const ALeft: TR3Vector; const ARight: double): TR3Vector;
  public
    property m1: double read fm1 write fm1;
    property m2: double read fm2 write fm2;
    property m3: double read fm3 write fm3;
  end;

  // TR3VectorHelper

  TR3VectorHelper = record helper for TR3Vector
    function Reciprocal: TR3Vector;
    function Normalized: TR3Vector;
    function Norm: double;
    function SquaredNorm: double;
    function Dot(const AVector: TR3Vector): double;
    function Cross(const AVector: TR3Vector): TR3Vector;
    function Projection(const AVector: TR3Vector): TR3Vector; overload;
    function Rejection(const AVector: TR3Vector): TR3Vector; overload;
    function Reflection(const AVector: TR3Vector): TR3Vector; overload;
    function SameValue(const AValue: TR3Vector): boolean;
    function ExtractVector(AComponents: TVectorComponents): TR3Vector;
    function ToString(APrecision, ADigits: longint): string;
    function ToString: string;
  end;

  // TR3Versor
  TR3Versor1 = record class operator *(const AValue: double; const ASelf: TR3Versor1): TR3Vector; end;
  TR3Versor2 = record class operator *(const AValue: double; const ASelf: TR3Versor2): TR3Vector; end;
  TR3Versor3 = record class operator *(const AValue: double; const ASelf: TR3Versor3): TR3Vector; end;

  // TR2Matrix into vectorial space R2

  TR2Matrix = record
  private
    fm11, fm12,
    fm21, fm22: double;
  public
    function Transpose: TR2Matrix;
    function Determinant: double;
    function Reciprocal(const ADeterminant: double): TR2Matrix;
    function ToString: string;
    class operator:=(const ASelf: TR2Matrix): TC2Matrix;
    class operator +(const ALeft, ARight: TR2Matrix): TR2Matrix;
    class operator -(const ALeft, ARight: TR2Matrix): TR2Matrix;
    class operator *(const ALeft: double; const ARight: TR2Matrix): TR2Matrix;
    class operator *(const ALeft: TR2Matrix; const ARight: double): TR2Matrix;
    class operator *(const ALeft, ARight: TR2Matrix): TR2Matrix;
    class operator /(const ALeft: TR2Matrix; const ARight: double): TR2Matrix;
    class operator /(const ALeft: double; const ARight: TR2Matrix): TR2Matrix;
    class operator /(const ALeft, ARight: TR2Matrix): TR2Matrix;
  public
    property a11: double read fm11 write fm11;
    property a12: double read fm12 write fm12;

    property a21: double read fm21 write fm21;
    property a22: double read fm22 write fm22;
  end;

  // TR3Matrix into vectorial space R3

  TR3Matrix = record
  private
    fm11, fm12, fm13,
    fm21, fm22, fm23,
    fm31, fm32, fm33: double;
  public
    function Transpose: TR3Matrix;
    function Determinant: double;
    function Reciprocal(const ADeterminant: double): TR3Matrix;
    function ToString: string;
    class operator:=(const ASelf: TR3Matrix): TC3Matrix;
    class operator +(const ALeft, ARight: TR3Matrix): TR3Matrix;
    class operator -(const ALeft, ARight: TR3Matrix): TR3Matrix;
    class operator *(const ALeft: double; const ARight: TR3Matrix): TR3Matrix;
    class operator *(const ALeft: TR3Matrix; const ARight: double): TR3Matrix;
    class operator *(const ALeft, ARight: TR3Matrix): TR3Matrix;
    class operator /(const ALeft: TR3Matrix; const ARight: double): TR3Matrix;
    class operator /(const ALeft: double; const ARight: TR3Matrix): TR3Matrix;
    class operator /(const ALeft, ARight: TR3Matrix): TR3Matrix;
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

  // TR4Matrix into vectorial space R4

  TR4Matrix = record
  private
    fm11, fm12, fm13, fm14,
    fm21, fm22, fm23, fm24,
    fm31, fm32, fm33, fm34,
    fm41, fm42, fm43, fm44: double;
  public
    function Transpose: TR4Matrix;
    function Determinant: double;
    function Reciprocal(const ADeterminant: double): TR4Matrix;
    function ToString: string;
    class operator +(const ALeft, ARight: TR4Matrix): TR4Matrix;
    class operator -(const ALeft, ARight: TR4Matrix): TR4Matrix;
    class operator *(const ALeft: double; const ARight: TR4Matrix): TR4Matrix;
    class operator *(const ALeft: TR4Matrix; const ARight: double): TR4Matrix;
    class operator *(const ALeft, ARight: TR4Matrix): TR4Matrix;
    class operator /(const ALeft: TR4Matrix; const ARight: double): TR4Matrix;
    class operator /(const ALeft: double; const ARight: TR4Matrix): TR4Matrix;
    class operator /(const ALeft, ARight: TR4Matrix): TR4Matrix;
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
  e1 : TR3Versor1 = ();
  e2 : TR3Versor2 = ();
  e3 : TR3Versor3 = ();

  u1 : TR3Vector = (fm1:1.0; fm2:0.0; fm3:0.0);
  u2 : TR3Vector = (fm1:0.0; fm2:1.0; fm3:0.0);
  u3 : TR3Vector = (fm1:0.0; fm2:0.0; fm3:1.0);

  NullVector : TR3Vector = (fm1: 0.0; fm2: 0.0; fm3: 0.0);
  NullScalar : double  = (0.0);

function Vector(const m1, m2, m3: double): TR3Vector;
function Matrix(const m11, m12, m21, m22: double): TR2Matrix;
function Matrix(const m11, m12, m13, m21, m22, m23, m31, m32, m33: double): TR3Matrix;
function Matrix(const m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44: double): TR4Matrix;

