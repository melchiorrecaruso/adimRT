{ TQuantity implementation }

{$IFNDEF ADIMOFF}
class operator TQuantity.:=(const AValue: double): TQuantity;
begin
  result.FID := ScalarId;
  result.FValue := AValue;
end;

class operator TQuantity.+(const ASelf: TQuantity): TQuantity;
begin
  result.FID := ASelf.FID;
  result.FValue := ASelf.FValue;
end;

class operator TQuantity.-(const ASelf: TQuantity): TQuantity;
begin
  result.FID := ASelf.FID;
  result.FValue := -ASelf.FValue;
end;

class operator TQuantity.+(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.-(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.*(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity.*(const ALeft: double; const ARight: TQuantity): TQuantity;
begin
  result.FID := ARight.FID;
  result.FValue:= ALeft * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: double): TQuantity;
begin
  result.FID := ALeft.FID;
  result.FValue:= ALeft.FValue * ARight;
end;

class operator TQuantity./(const ALeft: double; const ARight: TQuantity): TQuantity;
begin
  result.FID := CheckDiv(ScalarId, ARight.FID);
  result.FValue:= ALeft / ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: double): TQuantity;
begin
  result.FID := ALeft.FID;
  result.FValue:= ALeft.FValue / ARight;
end;

class operator TQuantity.=(const ALeft, ARight: TQuantity): boolean; inline;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TQuantity.<(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue < ARight.FValue;
end;

class operator TQuantity.>(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue > ARight.FValue;
end;

class operator TQuantity.<=(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <= ARight.FValue;
end;

class operator TQuantity.>=(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue >= ARight.FValue;
end;

class operator TQuantity.<>(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;
{$ENDIF}

{$IFNDEF ADIMOFF}
class operator TQuantity.*(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;
const
  i: TImaginaryNumber = ();
begin
  result.FID := CheckMul(ALeft.FID, ScalarID);
  result.FValue := ALeft.FValue * i;
end;

class operator TQuantity.*(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;
const
  i: TImaginaryNumber = ();
begin
  result.FID := CheckMul(ScalarID, ARight.FID);
  result.FValue := ARight.FValue * i;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;
const
  i: TImaginaryNumber = ();
begin
  result.FID := CheckDiv(ALeft.FID, ScalarID);
  result.FValue := -ALeft.FValue * i;
end;

class operator TQuantity./(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;
const
  i: TImaginaryNumber = ();
begin
  result.FID := CheckDiv(ScalarID, ARight.FID);
  result.FValue := i / ARight.FValue;
end;
{$ENDIF}

{$IFNDEF ADIMOFF}
class operator TQuantity.*(const ALeft: TQuantity; const ARight: TC2MatrixQuantity): TC2MatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TC2MatrixQuantity; const ARight: TQuantity): TC2MatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: TC3MatrixQuantity): TC3MatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TC3MatrixQuantity; const ARight: TQuantity): TC3MatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: TC4MatrixQuantity): TC4MatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TC4MatrixQuantity; const ARight: TQuantity): TC4MatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: TR2MatrixQuantity): TR2MatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TR2MatrixQuantity; const ARight: TQuantity): TR2MatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: TR3MatrixQuantity): TR3MatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TR3MatrixQuantity; const ARight: TQuantity): TR3MatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: TR4MatrixQuantity): TR4MatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TR4MatrixQuantity; const ARight: TQuantity): TR4MatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

{$ENDIF}

{$IFNDEF ADIMOFF}
class operator TQuantity.+(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.+(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.-(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.-(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TQuantity./(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

{$IFNDEF ADIMOFF}
class operator TQuantity.*(const ALeft: TQuantity; const ARight: TC2VecQuantity): TC2VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TC2VecQuantity; const ARight: TQuantity): TC2VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: TC2VecQuantity): TC2VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity./(const ALeft: TC2VecQuantity; const ARight: TQuantity): TC2VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: TC3VecQuantity): TC3VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TC3VecQuantity; const ARight: TQuantity): TC3VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: TC3VecQuantity): TC3VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity./(const ALeft: TC3VecQuantity; const ARight: TQuantity): TC3VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: TC4VecQuantity): TC4VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TC4VecQuantity; const ARight: TQuantity): TC4VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: TC4VecQuantity): TC4VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity./(const ALeft: TC4VecQuantity; const ARight: TQuantity): TC4VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

{$IFNDEF ADIMOFF}
class operator TQuantity.*(const ALeft: TQuantity; const ARight: TR2VecQuantity): TR2VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TR2VecQuantity; const ARight: TQuantity): TR2VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: TR2VecQuantity): TR2VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity./(const ALeft: TR2VecQuantity; const ARight: TQuantity): TR2VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: TR3VecQuantity): TR3VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TR3VecQuantity; const ARight: TQuantity): TR3VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: TR3VecQuantity): TR3VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity./(const ALeft: TR3VecQuantity; const ARight: TQuantity): TR3VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: TR4VecQuantity): TR4VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TR4VecQuantity; const ARight: TQuantity): TR4VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: TR4VecQuantity): TR4VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity./(const ALeft: TR4VecQuantity; const ARight: TQuantity): TR4VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

{$IFNDEF ADIMOFF}
class operator TQuantity.<>(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TQuantity.<>(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TQuantity.=(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TQuantity.=(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TQuantity.+(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.+(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.-(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.-(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft: TCL3MultivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TQuantity.+(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.+(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.-(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.-(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;


class operator TQuantity.*(const ALeft, ARight: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft, ARight: TCL3TrivecQuantity): TQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TQuantity./(const ALeft: TCL3TrivecQuantity; const ARight: TQuantity): TCL3TrivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TQuantity.+(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.+(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.-(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.-(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft: TCL3BivecQuantity; const ARight: TQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TQuantity.+(const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.+(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.-(const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.-(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3VecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./ (const ALeft: TCL3VecQuantity; const ARight: TQuantity): TCL3VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

{$IFNDEF ADIMOFF}
operator *(const ALeft: TC2TransposedVecQuantity; const ARight: TC2VecQuantity): TComplexQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;
operator *(const ALeft: TC3TransposedVecQuantity; const ARight: TC3VecQuantity): TComplexQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

operator *(const ALeft: TC4TransposedVecQuantity; const ARight: TC4VecQuantity): TComplexQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;
{$ENDIF}
