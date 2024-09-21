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
    FIndex: longint;
    FExponents: TExponents;
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

procedure TToolKitBuilder.Add(const AItem: TToolkitItem);
begin
  FList.Add(AItem);
end;

procedure TToolKitBuilder.Run;
var
  I, J, K: longint;
  Line: string;
  Stream: TResourceStream;
  S: string;
  Table: array of array of longint;
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

  SectionA2.Append('');
  SectionA2.Append('{ TQuantity }');
  SectionA2.Append('');
  SectionA2.Append('type');
  SectionA2.Append('  {$IFOPT D+}');
  SectionA2.Append('  TQuantity = record');
  SectionA2.Append('  private');
  SectionA2.Append('    FUnitOfMeasurement: longint;');
  SectionA2.Append('    FValue: double;');
  SectionA2.Append('  public');
  SectionA2.Append('    class operator Copy(constref ASrc: TQuantity; var ADst: TQuantity); inline;');
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

  SectionB2.Append('');
  SectionB2.Append('implementation');
  SectionB2.Append('');
  SectionB2.Append('const');
  SectionB2.Append(Format('  %-50s = %d;', ['uScalar', BaseUnitCount]));
  for i := 0 to FList.Count -1 do
  begin
    if FList[i].FBase = '' then
    begin
      Inc(BaseUnitCount);
      FList[i].FIndex := BaseUnitCount;
      FList[i].FExponents := GetDimensions(FList[i].FDimension);
      SectionB2.Append(Format('  %-50s = %d;', [GetUnitIndex(FList[i].FQuantity) , FList[i].FIndex]));
    end else
      Inc(FactoredUnitCount);
  end;


  SectionB2.Append('const');
  SectionB2.Append('');
  SectionB2.Append('  { Mul Table }');
  SectionB2.Append('');
  SectionB2.Append(Format('  MulTable : array[0..%d, 0..%d] of longint = (', [BaseUnitCount, BaseUnitCount]));

  Table := nil;
  SetLength(Table, BaseUnitCount);
  for i := Low(Table) to High(Table) do
    SetLength(Table[i], BaseUnitCount);

  for i := 0 to FList.Count -1 do
  begin
    if (FList[i].FBase = '') then
    begin
      Line := '    (';
      for j := 0 to FList.Count -1 do
      begin
        if (FList[j].FBase = '') then
        begin
          Line := Line +  IntToStr(FList.Search(SumDim(FList[i].FExponents, FList[j].FExponents))) + ', ';
        end;
      end;
      Line[High(Line) -1] := ')';
      Line[High(Line)   ] := ',';
      SectionB2.Append(Line);
    end;
  end;
  SectionB2.Append('    );');












































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
  SectionB2.Append('class operator TQuantity.Copy(constref ASrc: TQuantity; var ADst: TQuantity);');
  SectionB2.Append('begin');
  SectionB2.Append('  if ASrc.FUnitOfMeasurement <> ADst.FUnitOfMeasurement then');
  SectionB2.Append('    raise Exception.Create(''Assignment operator (:=) has detected wrong unit of measurements.'');');
  SectionB2.Append('  ADst.FValue := ASrc.FValue;');
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


  SectionA3.Append('');
  SectionA3.Append('{ Base units }');
  SectionA3.Append('');
  SectionA3.Append('type');

  SectionB3.Append('');
  SectionB3.Append('{ Base units }');
  SectionB3.Append('');
  for i := 0 to FList.Count -1 do
  begin
    if (FList[i].FIdentifier <> '') and (FList[i].FBase = '') then
    begin
      SectionA3.Add(Format('  %s = record', [GetUnit(FList[i].FQuantity)]));
      SectionA3.Add(Format('    class operator *(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
      SectionA3.Add(Format('    class operator *(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
      SectionA3.Add(Format('  end;',[]));
      SectionA3.Add(Format('',[]));

      SectionB3.Add(Format('class operator %s.*(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
      SectionB3.Add(Format('begin',[]));
      SectionB3.Add(Format('  {$IFOPT D+}',[]));
      SectionB3.Add(Format('  result.FUnitOfMeasurement := %s;',[GetUnitIndex(FList[i].FQuantity)]));
      SectionB3.Add(Format('  result.FValue := AValue',[]));
      SectionB3.Add(Format('  {$ELSE}',[]));
      SectionB3.Add(Format('  result := AValue',[]));
      SectionB3.Add(Format('  {$ENDIF}',[]));
      SectionB3.Add(Format('end;',[]));
      SectionB3.Add(Format('',[]));

      SectionB3.Add(Format('class operator %s.*(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
      SectionB3.Add(Format('begin',[]));
      SectionB3.Add(Format('  {$IFOPT D+}',[]));
      SectionB3.Add(Format('  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, %s];',[GetUnitIndex(FList[i].FQuantity)]));
      SectionB3.Add(Format('  result.FValue := AValue.FValue',[]));
      SectionB3.Add(Format('  {$ELSE}',[]));
      SectionB3.Add(Format('  result := AValue',[]));
      SectionB3.Add(Format('  {$ENDIF}',[]));
      SectionB3.Add(Format('end;',[]));
      SectionB3.Add(Format('',[]));
    end;
  end;
  SectionA3.Append('');
  SectionA3.Append('{ Factored units }');
  SectionA3.Append('');
  SectionA3.Append('type');

  SectionB3.Append('');
  SectionB3.Append('{ Factored units }');
  SectionB3.Append('');
  for i := 0 to FList.Count -1 do
  begin
    if (FList[i].FIdentifier <> '') and (FList[i].FBase <> '') then
    begin

      SectionA3.Add(Format('  %s = record', [GetUnit(FList[i].FQuantity)]));
      SectionA3.Add(Format('    class operator *(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
      SectionA3.Add(Format('    class operator *(const AValue: TQuantity; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity)]));
      SectionA3.Add(Format('  end;',[]));
      SectionA3.Add(Format('',[]));



      SectionB3.Add(Format('class operator %s.*(const AValue: double; const ASelf: %s): TQuantity; inline;', [GetUnit(FList[i].FQuantity), GetUnit(FList[i].FQuantity)]));
      SectionB3.Add(Format('begin',[]));
      SectionB3.Add(Format('  {$IFOPT D+}',[]));
      SectionB3.Add(Format('  result.FUnitOfMeasurement := %s;',[GetUnitIndex(FList[i].FBase)]));

      if Pos('%s', FList[i].FFactor) <> 0 then
        SectionB3.Add(Format('  result.FValue := %s;',[Format(Copy(FList[i].FFactor, 1, Pos('|', FList[i].FFactor) -1), ['AValue'])]))
      else
        if (FList[i].FFactor <> '') then
          SectionB3.Add(Format('  result.FValue := AValue * %s;', [FList[i].FFactor]))
        else
          SectionB3.Add(Format('  result.FValue := AValue;', []));

      SectionB3.Add(Format('  {$ELSE}',[]));

      if Pos('%s', FList[i].FFactor) <> 0 then
        SectionB3.Add(Format('  result := %s;',[Format(Copy(FList[i].FFactor, 1, Pos('|', FList[i].FFactor) -1), ['AValue'])]))
      else
        if (FList[i].FFactor <> '') then
          SectionB3.Add(Format('  result := AValue * %s;', [FList[i].FFactor]))
        else
          SectionB3.Add(Format('  result := AValue;', []));

      SectionB3.Add(Format('  {$ENDIF}',[]));

      SectionB3.Add(Format('end;',[]));
      SectionB3.Add(Format('',[]));

    end;
  end;

  SectionA3.Append('');
  SectionA3.Append('var');
  for i := 0 to FList.Count -1 do
  begin
    if (FList[i].FIdentifier <> '') and (FList[i].FBase = '') then
    begin
      SectionA3.Add(Format('  %-10s : %s;', [FList[i].FIdentifier, GetUnit(FList[i].FQuantity)]));
    end;
  end;
  SectionA3.Append('');
  SectionA3.Append('var');
  for i := 0 to FList.Count -1 do
  begin
    if (FList[i].FIdentifier <> '') and (FList[i].FBase <> '') then
    begin
      SectionA3.Add(Format('  %-10s : %s;', [FList[i].FIdentifier, GetUnit(FList[i].FQuantity)]));
    end;
  end;
  SectionA3.Append('');



  SectionB3.Append('{ TUnit classes }');
  SectionB3.Append('');



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
      SectionA8.Add(Format('function %sToString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('  {$IFOPT D+}',[]));
      SectionB8.Add(Format('  if.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FQuantity)]));
      SectionB8.Add(Format('    raise Exception.Create(Wrong units of measurements);', []));
      SectionB8.Add(Format('  {$ENDIF}', []));
      SectionB8.Add(Format('  result := '';', []));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));

      SectionA8.Add(Format('function %sToVerboseString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToVerboseString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('  {$IFOPT D+}',[]));
      SectionB8.Add(Format('  if.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FQuantity)]));
      SectionB8.Add(Format('    raise Exception.Create(Wrong units of measurements);', []));
      SectionB8.Add(Format('  {$ENDIF}', []));
      SectionB8.Add(Format('  result := '';', []));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));

      SectionA8.Add(Format('function %sToFloat(const AValue: TQuantity): double;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToFloat(const AValue: TQuantity): double;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('  {$IFOPT D+}',[]));
      SectionB8.Add(Format('  if.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FQuantity)]));
      SectionB8.Add(Format('    raise Exception.Create(Wrong units of measurements', []));
      SectionB8.Add(Format('  {$ENDIF}', []));
      SectionB8.Add(Format('  result := 0;', []));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));
    end else
    begin
      SectionA8.Add(Format('function %sToString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('  {$IFOPT D+}',[]));
      SectionB8.Add(Format('  if.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FBase)]));
      SectionB8.Add(Format('    raise Exception.Create(Wrong units of measurements', []));
      SectionB8.Add(Format('  {$ENDIF}', []));
      SectionB8.Add(Format('  result := '';', []));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));

      SectionA8.Add(Format('function %sVerboseToString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sVerboseToString(const AValue: TQuantity): string;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('  {$IFOPT D+}',[]));
      SectionB8.Add(Format('  if.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FBase)]));
      SectionB8.Add(Format('    raise Exception.Create(Wrong units of measurements', []));
      SectionB8.Add(Format('  {$ENDIF}', []));
      SectionB8.Add(Format('  result := '';', []));
      SectionB8.Add(Format('end;',[]));
      SectionB8.Add(Format('',[]));

      SectionA8.Add(Format('function %sToFloat(const AValue: TQuantity): double;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('function %sToFloat(const AValue: TQuantity): double;', [GetHelperFuncName(FList[i].FQuantity)]));
      SectionB8.Add(Format('begin',[]));
      SectionB8.Add(Format('  {$IFOPT D+}',[]));
      SectionB8.Add(Format('  if.FUnitOfMeasurement <> %s then;',[GetUnitIndex(FList[i].FBase)]));
      SectionB8.Add(Format('    raise Exception.Create(Wrong units of measurements', []));
      SectionB8.Add(Format('  {$ENDIF}', []));
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
         (Item.FExponents[7] = ADim[7]) then Exit(Item.FIndex);
    end;
  end;
  result := 0;
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
      if (Item.FExponents[1] = ADim[1]) and
         (Item.FExponents[2] = ADim[2]) and
         (Item.FExponents[3] = ADim[3]) and
         (Item.FExponents[4] = ADim[4]) and
         (Item.FExponents[5] = ADim[5]) and
         (Item.FExponents[6] = ADim[6]) and
         (Item.FExponents[7] = ADim[7]) then Exit(Item.FIndex);
    end;
  end;
  result := 0;
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

