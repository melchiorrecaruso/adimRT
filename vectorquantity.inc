
type

  { TVecQuantity }

  {$IFDEF ADIMDEBUG}
  TVecQuantity = record
  private
    FID: longint;
    FValue: TVector;
  public
    class operator <>(const ALeft, ARight: TVecQuantity): boolean;
    class operator = (const ALeft, ARight: TVecQuantity): boolean;
    class operator + (const AValue: TVecQuantity): TVecQuantity;
    class operator + (const ALeft, ARight: TVecQuantity): TVecQuantity;
    class operator - (const AValue: TVecQuantity): TVecQuantity;
    class operator - (const ALeft, ARight: TVecQuantity): TVecQuantity;
    class operator * (const ALeft: TQuantity; const ARight: TVecQuantity): TVecQuantity;
    class operator * (const ALeft: TVecQuantity; const ARight: TQuantity): TVecQuantity;
    class operator / (const ALeft: TQuantity; const ARight: TVecQuantity): TVecQuantity;
    class operator / (const ALeft: TVecQuantity; const ARight: TQuantity): TVecQuantity;
  end;
  {$ELSE}
  TVecQuantity = TVector;
  {$ENDIF}

  { TVecQuantityHelper }

  {$IFDEF ADIMDEBUG}
  TVecQuantityHelper = record helper for TVecQuantity
    function Reciprocal: TVecQuantity;
    function Normalized: TVecQuantity;
    function Norm: TQuantity;
    function SquaredNorm: TQuantity;

    function Dot(const AVector: TVecQuantity): TQuantity;
    function Cross(const AVector: TVecQuantity): TVecQuantity;
    function Projection(const AVersor: TVector): TVecQuantity;
    function Rejection(const AVersor: TVector): TVecQuantity; overload;
    function Reflection(const AVersor: TVector): TVecQuantity; overload;

    function ExtractVector(AComponents: TVectorComponents): TVecQuantity;
    function SameValue(const AVector: TVecQuantity): boolean;
  end;
  {$ENDIF}





