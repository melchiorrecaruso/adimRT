{
  Description: Common routines.

  Copyright (C) 2023-2024 Melchiorre Caruso <melchiorrecaruso@gmail.com>

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
  TExponents = array [1..7] of double;

const
  INTF_NOP            = '{$DEFINE NOP}';
  INTF_QUANTITY       = '{$DEFINE INTF_QUANTITY}{$DEFINE TQuantity:=%s}{$i %s}';
  INTF_UNIT           = '{$DEFINE INTF_UNIT}{$DEFINE TQuantity:=%s}{$DEFINE TUnit:=%s}{$i %s}';
  INTF_END            = '{$DEFINE INTF_END}{$i %s}';

  IMPL_NOP            = '{$DEFINE NOP}';
  IMPL_QUANTITY       = '{$DEFINE IMPL_QUANTITY}{$DEFINE TQuantity:=%s}{$i %s}';
  IMPL_UNIT           = '{$DEFINE IMPL_UNIT}{$DEFINE TQuantity:=%s}{$DEFINE TUnit:=%s}{$i %s}';

  IMPL_CSYMBOL        = '{$DEFINE CSYMBOL:=%s}';
  IMPL_CSINGULARNAME  = '{$DEFINE CSINGULARNAME:=%s}';
  IMPL_CPLURALNAME    = '{$DEFINE CPLURALNAME:=%s}';
  IMPL_CPREFIXES      = '{$DEFINE CPREFIXES:=%s}';
  IMPL_CEXPONENTS     = '{$DEFINE CEXPONENTS:=%s}';
  IMPL_CFACTOR        = '{$DEFINE CFACTOR:=%s}';

  INTF_OP_CLASS       = '  class operator %s(const ALeft: %s; const ARight: %s): %s;';
  IMPL_OP_CLASS       = 'class operator %s.%s(const ALeft: %s; const ARight: %s): %s;';
  INTF_OP             = 'operator %s(const ALeft: %s; const ARight: %s): %s;';
  IMPL_OP             = 'operator %s(const ALeft: %s; const ARight: %s): %s;';

  VECPrefix           = 'CL';


procedure Clear(var AValue: TExponents);


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

function GetReciprocalClassName(S: string): string;
function GetReciprocalQuantityType(S: string): string;
function GetReciprocalUnitTypeHelper(const S: string): string;

function GetQuantityType(const S: string): string;
function GetQuantity(const S: string): string;
function GetUnitType(const S: string): string;
function GetUnit(const S: string): string;

function GetUnitID(const S: string): string;
function GetUnitIndex(const S: string): string;

function GetHelperFuncName(const S: string): string;

function GetDimensions(const S: string): TExponents;
function SumDim(const ADim1, ADim2: TExponents): TExponents;
function SubDim(const ADim1, ADim2: TExponents): TExponents;



function GetUnitTypeHelper(const S: string): string;
function GetUnitIdentifier(const S: string): string;

function GetBaseClass(const S: string): string;

function  CleanSingleSpaces(const S: string): string;
function  CleanDoubleSpaces(const S: string): string;
procedure CleanDocument(S: TStringList);

function IsASpecialKey(const AKey: string): boolean;
function IsAVersorKey(const AKey: string): boolean;
function IsAVector(const AClassName: string): boolean;

implementation

uses
  StrUtils, Types;

function IsASpecialKey(const AKey: string): boolean;
begin
  Result := (UpperCase(AKey) = 'DOUBLE'       ) or
            (UpperCase(AKey) = 'TVECTOR'      ) or
            (UpperCase(AKey) = 'TBIVECTOR'    ) or
            (UpperCase(AKey) = 'TTRIVECTOR'   ) or
            (UpperCase(AKey) = 'TMULTIVECTOR' ) or
            (UpperCase(AKey) = 'TTRIVERSOR123') or
            (UpperCase(AKey) = 'TBIVERSOR12'  ) or
            (UpperCase(AKey) = 'TBIVERSOR13'  ) or
            (UpperCase(AKey) = 'TBIVERSOR23'  ) or
            (UpperCase(AKey) = 'TVERSOR1'     ) or
            (UpperCase(AKey) = 'TVERSOR2'     ) or
            (UpperCase(AKey) = 'TVERSOR3'     );
end;

function IsAVersorKey(const AKey: string): boolean;
begin
  Result := (UpperCase(AKey) = 'TTRIVERSOR123') or
            (UpperCase(AKey) = 'TBIVERSOR12'  ) or
            (UpperCase(AKey) = 'TBIVERSOR13'  ) or
            (UpperCase(AKey) = 'TBIVERSOR23'  ) or
            (UpperCase(AKey) = 'TVERSOR1'     ) or
            (UpperCase(AKey) = 'TVERSOR2'     ) or
            (UpperCase(AKey) = 'TVERSOR3'     );
end;

function IsAVector(const AClassName: string): boolean;
begin
  Result := False;
  if UpperCase(AClassName) = 'TVECTOR'      then Result := True;
  if UpperCase(AClassName) = 'TBIVECTOR'    then Result := True;
  if UpperCase(AClassName) = 'TTRIVECTOR'   then Result := True;
  if UpperCase(AClassName) = 'TMULTIVECTOR' then Result := True;

  if Pos('T' + VECPrefix, AClassName) = 1 then Result := True;
end;

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

procedure Clear(var AValue: TExponents);
var
  i: longint;
begin
  for i := Low(AValue) to high(AValue) do AValue[i] := 0;
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
  result := StringReplace(result, '.', '·', [rfReplaceAll]);
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

function GetReciprocalClassName(S: string): string;
var
  i: longint;
  Left, Right: string;
begin
  if IsAVector(S) then
    result := 'T'+ VECPrefix
  else
    result := 'T';
  Delete(S, 1, Length(Result));

  Right  := '';
  i := Pos('Per', S);
  if i > 0 then
  begin
    Right := Copy(S, i, Length(S) - i + 1);
    Right := StringReplace(Right, 'Per', '', [rfReplaceAll]);
    Delete(S, i, Length(S) - i + 1);
  end;

  if Length(S) > 0 then
  begin
    Left := S;
    if Left[Length(Left)] = '?' then  SetLength(Left, Length(Left) -1);
    if Left[Length(Left)] = '!' then  SetLength(Left, Length(Left) -1);

    Left := StringReplace(Left, '?', 'Per', [rfReplaceAll]);
    Left := StringReplace(Left, '!', 'Per', [rfReplaceAll]);

    Left := StringReplace(Left, 'KilogramMeter',       'KilogramPerMeter',       [rfReplaceAll]);
    Left := StringReplace(Left, 'KilogramSquareMeter', 'KilogramPerSquareMeter', [rfReplaceAll]);
    Left := StringReplace(Left, 'NewtonMeter',         'NewtonPerMeter',         [rfReplaceAll]);
  end;

  if Length(Right) = 0 then
  begin
    Result := Result + 'Reciprocal' + Left;
    Result := StringReplace(Result, 'Per', '', [rfReplaceAll]);
  end else
  begin
    Result := Result + Right + '?Per' + Left;
  end;

  Result := StringReplace(Result, 'SecondPerFarad',         'Ohm',          [rfReplaceAll]);

  Result := StringReplace(Result, 'ReciprocalOhm',          'Siemens',      [rfReplaceAll]);
  Result := StringReplace(Result, 'ReciprocalSiemens',      'Ohm',          [rfReplaceAll]);
  Result := StringReplace(Result, 'SecondSquared',          'SquareSecond', [rfReplaceAll]);
  Result := StringReplace(Result, 'ReciprocalReciprocal',   '',             [rfReplaceAll]);
end;

function GetReciprocalQuantityType(S: string): string;
begin
  Result := GetQuantityType(GetReciprocalClassName(S));
end;

function GetQuantityType(const S: string): string;
begin
  Result := S;
  if Result <> '' then
  begin
    Result := StringReplace(Result, 'Foot!', 'Foot', [rfReplaceAll]);
    Result := StringReplace(Result, 'Inch!', 'Inch', [rfReplaceAll]);
    Result := StringReplace(Result, 'y!',    'y',    [rfReplaceAll]);
    Result := StringReplace(Result, '?',     '',     [rfReplaceAll]);
    Result := StringReplace(Result, ' ',     '',     [rfReplaceAll]);

    Result := StringReplace(Result, 'Unit',  '',     [rfReplaceAll]);
    Result := StringReplace(Result, 'Qty',   '',     [rfReplaceAll]);

    if not IsASpecialKey(Result) then Result := Result + 'Qty';
  end;
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

function GetUnitType(const S: string): string;
begin
  if IsASpecialKey(S) then Exit(S);

  Result := S;
  Result := StringReplace(Result, '!',  '', [rfReplaceAll]);
  Result := StringReplace(Result, '?',  '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ',  '', [rfReplaceAll]);
  Result := StringReplace(Result, 'T' + VECPrefix, 'T', [rfReplaceAll]);

  if Result = 'double' then Result := '';
  if Result <> ''      then Result := Result + 'Unit';
end;

function GetUnit(const S: string): string;
begin
  if IsASpecialKey(S) then Exit(S);

  Result := S;
  Result := StringReplace(Result, '!',  '', [rfReplaceAll]);
  Result := StringReplace(Result, '?',  '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ',  '', [rfReplaceAll]);
  Result := StringReplace(Result, 'T' + VECPrefix, 'T', [rfReplaceAll]);

  if Result = 'double' then Result := '';
  if Result <> ''      then Result := Result + 'Unit';
end;

function GetUnitIndex(const S: string): string;
begin
  if IsASpecialKey(S) then Exit(S);

  Result := S;
  Result := StringReplace(Result, '!',  '', [rfReplaceAll]);
  Result := StringReplace(Result, '?',  '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ',  '', [rfReplaceAll]);
  Result := StringReplace(Result, 'T' + VECPrefix, 'T', [rfReplaceAll]);
  Result[1] := 'c';

  if Result = 'double' then Result := '';
  if Result <> ''      then Result := Result;
end;

function GetHelperFuncName(const S: string): string;
begin
  if IsASpecialKey(S) then Exit(S);

  Result := S;
  Result := StringReplace(Result, '!',  '', [rfReplaceAll]);
  Result := StringReplace(Result, '?',  '', [rfReplaceAll]);
  Result := StringReplace(Result, ' ',  '', [rfReplaceAll]);
  Result := StringReplace(Result, 'T' + VECPrefix, 'T', [rfReplaceAll]);
  Delete(Result, 1, 1);

  if Result = 'double' then Result := '';
  if Result <> ''      then Result := Result;
end;

function GetDimensions(const S: string): TExponents;
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
          if TryStrTofloat(R, result) then
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
  result[7] := GetExponent(  'K');
  result[6] := GetExponent( 'cd');
  result[5] := GetExponent('mol');
  result[4] := GetExponent(  'A');
  result[3] := GetExponent(  's');
  result[2] := GetExponent(  'm');
  result[1] := GetExponent( 'kg');
  List1.Destroy;
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
end;




function GetReciprocalUnitTypeHelper(const S: string): string;
begin
  Result := GetUnitTypeHelper(GetReciprocalClassName(S));
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

