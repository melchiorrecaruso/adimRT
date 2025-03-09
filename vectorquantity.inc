{ Vector quantity interface }

type

  { TR3VecQuantity }

  {$IFNDEF ADIMOFF}
  TR3VecQuantity = record
  private
    FID: longint;
    FValue: TR3Vector;
  public
    class operator <>(const ALeft, ARight: TR3VecQuantity): boolean;
    class operator = (const ALeft, ARight: TR3VecQuantity): boolean;
    class operator + (const AValue: TR3VecQuantity): TR3VecQuantity;
    class operator + (const ALeft, ARight: TR3VecQuantity): TR3VecQuantity;
    class operator - (const AValue: TR3VecQuantity): TR3VecQuantity;
    class operator - (const ALeft, ARight: TR3VecQuantity): TR3VecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TR3VecQuantity): TR3VecQuantity;
    class operator * (const ALeft: TR3VecQuantity; const ARight: TQuantity): TR3VecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TR3VecQuantity): TR3VecQuantity;
    class operator / (const ALeft: TR3VecQuantity; const ARight: TQuantity): TR3VecQuantity;
  end;
  {$ELSE}
  TR3VecQuantity = TR3Vector;
  {$ENDIF}

  { TR3VecQuantityHelper }

  {$IFNDEF ADIMOFF}
  TR3VecQuantityHelper = record helper for TR3VecQuantity
    function Reciprocal: TR3VecQuantity;
    function Normalized: TR3VecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TR3VecQuantity): TQuantity;
    function Cross(const AVector: TR3VecQuantity): TR3VecQuantity;
    function Projection(const AVersor: TR3Vector): TR3VecQuantity;
    function Rejection(const AVersor: TR3Vector): TR3VecQuantity; overload;
    function Reflection(const AVersor: TR3Vector): TR3VecQuantity; overload;

    function ExtractVector(AComponents: TVectorComponents): TR3VecQuantity;
    function SameValue(const AVector: TR3VecQuantity): boolean;
  end;
  {$ENDIF}





