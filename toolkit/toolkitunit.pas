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

    procedure AddUnitRecources(const AItem: TToolKitItem; const ASection: TStringList);
    procedure AddUnitSymbols(const AItem: TToolKitItem; const ASection: TStringList);
    procedure AddFactoredSymbols(const AIdentifier, ABase, AFactor, APrefixes: string; const SectionA: TStringList);

    procedure AddPowerTable(const Section: TStringList);
    procedure AddRootTable(const Section: TStringList);

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
  i: longint;
begin
  for i := 0 to FList.Count -1 do
  begin
    if (FList[i].FBase = '') then
    begin
      SectionA.Add(Format('type', []));
      SectionA.Add(Format('  %s = record', [GetUnit(FList[i].FQuantity)]));
      SectionA.Add(Format('    class operator *(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
      SectionA.Add(Format('    class operator /(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
      SectionA.Add(Format('  {$IFOPT D+}',[]));
      SectionA.Add(Format('    class operator *(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
      SectionA.Add(Format('    class operator /(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
      SectionA.Add(Format('  {$ENDIF}',[]));
      SectionA.Add(Format('  end;',[]));
      SectionA.Add(Format('',[]));

      AddUnitRecources(FList[i], SectionA);
      AddUnitSymbols(FList[i], SectionA);

      SectionB.Add(Format('class operator %s.*(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
      SectionB.Add(Format('begin',[]));
      SectionB.Add(Format('{$IFOPT D+}',[]));
      SectionB.Add(Format('  result.FUnitOfMeasurement := MulTable[cScalar, %s];',[GetUnitIndex(FList[i].FQuantity)]));
      SectionB.Add(Format('  result.FValue := AValue',[]));
      SectionB.Add(Format('{$ELSE}',[]));
      SectionB.Add(Format('  result := AValue',[]));
      SectionB.Add(Format('{$ENDIF}',[]));
      SectionB.Add(Format('end;',[]));
      SectionB.Add(Format('',[]));

      SectionB.Add(Format('class operator %s./(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
      SectionB.Add(Format('begin',[]));
      SectionB.Add(Format('{$IFOPT D+}',[]));
      SectionB.Add(Format('  result.FUnitOfMeasurement := DivTable[cScalar, %s];',[GetUnitIndex(FList[i].FQuantity)]));
      SectionB.Add(Format('  result.FValue := AValue',[]));
      SectionB.Add(Format('{$ELSE}',[]));
      SectionB.Add(Format('  result := AValue',[]));
      SectionB.Add(Format('{$ENDIF}',[]));
      SectionB.Add(Format('end;',[]));
      SectionB.Add(Format('',[]));

      SectionB.Add(Format('{$IFOPT D+}',[]));
      SectionB.Add(Format('class operator %s.*(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
      SectionB.Add(Format('begin',[]));
      SectionB.Add(Format('  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, %s];',[GetUnitIndex(FList[i].FQuantity)]));
      SectionB.Add(Format('  result.FValue := AValue.FValue',[]));
      SectionB.Add(Format('end;',[]));
      SectionB.Add(Format('{$ENDIF}',[]));
      SectionB.Add(Format('',[]));

      SectionB.Add(Format('{$IFOPT D+}',[]));
      SectionB.Add(Format('class operator %s./(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
      SectionB.Add(Format('begin',[]));
      SectionB.Add(Format('  result.FUnitOfMeasurement := DivTable[AValue.FUnitOfMeasurement, %s];',[GetUnitIndex(FList[i].FQuantity)]));
      SectionB.Add(Format('  result.FValue := AValue.FValue',[]));
      SectionB.Add(Format('end;',[]));
      SectionB.Add(Format('{$ENDIF}',[]));
      SectionB.Add(Format('',[]));
    end else
    begin
      if Pos('%s', FList[i].FFactor) > 0 then
      begin
        SectionA.Add(Format('type', []));
        SectionA.Add(Format('  %s = record', [GetUnit(FList[i].FQuantity)]));
        SectionA.Add(Format('    class operator *(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
        SectionA.Add(Format('    class operator /(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
        SectionA.Add(Format('  {$IFOPT D+}',[]));
        SectionA.Add(Format('    class operator *(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
        SectionA.Add(Format('    class operator /(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
        SectionA.Add(Format('  {$ENDIF}',[]));
        SectionA.Add(Format('  end;',[]));
        SectionA.Add(Format('',[]));

        AddUnitRecources(FList[i], SectionA);
        AddUnitSymbols(FList[i], SectionA);

        SectionB.Add(Format('class operator %s.*(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
        SectionB.Add(Format('begin',[]));
        SectionB.Add(Format('{$IFOPT D+}',[]));
        SectionB.Add(Format('  result.FUnitOfMeasurement := MulTable[cScalar, %s];',[GetUnitIndex(FList[i].FBase)]));
        SectionB.Add(Format('  result.FValue := %s;',[Format(Copy(FList[i].FFactor, 1, Pos('|', FList[i].FFactor) -1), ['AValue'])]));
        SectionB.Add(Format('{$ELSE}',[]));
        SectionB.Add(Format('  result := %s;',[Format(Copy(FList[i].FFactor, 1, Pos('|', FList[i].FFactor) -1), ['AValue'])]));
        SectionB.Add(Format('{$ENDIF}',[]));
        SectionB.Add(Format('end;',[]));
        SectionB.Add(Format('',[]));

        SectionB.Add(Format('class operator %s./(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
        SectionB.Add(Format('begin',[]));
        SectionB.Add(Format('{$IFOPT D+}',[]));
        SectionB.Add(Format('  result.FUnitOfMeasurement := DivTable[cScalar, %s];',[GetUnitIndex(FList[i].FBase)]));
        SectionB.Add(Format('  result.FValue := %s;',[Format(Copy(FList[i].FFactor, 1, Pos('|', FList[i].FFactor) -1), ['AValue'])]));
        SectionB.Add(Format('{$ELSE}',[]));
        SectionB.Add(Format('  result := %s;',[Format(Copy(FList[i].FFactor, 1, Pos('|', FList[i].FFactor) -1), ['AValue'])]));
        SectionB.Add(Format('{$ENDIF}',[]));
        SectionB.Add(Format('end;',[]));
        SectionB.Add(Format('',[]));

        SectionB.Add(Format('{$IFOPT D+}',[]));
        SectionB.Add(Format('class operator %s.*(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
        SectionB.Add(Format('begin',[]));
        SectionB.Add(Format('  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, %s];',[GetUnitIndex(FList[i].FBase)]));
        SectionB.Add(Format('  result.FValue := %s;',[Format(Copy(FList[i].FFactor, 1, Pos('|', FList[i].FFactor) -1), ['AValue.FValue'])]));
        SectionB.Add(Format('end;',[]));
        SectionB.Add(Format('{$ENDIF}',[]));
        SectionB.Add(Format('',[]));

        SectionB.Add(Format('{$IFOPT D+}',[]));
        SectionB.Add(Format('class operator %s./(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
        SectionB.Add(Format('begin',[]));
        SectionB.Add(Format('  result.FUnitOfMeasurement := DivTable[AValue.FUnitOfMeasurement, %s];',[GetUnitIndex(FList[i].FBase)]));
        SectionB.Add(Format('  result.FValue := %s;',[Format(Copy(FList[i].FFactor, 1, Pos('|', FList[i].FFactor) -1), ['AValue.FValue'])]));
        SectionB.Add(Format('end;',[]));
        SectionB.Add(Format('{$ENDIF}',[]));
        SectionB.Add(Format('',[]));
      end else
        if (FList[i].FFactor = '') then
        begin
          SectionA.Add(Format('type', []));
          SectionA.Add(Format('  %s = record', [GetUnit(FList[i].FQuantity)]));
          SectionA.Add(Format('    class operator *(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
          SectionA.Add(Format('    class operator /(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
          SectionA.Add(Format('  {$IFOPT D+}',[]));
          SectionA.Add(Format('    class operator *(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
          SectionA.Add(Format('    class operator /(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
          SectionA.Add(Format('  {$ENDIF}',[]));
          SectionA.Add(Format('  end;',[]));
          SectionA.Add(Format('',[]));

          AddUnitRecources(FList[i], SectionA);
          AddUnitSymbols(FList[i], SectionA);

          SectionB.Add(Format('class operator %s.*(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
          SectionB.Add(Format('begin',[]));
          SectionB.Add(Format('{$IFOPT D+}',[]));
          SectionB.Add(Format('  result.FUnitOfMeasurement := MulTable[cScalar, %s];',[GetUnitIndex(FList[i].FBase)]));
          SectionB.Add(Format('  result.FValue := AValue;',[]));
          SectionB.Add(Format('{$ELSE}',[]));
          SectionB.Add(Format('  result := AValue;', []));
          SectionB.Add(Format('{$ENDIF}',[]));
          SectionB.Add(Format('end;',[]));
          SectionB.Add(Format('',[]));

          SectionB.Add(Format('class operator %s./(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
          SectionB.Add(Format('begin',[]));
          SectionB.Add(Format('{$IFOPT D+}',[]));
          SectionB.Add(Format('  result.FUnitOfMeasurement := DivTable[cScalar, %s];',[GetUnitIndex(FList[i].FBase)]));
          SectionB.Add(Format('  result.FValue := AValue;',[]));
          SectionB.Add(Format('{$ELSE}',[]));
          SectionB.Add(Format('  result := AValue;', []));
          SectionB.Add(Format('{$ENDIF}',[]));
          SectionB.Add(Format('end;',[]));
          SectionB.Add(Format('',[]));

          SectionB.Add(Format('{$IFOPT D+}',[]));
          SectionB.Add(Format('class operator %s.*(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
          SectionB.Add(Format('begin',[]));
          SectionB.Add(Format('  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, %s];',[GetUnitIndex(FList[i].FBase)]));
          SectionB.Add(Format('  result.FValue := AValue.FValue;',[]));
          SectionB.Add(Format('end;',[]));
          SectionB.Add(Format('{$ENDIF}',[]));
          SectionB.Add(Format('',[]));

          SectionB.Add(Format('{$IFOPT D+}',[]));
          SectionB.Add(Format('class operator %s./(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
          SectionB.Add(Format('begin',[]));
          SectionB.Add(Format('  result.FUnitOfMeasurement := DivTable[AValue.FUnitOfMeasurement, %s];',[GetUnitIndex(FList[i].FBase)]));
          SectionB.Add(Format('  result.FValue := AValue.FValue;',[]));
          SectionB.Add(Format('end;',[]));
          SectionB.Add(Format('{$ENDIF}',[]));
          SectionB.Add(Format('',[]));
        end else
        begin
          SectionA.Add(Format('type', []));
          SectionA.Add(Format('  %s = record', [GetUnit(FList[i].FQuantity)]));
          SectionA.Add(Format('    class operator *(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
          SectionA.Add(Format('    class operator /(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
          SectionA.Add(Format('  {$IFOPT D+}',[]));
          SectionA.Add(Format('    class operator *(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
          SectionA.Add(Format('    class operator /(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
          SectionA.Add(Format('  {$ENDIF}',[]));
          SectionA.Add(Format('  end;',[]));
          SectionA.Add(Format('',[]));

          AddUnitRecources(FList[i], SectionA);
          AddUnitSymbols(FList[i], SectionA);

          SectionB.Add(Format('class operator %s.*(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
          SectionB.Add(Format('begin',[]));
          SectionB.Add(Format('{$IFOPT D+}',[]));
          SectionB.Add(Format('  result.FUnitOfMeasurement := MulTable[cScalar, %s];',[GetUnitIndex(FList[i].FBase)]));
          SectionB.Add(Format('  result.FValue := AValue * %s;',[FList[i].FFactor]));
          SectionB.Add(Format('{$ELSE}',[]));
          SectionB.Add(Format('  result := AValue * %s;', [FList[i].FFactor]));
          SectionB.Add(Format('{$ENDIF}',[]));
          SectionB.Add(Format('end;',[]));
          SectionB.Add(Format('',[]));

          SectionB.Add(Format('class operator %s./(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
          SectionB.Add(Format('begin',[]));
          SectionB.Add(Format('{$IFOPT D+}',[]));
          SectionB.Add(Format('  result.FUnitOfMeasurement := DivTable[cScalar, %s];',[GetUnitIndex(FList[i].FBase)]));
          SectionB.Add(Format('  result.FValue := AValue * %s;',[FList[i].FFactor]));
          SectionB.Add(Format('{$ELSE}',[]));
          SectionB.Add(Format('  result := AValue * %s;', [FList[i].FFactor]));
          SectionB.Add(Format('{$ENDIF}',[]));
          SectionB.Add(Format('end;',[]));
          SectionB.Add(Format('',[]));

          SectionB.Add(Format('{$IFOPT D+}',[]));
          SectionB.Add(Format('class operator %s.*(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
          SectionB.Add(Format('begin',[]));
          SectionB.Add(Format('  result.FUnitOfMeasurement := MulTable[cScalar, %s];',[GetUnitIndex(FList[i].FBase)]));
          SectionB.Add(Format('  result.FValue := AValue.FValue * %s;',[FList[i].FFactor]));
          SectionB.Add(Format('end;',[]));
          SectionB.Add(Format('{$ENDIF}',[]));
          SectionB.Add(Format('',[]));

          SectionB.Add(Format('{$IFOPT D+}',[]));
          SectionB.Add(Format('class operator %s./(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
          SectionB.Add(Format('begin',[]));
          SectionB.Add(Format('  result.FUnitOfMeasurement := DivTable[cScalar, %s];',[GetUnitIndex(FList[i].FBase)]));
          SectionB.Add(Format('  result.FValue := AValue.FValue * %s;',[FList[i].FFactor]));
          SectionB.Add(Format('end;',[]));
          SectionB.Add(Format('{$ENDIF}',[]));
          SectionB.Add(Format('',[]));
        end;
    end;
  end;
end;

procedure TToolKitBuilder.AddUnitRecources(const AItem: TToolKitItem; const ASection: TStringList);
begin
  ASection.Add('const');
  ASection.Add('  %s     = ''%s'';', [GetSymbolResourceString(AItem.FQuantity), AItem.FShortString]);
  ASection.Add('  %s       = ''%s'';', [GetSingularNameResourceString(AItem.FQuantity), GetSingularName(AItem.FLongString)]);
  ASection.Add('  %s = ''%s'';', [GetPluralNameResourceString(AItem.FQuantity), GetPluralName(AItem.FLongString)]);
  ASection.Add('');

  ASection.Add('const');
  ASection.Add('  %s                       = (%d);', [GetUnitIndex(AItem.FQuantity), AItem.FReserved]);

  if AItem.FBase = '' then
  begin
    ASection.Add('  %s  : TPrefixes  = (%s);', [GetPrefixesConst(AItem.FQuantity), GetPrefixes(AItem.FShortString)]);
    ASection.Add('  %s : TExponents = (%s);', [GetExponentsConst(AItem.FQuantity), GetExponents(AItem.FShortString)]);
  end else
  begin
    ASection.Add('  %s  : TPrefixes  = (%s);', [GetPrefixesConst(AItem.FQuantity), GetPrefixes(AItem.FShortString)]);
    ASection.Add('  %s : TExponents = (%s);', [GetExponentsConst(AItem.FQuantity), GetExponents(AItem.FShortString)]);
  end;
  ASection.Add('');
end;

procedure TToolKitBuilder.AddUnitSymbols(const AItem: TToolKitItem; const ASection: TStringList);
begin
  // Base unit symbols
  if (AItem.FBase = '') and (AItem.FIdentifier <> '') then
  begin
    ASection.Append('');
    ASection.Append('var');
    ASection.Add(Format('  %-10s : %s;', [AItem.FIdentifier, GetUnit(AItem.FQuantity)]));
    ASection.Append('');
    if (Pos('S', AItem.FPrefixes) > 0) or
       (Pos('L', AItem.FPrefixes) > 0) then
    begin
      ASection.Append('const');
      AddFactoredSymbols(AItem.FIdentifier, AItem.FQuantity, AItem.FFactor, AItem.FPrefixes, ASection);
      ASection.Append('');
    end;
  end else
    // Factored unit symbols
    if (AItem.FBase <> '') and (AItem.FIdentifier <> '') then
    begin
      if (AItem.FFactor = '') then
      begin
        ASection.Append('var');
        ASection.Add(Format('  %-10s : %s;', [AItem.FIdentifier, GetUnit(AItem.FQuantity)]));
        ASection.Append('');
        if (Pos('S', AItem.FPrefixes) > 0) or
           (Pos('L', AItem.FPrefixes) > 0) then
        begin
          ASection.Append('const');
          AddFactoredSymbols(AItem.FIdentifier, AItem.FBase, AItem.FFactor, AItem.FPrefixes, ASection);
          ASection.Append('');
        end;
      end else
        if (Pos('%s', AItem.FFactor) = 0) then
        begin
          ASection.Append('const');
          ASection.Add(Format('  %-10s : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: %s; FValue: %s); {$ELSE} (%s); {$ENDIF}', [AItem.FIdentifier, GetUnitIndex(AItem.FBase), AItem.FFactor, AItem.FFactor]));
          ASection.Append('');
          if (Pos('S', AItem.FPrefixes) > 0) or
             (Pos('L', AItem.FPrefixes) > 0) then
          begin
            ASection.Append('const');
            AddFactoredSymbols(AItem.FIdentifier, AItem.FBase, AItem.FFactor, AItem.FPrefixes, ASection);
            ASection.Append('');
          end;
        end else
          if (Pos('%s', AItem.FFactor) > 0) then
          begin
            ASection.Append('var');
            ASection.Add(Format('  %-10s : %s;', [AItem.FIdentifier, GetUnit(AItem.FQuantity)]));
            ASection.Append('');
            if (Pos('S', AItem.FPrefixes) > 0) or
               (Pos('L', AItem.FPrefixes) > 0) then
            begin
              ASection.Append('const');
              AddFactoredSymbols(AItem.FIdentifier, AItem.FBase, AItem.FFactor, AItem.FPrefixes, ASection);
              ASection.Append('');
            end;
          end;
     end;
end;

procedure TToolKitBuilder.AddFactoredSymbols(const AIdentifier, ABase, AFactor, APrefixes: string; const SectionA: TStringList);
var
  i, j: longint;
  Params: string;
  Power: longint;
  LocList: TStringList;
  Str: string;
  Factor: string;
begin
  Str := '  %-10s : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: %s; FValue: %s); {$ELSE} (%s); {$ENDIF}';

  Factor := '';
  if AFactor <> '' then
    Factor := AFactor + ' * ';

  if Length(APrefixes) = 24 then
  begin
    Params := APrefixes;
  end else
    Params := '------------------------';

  Power  := 1;
  if Pos('2', AIdentifier) > 0 then Power := 2;
  if Pos('3', AIdentifier) > 0 then Power := 3;
  if Pos('4', AIdentifier) > 0 then Power := 4;
  if Pos('5', AIdentifier) > 0 then Power := 5;
  if Pos('6', AIdentifier) > 0 then Power := 6;
  if Pos('7', AIdentifier) > 0 then Power := 7;
  if Pos('8', AIdentifier) > 0 then Power := 8;
  if Pos('9', AIdentifier) > 0 then Power := 9;

  LocList := TStringList.Create;
  if (LowerCase(AIdentifier) <> 'kg' ) and
     (LowerCase(AIdentifier) <> 'kg2') then
  begin
    if Params[ 1] = 'L' then LocList.Append(Format(Str, ['quetta' + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, +30*Power)), Factor + FormatFloat('0E+00', IntPower(10, +30*Power))]));
    if Params[ 1] = 'S' then LocList.Append(Format(Str, ['Q'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, +30*Power)), Factor + FormatFloat('0E+00', IntPower(10, +30*Power))]));
    if Params[ 2] = 'L' then LocList.Append(Format(Str, ['ronna'  + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, +27*Power)), Factor + FormatFloat('0E+00', IntPower(10, +27*Power))]));
    if Params[ 2] = 'S' then LocList.Append(Format(Str, ['R'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, +27*Power)), Factor + FormatFloat('0E+00', IntPower(10, +27*Power))]));
    if Params[ 3] = 'L' then LocList.Append(Format(Str, ['yotta'  + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, +24*Power)), Factor + FormatFloat('0E+00', IntPower(10, +24*Power))]));
    if Params[ 3] = 'S' then LocList.Append(Format(Str, ['Y'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, +24*Power)), Factor + FormatFloat('0E+00', IntPower(10, +24*Power))]));
    if Params[ 4] = 'L' then LocList.Append(Format(Str, ['zetta'  + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, +21*Power)), Factor + FormatFloat('0E+00', IntPower(10, +21*Power))]));
    if Params[ 4] = 'S' then LocList.Append(Format(Str, ['Z'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, +21*Power)), Factor + FormatFloat('0E+00', IntPower(10, +21*Power))]));
    if Params[ 5] = 'L' then LocList.Append(Format(Str, ['exa'    + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, +18*Power)), Factor + FormatFloat('0E+00', IntPower(10, +18*Power))]));
    if Params[ 5] = 'S' then LocList.Append(Format(Str, ['E'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, +18*Power)), Factor + FormatFloat('0E+00', IntPower(10, +18*Power))]));
    if Params[ 6] = 'L' then LocList.Append(Format(Str, ['peta'   + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, +15*Power)), Factor + FormatFloat('0E+00', IntPower(10, +15*Power))]));
    if Params[ 6] = 'S' then LocList.Append(Format(Str, ['P'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, +15*Power)), Factor + FormatFloat('0E+00', IntPower(10, +15*Power))]));

    if Params[ 7] = 'L' then LocList.Append(Format(Str, ['tera'   + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, +12*Power)), Factor + FormatFloat('0E+00', IntPower(10, +12*Power))]));
    if Params[ 7] = 'S' then LocList.Append(Format(Str, ['T'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, +12*Power)), Factor + FormatFloat('0E+00', IntPower(10, +12*Power))]));
    if Params[ 8] = 'L' then LocList.Append(Format(Str, ['giga'   + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, + 9*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 9*Power))]));
    if Params[ 8] = 'S' then LocList.Append(Format(Str, ['G'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, + 9*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 9*Power))]));
    if Params[ 9] = 'L' then LocList.Append(Format(Str, ['mega'   + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, + 6*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 6*Power))]));
    if Params[ 9] = 'S' then LocList.Append(Format(Str, ['M'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, + 6*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 6*Power))]));
    if Params[10] = 'L' then LocList.Append(Format(Str, ['kilo'   + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, + 3*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 3*Power))]));
    if Params[10] = 'S' then LocList.Append(Format(Str, ['k'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, + 3*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 3*Power))]));
    if Params[11] = 'L' then LocList.Append(Format(Str, ['hecto'  + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, + 2*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 2*Power))]));
    if Params[11] = 'S' then LocList.Append(Format(Str, ['h'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, + 2*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 2*Power))]));
    if Params[12] = 'L' then LocList.Append(Format(Str, ['deca'   + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, + 1*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 1*Power))]));
    if Params[12] = 'S' then LocList.Append(Format(Str, ['da'     + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, + 1*Power)), Factor + FormatFloat('0E+00', IntPower(10, + 1*Power))]));
    if Params[13] = 'L' then LocList.Append(Format(Str, ['deci'   + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, - 1*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 1*Power))]));
    if Params[13] = 'S' then LocList.Append(Format(Str, ['d'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, - 1*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 1*Power))]));
    if Params[14] = 'L' then LocList.Append(Format(Str, ['centi'  + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, - 2*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 2*Power))]));
    if Params[14] = 'S' then LocList.Append(Format(Str, ['c'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, - 2*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 2*Power))]));
    if Params[15] = 'L' then LocList.Append(Format(Str, ['milli'  + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, - 3*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 3*Power))]));
    if Params[15] = 'S' then LocList.Append(Format(Str, ['m'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, - 3*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 3*Power))]));
    if Params[16] = 'L' then LocList.Append(Format(Str, ['micro'  + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, - 6*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 6*Power))]));
    if Params[16] = 'S' then LocList.Append(Format(Str, ['mi'     + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, - 6*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 6*Power))]));
    if Params[17] = 'L' then LocList.Append(Format(Str, ['nano'   + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, - 9*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 9*Power))]));
    if Params[17] = 'S' then LocList.Append(Format(Str, ['n'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, - 9*Power)), Factor + FormatFloat('0E+00', IntPower(10, - 9*Power))]));
    if Params[18] = 'L' then LocList.Append(Format(Str, ['pico'   + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, -12*Power)), Factor + FormatFloat('0E+00', IntPower(10, -12*Power))]));
    if Params[18] = 'S' then LocList.Append(Format(Str, ['p'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, -12*Power)), Factor + FormatFloat('0E+00', IntPower(10, -12*Power))]));

    if Params[19] = 'L' then LocList.Append(Format(Str, ['femto'  + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, -15*Power)), Factor + FormatFloat('0E+00', IntPower(10, -15*Power))]));
    if Params[19] = 'S' then LocList.Append(Format(Str, ['f'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, -15*Power)), Factor + FormatFloat('0E+00', IntPower(10, -15*Power))]));
    if Params[20] = 'L' then LocList.Append(Format(Str, ['atto'   + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, -18*Power)), Factor + FormatFloat('0E+00', IntPower(10, -18*Power))]));
    if Params[20] = 'S' then LocList.Append(Format(Str, ['a'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, -18*Power)), Factor + FormatFloat('0E+00', IntPower(10, -18*Power))]));
    if Params[21] = 'L' then LocList.Append(Format(Str, ['zepto'  + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, -21*Power)), Factor + FormatFloat('0E+00', IntPower(10, -21*Power))]));
    if Params[21] = 'S' then LocList.Append(Format(Str, ['z'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, -21*Power)), Factor + FormatFloat('0E+00', IntPower(10, -21*Power))]));
    if Params[22] = 'L' then LocList.Append(Format(Str, ['yocto'  + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, -24*Power)), Factor + FormatFloat('0E+00', IntPower(10, -24*Power))]));
    if Params[22] = 'S' then LocList.Append(Format(Str, ['y'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, -24*Power)), Factor + FormatFloat('0E+00', IntPower(10, -24*Power))]));
    if Params[23] = 'L' then LocList.Append(Format(Str, ['ronto'  + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, -27*Power)), Factor + FormatFloat('0E+00', IntPower(10, -27*Power))]));
    if Params[23] = 'S' then LocList.Append(Format(Str, ['r'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, -27*Power)), Factor + FormatFloat('0E+00', IntPower(10, -27*Power))]));
    if Params[24] = 'L' then LocList.Append(Format(Str, ['quecto' + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, -30*Power)), Factor + FormatFloat('0E+00', IntPower(10, -30*Power))]));
    if Params[24] = 'S' then LocList.Append(Format(Str, ['q'      + AIdentifier, GetUnitIndex(ABase), Factor + FormatFloat('0E+00', IntPower(10, -30*Power)), Factor + FormatFloat('0E+00', IntPower(10, -30*Power))]));
  end else
    if (LowerCase(AIdentifier) = 'kg') then
    begin
      LocList.Append(Format(Str, ['hg'  , GetUnitIndex(ABase), '1E-01']));
      LocList.Append(Format(Str, ['dag' , GetUnitIndex(ABase), '1E-02']));
      LocList.Append(Format(Str, ['g'   , GetUnitIndex(ABase), '1E-03']));
      LocList.Append(Format(Str, ['dg'  , GetUnitIndex(ABase), '1E-04']));
      LocList.Append(Format(Str, ['cg'  , GetUnitIndex(ABase), '1E-05']));
      LocList.Append(Format(Str, ['mg'  , GetUnitIndex(ABase), '1E-06']));
      LocList.Append(Format(Str, ['mig' , GetUnitIndex(ABase), '1E-09']));
      LocList.Append(Format(Str, ['ng'  , GetUnitIndex(ABase), '1E-12']));
      LocList.Append(Format(Str, ['pg'  , GetUnitIndex(ABase), '1E-15']));
    end else
      if (LowerCase(AIdentifier) = 'kg2') then
      begin
        LocList.Append(Format(Str, ['hg2'  , GetUnitIndex(ABase), '1E-02']));
        LocList.Append(Format(Str, ['dag2' , GetUnitIndex(ABase), '1E-04']));
        LocList.Append(Format(Str, ['g2'   , GetUnitIndex(ABase), '1E-06']));
        LocList.Append(Format(Str, ['dg2'  , GetUnitIndex(ABase), '1E-08']));
        LocList.Append(Format(Str, ['cg2'  , GetUnitIndex(ABase), '1E-10']));
        LocList.Append(Format(Str, ['mg2'  , GetUnitIndex(ABase), '1E-12']));
        LocList.Append(Format(Str, ['mig2' , GetUnitIndex(ABase), '1E-18']));
        LocList.Append(Format(Str, ['ng2'  , GetUnitIndex(ABase), '1E-24']));
        LocList.Append(Format(Str, ['pg2'  , GetUnitIndex(ABase), '1E-30']));
      end;

  j := 0;
  for i := 0 to LocList.Count -1 do j := Max(j, Length(LocList[i]));
  for i := 0 to LocList.Count -1 do
  begin
    while Length(LocList[i]) < j do
      LocList[i] := ' ' + LocList[i];
    SectionA.Append(LocList[i]);
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
  Section.Add(Format('  PowerTable: = array[0..%d] of', [BaseUnitCount]));
  Section.Add(Format('    record  Square, Cubic, Quartic, Quintic, Sextic: longint; end = (', []));

  for i := 0 to FList.Count -1 do
  begin
    D1 := GetDimensions(FList[i].FDimension);

    for j := Low(D1) to High(D1) do D2[j] := 2 * D1[j];
    for j := Low(D1) to High(D1) do D3[j] := 3 * D1[j];
    for j := Low(D1) to High(D1) do D4[j] := 4 * D1[j];
    for j := Low(D1) to High(D1) do D5[j] := 5 * D1[j];
    for j := Low(D1) to High(D1) do D6[j] := 6 * D1[j];

    S := Format('    (Square: %d; Cubic: %d; Quartic: %d; Quintic: %d; Sextic: %d),',
      [FList.Search(D2), FList.Search(D3), FList.Search(D4), FList.Search(D5), FList.Search(D6)]);

    if i = FList.Count -1 then
    begin
      SetLength(S, Length(S) -1);
    end;
    Section.Add(S);
  end;

  Section.Add(Format('  );', []));
  Section.Add(Format('', []));
end;

procedure TToolKitBuilder.AddRootTable(const Section: TStringList);
var
  i, j, k: longint;
  Exponent: longint;
  D1, D2: TExponents;
begin
  for i := 0 to FList.Count -1 do

  begin
    D1 := GetDimensions(FList[i].FDimension);

    for Exponent := 2 to 10 do
    begin
      for j := Low(D1) to High(D1) do D2[j] := Exponent * D1[j];

      k := FList.Search(D2);
      if k <> -1 then
      begin
      end;

    end;

  end;
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

  SectionA2.Append('');
  SectionA2.Append('');
  SectionA2.Append('');
  SectionA2.Append('');

  SectionA2.Append('type');
  SectionA2.Append('  { Prefix }');
  SectionA2.Append('');
  SectionA2.Append('  TPrefix = (pQuetta, pRonna, pYotta, pZetta, pExa, pPeta, pTera, pGiga, pMega, pKilo, pHecto, pDeca, ');
  SectionA2.Append('    pNone, pDeci, pCenti, pMilli, pMicro, pNano, pPico, pFemto, pAtto, pZepto, pYocto, pRonto, pQuecto); ');
  SectionA2.Append('');
  SectionA2.Append('  { Prefixes }');
  SectionA2.Append('');
  SectionA2.Append('  TPrefixes = array of TPrefix;');
  SectionA2.Append('');
  SectionA2.Append('  { Exponents }');
  SectionA2.Append('');
  SectionA2.Append('  TExponents = array of longint;');
  SectionA2.Append('');

  SectionA2.Append('type');
  SectionA2.Append('{ TQuantity }');
  SectionA2.Append('');
  SectionA2.Append('type');
  SectionA2.Append('  {$IFOPT D+}');
  SectionA2.Append('  TQuantity = record');
  SectionA2.Append('  private');
  SectionA2.Append('    FUnitOfMeasurement: longint;');
  SectionA2.Append('    FValue: double;');
  SectionA2.Append('  public');
  SectionA2.Append('    class operator +(const ALeft, ARight: TQuantity): TQuantity; inline;');
  SectionA2.Append('    class operator -(const ALeft, ARight: TQuantity): TQuantity; inline;');
  SectionA2.Append('    class operator *(const ALeft, ARight: TQuantity): TQuantity; inline;');
  SectionA2.Append('    class operator /(const ALeft, ARight: TQuantity): TQuantity; inline;');
  SectionA2.Append('    class operator *(const ALeft: double; const ARight: TQuantity): TQuantity; inline;');
  SectionA2.Append('    class operator *(const ALeft: TQuantity; const ARight: double): TQuantity; inline;');
  SectionA2.Append('    class operator /(const ALeft: TQuantity; const ARight: double): TQuantity; inline;');
  SectionA2.Append('  end;');
  SectionA2.Append('  {$ELSE}');
  SectionA2.Append('  TQuantity = double;');
  SectionA2.Append('  {$ENDIF}');
  SectionA2.Append('');

  AddBaseUnits(SectionA3, SectionB3);

  SectionA3.Append('const');
  SectionA3.Append('  AvogadroConstant               : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cReciprocalMole;                     FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}');
  SectionA3.Append('  BohrMagneton                   : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cSquareMeterAmpere;                  FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}');
  SectionA3.Append('  BohrRadius                     : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cMeter;                              FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}');
  SectionA3.Append('  BoltzmannConstant              : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cJoulePerKelvin;                     FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}');
  SectionA3.Append('  ComptonWaveLength              : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cMeter;                              FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}');
  SectionA3.Append('  CoulombConstant                : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cNewtonSquareMeterPerSquareCoulomb;  FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}');
  SectionA3.Append('  DeuteronMass                   : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cKilogram;                           FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}');
  SectionA3.Append('  ElectricPermittivity           : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cFaradPerMeter;                      FValue:     8.8541878128E-12); {$ELSE} (    8.8541878128E-12); {$ENDIF}');
  SectionA3.Append('  ElectronMass                   : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cKilogram;                           FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}');
  SectionA3.Append('  ElectronCharge                 : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cCoulomb;                            FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}');
  SectionA3.Append('  MagneticPermeability           : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cHenryPerMeter;                      FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}');
  SectionA3.Append('  MolarGasConstant               : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cJoulePerMolePerKelvin;              FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}');
  SectionA3.Append('  NeutronMass                    : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cKilogram;                           FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}');
  SectionA3.Append('  NewtonianConstantOfGravitation : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cNewtonSquareMeterPerSquareKilogram; FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}');
  SectionA3.Append('  PlanckConstant                 : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cKilogramSquareMeterPerSecond;       FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}');
  SectionA3.Append('  ProtonMass                     : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cKilogram;                           FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}');
  SectionA3.Append('  RydbergConstant                : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cReciprocalMeter;                    FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}');
  SectionA3.Append('  SpeedOfLight                   : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cMeterPerSecond;                     FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}');
  SectionA3.Append('  SquaredSpeedOfLight            : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cSquareMeterPerSquareSecond;         FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}');
  SectionA3.Append('  StandardAccelerationOfGravity  : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cMeterPerSquareSecond;               FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}');
  SectionA3.Append('  ReducedPlanckConstant          : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cKilogramSquareMeterPerSecond;       FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}');
  SectionA3.Append('  UnifiedAtomicMassUnit          : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cKilogram;                           FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}');
  SectionA3.Append('');

  SectionA3.Append('const');
  SectionA3.Append('  PrefixTable: array[pQuetta..pQuecto] of');
  SectionA3.Append('    record  Symbol, Name: string; Exponent: longint end = (');
  SectionA3.Append('    (Symbol: ''Q'';   Name: ''quetta'';  Exponent: +30),');
  SectionA3.Append('    (Symbol: ''R'';   Name: ''ronna'';   Exponent: +27),');
  SectionA3.Append('    (Symbol: ''Y'';   Name: ''yotta'';   Exponent: +24),');
  SectionA3.Append('    (Symbol: ''Z'';   Name: ''zetta'';   Exponent: +21),');
  SectionA3.Append('    (Symbol: ''E'';   Name: ''exa'';     Exponent: +18),');
  SectionA3.Append('    (Symbol: ''P'';   Name: ''peta'';    Exponent: +15),');
  SectionA3.Append('    (Symbol: ''T'';   Name: ''tera'';    Exponent: +12),');
  SectionA3.Append('    (Symbol: ''G'';   Name: ''giga'';    Exponent: +09),');
  SectionA3.Append('    (Symbol: ''M'';   Name: ''mega'';    Exponent: +06),');
  SectionA3.Append('    (Symbol: ''k'';   Name: ''kilo'';    Exponent: +03),');
  SectionA3.Append('    (Symbol: ''h'';   Name: ''hecto'';   Exponent: +02),');
  SectionA3.Append('    (Symbol: ''da'';  Name: ''deca'';    Exponent: +01),');
  SectionA3.Append('    (Symbol: '''';    Name: '''';        Exponent:  00),');
  SectionA3.Append('    (Symbol: ''d'';   Name: ''deci'';    Exponent: -01),');
  SectionA3.Append('    (Symbol: ''c'';   Name: ''centi'';   Exponent: -02),');
  SectionA3.Append('    (Symbol: ''m'';   Name: ''milli'';   Exponent: -03),');
  SectionA3.Append('    (Symbol: ''μ'';   Name: ''micro'';   Exponent: -06),');
  SectionA3.Append('    (Symbol: ''n'';   Name: ''nano'';    Exponent: -09),');
  SectionA3.Append('    (Symbol: ''p'';   Name: ''pico'';    Exponent: -12),');
  SectionA3.Append('    (Symbol: ''f'';   Name: ''femto'';   Exponent: -15),');
  SectionA3.Append('    (Symbol: ''a'';   Name: ''atto'';    Exponent: -18),');
  SectionA3.Append('    (Symbol: ''z'';   Name: ''zepto'';   Exponent: -21),');
  SectionA3.Append('    (Symbol: ''y'';   Name: ''yocto'';   Exponent: -24),');
  SectionA3.Append('    (Symbol: ''r'';   Name: ''ronto'';   Exponent: -27),');
  SectionA3.Append('    (Symbol: ''q'';   Name: ''quecto'';  Exponent: -30)');
  SectionA3.Append('  );');
  SectionA3.Append('');


  SectionB2.Append('implementation');
  SectionB2.Append('');
  SectionB2.Append('uses');
  SectionB2.Append('  Math;');
  SectionB2.Append('');

  for i := 0 to FList.Count -1 do
  begin
    if FList[i].FBase = '' then
    begin
      Inc(BaseUnitCount);
    end else
    begin
      Inc(FactoredUnitCount);
    end;
    FList[i].FExponents := GetDimensions(FList[i].FDimension);
    FList[i].FReserved  := i;
  end;

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
            Line := Line + K.ToString + ', '
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
            Line := Line + K.ToString + ', '
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


  SectionB2.Append('function GetSymbol(const ASymbol: string; const Prefixes: TPrefixes): string;');
  SectionB2.Append('var');
  SectionB2.Append('  PrefixCount: longint;');
  SectionB2.Append('begin');
  SectionB2.Append('  PrefixCount := Length(Prefixes);');
  SectionB2.Append('  case PrefixCount of');
  SectionB2.Append('    0:  result := ASymbol;');
  SectionB2.Append('    1:  result := Format(ASymbol, [PrefixTable[Prefixes[0]].Symbol]);');
  SectionB2.Append('    2:  result := Format(ASymbol, [PrefixTable[Prefixes[0]].Symbol, PrefixTable[Prefixes[1]].Symbol]);  ');
  SectionB2.Append('    3:  result := Format(ASymbol, [PrefixTable[Prefixes[0]].Symbol, PrefixTable[Prefixes[1]].Symbol, PrefixTable[Prefixes[2]].Symbol]);');
  SectionB2.Append('  else raise Exception.Create(''Wrong number of prefixes.''); ');
  SectionB2.Append('  end;');
  SectionB2.Append('end;');
  SectionB2.Append('');

  SectionB2.Append('function GetName(const AName: string; const Prefixes: TPrefixes): string;');
  SectionB2.Append('var');
  SectionB2.Append('  PrefixCount: longint;');
  SectionB2.Append('begin');
  SectionB2.Append('  PrefixCount := Length(Prefixes);');
  SectionB2.Append('  case PrefixCount of');
  SectionB2.Append('    0:  result := AName;');
  SectionB2.Append('    1:  result := Format(AName, [PrefixTable[Prefixes[0]].Name]);');
  SectionB2.Append('    2:  result := Format(AName, [PrefixTable[Prefixes[0]].Name, PrefixTable[Prefixes[1]].Name]); ');
  SectionB2.Append('    3:  result := Format(AName, [PrefixTable[Prefixes[0]].Name, PrefixTable[Prefixes[1]].Name, PrefixTable[Prefixes[2]].Name]);');
  SectionB2.Append('  else raise Exception.Create(''Wrong number of prefixes.'');');
  SectionB2.Append('  end;');
  SectionB2.Append('end;');
  SectionB2.Append('');


  SectionB2.Append('function GetValue(const AValue: double; const APrefixes, ABasePrefixes: TPrefixes; const AExponents, ABaseExponents: TExponents): double;');
  SectionB2.Append('var');
  SectionB2.Append('  I: longint;');
  SectionB2.Append('  Exponent: longint;');
  SectionB2.Append('  PrefixCount: longint;');
  SectionB2.Append('begin');
  SectionB2.Append('  PrefixCount := Length(APrefixes);');
  SectionB2.Append('  if PrefixCount = Length(ABasePrefixes) then');
  SectionB2.Append('  begin');
  SectionB2.Append('    Exponent := 0;');
  SectionB2.Append('    for I := 0 to PrefixCount -1 do');
  SectionB2.Append('      Inc(Exponent, PrefixTable[ABasePrefixes[I]].Exponent * ABaseExponents[I]);');
  SectionB2.Append('');
  SectionB2.Append('    for I := 0 to PrefixCount -1 do');
  SectionB2.Append('      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * ABaseExponents[I]);');
  SectionB2.Append('');
  SectionB2.Append('    if Exponent <> 0 then');
  SectionB2.Append('      result := AValue * IntPower(10, Exponent)');
  SectionB2.Append('    else');
  SectionB2.Append('      result := AValue;');
  SectionB2.Append('  end else');
  SectionB2.Append('    if PrefixCount = 0 then');
  SectionB2.Append('      result := AValue');
  SectionB2.Append('    else');
  SectionB2.Append('      raise Exception.Create(''Wrong number of prefixes.'');');
  SectionB2.Append('end;');
  SectionB2.Append('');



  SectionB2.Append('{$IFOPT D+}');
  SectionB2.Append('class operator TQuantity.+(const ALeft, ARight: TQuantity): TQuantity;');
  SectionB2.Append('begin');
  SectionB2.Append('  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then');
  SectionB2.Append('    raise Exception.Create(''Summing operator (+) has detected wrong unit of measurements.'');');
  SectionB2.Append('  result.FValue := ALeft.FValue + ARight.FValue;');
  SectionB2.Append('end;');
  SectionB2.Append('');
  SectionB2.Append('class operator TQuantity.-(const ALeft, ARight: TQuantity): TQuantity;');
  SectionB2.Append('begin');
  SectionB2.Append('  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then');
  SectionB2.Append('    raise Exception.Create(''Subtracting operator (-) has detected wrong unit of measurements.'');');
  SectionB2.Append('  result.FValue := ALeft.FValue - ARight.FValue;');
  SectionB2.Append('end;');
  SectionB2.Append('');
  SectionB2.Append('class operator TQuantity.*(const ALeft, ARight: TQuantity): TQuantity;');
  SectionB2.Append('begin');
  SectionB2.Append('  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];');
  SectionB2.Append('  result.FValue := ALeft.FValue * ARight.FValue;');
  SectionB2.Append('end;');
  SectionB2.Append('');
  SectionB2.Append('class operator TQuantity./(const ALeft, ARight: TQuantity): TQuantity;');
  SectionB2.Append('begin');
  SectionB2.Append('  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];');
  SectionB2.Append('  result.FValue := ALeft.FValue / ARight.FValue;');
  SectionB2.Append('end;');
  SectionB2.Append('');
  SectionB2.Append('class operator TQuantity.*(const ALeft: double; const ARight: TQuantity): TQuantity;');
  SectionB2.Append('begin');
  SectionB2.Append('  result.FUnitOfMeasurement := ARight.FUnitOfMeasurement;');
  SectionB2.Append('  result.FValue:= ALeft * ARight.FValue;');
  SectionB2.Append('end;');
  SectionB2.Append('');
  SectionB2.Append('class operator TQuantity.*(const ALeft: TQuantity; const ARight: double): TQuantity;');
  SectionB2.Append('begin');
  SectionB2.Append('  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;');
  SectionB2.Append('  result.FValue:= ALeft.FValue * ARight;');
  SectionB2.Append('end;');
  SectionB2.Append('');
  SectionB2.Append('class operator TQuantity./(const ALeft: TQuantity; const ARight: double): TQuantity;');
  SectionB2.Append('begin');
  SectionB2.Append('  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;');
  SectionB2.Append('  result.FValue:= ALeft.FValue / ARight;');
  SectionB2.Append('end;');
  SectionB2.Append('{$ENDIF}');
  SectionB2.Append('');







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
    if (FList[i].FBase = '') then
    begin
      // %sToString
      SectionA8.Add(Format('function %sToString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('{$IFOPT D+}',[]));
      SectionB8.Add(Format('  if AValue.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FQuantity)]));
      SectionB8.Add(Format('    raise Exception.Create(''Wrong units of measurements'');', []));
      SectionB8.Add(Format('  result := FloatToStr(AValue.FValue) + '' '' + GetSymbol(%s, %s);', [GetSymbolResourceString(FList[i].FQuantity), GetPrefixesConst(FList[i].FQuantity)]));
      SectionB8.Add(Format('{$ELSE}', []));
      SectionB8.Add(Format('  result := FloatToStr(AValue) + '' '' + GetSymbol(%s, %s);', [GetSymbolResourceString(FList[i].FQuantity), GetPrefixesConst(FList[i].FQuantity)]));
      SectionB8.Add(Format('{$ENDIF}', []));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));

      SectionA8.Add(Format('function %sToString(const AValue: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToString(const AValue: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('var',[]));
      SectionB8.Add(Format('  FactoredValue: double;',[]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('{$IFOPT D+}',[]));
      SectionB8.Add(Format('  if AValue.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FQuantity)]));
      SectionB8.Add(Format('    raise Exception.Create(''Wrong units of measurements'');', []));
      SectionB8.Add(Format('  FactoredValue := GetValue(AValue.FValue, APrefixes, %s, %s, %s);', [GetPrefixesConst(FList[i].FQuantity), GetExponentsConst(FList[i].FQuantity), GetExponentsConst(FList[i].FQuantity)]));
      SectionB8.Add(Format('{$ELSE}', []));
      SectionB8.Add(Format('  FactoredValue := GetValue(AValue, APrefixes, %s, %s, %s);', [GetPrefixesConst(FList[i].FQuantity), GetExponentsConst(FList[i].FQuantity), GetExponentsConst(FList[i].FQuantity)]));
      SectionB8.Add(Format('{$ENDIF}', []));
      SectionB8.Add(Format('  if Length(APrefixes) = 0 then', []));
      SectionB8.Add(Format('    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + '' '' + GetSymbol(%s, %s)', [GetSymbolResourceString(FList[i].FQuantity), GetPrefixesConst(FList[i].FQuantity)]));
      SectionB8.Add(Format('  else', []));
      SectionB8.Add(Format('    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + '' '' + GetSymbol(%s, APrefixes);', [GetSymbolResourceString(FList[i].FQuantity)]));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));

      // %sToVerboseString
      SectionA8.Add(Format('function %sToVerboseString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToVerboseString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('{$IFOPT D+}',[]));
      SectionB8.Add(Format('  if AValue.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FQuantity)]));
      SectionB8.Add(Format('    raise Exception.Create(''Wrong units of measurements'');', []));
      SectionB8.Add(Format('{$ENDIF}', []));
      SectionB8.Add(Format('  result := '''';', []));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));

      SectionA8.Add(Format('function %sToVerboseString(const AValue: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToVerboseString(const AValue: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('{$IFOPT D+}',[]));
      SectionB8.Add(Format('  if AValue.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FQuantity)]));
      SectionB8.Add(Format('    raise Exception.Create(''Wrong units of measurements'');', []));
      SectionB8.Add(Format('{$ENDIF}', []));
      SectionB8.Add(Format('  result := '''';', []));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));

      SectionA8.Add(Format('function %sToFloat(const AValue: TQuantity): double;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToFloat(const AValue: TQuantity): double;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('{$IFOPT D+}',[]));
      SectionB8.Add(Format('  if AValue.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FQuantity)]));
      SectionB8.Add(Format('    raise Exception.Create(''Wrong units of measurements'');', []));
      SectionB8.Add(Format('{$ENDIF}', []));
      SectionB8.Add(Format('  result := 0;', []));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));
    end else
    begin
      // %sToString
      SectionA8.Add(Format('function %sToString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('{$IFOPT D+}',[]));
      SectionB8.Add(Format('  if AValue.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FBase)]));
      SectionB8.Add(Format('    raise Exception.Create(''Wrong units of measurements'');', []));
      SectionB8.Add(Format('{$ENDIF}', []));
      SectionB8.Add(Format('  result := '''';', []));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));

      SectionA8.Add(Format('function %sToString(const AValue: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToString(const AValue: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('var',[]));
      SectionB8.Add(Format('  FactoredValue: double;',[]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('{$IFOPT D+}',[]));
      SectionB8.Add(Format('  if AValue.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FBase)]));
      SectionB8.Add(Format('    raise Exception.Create(''Wrong units of measurements'');', []));
      SectionB8.Add(Format('  FactoredValue := GetValue(AValue.FValue, APrefixes, %s, %s, %s);', [GetPrefixesConst(FList[i].FQuantity), GetExponentsConst(FList[i].FQuantity), GetExponentsConst(FList[i].FQuantity)]));
      SectionB8.Add(Format('{$ELSE}', []));
      SectionB8.Add(Format('  FactoredValue := GetValue(AValue, APrefixes, %s, %s, %s);', [GetPrefixesConst(FList[i].FQuantity), GetExponentsConst(FList[i].FQuantity), GetExponentsConst(FList[i].FQuantity)]));
      SectionB8.Add(Format('{$ENDIF}', []));
      SectionB8.Add(Format('  if Length(APrefixes) = 0 then', []));
      SectionB8.Add(Format('    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + '' '' + GetSymbol(%s, %s)', [GetSymbolResourceString(FList[i].FQuantity), GetPrefixesConst(FList[i].FQuantity)]));
      SectionB8.Add(Format('  else', []));
      SectionB8.Add(Format('    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + '' '' + GetSymbol(%s, APrefixes);', [GetSymbolResourceString(FList[i].FQuantity)]));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));

      // %sToVerboseString
      SectionA8.Add(Format('function %sToVerboseString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToVerboseString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('{$IFOPT D+}',[]));
      SectionB8.Add(Format('  if AValue.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FBase)]));
      SectionB8.Add(Format('    raise Exception.Create(''Wrong units of measurements'');', []));
      SectionB8.Add(Format('{$ENDIF}', []));
      SectionB8.Add(Format('  result := '''';', []));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));

      SectionA8.Add(Format('function %sToVerboseString(const AValue: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToVerboseString(const AValue: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('{$IFOPT D+}',[]));
      SectionB8.Add(Format('  if AValue.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FBase)]));
      SectionB8.Add(Format('    raise Exception.Create(''Wrong units of measurements'');', []));
      SectionB8.Add(Format('{$ENDIF}', []));
      SectionB8.Add(Format('  result := '''';', []));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));

      SectionA8.Add(Format('function %sToFloat(const AValue: TQuantity): double;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToFloat(const AValue: TQuantity): double;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('{$IFOPT D+}',[]));
      SectionB8.Add(Format('  if AValue.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FBase)]));
      SectionB8.Add(Format('    raise Exception.Create(''Wrong units of measurements'');', []));
      SectionB8.Add(Format('{$ENDIF}', []));
      SectionB8.Add(Format('  result := 0;', []));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));
    end;
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
      if (Item.FExponents[1] = ADim[1]) and
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

