{
  Description: MainForm.

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

unit MainFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, Buttons,
  ComCtrls, StdCtrls, SynHighlighterPas, SynEdit, ToolKitUnit, Types;

type
  { TMainForm }

  TMainForm = class(TForm)
    AddBtn: TBitBtn;
    MoveDownBtn: TBitBtn;
    MoveUtBtn: TBitBtn;
    DeleteBtn: TBitBtn;
    EditBtn: TBitBtn;
    SaveBtn: TBitBtn;
    SkipVectorialUnits: TCheckBox;
    Memo: TMemo;
    StringGrid: TStringGrid;
    TabSheet3: TTabSheet;
    ExportBtn: TBitBtn;
    LoadBtn: TBitBtn;
    RunBtn: TBitBtn;
    PageControl: TPageControl;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    SynEdit: TSynEdit;
    SynPasSyn: TSynPasSyn;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet4: TTabSheet;
    procedure AddBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure EditBtnClick(Sender: TObject);
    procedure MoveDownBtnClick(Sender: TObject);
    procedure MoveUtBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure ExportBtnClick(Sender: TObject);
    procedure RunBtnClick(Sender: TObject);
    procedure OnTerminate(Sender: TObject);
    procedure StringGridDblClick(Sender: TObject);
    procedure StringGridPrepareCanvas(Sender: TObject; aCol, aRow: Integer;
      aState: TGridDrawState);
    procedure UpdateButton(Value: boolean);
    procedure DoMessage;
  public
    FList: TToolKitList;
    procedure UpdateGrid;
    procedure UpdateInsertFrmField;
  end;

  TToolKitThread = class(TThread)
  private
    FList: TToolKitBuilder;
    FMessage: string;
    procedure OnMessage(const AMessage: string);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute; override;
  end;


var
  MainForm: TMainForm;
  ToolKitThread: TToolKitThread = nil;

implementation

uses
  Common, InsertForm;

{$R *.lfm}

{ TMainForm }

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FList := TToolKitList.Create;

  PageControl.TabIndex   := 0;
  WindowState            := wsNormal;
  StringGrid.SaveOptions := [soDesign, soPosition, soAttributes, soContent];
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FList.Destroy;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //
end;

procedure TMainForm.LoadBtnClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    FList.Clear;
    FList.LoadFromFile(OpenDialog.FileName);
    UpdateGrid;
  end;
end;

procedure TMainForm.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    FList.SaveToFile(SaveDialog.FileName);
  end;
end;

procedure TMainForm.AddBtnClick(Sender: TObject);
var
  Item: TToolKitItem;
begin
  InsertFrm.Field       .Text := '';
  InsertFrm.Quantity    .Text := '';
  InsertFrm.Dimension   .Text := '';
  InsertFrm.LongSymbol  .Text := '';
  InsertFrm.ShortSymbol .Text := '';
  InsertFrm.Identifier  .Text := '';
  InsertFrm.BaseQuantity.Text := '';
  InsertFrm.Factor      .Text := '';
  InsertFrm.Prefixes    .Text := '';
  InsertFrm.TypeQuantity.Text := '';
  InsertFrm.ColorBtn    .ButtonColor := clWhite;

  UpdateInsertFrmField;
  if InsertFrm.ShowModal = mrOk then
  begin
    Item               := TToolKitItem.Create;
    Item.FField        := InsertFrm.Field       .Text;
    Item.FQuantity     := InsertFrm.Quantity    .Text;
    Item.FDimension    := InsertFrm.Dimension   .Text;
    Item.FLongString   := InsertFrm.LongSymbol  .Text;
    Item.FShortString  := InsertFrm.ShortSymbol .Text;
    Item.FIdentifier   := InsertFrm.Identifier  .Text;
    Item.FBase         := InsertFrm.BaseQuantity.Text;
    Item.FFactor       := InsertFrm.Factor      .Text;
    Item.FPrefixes     := InsertFrm.Prefixes    .Text;
    Item.FType         := InsertFrm.TypeQuantity.Text;
    Item.FColor        := ColorToString(InsertFrm.ColorBtn.ButtonColor);
    FList.Add(Item);
  end;
  UpdateGrid;
end;

procedure TMainForm.DeleteBtnClick(Sender: TObject);
begin
  if StringGrid.Row > 0 then
  begin
    if MessageDlg('Warning', 'Do you want to delete selected row?', mtWarning, [mbCancel, mbOk], '') = mrOk then
    begin
      FList.Delete(StringGrid.Row -1);
    end;
    UpdateGrid;
  end;
end;

procedure TMainForm.EditBtnClick(Sender: TObject);
var
  Item: TToolKitItem;
begin
  if StringGrid.Row > 0 then
  begin
    Item := FList.Items[StringGrid.Row -1];
    InsertFrm.Field       .Text := Item.FField;
    InsertFrm.Quantity    .Text := Item.FQuantity;
    InsertFrm.Dimension   .Text := Item.FDimension;
    InsertFrm.LongSymbol  .Text := Item.FLongString;
    InsertFrm.ShortSymbol .Text := Item.FShortString;
    InsertFrm.Identifier  .Text := Item.FIdentifier;
    InsertFrm.BaseQuantity.Text := Item.FBase;
    InsertFrm.Factor      .Text := Item.FFactor;
    InsertFrm.Prefixes    .Text := Item.FPrefixes;
    InsertFrm.TypeQuantity.Text := Item.FType;
    InsertFrm.ColorBtn.ButtonColor := StringToColor(Item.FColor);

    UpdateInsertFrmField;
    if InsertFrm.ShowModal = mrOk then
    begin
      Item.FField        := InsertFrm.Field       .Text;
      Item.FQuantity     := InsertFrm.Quantity    .Text;
      Item.FDimension    := InsertFrm.Dimension   .Text;
      Item.FLongString   := InsertFrm.LongSymbol  .Text;
      Item.FShortString  := InsertFrm.ShortSymbol .Text;
      Item.FIdentifier   := InsertFrm.Identifier  .Text;
      Item.FBase         := InsertFrm.BaseQuantity.Text;
      Item.FFactor       := InsertFrm.Factor      .Text;
      Item.FPrefixes     := InsertFrm.Prefixes    .Text;
      Item.FType         := InsertFrm.TypeQuantity.Text;
      Item.FColor        := ColorToString(InsertFrm.ColorBtn.ButtonColor);
    end;
  end;
  UpdateGrid;
end;

procedure TMainForm.MoveDownBtnClick(Sender: TObject);
begin
  if StringGrid.Row > 0 then
    FList.MoveDown(StringGrid.Row -1);
  UpdateGrid;
end;

procedure TMainForm.MoveUtBtnClick(Sender: TObject);
begin
  if StringGrid.Row > 0 then
    FList.MoveUp(StringGrid.Row -1);
  UpdateGrid;
end;

procedure TMainForm.UpdateGrid;
var
  i: longint;
begin
  StringGrid.RowCount := FList.Count + 1;
  for i := 0 to FList.Count -1 do
  begin
    StringGrid.Cells[0, i + 1] := FList[i].FField;
    StringGrid.Cells[1, i + 1] := FList[i].FQuantity;
    StringGrid.Cells[2, i + 1] := FList[i].FDimension;
    StringGrid.Cells[3, i + 1] := FList[i].FLongString;
    StringGrid.Cells[4, i + 1] := FList[i].FShortString;
    StringGrid.Cells[5, i + 1] := FList[i].FIdentifier;
    StringGrid.Cells[6, i + 1] := FList[i].FBase;
    StringGrid.Cells[7, i + 1] := FList[i].FFactor;
    StringGrid.Cells[8, i + 1] := FList[i].FPrefixes;
    StringGrid.Cells[9, i + 1] := FList[i].FType;
  end;
end;

procedure TMainForm.UpdateInsertFrmField;
var
  i: longint;
  Item: TToolKitItem;
begin
  for i := 0 to FList.Count -1 do
  begin
    Item := FList[i];
    if Item.FField <> '' then
      if InsertFrm.Field.Items.IndexOf(Item.FField) = -1 then
      begin
        InsertFrm.Field.Items.Add(Item.FField);
      end;
  end;
end;

procedure TMainForm.ExportBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    SynEdit.Lines.SaveToFile(SaveDialog.FileName);
  end;
end;

procedure TMainForm.RunBtnClick(Sender: TObject);
var
  i: longint;
  T: TToolkitItem;
begin
  Memo.Clear;
  UpdateButton(False);
  ToolKitThread := TToolKitThread.Create;
  ToolKitThread.OnTerminate := @OnTerminate;
  (*
  for i := 0 to WorksheetGrid.Worksheet.GetLastRowIndex do
  begin
    T.FClassName        := CleanSingleSpaces(WorksheetGrid.Worksheet.ReadAsText(i, 00));
    T.FOperator         := CleanSingleSpaces(WorksheetGrid.Worksheet.ReadAsText(i, 01));
    T.FClassParent1     := CleanSingleSpaces(WorksheetGrid.Worksheet.ReadAsText(i, 02));
    T.FClassParent2     := CleanSingleSpaces(WorksheetGrid.Worksheet.ReadAsText(i, 03));
    T.FLongSymbol       := CleanDoubleSpaces(WorksheetGrid.Worksheet.ReadAsText(i, 04));
    T.FShortSymbol      := CleanSingleSpaces(WorksheetGrid.Worksheet.ReadAsText(i, 05));
    T.FIdentifierSymbol := CleanSingleSpaces(WorksheetGrid.Worksheet.ReadAsText(i, 06));
    T.FBaseClass        := CleanSingleSpaces(WorksheetGrid.Worksheet.ReadAsText(i, 07));
    T.FFactor           := CleanDoubleSpaces(WorksheetGrid.Worksheet.ReadAsText(i, 08));
    T.FPrefixes         := CleanSingleSpaces(WorksheetGrid.Worksheet.ReadAsText(i, 09));
    T.FClassType        := CleanSingleSpaces(WorksheetGrid.Worksheet.ReadAsText(i, 10));

    if (T.FClassName <> '') and (T.FClassName[1] <> '/') then
    begin
      if SkipVectorialUnits.Checked then
      begin
        if (T.FClassType = '') then
          ToolKitThread.FList.Add(T);
      end else
        ToolKitThread.FList.Add(T);
    end;
  end;
  *)

  ToolKitThread.Start;
end;

procedure TMainForm.OnTerminate(Sender: TObject);
var
  I: longint;
begin
  SynEdit.BeginUpdate(True);
  SynEdit.Clear;
  with ToolKitThread.FList do
  begin
    for I := 0 to Document.Count - 1 do SynEdit.Append(Document[I]);
    for I := 0 to Messages.Count - 1 do Memo.Lines.Add(Messages[I]);
  end;
  SynEdit.EndUpdate;
  UpdateButton(True);
  ToolKitThread := nil;
end;

procedure TMainForm.StringGridDblClick(Sender: TObject);
begin
  if StringGrid.Row > 0 then
    EditBtnClick(Sender);
end;

procedure TMainForm.StringGridPrepareCanvas(Sender: TObject; aCol,
  aRow: Integer; aState: TGridDrawState);
var
  Grid: TStringGrid;
begin
  Grid := Sender as TStringGrid;
  if (aRow > 0) then
  begin
    Grid.Canvas.Brush.Color := StringToColor(FList[aRow -1].FColor);
    Grid.Canvas.Font.Color  := clBlack;
  end;
end;

procedure TMainForm.UpdateButton(Value: boolean);
begin
  LoadBtn.Enabled                   := Value;
  SkipVectorialUnits.Enabled        := Value;

  ExportBtn.Enabled        := Value;
  RunBtn.Enabled           := Value;
  case Value of
    True:  PageControl.TabIndex := 1;
    False: PageControl.TabIndex := 2;
  end;
end;

procedure TMainForm.DoMessage;
begin
  Memo.Append(ToolKitThread.FMessage);
end;

{ TToolKitThread }

constructor TToolKitThread.Create;
begin
  FList := TToolKitBuilder.Create;
  FList.SkipVectorialUnits := Mainform.SkipVectorialUnits.Checked;
  FreeOnTerminate := True;
  inherited Create(True);
end;

destructor TToolKitThread.Destroy;
begin
  FList.Destroy;
  inherited Destroy;
end;

procedure TToolKitThread.Execute;
begin
  FList.Run;
end;

procedure TToolKitThread.OnMessage(const AMessage: string);
begin
  FMessage := AMessage;
  Synchronize(@MainForm.DoMessage);
end;

end.

