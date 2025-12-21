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
  TExponents = array [1..8] of longint;

const
  TExponentValues : array[0..13] of longint = (10, 12, 15, 20, 30, 45, 60, 90, 120, 150, 180, 240, 300, 360);
  TExponentBase = 60;

  NullExponents  : TExponents = (0, 0, 0, 0, 0, 0, 0, 0);


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
function GetUnitID(const ADim: TExponents): string;


function StringToDimensions(const S: string): TExponents;
function DimensionToString(const ADim: TExponents): string;
function DimensionToQuantity(const ADim: TExponents): string;
function DimensionToLongString(const ADim: TExponents): string;
function DimensionToShortString(const ADim: TExponents): string;

function SumDim(const ADim1, ADim2: TExponents): TExponents;
function SubDim(const ADim1, ADim2: TExponents): TExponents;

function GetUnitTypeHelper(const S: string): string;
function GetUnitIdentifier(const S: string): string;

function  CleanSingleSpaces(const S: string): string;
function  CleanDoubleSpaces(const S: string): string;
procedure CleanDocument(S: TStringList);


implementation

uses
  StrUtils, Types;

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
  result := StringReplace(result, '.', '∙', [rfReplaceAll]);
  result := StringReplace(result, '2', '²', [rfReplaceAll]);
  result := StringReplace(result, '3', '³', [rfReplaceAll]);
  result := StringReplace(result, '4', '⁴', [rfReplaceAll]);
  result := StringReplace(result, '5', '⁵', [rfReplaceAll]);
  result := StringReplace(result, '6', '⁶', [rfReplaceAll]);
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

function GetQuantity(const S: string): string;
begin
  Result := S;
  if Result <> '' then
  begin
    Result := StringReplace(Result, '!',  '', [rfReplaceAll]);
    Result := StringReplace(Result, '?',  '', [rfReplaceAll]);
    Result := StringReplace(Result, ' ',  '', [rfReplaceAll]);
  end;
end;

function GetUnitID(const S: string): string;
begin
  Result := GetQuantity(S);
  if Pos('T', Result) = 1 then
    Delete(Result, 1, 1);
end;

function GetUnitID(const ADim: TExponents): string;
begin
  result := Format('(FKilogram: %d; FMeter: %d; FSecond: %d; FAmpere: %d; FKelvin: %d; FMole: %d; FCandela: %d; FRadian: %d)', [
    ADim[1],
    ADim[2],
    ADim[3],
    ADim[4],
    ADim[5],
    ADim[6],
    ADim[7],
    ADim[8]]);
end;

function StringToDimensions(const S: string): TExponents;
var
  i: longint;
  List1: TStringList;
  List2: TStringDynArray;
  R: string;

  function GetExponent(const AKey: string): longint;
  var
    i: longint;
    D: double;
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
          Exit(TExponentBase)
        end else
          if TryStrToFloat(R, D) then
          begin
            List1.Delete(i);
            Exit(Trunc(D*TExponentBase));
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

  result[1] := GetExponent(  'kg');
  result[2] := GetExponent(   'm');
  result[3] := GetExponent(   's');
  result[4] := GetExponent(   'A');
  result[5] := GetExponent(   'K');
  result[6] := GetExponent( 'mol');
  result[7] := GetExponent(  'cd');
  result[8] := GetExponent( 'rad');
  List1.Destroy;
end;

function DimensionToString(const ADim: TExponents): string;
begin
  result := '';
  if (ADim[1] <> 0) then result := result + Format('kg%0.2f ',  [ADim[1]/TExponentBase]);
  if (ADim[2] <> 0) then result := result + Format('m%0.2f ',   [ADim[2]/TExponentBase]);
  if (ADim[3] <> 0) then result := result + Format('s%0.2f ',   [ADim[3]/TExponentBase]);
  if (ADim[4] <> 0) then result := result + Format('A%0.2f ',   [ADim[4]/TExponentBase]);
  if (ADim[5] <> 0) then result := result + Format('K%0.2f ',   [ADim[5]/TExponentBase]);
  if (ADim[6] <> 0) then result := result + Format('mol%0.2f ', [ADim[6]/TExponentBase]);
  if (ADim[7] <> 0) then result := result + Format('cd%0.2f ',  [ADim[7]/TExponentBase]);
  if (ADim[8] <> 0) then result := result + Format('rad%0.2f ', [ADim[8]/TExponentBase]);

  if result <> '' then
    SetLength(result, Length(result) -1);
end;

function DimensionToShortString(const ADim: longint; const ASymbol: string): string;
var
  Value: longint;
begin
  Value := Abs(ADim);
  if (Value = 10 ) then result := '⁶√' + Format('%s',  [ASymbol]) else
  if (Value = 12 ) then result := '⁵√' + Format('%s',  [ASymbol]) else
  if (Value = 15 ) then result :=  '∜' + Format('%s',  [ASymbol]) else
  if (Value = 20 ) then result :=  '∛' + Format('%s',  [ASymbol]) else
  if (Value = 30 ) then result :=  '√' + Format('%s',  [ASymbol]) else
  if (Value = 45 ) then result :=  '∜' + Format('%s3', [ASymbol]) else
  if (Value = 60 ) then result :=        Format('%s' , [ASymbol]) else
  if (Value = 90 ) then result :=  '√' + Format('%s3', [ASymbol]) else
  if (Value = 120) then result :=        Format('%s2', [ASymbol]) else
  if (Value = 150) then result :=  '√' + Format('%s5', [ASymbol]) else
  if (Value = 180) then result :=        Format('%s3', [ASymbol]) else
  if (Value = 240) then result :=        Format('%s4', [ASymbol]) else
  if (Value = 300) then result :=        Format('%s5', [ASymbol]) else
  if (Value = 360) then result :=        Format('%s6', [ASymbol]) else
    raise Exception.CreateFmt('ERROR: DimensionToShortString (%s)', [Value.ToString]);
end;

function DimensionToLongString(const ADim: longint; AName: string): string;
var
  Value: longint;
begin
  Value := Abs(ADim);
  if (Value = 10 ) then result := Format('Sextic Root %s'        , [AName]) else
  if (Value = 12 ) then result := Format('Quintic Root %s'       , [AName]) else
  if (Value = 15 ) then result := Format('Quartic Root %s'       , [AName]) else
  if (Value = 20 ) then result := Format('Cubic Root %s'         , [AName]) else
  if (Value = 30 ) then result := Format('Square Root %s'        , [AName]) else
  if (Value = 45 ) then result := Format('Quartic Root Cubic %s' , [AName]) else
  if (Value = 60 ) then result := Format('%s'                    , [AName]) else
  if (Value = 90 ) then result := Format('Square Root Cubic %s'  , [AName]) else
  if (Value = 120) then result := Format('Square %s'             , [AName]) else
  if (Value = 150) then result := Format('Square Root Quintic %s', [AName]) else
  if (Value = 180) then result := Format('Cubic %s'              , [AName]) else
  if (Value = 240) then result := Format('Quartic %s'            , [AName]) else
  if (Value = 300) then result := Format('Quintic %s'            , [AName]) else
  if (Value = 360) then result := Format('Sextic %s'             , [AName]) else
    raise Exception.CreateFmt('ERROR: DimensionToLongString (%s)', [Value.ToString]);
end;

function DimensionToLongStringEx(const ADim: TExponents): string;
var
  Num, Denom: string;
begin
  Num := '';
  if ADim[1] > 0 then Num := Num + DimensionToLongString(ADim[1], '%sKilogram? ');
  if ADim[2] > 0 then Num := Num + DimensionToLongString(ADim[2], '%sMeter? '   );
  if ADim[3] > 0 then Num := Num + DimensionToLongString(ADim[3], '%sSecond? '  );
  if ADim[4] > 0 then Num := Num + DimensionToLongString(ADim[4], '%sAmpere? '  );
  if ADim[5] > 0 then Num := Num + DimensionToLongString(ADim[5], '%sKelvin? '  );
  if ADim[6] > 0 then Num := Num + DimensionToLongString(ADim[6], '%sMole? '    );
  if ADim[7] > 0 then Num := Num + DimensionToLongString(ADim[7], '%sCandela? ' );
  if ADim[8] > 0 then Num := Num + DimensionToLongString(ADim[8], 'Radian? '  );

  Denom := '';
  if ADim[1] < 0 then Denom := Denom + 'Per ' + DimensionToLongString(ADim[1], '%sKilogram ');
  if ADim[2] < 0 then Denom := Denom + 'Per ' + DimensionToLongString(ADim[2], '%sMeter '   );
  if ADim[3] < 0 then Denom := Denom + 'Per ' + DimensionToLongString(ADim[3], '%sSecond '  );
  if ADim[4] < 0 then Denom := Denom + 'Per ' + DimensionToLongString(ADim[4], '%sAmpere '  );
  if ADim[5] < 0 then Denom := Denom + 'Per ' + DimensionToLongString(ADim[5], '%sKelvin '  );
  if ADim[6] < 0 then Denom := Denom + 'Per ' + DimensionToLongString(ADim[6], '%sMole '    );
  if ADim[7] < 0 then Denom := Denom + 'Per ' + DimensionToLongString(ADim[7], '%sCandela ' );
  if ADim[8] < 0 then Denom := Denom + 'Per ' + DimensionToLongString(ADim[8], 'Radian '  );

  if Num = '' then
  begin
    if Denom = '' then
      result := ''
    else
      result := 'Reciprocal ' + StringReplace(Denom, 'Per ', '', [rfReplaceAll]);
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

function DimensionToQuantity(const ADim: TExponents): string;
begin
  result := 'T' + DimensionToLongStringEx(ADim);
  result := StringReplace(result, '%s', '', [rfReplaceAll]);
  result := StringReplace(result, '  ', '', [rfReplaceAll]);
  result := StringReplace(result, ' ' , '', [rfReplaceAll]);
  result := StringReplace(result, '?' , '', [rfReplaceAll]);
  result := StringReplace(result, '!' , '', [rfReplaceAll]);
end;

function DimensionToLongString(const ADim: TExponents): string;
begin
  result := LowerCase(DimensionToLongStringEx(ADim));
end;

function DimensionToShortString(const ADim: TExponents): string;
var
  Num, Denom: string;
begin
  Num := '';
  if ADim[1] > 0 then Num := Num + '.' + DimensionToShortString(ADim[1], '%skg' );
  if ADim[2] > 0 then Num := Num + '.' + DimensionToShortString(ADim[2], '%sm'  );
  if ADim[3] > 0 then Num := Num + '.' + DimensionToShortString(ADim[3], '%ss'  );
  if ADim[4] > 0 then Num := Num + '.' + DimensionToShortString(ADim[4], '%sA'  );
  if ADim[5] > 0 then Num := Num + '.' + DimensionToShortString(ADim[5], '%sK'  );
  if ADim[6] > 0 then Num := Num + '.' + DimensionToShortString(ADim[6], '%smol');
  if ADim[7] > 0 then Num := Num + '.' + DimensionToShortString(ADim[7], '%scd' );
  if ADim[8] > 0 then Num := Num + '.' + DimensionToShortString(ADim[8], 'rad');

  if (Length(Num) > 0) then Delete(Num, 1, 1);

  Denom := '';
  if ADim[1] < 0 then Denom := Denom + '/' + DimensionToShortString(ADim[1], '%skg' );
  if ADim[2] < 0 then Denom := Denom + '/' + DimensionToShortString(ADim[2], '%sm'  );
  if ADim[3] < 0 then Denom := Denom + '/' + DimensionToShortString(ADim[3], '%ss'  );
  if ADim[4] < 0 then Denom := Denom + '/' + DimensionToShortString(ADim[4], '%sA'  );
  if ADim[5] < 0 then Denom := Denom + '/' + DimensionToShortString(ADim[5], '%sK'  );
  if ADim[6] < 0 then Denom := Denom + '/' + DimensionToShortString(ADim[6], '%smol');
  if ADim[7] < 0 then Denom := Denom + '/' + DimensionToShortString(ADim[7], '%scd' );
  if ADim[8] < 0 then Denom := Denom + '/' + DimensionToShortString(ADim[8], 'rad');

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

