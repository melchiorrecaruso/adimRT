type
  TDimension = record
  private
    FKilogram: smallint;
    FMeter:    smallint;
    FSecond:   smallint;
    FAmpere:   smallint;
    FKelvin:   smallint;
    FMole:     smallint;
    FCandela:  smallint;
    FRadian:   smallint;
  public
    class operator  <>(const ALeft, ARight: TDimension): boolean;
    class operator   =(const ALeft, ARight: TDimension): boolean;
    class operator   +(const ALeft, ARight: TDimension): TDimension;
    class operator   -(const ALeft, ARight: TDimension): TDimension;
    class operator   *(const ALeft: longint; ARight: TDimension): TDimension;
    class operator   *(const ALeft: TDimension; ARight: longint): TDimension;
    class operator div(const ALeft: TDimension; ARight: longint): TDimension;
  end;

