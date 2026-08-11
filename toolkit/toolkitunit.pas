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
  Classes, Common, Contnrs, SysUtils;

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
    FList: TObjectList;
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

    function IndexOfQuantity(const AValue: string): longint;
    function IndexOfDimension(const ADim: TExponents): longint;
    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
  public
    property Items[Index: longint]: TToolKitItem read GetItem; default;
    property Count: longint read GetCount;
  end;

  TToolKitBuilder = class
  private
    FList: TToolKitList;
    FBaseUnits: TStringList;
    FFactoredUnits: TStringList;
    FDocument: TStringList;
    FResources: TStringList;

    FTemplateFileName: string;
    FResourceTemplateFileName: string;

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

    procedure ExpandUnits;
  public
    constructor Create(const AList: TToolKitList;
      const ATemplateFileName: string = 'skeleton.pas';
      const AResourceTemplateFileName: string = 'skeletonres.pas');
    destructor Destroy; override;

    procedure Build;

    property Document: TStringList read FDocument;
    property BaseUnits: TStringList read FBaseUnits;
    property FactoredUnits: TStringList read FFactoredUnits;
    property Resources: TStringList read FResources;

  end;


implementation

uses
  CSVDocument, Math;

function EscapePascalString(const AValue: string): string;
begin
  result := StringReplace(AValue, '''', '''''', [rfReplaceAll]);
end;

function IsValidPrefixMask(const AValue: string): boolean;
var
  I: integer;
begin
  if AValue = '' then Exit(True);
  if Length(AValue) <> 24 then Exit(False);
  for I := 1 to Length(AValue) do
    if not (AValue[I] in ['L', 'S', '-']) then Exit(False);
  result := True;
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

constructor TToolKitBuilder.Create(const AList: TToolKitList;
  const ATemplateFileName: string; const AResourceTemplateFileName: string);
var
  i: longint;
  LItem: TToolKitItem;
begin
  inherited Create;
  FList := TToolKitList.Create;
  for i := 0 to AList.Count -1 do
  begin
    LItem := AList[i].NewItem;
    try
      FList.Add(LItem);
      LItem := nil;
    finally
      LItem.Free;
    end;
  end;

  FBaseUnits     := TStringList.Create;
  FFactoredUnits := TStringList.Create;
  FDocument      := TStringList.Create;
  FResources     := TStringList.Create;
  FTemplateFileName := ExpandFileName(ATemplateFileName);
  FResourceTemplateFileName := ExpandFileName(AResourceTemplateFileName);
end;

destructor TToolKitBuilder.Destroy;
begin
  FBaseUnits.Free;
  FFactoredUnits.Free;
  FResources.Free;
  FDocument.Free;
  FList.Free;
  inherited Destroy;
end;

procedure TToolKitBuilder.AddUnits(const ASection: TStringList);
var
  i: longint;
  LState: array of byte;

  procedure ResolveDimensions(AIndex: longint);
  var
    LBaseIndex: longint;
  begin
    case LState[AIndex] of
      1: raise Exception.CreateFmt('Cyclic base-unit dependency involving %s.',
           [FList[AIndex].FQuantity]);
      2: Exit;
    end;

    LState[AIndex] := 1;
    if FList[AIndex].FBase = '' then
      FList[AIndex].FExponents := StringToDimensions(FList[AIndex].FDimension)
    else
    begin
      LBaseIndex := FList.IndexOfQuantity(FList[AIndex].FBase);
      if LBaseIndex = -1 then
        raise Exception.CreateFmt('Base unit %s referenced by %s was not found.',
          [FList[AIndex].FBase, FList[AIndex].FQuantity]);
      ResolveDimensions(LBaseIndex);
      FList[AIndex].FExponents := FList[LBaseIndex].FExponents;
    end;
    LState[AIndex] := 2;
  end;
begin
  LState := nil;
  SetLength(LState, FList.Count);
  for i := 0 to FList.Count -1 do
    ResolveDimensions(i);

  ExpandUnits;
  for i := 0 to FList.Count -1 do
  begin
    if (FList[i].FBase = '') then
    begin
      AddUnit(FList[i], ASection);
      AddSymbols(FList[i], ASection);
    end else
    begin
      if FList[i].FFactor = '' then
      begin
        AddClonedUnit(FList[i], ASection);
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
    AddResource(FList[i], ASection);
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

  { ScalarUnit is part of skeleton.pas because the template must compile on its
    own. Keep it in the generated unit summary, but do not declare it twice. }
  if CompareText(GetUnitID(AItem.FQuantity), 'Scalar') = 0 then Exit;

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
  ASection.Add('  %s = ''%s'';', [GetSymbolResourceString(AItem.FQuantity),
    EscapePascalString(GetSymbol(AItem.FShortString))]);
  ASection.Add('  %s = ''%s'';', [GetSingularNameResourceString(AItem.FQuantity),
    EscapePascalString(GetSingularName(AItem.FLongString))]);
  ASection.Add('  %s = ''%s'';', [GetPluralNameResourceString(AItem.FQuantity),
    EscapePascalString(GetPluralName(AItem.FLongString))]);
end;

procedure TToolKitBuilder.AddSymbols(const AItem: TToolKitItem; const ASection: TStringList);
var
  Identifier: string;
begin
  if (AItem.FBase = '') then
  begin
    // Base unit symbols
    ASection.Add('var');

    Identifier := GetUnitID(AItem.FQuantity);
    if CompareText(Identifier, AItem.FIdentifier) <> 0 then
    begin
      ASection.Add('  { %s }', [AItem.FComment]);
      ASection.Add('  %s : TUnit absolute %sUnit;', [Identifier, GetUnitID(AItem.FQuantity)]);
      ASection.Add('');
    end;

    if AItem.FIdentifier <> '' then
    begin
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
      ASection.Add('var');

      Identifier := GetUnitID(AItem.FQuantity);
      if CompareText(Identifier, AItem.FIdentifier) <> 0 then
      begin
        ASection.Add('  { %s }', [AItem.FComment]);
        ASection.Add('  %s : TUnit absolute %sUnit;', [Identifier, GetUnitID(AItem.FQuantity)]);
        ASection.Add('');
      end;

      if AItem.FIdentifier <> '' then
      begin
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
        begin
          ASection.Add('  %s : TDegreeCelsiusUnit absolute %sUnit;', [AItem.FIdentifier, GetUnitID(AItem.FQuantity)])
        end else
          if LowerCase(AItem.FFactor) = 'fahrenheit' then
          begin
            ASection.Add('  %s : TDegreeFahrenheitUnit absolute %sUnit;', [AItem.FIdentifier, GetUnitID(AItem.FQuantity)])
          end else
          begin

            Identifier := GetUnitID(AItem.FQuantity);
            if CompareText(Identifier, AItem.FIdentifier) <> 0 then
             begin
               ASection.Add('  { %s }', [AItem.FComment]);
               ASection.Add('  %s : TFactoredUnit absolute %sUnit;', [Identifier, GetUnitID(AItem.FQuantity)]);
               ASection.Add('');
             end;

            if AItem.FIdentifier <> '' then
            begin
              ASection.Add('  { %s }', [AItem.FComment]);
              ASection.Add('  %s : TFactoredUnit absolute %sUnit;', [AItem.FIdentifier, GetUnitID(AItem.FQuantity)]);
              ASection.Add('');
            end;
          end;
        ASection.Add('');
      end;
      if AItem.FIdentifier <> '' then
        AddFactoredSymbols(AItem, ASection);
    end;
  end;
end;

type
  TGeneratorPrefix = record
    LongName: string[6];
    ShortName: string[2];
    Exponent: shortint;
  end;

const
  GeneratorPrefixes: array[1..24] of TGeneratorPrefix = (
    (LongName: 'quetta'; ShortName: 'Q';  Exponent:  30),
    (LongName: 'ronna';  ShortName: 'R';  Exponent:  27),
    (LongName: 'yotta';  ShortName: 'Y';  Exponent:  24),
    (LongName: 'zetta';  ShortName: 'Z';  Exponent:  21),
    (LongName: 'exa';    ShortName: 'E';  Exponent:  18),
    (LongName: 'peta';   ShortName: 'P';  Exponent:  15),
    (LongName: 'tera';   ShortName: 'T';  Exponent:  12),
    (LongName: 'giga';   ShortName: 'G';  Exponent:   9),
    (LongName: 'mega';   ShortName: 'M';  Exponent:   6),
    (LongName: 'kilo';   ShortName: 'k';  Exponent:   3),
    (LongName: 'hecto';  ShortName: 'h';  Exponent:   2),
    (LongName: 'deca';   ShortName: 'da'; Exponent:   1),
    (LongName: 'deci';   ShortName: 'd';  Exponent:  -1),
    (LongName: 'centi';  ShortName: 'c';  Exponent:  -2),
    (LongName: 'milli';  ShortName: 'm';  Exponent:  -3),
    (LongName: 'micro';  ShortName: 'mi'; Exponent:  -6),
    (LongName: 'nano';   ShortName: 'n';  Exponent:  -9),
    (LongName: 'pico';   ShortName: 'p';  Exponent: -12),
    (LongName: 'femto';  ShortName: 'f';  Exponent: -15),
    (LongName: 'atto';   ShortName: 'a';  Exponent: -18),
    (LongName: 'zepto';  ShortName: 'z';  Exponent: -21),
    (LongName: 'yocto';  ShortName: 'y';  Exponent: -24),
    (LongName: 'ronto';  ShortName: 'r';  Exponent: -27),
    (LongName: 'quecto'; ShortName: 'q';  Exponent: -30)
  );

procedure TToolKitBuilder.AddFactoredSymbols(const AItem: TToolKitItem; const SectionA: TStringList);
const
  S = '  %s : TRealQuantity = {$IFNDEF ADIMOFF} (FDim: %s; FValue: %s); {$ELSE} (%s); {$ENDIF}';
var
  I: integer;
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
    if (LowerCase(AItem.FIdentifier) = 'kg'  ) then CurrName := 'kilogram**';
    if (LowerCase(AItem.FIdentifier) = 'kg2' ) then CurrName := 'square kilogram**';

    BaseSymbol := AItem.FShortString;
    BaseSymbol := StringReplace(BaseSymbol, '%s', '',  [rfReplaceAll]);
    BaseSymbol := StringReplace(BaseSymbol, '!',  '',  [rfReplaceAll]);
    BaseSymbol := StringReplace(BaseSymbol, '?',  '',  [rfReplaceAll]);
    BaseSymbol := GetSymbol(BaseSymbol);
    if (LowerCase(AItem.FIdentifier) = 'kg'  ) then BaseSymbol := 'kg**';
    if (LowerCase(AItem.FIdentifier) = 'kg2' ) then BaseSymbol := 'kg2**';

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

  if AItem.FPrefixes = '' then
    Params := '------------------------'
  else
  begin
    if Length(AItem.FPrefixes) <> Length(GeneratorPrefixes) then
      raise Exception.CreateFmt(
        'Invalid prefix mask for %s: expected %d characters, got %d.',
        [AItem.FQuantity, Length(GeneratorPrefixes), Length(AItem.FPrefixes)]);
    Params := AItem.FPrefixes;
    for I := 1 to Length(Params) do
      if not (Params[I] in ['L', 'S', '-']) then
        raise Exception.CreateFmt(
          'Invalid prefix marker "%s" for %s at position %d.',
          [Params[I], AItem.FQuantity, I]);
  end;

  Power  := 1;
  if (AItem.FIdentifier <> '') and
     (AItem.FIdentifier[Length(AItem.FIdentifier)] in ['2'..'9']) then
    Power := Ord(AItem.FIdentifier[Length(AItem.FIdentifier)]) - Ord('0');

  FIndex := GetUnitID(AItem.FExponents);

  if (Pos('L', Params) > 0) or
     (Pos('S', Params) > 0) then SectionA.Add('const');

  if (LowerCase(AItem.FIdentifier) <> 'kg' ) and
     (LowerCase(AItem.FIdentifier) <> 'kg2') then
  begin
    for I := Low(GeneratorPrefixes) to High(GeneratorPrefixes) do
      case Params[I] of
        'L': Append(GeneratorPrefixes[I].LongName,
          GeneratorPrefixes[I].LongName, FIndex, Factor,
          FormatFloat('0e+00', IntPower(10,
            GeneratorPrefixes[I].Exponent * Power)));
        'S': Append(GeneratorPrefixes[I].LongName,
          GeneratorPrefixes[I].ShortName, FIndex, Factor,
          FormatFloat('0e+00', IntPower(10,
            GeneratorPrefixes[I].Exponent * Power)));
      end;
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
      if FList.IndexOfDimension(NewDim) = -1 then
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
         if FList.IndexOfDimension(NewDim) = -1 then
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
      if FList.IndexOfDimension(NewDim) = -1 then
        FList.Add(NewDim);
    end;
    Inc(i);
  end;
end;

procedure TToolKitBuilder.Build;
var
  i, LUnitDeclarationCount: longint;
  Section0: TStringList;
  Section1: TStringList;
  Section2: TStringList;
begin
  FBaseUnits.Clear;
  FFactoredUnits.Clear;
  FDocument.Clear;
  FResources.Clear;

  Section0 := nil;
  Section1 := nil;
  Section2 := nil;
  try
    Section0 := TStringList.Create;
    AddUnits(Section0);

    Section1 := TStringList.Create;
    Section1.Append('{');
    Section1.Append('  ADim Run-time library generated by ADimPas Toolkit.');
    Section1.Append('');
    Section1.Append(Format('  Number of base units: %d', [FBaseUnits.Count]));
    Section1.Append(Format('  Number of factored units: %d', [FFactoredUnits.Count]));
    Section1.Append('}');
    Section1.Append('');

    FDocument.LoadFromFile(FTemplateFileName);
    LUnitDeclarationCount := 0;
    for i := 0 to FDocument.Count -1 do
    begin
      if CompareText(Trim(FDocument[i]), 'unit skeleton;') = 0 then
      begin
        FDocument[i] := 'unit ADim;';
        Inc(LUnitDeclarationCount);
      end;
    end;
    if LUnitDeclarationCount <> 1 then
      raise Exception.CreateFmt(
        'Template %s must contain exactly one "unit skeleton;" declaration.',
        [FTemplateFileName]);
    RemoveIncludeDirective(Section1, FDocument, '{#HEADER}');
    RemoveIncludeDirective(Section0, FDocument, '{#UNITSOFMEASUREMENT}');
    CleanDocument(FDocument);

    Section2 := TStringList.Create;
    AddResources(Section2);

    FResources.LoadFromFile(FResourceTemplateFileName);
    LUnitDeclarationCount := 0;
    for i := 0 to FResources.Count -1 do
    begin
      if CompareText(Trim(FResources[i]), 'unit skeletonres;') = 0 then
      begin
        FResources[i] := 'unit ADimRes;';
        Inc(LUnitDeclarationCount);
      end;
    end;
    if LUnitDeclarationCount <> 1 then
      raise Exception.CreateFmt(
        'Template %s must contain exactly one "unit skeletonres;" declaration.',
        [FResourceTemplateFileName]);
    RemoveIncludeDirective(Section2, FResources, '{#RESOURCESTRINGS}');
    CleanDocument(FResources);
  finally
    Section2.Free;
    Section1.Free;
    Section0.Free;
  end;
end;

// TToolKitList

constructor TToolKitList.Create;
begin
  inherited Create;
  FList := TObjectList.Create(True);
end;

destructor TToolKitList.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

procedure TToolKitList.Add(const AItem: TToolKitItem);
begin
  if AItem = nil then
    raise EArgumentNilException.Create('AItem');
  if Trim(AItem.FQuantity) = '' then
    raise Exception.Create('The quantity name cannot be empty.');
  if IndexOfQuantity(AItem.FQuantity) <> -1 then
    raise Exception.CreateFmt('Duplicate quantity: %s.', [AItem.FQuantity]);
  FList.Add(AItem);
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
  NewItem.FComment     := GetComment(ADim);
  NewItem.FColor       := '';
  FList.Add(NewItem);
end;

procedure TToolKitList.Delete(Index: longint);
begin
  FList.Delete(Index);
end;

procedure TToolKitList.Clear;
begin
  FList.Clear;
end;

procedure TToolKitList.MoveUp(Index: longint);
begin
  if Index > 0 then
    FList.Exchange(Index, Index -1);
end;

procedure TToolKitList.MoveDown(Index: longint);
begin
  if Index < FList.Count -1 then
    FList.Exchange(Index, Index +1);
end;

function TToolKitList.IndexOfQuantity(const AValue: string): longint;
var
  i: longint;
  Item: TToolKitItem;
begin
  for i := 0 to FList.Count -1 do
  begin
    Item := TToolKitItem(FList[i]);
    if CompareText(Item.FQuantity, AValue) = 0 then Exit(i);
  end;
  result := -1;
end;

function TToolKitList.IndexOfDimension(const ADim: TExponents): longint;
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

procedure TToolKitList.SaveToFile(const AFileName: string);
var
  i: longint;
  CSVDoc:TCSVDocument;
  Item: TToolKitItem;
begin
  CSVDoc := TCSVDocument.Create;
  try
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
  finally
    CSVDoc.Free;
  end;
end;

procedure TToolKitList.LoadFromFile(const AFileName: string);
var
  i: longint;
  CSVDoc: TCSVDocument;
  Item: TToolKitItem;
  LLoadedList: TToolKitList;
  LOldList: TObjectList;
begin
  CSVDoc := TCSVDocument.Create;
  LLoadedList := TToolKitList.Create;
  try
    CSVDoc.Delimiter := ';';
    CSVDoc.LoadFromFile(AFileName);
    for i := 0 to CSVDoc.RowCount -1 do
    begin
      if CSVDoc.ColCount[i] < 11 then
        raise Exception.CreateFmt(
          'Invalid CSV row %d: expected 11 columns, got %d.',
          [i + 1, CSVDoc.ColCount[i]]);

      Item := TToolKitItem.Create;
      try
        try
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
            Item.FColor := 'clWhite';
          if not IsValidPrefixMask(Item.FPrefixes) then
            raise Exception.CreateFmt('Invalid prefix mask for %s.',
              [Item.FQuantity]);

          LLoadedList.Add(Item);
          Item := nil;
        except
          on E: Exception do
            raise Exception.CreateFmt('Invalid CSV row %d: %s',
              [i + 1, E.Message]);
        end;
      finally
        Item.Free;
      end;
    end;

    LOldList := FList;
    FList := LLoadedList.FList;
    LLoadedList.FList := LOldList;
  finally
    LLoadedList.Free;
    CSVDoc.Free;
  end;
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

