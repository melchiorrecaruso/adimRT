{
  Description: ADim record types and data structures.

  Copyright (C) 2025-2026 Melchiorre Caruso <melchiorrecaruso@gmail.com>

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
}

unit ADimTypes;

{$H+}{$J-}
{$modeswitch advancedrecords}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function's return value.
{$WARN 6058 OFF} // Suppress warning for function marked as inline that cannot be inlined.

interface

uses
  SysUtils;

type
  { TDimension }

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

implementation

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
  if FKilogram  < 0 then Denom := Denom + '/' + SymbolToString(FKilogram,  'kg');
  if FMeter     < 0 then Denom := Denom + '/' + SymbolToString(FMeter,      'm');
  if FSecond    < 0 then Denom := Denom + '/' + SymbolToString(FSecond,     's');
  if FAmpere    < 0 then Denom := Denom + '/' + SymbolToString(FAmpere,     'A');
  if FKelvin    < 0 then Denom := Denom + '/' + SymbolToString(FKelvin,     'K');
  if FMole      < 0 then Denom := Denom + '/' + SymbolToString(FMole,     'mol');
  if FCandela   < 0 then Denom := Denom + '/' + SymbolToString(FCandela,   'cd');
  if FSteradian < 0 then Denom := Denom + '/' + SymbolToString(FSteradian, 'sr');

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

end.

