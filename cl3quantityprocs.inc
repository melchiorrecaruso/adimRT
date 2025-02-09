{ CL3 quantity implementation }

// TMultivecQuantity

{$IFNDEF ADIMOFF}
class operator TMultivecQuantity.:=(const AValue: TQuantity): TMultivecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TMultivecQuantity.<>(const ALeft, ARight: TMultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TMultivecQuantity.<>(const ALeft: TMultivecQuantity; const ARight: TQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TMultivecQuantity.<>(const ALeft: TQuantity; const ARight: TMultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TMultivecQuantity.=(const ALeft: TMultivecQuantity; const ARight: TQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TMultivecQuantity.=(const ALeft: TQuantity; const ARight: TMultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TMultivecQuantity.=(const ALeft, ARight: TMultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TMultivecQuantity.+(const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TMultivecQuantity.+(const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TMultivecQuantity.+(const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TMultivecQuantity.-(const ASelf: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := ASelf.FID;
  result.FValue := -ASelf.FValue;
end;

class operator TMultivecQuantity.-(const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TMultivecQuantity.-(const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TMultivecQuantity.-(const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TMultivecQuantity.*(const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TMultivecQuantity.*(const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TMultivecQuantity.*(const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TMultivecQuantity./(const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TMultivecQuantity./(const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TMultivecQuantity./(const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TTrivecQuantity

{$IFNDEF ADIMOFF}

class operator TTrivecQuantity.:=(const AValue: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TTrivecQuantity.<>(const ALeft, ARight: TTrivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TTrivecQuantity.<>(const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TTrivecQuantity.<>(const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TTrivecQuantity.=(const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TTrivecQuantity.=(const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TTrivecQuantity.=(const ALeft, ARight: TTrivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TTrivecQuantity.+(const ALeft, ARight: TTrivecQuantity): TTrivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivecQuantity.+(const ALeft: TTrivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivecQuantity.+(const ALeft: TQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivecQuantity.+(const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivecQuantity.+(const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TTrivecQuantity.-(const ASelf: TTrivecQuantity): TTrivecQuantity;
begin
  result.FID := ASelf.FID;
  result.FValue := -ASelf.FValue;
end;

class operator TTrivecQuantity.-(const ALeft, ARight: TTrivecQuantity): TTrivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivecQuantity.-(const ALeft: TTrivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivecQuantity.-(const ALeft: TQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivecQuantity.-(const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivecQuantity.-(const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TTrivecQuantity.*(const ALeft: TQuantity; const ARight: TTrivecQuantity): TTrivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivecQuantity.*(const ALeft: TTrivecQuantity; const ARight: TQuantity): TTrivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivecQuantity.*(const ALeft, ARight: TTrivecQuantity): TQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivecQuantity.*(const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivecQuantity.*(const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TTrivecQuantity./(const ALeft, ARight: TTrivecQuantity): TQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TTrivecQuantity./(const ALeft: TTrivecQuantity; const ARight: TQuantity): TTrivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TTrivecQuantity./(const ALeft: TQuantity; const ARight: TTrivecQuantity): TTrivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TTrivecQuantity./(const ALeft: TMultivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TTrivecQuantity./(const ALeft: TTrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TBivecQuantity

{$IFNDEF ADIMOFF}
class operator TBivecQuantity.:=(const AValue: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TBivecQuantity.<>(const ALeft, ARight: TBivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TBivecQuantity.<>(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TBivecQuantity.<>(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TBivecQuantity.=(const ALeft, ARight: TBivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TBivecQuantity.=(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TBivecQuantity.=(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft, ARight: TBivecQuantity): TBivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TBivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.-(const ASelf: TBivecQuantity): TBivecQuantity;
begin
  result.FID := ASelf.FID;
  result.FValue := -ASelf.FValue;
end;

class operator TBivecQuantity.-(const ALeft, ARight: TBivecQuantity): TBivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TBivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TQuantity; const ARight: TBivecQuantity): TBivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TBivecQuantity; const ARight: TQuantity): TBivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft, ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity./(const ALeft, ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TBivecQuantity; const ARight: TQuantity): TBivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TBivecQuantity./(const ALeft: TQuantity; const ARight: TBivecQuantity): TBivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TBivecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TTrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TVecQuantity

{$IFNDEF ADIMOFF}
class operator TVecQuantity.:=(const AValue: TVecQuantity): TMultivecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TVecQuantity.<>(const ALeft, ARight: TVecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVecQuantity.<>(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVecQuantity.<>(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVecQuantity.=(const ALeft, ARight: TVecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVecQuantity.=(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TVecQuantity.=(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft, ARight: TVecQuantity): TVecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TVecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.-(const ASelf: TVecQuantity): TVecQuantity;
begin
  result.FID := ASelf.FID;
  result.FValue := -ASelf.FValue;
end;

class operator TVecQuantity.-(const ALeft, ARight: TVecQuantity): TVecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TVecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
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

class operator TVecQuantity.*(const ALeft, ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TBivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TBivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity./(const ALeft, ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
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

class operator TVecQuantity./(const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TVecQuantity; const ARight: TTrivecQuantity): TBivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TTrivecQuantity; const ARight: TVecQuantity): TBivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TMultivecQuantityHelper

{$IFNDEF ADIMOFF}
function TMultivecQuantityHelper.Dual: TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Dual;
end;

function TMultivecQuantityHelper.Inverse: TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Inverse;
end;

function TMultivecQuantityHelper.Reverse: TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reverse;
end;

function TMultivecQuantityHelper.Conjugate: TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Conjugate;
end;

function TMultivecQuantityHelper.Reciprocal: TMultivecQuantity;
begin
  result.FID := CheckDiv(ScalarId, FID);
  result.FValue := FValue.Reciprocal;
end;

function TMultivecQuantityHelper.LeftReciprocal: TMultivecQuantity;
begin
  result.FID := CheckDiv(ScalarId, FID);
  result.FValue := FValue.LeftReciprocal;
end;

function TMultivecQuantityHelper.Normalized: TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Normalized;
end;

function TMultivecQuantityHelper.Norm: TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Norm;
end;

function TMultivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FID := CheckMul(FID, FID);
  result.FValue := FValue.SquaredNorm;
end;

function TMultivecQuantityHelper.Dot(const AVector: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivecQuantityHelper.Dot(const AVector: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivecQuantityHelper.Dot(const AVector: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivecQuantityHelper.Dot(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivecQuantityHelper.Wedge(const AVector: TVecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivecQuantityHelper.Wedge(const AVector: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivecQuantityHelper.Wedge(const AVector: TTrivecQuantity): TTrivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivecQuantityHelper.Wedge(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivecQuantityHelper.Projection(const AVector: TVecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TMultivecQuantityHelper.Projection(const AVector: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TMultivecQuantityHelper.Projection(const AVector: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TMultivecQuantityHelper.Projection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TMultivecQuantityHelper.Rejection(const AVector: TVecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TMultivecQuantityHelper.Rejection(const AVector: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TMultivecQuantityHelper.Rejection(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TMultivecQuantityHelper.Rejection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TMultivecQuantityHelper.Reflection(const AVector: TVecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TMultivecQuantityHelper.Reflection(const AVector: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TMultivecQuantityHelper.Reflection(const AVector: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TMultivecQuantityHelper.Reflection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TMultivecQuantityHelper.Rotation(const AVector1, AVector2: TVecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TMultivecQuantityHelper.Rotation(const AVector1, AVector2: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TMultivecQuantityHelper.Rotation(const AVector1, AVector2: TTrivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TMultivecQuantityHelper.Rotation(const AVector1, AVector2: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TMultivecQuantityHelper.SameValue(const AVector: TMultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TMultivecQuantityHelper.SameValue(const AVector: TTrivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TMultivecQuantityHelper.SameValue(const AVector: TBivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TMultivecQuantityHelper.SameValue(const AVector: TVecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TMultivecQuantityHelper.SameValue(const AVector: TQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TMultivecQuantityHelper.ExtractMultivector(AComponents: TMultivectorComponents): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractMultivector(AComponents);
end;

function TMultivecQuantityHelper.ExtractBivector(AComponents: TMultivectorComponents): TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractBivector(AComponents);
end;

function TMultivecQuantityHelper.ExtractVector(AComponents: TMultivectorComponents): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractVector(AComponents);
end;

function TMultivecQuantityHelper.ExtractTrivector: TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractTrivector;
end;

function TMultivecQuantityHelper.ExtractBivector: TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractBivector;
end;

function TMultivecQuantityHelper.ExtractVector: TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractVector;
end;

function TMultivecQuantityHelper.ExtractScalar: TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractScalar;
end;

function TMultivecQuantityHelper.IsNull: boolean;
begin
  result := FValue.SameValue(NullMultivector);
end;

function TMultivecQuantityHelper.IsScalar: boolean;
begin
  result := FValue.IsScalar;
end;

function TMultivecQuantityHelper.IsVector: boolean;
begin
  result := FValue.IsVector;
end;

function TMultivecQuantityHelper.IsBiVector: boolean;
begin
  result := FValue.IsBiVector;
end;

function TMultivecQuantityHelper.IsTrivector: boolean;
begin
  result := FValue.IsTrivector;
end;

function TMultivecQuantityHelper.IsA: string;
begin
  result := FValue.IsA;
end;
{$ENDIF}

// TTrivecQuantityHelper

{$IFNDEF ADIMOFF}
function TTrivecQuantityHelper.Dual: TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Dual;
end;

function TTrivecQuantityHelper.Inverse: TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Inverse;
end;

function TTrivecQuantityHelper.Reverse: TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reverse;
end;

function TTrivecQuantityHelper.Conjugate: TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Conjugate;
end;

function TTrivecQuantityHelper.Reciprocal: TTrivecQuantity;
begin
  result.FID := CheckDiv(ScalarId, FID);
  result.FValue := FValue.Reciprocal;
end;

function TTrivecQuantityHelper.Normalized: TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Normalized;
end;

function TTrivecQuantityHelper.Norm: TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Norm;
end;

function TTrivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FID := CheckMul(FID, FID);
  result.FValue := FValue.SquaredNorm;
end;

function TTrivecQuantityHelper.Dot(const AVector: TVecQuantity): TBivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TTrivecQuantityHelper.Dot(const AVector: TBivecQuantity): TVecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TTrivecQuantityHelper.Dot(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TTrivecQuantityHelper.Dot(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TTrivecQuantityHelper.Wedge(const AVector: TVecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := 0.0;
end;

function TTrivecQuantityHelper.Wedge(const AVector: TBivecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := 0.0;
end;

function TTrivecQuantityHelper.Wedge(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := 0.0;
end;

function TTrivecQuantityHelper.Wedge(const AVector: TMultivecQuantity): TTrivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TTrivecQuantityHelper.Projection(const AVector: TVecQuantity): TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TTrivecQuantityHelper.Projection(const AVector: TBivecQuantity): TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TTrivecQuantityHelper.Projection(const AVector: TTrivecQuantity): TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TTrivecQuantityHelper.Projection(const AVector: TMultivecQuantity): TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TTrivecQuantityHelper.Rejection(const AVector: TVecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TTrivecQuantityHelper.Rejection(const AVector: TBivecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TTrivecQuantityHelper.Rejection(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TTrivecQuantityHelper.Rejection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TTrivecQuantityHelper.Reflection(const AVector: TVecQuantity): TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TTrivecQuantityHelper.Reflection(const AVector: TBivecQuantity): TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TTrivecQuantityHelper.Reflection(const AVector: TTrivecQuantity): TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TTrivecQuantityHelper.Reflection(const AVector: TMultivecQuantity): TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TTrivecQuantityHelper.Rotation(const AVector1, AVector2: TVecQuantity): TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TTrivecQuantityHelper.Rotation(const AVector1, AVector2: TBivecQuantity): TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TTrivecQuantityHelper.Rotation(const AVector1, AVector2: TTrivecQuantity): TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TTrivecQuantityHelper.Rotation(const AVector1, AVector2: TMultivecQuantity): TTrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TTrivecQuantityHelper.SameValue(const AVector: TMultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TTrivecQuantityHelper.SameValue(const AVector: TTrivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TTrivecQuantityHelper.ToMultivector: TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TBivecQuantityHelper

{$IFNDEF ADIMOFF}
function TBivecQuantityHelper.Dual: TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Dual;
end;

function TBivecQuantityHelper.Inverse: TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Inverse;
end;

function TBivecQuantityHelper.Conjugate: TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Conjugate;
end;

function TBivecQuantityHelper.Reverse: TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reverse;
end;

function TBivecQuantityHelper.Reciprocal: TBivecQuantity;
begin
  result.FID := CheckDiv(ScalarId, FID);
  result.FValue := FValue.Reciprocal;
end;

function TBivecQuantityHelper.Normalized: TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Normalized;
end;

function TBivecQuantityHelper.Norm: TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Norm;
end;

function TBivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FID := CheckMul(FID, FID);
  result.FValue := FValue.SquaredNorm;
end;

function TBivecQuantityHelper.Dot(const AVector: TVecQuantity): TVecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivecQuantityHelper.Dot(const AVector: TBivecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivecQuantityHelper.Dot(const AVector: TTrivecQuantity): TVecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivecQuantityHelper.Dot(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivecQuantityHelper.Wedge(const AVector: TVecQuantity): TTrivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TBivecQuantityHelper.Wedge(const AVector: TBivecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := 0.0;
end;

function TBivecQuantityHelper.Wedge(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := 0.0;
end;

function TBivecQuantityHelper.Wedge(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TBivecQuantityHelper.Projection(const AVector: TVecQuantity): TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TBivecQuantityHelper.Projection(const AVector: TBivecQuantity): TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TBivecQuantityHelper.Projection(const AVector: TTrivecQuantity): TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TBivecQuantityHelper.Projection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TBivecQuantityHelper.Rejection(const AVector: TVecQuantity): TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TBivecQuantityHelper.Rejection(const AVector: TBivecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TBivecQuantityHelper.Rejection(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TBivecQuantityHelper.Rejection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TBivecQuantityHelper.Reflection(const AVector: TVecQuantity): TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TBivecQuantityHelper.Reflection(const AVector: TBivecQuantity): TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TBivecQuantityHelper.Reflection(const AVector: TTrivecQuantity): TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TBivecQuantityHelper.Reflection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TBivecQuantityHelper.Rotation(const AVector1, AVector2: TVecQuantity): TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TBivecQuantityHelper.Rotation(const AVector1, AVector2: TBivecQuantity): TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TBivecQuantityHelper.Rotation(const AVector1, AVector2: TTrivecQuantity): TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TBivecQuantityHelper.Rotation(const AVector1, AVector2: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TBivecQuantityHelper.SameValue(const AVector: TMultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TBivecQuantityHelper.SameValue(const AVector: TBivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TBivecQuantityHelper.ExtractBivector(AComponents: TMultivectorComponents): TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractBivector(AComponents);
end;

function TBivecQuantityHelper.ToMultivector: TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TVecQuantityHelper

{$IFNDEF ADIMOFF}
function TVecQuantityHelper.Dual: TBivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Dual;
end;

function TVecQuantityHelper.Inverse: TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Inverse;
end;

function TVecQuantityHelper.Reverse: TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reverse;
end;

function TVecQuantityHelper.Conjugate: TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Conjugate;
end;

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

function TVecQuantityHelper.Dot(const AVector: TBivecQuantity): TVecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVecQuantityHelper.Dot(const AVector: TTrivecQuantity): TBivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVecQuantityHelper.Dot(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVecQuantityHelper.Wedge(const AVector: TVecQuantity): TBivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TVecQuantityHelper.Wedge(const AVector: TBivecQuantity): TTrivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TVecQuantityHelper.Wedge(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FID := CheckMul(FID, FID);
  result.FValue := 0.0;
end;

function TVecQuantityHelper.Wedge(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TVecQuantityHelper.Projection(const AVector: TVecQuantity): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TVecQuantityHelper.Projection(const AVector: TBivecQuantity): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TVecQuantityHelper.Projection(const AVector: TTrivecQuantity): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TVecQuantityHelper.Projection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TVecQuantityHelper.Rejection(const AVector: TVecQuantity): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function  TVecQuantityHelper.Rejection(const AVector: TBivecQuantity): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TVecQuantityHelper.Rejection(const AVector: TTrivecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TVecQuantityHelper.Rejection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TVecQuantityHelper.Reflection(const AVector: TVecQuantity): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TVecQuantityHelper.Reflection(const AVector: TBivecQuantity): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TVecQuantityHelper.Reflection(const AVector: TTrivecQuantity): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TVecQuantityHelper.Reflection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TVecQuantityHelper.Rotation(const AVector1, AVector2: TVecQuantity): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TVecQuantityHelper.Rotation(const AVector1, AVector2: TBivecQuantity): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TVecQuantityHelper.Rotation(const AVector1, AVector2: TTrivecQuantity): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TVecQuantityHelper.Rotation(const AVector1, AVector2: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TVecQuantityHelper.Cross(const AVector: TVecQuantity): TVecQuantity;
begin
  result.FID := CheckMul(FID, AVector.FID);
  result.FValue := FValue.Cross(AVector.FValue);
end;

function TVecQuantityHelper.SameValue(const AVector: TMultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TVecQuantityHelper.SameValue(const AVector: TVecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TVecQuantityHelper.ExtractVector(AComponents: TMultivectorComponents): TVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ExtractVector(AComponents);
end;

function TVecQuantityHelper.ToMultivector: TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}
