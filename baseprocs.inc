// TDimension

class operator TDimension.<>(const ALeft, ARight: TDimension): boolean;
begin
  result := (ALeft.FKilogram  <> ARight.FKilogram ) and
            (ALeft.FMeter     <> ARight.FMeter    ) and
            (ALeft.FSecond    <> ARight.FSecond   ) and
            (ALeft.FAmpere    <> ARight.FAmpere   ) and
            (ALeft.FKelvin    <> ARight.FKelvin   ) and
            (ALeft.FMole      <> ARight.FMole     ) and
            (ALeft.FCandela   <> ARight.FCandela  ) and
            (ALeft.FRadian    <> ARight.FRadian   );
end;

class operator TDimension.=(const ALeft, ARight: TDimension): boolean;
begin
  result := (ALeft.FKilogram  = ARight.FKilogram ) and
            (ALeft.FMeter     = ARight.FMeter    ) and
            (ALeft.FSecond    = ARight.FSecond   ) and
            (ALeft.FAmpere    = ARight.FAmpere   ) and
            (ALeft.FKelvin    = ARight.FKelvin   ) and
            (ALeft.FMole      = ARight.FMole     ) and
            (ALeft.FCandela   = ARight.FCandela  ) and
            (ALeft.FRadian    = ARight.FRadian   );
end;

class operator TDimension.+(const ALeft, ARight: TDimension): TDimension;
begin
  result.FKilogram  := ALeft.FKilogram  + ARight.FKilogram;
  result.FMeter     := ALeft.FMeter     + ARight.FMeter;
  result.FSecond    := ALeft.FSecond    + ARight.FSecond;
  result.FAmpere    := ALeft.FAmpere    + ARight.FAmpere;
  result.FKelvin    := ALeft.FKelvin    + ARight.FKelvin;
  result.FMole      := ALeft.FMole      + ARight.FMole;
  result.FCandela   := ALeft.FCandela   + ARight.FCandela;
  result.FRadian    := ALeft.FRadian    + ARight.FRadian;
end;

class operator TDimension.-(const ALeft, ARight: TDimension): TDimension;
begin
  result.FKilogram  := ALeft.FKilogram  - ARight.FKilogram;
  result.FMeter     := ALeft.FMeter     - ARight.FMeter;
  result.FSecond    := ALeft.FSecond    - ARight.FSecond;
  result.FAmpere    := ALeft.FAmpere    - ARight.FAmpere;
  result.FKelvin    := ALeft.FKelvin    - ARight.FKelvin;
  result.FMole      := ALeft.FMole      - ARight.FMole;
  result.FCandela   := ALeft.FCandela   - ARight.FCandela;
  result.FRadian    := ALeft.FRadian    - ARight.FRadian;
end;

class operator TDimension.*(const ALeft: longint; ARight: TDimension): TDimension;
begin
  result.FKilogram  := ALeft * ARight.FKilogram;
  result.FMeter     := ALeft * ARight.FMeter;
  result.FSecond    := ALeft * ARight.FSecond;
  result.FAmpere    := ALeft * ARight.FAmpere;
  result.FKelvin    := ALeft * ARight.FKelvin;
  result.FMole      := ALeft * ARight.FMole;
  result.FCandela   := ALeft * ARight.FCandela;
  result.FRadian    := ALeft * ARight.FRadian;
end;

class operator TDimension.*(const ALeft: TDimension; ARight: longint): TDimension;
begin
  result.FKilogram  := ALeft.FKilogram  * ARight;
  result.FMeter     := ALeft.FMeter     * ARight;
  result.FSecond    := ALeft.FSecond    * ARight;
  result.FAmpere    := ALeft.FAmpere    * ARight;
  result.FKelvin    := ALeft.FKelvin    * ARight;
  result.FMole      := ALeft.FMole      * ARight;
  result.FCandela   := ALeft.FCandela   * ARight;
  result.FRadian    := ALeft.FRadian    * ARight;
end;

class operator TDimension.div(const ALeft: TDimension; ARight: longint): TDimension;
begin
  result.FKilogram  := ALeft.FKilogram  div ARight;
  result.FMeter     := ALeft.FMeter     div ARight;
  result.FSecond    := ALeft.FSecond    div ARight;
  result.FAmpere    := ALeft.FAmpere    div ARight;
  result.FKelvin    := ALeft.FKelvin    div ARight;
  result.FMole      := ALeft.FMole      div ARight;
  result.FCandela   := ALeft.FCandela   div ARight;
  result.FRadian    := ALeft.FRadian    div ARight;
end;

