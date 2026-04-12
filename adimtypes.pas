{
  Description: ADim record types and data structures.

  Copyright (C) 2025-2026 Melchiorre Caruso <@url(melchiorrecaruso@gmail.com)>

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
{$WARN 5024 OFF}// Suppress warning for unused routine parameter.
{$WARN 5033 OFF}// Suppress warning for unassigned function's return value.
{$WARN 6058 OFF}// Suppress warning for function marked as inline that cannot be inlined.

interface

uses
  SysUtils;

type
  { Represents the physical dimension of a quantity using the SI base units.

    Each field stores the integer exponent of the corresponding SI base unit.
    For example, a velocity has dimension @code(m¹·s⁻¹), represented as
    @code(FMeter=1, FSecond=-1) with all other exponents equal to zero.
    A dimensionless quantity has all exponents equal to zero.

    Dimension arithmetic follows the rules of dimensional analysis:
    @unorderedList(
      @item(Multiplication of quantities → addition of exponents)
      @item(Division of quantities → subtraction of exponents)
      @item(Power of a quantity → multiplication of exponents by an integer)
      @item(Root of a quantity → division of exponents by an integer)
    )
  }
  TDimension = record
  private
    { Exponent of the SI base unit kilogram @code([kg]). Mass dimension. }
    FKilogram: smallint;

    { Exponent of the SI base unit metre @code([m]). Length dimension. }
    FMeter: smallint;

    { Exponent of the SI base unit second @code([s]). Time dimension. }
    FSecond: smallint;

    { Exponent of the SI base unit ampere @code([A]). Electric current dimension. }
    FAmpere: smallint;

    { Exponent of the SI base unit kelvin @code([K]). Thermodynamic temperature dimension. }
    FKelvin: smallint;

    { Exponent of the SI base unit mole @code([mol]). Amount of substance dimension. }
    FMole: smallint;

    { Exponent of the SI base unit candela @code([cd]). Luminous intensity dimension. }
    FCandela: smallint;

    { Exponent of the SI derived unit steradian @code([sr]).
      Used to track solid angle dimensionality independently from dimensionless quantities.
    }
    FSteradian: smallint;

  public
    { Returns a human-readable string representation of the dimension.
      Exponents equal to zero are omitted. Positive exponents are listed first,
      followed by negative ones with a @code(/) separator.
      Example: @code(kg·m²·s⁻³·A⁻¹) for the dimension of electric potential.
    }
    function ToString: string;

    { Unary plus. Returns the dimension unchanged. }
    class operator +(const ASelf: TDimension): TDimension;

    { Unary minus. Returns the inverse dimension.
      Each exponent is negated: used to represent the dimension of a reciprocal quantity.
    }
    class operator -(const ASelf: TDimension): TDimension;

    { Returns the sum of two dimensions, i.e. the dimension resulting from
      multiplying two physical quantities.
      Each exponent of the result equals the sum of the corresponding exponents.
    }
    class operator +(const ALeft, ARight: TDimension): TDimension;

    { Returns the difference of two dimensions, i.e. the dimension resulting from
      dividing two physical quantities.
      Each exponent of the result equals the difference of the corresponding exponents.
    }
    class operator -(const ALeft, ARight: TDimension): TDimension;

    { Returns the dimension scaled by an integer exponent.
      Each exponent is multiplied by @code(ALeft).
      Used to represent the dimension of a quantity raised to an integer power,
      e.g. @code(3 * [m] = [m³]).
    }
    class operator *(const ALeft: longint; ARight: TDimension): TDimension;

    { Returns the dimension scaled by an integer exponent.
      Each exponent is multiplied by @code(ARight).
      Used to represent the dimension of a quantity raised to an integer power,
      e.g. @code([m] * 3 = [m³]).
    }
    class operator *(const ALeft: TDimension; ARight: longint): TDimension;

    { Returns the dimension divided by an integer.
      Each exponent is divided by @code(ARight).
      Used to represent the dimension of an integer root of a quantity,
      e.g. @code([m²] div 2 = [m]).
    }
    class operator div(const ALeft: TDimension; ARight: longint): TDimension;

    { Returns @true if the two dimensions differ in at least one exponent.
      Used internally to detect dimensional incompatibility between quantities.
    }
    class operator <>(const ALeft, ARight: TDimension): boolean;

    { Returns @true if all corresponding exponents of the two dimensions are equal.
      Two quantities are dimensionally compatible if and only if their dimensions are equal.
    }
    class operator =(const ALeft, ARight: TDimension): boolean;
  end;

implementation

// TDimension

class operator TDimension.+(const ASelf: TDimension): TDimension;
begin
  Result.FKilogram  := ASelf.FKilogram;
  Result.FMeter     := ASelf.FMeter;
  Result.FSecond    := ASelf.FSecond;
  Result.FAmpere    := ASelf.FAmpere;
  Result.FKelvin    := ASelf.FKelvin;
  Result.FMole      := ASelf.FMole;
  Result.FCandela   := ASelf.FCandela;
  Result.FSteradian := ASelf.FSteradian;
end;

class operator TDimension.-(const ASelf: TDimension): TDimension;
begin
  Result.FKilogram  := -ASelf.FKilogram;
  Result.FMeter     := -ASelf.FMeter;
  Result.FSecond    := -ASelf.FSecond;
  Result.FAmpere    := -ASelf.FAmpere;
  Result.FKelvin    := -ASelf.FKelvin;
  Result.FMole      := -ASelf.FMole;
  Result.FCandela   := -ASelf.FCandela;
  Result.FSteradian := -ASelf.FSteradian;
end;

class operator TDimension.+(const ALeft, ARight: TDimension): TDimension;
begin
  Result.FKilogram  := ALeft.FKilogram  + ARight.FKilogram;
  Result.FMeter     := ALeft.FMeter     + ARight.FMeter;
  Result.FSecond    := ALeft.FSecond    + ARight.FSecond;
  Result.FAmpere    := ALeft.FAmpere    + ARight.FAmpere;
  Result.FKelvin    := ALeft.FKelvin    + ARight.FKelvin;
  Result.FMole      := ALeft.FMole      + ARight.FMole;
  Result.FCandela   := ALeft.FCandela   + ARight.FCandela;
  Result.FSteradian := ALeft.FSteradian + ARight.FSteradian;
end;

class operator TDimension.-(const ALeft, ARight: TDimension): TDimension;
begin
  Result.FKilogram  := ALeft.FKilogram  - ARight.FKilogram;
  Result.FMeter     := ALeft.FMeter     - ARight.FMeter;
  Result.FSecond    := ALeft.FSecond    - ARight.FSecond;
  Result.FAmpere    := ALeft.FAmpere    - ARight.FAmpere;
  Result.FKelvin    := ALeft.FKelvin    - ARight.FKelvin;
  Result.FMole      := ALeft.FMole      - ARight.FMole;
  Result.FCandela   := ALeft.FCandela   - ARight.FCandela;
  Result.FSteradian := ALeft.FSteradian - ARight.FSteradian;
end;

class operator TDimension.*(const ALeft: longint; ARight: TDimension): TDimension;
begin
  Result.FKilogram  := ALeft * ARight.FKilogram;
  Result.FMeter     := ALeft * ARight.FMeter;
  Result.FSecond    := ALeft * ARight.FSecond;
  Result.FAmpere    := ALeft * ARight.FAmpere;
  Result.FKelvin    := ALeft * ARight.FKelvin;
  Result.FMole      := ALeft * ARight.FMole;
  Result.FCandela   := ALeft * ARight.FCandela;
  Result.FSteradian := ALeft * ARight.FSteradian;
end;

class operator TDimension.*(const ALeft: TDimension; ARight: longint): TDimension;
begin
  Result.FKilogram  := ALeft.FKilogram  * ARight;
  Result.FMeter     := ALeft.FMeter     * ARight;
  Result.FSecond    := ALeft.FSecond    * ARight;
  Result.FAmpere    := ALeft.FAmpere    * ARight;
  Result.FKelvin    := ALeft.FKelvin    * ARight;
  Result.FMole      := ALeft.FMole      * ARight;
  Result.FCandela   := ALeft.FCandela   * ARight;
  Result.FSteradian := ALeft.FSteradian * ARight;
end;

class operator TDimension.div(const ALeft: TDimension; ARight: longint): TDimension;
begin
  Result.FKilogram  := ALeft.FKilogram  div ARight;
  Result.FMeter     := ALeft.FMeter     div ARight;
  Result.FSecond    := ALeft.FSecond    div ARight;
  Result.FAmpere    := ALeft.FAmpere    div ARight;
  Result.FKelvin    := ALeft.FKelvin    div ARight;
  Result.FMole      := ALeft.FMole      div ARight;
  Result.FCandela   := ALeft.FCandela   div ARight;
  Result.FSteradian := ALeft.FSteradian div ARight;
end;

class operator TDimension.<>(const ALeft, ARight: TDimension): boolean;
begin
  Result := (ALeft.FKilogram  <> ARight.FKilogram ) or
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
  Result := (ALeft.FKilogram  = ARight.FKilogram ) and
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
  if (AExponent =  10) then Result := '⁶√' + Format('%s',  [ASymbol]) else
  if (AExponent =  12) then Result := '⁵√' + Format('%s',  [ASymbol]) else
  if (AExponent =  15) then Result := '∜'  + Format('%s',  [ASymbol]) else
  if (AExponent =  20) then Result := '∛'  + Format('%s',  [ASymbol]) else
  if (AExponent =  30) then Result := '√'  + Format('%s',  [ASymbol]) else
  if (AExponent =  45) then Result := '∜'  + Format('%s3', [ASymbol]) else
  if (AExponent =  60) then Result :=        Format('%s',  [ASymbol]) else
  if (AExponent =  90) then Result := '√'  + Format('%s3', [ASymbol]) else
  if (AExponent = 120) then Result :=        Format('%s2', [ASymbol]) else
  if (AExponent = 150) then Result := '√'  + Format('%s5', [ASymbol]) else
  if (AExponent = 180) then Result :=        Format('%s3', [ASymbol]) else
  if (AExponent = 240) then Result :=        Format('%s4', [ASymbol]) else
  if (AExponent = 300) then Result :=        Format('%s5', [ASymbol]) else
  if (AExponent = 360) then Result :=        Format('%s6', [ASymbol]) else
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
      Result := ''
    else
      Result := '1' + Denom;
  end else
  begin
    if Denom = '' then
      Result := Num
    else
      Result := Num + Denom;
  end;

  while (Length(Result) > 0) and (Result[Low(Result)]  = ' ') do Delete(Result, Low(Result),  1);
  while (Length(Result) > 0) and (Result[High(Result)] = ' ') do Delete(Result, High(Result), 1);

  Result := StringReplace(Result, '//', '/', [rfReplaceAll]);
  Result := StringReplace(Result, '  ', ' ', [rfReplaceAll]);
end;

end.
