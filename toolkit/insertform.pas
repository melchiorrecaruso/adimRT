unit insertform;

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

