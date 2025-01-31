// TMultivecQuantity

{$IFDEF ADIMDEBUG}
class operator TMultivecQuantity.:=(const AValue: TQuantity): TMultivecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TMultivecQuantity.<>(const ALeft, ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TMultivecQuantity.<>(const ALeft: TMultivecQuantity; const ARight: TQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TMultivecQuantity.<>(const ALeft: TQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TMultivecQuantity.=(const ALeft: TMultivecQuantity; const ARight: TQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TMultivecQuantity.=(const ALeft: TQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TMultivecQuantity.=(const ALeft, ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TMultivecQuantity.+(const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;

  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');
end;

class operator TMultivecQuantity.+(const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;

  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');
end;

class operator TMultivecQuantity.+(const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;

  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');
end;

class operator TMultivecQuantity.-(const ASelf: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := ASelf.FID;
  result.FValue := -ASelf.FValue;
end;

class operator TMultivecQuantity.-(const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TMultivecQuantity.-(const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TMultivecQuantity.-(const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TMultivecQuantity.*(const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TMultivecQuantity.*(const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TMultivecQuantity.*(const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TMultivecQuantity./(const ALeft: TMultivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TMultivecQuantity./(const ALeft: TQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TMultivecQuantity./(const ALeft, ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TCL3TrivecQuantity

{$IFDEF ADIMDEBUG}

class operator TCL3TrivecQuantity.:=(const AValue: TCL3TrivecQuantity): TMultivecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft, ARight: TCL3TrivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TMultivecQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.<>(const ALeft: TCL3TrivecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft: TMultivecQuantity; const ARight: TCL3TrivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft: TCL3TrivecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.=(const ALeft, ARight: TCL3TrivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft, ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TMultivecQuantity; const ARight: TCL3TrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ASelf: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := ASelf.FID;
  result.FValue := -ASelf.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft, ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TMultivecQuantity; const ARight: TCL3TrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft, ARight: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TMultivecQuantity; const ARight: TCL3TrivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft, ARight: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCL3TrivecQuantity./(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3TrivecQuantity./(const ALeft: TMultivecQuantity; const ARight: TCL3TrivecQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TCL3TrivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TBivecQuantity

{$IFDEF ADIMDEBUG}
class operator TBivecQuantity.:=(const AValue: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TBivecQuantity.<>(const ALeft, ARight: TBivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TBivecQuantity.<>(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TBivecQuantity.<>(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TBivecQuantity.=(const ALeft, ARight: TBivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TBivecQuantity.=(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TBivecQuantity.=(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft, ARight: TBivecQuantity): TBivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TBivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TBivecQuantity; const ARight: TCL3TrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.+(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TBivecQuantity.-(const ASelf: TBivecQuantity): TBivecQuantity;
begin
  result.FID := ASelf.FID;
  result.FValue := -ASelf.FValue;
end;

class operator TBivecQuantity.-(const ALeft, ARight: TBivecQuantity): TBivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TBivecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TBivecQuantity; const ARight: TCL3TrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.-(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TQuantity; const ARight: TBivecQuantity): TBivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TBivecQuantity; const ARight: TQuantity): TBivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft, ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TBivecQuantity; const ARight: TCL3TrivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity.*(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TBivecQuantity./(const ALeft, ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TBivecQuantity; const ARight: TQuantity): TBivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TBivecQuantity./(const ALeft: TQuantity; const ARight: TBivecQuantity): TBivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TBivecQuantity; const ARight: TCL3TrivecQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TMultivecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TBivecQuantity./(const ALeft: TBivecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TVecQuantity

{$IFDEF ADIMDEBUG}
class operator TVecQuantity.:=(const AValue: TVecQuantity): TMultivecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TVecQuantity.<>(const ALeft, ARight: TVecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVecQuantity.<>(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;

class operator TVecQuantity.<>(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): boolean;
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

class operator TVecQuantity.=(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TVecQuantity.=(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft, ARight: TVecQuantity): TVecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TVecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TVecQuantity; const ARight: TCL3TrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.+(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TVecQuantity.-(const ASelf: TVecQuantity): TVecQuantity;
begin
  result.FID := ASelf.FID;
  result.FValue := -ASelf.FValue;
end;

class operator TVecQuantity.-(const ALeft, ARight: TVecQuantity): TVecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TVecQuantity; const ARight: TQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TVecQuantity; const ARight: TCL3TrivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.-(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  if ALeft.FID <> ARight.FID then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TQuantity; const ARight: TVecQuantity): TVecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TVecQuantity; const ARight: TQuantity): TVecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft, ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TVecQuantity; const ARight: TCL3TrivecQuantity): TBivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TVecQuantity): TBivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity.*(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TVecQuantity./(const ALeft, ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./ (const ALeft: TVecQuantity; const ARight: TQuantity): TVecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TVecQuantity./(const ALeft: TQuantity; const ARight: TVecQuantity): TVecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TVecQuantity; const ARight: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TBivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TVecQuantity; const ARight: TCL3TrivecQuantity): TBivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TVecQuantity): TBivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TMultivecQuantity; const ARight: TVecQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TVecQuantity./(const ALeft: TVecQuantity; const ARight: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := DivTable[ALeft.FID, ARight.FID];
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

// TMultivecQuantityHelper

{$IFDEF ADIMDEBUG}
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
  result.FID := DivTable[ScalarId, FID];
  result.FValue := FValue.Reciprocal;
end;

function TMultivecQuantityHelper.LeftReciprocal: TMultivecQuantity;
begin
  result.FID := DivTable[ScalarId, FID];
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
  result.FID := MulTable[FID, FID];
  result.FValue := FValue.SquaredNorm;
end;

function TMultivecQuantityHelper.Dot(const AVector: TVecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivecQuantityHelper.Dot(const AVector: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivecQuantityHelper.Dot(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TMultivecQuantityHelper.Wedge(const AVector: TVecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivecQuantityHelper.Wedge(const AVector: TBivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TMultivecQuantityHelper.Wedge(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
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

function TMultivecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TMultivecQuantity;
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

function TMultivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
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

function TMultivecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TMultivecQuantity;
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

function TMultivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TMultivecQuantity;
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

function TMultivecQuantityHelper.SameValue(const AVector: TCL3TrivecQuantity): boolean;
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

function TMultivecQuantityHelper.ExtractTrivector: TCL3TrivecQuantity;
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

// TCL3TrivecQuantityHelper

{$IFDEF ADIMDEBUG}
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
  result.FID := DivTable[ScalarId, FID];
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
  result.FID := MulTable[FID, FID];
  result.FValue := FValue.SquaredNorm;
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TVecQuantity): TBivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TBivecQuantity): TVecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TVecQuantity): TQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TBivecQuantity): TQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TMultivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TVecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TBivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TMultivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TVecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TBivecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := FID;
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TVecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TBivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TMultivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TVecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TBivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TMultivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.SameValue(const AVector: TMultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.SameValue(const AVector: TCL3TrivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.ToMultivector: TMultivecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TBivecQuantityHelper

{$IFDEF ADIMDEBUG}
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
  result.FID := DivTable[ScalarId, FID];
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
  result.FID := MulTable[FID, FID];
  result.FValue := FValue.SquaredNorm;
end;

function TBivecQuantityHelper.Dot(const AVector: TVecQuantity): TVecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivecQuantityHelper.Dot(const AVector: TBivecQuantity): TQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TVecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivecQuantityHelper.Dot(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TBivecQuantityHelper.Wedge(const AVector: TVecQuantity): TCL3TrivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TBivecQuantityHelper.Wedge(const AVector: TBivecQuantity): TQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := 0.0;
end;

function TBivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := 0.0;
end;

function TBivecQuantityHelper.Wedge(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
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

function TBivecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TBivecQuantity;
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

function TBivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
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

function TBivecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TBivecQuantity;
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

function TBivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TBivecQuantity;
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

{$IFDEF ADIMDEBUG}
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
  result.FID := DivTable[ScalarId, FID];
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
  result.FID := MulTable[FID, FID];
  result.FValue := FValue.SquaredNorm;
end;

function TVecQuantityHelper.Dot(const AVector: TVecQuantity): TQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVecQuantityHelper.Dot(const AVector: TBivecQuantity): TVecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TBivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVecQuantityHelper.Dot(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TVecQuantityHelper.Wedge(const AVector: TVecQuantity): TBivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TVecQuantityHelper.Wedge(const AVector: TBivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TVecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := MulTable[FID, FID];
  result.FValue := 0.0;
end;

function TVecQuantityHelper.Wedge(const AVector: TMultivecQuantity): TMultivecQuantity;
begin
  result.FID := MulTable[FID, AVector.FID];
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

function TVecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TVecQuantity;
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

function TVecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
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

function TVecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TVecQuantity;
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

function TVecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TVecQuantity;
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
  result.FID := MulTable[FID, AVector.FID];
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
