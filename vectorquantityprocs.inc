
// TVecQuantity

{$IFDEF ADIMDEBUG}
class operator TVecQuantity.<>(const ALeft, ARight: TVecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVecQuantity.=(const ALeft, ARight: TVecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVecQuantity.+(const AValue: TVecQuantity): TVecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := +AValue.FValue;
end;

class operator TVecQuantity.+(const ALeft, ARight: TVecQuantity): TVecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.-(const AValue: TVecQuantity): TVecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := -AValue.FValue;
end;

class operator TVecQuantity.-(const ALeft, ARight: TVecQuantity): TVecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TQuantity; const ARight: TVecQuantity): TVecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TVecQuantity; const ARight: TQuantity): TVecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity./ (const ALeft: TVecQuantity; const ARight: TQuantity): TVecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TVecQuantity./(const ALeft: TQuantity; const ARight: TVecQuantity): TVecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TVecQuantityHelper

{$IFDEF ADIMDEBUG}

function TVecQuantityHelper.Reciprocal: TVecQuantity;
begin
  result.FID := CheckDiv(ScalarId, FID);
  result.FValue := FValue.Reciprocal;
end;

function TVecQuantityHelper.Normalized: TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Normalized;
end;

function TVecQuantityHelper.Norm: TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Norm;
end;

function TVecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FID := CheckMul(FID, FID);
  result.FValue := FValue.SquaredNorm;
end;

function TVecQuantityHelper.Dot(const AVector: TVecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVecQuantityHelper.Cross(const AVector: TVecQuantity): TVecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Cross(AVector.FValue);
end;

function TVecQuantityHelper.Projection(const AVersor: TVector): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVersor);
end;

function TVecQuantityHelper.Rejection(const AVersor: TVector): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVersor);
end;

function TVecQuantityHelper.Reflection(const AVersor: TVector): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVersor);
end;

function TVecQuantityHelper.SameValue(const AVector: TVecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TVecQuantityHelper.ExtractVector(AComponents: TVectorComponents): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractVector(AComponents);
end;
{$ENDIF}
