
// TQuantity

{$IFNDEF ADIMOFF}
function TQuantity.Reciprocal: TQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := 1/FValue;
end;

class operator TQuantity.+(const ASelf: TQuantity): TQuantity;
begin
  result.FDim := ASelf.FDim;
  result.FValue := ASelf.FValue;
end;

class operator TQuantity.-(const ASelf: TQuantity): TQuantity;
begin
  result.FDim := ASelf.FDim;
  result.FValue := -ASelf.FValue;
end;

class operator TQuantity.+(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.-(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.*(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity.*(const ALeft: double; const ARight: TQuantity): TQuantity;
begin
  result.FDim := ARight.FDim;
  result.FValue:= ALeft * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: double): TQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue:= ALeft.FValue * ARight;
end;

class operator TQuantity./(const ALeft: double; const ARight: TQuantity): TQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue:= ALeft / ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: double): TQuantity;
begin
  result.FDim := ALeft.FDim;
  result.FValue:= ALeft.FValue / ARight;
end;

class operator TQuantity.=(const ALeft, ARight: TQuantity): boolean; inline;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TQuantity.<(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue < ARight.FValue;
end;

class operator TQuantity.>(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue > ARight.FValue;
end;

class operator TQuantity.<=(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <= ARight.FValue;
end;

class operator TQuantity.>=(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue >= ARight.FValue;
end;

class operator TQuantity.<>(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TQuantity.:=(const AValue: double): TQuantity;
begin
  result.FDim := ScalarUnit.FDim;
  result.FValue := AValue;
end;
{$ENDIF}

