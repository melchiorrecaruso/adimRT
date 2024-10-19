{
  Description: Common unit.

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

unit ToolKitUnit;

{$mode ObjFPC}{$H+}
{$modeswitch advancedrecords}

interface

uses
  Classes, Common, Dialogs, Graphics, StrUtils, SysUtils;

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
    FReserved: longint;
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

    procedure SaveToFile(const AFileName: string);
    procedure LoadFromFile(const AFileName: string);

  public
    property Items[Index: longint]: TToolKitItem read GetItem; default;
    property Count: longint read GetCount;
  end;

  TToolKitBuilder = class
  private
    FList: TToolKitList;
    FClassList: TStringList;
    FCommUnits: TStringList;
    FOperatorList: TStringList;

    BaseUnitCount:     longint;
    FactoredUnitCount: longint;
    ExternalOperators: longint;
    ForcedOperators:   longint;
    InternalOperators: longint;
    FTestingCount:     longint;
    FSkipVectorialUnits: boolean;
    FUseFuncInsteadOfOperators: boolean;
    FExpandQuantityOperators: boolean;

    FDocument:  TStringList;
    FMessages:  TStringList;
    SectionA0:  TStringList;
    SectionA1:  TStringList;
    SectionA2:  TStringList;
    SectionA21: TStringList;
    SectionA22: TStringList;
    SectionA3:  TStringList;
    SectionA4:  TStringList;
    SectionA5:  TStringList;
    SectionA6:  TStringList;
    SectionA7:  TStringList;
    SectionA8:  TStringList;
    SectionA9:  TStringList;
    SectionA10: TStringList;

    SectionB1:  TStringList;
    SectionB2:  TStringList;
    SectionB21: TStringList;
    SectionB22: TStringList;
    SectionB3:  TStringList;
    SectionB4:  TStringList;
    SectionB5:  TStringList;
    SectionB6:  TStringList;
    SectionB7:  TStringList;
    SectionB8:  TStringList;
    SectionB9:  TStringList;
    SectionB10: TStringList;

    //FOnMessage: TMessageEvent;
    //FMessage: string;

    // private routines

    function  SearchLine(const ALine: string; ASection: TStringList): longint;
  public
    constructor Create;
    destructor Destroy; override;

    procedure AddBaseUnits(const SectionA, SectionB: TStringList);

    procedure AddUnit(const AItem: TToolKitItem; const ASection: TStringList);
    procedure AddFactoredUnit(const AItem: TToolKitItem; const ASection: TStringList);


    procedure AddSymbols(const AItem: TToolKitItem; const ASection: TStringList);
    procedure AddFactoredSymbols(const AItem: TToolKitItem; const SectionA: TStringList);

    procedure AddPowerTable(const Section: TStringList);
    procedure AddRootTable(const Section: TStringList);

    procedure AddGetValueFunctions(const AItem: TToolKitItem; const SectionA, SectionB: TStringList);



    procedure Add(const AItem: TToolkitItem);
    procedure Run;
  public
    property ExpandQuantityOperators: boolean read FExpandQuantityOperators write FExpandQuantityOperators;
    property UseFuncInsteadOfOperators: boolean read FUseFuncInsteadOfOperators write FUseFuncInsteadOfOperators;
    property SkipVectorialUnits: boolean read FSkipVectorialUnits write FSkipVectorialUnits;
    property Document: TStringList read FDocument;
    property Messages: TStringList read FMessages;
  end;


implementation

uses
  CSVDocument, DateUtils, IniFiles, LCLType, Math, Process;

// TToolKitBuilder

constructor TToolKitBuilder.Create;
begin
  inherited Create;
  FList         := TToolKitList.Create;
  FDocument     := TStringList.Create;
  FMessages     := TStringList.Create;
  FClassList    := TStringList.Create;
  FClassList.Sorted := TRUE;

  FCommUnits    := TStringList.Create;
  FOperatorList := TStringList.Create;
  FOperatorList.Sorted := TRUE;

  FSkipVectorialunits := False;
  FUseFuncInsteadOfOperators := False;
  FExpandQuantityOperators := False;
  FTestingCount := 0;
end;

destructor TToolKitBuilder.Destroy;
begin
  FOperatorList.Destroy;
  FCommUnits.Destroy;
  FClassList.Destroy;

  FMessages.Destroy;
  FDocument.Destroy;
  FList.Destroy;
  inherited Destroy;
end;

procedure TToolKitBuilder.AddBaseUnits(const SectionA, SectionB: TStringList);
var
  i, j: longint;
begin
  for i := 0 to FList.Count -1 do
  begin

    if (FList[i].FBase = '') then
    begin
      FList[i].FReserved  := BaseUnitCount;
      FList[i].FExponents := GetDimensions(FList[i].FDimension);
      Inc(BaseUnitCount);

      AddUnit(FList[i], SectionA);
      AddSymbols(FList[i], SectionA);
    end else
    begin
      if (FList[i].FFactor = '') then
      begin
        j := FList.Search(FList[i].FBase, 1);
        FList[i].FReserved  := FList[j].FReserved;
        FList[i].FExponents := FList[j].FExponents;
        Inc(FactoredUnitCount);

        AddUnit(FList[i], SectionA);
        AddSymbols(FList[i], SectionA);
      end else
        if Pos('%s', FList[i].FFactor) = 0 then
        begin





          AddFactoredUnit(FList[i], SectionA);
          AddSymbols(FList[i], SectionA);
        end else
        begin



        end;
    end;
  end;
end;

procedure TToolKitBuilder.AddUnit(const AItem: TToolKitItem; const ASection: TStringList);
begin
  ASection.Add('const');
  ASection.Add('  c%s = %d;', [GetUnitID(AItem.FQuantity), AItem.FReserved]);
  ASection.Add('');
  ASection.Add('type');
  ASection.Add('  { T%s }', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('');
  ASection.Add('  T%s = record', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('    const FUnitOfMeasurement = c%s;', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('    const FSymbol            = ''%s'';', [AItem.FShortString]);
  ASection.Add('    const FName              = ''%s'';', [GetSingularName(AItem.FLongString)]);
  ASection.Add('    const FPluralName        = ''%s'';', [GetPluralName(AItem.FLongString)]);
  ASection.Add('    const FPrefixes          : TPrefixes  = (%s);', [GetPrefixes(AItem.FShortString)]);
  ASection.Add('    const FExponents         : TExponents = (%s);', [GetExponents(AItem.FShortString)]);
  ASection.Add('  end;');
  ASection.Add('  %s = specialize TUnit<T%s>;', [GetUnit(AItem.FQuantity), GetUnitID(AItem.FQuantity)]);
  ASection.Add('');
end;

procedure TToolKitBuilder.AddFactoredUnit(const AItem: TToolKitItem; const ASection: TStringList);
begin
  ASection.Add('const');
  ASection.Add('  c%s = %d;', [GetUnitID(AItem.FQuantity), AItem.FReserved]);
  ASection.Add('');
  ASection.Add('type');
  ASection.Add('  { T%s }', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('');
  ASection.Add('  T%s = record', [GetUnitID(AItem.FQuantity)]);
  ASection.Add('    const FUnitOfMeasurement = %d;', [AItem.FReserved]);
  ASection.Add('    const FSymbol            = ''%s'';', [AItem.FShortString]);
  ASection.Add('    const FName              = ''%s'';', [GetSingularName(AItem.FLongString)]);
  ASection.Add('    const FPluralName        = ''%s'';', [GetPluralName(AItem.FLongString)]);
  ASection.Add('    const FPrefixes          : TPrefixes  = (%s);', [GetPrefixes(AItem.FShortString)]);
  ASection.Add('    const FExponents         : TExponents = (%s);', [GetExponents(AItem.FShortString)]);
  ASection.Add('    function GetValue(const AQuantity: TQuantity): double;');
  ASection.Add('    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;');
  ASection.Add('  end;');
  ASection.Add('  %s = specialize TUnit<T%s>;', [GetUnit(AItem.FQuantity), GetUnitID(AItem.FQuantity)]);
  ASection.Add('');
end;

procedure TToolKitBuilder.AddSymbols(const AItem: TToolKitItem; const ASection: TStringList);
begin
  // Base unit symbols
  if (AItem.FBase = '') and (AItem.FIdentifier <> '') then
  begin
    ASection.Append('');
    ASection.Append('var');
    ASection.Add(Format('  %-10s : %s;', [AItem.FIdentifier, GetUnit(AItem.FQuantity)]));
    ASection.Append('');

    AddFactoredSymbols(AItem, ASection);
  end else
    // Factored unit symbols
    if (AItem.FBase <> '') and (AItem.FIdentifier <> '') then
    begin
      if (AItem.FFactor = '') then
      begin
        ASection.Append('var');
        ASection.Add(Format('  %-10s : %s;', [AItem.FIdentifier, GetUnit(AItem.FQuantity)]));
        ASection.Append('');

        AddFactoredSymbols(AItem, ASection);
      end else
        if (Pos('%s', AItem.FFactor) = 0) then
        begin
          ASection.Append('const');
          ASection.Add(Format('  %-10s : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: %d; FValue: %s); {$ELSE} (%s); {$ENDIF}', [AItem.FIdentifier, AItem.FReserved, AItem.FFactor, AItem.FFactor]));
          ASection.Append('');

          AddFactoredSymbols(AItem, ASection);
        end else
          if (Pos('%s', AItem.FFactor) > 0) then
          begin
            ASection.Append('var');
            ASection.Add(Format('  %-10s : %s;', [AItem.FIdentifier, GetUnit(AItem.FQuantity)]));
            ASection.Append('');

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
begin
  Str := '  %-10s : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: %d; FValue: %s); {$ELSE} (%s); {$ENDIF}';

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

  LocList := TStringList.Create;
  if (LowerCase(AItem.FIdentifier) <> 'kg' ) and
     (LowerCase(AItem.FIdentifier) <> 'kg2') then
  begin
    if Params[ 1] = 'L' then LocList.Append(Format(Str, ['quetta' + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, +30*Power)), Factor + FormatFloat('0E+00', IntPower(10, +30*Power))]));
    if Params[ 1] = 'S' then LocList.Append(Format(Str, ['Q'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, +30*Power)), Factor + FormatFloat('0E+00', IntPower(10, +30*Power))]));
    if Params[ 2] = 'L' then LocList.Append(Format(Str, ['ronna'  + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, +27*Power)), Factor + FormatFloat('0E+00', IntPower(10, +27*Power))]));
    if Params[ 2] = 'S' then LocList.Append(Format(Str, ['R'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, +27*Power)), Factor + FormatFloat('0E+00', IntPower(10, +27*Power))]));
    if Params[ 3] = 'L' then LocList.Append(Format(Str, ['yotta'  + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, +24*Power)), Factor + FormatFloat('0E+00', IntPower(10, +24*Power))]));
    if Params[ 3] = 'S' then LocList.Append(Format(Str, ['Y'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, +24*Power)), Factor + FormatFloat('0E+00', IntPower(10, +24*Power))]));
    if Params[ 4] = 'L' then LocList.Append(Format(Str, ['zetta'  + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, +21*Power)), Factor + FormatFloat('0E+00', IntPower(10, +21*Power))]));
    if Params[ 4] = 'S' then LocList.Append(Format(Str, ['Z'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, +21*Power)), Factor + FormatFloat('0E+00', IntPower(10, +21*Power))]));
    if Params[ 5] = 'L' then LocList.Append(Format(Str, ['exa'    + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, +18*Power)), Factor + FormatFloat('0E+00', IntPower(10, +18*Power))]));
    if Params[ 5] = 'S' then LocList.Append(Format(Str, ['E'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, +18*Power)), Factor + FormatFloat('0E+00', IntPower(10, +18*Power))]));
    if Params[ 6] = 'L' then LocList.Append(Format(Str, ['peta'   + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, +15*Power)), Factor + FormatFloat('0E+00', IntPower(10, +15*Power))]));
    if Params[ 6] = 'S' then LocList.Append(Format(Str, ['P'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, +15*Power)), Factor + FormatFloat('0E+00', IntPower(10, +15*Power))]));

    if Params[ 7] = 'L' then LocList.Append(Format(Str, ['tera'   + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, +12*Power)), Factor + FormatFloat('0E+00', IntPower(10, +12*Power))]));
    if Params[ 7] = 'S' then LocList.Append(Format(Str, ['T'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, +12*Power)), Factor + FormatFloat('0E+00', IntPower(10, +12*Power))]));
    if Params[ 8] = 'L' then LocList.Append(Format(Str, ['giga'   + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, + 9*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 9*Power))]));
    if Params[ 8] = 'S' then LocList.Append(Format(Str, ['G'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, + 9*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 9*Power))]));
    if Params[ 9] = 'L' then LocList.Append(Format(Str, ['mega'   + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, + 6*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 6*Power))]));
    if Params[ 9] = 'S' then LocList.Append(Format(Str, ['M'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, + 6*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 6*Power))]));
    if Params[10] = 'L' then LocList.Append(Format(Str, ['kilo'   + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, + 3*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 3*Power))]));
    if Params[10] = 'S' then LocList.Append(Format(Str, ['k'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, + 3*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 3*Power))]));
    if Params[11] = 'L' then LocList.Append(Format(Str, ['hecto'  + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, + 2*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 2*Power))]));
    if Params[11] = 'S' then LocList.Append(Format(Str, ['h'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, + 2*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 2*Power))]));
    if Params[12] = 'L' then LocList.Append(Format(Str, ['deca'   + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, + 1*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 1*Power))]));
    if Params[12] = 'S' then LocList.Append(Format(Str, ['da'     + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, + 1*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 1*Power))]));
    if Params[13] = 'L' then LocList.Append(Format(Str, ['deci'   + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, - 1*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 1*Power))]));
    if Params[13] = 'S' then LocList.Append(Format(Str, ['d'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, - 1*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 1*Power))]));
    if Params[14] = 'L' then LocList.Append(Format(Str, ['centi'  + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, - 2*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 2*Power))]));
    if Params[14] = 'S' then LocList.Append(Format(Str, ['c'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, - 2*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 2*Power))]));
    if Params[15] = 'L' then LocList.Append(Format(Str, ['milli'  + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, - 3*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 3*Power))]));
    if Params[15] = 'S' then LocList.Append(Format(Str, ['m'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, - 3*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 3*Power))]));
    if Params[16] = 'L' then LocList.Append(Format(Str, ['micro'  + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, - 6*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 6*Power))]));
    if Params[16] = 'S' then LocList.Append(Format(Str, ['mi'     + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, - 6*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 6*Power))]));
    if Params[17] = 'L' then LocList.Append(Format(Str, ['nano'   + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, - 9*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 9*Power))]));
    if Params[17] = 'S' then LocList.Append(Format(Str, ['n'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, - 9*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 9*Power))]));
    if Params[18] = 'L' then LocList.Append(Format(Str, ['pico'   + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, -12*Power)), Factor + FormatFloat('0E+00', IntPower(10, -12*Power))]));
    if Params[18] = 'S' then LocList.Append(Format(Str, ['p'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, -12*Power)), Factor + FormatFloat('0E+00', IntPower(10, -12*Power))]));

    if Params[19] = 'L' then LocList.Append(Format(Str, ['femto'  + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, -15*Power)), Factor + FormatFloat('0E+00', IntPower(10, -15*Power))]));
    if Params[19] = 'S' then LocList.Append(Format(Str, ['f'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, -15*Power)), Factor + FormatFloat('0E+00', IntPower(10, -15*Power))]));
    if Params[20] = 'L' then LocList.Append(Format(Str, ['atto'   + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, -18*Power)), Factor + FormatFloat('0E+00', IntPower(10, -18*Power))]));
    if Params[20] = 'S' then LocList.Append(Format(Str, ['a'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, -18*Power)), Factor + FormatFloat('0E+00', IntPower(10, -18*Power))]));
    if Params[21] = 'L' then LocList.Append(Format(Str, ['zepto'  + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, -21*Power)), Factor + FormatFloat('0E+00', IntPower(10, -21*Power))]));
    if Params[21] = 'S' then LocList.Append(Format(Str, ['z'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, -21*Power)), Factor + FormatFloat('0E+00', IntPower(10, -21*Power))]));
    if Params[22] = 'L' then LocList.Append(Format(Str, ['yocto'  + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, -24*Power)), Factor + FormatFloat('0E+00', IntPower(10, -24*Power))]));
    if Params[22] = 'S' then LocList.Append(Format(Str, ['y'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, -24*Power)), Factor + FormatFloat('0E+00', IntPower(10, -24*Power))]));
    if Params[23] = 'L' then LocList.Append(Format(Str, ['ronto'  + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, -27*Power)), Factor + FormatFloat('0E+00', IntPower(10, -27*Power))]));
    if Params[23] = 'S' then LocList.Append(Format(Str, ['r'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, -27*Power)), Factor + FormatFloat('0E+00', IntPower(10, -27*Power))]));
    if Params[24] = 'L' then LocList.Append(Format(Str, ['quecto' + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, -30*Power)), Factor + FormatFloat('0E+00', IntPower(10, -30*Power))]));
    if Params[24] = 'S' then LocList.Append(Format(Str, ['q'      + AItem.FIdentifier, AItem.FReserved, Factor + FormatFloat('0E+00', IntPower(10, -30*Power)), Factor + FormatFloat('0E+00', IntPower(10, -30*Power))]));
  end else
    if (LowerCase(AItem.FIdentifier) = 'kg') then
    begin
      LocList.Append(Format(Str, ['hg'  , AItem.FReserved, '1E-01', '1E-01']));
      LocList.Append(Format(Str, ['dag' , AItem.FReserved, '1E-02', '1E-02']));
      LocList.Append(Format(Str, ['g'   , AItem.FReserved, '1E-03', '1E-03']));
      LocList.Append(Format(Str, ['dg'  , AItem.FReserved, '1E-04', '1E-04']));
      LocList.Append(Format(Str, ['cg'  , AItem.FReserved, '1E-05', '1E-05']));
      LocList.Append(Format(Str, ['mg'  , AItem.FReserved, '1E-06', '1E-06']));
      LocList.Append(Format(Str, ['mig' , AItem.FReserved, '1E-09', '1E-09']));
      LocList.Append(Format(Str, ['ng'  , AItem.FReserved, '1E-12', '1E-12']));
      LocList.Append(Format(Str, ['pg'  , AItem.FReserved, '1E-15', '1E-15']));
    end else
      if (LowerCase(AItem.FIdentifier) = 'kg2') then
      begin
        LocList.Append(Format(Str, ['hg2'  , AItem.FReserved, '1E-02', '1E-02']));
        LocList.Append(Format(Str, ['dag2' , AItem.FReserved, '1E-04', '1E-04']));
        LocList.Append(Format(Str, ['g2'   , AItem.FReserved, '1E-06', '1E-06']));
        LocList.Append(Format(Str, ['dg2'  , AItem.FReserved, '1E-08', '1E-08']));
        LocList.Append(Format(Str, ['cg2'  , AItem.FReserved, '1E-10', '1E-10']));
        LocList.Append(Format(Str, ['mg2'  , AItem.FReserved, '1E-12', '1E-12']));
        LocList.Append(Format(Str, ['mig2' , AItem.FReserved, '1E-18', '1E-18']));
        LocList.Append(Format(Str, ['ng2'  , AItem.FReserved, '1E-24', '1E-24']));
        LocList.Append(Format(Str, ['pg2'  , AItem.FReserved, '1E-30', '1E-30']));
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


procedure TToolKitBuilder.AddPowerTable(const Section: TStringList);
var
  i, j: longint;
  D1, D2, D3, D4, D5, D6: TExponents;
  S: string;
begin
  Section.Add(Format('const', []));
  Section.Add(Format('  PowerTable : array[0..%d] of', [BaseUnitCount -1]));
  Section.Add(Format('    record  Square, Cubic, Quartic, Quintic, Sextic: longint; end = (', []));

  for i := 0 to FList.Count -1 do
  begin
    if FList[i].FBase = '' then
    begin
      D1 := GetDimensions(FList[i].FDimension);

      for j := Low(D1) to High(D1) do D2[j] := D1[j] *2;
      for j := Low(D1) to High(D1) do D3[j] := D1[j] *3;
      for j := Low(D1) to High(D1) do D4[j] := D1[j] *4;
      for j := Low(D1) to High(D1) do D5[j] := D1[j] *5;
      for j := Low(D1) to High(D1) do D6[j] := D1[j] *6;

      S := Format('    (Square: %d; Cubic: %d; Quartic: %d; Quintic: %d; Sextic: %d),',
        [FList.Search(D2), FList.Search(D3), FList.Search(D4), FList.Search(D5), FList.Search(D6)]);

      if i = FList.Count -1 then
      begin
        SetLength(S, Length(S) -1);
      end;
      Section.Add(S);
    end;
  end;
  Section.Add(Format('  );', []));
  Section.Add(Format('', []));
end;

procedure TToolKitBuilder.AddRootTable(const Section: TStringList);
var
  i, j: longint;
  D1, D2, D3, D4, D5, D6: TExponents;
  S: string;
begin
  Section.Add(Format('const', []));
  Section.Add(Format('  RootTable : array[0..%d] of', [BaseUnitCount -1]));
  Section.Add(Format('    record  Square, Cubic, Quartic, Quintic, Sextic: longint; end = (', []));

  for i := 0 to FList.Count -1 do
  begin
    if FList[i].FBase = '' then
    begin
      D1 := GetDimensions(FList[i].FDimension);

      for j := Low(D1) to High(D1) do D2[j] := D1[j] /2;
      for j := Low(D1) to High(D1) do D3[j] := D1[j] /3;
      for j := Low(D1) to High(D1) do D4[j] := D1[j] /4;
      for j := Low(D1) to High(D1) do D5[j] := D1[j] /5;
      for j := Low(D1) to High(D1) do D6[j] := D1[j] /6;

      S := Format('    (Square: %d; Cubic: %d; Quartic: %d; Quintic: %d; Sextic: %d),',
        [FList.Search(D2), FList.Search(D3), FList.Search(D4), FList.Search(D5), FList.Search(D6)]);

      if i = FList.Count -1 then
      begin
        SetLength(S, Length(S) -1);
      end;
      Section.Add(S);
    end;
  end;
  Section.Add(Format('  );', []));
  Section.Add(Format('', []));
end;

procedure TToolKitBuilder.AddGetValueFunctions(const AItem: TToolKitItem; const SectionA, SectionB: TStringList);
begin
  SectionB.Add(Format('function %s.GetValue(const AValue: TQuantity): double;', [GetHelperFuncName(AItem.FQuantity)]));
  SectionB.Add(Format('begin',[]));
  SectionB.Add(Format('{$IFOPT D+}',[]));
  SectionB.Add(Format('  result := GetValue( %s );', ['AValue.FValue']));
  SectionB.Add(Format('{$ELSE}', []));
  SectionB.Add(Format('  result := GetValue( %s );', ['AValue']));
  SectionB.Add(Format('{$ENDIF}', []));
  SectionB.Add(Format('end;',[]));
  SectionB.Add(Format('',[]));

  SectionB.Add(Format('function %s.GetValue(const AValue: TQuantity; const APrefixes: TPrefixes): double;', [GetHelperFuncName(AItem.FQuantity)]));
  SectionB.Add(Format('begin',[]));
  SectionB.Add(Format('{$IFOPT D+}',[]));
  SectionB.Add(Format('  result := GetValue( %s, APrefixes);', ['AValue.FValue']));
  SectionB.Add(Format('{$ELSE}', []));
  SectionB.Add(Format('  result := GetValue( %s, APrefixes);', ['AValue']));
  SectionB.Add(Format('{$ENDIF}', []));
  SectionB.Add(Format('end;',[]));
  SectionB.Add(Format('',[]));
  SectionB.Add(Format('',[]));
end;

procedure TToolKitBuilder.Add(const AItem: TToolkitItem);
begin
  FList.Add(AItem);
end;

procedure TToolKitBuilder.Run;
var
  I, J, K: longint;
  Line: string;
  Table: array of array of longint;
  Dim1: TExponents;
  Dim2: TExponents;

begin
  SectionA0  := TStringList.Create;
  SectionA1  := TStringList.Create;
  SectionA2  := TStringList.Create;
  SectionA21 := TStringList.Create;
  SectionA22 := TStringList.Create;
  SectionA3  := TStringList.Create;
  SectionA4  := TStringList.Create;
  SectionA5  := TStringList.Create;
  SectionA6  := TStringList.Create;
  SectionA7  := TStringList.Create;
  SectionA8  := TStringList.Create;
  SectionA9  := TStringList.Create;
  SectionA10 := TStringList.Create;

  SectionB1  := TStringList.Create;
  SectionB2  := TStringList.Create;
  SectionB21 := TStringList.Create;
  SectionB22 := TStringList.Create;
  SectionB3  := TStringList.Create;
  SectionB4  := TStringList.Create;
  SectionB5  := TStringList.Create;
  SectionB6  := TStringList.Create;
  SectionB7  := TStringList.Create;
  SectionB8  := TStringList.Create;
  SectionB9  := TStringList.Create;
  SectionB10 := TStringList.Create;

  BaseUnitCount     := 0;
  FactoredUnitCount := 0;
  ExternalOperators := 0;
  InternalOperators := 0;
  ForcedOperators   := 0;

  FClassList.Clear;
  FCommUnits.Clear;
  FOperatorList.Clear;

  SectionA2.Add('');
  SectionA2.Add('');
  SectionA2.Add('');
  SectionA2.Add('');







  AddBaseUnits(SectionA3, SectionB3);




  SectionB2.Append('implementation');
  SectionB2.Append('');
  SectionB2.Append('uses');
  SectionB2.Append('  Math;');
  SectionB2.Append('');



  SetLength(Table, BaseUnitCount);
  for i := Low(Table) to High(Table) do
    SetLength(Table[i], BaseUnitCount);

  SectionB2.Append('const');
  SectionB2.Append('');
  SectionB2.Append('  { Mul Table }');
  SectionB2.Append('');
  SectionB2.Append(Format('  MulTable : array[%d..%d, %d..%d] of longint = (', [Low(Table), High(Table), Low(Table), High(Table)]));

  for i := 0 to FList.Count -1 do
  begin
    if FList[i].FBase = '' then
    begin
      Clear(Dim1);
      Dim1 := FList[i].FExponents;
      Line := '    (';
      for j := 0 to FList.Count -1 do
      begin
        if FList[j].FBase = '' then
        begin
          Clear(Dim2);
          Dim2 := FList[j].FExponents;

          K := FList.Search(SumDim(Dim1, Dim2));
          if K <> -1 then
            Line := Line + 'c' + GetUnit(FList[K].FQuantity) + ', '
          else
            Line := Line +  '-1, '
        end;
      end;

      if i = (FList.Count - 1) then
      begin
        Line[High(Line) -1] := ')';
        Line[High(Line)   ] := ' ';
      end else
      begin
        Line[High(Line) -1] := ')';
        Line[High(Line)   ] := ',';
      end;
      SectionB2.Append(Line);
    end;
  end;
  for i := Low(Table) to High(Table) do Table[i] := nil;
  Table := nil;
  SectionB2.Append('  );');
  SectionB2.Append('');


  SetLength(Table, BaseUnitCount);
  for i := Low(Table) to High(Table) do
    SetLength(Table[i], BaseUnitCount);

  SectionB2.Append('  { Div Table }');
  SectionB2.Append('');
  SectionB2.Append(Format('  DivTable : array[%d..%d, %d..%d] of longint = (', [Low(Table), High(Table), Low(Table), High(Table)]));

  for i := 0 to FList.Count -1 do
  begin
    if FList[i].FBase = '' then
    begin
      Clear(Dim1);
      Dim1 := FList[i].FExponents;
      Line := '    (';
      for j := 0 to FList.Count -1 do
      begin
        if FList[j].FBase = '' then
        begin
          Clear(Dim2);
          Dim2 := FList[j].FExponents;

          K := FList.Search(SubDim(Dim1, Dim2));
          if K <> -1 then
            Line := Line + 'c' + GetUnit(FList[K].FQuantity) + ', '
          else
            Line := Line +  '-1, '
        end;
      end;

      if i = (FList.Count - 1) then
      begin
        Line[High(Line) -1] := ')';
        Line[High(Line)   ] := ' ';
      end else
      begin
        Line[High(Line) -1] := ')';
        Line[High(Line)   ] := ',';
      end;
      SectionB2.Append(Line);
    end;
  end;
  for i := Low(Table) to High(Table) do Table[i] := nil;
  Table := nil;
  SectionB2.Append('  );');
  SectionB2.Append('');


  AddPowerTable(SectionB2);
  AddRootTable(SectionB2);

















  SectionA4.Append('');
  SectionB4.Append('');

  SectionA5.Append('');
  SectionB5.Append('');

  SectionA6.Append('');
  SectionB6.Append('');

  SectionA7.Append('');
  SectionB7.Append('');

  SectionA8.Append('');
  SectionA8.Append('{ Helpers }');
  SectionA8.Append('');


  for i := 0 to FList.Count -1 do
  begin
    if Pos('%s', FList[i].FFactor) <> 0 then
      AddGetValueFunctions(FList[i], SectionA8, SectionB8);
  end;




  SectionB8.Append('');
  SectionB8.Append('{ Helpers }');
  SectionB8.Append('');


  SectionA9.Append('');
  SectionA9.Append('{ Power functions }');
  SectionA9.Append('');
  SectionB9.Append('');
  SectionB9.Append('{ Power functions }');
  SectionB9.Append('');



  SectionA10.Append('');
  SectionB10.Append('');





  SectionA0.Append('');
  SectionA0.Append('{');
  SectionA0.Append(Format('  ADimRT library built on %s.', [DateToStr(Now)]));
  SectionA0.Append('');

  SectionA0.Append(Format('  Number of base units: %d', [BaseUnitCount]));
  SectionA0.Append(Format('  Number of factored units: %d', [FactoredUnitCount]));
  SectionA0.Append(Format('  Number of operators: %d (%d external, %d internal)',
    [ExternalOperators + InternalOperators, ExternalOperators, InternalOperators]));
  SectionA0.Append('}');

  SectionA0.Append('');
  SectionA0.Append('unit ADimRT;');
  SectionA0.Append('');
  SectionA0.Append('{$H+}{$J-}');
  SectionA0.Append('{$modeswitch typehelpers}');
  SectionA0.Append('{$modeswitch advancedrecords}');
  SectionA0.Append('{$WARN 5024 OFF} // Suppress warning for unused routine parameter.');
  SectionA0.Append('{$WARN 5033 OFF} // Suppress warning for unassigned function''s return value.');
  SectionA0.Append('{$MACRO ON}');
  SectionA0.Append('');
  SectionA0.Append('interface');
  SectionA0.Append('');
  SectionA0.Append('uses');
  SectionA0.Append('  DateUtils, Sysutils;');
  SectionA0.Append('');












  for I := 0 to SectionA0 .Count -1 do FDocument.Append(SectionA0 [I]);
  for I := 0 to SectionA1 .Count -1 do FDocument.Append(SectionA1 [I]);
  for I := 0 to SectionA2 .Count -1 do FDocument.Append(SectionA2 [I]);
  for I := 0 to SectionA21.Count -1 do FDocument.Append(SectionA21[I]);
  for I := 0 to SectionA22.Count -1 do FDocument.Append(SectionA22[I]);

  for I := 0 to SectionA3 .Count -1 do FDocument.Append(SectionA3 [I]);
  for I := 0 to SectionA4 .Count -1 do FDocument.Append(SectionA4 [I]);
  for I := 0 to SectionA5 .Count -1 do FDocument.Append(SectionA5 [I]);
  for I := 0 to SectionA6 .Count -1 do FDocument.Append(SectionA6 [I]);
  for I := 0 to SectionA7 .Count -1 do FDocument.Append(SectionA7 [I]);
  for I := 0 to SectionA8 .Count -1 do FDocument.Append(SectionA8 [I]);
  for I := 0 to SectionA9 .Count -1 do FDocument.Append(SectionA9 [I]);
  for I := 0 to SectionA10.Count -1 do FDocument.Append(SectionA10[I]);

  for I := 0 to SectionB1 .Count -1 do FDocument.Append(SectionB1 [I]);
  for I := 0 to SectionB2 .Count -1 do FDocument.Append(SectionB2 [I]);
  for I := 0 to SectionB21.Count -1 do FDocument.Append(SectionB21[I]);
  for I := 0 to SectionB22.Count -1 do FDocument.Append(SectionB22[I]);

  for I := 0 to SectionB3 .Count -1 do FDocument.Append(SectionB3 [I]);
  for I := 0 to SectionB4 .Count -1 do FDocument.Append(SectionB4 [I]);
  for I := 0 to SectionB5 .Count -1 do FDocument.Append(SectionB5 [I]);
  for I := 0 to SectionB6 .Count -1 do FDocument.Append(SectionB6 [I]);
  for I := 0 to SectionB7 .Count -1 do FDocument.Append(SectionB7 [I]);
  for I := 0 to SectionB8 .Count -1 do FDocument.Append(SectionB8 [I]);
  for I := 0 to SectionB9 .Count -1 do FDocument.Append(SectionB9 [I]);
  for I := 0 to SectionB10.Count -1 do FDocument.Append(SectionB10[I]);

  FDocument.Add('');
  FDocument.Add('end.');
  CleanDocument(FDocument);

  SectionB10.Destroy;
  SectionB9 .Destroy;
  SectionB8 .Destroy;
  SectionB7 .Destroy;
  SectionB6 .Destroy;
  SectionB5 .Destroy;
  SectionB4 .Destroy;
  SectionB3 .Destroy;
  SectionB22.Destroy;
  SectionB21.Destroy;
  SectionB2 .Destroy;
  SectionB1 .Destroy;

  SectionA10.Destroy;
  SectionA9 .Destroy;
  SectionA8 .Destroy;
  SectionA7 .Destroy;
  SectionA6 .Destroy;
  SectionA5 .Destroy;
  SectionA4 .Destroy;
  SectionA3 .Destroy;
  SectionA22.Destroy;
  SectionA21.Destroy;
  SectionA2 .Destroy;
  SectionA1 .Destroy;
  SectionA0 .Destroy;
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
  FList.Delete(Index);
end;

procedure TToolKitList.Clear;
begin
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
      if SameValue(Item.FExponents[1], ADim[1]) and
         SameValue(Item.FExponents[2], ADim[2]) and
         SameValue(Item.FExponents[3], ADim[3]) and
         SameValue(Item.FExponents[4], ADim[4]) and
         SameValue(Item.FExponents[5], ADim[5]) and
         SameValue(Item.FExponents[6], ADim[6]) and
         SameValue(Item.FExponents[7], ADim[7]) then Exit(i);
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
      if SameValue(Item.FExponents[1], ADim[1]) and
         SameValue(Item.FExponents[2], ADim[2]) and
         SameValue(Item.FExponents[3], ADim[3]) and
         SameValue(Item.FExponents[4], ADim[4]) and
         SameValue(Item.FExponents[5], ADim[5]) and
         SameValue(Item.FExponents[6], ADim[6]) and
         SameValue(Item.FExponents[7], ADim[7]) then Exit(i);
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

    //AddBool := Pos('//', Item.FQuantity) = 0;
    //if AddBool then
    //begin
    //  AddBool := (Item.FLongString <> '') and (Item.FShortString <> '');
    //end;

    //if AddBool then
    Add(Item);
    //else
    //  Item.Destroy;
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

