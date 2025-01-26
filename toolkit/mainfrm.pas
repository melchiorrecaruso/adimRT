{
  Description: MainForm.

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

unit MainFrm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Grids, Buttons,
  ComCtrls, StdCtrls, Spin, SynHighlighterPas, SynEdit, SpinEx, ToolKitUnit,
  Types;

type
  { TMainForm }

  TMainForm = class(TForm)
    AddBtn: TBitBtn;
    MoveDownBtn: TBitBtn;
    MoveUtBtn: TBitBtn;
    DeleteBtn: TBitBtn;
    EditBtn: TBitBtn;
    SaveBtn: TBitBtn;
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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LoadBtnClick(Sender: TObject);
    procedure ExportBtnClick(Sender: TObject);
    procedure RunBtnClick(Sender: TObject);
    procedure StringGridDblClick(Sender: TObject);
    procedure StringGridPrepareCanvas(Sender: TObject; aCol, aRow: Integer; aState: TGridDrawState);
    procedure UpdateButton(Value: boolean);
  public
    FList: TToolKitList;
    procedure UpdateGrid;
    procedure UpdateInsertFrmField;
  end;


var
  MainForm: TMainForm;

implementation

uses
  InsertForm;

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
  SynEdit.BeginUpdate(True);
  SynEdit.Clear;
  SynEdit.EndUpdate;

  FList.Destroy;
end;

procedure TMainForm.LoadBtnClick(Sender: TObject);
begin
  OpenDialog.Filter := 'CSV Document|*.csv;';
  if OpenDialog.Execute then
  begin
    FList.Clear;
    FList.LoadFromFile(OpenDialog.FileName);
    UpdateGrid;
  end;
end;

procedure TMainForm.SaveBtnClick(Sender: TObject);
begin
  SaveDialog.Filter := 'CSV Document|*.csv;';
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
  SaveDialog.Filter := 'FreePascal unit|*.pas;';
  if SaveDialog.Execute then
  begin
    SynEdit.Lines.SaveToFile(SaveDialog.FileName);
  end;
end;

procedure TMainForm.RunBtnClick(Sender: TObject);
var
  i: longint;
  Builder: TToolKitBuilder;
begin
  UpdateButton(False);
  Application.ProcessMessages;
  Builder := TToolKitBuilder.Create(FList);
  Builder.Run;

  SynEdit.BeginUpdate(True);
  SynEdit.Clear;
  for i := 0 to Builder.Document.Count - 1 do
    SynEdit.Append(Builder.Document[i]);
  SynEdit.EndUpdate;

  Memo.Clear;
  for i := 0 to Builder.Messages.Count - 1 do
    Memo.Lines.Add(Builder.Messages[i]);

  Builder.Destroy;
  UpdateButton(True);
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
  LoadBtn.Enabled   := Value;
  ExportBtn.Enabled := Value;
  RunBtn.Enabled    := Value;

  if Memo.Lines.Count = 0 then
    PageControl.TabIndex := 1
  else
    PageControl.TabIndex := 2;
end;

end.

