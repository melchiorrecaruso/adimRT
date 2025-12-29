
// TDimension

class operator TDimension.+(const ASelf: TDimension): TDimension;
begin
  result.FKilogram  := ASelf.FKilogram;
  result.FMeter     := ASelf.FMeter;
  result.FSecond    := ASelf.FSecond;
  result.FAmpere    := ASelf.FAmpere;
  result.FKelvin    := ASelf.FKelvin;
  result.FMole      := ASelf.FMole;
  result.FCandela   := ASelf.FCandela;
  result.FSteradian := ASelf.FSteradian;
end;

class operator TDimension.-(const ASelf: TDimension): TDimension;
begin
  result.FKilogram  := -ASelf.FKilogram;
  result.FMeter     := -ASelf.FMeter;
  result.FSecond    := -ASelf.FSecond;
  result.FAmpere    := -ASelf.FAmpere;
  result.FKelvin    := -ASelf.FKelvin;
  result.FMole      := -ASelf.FMole;
  result.FCandela   := -ASelf.FCandela;
  result.FSteradian := -ASelf.FSteradian;
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
  result.FSteradian := ALeft.FSteradian + ARight.FSteradian;
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
  result.FSteradian := ALeft.FSteradian - ARight.FSteradian;
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
  result.FSteradian := ALeft * ARight.FSteradian;
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
  result.FSteradian := ALeft.FSteradian * ARight;
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
  result.FSteradian := ALeft.FSteradian div ARight;
end;

class operator TDimension.<>(const ALeft, ARight: TDimension): boolean;
begin
  result := (ALeft.FKilogram  <> ARight.FKilogram ) or
            (ALeft.FMeter     <> ARight.FMeter    ) or
            (ALeft.FSecond    <> ARight.FSecond   ) or
            (ALeft.FAmpere    <> ARight.FAmpere   ) or
            (ALeft.FKelvin    <> ARight.FKelvin   ) or
            (ALeft.FMole      <> ARight.FMole     ) or
            (ALeft.FCandela   <> ARight.FCandela  ) or
            (ALeft.FSteradian <> ARight.FSteradian);
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
            (ALeft.FSteradian = ARight.FSteradian);
end;

function SymbolToString(AExponent: smallint; const ASymbol: string): string; inline;
begin
  AExponent := System.Abs(AExponent);
  if (AExponent = 10 ) then result := '⁶√' + Format('%s',  [ASymbol]) else
  if (AExponent = 12 ) then result := '⁵√' + Format('%s',  [ASymbol]) else
  if (AExponent = 15 ) then result :=  '∜' + Format('%s' , [ASymbol]) else
  if (AExponent = 20 ) then result :=  '∛' + Format('%s' , [ASymbol]) else
  if (AExponent = 30 ) then result :=  '√' + Format('%s' , [ASymbol]) else
  if (AExponent = 45 ) then result :=  '∜' + Format('%s3', [ASymbol]) else
  if (AExponent = 60 ) then result :=        Format('%s' , [ASymbol]) else
  if (AExponent = 90 ) then result :=  '√' + Format('%s3', [ASymbol]) else
  if (AExponent = 120) then result :=        Format('%s2', [ASymbol]) else
  if (AExponent = 150) then result :=  '√' + Format('%s5', [ASymbol]) else
  if (AExponent = 180) then result :=        Format('%s3', [ASymbol]) else
  if (AExponent = 240) then result :=        Format('%s4', [ASymbol]) else
  if (AExponent = 300) then result :=        Format('%s5', [ASymbol]) else
  if (AExponent = 360) then result :=        Format('%s6', [ASymbol]) else
    raise Exception.CreateFmt('ERROR: SymbolToString (%s)', [AExponent.ToString]);
end;

function TDimension.ToString: string;
var
  Num, Denom: string;
begin
  Num := '';
  if FKilogram  > 0 then Num := Num + '.' + SymbolToString(FKilogram,  'kg');
  if FMeter     > 0 then Num := Num + '.' + SymbolToString(FMeter,      'm');
  if FSecond    > 0 then Num := Num + '.' + SymbolToString(FSecond,     's');
  if FAmpere    > 0 then Num := Num + '.' + SymbolToString(FAmpere,     'A');
  if FKelvin    > 0 then Num := Num + '.' + SymbolToString(FKelvin,     'K');
  if FMole      > 0 then Num := Num + '.' + SymbolToString(FMole,     'mol');
  if FCandela   > 0 then Num := Num + '.' + SymbolToString(FCandela,   'cd');
  if FSteradian > 0 then Num := Num + '.' + SymbolToString(FSteradian, 'sr');

  if (Length(Num) > 0) then Delete(Num, 1, 1);

  Denom := '';
  if FKilogram  < 0 then Denom := Denom + '/' + SymbolToString(FKilogram, '%skg');
  if FMeter     < 0 then Denom := Denom + '/' + SymbolToString(FMeter,     '%sm');
  if FSecond    < 0 then Denom := Denom + '/' + SymbolToString(FSecond,    '%ss');
  if FAmpere    < 0 then Denom := Denom + '/' + SymbolToString(FAmpere,    '%sA');
  if FKelvin    < 0 then Denom := Denom + '/' + SymbolToString(FKelvin,    '%sK');
  if FMole      < 0 then Denom := Denom + '/' + SymbolToString(FMole,    '%smol');
  if FCandela   < 0 then Denom := Denom + '/' + SymbolToString(FCandela,  '%scd');
  if FSteradian < 0 then Denom := Denom + '/' + SymbolToString(FSteradian,  'sr');

  if Num = '' then
  begin
    if Denom = '' then
      result := ''
    else
      result := '1' + Denom;
  end else
  begin
    if Denom = '' then
      result := Num
    else
      result := Num + Denom
  end;

  while (Length(result) > 0) and (result[Low (result)] = ' ') do Delete(result, Low (result), 1);
  while (Length(result) > 0) and (result[High(result)] = ' ') do Delete(result, High(result), 1);
  result := StringReplace(result, '//', '/', [rfReplaceAll]);
  result := StringReplace(result, '  ', ' ', [rfReplaceAll]);
end;

// Check routines

{$IFNDEF ADIMOFF}
  {$ASSERTIONS ON}
{$ENDIF}

procedure Check(ALeft, ARight: TDimension);
begin
  Assert(ALeft = ARight, Format('Wrong units of measurement detected, %s expected but %s found', [ALeft.ToString, ARight.ToString]));
end;

function CheckEqual(ALeft, ARight: TDimension): TDimension;
begin
  Assert(ALeft = ARight, Format('Wrong units of measurement detected, %s expected but %s found', [ALeft.ToString, ARight.ToString]));
  result := ALeft;
end;

function CheckSum(ALeft, ARight: TDimension): TDimension;
begin
  Assert(ALeft = ARight, Format('Wrong units of measurement detected, %s expected but %s found', [ALeft.ToString, ARight.ToString]));
  result := ALeft;
end;

function CheckSub(ALeft, ARight: TDimension): TDimension;
begin
  Assert(ALeft = ARight, Format('Wrong units of measurement detected, "%s" expected but "%s" found', [ALeft.ToString, ARight.ToString]));
  result := ALeft;
end;

function CheckMul(ALeft, ARight: TDimension): TDimension;
begin
  result := ALeft + ARight;
end;

function CheckDiv(ALeft, ARight: TDimension): TDimension;
begin
  result := ALeft - ARight;
end;
