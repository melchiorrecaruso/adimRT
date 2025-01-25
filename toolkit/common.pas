{
  Description: Common routines.

  Copyright (C) 2023-2025 Melchiorre Caruso <melchiorrecaruso@gmail.com>

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program. If not, see <http://www.gnu.org/licenses/>.
}

unit Common;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  TExponents = array [1..8] of double;

function GetSymbolResourceString(const AClassName: string): string;
function GetSingularNameResourceString(const AClassName: string): string;
function GetPluralNameResourceString(const AClassName: string): string;
function GetPrefixesConst(const AClassName: string): string;
function GetExponentsConst(const AClassName: string): string;
function GetFactorConst(const AClassName: string): string;

function GetSymbol(const AShortSymbol: string): string;
function GetSingularName(const ALongSymbol: string): string;
function GetPluralName(const ALongSymbol: string): string;
function GetPrefixes(const AShortSymbol: string): string;
function GetExponents(const AShortSymbol: string): string;

function GetReciprocal(const AExponents: TExponents): TExponents;

function GetQuantity(const S: string): string;

function GetUnitID(const S: string): string;

function GetUnitRec(const S: string): string;

function StringToDimensions(const S: string): TExponents;
function DimensionToString(const ADim: TExponents): string;
function DimensionToQuantityType(const ADim: TExponents): string;
function DimensionToLongString(const ADim: TExponents): string;
function DimensionToShortString(const ADim: TExponents): string;

function SumDim(const ADim1, ADim2: TExponents): TExponents;
function SubDim(const ADim1, ADim2: TExponents): TExponents;

function GetUnitTypeHelper(const S: string): string;
function GetUnitIdentifier(const S: string): string;

function GetBaseClass(const S: string): string;

function  CleanSingleSpaces(const S: string): string;
function  CleanDoubleSpaces(const S: string): string;
procedure CleanDocument(S: TStringList);


implementation

uses
  Math, StrUtils, Types;

function Split(const AStr: string): TStringArray;
var
  I, Index: longint;
begin
  Index  := 0;
  result := nil;
  SetLength(result, Index + 10);
  for I := Low(AStr) to High(AStr) do
  begin

    if AStr[I] in ['/', '.'] then
    begin
      Inc(Index);
      if Index = Length(result) then
        SetLength(result, Index + 10);
      if AStr[I] <> ' ' then
      begin
        result[Index] := AStr[I];
        Inc(Index);
        if Index = Length(result) then
           SetLength(result, Index + 10);
      end;
      result[Index] := '';
    end else
      result[Index] := result[Index] + AStr[I];
   end;
  SetLength(result, Index + 1);
end;

function GetSymbolResourceString(const AClassName: string): string;
begin
  result := Format('rs%sSymbol', [GetUnitID(AClassName)]);
end;

function GetSingularNameResourceString(const AClassName: string): string;
begin
  result := Format('rs%sName', [GetUnitID(AClassName)]);
end;

function GetPluralNameResourceString(const AClassName: string): string;
begin
  result := Format('rs%sPluralName', [GetUnitID(AClassName)]);
end;

function GetPrefixesConst(const AClassName: string): string;
begin
  result := Format('c%sPrefixes', [GetUnitID(AClassName)]);
end;

function GetExponentsConst(const AClassName: string): string;
begin
  result := Format('c%sExponents', [GetUnitID(AClassName)]);
end;

function GetFactorConst(const AClassName: string): string;
begin
  result := Format('c%sFactor', [GetUnitID(AClassName)]);
end;

function GetSymbol(const AShortSymbol: string): string;
begin
  result := AShortSymbol;
  result := StringReplace(result, '.', '.', [rfReplaceAll]);
end;

function GetSingularName(const ALongSymbol: string): string;
begin
  result := ALongSymbol;
  result := StringReplace(StringReplace(result, '!', '', [rfReplaceAll]), '?', '', [rfReplaceAll]);
end;

function GetPluralName(const ALongSymbol: string): string;
begin
  result := ALongSymbol;
  result := StringReplace(StringReplace(result, 'inch!', 'inches', [rfReplaceAll]), 'foot!', 'feet', [rfReplaceAll]);
  result := StringReplace(StringReplace(result, 'y!',    'ies',    [rfReplaceAll]), '?',     's',    [rfReplaceAll]);
end;

function GetQuantityTypeHelper(const S: string): string;
begin
  Result := S;
  if Result <> '' then
  begin
    Result := StringReplace(Result, 'Foot!', 'Foot', [rfReplaceAll]);
    Result := StringReplace(Result, 'Inch!', 'Inch', [rfReplaceAll]);
    Result := StringReplace(Result, 'y!',    'y',    [rfReplaceAll]);
    Result := StringReplace(Result, '?',     '',     [rfReplaceAll]);
    Result := StringReplace(Result, ' ',     '',     [rfReplaceAll]);

    Result := Result + 'Helper';
  end;
end;

function GetQuantity(const S: string): string;
begin
  Result := S;
  if Result <> '' then
  begin
    Result := StringReplace(Result, 'Foot!', 'Feet',   [rfReplaceAll]);
    Result := StringReplace(Result, 'Inch!', 'Inches', [rfReplaceAll]);
    Result := StringReplace(Result, 'y!',    'ies',    [rfReplaceAll]);
    Result := StringReplace(Result, '?',     's',      [rfReplaceAll]);
    Result := StringReplace(Result, ' ',     '',       [rfReplaceAll]);
  end;
end;

function GetUnitComment(S: string): string;
var
  I: longint;
begin
  S := StringReplace(S, '!',  '', [rfReplaceAll]);
  S := StringReplace(S, '?',  '', [rfReplaceAll]);
  S := StringReplace(S, ' ',  '', [rfReplaceAll]);
  if Pos('T', S) = 1 then
    Delete(S, 1, 1);

  result := '';
  for I := low(S) to high(S) do
  begin
    if S[I] = UpCase(S[I]) then
      result := result + ' ';
     result := result + LowerCase(S[I]);
  end;

  if Pos(' ', result) = 1 then
    Delete(result, 1, 1);
end;

function GetUnitID(const S: string): string;
begin
  Result := S;
  Result := StringReplace(Result, '!',  '', [rfReplaceAll]);
  Result := StringReplace(Result, '?',  '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ',  '', [rfReplaceAll]);
  if Pos('T', Result) = 1 then
    Delete(Result, 1, 1);
end;

function GetUnitRec(const S: string): string;
begin
  Result := S;
  Result := StringReplace(Result, '!',  '', [rfReplaceAll]);
  Result := StringReplace(Result, '?',  '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ',  '', [rfReplaceAll]);
  Result := Result + 'Rec';
end;

function StringToDimensions(const S: string): TExponents;
var
  i: longint;
  List1: TStringList;
  List2: TStringDynArray;
  R: string;

  function GetExponent(const AKey: string): double;
  var
    i: longint;
  begin
    i := 0;
    while i < List1.Count do
    begin
      if Pos(AKey, List1[i]) <> 0 then
      begin
        R := List1[i];
        Delete(R, 1, Length(AKey));

        if Length(R) = 0 then
        begin
          List1.Delete(i);
          Exit(1.0)
        end else
          if TryStrToFloat(R, result) then
          begin
            List1.Delete(i);
            Exit(result);
          end;
      end;
      Inc(i);
    end;
    result := 0;
  end;

begin
  List1 := TStringList.Create;
  List2 := SplitString(S, ' ');
  for i := Low(List2) to High(List2) do
  begin
    List1.Add(List2[i]);
  end;
  List2 := nil;

  result[1] := GetExponent( 'kg');
  result[2] := GetExponent(  'm');
  result[3] := GetExponent(  's');
  result[4] := GetExponent(  'A');
  result[5] := GetExponent(  'K');
  result[6] := GetExponent('mol');
  result[7] := GetExponent( 'cd');
  result[8] := GetExponent( 'sr');
  List1.Destroy;
end;

function DimensionToString(const ADim: TExponents): string;
var
  i: longint;
begin
  result := '';

  if not Math.SameValue(ADim[1], 0) then result := result + Format('kg%0.1f ',  [ADim[1]]);
  if not Math.SameValue(ADim[2], 0) then result := result + Format('m%0.1f ',   [ADim[2]]);
  if not Math.SameValue(ADim[3], 0) then result := result + Format('s%0.1f ',   [ADim[3]]);
  if not Math.SameValue(ADim[4], 0) then result := result + Format('A%0.1f ',   [ADim[4]]);
  if not Math.SameValue(ADim[5], 0) then result := result + Format('K%0.1f ',   [ADim[5]]);
  if not Math.SameValue(ADim[6], 0) then result := result + Format('mol%0.1f ', [ADim[6]]);
  if not Math.SameValue(ADim[7], 0) then result := result + Format('cd%0.1f ',  [ADim[7]]);
  if not Math.SameValue(ADim[8], 0) then result := result + Format('sr%0.1f ',  [ADim[8]]);

  i := Length(result);
  if i > 0 then
  begin
    SetLength(result, i -1);
  end;
end;

function DimensionToQuantityType(const ADim: TExponents): string;
var
  Num, Denom: string;
begin
  Num := '';
  if ADim[1] > 0 then Num := Num + Format('Kilogram',  [ADim[1]]);
  if ADim[2] > 0 then Num := Num + Format('Meter',     [ADim[2]]);
  if ADim[3] > 0 then Num := Num + Format('Second',    [ADim[3]]);
  if ADim[4] > 0 then Num := Num + Format('Ampere',    [ADim[4]]);
  if ADim[5] > 0 then Num := Num + Format('Kelvin',    [ADim[5]]);
  if ADim[6] > 0 then Num := Num + Format('Mole',      [ADim[6]]);
  if ADim[7] > 0 then Num := Num + Format('Candela',   [ADim[7]]);
  if ADim[8] > 0 then Num := Num + Format('Steradian', [ADim[8]]);

  Denom := '';
  if ADim[1] < 0 then Denom := Denom + Format('Kilogram',  [ADim[1]]);
  if ADim[2] < 0 then Denom := Denom + Format('Meter',     [ADim[2]]);
  if ADim[3] < 0 then Denom := Denom + Format('Second',    [ADim[3]]);
  if ADim[4] < 0 then Denom := Denom + Format('Ampere',    [ADim[4]]);
  if ADim[5] < 0 then Denom := Denom + Format('Kelvin',    [ADim[5]]);
  if ADim[6] < 0 then Denom := Denom + Format('Mole',      [ADim[6]]);
  if ADim[7] < 0 then Denom := Denom + Format('Candela',   [ADim[7]]);
  if ADim[8] < 0 then Denom := Denom + Format('Steradian', [ADim[8]]);

  if Num = '' then
  begin
    if Denom = '' then
      result := ''
    else
      result := 'TReciprocal' + Denom;
  end else
  begin
    if Denom = '' then
      result := 'T' + Num + 's'
    else
      result := 'T' + Num + 'sPer' + Denom
  end;
end;

function DimensionToShortString(const ADim: double; const ASymbol: string): string;
var
  Value: double;
begin
  Value := Abs(ADim);
  if SameValue(Value, 1/4) then result := Format('∜%s' , [ASymbol]) else
  if SameValue(Value, 1/3) then result := Format('∛%s' , [ASymbol]) else
  if SameValue(Value, 1/2) then result := Format('√%s' , [ASymbol]) else
  if SameValue(Value, 1.0) then result := Format('%s'  , [ASymbol]) else
  if SameValue(Value, 3/2) then result := Format('√%s3', [ASymbol]) else
  if SameValue(Value, 2.0) then result := Format('%s2' , [ASymbol]) else
  if SameValue(Value, 3.0) then result := Format('%s3' , [ASymbol]) else
  if SameValue(Value, 4.0) then result := Format('%s4' , [ASymbol]) else
  if SameValue(Value, 5.0) then result := Format('%s5' , [ASymbol]) else
  if SameValue(Value, 6.0) then result := Format('%s6' , [ASymbol]) else
    raise Exception.Create('ERROR: DimensionToShortString');
end;

function DimensionToLongString(const ADim: double; AName: string): string;
var
  Value: double;
begin
  value := abs(adim);
  if samevalue(value, 1/6) then result := format('sextic root %s'      , [AName]) else
  if samevalue(value, 1/5) then result := format('quintic root %s'     , [AName]) else
  if samevalue(value, 1/4) then result := format('quartic root %s'     , [AName]) else
  if samevalue(value, 1/3) then result := format('cubic root %s'       , [AName]) else
  if samevalue(value, 1/2) then result := format('square root %s'      , [AName]) else
  if samevalue(value, 1.0) then result := format('%s'                  , [AName]) else
  if samevalue(value, 3/2) then result := format('square root cubic %s', [AName]) else
  if samevalue(value, 2.0) then result := format('square %s'           , [AName]) else
  if samevalue(value, 3.0) then result := format('cubic %s'            , [AName]) else
  if samevalue(value, 4.0) then result := format('quartic %s'          , [AName]) else
  if samevalue(value, 5.0) then result := format('quintic %s'          , [AName]) else
  if samevalue(value, 6.0) then result := format('sextic %s'           , [AName]) else
    raise Exception.Create('ERROR: DimensionToLongString');
end;

function DimensionToLongString(const ADim: TExponents): string;
var
  Num, Denom: string;
begin
  Num := '';
  if ADim[1] > 0 then Num := Num + DimensionToLongString(ADim[1], '%skilogram? ');
  if ADim[2] > 0 then Num := Num + DimensionToLongString(ADim[2], '%smeter? '   );
  if ADim[3] > 0 then Num := Num + DimensionToLongString(ADim[3], '%ssecond? '  );
  if ADim[4] > 0 then Num := Num + DimensionToLongString(ADim[4], '%sampere? '  );
  if ADim[5] > 0 then Num := Num + DimensionToLongString(ADim[5], '%skelvin? '  );
  if ADim[6] > 0 then Num := Num + DimensionToLongString(ADim[6], '%smole? '    );
  if ADim[7] > 0 then Num := Num + DimensionToLongString(ADim[7], '%scandela? ' );
  if ADim[8] > 0 then Num := Num + DimensionToLongString(ADim[8], 'steradian '  );

  Denom := '';
  if ADim[1] < 0 then Denom := Denom + 'per ' + DimensionToLongString(ADim[1], '%skilogram ');
  if ADim[2] < 0 then Denom := Denom + 'per ' + DimensionToLongString(ADim[2], '%smeter '   );
  if ADim[3] < 0 then Denom := Denom + 'per ' + DimensionToLongString(ADim[3], '%ssecond '  );
  if ADim[4] < 0 then Denom := Denom + 'per ' + DimensionToLongString(ADim[4], '%sampere '  );
  if ADim[5] < 0 then Denom := Denom + 'per ' + DimensionToLongString(ADim[5], '%skelvin '  );
  if ADim[6] < 0 then Denom := Denom + 'per ' + DimensionToLongString(ADim[6], '%smole '    );
  if ADim[7] < 0 then Denom := Denom + 'per ' + DimensionToLongString(ADim[7], '%scandela ' );
  if ADim[8] < 0 then Denom := Denom + 'per ' + DimensionToLongString(ADim[8], 'steradian ' );

  if Num = '' then
  begin
    if Denom = '' then
      result := ''
    else
      result := 'reciprocal ' + StringReplace(Denom, 'per ', '', [rfReplaceAll]);
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

function DimensionToShortString(const ADim: TExponents): string;
var
  Num, Denom: string;
begin
  Num := '';
  if ADim[1] > 0 then Num := Num + DimensionToShortString(ADim[1], '.%skg' );
  if ADim[2] > 0 then Num := Num + DimensionToShortString(ADim[2], '.%sm'  );
  if ADim[3] > 0 then Num := Num + DimensionToShortString(ADim[3], '.%ss'  );
  if ADim[4] > 0 then Num := Num + DimensionToShortString(ADim[4], '.%sA'  );
  if ADim[5] > 0 then Num := Num + DimensionToShortString(ADim[5], '.%sK'  );
  if ADim[6] > 0 then Num := Num + DimensionToShortString(ADim[6], '.%smol');
  if ADim[7] > 0 then Num := Num + DimensionToShortString(ADim[7], '.%scd' );
  if ADim[8] > 0 then Num := Num + DimensionToShortString(ADim[8], '.sr'   );

  if (Length(Num) > 0) then Delete(Num, 1, 1);

  Denom := '';
  if ADim[1] < 0 then Denom := Denom + DimensionToShortString(ADim[1], '/%skg' );
  if ADim[2] < 0 then Denom := Denom + DimensionToShortString(ADim[2], '/%sm'  );
  if ADim[3] < 0 then Denom := Denom + DimensionToShortString(ADim[3], '/%ss'  );
  if ADim[4] < 0 then Denom := Denom + DimensionToShortString(ADim[4], '/%sA'  );
  if ADim[5] < 0 then Denom := Denom + DimensionToShortString(ADim[5], '/%sK'  );
  if ADim[6] < 0 then Denom := Denom + DimensionToShortString(ADim[6], '/%smol');
  if ADim[7] < 0 then Denom := Denom + DimensionToShortString(ADim[7], '/%scd' );
  if ADim[8] < 0 then Denom := Denom + DimensionToShortString(ADim[8], '/sr'   );

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

function SumDim(const ADim1, ADim2: TExponents): TExponents;
begin
  result[1] := ADim1[1] + ADim2[1];
  result[2] := ADim1[2] + ADim2[2];
  result[3] := ADim1[3] + ADim2[3];
  result[4] := ADim1[4] + ADim2[4];
  result[5] := ADim1[5] + ADim2[5];
  result[6] := ADim1[6] + ADim2[6];
  result[7] := ADim1[7] + ADim2[7];
  result[8] := ADim1[8] + ADim2[8];
end;

function SubDim(const ADim1, ADim2: TExponents): TExponents;
begin
  result[1] := ADim1[1] - ADim2[1];
  result[2] := ADim1[2] - ADim2[2];
  result[3] := ADim1[3] - ADim2[3];
  result[4] := ADim1[4] - ADim2[4];
  result[5] := ADim1[5] - ADim2[5];
  result[6] := ADim1[6] - ADim2[6];
  result[7] := ADim1[7] - ADim2[7];
  result[8] := ADim1[8] - ADim2[8];
end;

function GetReciprocal(const AExponents: TExponents): TExponents;
var
  i: longint;
begin
  for i := Low(AExponents) to High(AExponents) do
  begin
    result[i] := -AExponents[i];
  end;
end;

function GetUnitTypeHelper(const S: string): string;
begin
  Result := S;
  Result := StringReplace(Result, '!',  '', [rfReplaceAll]);
  Result := StringReplace(Result, '?',  '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ',  '', [rfReplaceAll]);
  Result := Result + 'Helper';
end;

function GetUnitIdentifier(const S: string): string;
begin
  Result := S;
  Result := StringReplace(Result, '!',  '', [rfReplaceAll]);
  Result := StringReplace(Result, '?',  '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ',  '', [rfReplaceAll]);
  Result := Result + 'Unit';
end;

function GetBaseClass(const S: string): string;
begin
  Result := S;
  Result := StringReplace(Result, 'Unit',   '',      [rfReplaceAll]);
  Result := StringReplace(Result, 'Qty',    '',      [rfReplaceAll]);

  Result := StringReplace(Result, 'Feet',   'Foot!', [rfReplaceAll]);
  Result := StringReplace(Result, 'Inches', 'Inch!', [rfReplaceAll]);
  Result := StringReplace(Result, 'ies',    'y!',    [rfReplaceAll]);
  Result := StringReplace(Result, ' ',      '',      [rfReplaceAll]);


  if Result = 'TSiemens' then Exit;

  if Result[Length(Result)] = 's' then
    Result[Length(Result)] := '?';
end;


function GetPrefixes(const AShortSymbol: string): string;
var
  I, J: longint;
  S: TStringArray;
begin
  Result := '';
  S := Split(AShortSymbol);
  for I := Low(S) to High(S) do
  begin
    J := Pos('%s', S[I]);
    if J > 0 then
    begin
      if (S[I] = '%sg') or (S[I] = '%sg2') then
        result := result + ' pKilo,'
      else
        result := result + ' pNone,';
    end;
  end;
  S := nil;

  while (Length(Result) > 0) and (Result[Low (Result)] = ' ') do
    Delete(Result, Low (Result), 1);

  while (Length(Result) > 0) and (Result[High(Result)] = ',') do
    Delete(Result, High(Result), 1);
end;

function GetExponents(const AShortSymbol: string): string;
var
  I, Exponent: longint;
  S: TStringArray;
begin
  Result := '';
  Exponent := 1;
  S := Split(AShortSymbol);
  for I := Low(S) to High(S) do
  begin
    if S[I] = '.' then
      Exponent := 1
    else
      if S[I] = '/' then
        Exponent := -1
      else
      begin
        if Pos('%s', S[I]) > 0 then
        begin
          if S[I][Length(S[I])] in ['2', '3', '4', '5', '6', '7', '8', '9'] then
          begin
            if Exponent < 0 then
              Result := Result + ' -' + S[I][Length(S[I])] + ','
            else
              Result := Result + ' ' + S[I][Length(S[I])] + ',';
          end else
          begin
            if Exponent < 0 then
              Result := Result + ' -1,'
            else
              Result := Result + ' 1,';
          end;
        end;
      end;
  end;
  S := nil;

  while (Length(Result) > 0) and (Result[Low (Result)] = ' ') do Delete(Result, Low (Result), 1);
  while (Length(Result) > 0) and (Result[High(Result)] = ',') do Delete(Result, High(Result), 1);
end;

function CleanDoubleSpaces(const S: string): string;
begin
  Result := S;
  while Pos('  ', Result) > 0 do
  begin
    Delete(Result, Pos('  ', Result), 1);
  end;
end;

function CleanSingleSpaces(const S: string): string;
begin
  Result := S;
  while Pos(' ', Result) > 0 do
  begin
    Delete(Result, Pos(' ', Result), 1);
  end;
end;

procedure CleanDocument(S: TStringList);
var
  i: longint;
begin
  i := 0;
  while i < S.Count do
  begin
    if IsEmptyStr(S[i], [' ']) then
    begin
      S.Delete(i);
    end else
      Break;
  end;

  while (i + 1) < S.Count do
  begin
    if IsEmptyStr(S[i],     [' ']) and
       IsEmptyStr(S[i + 1], [' ']) then
    begin
      S.Delete(i + 1);
    end else
      inc(i);
  end;
end;

end.

