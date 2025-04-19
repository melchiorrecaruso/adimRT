{ Complex numbers implementation }

// TComplex

function TComplex.Dual: TComplex;
begin
  result.fRe :=  fRe;
  result.fIm := -fIm;
end;

function TComplex.IsNull: boolean;
begin
  result := Math.SameValue(fRe, 0) and
            Math.SameValue(fIm, 0);
end;

function TComplex.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TComplex.Norm: double;
begin
  result := hypot(fRe, fIm);
end;

function TComplex.Reciprocal: TComplex;
begin
  result := Dual / SquaredNorm;
end;

function TComplex.SquaredNorm: double;
begin
  result := sqr(fRe) + sqr(fIm);
end;

function TComplex.ToString: string;
var
  sign: array[boolean] of string = ('+', '-');
begin
  if (not Math.SameValue(fRe, 0)) and
     (not Math.SameValue(fIm, 0)) then
  begin
    if (Math.SameValue(Abs(fIm), 1)) then
      result := Format('%s %si', [FloatToStr(fRe), sign[fIm < 0]])
    else
      result := Format('%s %s%s∙i', [FloatToStr(fRe), sign[fIm < 0], FloatToStr(Abs(fIm))]);
  end else
    if (not Math.SameValue(fRe, 0)) then
      result := Format('%s', [FloatToStr(fRe)])
    else
      if (not Math.SameValue(fIm, 0)) then
      begin
        if (Math.SameValue(fIm, 1)) then
          result := 'i'
        else if (Math.SameValue(fIm, -1)) then
          result := '-i'
        else
          result := Format('%s∙i', [FloatToStr(fIm)])
      end else
        result := '0';
end;

function TComplex.ToString(APrecision, ADigits: integer): string;
var
  sign: array[boolean] of string = ('+', '-');
begin
  if (not Math.SameValue(fRe, 0)) and
     (not Math.SameValue(fIm, 0)) then
  begin
    if (Math.SameValue(Abs(fIm), 1)) then
      result := Format('%s %si', [FloatToStrF(fRe, ffGeneral, APrecision, ADigits), sign[fIm < 0]])
    else
      result := Format('%s %s%s∙i', [FloatToStrF(fRe,      ffGeneral, APrecision, ADigits), sign[fIm < 0],
                                     FloatToStrF(Abs(fIm), ffGeneral, APrecision, ADigits)]);
  end else
    if (not Math.SameValue(fRe, 0)) then
      result := Format('%s', [FloatToStrF(fRe, ffGeneral, APrecision, ADigits)])
    else
      if (not Math.SameValue(fIm, 0)) then
      begin
        if (Math.SameValue(fIm, 1)) then
          result := 'i'
        else if (Math.SameValue(fIm, -1)) then
          result := '-i'
        else
          result := Format('%s∙i', [FloatToStrF(fIm, ffGeneral, APrecision, ADigits)])
      end else
        result := '0';
end;

class operator TComplex.:=(const AValue: double): TComplex;
begin
  result.fRe := AValue;
  result.fIm := 0;
end;

class operator TComplex.=(const ALeft, ARight: TComplex): boolean;
begin
  result := (ALeft.fRe = ARight.fRe) and
            (ALeft.fIm = ARight.fIm);
end;

class operator TComplex.<>(const ALeft, ARight: TComplex): boolean;
begin
  result := (ALeft.fRe <> ARight.fRe) or
            (ALeft.fIm <> ARight.fIm);
end;

class operator TComplex.+(const AValue: TComplex): TComplex;
begin
  result.fRe := AValue.fRe;
  result.fIm := AValue.fIm;
end;

class operator TComplex.+(const ALeft, ARight: TComplex): TComplex;
begin
  result.fRe := ALeft.fRe + ARight.fRe;
  result.fIm := ALeft.fIm + ARight.fIm;
end;

class operator TComplex.+(const ALeft: double; const ARight: TComplex): TComplex;
begin
  result.fRe := ALeft + ARight.fRe;
  result.fIm :=         ARight.fIm;
end;

class operator TComplex.+(const ALeft: TComplex; const ARight: double): TComplex;
begin
  result.fRe := ALeft.fRe + ARight;
  result.fIm := ALeft.fIm;
end;

class operator TComplex.-(const AValue: TComplex): TComplex;
begin
  result.fRe := -AValue.fRe;
  result.fIm := -AValue.fIm;
end;

class operator TComplex.-(const ALeft, ARight: TComplex): TComplex;
begin
  result.fRe := ALeft.fRe - ARight.fRe;
  result.fIm := ALeft.fIm - ARight.fIm;
end;

class operator TComplex.-(const ALeft: double; const ARight: TComplex): TComplex; inline;
begin
  result.fRe := ALeft - ARight.fRe;
  result.fIm :=       - ARight.fIm;;
end;

class operator TComplex.-(const ALeft: TComplex; const ARight: double): TComplex; inline;
begin
  result.fRe := ALeft.fRe - ARight;
  result.fIm := ALeft.fIm;
end;

class operator TComplex.*(const ALeft, ARight: TComplex): TComplex;
begin
  result.fRe := ALeft.fRe * ARight.fRe - ALeft.fIm * ARight.fIm;
  result.fIm := ALeft.fRe * ARight.fIm + ALeft.fIm * ARight.fRe;
end;

class operator TComplex.*(const ALeft: double; const ARight: TComplex): TComplex; inline;
begin
  result.fRe := ALeft * ARight.fRe;
  result.fIm := ALeft * ARight.fIm;
end;

class operator TComplex.*(const ALeft: TComplex; const ARight: double): TComplex; inline;
begin
  result.fRe := ALeft.fRe * ARight;
  result.fIm := ALeft.fIm * ARight;
end;

class operator TComplex./(const ALeft, ARight: TComplex): TComplex;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TComplex./(const ALeft: double; const ARight: TComplex): TComplex; inline;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TComplex./(const ALeft: TComplex; const ARight: double): TComplex; inline;
begin
  result.fRe := ALeft.fRe / ARight;
  result.fIm := ALeft.fIm / ARight;
end;

// TComplexQuantity

{$IFNDEF ADIMOFF}
class operator TComplexQuantity.:=(const AQuantity: TQuantity): TComplexQuantity;
begin
  result.FID := AQuantity.FID;
  result.FValue := AQuantity.FValue;
end;

class operator TComplexQuantity.=(const ALeft, ARight: TComplexQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TComplexQuantity.<>(const ALeft, ARight: TComplexQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TComplexQuantity.+(const AValue: TComplexQuantity): TComplexQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TComplexQuantity.+(const ALeft, ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TComplexQuantity.-(const AValue: TComplexQuantity): TComplexQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := -AValue.FValue;
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

class operator TComplexQuantity.*(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FID := CheckMul(ScalarID, ARight.FID);
  result.FValue := ALeft * ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ScalarID);
  result.FValue := ALeft.FValue * ARight;
end;

class operator TComplexQuantity./(const ALeft, ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TComplexQuantity./(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FID := CheckDiv(ScalarID, ARight.FID);
  result.FValue := ALeft / ARight.FValue;
end;

class operator TComplexQuantity./(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ScalarID);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TComplexQuantity.+(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TComplexQuantity.+(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TComplexQuantity.-(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TComplexQuantity.-(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TComplexQuantity./(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TComplexQuantity./(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

// TImaginayUnit

class operator TImaginaryNumber.:=(const ASelf: TImaginaryNumber): TComplex;
begin
  result.fRe := 0;
  result.fIm := 1;
end;

class operator TImaginaryNumber.+(const ALeft: double; const ARight: TImaginaryNumber): TComplex;
begin
  result.fRe := ALeft;
  result.fIm := 1;
end;

class operator TImaginaryNumber.+(const ALeft: TImaginaryNumber; const ARight: double): TComplex;
begin
  result.fRe := ARight;
  result.fIm := 1;
end;

class operator TImaginaryNumber.-(const ALeft: double; const ARight: TImaginaryNumber): TComplex;
begin
  result.fRe := ALeft;
  result.fIm := -1;
end;

class operator TImaginaryNumber.-(const ALeft: TImaginaryNumber; const ARight: double): TComplex;
begin
  result.fRe := -ARight;
  result.fIm := 1;
end;

class operator TImaginaryNumber.+(const ALeft: TComplex; const ARight: TImaginaryNumber): TComplex;
begin
  result.fRe := ALeft.fRe;
  result.fIm := ALeft.fIm + 1;
end;

class operator TImaginaryNumber.+(const ALeft: TImaginaryNumber; const ARight: TComplex): TComplex;
begin
  result.fRe := ARight.fRe;
  result.fIm := ARight.fIm + 1;
end;

class operator TImaginaryNumber.-(const ALeft: TComplex; const ARight: TImaginaryNumber): TComplex;
begin
  result.fRe := ALeft.fRe;
  result.fIm := ALeft.fIm - 1;
end;

class operator TImaginaryNumber.-(const ALeft: TImaginaryNumber; const ARight: TComplex): TComplex;
begin
  result.fRe :=   -ARight.fRe;
  result.fIm := 1 -ARight.fIm;
end;

class operator TImaginaryNumber.*(const ALeft: double; const ARight: TImaginaryNumber): TComplex;
begin
  result.fRe := 0;
  result.fIm := ALeft;
end;

class operator TImaginaryNumber.*(const ALeft: TImaginaryNumber; const ARight: double): TComplex;
begin
  result.fRe := 0;
  result.fIm := ARight;
end;

class operator TImaginaryNumber.*(const ALeft: TComplex; const ARight: TImaginaryNumber): TComplex;
begin
  result.fRe := -ALeft.fIm;
  result.fIm :=  ALeft.fRe;
end;

class operator TImaginaryNumber.*(const ALeft: TImaginaryNumber; const ARight: TComplex): TComplex;
begin
  result.fRe := -ARight.fIm;
  result.fIm :=  ARight.fRe;
end;

class operator TImaginaryNumber./(const ALeft: double; const ARight: TImaginaryNumber): TComplex;
begin
  result.fRe :=  0;
  result.fIm := -ALeft;
end;

class operator TImaginaryNumber./(const ALeft: TImaginaryNumber; const ARight: double): TComplex;
begin
  result.fRe := 0;
  result.fIm := 1/ARight;
end;

class operator TImaginaryNumber./(const ALeft: TComplex; const ARight: TImaginaryNumber): TComplex;
begin
  result.fRe :=  ALeft.fIm;
  result.fIm := -ALeft.fRe;
end;

class operator TImaginaryNumber./(const ALeft: TImaginaryNumber; const ARight: TComplex): TComplex;
begin
  result.fRe := -ARight.fIm;
  result.fIm :=  ARight.fRe;
end;

{$IFNDEF ADIMOFF}
class operator TImaginaryNumber.*(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;
const
  i: TImaginaryNumber = ();
begin
  result.FID := CheckMul(ALeft.FID, ScalarID);
  result.FValue := ALeft.FValue * i;
end;

class operator TImaginaryNumber.*(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;
const
  i: TImaginaryNumber = ();
begin
  result.FID := CheckMul(ScalarID, ARight.FID);
  result.FValue := ARight.FValue * i;
end;

class operator TImaginaryNumber./(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;
const
  i: TImaginaryNumber = ();
begin
  result.FID := CheckDiv(ALeft.FID, ScalarID);
  result.FValue := ALeft.FValue / i;
end;

class operator TImaginaryNumber./(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;
const
  i: TImaginaryNumber = ();
begin
  result.FID := CheckDiv(ScalarID, ARight.FID);
  result.FValue := i / ARight.FValue;
end;
{$ENDIF}

