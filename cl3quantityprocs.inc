{ CL3 quantity implementation }

// TCL3MultivecQuantity

{$IFNDEF ADIMOFF}
class operator TCL3MultivecQuantity.:=(const AValue: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TCL3MultivecQuantity.<>(const ALeft, ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3MultivecQuantity.<>(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3MultivecQuantity.<>(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3MultivecQuantity.=(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3MultivecQuantity.=(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3MultivecQuantity.=(const ALeft, ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3MultivecQuantity.+(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3MultivecQuantity.+(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3MultivecQuantity.+(const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3MultivecQuantity.-(const ASelf: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := ASelf.FID;
  result.FValue := -ASelf.FValue;
end;

class operator TCL3MultivecQuantity.-(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3MultivecQuantity.-(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3MultivecQuantity.-(const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3MultivecQuantity.*(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3MultivecQuantity.*(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3MultivecQuantity.*(const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3MultivecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3MultivecQuantity./(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3MultivecQuantity./(const ALeft, ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TCL3TrivecQuantity

{$IFNDEF ADIMOFF}

class operator TCL3TrivecQuantity.:=(const AValue: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft, ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft, ARight: TCL3TrivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft, ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ASelf: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := ASelf.FID;
  result.FValue := -ASelf.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft, ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft, ARight: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft, ARight: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TCL3BivecQuantity

{$IFNDEF ADIMOFF}
class operator TCL3BivecQuantity.:=(const AValue: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TCL3BivecQuantity.<>(const ALeft, ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3BivecQuantity.<>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3BivecQuantity.<>(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3BivecQuantity.=(const ALeft, ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3BivecQuantity.=(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3BivecQuantity.=(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft, ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.+(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ASelf: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FID := ASelf.FID;
  result.FValue := -ASelf.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft, ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.-(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft, ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity.*(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft, ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3BivecQuantity./(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3BivecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TCL3VecQuantity

{$IFNDEF ADIMOFF}
class operator TCL3VecQuantity.:=(const AValue: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TCL3VecQuantity.<>(const ALeft, ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3VecQuantity.<>(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3VecQuantity.<>(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3VecQuantity.=(const ALeft, ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3VecQuantity.=(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3VecQuantity.=(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft, ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.+(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ASelf: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FID := ASelf.FID;
  result.FValue := -ASelf.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft, ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.-(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft, ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity.*(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3VecQuantity./(const ALeft, ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./ (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3VecQuantity./(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3VecQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3VecQuantity; const ARight: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3VecQuantity./(const ALeft: TCL3VecQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TCL3MultivecQuantityHelper

{$IFNDEF ADIMOFF}
function TCL3MultivecQuantityHelper.Dual: TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Dual;
end;

function TCL3MultivecQuantityHelper.Inverse: TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Inverse;
end;

function TCL3MultivecQuantityHelper.Reverse: TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reverse;
end;

function TCL3MultivecQuantityHelper.Conjugate: TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Conjugate;
end;

function TCL3MultivecQuantityHelper.Reciprocal: TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ScalarId, FID);
  result.FValue := FValue.Reciprocal;
end;

function TCL3MultivecQuantityHelper.LeftReciprocal: TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ScalarId, FID);
  result.FValue := FValue.LeftReciprocal;
end;

function TCL3MultivecQuantityHelper.Normalized: TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Normalized;
end;

function TCL3MultivecQuantityHelper.Norm: TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Norm;
end;

function TCL3MultivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FID := CheckMul(FID, FID);
  result.FValue := FValue.SquaredNorm;
end;

function TCL3MultivecQuantityHelper.Dot(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Dot(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Wedge(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Projection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Projection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rejection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Reflection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Reflection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TCL3MultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TCL3TrivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TCL3BivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TCL3VecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.ExtractMultivector(AComponents: TCL3MultivectorComponents): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractMultivector(AComponents);
end;

function TCL3MultivecQuantityHelper.ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractBivector(AComponents);
end;

function TCL3MultivecQuantityHelper.ExtractVector(AComponents: TCL3MultivectorComponents): TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractVector(AComponents);
end;

function TCL3MultivecQuantityHelper.ExtractTrivector: TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractTrivector;
end;

function TCL3MultivecQuantityHelper.ExtractBivector: TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractBivector;
end;

function TCL3MultivecQuantityHelper.ExtractVector: TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractVector;
end;

function TCL3MultivecQuantityHelper.ExtractScalar: TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractScalar;
end;

function TCL3MultivecQuantityHelper.IsNull: boolean;
begin
  result := FValue.SameValue(CL3NullMultivector);
end;

function TCL3MultivecQuantityHelper.IsScalar: boolean;
begin
  result := FValue.IsScalar;
end;

function TCL3MultivecQuantityHelper.IsVector: boolean;
begin
  result := FValue.IsVector;
end;

function TCL3MultivecQuantityHelper.IsBiVector: boolean;
begin
  result := FValue.IsBiVector;
end;

function TCL3MultivecQuantityHelper.IsTrivector: boolean;
begin
  result := FValue.IsTrivector;
end;

function TCL3MultivecQuantityHelper.IsA: string;
begin
  result := FValue.IsA;
end;
{$ENDIF}

// TCL3TrivecQuantityHelper

{$IFNDEF ADIMOFF}
function TCL3TrivecQuantityHelper.Dual: TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Dual;
end;

function TCL3TrivecQuantityHelper.Inverse: TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Inverse;
end;

function TCL3TrivecQuantityHelper.Reverse: TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reverse;
end;

function TCL3TrivecQuantityHelper.Conjugate: TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Conjugate;
end;

function TCL3TrivecQuantityHelper.Reciprocal: TCL3TrivecQuantity;
begin
  result.FID := CheckDiv(ScalarId, FID);
  result.FValue := FValue.Reciprocal;
end;

function TCL3TrivecQuantityHelper.Normalized: TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Normalized;
end;

function TCL3TrivecQuantityHelper.Norm: TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Norm;
end;

function TCL3TrivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FID := CheckMul(FID, FID);
  result.FValue := FValue.SquaredNorm;
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3VecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TCL3VecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3VecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TCL3VecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.SameValue(const AVector: TCL3MultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.SameValue(const AVector: TCL3TrivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.ToMultivector: TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TCL3BivecQuantityHelper

{$IFNDEF ADIMOFF}
function TCL3BivecQuantityHelper.Dual: TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Dual;
end;

function TCL3BivecQuantityHelper.Inverse: TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Inverse;
end;

function TCL3BivecQuantityHelper.Conjugate: TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Conjugate;
end;

function TCL3BivecQuantityHelper.Reverse: TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reverse;
end;

function TCL3BivecQuantityHelper.Reciprocal: TCL3BivecQuantity;
begin
  result.FID := CheckDiv(ScalarId, FID);
  result.FValue := FValue.Reciprocal;
end;

function TCL3BivecQuantityHelper.Normalized: TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Normalized;
end;

function TCL3BivecQuantityHelper.Norm: TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Norm;
end;

function TCL3BivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FID := CheckMul(FID, FID);
  result.FValue := FValue.SquaredNorm;
end;

function TCL3BivecQuantityHelper.Dot(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Dot(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3VecQuantity): TCL3TrivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := 0.0;
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := 0.0;
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Projection(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Projection(const AVector: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Reflection(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Reflection(const AVector: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.SameValue(const AVector: TCL3MultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3BivecQuantityHelper.SameValue(const AVector: TCL3BivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3BivecQuantityHelper.ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractBivector(AComponents);
end;

function TCL3BivecQuantityHelper.ToMultivector: TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TCL3VecQuantityHelper

{$IFNDEF ADIMOFF}
function TCL3VecQuantityHelper.Dual: TCL3BivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Dual;
end;

function TCL3VecQuantityHelper.Inverse: TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Inverse;
end;

function TCL3VecQuantityHelper.Reverse: TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reverse;
end;

function TCL3VecQuantityHelper.Conjugate: TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Conjugate;
end;

function TCL3VecQuantityHelper.Reciprocal: TCL3VecQuantity;
begin
  result.FID := CheckDiv(ScalarId, FID);
  result.FValue := FValue.Reciprocal;
end;

function TCL3VecQuantityHelper.Normalized: TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Normalized;
end;

function TCL3VecQuantityHelper.Norm: TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Norm;
end;

function TCL3VecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FID := CheckMul(FID, FID);
  result.FValue := FValue.SquaredNorm;
end;

function TCL3VecQuantityHelper.Dot(const AVector: TCL3VecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3VecQuantityHelper.Dot(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3VecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3VecQuantityHelper.Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3VecQuantityHelper.Wedge(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3VecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3VecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, FID);
  result.FValue := 0.0;
end;

function TCL3VecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3VecQuantityHelper.Projection(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Projection(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Rejection(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function  TCL3VecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TCL3VecQuantityHelper.Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Reflection(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Reflection(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Cross(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Cross(AVector.FValue);
end;

function TCL3VecQuantityHelper.SameValue(const AVector: TCL3MultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3VecQuantityHelper.SameValue(const AVector: TCL3VecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3VecQuantityHelper.ExtractVector(AComponents: TCL3MultivectorComponents): TCL3VecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractVector(AComponents);
end;

function TCL3VecQuantityHelper.ToMultivector: TCL3MultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}
