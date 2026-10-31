{
  Description: InsertForm.

  Copyright (C) 2023-2025 Melchiorre Caruso <melchiorrecaruso@gmail.com>

  Distributed under the MIT License, see the file LICENSE.
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
var
  LDimension: TExponents;
begin
  LongSymbol.Items.Clear;
  ShortSymbol.Items.Clear;
  if Dimension.Text <> '' then
  begin
    LDimension := StringToDimensions(Dimension.Text);
    LongSymbol.Items.Add(DimensionToLongString(LDimension));
    ShortSymbol.Items.Add(DimensionToShortString(LDimension));
  end;
end;

{ TInsertFrm }

end.

