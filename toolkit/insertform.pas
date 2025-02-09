{
  Description: InsertForm.

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

unit InsertForm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ExtCtrls;

type

  { TInsertFrm }

  TInsertFrm = class(TForm)
    ColorBtn: TColorButton;
    Dimension: TComboBox;
    Factor: TComboBox;
    Identifier: TComboBox;
    ColorLB: TLabel;
    LongSymbol: TComboBox;
    Prefixes: TComboBox;
    Quantity: TComboBox;
    ShortSymbol: TComboBox;
    CommentB: TLabel;
    OkBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PrefixesLB: TLabel;
    Field: TComboBox;
    BaseQuantity: TComboBox;
    Comment: TComboBox;
    DimensionLB: TLabel;
    IdentifierLB: TLabel;
    BaseQuantityLB: TLabel;
    FactorLB: TLabel;
    LongStringLB: TLabel;
    ShortStringLB: TLabel;
    QuantityLB: TLabel;
    FieldLB: TLabel;
    procedure DimensionEditingDone(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  InsertFrm: TInsertFrm;

implementation

{$R *.lfm}

uses
  Common;

{ TInsertFrm }

procedure TInsertFrm.FormShow(Sender: TObject);
begin
  DimensionEditingDone(Sender);
end;

procedure TInsertFrm.DimensionEditingDone(Sender: TObject);
begin
  LongSymbol.Items.Clear;
  ShortSymbol.Items.Clear;
  if Dimension.Text <> '' then
  begin
    LongSymbol.Items.Add(DimensionToLongString(StringToDimensions(Dimension.Text)));
    ShortSymbol.Items.Add(DimensionToShortString(StringToDimensions(Dimension.Text)));
  end;
end;

{ TInsertFrm }

end.

