type
  TID = record
  private
    FKilogram: smallint;
    FMeter: smallint;
    FSecond: smallint;
    FAmpere: smallint;
    FKelvin: smallint;
    FMole: smallint;
    FCandela: smallint;
    FRadian: smallint;
  public
    class operator  <>(const ALeft, ARight: TID): boolean;
    class operator   =(const ALeft, ARight: TID): boolean;
    class operator   +(const ALeft, ARight: TID): TID;
    class operator   -(const ALeft, ARight: TID): TID;
    class operator   *(const ALeft: longint; ARight: TID): TID;
    class operator   *(const ALeft: TID; ARight: longint): TID;
    class operator div(const ALeft: TID; ARight: longint): TID;
  end;

