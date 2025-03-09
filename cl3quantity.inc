{ CL3 quantity interface }

type

  { TCL3MultivecQuantity }

  {$IFNDEF ADIMOFF}
  TCL3MultivecQuantity = record
  private
    FID: longint;
    FValue: TCL3Multivector;
  public
    class operator :=(const AValue: TQuantity): TCL3MultivecQuantity;
    class operator <>(const ALeft, ARight: TCL3MultivecQuantity): boolean;
    class operator <>(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): boolean;
    class operator <>(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): boolean;

    class operator = (const ALeft, ARight: TCL3MultivecQuantity): boolean;
    class operator = (const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): boolean;
    class operator = (const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): boolean;

    class operator + (const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    class operator - (const ASelf: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    class operator * (const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;

    class operator / (const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
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
    FID: longint;
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
    class operator + (const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    class operator - (const ASelf: TCL3TrivecQuantity): TCL3TrivecQuantity;
    class operator - (const ALeft, ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
    class operator - (const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    class operator * (const ALeft, ARight: TCL3TrivecQuantity): TQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
    class operator * (const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;
    class operator * (const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;

    class operator / (const ALeft, ARight: TCL3TrivecQuantity): TQuantity;
    class operator / (const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
    class operator / (const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
  end;
  {$ELSE}
  TCL3TrivecQuantity = TCL3Trivector;
  {$ENDIF}

  { TCL3BivecQuantity }

  {$IFNDEF ADIMOFF}
  TCL3BivecQuantity = record
  private
    FID: longint;
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
    class operator + (const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    class operator - (const ASelf: TCL3BivecQuantity): TCL3BivecQuantity;
    class operator - (const ALeft, ARight: TCL3BivecQuantity): TCL3BivecQuantity;
    class operator - (const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    class operator * (const ALeft, ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
    class operator * (const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3BivecQuantity;
    class operator * (const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;

    class operator / (const ALeft, ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3BivecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
    class operator / (const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
  end;
  {$ELSE}
  TCL3BivecQuantity = TCL3Bivector;
  {$ENDIF}

  { TCL3VecQuantity }

  {$IFNDEF ADIMOFF}
  TCL3VecQuantity = record
  private
    FID: longint;
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
    class operator + (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator + (const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    class operator - (const ASelf: TCL3VecQuantity): TCL3VecQuantity;
    class operator - (const ALeft, ARight: TCL3VecQuantity): TCL3VecQuantity;
    class operator - (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator - (const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    class operator * (const ALeft, ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
    class operator * (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3VecQuantity;
    class operator * (const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3BivecQuantity;
    class operator * (const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator * (const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3BivecQuantity;
    class operator * (const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;

    class operator / (const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
    class operator / (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3VecQuantity;
    class operator / (const ALeft, ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3BivecQuantity;
    class operator / (const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
    class operator / (const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3BivecQuantity;
    class operator / (const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
  end;
  {$ELSE}
  TCL3VecQuantity = TCL3Vector;
  {$ENDIF}

  { TCL3MultivecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TCL3MultivecQuantityHelper = record helper for TCL3MultivecQuantity
    function Dual: TCL3MultivecQuantity;
    function Inverse: TCL3MultivecQuantity;
    function Reverse: TCL3MultivecQuantity;
    function Conjugate: TCL3MultivecQuantity;
    function Reciprocal: TCL3MultivecQuantity;
    function LeftReciprocal: TCL3MultivecQuantity;
    function Normalized: TCL3MultivecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;
    function Dot(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;
    function Dot(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity; overload;
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Wedge(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;
    function Wedge(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;
    function Wedge(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity; overload;
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Projection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;
    function Projection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;
    function Projection(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity; overload;
    function Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Rejection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;
    function Rejection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;
    function Rejection(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Reflection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity; overload;
    function Reflection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity; overload;
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity; overload;
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3MultivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3MultivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3MultivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;overload;

    function SameValue(const AVector: TCL3MultivecQuantity): boolean;
    function SameValue(const AVector: TCL3TrivecQuantity): boolean;
    function SameValue(const AVector: TCL3BivecQuantity): boolean;
    function SameValue(const AVector: TCL3VecQuantity): boolean;
    function SameValue(const AVector: TQuantity): boolean;

    function ExtractMultivector(AComponents: TCL3MultivectorComponents): TCL3MultivecQuantity;
    function ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3BivecQuantity;
    function ExtractVector(AComponents: TCL3MultivectorComponents): TCL3VecQuantity;

    function ExtractTrivector: TCL3TrivecQuantity;
    function ExtractBivector: TCL3BivecQuantity;
    function ExtractVector: TCL3VecQuantity;
    function ExtractScalar: TQuantity;

    function IsNull: boolean;
    function IsScalar: boolean;
    function IsVector: boolean;
    function IsBiVector: boolean;
    function IsTrivector: boolean;
    function IsA: string;
  end;
  {$ENDIF}

  { TCL3TrivecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TCL3TrivecQuantityHelper = record helper for TCL3TrivecQuantity
    function Dual: TQuantity;
    function Inverse: TCL3TrivecQuantity;
    function Reverse: TCL3TrivecQuantity;
    function Conjugate: TCL3TrivecQuantity;
    function Reciprocal: TCL3TrivecQuantity;
    function Normalized: TCL3TrivecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;
    function Dot(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;
    function Dot(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Wedge(const AVector: TCL3VecQuantity): TQuantity; overload;
    function Wedge(const AVector: TCL3BivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity; overload;

    function Projection(const AVector: TCL3VecQuantity): TCL3TrivecQuantity; overload;
    function Projection(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity; overload;
    function Projection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity; overload;
    function Projection(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity; overload;

    function Rejection(const AVector: TCL3VecQuantity): TQuantity; overload;
    function Rejection(const AVector: TCL3BivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Reflection(const AVector: TCL3VecQuantity): TCL3TrivecQuantity; overload;
    function Reflection(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity; overload;
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity; overload;
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3TrivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3TrivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3TrivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3TrivecQuantity; overload;

    function SameValue(const AVector: TCL3MultivecQuantity): boolean;
    function SameValue(const AVector: TCL3TrivecQuantity): boolean;

    function ToMultivector: TCL3MultivecQuantity;
  end;
  {$ENDIF}

  { TCL3BivecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TCL3BivecQuantityHelper = record helper for TCL3BivecQuantity
    function Dual: TCL3VecQuantity;
    function Inverse: TCL3BivecQuantity;
    function Reverse: TCL3BivecQuantity;
    function Conjugate: TCL3BivecQuantity;
    function Reciprocal: TCL3BivecQuantity;
    function Normalized: TCL3BivecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TCL3VecQuantity): TCL3VecQuantity; overload;
    function Dot(const AVector: TCL3BivecQuantity): TQuantity; overload;
    function Dot(const AVector: TCL3TrivecQuantity): TCL3VecQuantity; overload;
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Wedge(const AVector: TCL3VecQuantity): TCL3TrivecQuantity; overload;
    function Wedge(const AVector: TCL3BivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Projection(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;
    function Projection(const AVector: TCL3BivecQuantity): TCL3BivecQuantity; overload;
    function Projection(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity; overload;
    function Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Rejection(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;
    function Rejection(const AVector: TCL3BivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Reflection(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;
    function Reflection(const AVector: TCL3BivecQuantity): TCL3BivecQuantity; overload;
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity; overload;
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3BivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3BivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3BivecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function SameValue(const AVector: TCL3MultivecQuantity): boolean;
    function SameValue(const AVector: TCL3BivecQuantity): boolean;

    function ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3BivecQuantity;

    function ToMultivector: TCL3MultivecQuantity;
  end;
  {$ENDIF}

  { TCL3VecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TCL3VecQuantityHelper = record helper for TCL3VecQuantity
    function Dual: TCL3BivecQuantity;
    function Inverse: TCL3VecQuantity;
    function Reverse: TCL3VecQuantity;
    function Conjugate: TCL3VecQuantity;
    function Reciprocal: TCL3VecQuantity;
    function Normalized: TCL3VecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TCL3VecQuantity): TQuantity; overload;
    function Dot(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;
    function Dot(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity; overload;
    function Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Wedge(const AVector: TCL3VecQuantity): TCL3BivecQuantity; overload;
    function Wedge(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity; overload;
    function Wedge(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Cross(const AVector: TCL3VecQuantity): TCL3VecQuantity;

    function Projection(const AVector: TCL3VecQuantity): TCL3VecQuantity; overload;
    function Projection(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;
    function Projection(const AVector: TCL3TrivecQuantity): TCL3VecQuantity; overload;
    function Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Rejection(const AVector: TCL3VecQuantity): TCL3VecQuantity; overload;
    function Rejection(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;
    function Rejection(const AVector: TCL3TrivecQuantity): TQuantity; overload;
    function Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Reflection(const AVector: TCL3VecQuantity): TCL3VecQuantity; overload;
    function Reflection(const AVector: TCL3BivecQuantity): TCL3VecQuantity; overload;
    function Reflection(const AVector: TCL3TrivecQuantity): TCL3VecQuantity; overload;
    function Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3VecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3VecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3VecQuantity; overload;
    function Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity; overload;

    function SameValue(const AVector: TCL3MultivecQuantity): boolean;
    function SameValue(const AVector: TCL3VecQuantity): boolean;

    function ExtractVector(AComponents: TCL3MultivectorComponents): TCL3VecQuantity;

    function ToMultivector: TCL3MultivecQuantity;
  end;
  {$ENDIF}

