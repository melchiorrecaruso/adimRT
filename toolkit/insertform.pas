{
  Description: InsertForm.

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
    TypeQuantityLB: TLabel;
    OkBtn: TBitBtn;
    CancelBtn: TBitBtn;
    PrefixesLB: TLabel;
    Field: TComboBox;
    BaseQuantity: TComboBox;
    TypeQuantity: TComboBox;
    DimensionLB: TLabel;
    IdentifierLB: TLabel;
    BaseQuantityLB: TLabel;
    FactorLB: TLabel;
    LongStringLB: TLabel;
    ShortStringLB: TLabel;
    QuantityLB: TLabel;
    FieldLB: TLabel;
  private

  public

  end;

var
  InsertFrm: TInsertFrm;

implementation

{$R *.lfm}

end.

