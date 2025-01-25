
// TComplexQuantity

{$IFDEF ADIMDEBUG}
function TComplexQuantity.Dual: TComplexQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Dual;
end;

function TComplexQuantity.Reciprocal: TComplexQuantity;
begin
  result.FID := CheckDiv(ScalarID, FID);
  result.FValue := FValue.Reciprocal;
end;

function TComplexQuantity.Norm: TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Norm;
end;

function TComplexQuantity.SquaredNorm: TQuantity;
begin
  result.FID := MulTable[FID, FID];
  result.FValue := FValue.SquaredNorm;
end;

class operator TComplexQuantity.+(const AValue: TComplexQuantity): TComplexQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TComplexQuantity.-(const AValue: TComplexQuantity): TComplexQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := -AValue.FValue;
end;

class operator TComplexQuantity.+(const ALeft, ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TComplexQuantity.-(const ALeft, ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft, ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FID := CheckMul(ScalarID, ARight.FID);
  result.FValue := ALeft * ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity; inline;
begin
  result.FID := CheckMul(ALeft.FID, ScalarID);
  result.FValue := ALeft.FValue * ARight;
end;

class operator TComplexQuantity./(const ALeft, ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result := ALeft.FValue * ARight.Reciprocal;
end;

class operator TComplexQuantity./(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FID := CheckDiv(ScalarID, ARight.FID);
  result := ALeft * ARight.Reciprocal;
end;

class operator TComplexQuantity./(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity; inline;
begin
  result.FID := CheckDiv(ALeft.FID, ScalarID);
  result := ALeft.Reciprocal * ARight;
end;

class operator TComplexQuantity.=(const ALeft, ARight: TComplexQuantity): boolean;
begin
  CheckEqual(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TComplexQuantity.<>(const ALeft, ARight: TComplexQuantity): boolean;
begin
  CheckNotEqual(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TComplexQuantity.:=(const AValue: TComplex): TComplexQuantity;
begin
  result.FID := ScalarID;
  result.FValue := AValue;
end;
{$ENDIF}

