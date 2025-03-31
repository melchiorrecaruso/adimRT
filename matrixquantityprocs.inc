
{ Matrix and vector quantity implementation }

{$IFNDEF ADIMOFF}
class operator TCVecQuantity.<>(const ALeft, ARight: TSelf): boolean;
begin
  if ALeft.FID <> ARight.FID then Exit(True);
  if ALeft.FValue <> ARight.FValue then Exit(True);
  result := False;
end;

class operator TCVecQuantity.=(const ALeft, ARight: TSelf): boolean;
begin
  if ALeft.FID <> ARight.FID then Exit(False);
  if ALeft.FValue <> ARight.FValue then Exit(False);
  result := True;
end;

class operator TCVecQuantity.+(const AValue: TSelf): TSelf;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TCVecQuantity.+(const ALeft, ARight: TSelf): TSelf;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCVecQuantity.-(const AValue: TCVecQuantity): TSelf;
begin
  result.FID := AValue.FID;
  result.FValue := -AValue.FValue;
end;

class operator TCVecQuantity.-(const ALeft, ARight: TCVecQuantity): TSelf;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TQuantity; const ARight: TSelf): TSelf;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TSelf; const ARight: TQuantity): TSelf;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCVecQuantity./(const ALeft: TQuantity; const ARight: TSelf): TSelf;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCVecQuantity./(const ALeft: TSelf; const ARight: TQuantity): TSelf;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

{$IFNDEF ADIMOFF}
class operator TRVecQuantity.<>(const ALeft, ARight: TSelf): boolean;
begin
  if ALeft.FID <> ARight.FID then Exit(True);
  if ALeft.FValue <> ARight.FValue then Exit(True);
  result := False;
end;

class operator TRVecQuantity.=(const ALeft, ARight: TSelf): boolean;
begin
  if ALeft.FID <> ARight.FID then Exit(False);
  if ALeft.FValue <> ARight.FValue then Exit(False);
  result := True;
end;

class operator TRVecQuantity.+(const AValue: TSelf): TSelf;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TRVecQuantity.+(const ALeft, ARight: TSelf): TSelf;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TRVecQuantity.-(const AValue: TRVecQuantity): TSelf;
begin
  result.FID := AValue.FID;
  result.FValue := -AValue.FValue;
end;

class operator TRVecQuantity.-(const ALeft, ARight: TRVecQuantity): TSelf;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TRVecQuantity.*(const ALeft: TQuantity; const ARight: TSelf): TSelf;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRVecQuantity.*(const ALeft: TSelf; const ARight: TQuantity): TSelf;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRVecQuantity./(const ALeft: TQuantity; const ARight: TSelf): TSelf;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TRVecQuantity./(const ALeft: TSelf; const ARight: TQuantity): TSelf;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

{$IFNDEF ADIMOFF}
function TR3VecQuantityHelper.Dot(const AVector: TR3VecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TR3VecQuantityHelper.Cross(const AVector: TR3VecQuantity): TR3VecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Cross(AVector.FValue);
end;

function TR3VecQuantityHelper.Projection(const AVersor: TR3Vector): TR3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVersor);
end;

function TR3VecQuantityHelper.Rejection(const AVersor: TR3Vector): TR3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVersor);
end;

function TR3VecQuantityHelper.Reflection(const AVersor: TR3Vector): TR3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVersor);
end;
{$ENDIF}

