{ Vector quantity implementation }

// TR3VecQuantity

{$IFNDEF ADIMOFF}
class operator TR3VecQuantity.<>(const ALeft, ARight: TR3VecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TR3VecQuantity.=(const ALeft, ARight: TR3VecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TR3VecQuantity.+(const AValue: TR3VecQuantity): TR3VecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TR3VecQuantity.+(const ALeft, ARight: TR3VecQuantity): TR3VecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TR3VecQuantity.-(const AValue: TR3VecQuantity): TR3VecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := -AValue.FValue;
end;

class operator TR3VecQuantity.-(const ALeft, ARight: TR3VecQuantity): TR3VecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TR3VecQuantity.*(const ALeft: TQuantity; const ARight: TR3VecQuantity): TR3VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TR3VecQuantity.*(const ALeft: TR3VecQuantity; const ARight: TQuantity): TR3VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TR3VecQuantity./(const ALeft: TR3VecQuantity; const ARight: TQuantity): TR3VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TR3VecQuantity./(const ALeft: TQuantity; const ARight: TR3VecQuantity): TR3VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TR3VecQuantityHelper

{$IFNDEF ADIMOFF}

function TR3VecQuantityHelper.Reciprocal: TR3VecQuantity;
begin
  result.FID := CheckDiv(ScalarId, FID);
  result.FValue := FValue.Reciprocal;
end;

function TR3VecQuantityHelper.Normalized: TR3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Normalized;
end;

function TR3VecQuantityHelper.Norm: TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Norm;
end;

function TR3VecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FID := CheckMul(FID, FID);
  result.FValue := FValue.SquaredNorm;
end;

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

function TR3VecQuantityHelper.SameValue(const AVector: TR3VecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TR3VecQuantityHelper.ExtractVector(AComponents: TVectorComponents): TR3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractVector(AComponents);
end;
{$ENDIF}
