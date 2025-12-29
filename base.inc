type
  TDimension = record
  private
    FKilogram:  smallint;
    FMeter:     smallint;
    FSecond:    smallint;
    FAmpere:    smallint;
    FKelvin:    smallint;
    FMole:      smallint;
    FCandela:   smallint;
    FSteradian: smallint;
  public
    function ToString: string;
    class operator   +(const ASelf: TDimension): TDimension;
    class operator   -(const ASelf: TDimension): TDimension;
    class operator   +(const ALeft, ARight: TDimension): TDimension;
    class operator   -(const ALeft, ARight: TDimension): TDimension;
    class operator   *(const ALeft: longint; ARight: TDimension): TDimension;
    class operator   *(const ALeft: TDimension; ARight: longint): TDimension;
    class operator div(const ALeft: TDimension; ARight: longint): TDimension;
    class operator  <>(const ALeft, ARight: TDimension): boolean;
    class operator   =(const ALeft, ARight: TDimension): boolean;
  end;

  { Check routines }

  procedure Check(ALeft, ARight: TDimension); inline;
  function CheckEqual(ALeft, ARight: TDimension): TDimension; inline;
  function CheckSum(ALeft, ARight: TDimension): TDimension; inline;
  function CheckSub(ALeft, ARight: TDimension): TDimension; inline;
  function CheckMul(ALeft, ARight: TDimension): TDimension; inline;
  function CheckDiv(ALeft, ARight: TDimension): TDimension; inline;

