{ ADim record types and data structures.

  Defines the core record types and data structures used throughout the
  ADimPas library, including:

  @unorderedList(
    @item(@link(TDimension) — the SI dimension exponent record, storing
          the integer exponents of the eight SI base units and the steradian.)
  )

  @author Melchiorre Caruso (melchiorrecaruso@@gmail.com)
  @copyright 2025-2026 Melchiorre Caruso
  @license GNU Lesser General Public License v3 with modified LGPL exception.

  This unit is part of the ADim library, distributed under the
  GNU Lesser General Public License v3 (LGPL v3) with the following
  special exception:

  As a special exception, the copyright holders of this library give you
  permission to link this library with independent modules to produce an
  executable, regardless of the license terms of these independent modules,
  and to copy and distribute the resulting executable under terms of your
  choice, provided that you also meet, for each linked independent module,
  the terms and conditions of the license of that module. An independent
  module is a module which is not derived from or based on this library.
  If you modify this library, you may extend this exception to your version
  of the library, but you are not obligated to do so. If you do not wish
  to do so, delete this exception statement from your version.
}

unit ADimCommon;

{$H+}{$J-}
{$modeswitch advancedrecords}
{$WARN 5024 OFF}// Suppress warning for unused routine parameter.
{$WARN 5033 OFF}// Suppress warning for unassigned function's return value.
{$WARN 6058 OFF}// Suppress warning for function marked as inline that cannot be inlined.

interface

uses
  SysUtils;

type
  { SI base units tracked by @link(TDimension). The order defines the
    position of each exponent in @code(TDimension.FExponents). }
  TBaseUnit = (buKilogram, buMeter, buSecond, buAmpere, buKelvin, buMole,
    buCandela, buSteradian);

const
  { Number of 16-bit exponents that fit in one 64-bit word. }
  ExponentsPerWord = SizeOf(QWord) div SizeOf(smallint);

  { Number of 64-bit words needed to hold one exponent per base unit. }
  DimensionWords = (Ord(High(TBaseUnit)) + ExponentsPerWord) div ExponentsPerWord;

  { Number of exponent slots: the base units rounded up to whole words. The
    slots beyond @code(High(TBaseUnit)) are padding and are always zero. }
  DimensionSlots = DimensionWords * ExponentsPerWord;

type
  { Represents the physical dimension of a quantity using the SI base units.

    Each slot of @code(FExponents) stores the integer exponent of the SI base
    unit at position @code(Ord(TBaseUnit)). Exponents are stored in sixtieths
    (60 = 1, 30 = 1/2, 20 = 1/3, ...), so that roots up to the sixth remain
    integral. For example, a velocity has dimension @code(m¹·s⁻¹), represented
    by the exponents of @code(buMeter) and @code(buSecond) set to 60 and -60,
    with all other exponents equal to zero. A dimensionless quantity has all
    exponents equal to zero.

    Dimension arithmetic follows the rules of dimensional analysis:
    @unorderedList(
      @item(Multiplication of quantities → addition of exponents)
      @item(Division of quantities → subtraction of exponents)
      @item(Power of a quantity → multiplication of exponents by an integer)
      @item(Root of a quantity → division of exponents by an integer)
    )
  }
  TDimension = record
  public
    { Returns a human-readable string representation of the dimension.
      Exponents equal to zero are omitted. Positive exponents are listed first,
      followed by negative ones with a @code(/) separator.
      Example: @code(kg·m²·s⁻³·A⁻¹) for the dimension of electric potential.
    }
    function ToString: string;

    { Unary plus. Returns the dimension unchanged. }
    class operator +(const ASelf: TDimension): TDimension; inline;

    { Unary minus. Returns the inverse dimension.
      Each exponent is negated: used to represent the dimension of a reciprocal quantity.
    }
    class operator -(const ASelf: TDimension): TDimension; inline;

    { Returns the sum of two dimensions, i.e. the dimension resulting from
      multiplying two physical quantities.
      Each exponent of the result equals the sum of the corresponding exponents.
    }
    class operator +(const ALeft, ARight: TDimension): TDimension; inline;

    { Returns the difference of two dimensions, i.e. the dimension resulting from
      dividing two physical quantities.
      Each exponent of the result equals the difference of the corresponding exponents.
    }
    class operator -(const ALeft, ARight: TDimension): TDimension; inline;

    { Returns the dimension scaled by an integer exponent.
      Each exponent is multiplied by @code(ALeft).
      Used to represent the dimension of a quantity raised to an integer power,
      e.g. @code(3 * [m] = [m³]).
    }
    class operator *(const ALeft: longint; ARight: TDimension): TDimension; inline;

    { Returns the dimension scaled by an integer exponent.
      Each exponent is multiplied by @code(ARight).
      Used to represent the dimension of a quantity raised to an integer power,
      e.g. @code([m] * 3 = [m³]).
    }
    class operator *(const ALeft: TDimension; ARight: longint): TDimension; inline;

    { Returns the dimension divided by an integer.
      Each exponent is divided by @code(ARight).
      Used to represent the dimension of an integer root of a quantity,
      e.g. @code([m²] div 2 = [m]).
    }
    class operator div(const ALeft: TDimension; ARight: longint): TDimension; inline;

    { Returns @true if the two dimensions differ in at least one exponent.
      Used internally to detect dimensional incompatibility between quantities.
    }
    class operator <>(const ALeft, ARight: TDimension): boolean; inline;

    { Returns @true if all corresponding exponents of the two dimensions are equal.
      Two quantities are dimensionally compatible if and only if their dimensions are equal.
    }
    class operator =(const ALeft, ARight: TDimension): boolean; inline;
  private
    case byte of
      { Exponent of each SI base unit, indexed by @code(Ord(TBaseUnit)). }
      0: (FExponents: array[0..DimensionSlots - 1] of smallint);
      { The same exponents viewed as 64-bit words of four 16-bit lanes. }
      1: (FWords: array[0..DimensionWords - 1] of QWord);
  end;

implementation

{ The 16-bit exponents are added and subtracted four at a time, as lanes of a
  64-bit word. The sign bit of every lane is excluded from the carry chain and
  recomputed separately, so no carry or borrow ever crosses a lane boundary.
  The results equal the lane-by-lane smallint arithmetic, including
  wrap-around. Padding lanes stay zero because 0 + 0 = 0 - 0 = 0. }
const
  LaneSignBits = QWord($8000800080008000);

function PackedAdd(ALeft, ARight: QWord): QWord; inline;
begin
  Result := ((ALeft and not LaneSignBits) + (ARight and not LaneSignBits)) xor
    ((ALeft xor ARight) and LaneSignBits);
end;

function PackedSub(ALeft, ARight: QWord): QWord; inline;
begin
  Result := ((ALeft or LaneSignBits) - (ARight and not LaneSignBits)) xor
    ((ALeft xor not ARight) and LaneSignBits);
end;

// TDimension

class operator TDimension.+(const ASelf: TDimension): TDimension;
begin
  Result := ASelf;
end;

class operator TDimension.-(const ASelf: TDimension): TDimension;
var
  I: longint;
begin
  for I := Low(Result.FWords) to High(Result.FWords) do
    Result.FWords[I] := PackedSub(0, ASelf.FWords[I]);
end;

class operator TDimension.+(const ALeft, ARight: TDimension): TDimension;
var
  I: longint;
begin
  for I := Low(Result.FWords) to High(Result.FWords) do
    Result.FWords[I] := PackedAdd(ALeft.FWords[I], ARight.FWords[I]);
end;

class operator TDimension.-(const ALeft, ARight: TDimension): TDimension;
var
  I: longint;
begin
  for I := Low(Result.FWords) to High(Result.FWords) do
    Result.FWords[I] := PackedSub(ALeft.FWords[I], ARight.FWords[I]);
end;

{ Scaling and division run over every slot, padding included, so the padding
  of the result is always written (0 * k = 0 div k = 0). }

class operator TDimension.*(const ALeft: longint; ARight: TDimension): TDimension;
var
  I: longint;
begin
  for I := Low(Result.FExponents) to High(Result.FExponents) do
    Result.FExponents[I] := ALeft * ARight.FExponents[I];
end;

class operator TDimension.*(const ALeft: TDimension; ARight: longint): TDimension;
var
  I: longint;
begin
  for I := Low(Result.FExponents) to High(Result.FExponents) do
    Result.FExponents[I] := ALeft.FExponents[I] * ARight;
end;

class operator TDimension.div(const ALeft: TDimension; ARight: longint): TDimension;
var
  I: longint;
begin
  for I := Low(Result.FExponents) to High(Result.FExponents) do
    Result.FExponents[I] := ALeft.FExponents[I] div ARight;
end;

class operator TDimension.<>(const ALeft, ARight: TDimension): boolean;
var
  I: longint;
  LDifference: QWord;
begin
  LDifference := 0;
  for I := Low(ALeft.FWords) to High(ALeft.FWords) do
    LDifference := LDifference or (ALeft.FWords[I] xor ARight.FWords[I]);
  Result := LDifference <> 0;
end;

class operator TDimension.=(const ALeft, ARight: TDimension): boolean;
var
  I: longint;
  LDifference: QWord;
begin
  LDifference := 0;
  for I := Low(ALeft.FWords) to High(ALeft.FWords) do
    LDifference := LDifference or (ALeft.FWords[I] xor ARight.FWords[I]);
  Result := LDifference = 0;
end;

const
  BaseUnitSymbols: array[TBaseUnit] of string = (
    'kg', 'm', 's', 'A', 'K', 'mol', 'cd', 'sr');

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
  LUnit: TBaseUnit;
  LExponent: smallint;
  Num, Denom: string;
begin
  Num := '';
  Denom := '';
  for LUnit := Low(TBaseUnit) to High(TBaseUnit) do
  begin
    LExponent := FExponents[Ord(LUnit)];
    if LExponent > 0 then
      Num := Num + '.' + SymbolToString(LExponent, BaseUnitSymbols[LUnit])
    else if LExponent < 0 then
      Denom := Denom + '/' + SymbolToString(LExponent, BaseUnitSymbols[LUnit]);
  end;
  Delete(Num, 1, 1);

  if Num = '' then
  begin
    if Denom = '' then
      Result := ''
    else
      Result := '1' + Denom;
  end else
    Result := Num + Denom;
end;

end.
