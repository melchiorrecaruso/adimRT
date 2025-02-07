{
  Description: Common unit.

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

unit ToolKitUnit;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, Common, Dialogs, FGL, Graphics, StrUtils, SysUtils;

type
  TToolKitItem = class
    FField: string;
    FQuantity: string;
    FDimension: string;
    FLongString:  string;
    FShortString: string;
    FIdentifier: string;
    FBase: string;
    FFactor: string;
    FPrefixes: string;
    FType: string;
    FColor: string;
    FExponents: TExponents;
    FIndex: longint;
  end;

  TToolKitList = class
  private
    FList: TList;
    function GetItem(Index: longint): TToolKitItem;
    function GetCount: longint;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Add(const Item: TToolKitItem);
    procedure Delete(Index: longint);
    procedure Clear;

    procedure MoveUp(Index: longint);
    procedure MoveDown(Index: longint);

    function Search(const AValue: string; AIndex: longint): longint;
    function Search(const ADim: TExponents): longint;
    function SearchFromEnd(const ADim: TExponents): longint;
    function SameValue(const ADim1, ADim2: TExponents): boolean;

    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
  public
    property Items[Index: longint]: TToolKitItem read GetItem; default;
    property Count: longint read GetCount;
  end;

  TToolKitBuilder = class(TThread)
  private
    BaseUnitCount: longint;
    FactoredUnitCount: longint;
    FList: TToolKitList;
    FDocument: TStringList;
    FMessage: string;
    FOnMessage: TThreadMethod;
    FOnStart: TThreadMethod;
    FOnStop: TThreadMethod;

    SectionA0:  TStringList;
    SectionA1:  TStringList;
    SectionA2:  TStringList;
    SectionA3:  TStringList;
    SectionA4:  TStringList;

    SectionB0:  TStringList;
    SectionB1:  TStringList;
    SectionB2:  TStringList;
    SectionB3:  TStringList;
    SectionB4:  TStringList;

    function  SearchLine(const ALine: string; ASection: TStringList): longint;
  public
    constructor Create(const AList: TToolKitList);
    destructor Destroy; override;

    procedure AddUnits(const SectionA, SectionB: TStringList);
    procedure AddUnit(const AItem: TToolKitItem; const ASection: TStringList);
    procedure AddClonedUnit(const AItem: TToolKitItem; const ASection: TStringList);
    procedure AddFactoredUnit(const AItem: TToolKitItem; const ASection: TStringList);
    procedure AddDegreeCelsiusUnit(const AItem: TToolKitItem; const ASection: TStringList);
    procedure AddDegreeFahrenheitUnit(const AItem: TToolKitItem; const ASection: TStringList);

    procedure AddSymbols(const AItem: TToolKitItem; const ASection: TStringList);
    procedure AddFactoredSymbols(const AItem: TToolKitItem; const SectionA: TStringList);
    procedure AddTable(ASection: TStringList);

    procedure Add(const AItem: TToolkitItem);
    procedure ExpandUnits;
    procedure CreateIndexes;
    procedure Check;
    function ReCheck: boolean;
    procedure Execute; override;
  public
    property Document: TStringList read FDocument;
    property Message: string read FMessage;
    property OnMessage: TThreadMethod read FOnMessage write FOnMessage;
    property OnStart: TThreadMethod read FOnStart write FOnStart;
    property OnStop: TThreadMethod read FOnStop write FOnStop;
  end;

  TIntegerList = specialize TFPGList<Integer>;


implementation

uses
  CSVDocument, DateUtils,  LCLType, Math, Process;

function CompareInteger(const Item1, Item2: longint): integer;
begin
  result := Item2 - Item1;
end;

// TToolKitBuilder

constructor TToolKitBuilder.Create(const AList: TToolKitList);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FDocument := TStringList.Create;
  FList := AList;
end;

destructor TToolKitBuilder.Destroy;
begin
  FDocument.Destroy;
  inherited Destroy;
end;

procedure TToolKitBuilder.AddUnits(const SectionA, SectionB: TStringList);
var
  i: longint;
begin
  CreateIndexes;
  for i := 0 to FList.Count -1 do
  begin
    if (FList[i].FBase = '') then
    begin
      Inc(BaseUnitCount);
      AddUnit(FList[i], SectionA);
      AddSymbols(FList[i], SectionA);
    end else
    begin
      if (FList[i].FFactor = '') then
      begin
        Inc(FactoredUnitCount);
        AddClonedUnit(FList[i], SectionA);
        AddSymbols(FList[i], SectionA);
      end else
        if Pos('%s', FList[i].FFactor) = 0 then
        begin
          Inc(FactoredUnitCount);
          AddFactoredUnit(FList[i], SectionA);
          AddSymbols(FList[i], SectionA);
        end else
        begin
          Inc(FactoredUnitCount);
          AddFactoredUnit(FList[i], SectionA);
          AddSymbols(FList[i], SectionA);
        end;
    end;
  end;
  Check;
end;

procedure TToolKitBuilder.AddUnit(const AItem: TToolKitItem; const ASection: TStringList);
begin
  ASection.Add('{ T%s }', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('');
  ASection.Add('resourcestring');
  ASection.Add('  %s = ''%s'';', [GetSymbolResourceString(AItem.FQuantity), GetSymbol(AItem.FShortString)]);
  ASection.Add('  %s = ''%s'';', [GetSingularNameResourceString(AItem.FQuantity), GetSingularName(AItem.FLongString)]);
  ASection.Add('  %s = ''%s'';', [GetPluralNameResourceString(AItem.FQuantity), GetPluralName(AItem.FLongString)]);
  ASection.Add('');
  ASection.Add('const');
  ASection.Add('  %sID = %s;', [GetUnitID(AItem.FQuantity), IntToStr(AItem.FIndex)]);
  ASection.Add('  %sUnit : TUnit = (', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('    FID         : %sID;', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('    FSymbol     : %s;', [GetSymbolResourceString(AItem.FQuantity)]);
  ASection.Add('    FName       : %s;', [GetSingularNameResourceString(AItem.FQuantity)]);
  ASection.Add('    FPluralName : %s;', [GetPluralNameResourceString(AItem.FQuantity)]);
  ASection.Add('    FPrefixes   : (%s);', [GetPrefixes(AItem.FShortString)]);
  ASection.Add('    FExponents  : (%s));', [GetExponents(AItem.FShortString)]);
  ASection.Add('');
end;

procedure TToolKitBuilder.AddClonedUnit(const AItem: TToolKitItem; const ASection: TStringList);
begin
  ASection.Add('{ T%s }', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('');
  ASection.Add('resourcestring');
  ASection.Add('  %s = ''%s'';', [GetSymbolResourceString(AItem.FQuantity), GetSymbol(AItem.FShortString)]);
  ASection.Add('  %s = ''%s'';', [GetSingularNameResourceString(AItem.FQuantity), GetSingularName(AItem.FLongString)]);
  ASection.Add('  %s = ''%s'';', [GetPluralNameResourceString(AItem.FQuantity), GetPluralName(AItem.FLongString)]);
  ASection.Add('');
  ASection.Add('const');
  ASection.Add('  %sUnit : TUnit = (', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('    FID         : %sID;', [GetUnitID(AItem.FBase)]);
  ASection.Add('    FSymbol     : %s;', [GetSymbolResourceString(AItem.FQuantity)]);
  ASection.Add('    FName       : %s;', [GetSingularNameResourceString(AItem.FQuantity)]);
  ASection.Add('    FPluralName : %s;', [GetPluralNameResourceString(AItem.FQuantity)]);
  ASection.Add('    FPrefixes   : (%s);', [GetPrefixes(AItem.FShortString)]);
  ASection.Add('    FExponents  : (%s));', [GetExponents(AItem.FShortString)]);
  ASection.Add('');
end;

procedure TToolKitBuilder.AddFactoredUnit(const AItem: TToolKitItem; const ASection: TStringList);
begin
  if LowerCase(AItem.FFactor) = 'celsius' then
  begin
    AddDegreeCelsiusUnit(AItem, ASection)
  end else
  begin
    if LowerCase(AItem.FFactor) = 'fahrenheit' then
    begin
      AddDegreeFahrenheitUnit(AItem, ASection)
    end else
    begin
      ASection.Add('{ T%s }', [GetUnitID(AItem.FQuantity)]);
      ASection.Add('');
      ASection.Add('resourcestring');
      ASection.Add('  %s = ''%s'';', [GetSymbolResourceString(AItem.FQuantity), GetSymbol(AItem.FShortString)]);
      ASection.Add('  %s = ''%s'';', [GetSingularNameResourceString(AItem.FQuantity), GetSingularName(AItem.FLongString)]);
      ASection.Add('  %s = ''%s'';', [GetPluralNameResourceString(AItem.FQuantity), GetPluralName(AItem.FLongString)]);
      ASection.Add('');
      ASection.Add('const');
      ASection.Add('  %sUnit : TFactoredUnit = (', [GetUnitID(AItem.FQuantity)]);
      ASection.Add('    FID         : %sID;', [GetUnitID(AItem.FBase)]);
      ASection.Add('    FSymbol     : %s;', [GetSymbolResourceString(AItem.FQuantity)]);
      ASection.Add('    FName       : %s;', [GetSingularNameResourceString(AItem.FQuantity)]);
      ASection.Add('    FPluralName : %s;', [GetPluralNameResourceString(AItem.FQuantity)]);
      ASection.Add('    FPrefixes   : (%s);', [GetPrefixes(AItem.FShortString)]);
      ASection.Add('    FExponents  : (%s);', [GetExponents(AItem.FShortString)]);
      ASection.Add('    FFactor     : (%s));', [AItem.FFactor]);
      ASection.Add('');
    end;
  end;
end;

procedure TToolKitBuilder.AddDegreeCelsiusUnit(const AItem: TToolKitItem; const ASection: TStringList);
begin
  ASection.Add('{ T%s }', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('');
  ASection.Add('resourcestring');
  ASection.Add('  %s = ''%s'';', [GetSymbolResourceString(AItem.FQuantity), GetSymbol(AItem.FShortString)]);
  ASection.Add('  %s = ''%s'';', [GetSingularNameResourceString(AItem.FQuantity), GetSingularName(AItem.FLongString)]);
  ASection.Add('  %s = ''%s'';', [GetPluralNameResourceString(AItem.FQuantity), GetPluralName(AItem.FLongString)]);
  ASection.Add('');
  ASection.Add('const');
  ASection.Add('  %sUnit : TDegreeCelsiusUnit = (', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('    FID         : %sID;', [GetUnitID(AItem.FBase)]);
  ASection.Add('    FSymbol     : %s;', [GetSymbolResourceString(AItem.FQuantity)]);
  ASection.Add('    FName       : %s;', [GetSingularNameResourceString(AItem.FQuantity)]);
  ASection.Add('    FPluralName : %s;', [GetPluralNameResourceString(AItem.FQuantity)]);
  ASection.Add('    FPrefixes   : (%s);', [GetPrefixes(AItem.FShortString)]);
  ASection.Add('    FExponents  : (%s));', [GetExponents(AItem.FShortString)]);
  ASection.Add('');
end;

procedure TToolKitBuilder.AddDegreeFahrenheitUnit(const AItem: TToolKitItem; const ASection: TStringList);
begin
  ASection.Add('{ T%s }', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('');
  ASection.Add('resourcestring');
  ASection.Add('  %s = ''%s'';', [GetSymbolResourceString(AItem.FQuantity), GetSymbol(AItem.FShortString)]);
  ASection.Add('  %s = ''%s'';', [GetSingularNameResourceString(AItem.FQuantity), GetSingularName(AItem.FLongString)]);
  ASection.Add('  %s = ''%s'';', [GetPluralNameResourceString(AItem.FQuantity), GetPluralName(AItem.FLongString)]);
  ASection.Add('');
  ASection.Add('const');
  ASection.Add('  %sUnit : TDegreeFahrenheitUnit = (', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('    FID : %sID;', [GetUnitID(AItem.FBase)]);
  ASection.Add('    FSymbol            : %s;', [GetSymbolResourceString(AItem.FQuantity)]);
  ASection.Add('    FName              : %s;', [GetSingularNameResourceString(AItem.FQuantity)]);
  ASection.Add('    FPluralName        : %s;', [GetPluralNameResourceString(AItem.FQuantity)]);
  ASection.Add('    FPrefixes          : (%s);', [GetPrefixes(AItem.FShortString)]);
  ASection.Add('    FExponents         : (%s));', [GetExponents(AItem.FShortString)]);
  ASection.Add('');
end;

procedure TToolKitBuilder.AddSymbols(const AItem: TToolKitItem; const ASection: TStringList);
const
  S = '  %-10s : TQuantity = {$IFDEF ADIMDEBUG} (FID: %d; FValue: %s); {$ELSE} (%s); {$ENDIF}';
begin
  if (AItem.FBase = '') then
  begin
    // Base unit symbols
    if AItem.FIdentifier <> '' then
    begin
      ASection.Add('var');
      ASection.Add('  %s : TUnit absolute %sUnit;', [AItem.FIdentifier, GetUnitID(AItem.FQuantity)]);
      ASection.Add('');
    end;
    if AItem.FIdentifier <> '' then
      AddFactoredSymbols(AItem, ASection);
  end else
  begin
    if (AItem.FFactor = '') then
    begin
      // Cloned unit symbols
      if AItem.FIdentifier <> '' then
      begin
        ASection.Add('var');
        ASection.Add('  %s : TUnit absolute %sUnit;', [AItem.FIdentifier, GetUnitID(AItem.FQuantity)]);
        ASection.Add('');
      end;
      if AItem.FIdentifier <> '' then
        AddFactoredSymbols(AItem, ASection);
    end else
    begin
      // Factored unit symbol
      if AItem.FIdentifier <> '' then
      begin
        ASection.Add('var');
        if LowerCase(AItem.FFactor) = 'celsius' then
          ASection.Add('  %s : TDegreeCelsiusUnit absolute %sUnit;', [AItem.FIdentifier, GetUnitID(AItem.FQuantity)])
        else
          if LowerCase(AItem.FFactor) = 'fahrenheit' then
            ASection.Add('  %s : TDegreeFahrenheitUnit absolute %sUnit;', [AItem.FIdentifier, GetUnitID(AItem.FQuantity)])
          else
            ASection.Add('  %s : TFactoredUnit absolute %sUnit;', [AItem.FIdentifier, GetUnitID(AItem.FQuantity)]);
        ASection.Add('');
      end;
      if AItem.FIdentifier <> '' then
        AddFactoredSymbols(AItem, ASection);
    end;
  end;
end;

procedure TToolKitBuilder.AddFactoredSymbols(const AItem: TToolKitItem; const SectionA: TStringList);
var
  i, j: longint;
  Params: string;
  Power: longint;
  LocList: TStringList;
  Str: string;
  Factor: string;
  FIndex: string;
begin
  Str := '  %-10s : TQuantity = {$IFDEF ADIMDEBUG} (FID: %sID; FValue: %s); {$ELSE} (%s); {$ENDIF}';

  Factor := '';
  if AItem.FFactor <> '' then
    Factor := AItem.FFactor + ' * ';

  if Length(AItem.FPrefixes) = 24 then
  begin
    Params := AItem.FPrefixes;
  end else
    Params := '------------------------';

  Power  := 1;
  if Pos('2', AItem.FIdentifier) > 0 then Power := 2;
  if Pos('3', AItem.FIdentifier) > 0 then Power := 3;
  if Pos('4', AItem.FIdentifier) > 0 then Power := 4;
  if Pos('5', AItem.FIdentifier) > 0 then Power := 5;
  if Pos('6', AItem.FIdentifier) > 0 then Power := 6;
  if Pos('7', AItem.FIdentifier) > 0 then Power := 7;
  if Pos('8', AItem.FIdentifier) > 0 then Power := 8;
  if Pos('9', AItem.FIdentifier) > 0 then Power := 9;

  if AItem.FBase = '' then
    FIndex := GetUnitID(AItem.FQuantity)
  else
    FIndex := GetUnitID(AItem.FBase);

  LocList := TStringList.Create;
  if (LowerCase(AItem.FIdentifier) <> 'kg' ) and
     (LowerCase(AItem.FIdentifier) <> 'kg2') then
  begin
    if Params[ 1] = 'L' then LocList.Append(Format(Str, ['quetta' + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, +30*Power)), Factor + FormatFloat('0E+00', IntPower(10, +30*Power))]));
    if Params[ 1] = 'S' then LocList.Append(Format(Str, ['Q'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, +30*Power)), Factor + FormatFloat('0E+00', IntPower(10, +30*Power))]));
    if Params[ 2] = 'L' then LocList.Append(Format(Str, ['ronna'  + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, +27*Power)), Factor + FormatFloat('0E+00', IntPower(10, +27*Power))]));
    if Params[ 2] = 'S' then LocList.Append(Format(Str, ['R'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, +27*Power)), Factor + FormatFloat('0E+00', IntPower(10, +27*Power))]));
    if Params[ 3] = 'L' then LocList.Append(Format(Str, ['yotta'  + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, +24*Power)), Factor + FormatFloat('0E+00', IntPower(10, +24*Power))]));
    if Params[ 3] = 'S' then LocList.Append(Format(Str, ['Y'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, +24*Power)), Factor + FormatFloat('0E+00', IntPower(10, +24*Power))]));
    if Params[ 4] = 'L' then LocList.Append(Format(Str, ['zetta'  + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, +21*Power)), Factor + FormatFloat('0E+00', IntPower(10, +21*Power))]));
    if Params[ 4] = 'S' then LocList.Append(Format(Str, ['Z'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, +21*Power)), Factor + FormatFloat('0E+00', IntPower(10, +21*Power))]));
    if Params[ 5] = 'L' then LocList.Append(Format(Str, ['exa'    + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, +18*Power)), Factor + FormatFloat('0E+00', IntPower(10, +18*Power))]));
    if Params[ 5] = 'S' then LocList.Append(Format(Str, ['E'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, +18*Power)), Factor + FormatFloat('0E+00', IntPower(10, +18*Power))]));
    if Params[ 6] = 'L' then LocList.Append(Format(Str, ['peta'   + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, +15*Power)), Factor + FormatFloat('0E+00', IntPower(10, +15*Power))]));
    if Params[ 6] = 'S' then LocList.Append(Format(Str, ['P'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, +15*Power)), Factor + FormatFloat('0E+00', IntPower(10, +15*Power))]));

    if Params[ 7] = 'L' then LocList.Append(Format(Str, ['tera'   + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, +12*Power)), Factor + FormatFloat('0E+00', IntPower(10, +12*Power))]));
    if Params[ 7] = 'S' then LocList.Append(Format(Str, ['T'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, +12*Power)), Factor + FormatFloat('0E+00', IntPower(10, +12*Power))]));
    if Params[ 8] = 'L' then LocList.Append(Format(Str, ['giga'   + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, + 9*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 9*Power))]));
    if Params[ 8] = 'S' then LocList.Append(Format(Str, ['G'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, + 9*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 9*Power))]));
    if Params[ 9] = 'L' then LocList.Append(Format(Str, ['mega'   + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, + 6*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 6*Power))]));
    if Params[ 9] = 'S' then LocList.Append(Format(Str, ['M'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, + 6*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 6*Power))]));
    if Params[10] = 'L' then LocList.Append(Format(Str, ['kilo'   + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, + 3*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 3*Power))]));
    if Params[10] = 'S' then LocList.Append(Format(Str, ['k'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, + 3*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 3*Power))]));
    if Params[11] = 'L' then LocList.Append(Format(Str, ['hecto'  + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, + 2*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 2*Power))]));
    if Params[11] = 'S' then LocList.Append(Format(Str, ['h'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, + 2*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 2*Power))]));
    if Params[12] = 'L' then LocList.Append(Format(Str, ['deca'   + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, + 1*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 1*Power))]));
    if Params[12] = 'S' then LocList.Append(Format(Str, ['da'     + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, + 1*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 1*Power))]));
    if Params[13] = 'L' then LocList.Append(Format(Str, ['deci'   + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, - 1*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 1*Power))]));
    if Params[13] = 'S' then LocList.Append(Format(Str, ['d'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, - 1*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 1*Power))]));
    if Params[14] = 'L' then LocList.Append(Format(Str, ['centi'  + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, - 2*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 2*Power))]));
    if Params[14] = 'S' then LocList.Append(Format(Str, ['c'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, - 2*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 2*Power))]));
    if Params[15] = 'L' then LocList.Append(Format(Str, ['milli'  + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, - 3*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 3*Power))]));
    if Params[15] = 'S' then LocList.Append(Format(Str, ['m'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, - 3*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 3*Power))]));
    if Params[16] = 'L' then LocList.Append(Format(Str, ['micro'  + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, - 6*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 6*Power))]));
    if Params[16] = 'S' then LocList.Append(Format(Str, ['mi'     + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, - 6*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 6*Power))]));
    if Params[17] = 'L' then LocList.Append(Format(Str, ['nano'   + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, - 9*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 9*Power))]));
    if Params[17] = 'S' then LocList.Append(Format(Str, ['n'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, - 9*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 9*Power))]));
    if Params[18] = 'L' then LocList.Append(Format(Str, ['pico'   + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, -12*Power)), Factor + FormatFloat('0E+00', IntPower(10, -12*Power))]));
    if Params[18] = 'S' then LocList.Append(Format(Str, ['p'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, -12*Power)), Factor + FormatFloat('0E+00', IntPower(10, -12*Power))]));

    if Params[19] = 'L' then LocList.Append(Format(Str, ['femto'  + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, -15*Power)), Factor + FormatFloat('0E+00', IntPower(10, -15*Power))]));
    if Params[19] = 'S' then LocList.Append(Format(Str, ['f'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, -15*Power)), Factor + FormatFloat('0E+00', IntPower(10, -15*Power))]));
    if Params[20] = 'L' then LocList.Append(Format(Str, ['atto'   + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, -18*Power)), Factor + FormatFloat('0E+00', IntPower(10, -18*Power))]));
    if Params[20] = 'S' then LocList.Append(Format(Str, ['a'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, -18*Power)), Factor + FormatFloat('0E+00', IntPower(10, -18*Power))]));
    if Params[21] = 'L' then LocList.Append(Format(Str, ['zepto'  + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, -21*Power)), Factor + FormatFloat('0E+00', IntPower(10, -21*Power))]));
    if Params[21] = 'S' then LocList.Append(Format(Str, ['z'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, -21*Power)), Factor + FormatFloat('0E+00', IntPower(10, -21*Power))]));
    if Params[22] = 'L' then LocList.Append(Format(Str, ['yocto'  + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, -24*Power)), Factor + FormatFloat('0E+00', IntPower(10, -24*Power))]));
    if Params[22] = 'S' then LocList.Append(Format(Str, ['y'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, -24*Power)), Factor + FormatFloat('0E+00', IntPower(10, -24*Power))]));
    if Params[23] = 'L' then LocList.Append(Format(Str, ['ronto'  + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, -27*Power)), Factor + FormatFloat('0E+00', IntPower(10, -27*Power))]));
    if Params[23] = 'S' then LocList.Append(Format(Str, ['r'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, -27*Power)), Factor + FormatFloat('0E+00', IntPower(10, -27*Power))]));
    if Params[24] = 'L' then LocList.Append(Format(Str, ['quecto' + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, -30*Power)), Factor + FormatFloat('0E+00', IntPower(10, -30*Power))]));
    if Params[24] = 'S' then LocList.Append(Format(Str, ['q'      + AItem.FIdentifier, FIndex, Factor + FormatFloat('0E+00', IntPower(10, -30*Power)), Factor + FormatFloat('0E+00', IntPower(10, -30*Power))]));
  end else
    if (LowerCase(AItem.FIdentifier) = 'kg') then
    begin
      LocList.Append(Format(Str, ['hg'  , FIndex, '1E-01', '1E-01']));
      LocList.Append(Format(Str, ['dag' , FIndex, '1E-02', '1E-02']));
      LocList.Append(Format(Str, ['g'   , FIndex, '1E-03', '1E-03']));
      LocList.Append(Format(Str, ['dg'  , FIndex, '1E-04', '1E-04']));
      LocList.Append(Format(Str, ['cg'  , FIndex, '1E-05', '1E-05']));
      LocList.Append(Format(Str, ['mg'  , FIndex, '1E-06', '1E-06']));
      LocList.Append(Format(Str, ['mig' , FIndex, '1E-09', '1E-09']));
      LocList.Append(Format(Str, ['ng'  , FIndex, '1E-12', '1E-12']));
      LocList.Append(Format(Str, ['pg'  , FIndex, '1E-15', '1E-15']));
    end else
      if (LowerCase(AItem.FIdentifier) = 'kg2') then
      begin
        LocList.Append(Format(Str, ['hg2'  , FIndex, '1E-02', '1E-02']));
        LocList.Append(Format(Str, ['dag2' , FIndex, '1E-04', '1E-04']));
        LocList.Append(Format(Str, ['g2'   , FIndex, '1E-06', '1E-06']));
        LocList.Append(Format(Str, ['dg2'  , FIndex, '1E-08', '1E-08']));
        LocList.Append(Format(Str, ['cg2'  , FIndex, '1E-10', '1E-10']));
        LocList.Append(Format(Str, ['mg2'  , FIndex, '1E-12', '1E-12']));
        LocList.Append(Format(Str, ['mig2' , FIndex, '1E-18', '1E-18']));
        LocList.Append(Format(Str, ['ng2'  , FIndex, '1E-24', '1E-24']));
        LocList.Append(Format(Str, ['pg2'  , FIndex, '1E-30', '1E-30']));
      end;

  j := 0;
  if LocList.Count > 0 then
  begin
    SectionA.Append('const');
    for i := 0 to LocList.Count -1 do
      j := Max(j, Length(LocList[i]));

    for i := 0 to LocList.Count -1 do
    begin
      while Length(LocList[i]) < j do
        LocList[i] := ' ' + LocList[i];
      SectionA.Append(LocList[i]);
    end;
    SectionA.Append('');
  end;
  LocList.Destroy;
end;

procedure TToolKitBuilder.AddTable(ASection: TStringList);
var
  i: longint;
  Line: string;
begin
  ASection.Add('const');
  ASection.Add('  Table : array[0..%s-1] of', [BaseUnitCount.toString]);
  ASection.Add('    record FID: longint; FStr: string; end = (', []);

  for i := 0 to FList.Count -1 do
    if FList[i].FBase = '' then
    begin
      ASection.Add('    (FID: %5s; FStr: ''T%s''),', [FList[i].FIndex.ToString, GetUnitID(FList[i].FQuantity)]);
    end;

  Line := ASection[ASection.Count-1];
  SetLength(Line, Length(Line)-1);
  ASection[ASection.Count-1] := Line;
  ASection.Add('  );');
end;

procedure TToolKitBuilder.Add(const AItem: TToolkitItem);
begin
  FList.Add(AItem);
end;

procedure TToolKitBuilder.Check;
var
  i, j: longint;
begin
  for i := 0 to FList.Count -1 do
    if FList[i].FBase = '' then
    begin
      for j := 0 to FList.Count -1 do
        if FList[j].FBase = '' then
        begin
          if FList.SameValue(FList[i].FExponents, FList[j].FExponents) and (i <> j) then
          begin
            FMessage := Format('FATAL ERROR: %s and %s have same units of measurement.', [FList[i].FQuantity, FList[j].FQuantity]);
            if Assigned(FOnMessage) then Queue(FOnMessage);
          end;

          if (FList[i].FIndex = FList[j].FIndex) and (i <> j) then
          begin
            FMessage := Format('FATAL ERROR: %s and %s have same units of measurement.', [FList[i].FQuantity, FList[j].FQuantity]);
            if Assigned(FOnMessage) then Queue(FOnMessage);
          end;
        end;

      if FList.Search(GetReciprocal(FList[i].FExponents)) = -1 then
      begin
        FMessage := Format('WARNING: %s unit hasn''t a reciprocal.', [FList[i].FQuantity]);
        if Assigned(FOnMessage) then Queue(FOnMessage);
      end;
    end;
end;

function TToolKitBuilder.ReCheck: boolean;
var
  i, j, k: longint;
  kExponents: TExponents;
  kIndex: longint;
begin
  for i := 0 to FList.Count -1 do
    if FList[i].FBase = '' then
    begin
      for j := 0 to FList.Count -1 do
        if FList[j].FBase = '' then
        begin
          // Multiply
          kExponents := SumDim(FList[i].FExponents, FList[j].FExponents);
          kIndex     := FList[i].FIndex + FList[j].FIndex;

          for k := 0 to FList.Count -1 do
            if (FList[k].FBase = '') and FList.SameValue(FList[k].FExponents, kExponents) and (FList[k].FIndex <> kIndex) then Exit(False);

          // Divide
          kExponents := SubDim(FList[i].FExponents, FList[j].FExponents);
          kIndex     := FList[i].FIndex - FList[j].FIndex;

          for k := 0 to FList.Count -1 do
            if (FList[k].FBase = '') and FList.SameValue(FList[k].FExponents, kExponents) and (FList[k].FIndex <> kIndex) then Exit(False);
        end;
    end;
  result := True;
end;

procedure TToolKitBuilder.CreateIndexes;
var
 i, j: longint;
 Weights: TExponents;
 IsNeededRecalculate: boolean;
 Indexes: TIntegerList;
begin
  Indexes := TIntegerList.Create;
  Indexes.Sort(@CompareInteger);
  for i := 0 to FList.Count -1 do
  begin
    if (FList[i].FBase = '') then
      FList[i].FExponents := StringToDimensions(FList[i].FDimension);
  end;
  ExpandUnits;

  IsNeededRecalculate := True;
  while IsNeededRecalculate do
  begin
    for i := Low(Weights) to High(Weights) do
      Weights[i] := random(255);

    Indexes.Clear;
    for i := 0 to FList.Count -1 do
      if FList[i].FBase = '' then
      begin
        FList[i].FIndex :=
          Trunc(FList[i].FExponents[1]*Weights[1]) +
          Trunc(FList[i].FExponents[2]*Weights[2]) +
          Trunc(FList[i].FExponents[3]*Weights[3]) +
          Trunc(FList[i].FExponents[4]*Weights[4]) +
          Trunc(FList[i].FExponents[5]*Weights[5]) +
          Trunc(FList[i].FExponents[6]*Weights[6]) +
          Trunc(FList[i].FExponents[7]*Weights[7]) +
          Trunc(FList[i].FExponents[8]*Weights[8]);

        IsNeededRecalculate := Indexes.IndexOf(FList[i].FIndex) <> -1;
        if IsNeededRecalculate = False then
          Indexes.Add(FList[i].FIndex)
        else
          Break;
      end;

    if IsNeededRecalculate = False then
      IsNeededRecalculate := ReCheck = False;
  end;
  Indexes.Destroy;

  for i := 0 to FList.Count -1 do
  begin
    if FList[i].FBase <> '' then
    begin
      j := FList.Search(FList[i].FBase, 1);
      if j <> -1 then
      begin
        FList[i].FExponents := FList[j].FExponents;
        FList[i].FIndex := FList[j].FIndex;
      end else
      begin
        FMessage := Format('%s base unit not found', [FList[i].FQuantity]);
        if Assigned(FOnMessage) then Queue(FOnMessage);
      end;
    end;
  end;
end;

procedure TToolKitBuilder.ExpandUnits;
var
 i, j: longint;
 NewDim: TExponents;
 NewItem: TToolKitItem;
begin
  // Expand base unit
  i := 0;
  while i < FList.Count do
  begin
    if FList[i].FBase = '' then
    begin
      for j := Low(NewDim) to High(NewDim) do
      begin
         NewDim := FList[i].FExponents;
         NewDim[j] := 0;

         if FList.Search(NewDim) = -1 then
         begin
           NewItem := TToolKitItem.Create;
           NewItem.FField       := '';
           NewItem.FQuantity    := DimensionToQuantity(NewDim);
           NewItem.FDimension   := DimensionToString(NewDim);
           NewItem.FLongString  := DimensionToLongString(NewDim);
           NewItem.FShortString := DimensionToShortString(NewDim);
           NewItem.FIdentifier  := '';
           NewItem.FBase        := '';
           NewItem.FFactor      := '';
           NewItem.FPrefixes    := '';
           NewItem.FExponents   := NewDim;
           NewItem.FType        := '';
           NewItem.FColor       := '';
           NewItem.FIndex       := 0;
           FList.Add(NewItem);
         end;
       end;
    end;
    Inc(i);
  end;

  // Adding reciprocal units
  i := 0;
  while i < FList.Count do
  begin
    if FList[i].FBase = '' then
    begin
      for j := Low(NewDim) to High(NewDim) do
        NewDim[j] := -FList[i].FExponents[j];

      if FList.Search(NewDim) = -1 then
      begin
        NewItem := TToolKitItem.Create;
        NewItem.FField       := '';
        NewItem.FQuantity    := DimensionToQuantity(NewDim);
        NewItem.FDimension   := DimensionToString(NewDim);
        NewItem.FLongString  := DimensionToLongString(NewDim);
        NewItem.FShortString := DimensionToShortString(NewDim);
        NewItem.FIdentifier  := '';
        NewItem.FBase        := '';
        NewItem.FFactor      := '';
        NewItem.FPrefixes    := '';
        NewItem.FExponents   := NewDim;
        NewItem.FType        := '';
        NewItem.FColor       := '';
        NewItem.FIndex       := 0;
        FList.Add(NewItem);
      end;
    end;
    Inc(i);
  end;
end;

procedure TToolKitBuilder.Execute;
var
  i: longint;
  Stream: TResourceStream;
begin
  if Assigned(FOnStart) then
    Synchronize(FOnStart);
  SectionA0 := TStringList.Create;
  SectionA1 := TStringList.Create;
  SectionA2 := TStringList.Create;
  SectionA3 := TStringList.Create;
  SectionA4 := TStringList.Create;
  SectionB0 := TStringList.Create;
  SectionB1 := TStringList.Create;
  SectionB2 := TStringList.Create;
  SectionB3 := TStringList.Create;
  SectionB4 := TStringList.Create;

  BaseUnitCount     := 0;
  FactoredUnitCount := 0;

  Stream := TResourceStream.Create(HInstance, 'Section-A0', RT_RCDATA);
  SectionA0.LoadFromStream(Stream);
  SectionA0.Insert(0, '');
  SectionA0.Append('');
  Stream.Destroy;

  Stream := TResourceStream.Create(HInstance, 'Section-B0', RT_RCDATA);
  SectionB0.LoadFromStream(Stream);
  SectionB0.Insert(0, '');
  SectionB0.Append('');
  Stream.Destroy;

  Stream := TResourceStream.Create(HInstance, 'Section-A1', RT_RCDATA);
  SectionA1.LoadFromStream(Stream);
  SectionA1.Insert(0, '');
  SectionA1.Append('');
  Stream.Destroy;

  Stream := TResourceStream.Create(HInstance, 'Section-B1', RT_RCDATA);
  SectionB1.LoadFromStream(Stream);
  SectionB1.Insert(0, '');
  SectionB1.Append('');
  Stream.Destroy;

  AddUnits(SectionA3, SectionB3);
  AddTable(SectionB0);

  Stream := TResourceStream.Create(HInstance, 'Section-A4', RT_RCDATA);
  SectionA4.LoadFromStream(Stream);
  SectionA4.Insert(0, '');
  SectionA4.Append('');
  Stream.Destroy;

  Stream := TResourceStream.Create(HInstance, 'Section-B4', RT_RCDATA);
  SectionB4.LoadFromStream(Stream);
  SectionB4.Insert(0, '');
  SectionB4.Append('');
  Stream.Destroy;

  SectionA0.Append('');
  SectionA0.Append('unit ADim;');
  SectionA0.Append('');
  SectionA0.Append('{$H+}{$J-}');
  SectionA0.Append('{$modeswitch advancedrecords}');
  SectionA0.Append('{$WARN 5024 OFF} // Suppress warning for unused routine parameter.');
  SectionA0.Append('{$WARN 5033 OFF} // Suppress warning for unassigned function''s return value.');
  SectionA0.Append('');

  SectionA0.Append('{');
  SectionA0.Append(Format('  ADim Run-time library built on %s.', [FormatDateTime('DD/MM/YYYY', Now)]));
  SectionA0.Append('');

  SectionA0.Append(Format('  Number of base units: %d', [BaseUnitCount]));
  SectionA0.Append(Format('  Number of factored units: %d', [FactoredUnitCount]));
  SectionA0.Append('}');
  SectionA0.Append('');

  for I := 0 to SectionA0 .Count -1 do FDocument.Append(SectionA0 [I]);
  for I := 0 to SectionA1 .Count -1 do FDocument.Append(SectionA1 [I]);
  for I := 0 to SectionA2 .Count -1 do FDocument.Append(SectionA2 [I]);
  for I := 0 to SectionA3 .Count -1 do FDocument.Append(SectionA3 [I]);
  for I := 0 to SectionA4 .Count -1 do FDocument.Append(SectionA4 [I]);

  for I := 0 to SectionB0 .Count -1 do FDocument.Append(SectionB0 [I]);
  for I := 0 to SectionB1 .Count -1 do FDocument.Append(SectionB1 [I]);
  for I := 0 to SectionB2 .Count -1 do FDocument.Append(SectionB2 [I]);
  for I := 0 to SectionB3 .Count -1 do FDocument.Append(SectionB3 [I]);
  for I := 0 to SectionB4 .Count -1 do FDocument.Append(SectionB4 [I]);

  FDocument.Add('');
  FDocument.Add('end.');
  CleanDocument(FDocument);

  SectionB4 .Destroy;
  SectionB3 .Destroy;
  SectionB2 .Destroy;
  SectionB1 .Destroy;
  SectionB0 .Destroy;

  SectionA4 .Destroy;
  SectionA3 .Destroy;
  SectionA2 .Destroy;
  SectionA1 .Destroy;
  SectionA0 .Destroy;

  if Assigned(FOnStop) then
    Synchronize(FOnStop);
end;

function TToolKitBuilder.SearchLine(const ALine: string; ASection: TStringList): longint;
var
  i: longint;
begin
  for i := 0 to ASection.Count -1 do
  begin
    if IsWild(ASection[i], ALine, False) then Exit(i);
  end;
  Result := -1;
end;

// TToolKitList

constructor TToolKitList.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TToolKitList.Destroy;
begin
  Clear;
  FList.Destroy;
  inherited Destroy;
end;

procedure TToolKitList.Add(const Item: TToolKitItem);
begin
  FList.Add(Item);
end;

procedure TToolKitList.Delete(Index: longint);
begin
  TToolKitItem(FList[Index]).Destroy;
  FList.Delete(Index);
end;

procedure TToolKitList.Clear;
var
  i: longint;
begin
  for i := 0 to FList.Count -1 do
    TToolKitItem(FList[i]).Destroy;
  FList.Clear;
end;

procedure TToolKitList.MoveUp(Index: longint);
var
  Item1: pointer;
  Item2: pointer;
begin
  if Index > 0 then
  begin
    Item1 := FList[Index -1];
    Item2 := FList[Index   ];

    FList[Index -1] := Item2;
    FList[Index   ] := Item1;
  end;
end;

procedure TToolKitList.MoveDown(Index: longint);
var
  Item1: pointer;
  Item2: pointer;
begin
  if Index < FList.Count -1 then
  begin
    Item1 := FList[Index   ];
    Item2 := FList[Index +1];

    FList[Index   ] := Item2;
    FList[Index +1] := Item1;
  end;
end;

function TToolKitList.Search(const AValue: string; AIndex: longint): longint;
var
  i: longint;
  Item: TToolKitItem;
begin
  for i := 0 to FList.Count -1 do
  begin
    Item := TToolKitItem(FList[i]);
    case AIndex of
      0: if CompareText(Item.FField,       AValue) = 0 then Exit(i);
      1: if CompareText(Item.FQuantity,    AValue) = 0 then Exit(i);
      2: if CompareText(Item.FDimension,   AValue) = 0 then Exit(i);
      3: if CompareText(Item.FLongString,  AValue) = 0 then Exit(i);
      4: if CompareText(Item.FShortString, AValue) = 0 then Exit(i);
      5: if CompareText(Item.FIdentifier,  AValue) = 0 then Exit(i);
      6: if CompareText(Item.FBase,        AValue) = 0 then Exit(i);
      7: if CompareText(Item.FFactor,      AValue) = 0 then Exit(i);
      8: if CompareText(Item.FPrefixes,    AValue) = 0 then Exit(i);
      9: if CompareText(Item.FType,        AValue) = 0 then Exit(i);
    end;
  end;
  result := -1;
end;

function TToolKitList.Search(const ADim: TExponents): longint;
var
  i: longint;
  Item: TToolKitItem;
begin
  for i := 0 to FList.Count -1 do
  begin
    Item := TToolKitItem(FList[i]);
    if Item.FBase = '' then
    begin
      if Math.SameValue(Item.FExponents[1], ADim[1]) and
         Math.SameValue(Item.FExponents[2], ADim[2]) and
         Math.SameValue(Item.FExponents[3], ADim[3]) and
         Math.SameValue(Item.FExponents[4], ADim[4]) and
         Math.SameValue(Item.FExponents[5], ADim[5]) and
         Math.SameValue(Item.FExponents[6], ADim[6]) and
         Math.SameValue(Item.FExponents[7], ADim[7]) and
         Math.SameValue(Item.FExponents[8], ADim[8]) then Exit(i);
    end;
  end;
  result := -1;
end;

function TToolKitList.SearchFromEnd(const ADim: TExponents): longint;
var
  i: longint;
  Item: TToolKitItem;
begin
  for i := FList.Count -1 downto 0 do
  begin
    Item := TToolKitItem(FList[i]);
    if Item.FBase = '' then
    begin
      if Math.SameValue(Item.FExponents[1], ADim[1]) and
         Math.SameValue(Item.FExponents[2], ADim[2]) and
         Math.SameValue(Item.FExponents[3], ADim[3]) and
         Math.SameValue(Item.FExponents[4], ADim[4]) and
         Math.SameValue(Item.FExponents[5], ADim[5]) and
         Math.SameValue(Item.FExponents[6], ADim[6]) and
         Math.SameValue(Item.FExponents[7], ADim[7]) and
         Math.SameValue(Item.FExponents[8], ADim[8]) then Exit(i);
    end;
  end;
  result := -1;
end;

function TToolKitList.SameValue(const ADim1, ADim2: TExponents): boolean;
begin
  result := Math.SameValue(ADim1[1], ADim2[1]) and
            Math.SameValue(ADim1[2], ADim2[2]) and
            Math.SameValue(ADim1[3], ADim2[3]) and
            Math.SameValue(ADim1[4], ADim2[4]) and
            Math.SameValue(ADim1[5], ADim2[5]) and
            Math.SameValue(ADim1[6], ADim2[6]) and
            Math.SameValue(ADim1[7], ADim2[7]) and
            Math.SameValue(ADim1[8], ADim2[8]);
end;

procedure TToolKitList.SaveToFile(const AFileName: string);
var
  i: longint;
  CSVDoc:TCSVDocument;
  Item: TToolKitItem;
begin
  CSVDoc := TCSVDocument.Create;
  CSVDoc.Delimiter := ';';

  for i := 0 to FList.Count -1 do
  begin
    Item := TToolKitItem(FList[i]);

    CSVDoc.AddRow();
    CSVDoc.AddCell(i, Item.FField);
    CSVDoc.AddCell(i, Item.FQuantity);
    CSVDoc.AddCell(i, Item.FDimension);
    CSVDoc.AddCell(i, Item.FLongString);
    CSVDoc.AddCell(i, Item.FShortString);
    CSVDoc.AddCell(i, Item.FIdentifier);
    CSVDoc.AddCell(i, Item.FBase);
    CSVDoc.AddCell(i, Item.FFactor);
    CSVDoc.AddCell(i, Item.FPrefixes);
    CSVDoc.AddCell(i, Item.FType);
    CSVDoc.AddCell(i, Item.FColor);
  end;
  CSVDoc.SaveToFile(AFileName);
  CSVDoc.Destroy;
end;

procedure TToolKitList.LoadFromFile(const AFileName: string);
var
  i: longint;
  CSVDoc:TCSVDocument;
  Item: TToolKitItem;
begin
  CSVDoc := TCSVDocument.Create;
  CSVDoc.Delimiter := ';';
  CSVDoc.LoadFromFile(AFileName);
  for i := 0 to CSVDoc.RowCount -1 do
  begin
    Item              := TToolKitItem.Create;
    Item.FField       := CSVDoc.Cells[ 0, i];
    Item.FQuantity    := CSVDoc.Cells[ 1, i];
    Item.FDimension   := CSVDoc.Cells[ 2, i];
    Item.FLongString  := CSVDoc.Cells[ 3, i];
    Item.FShortString := CSVDoc.Cells[ 4, i];
    Item.FIdentifier  := CSVDoc.Cells[ 5, i];
    Item.FBase        := CSVDoc.Cells[ 6, i];
    Item.FFactor      := CSVDoc.Cells[ 7, i];
    Item.FPrefixes    := CSVDoc.Cells[ 8, i];
    Item.FType        := CSVDoc.Cells[ 9, i];
    Item.FColor       := CSVDoc.Cells[10, i];

    if Item.FColor = '' then
    begin
      Item.FColor := ColorToString(clWhite);
    end;
    Add(Item);
  end;
  CSVDoc.Destroy;
end;

function TToolKitList.GetItem(Index: longint): TToolKitItem;
begin
  result := TToolKitItem(FList[Index]);
end;

function TToolKitList.GetCount: longint;
begin
  result := FList.Count;
end;

end.

