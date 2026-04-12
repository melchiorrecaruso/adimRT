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
  public
    FField: string;
    FQuantity: string;
    FDimension: string;
    FLongString:  string;
    FShortString: string;
    FIdentifier: string;
    FBase: string;
    FFactor: string;
    FPrefixes: string;
    FComment: string;
    FColor: string;
    FExponents: TExponents;
  public
    function NewItem: TToolKitItem;
  end;

  TToolKitList = class
  private
    FList: TList;
    function GetItem(Index: longint): TToolKitItem;
    function GetCount: longint;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Add(const AItem: TToolKitItem);
    procedure Add(const ADim: TExponents);
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
    FList: TToolKitList;
    FBaseUnits: TStringList;
    FFactoredUnits: TStringList;
    FDocument: TStringList;
    FResources: TStringList;

    FMessage: string;
    FOnMessage: TThreadMethod;
    FOnStart: TThreadMethod;
    FOnStop: TThreadMethod;

    function  SearchLine(const ALine: string; ASection: TStringList): longint;
  public
    constructor Create(const AList: TToolKitList);
    destructor Destroy; override;

    procedure AddUnits(const ASection: TStringList);
    procedure AddUnit(const AItem: TToolKitItem; const ASection: TStringList);
    procedure AddClonedUnit(const AItem: TToolKitItem; const ASection: TStringList);
    procedure AddFactoredUnit(const AItem: TToolKitItem; const ASection: TStringList);
    procedure AddDegreeCelsiusUnit(const AItem: TToolKitItem; const ASection: TStringList);
    procedure AddDegreeFahrenheitUnit(const AItem: TToolKitItem; const ASection: TStringList);

    procedure AddResources(const ASection: TStringList);
    procedure AddResource(const AItem: TToolKitItem; const ASection: TStringList);

    procedure AddSymbols(const AItem: TToolKitItem; const ASection: TStringList);
    procedure AddFactoredSymbols(const AItem: TToolKitItem; const SectionA: TStringList);

    procedure Add(const AItem: TToolkitItem);
    procedure ExpandUnits;
    procedure Execute; override;
  public
    property Document: TStringList read FDocument;
    property BaseUnits: TStringList read FBaseUnits;
    property FactoredUnits: TStringList read FFactoredUnits;
    property Resources: TStringList read FResources;

    property Message: string read FMessage;
    property OnMessage: TThreadMethod read FOnMessage write FOnMessage;
    property OnStart: TThreadMethod read FOnStart write FOnStart;
    property OnStop: TThreadMethod read FOnStop write FOnStop;
  end;

  TIntegerList = specialize TFPGList<Integer>;


implementation

uses
  CSVDocument, DateUtils,  LCLType, Math;

function CompareInteger(const Item1, Item2: longint): integer;
begin
  result := Item2 - Item1;
end;

// TToolKitItem

function TToolKitItem.NewItem: TToolKitItem;
begin
  result := TToolKitItem.Create;
  result.FField       := FField;
  result.FQuantity    := FQuantity;
  result.FDimension   := FDimension;
  result.FLongString  := FLongString;
  result.FShortString := FShortString;
  result.FIdentifier  := FIdentifier;
  result.FBase        := FBase;
  result.FFactor      := FFactor;
  result.FPrefixes    := FPrefixes;
  result.FComment     := FComment;
  result.FColor       := FColor;
  result.FExponents   := FExponents;
end;

// TToolKitBuilder

constructor TToolKitBuilder.Create(const AList: TToolKitList);
var
  i: longint;
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FList := TToolKitList.Create;
  for i := 0 to AList.Count -1 do
    FList.Add(AList[i].NewItem);

  FBaseUnits     := TStringList.Create;
  FFactoredUnits := TStringList.Create;
  FDocument      := TStringList.Create;
  FResources     := TStringList.Create;
end;

destructor TToolKitBuilder.Destroy;
begin
  FBaseUnits.Destroy;
  FFactoredUnits.Destroy;
  FResources.Destroy;
  FDocument.Destroy;
  FList.Destroy;
  inherited Destroy;
end;

procedure TToolKitBuilder.AddUnits(const ASection: TStringList);
var
  i, j: longint;
begin
  for i := 0 to FList.Count -1 do
  begin;
    if FList[i].FBase = '' then
    begin
      FList[i].FExponents := StringToDimensions(FList[i].FDimension);
    end else
    begin
      j := FList.Search(FList[i].FBase, 1);
      if j <> -1 then
      begin
        FList[i].FExponents := FList[j].FExponents;
      end;
    end;
  end;

  ExpandUnits;
  for i := 0 to FList.Count -1 do
  begin
    if (FList[i].FBase = '') then
    begin
      AddUnit(FList[i], ASection);
      AddSymbols(FList[i], ASection);
    end else
    begin
      if (FList[i].FFactor = '') then
      begin
        AddClonedUnit(FList[i], ASection);
        AddSymbols(FList[i], ASection);
      end else
        if Pos('%s', FList[i].FFactor) = 0 then
        begin
          AddFactoredUnit(FList[i], ASection);
          AddSymbols(FList[i], ASection);
        end else
        begin
          AddFactoredUnit(FList[i], ASection);
          AddSymbols(FList[i], ASection);
        end;
    end;
  end;
end;

procedure TToolKitBuilder.AddResources(const ASection: TStringList);
var
  i: longint;
begin
  for i := 0 to FList.Count -1 do
  begin
    if (FList[i].FBase = '') then
    begin
      AddResource(FList[i], ASection);
    end else
    begin
      if (FList[i].FFactor = '') then
      begin
        AddResource(FList[i], ASection);
      end else
        if Pos('%s', FList[i].FFactor) = 0 then
        begin
          AddResource(FList[i], ASection);
        end else
        begin
          AddResource(FList[i], ASection);
        end;
    end;
  end;
end;

function GetDescription(const S: string): string;
begin
  result := S;
  result := StringReplace(result, '%sgram', 'kilogram', [rfReplaceAll]);
  result := StringReplace(result, '%s', '', [rfReplaceAll]);
end;

procedure TToolKitBuilder.AddUnit(const AItem: TToolKitItem; const ASection: TStringList);
begin
  FBaseUnits.Add(Format(' - %s [%sUnit]', [GetDescription(GetPluralName(AItem.FLongString)), GetUnitID(AItem.FQuantity)]));

  ASection.Add('{ T%s } { @exclude }', [GetUnitID(AItem.FQuantity)]);

  ASection.Add('');
  ASection.Add('const');
  ASection.Add('  %sUnit : TUnit = (', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('    FDim        : %s;', [GetUnitID(AItem.FExponents)]);
  ASection.Add('    FSymbol     : %s;', [GetSymbolResourceString(AItem.FQuantity)]);
  ASection.Add('    FName       : %s;', [GetSingularNameResourceString(AItem.FQuantity)]);
  ASection.Add('    FPluralName : %s;', [GetPluralNameResourceString(AItem.FQuantity)]);
  ASection.Add('    FPrefixes   : (%s);', [GetPrefixes(AItem.FShortString)]);
  ASection.Add('    FExponents  : (%s));', [GetExponents(AItem.FShortString)]);
  ASection.Add('');
end;

procedure TToolKitBuilder.AddClonedUnit(const AItem: TToolKitItem; const ASection: TStringList);
begin
  FFactoredUnits.Add(Format(' - %s [%sUnit]', [GetDescription(GetPluralName(AItem.FLongString)), GetUnitID(AItem.FQuantity)]));

  ASection.Add('{ T%s } { @exclude }', [GetUnitID(AItem.FQuantity)]);

  ASection.Add('');
  ASection.Add('const');
  ASection.Add('  %sUnit : TUnit = (', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('    FDim        : %s;', [GetUnitID(AItem.FExponents)]);
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
      FFactoredUnits.Add(Format(' - %s [%sUnit]', [GetDescription(GetPluralName(AItem.FLongString)), GetUnitID(AItem.FQuantity)]));

      ASection.Add('{ T%s } { @exclude }', [GetUnitID(AItem.FQuantity)]);

      ASection.Add('');
      ASection.Add('const');
      ASection.Add('  %sUnit : TFactoredUnit = (', [GetUnitID(AItem.FQuantity)]);
      ASection.Add('    FDim        : %s;', [GetUnitID(AItem.FExponents)]);
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
  FFactoredUnits.Add(Format(' - %s [%sUnit]', [GetDescription(GetPluralName(AItem.FLongString)), GetUnitID(AItem.FQuantity)]));

  ASection.Add('{ T%s } { @exclude }', [GetUnitID(AItem.FQuantity)]);

  ASection.Add('');
  ASection.Add('const');
  ASection.Add('  %sUnit : TDegreeCelsiusUnit = (', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('    FDim        : %s;', [GetUnitID(AItem.FExponents)]);
  ASection.Add('    FSymbol     : %s;', [GetSymbolResourceString(AItem.FQuantity)]);
  ASection.Add('    FName       : %s;', [GetSingularNameResourceString(AItem.FQuantity)]);
  ASection.Add('    FPluralName : %s;', [GetPluralNameResourceString(AItem.FQuantity)]);
  ASection.Add('    FPrefixes   : (%s);', [GetPrefixes(AItem.FShortString)]);
  ASection.Add('    FExponents  : (%s));', [GetExponents(AItem.FShortString)]);
  ASection.Add('');
end;

procedure TToolKitBuilder.AddDegreeFahrenheitUnit(const AItem: TToolKitItem; const ASection: TStringList);
begin
  FFactoredUnits.Add(Format(' - %s [%sUnit]', [GetDescription(GetPluralName(AItem.FLongString)), GetUnitID(AItem.FQuantity)]));

  ASection.Add('{ T%s } { @exclude }', [GetUnitID(AItem.FQuantity)]);

  ASection.Add('');
  ASection.Add('const');
  ASection.Add('  %sUnit : TDegreeFahrenheitUnit = (', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('    FDim               : %s;', [GetUnitID(AItem.FExponents)]);
  ASection.Add('    FSymbol            : %s;', [GetSymbolResourceString(AItem.FQuantity)]);
  ASection.Add('    FName              : %s;', [GetSingularNameResourceString(AItem.FQuantity)]);
  ASection.Add('    FPluralName        : %s;', [GetPluralNameResourceString(AItem.FQuantity)]);
  ASection.Add('    FPrefixes          : (%s);', [GetPrefixes(AItem.FShortString)]);
  ASection.Add('    FExponents         : (%s));', [GetExponents(AItem.FShortString)]);
  ASection.Add('');
end;

procedure TToolKitBuilder.AddResource(const AItem: TToolKitItem; const ASection: TStringList);
begin
  ASection.Add('  %s = ''%s'';', [GetSymbolResourceString(AItem.FQuantity), GetSymbol(AItem.FShortString)]);
  ASection.Add('  %s = ''%s'';', [GetSingularNameResourceString(AItem.FQuantity), GetSingularName(AItem.FLongString)]);
  ASection.Add('  %s = ''%s'';', [GetPluralNameResourceString(AItem.FQuantity), GetPluralName(AItem.FLongString)]);
end;

procedure TToolKitBuilder.AddSymbols(const AItem: TToolKitItem; const ASection: TStringList);
begin
  if (AItem.FBase = '') then
  begin
    // Base unit symbols
    if AItem.FIdentifier <> '' then
    begin
      ASection.Add('var');
      ASection.Add('  { %s }', [AItem.FComment]);
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
        ASection.Add('  { %s }', [AItem.FComment]);
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
        ASection.Add('  { %s }', [AItem.FComment]);
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

function GetIdentifier(const S: string): string;
begin
  result := S;
  if Pos(' :', result) > 0 then
    SetLength(result, Pos(' :', result));
  result := CleanSingleSpaces(result);
end;

procedure TToolKitBuilder.AddFactoredSymbols(const AItem: TToolKitItem; const SectionA: TStringList);
const
  S = '  %s : TQuantity = {$IFNDEF ADIMOFF} (FDim: %s; FValue: %s); {$ELSE} (%s); {$ENDIF}';
var
  Params: string;
  Power: longint;
  Factor: string;
  FIndex: string;

  procedure Append(const ALongPrefix, APrefix, AIndex, AFactor, APower: string);
  var
    CurrSymbol, Kind, CurrName, BaseSymbol, BaseName: string;
  begin
    CurrSymbol := APrefix + AItem.FIdentifier;
    if (LowerCase(AItem.FIdentifier) = 'kg' ) then CurrSymbol := APrefix;
    if (LowerCase(AItem.FIdentifier) = 'kg2') then CurrSymbol := APrefix;

    if Pos('+', APower) > 0 then
      Kind := 'multiple'
    else
      Kind := 'submultiple';

    CurrName := AItem.FLongString;
    CurrName := StringReplace(CurrName, '%s', ALongPrefix,  [rfReplaceAll]);
    CurrName := StringReplace(CurrName, '!',  '',           [rfReplaceAll]);
    CurrName := StringReplace(CurrName, '?',  '',           [rfReplaceAll]);
    CurrName := GetSymbol(CurrName);
    if (LowerCase(AItem.FIdentifier) = 'kg'  ) then CurrName := 'kilogram';
    if (LowerCase(AItem.FIdentifier) = 'kg2' ) then CurrName := 'square kilogram';

    BaseSymbol := AItem.FShortString;
    BaseSymbol := StringReplace(BaseSymbol, '%s', '',  [rfReplaceAll]);
    BaseSymbol := StringReplace(BaseSymbol, '!',  '',  [rfReplaceAll]);
    BaseSymbol := StringReplace(BaseSymbol, '?',  '',  [rfReplaceAll]);
    BaseSymbol := GetSymbol(BaseSymbol);
    if (LowerCase(AItem.FIdentifier) = 'kg'  ) then BaseSymbol := 'kg';
    if (LowerCase(AItem.FIdentifier) = 'kg2' ) then BaseSymbol := 'kg2';

    BaseName := AItem.FLongString;
    BaseName := StringReplace(BaseName, '%s', '',  [rfReplaceAll]);
    BaseName := StringReplace(BaseName, '!',  '',  [rfReplaceAll]);
    BaseName := StringReplace(BaseName, '?',  '',  [rfReplaceAll]);
    BaseName := GetSymbol(BaseName);
    if (LowerCase(AItem.FIdentifier) = 'kg'  ) then BaseName := 'kilogram';
    if (LowerCase(AItem.FIdentifier) = 'kg2' ) then BaseName := 'square kilogram';

    SectionA.Add('  { %s - %s: %s of %s; 1 %s = %s %s. }', [GetSymbol(CurrSymbol), CurrName, Kind, BaseName, GetSymbol(CurrSymbol), APower, GetSymbol(BaseSymbol)]);
    SectionA.Add(S, [CurrSymbol, AIndex, AFactor + APower, AFactor + APower]);
    SectionA.Add('');
  end;

begin
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

  FIndex := GetUnitID(AItem.FExponents);

  if (Pos('L', Params) > 0) or
     (Pos('S', Params) > 0) then SectionA.Add('const');

  if (LowerCase(AItem.FIdentifier) <> 'kg' ) and
     (LowerCase(AItem.FIdentifier) <> 'kg2') then
  begin
    if Params[ 1] = 'L' then Append('quetta', 'quetta', FIndex, Factor, FormatFloat('0e+00', IntPower(10, +30*Power)));
    if Params[ 1] = 'S' then Append('quetta', 'Q'     , FIndex, Factor, FormatFloat('0e+00', IntPower(10, +30*Power)));
    if Params[ 2] = 'L' then Append('ronna',  'ronna',  FIndex, Factor, FormatFloat('0e+00', IntPower(10, +27*Power)));
    if Params[ 2] = 'S' then Append('ronna',  'R',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, +27*Power)));
    if Params[ 3] = 'L' then Append('yotta',  'yotta',  FIndex, Factor, FormatFloat('0e+00', IntPower(10, +24*Power)));
    if Params[ 3] = 'S' then Append('yotta',  'Y',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, +24*Power)));
    if Params[ 4] = 'L' then Append('zetta',  'zetta',  FIndex, Factor, FormatFloat('0e+00', IntPower(10, +21*Power)));
    if Params[ 4] = 'S' then Append('zetta',  'Z',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, +21*Power)));
    if Params[ 5] = 'L' then Append('exa',    'exa',    FIndex, Factor, FormatFloat('0e+00', IntPower(10, +18*Power)));
    if Params[ 5] = 'S' then Append('exa',    'exa',    FIndex, Factor, FormatFloat('0e+00', IntPower(10, +18*Power)));
    if Params[ 6] = 'L' then Append('peta',   'peta',   FIndex, Factor, FormatFloat('0e+00', IntPower(10, +15*Power)));
    if Params[ 6] = 'S' then Append('peta',   'P',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, +15*Power)));

    if Params[ 7] = 'L' then Append('tera',   'tera',   FIndex, Factor, FormatFloat('0e+00', IntPower(10, +12*Power)));
    if Params[ 7] = 'S' then Append('tera',   'T',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, +12*Power)));
    if Params[ 8] = 'L' then Append('giga',   'giga',   FIndex, Factor, FormatFloat('0e+00', IntPower(10, + 9*Power)));
    if Params[ 8] = 'S' then Append('giga',   'G',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, + 9*Power)));
    if Params[ 9] = 'L' then Append('mega',   'mega',   FIndex, Factor, FormatFloat('0e+00', IntPower(10, + 6*Power)));
    if Params[ 9] = 'S' then Append('mega',   'M',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, + 6*Power)));
    if Params[10] = 'L' then Append('kilo',   'kilo',   FIndex, Factor, FormatFloat('0e+00', IntPower(10, + 3*Power)));
    if Params[10] = 'S' then Append('kilo',   'k',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, + 3*Power)));
    if Params[11] = 'L' then Append('hecto',  'hecto',  FIndex, Factor, FormatFloat('0e+00', IntPower(10, + 2*Power)));
    if Params[11] = 'S' then Append('hecto',  'h',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, + 2*Power)));
    if Params[12] = 'L' then Append('deca',   'deca',   FIndex, Factor, FormatFloat('0e+00', IntPower(10, + 1*Power)));
    if Params[12] = 'S' then Append('deca',   'da',     FIndex, Factor, FormatFloat('0e+00', IntPower(10, + 1*Power)));
    if Params[13] = 'L' then Append('deci',   'deci',   FIndex, Factor, FormatFloat('0e+00', IntPower(10, - 1*Power)));
    if Params[13] = 'S' then Append('deci',   'd',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, - 1*Power)));
    if Params[14] = 'L' then Append('centi',  'centi',  FIndex, Factor, FormatFloat('0e+00', IntPower(10, - 2*Power)));
    if Params[14] = 'S' then Append('centi',  'c',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, - 2*Power)));
    if Params[15] = 'L' then Append('milli',  'milli',  FIndex, Factor, FormatFloat('0e+00', IntPower(10, - 3*Power)));
    if Params[15] = 'S' then Append('milli',  'm',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, - 3*Power)));
    if Params[16] = 'L' then Append('micro',  'micro',  FIndex, Factor, FormatFloat('0e+00', IntPower(10, - 6*Power)));
    if Params[16] = 'S' then Append('micro',  'mi',     FIndex, Factor, FormatFloat('0e+00', IntPower(10, - 6*Power)));
    if Params[17] = 'L' then Append('nano',   'nano',   FIndex, Factor, FormatFloat('0e+00', IntPower(10, - 9*Power)));
    if Params[17] = 'S' then Append('nano',   'n',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, - 9*Power)));
    if Params[18] = 'L' then Append('pico',   'pico',   FIndex, Factor, FormatFloat('0e+00', IntPower(10, -12*Power)));
    if Params[18] = 'S' then Append('pico',   'p',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, -12*Power)));

    if Params[19] = 'L' then Append('femto',  'femto',  FIndex, Factor, FormatFloat('0e+00', IntPower(10, -15*Power)));
    if Params[19] = 'S' then Append('femto',  'f',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, -15*Power)));
    if Params[20] = 'L' then Append('atto',   'atto',   FIndex, Factor, FormatFloat('0e+00', IntPower(10, -18*Power)));
    if Params[20] = 'S' then Append('atto',   'a',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, -18*Power)));
    if Params[21] = 'L' then Append('zepto',  'zepto',  FIndex, Factor, FormatFloat('0e+00', IntPower(10, -21*Power)));
    if Params[21] = 'S' then Append('zepto',  'z',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, -21*Power)));
    if Params[22] = 'L' then Append('yocto',  'yocto',  FIndex, Factor, FormatFloat('0e+00', IntPower(10, -24*Power)));
    if Params[22] = 'S' then Append('yocto',  'y',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, -24*Power)));
    if Params[23] = 'L' then Append('ronto',  'ronto',  FIndex, Factor, FormatFloat('0e+00', IntPower(10, -27*Power)));
    if Params[23] = 'S' then Append('ronto',  'r',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, -27*Power)));
    if Params[24] = 'L' then Append('quecto', 'quecto', FIndex, Factor, FormatFloat('0e+00', IntPower(10, -30*Power)));
    if Params[24] = 'S' then Append('quecto', 'q',      FIndex, Factor, FormatFloat('0e+00', IntPower(10, -30*Power)));
  end else
    if (LowerCase(AItem.FIdentifier) = 'kg') then
    begin
      Append('hectogram',  'hg',  FIndex, '', FormatFloat('0e+00', 1E-01));
      Append('decagram',   'dag', FIndex, '', FormatFloat('0e+00', 1E-02));
      Append('gram',       'g',   FIndex, '', FormatFloat('0e+00', 1E-03));
      Append('decigram',   'dg',  FIndex, '', FormatFloat('0e+00', 1E-04));
      Append('centigram',  'cg',  FIndex, '', FormatFloat('0e+00', 1E-05));
      Append('milligram',  'mg',  FIndex, '', FormatFloat('0e+00', 1E-06));
      Append('microgram',  'mig', FIndex, '', FormatFloat('0e+00', 1E-09));
      Append('nanogram',   'ng',  FIndex, '', FormatFloat('0e+00', 1E-12));
      Append('picogram',   'pg',  FIndex, '', FormatFloat('0e+00', 1E-15));
    end else
      if (LowerCase(AItem.FIdentifier) = 'kg2') then
      begin
        Append('square hectogram',  'hg2'  , FIndex, '', FormatFloat('0e+00', 1E-02));
        Append('square decagram',   'dag2' , FIndex, '', FormatFloat('0e+00', 1E-04));
        Append('square gram',       'g2'   , FIndex, '', FormatFloat('0e+00', 1E-06));
        Append('square decigram',   'dg2'  , FIndex, '', FormatFloat('0e+00', 1E-08));
        Append('square centigram',  'cg2'  , FIndex, '', FormatFloat('0e+00', 1E-10));
        Append('square milligram',  'mg2'  , FIndex, '', FormatFloat('0e+00', 1E-12));
        Append('square microgram',  'mig2' , FIndex, '', FormatFloat('0e+00', 1E-18));
        Append('square nanogram',   'ng2'  , FIndex, '', FormatFloat('0e+00', 1E-24));
        Append('square picogram',   'pg2'  , FIndex, '', FormatFloat('0e+00', 1E-30));
      end;

  SectionA.Add('');
end;

procedure TToolKitBuilder.Add(const AItem: TToolkitItem);
begin
  FList.Add(AItem);
end;

procedure TToolKitBuilder.ExpandUnits;
var
 i, j: longint;
 NewDim: TExponents;
begin
  // Add powers
  for i := Low(NewDim) to High(NewDim) do
    for j := Low(TExponentValues) to High(TExponentValues) do
    begin
      NewDim := NullExponents;
      NewDim[i] := TExponentValues[j];
      if FList.Search(NewDim) = -1 then
        FList.Add(NewDim);
    end;

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
           FList.Add(NewDim);
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
        FList.Add(NewDim);
    end;
    Inc(i);
  end;
end;

procedure TToolKitBuilder.Execute;
var
  i: longint;
  Section0: TStringList;
  Section1: TStringList;
  Section2: TStringList;
begin
  if Assigned(FOnStart) then
    Synchronize(FOnStart);

  FBaseUnits.Clear;
  FFactoredUnits.Clear;
  FDocument.Clear;
  FResources.Clear;

  Section0 := TStringList.Create;
  AddUnits(Section0);

  Section1 := TStringList.Create;
  Section1.Append('{');
  Section1.Append(Format('  ADim Run-time library built on %s.', [FormatDateTime('DD/MM/YYYY', Now)]));
  Section1.Append('');

  Section1.Append(Format('  Number of base units: %d', [FBaseUnits.Count]));
  Section1.Append(Format('  Number of factored units: %d', [FFactoredUnits.Count]));
  Section1.Append('}');
  Section1.Append('');

  FDocument.LoadFromFile('skeleton.pas');
  for i := 0 to  FDocument.Count -1 do
  begin
    if CompareText(FDocument[i], 'unit skeleton;') = 0 then
    begin
      FDocument[i] := 'unit ADim;';
    end;
  end;
  RemoveIncludeDirective(Section1, FDocument, '{#HEADER}');
  RemoveIncludeDirective(Section0, FDocument, '{#UNITSOFMEASUREMENT}');
  CleanDocument(FDocument);

  Section2 := TStringList.Create;
  AddResources(Section2);

  FResources.LoadFromFile('skeletonres.pas');
  for i := 0 to  FResources.Count -1 do
  begin
    if CompareText(FResources[i], 'unit skeletonres;') = 0 then
    begin
      FResources[i] := 'unit ADimRes;';
    end;
  end;
  RemoveIncludeDirective(Section2, FResources, '{#RESOURCESTRINGS}');
  CleanDocument(FResources);

  Section0.Destroy;
  Section1.Destroy;
  Section2.Destroy;
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

procedure TToolKitList.Add(const AItem: TToolKitItem);
begin
  if Search(AItem.FQuantity, 1) = -1 then
    FList.Add(AItem)
  else
    AItem.Destroy;
end;

procedure TToolKitList.Add(const ADim: TExponents);
var
  NewItem: TToolKitItem;
begin
  NewItem := TToolKitItem.Create;
  NewItem.FField       := '';
  NewItem.FQuantity    := DimensionToQuantity(ADim);
  NewItem.FDimension   := DimensionToString(ADim);
  NewItem.FLongString  := DimensionToLongString(ADim);
  NewItem.FShortString := DimensionToShortString(ADim);
  NewItem.FIdentifier  := '';
  NewItem.FBase        := '';
  NewItem.FFactor      := '';
  NewItem.FPrefixes    := '';
  NewItem.FExponents   := ADim;
  NewItem.FComment     := '';
  NewItem.FColor       := '';
  FList.Add(NewItem);
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
      9: if CompareText(Item.FComment,     AValue) = 0 then Exit(i);
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
      if (Item.FExponents[0] = ADim[0]) and
         (Item.FExponents[1] = ADim[1]) and
         (Item.FExponents[2] = ADim[2]) and
         (Item.FExponents[3] = ADim[3]) and
         (Item.FExponents[4] = ADim[4]) and
         (Item.FExponents[5] = ADim[5]) and
         (Item.FExponents[6] = ADim[6]) and
         (Item.FExponents[7] = ADim[7]) then Exit(i);
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
      if (Item.FExponents[0] = ADim[0]) and
         (Item.FExponents[1] = ADim[1]) and
         (Item.FExponents[2] = ADim[2]) and
         (Item.FExponents[3] = ADim[3]) and
         (Item.FExponents[4] = ADim[4]) and
         (Item.FExponents[5] = ADim[5]) and
         (Item.FExponents[6] = ADim[6]) and
         (Item.FExponents[7] = ADim[7]) then Exit(i);
    end;
  end;
  result := -1;
end;

function TToolKitList.SameValue(const ADim1, ADim2: TExponents): boolean;
begin
  result := (ADim1[1] = ADim2[1]) and
            (ADim1[2] = ADim2[2]) and
            (ADim1[3] = ADim2[3]) and
            (ADim1[4] = ADim2[4]) and
            (ADim1[5] = ADim2[5]) and
            (ADim1[6] = ADim2[6]) and
            (ADim1[7] = ADim2[7]);
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
    CSVDoc.AddCell(i, Item.FComment);
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
    Item.FComment     := CSVDoc.Cells[ 9, i];
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

