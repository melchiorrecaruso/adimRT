
// TComplex

function TComplex.Conjugate: TComplex;
begin
  result.fRe :=  fRe;
  result.fIm := -fIm;
end;

function TComplex.IsNull: boolean;
begin
  result := SameValueEx(fRe, 0) and
            SameValueEx(fIm, 0);
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
  result := Conjugate / SquaredNorm;
end;

function TComplex.SquaredNorm: double;
begin
  result := sqr(fRe) + sqr(fIm);
end;

function TComplex.ToString: string;
var
  sign: array[boolean] of string = ('+', '-');
begin
  if (not SameValueEx(fRe, 0)) and
     (not SameValueEx(fIm, 0)) then
  begin
    if (SameValueEx(Abs(fIm), 1)) then
      result := Format('%s %si', [FloatToStr(fRe), sign[fIm < 0]])
    else
      result := Format('%s %s%s∙i', [FloatToStr(fRe), sign[fIm < 0], FloatToStr(Abs(fIm))]);
  end else
    if (not SameValueEx(fRe, 0)) then
      result := Format('%s', [FloatToStr(fRe)])
    else
      if (not SameValueEx(fIm, 0)) then
      begin
        if (SameValueEx(fIm, 1)) then
          result := 'i'
        else if (SameValueEx(fIm, -1)) then
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
  if (not SameValueEx(fRe, 0)) and
     (not SameValueEx(fIm, 0)) then
  begin
    if (SameValueEx(Abs(fIm), 1)) then
      result := Format('%s %si', [FloatToStrF(fRe, ffGeneral, APrecision, ADigits), sign[fIm < 0]])
    else
      result := Format('%s %s%s∙i', [FloatToStrF(fRe,      ffGeneral, APrecision, ADigits), sign[fIm < 0],
                                     FloatToStrF(Abs(fIm), ffGeneral, APrecision, ADigits)]);
  end else
    if (not SameValueEx(fRe, 0)) then
      result := Format('%s', [FloatToStrF(fRe, ffGeneral, APrecision, ADigits)])
    else
      if (not SameValueEx(fIm, 0)) then
      begin
        if (SameValueEx(fIm, 1)) then
          result := 'i'
        else if (SameValueEx(fIm, -1)) then
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
  result.FDim := AQuantity.FDim;
  result.FValue := AQuantity.FValue;
end;

class operator TComplexQuantity.=(const ALeft, ARight: TComplexQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TComplexQuantity.<>(const ALeft, ARight: TComplexQuantity): boolean;
begin
  Check(ALeft.FDim, ARight.FDim);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TComplexQuantity.+(const AValue: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := AValue.FValue;
end;

class operator TComplexQuantity.+(const ALeft, ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TComplexQuantity.-(const AValue: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := AValue.FDim;
  result.FValue := -AValue.FValue;
end;

class operator TComplexQuantity.-(const ALeft, ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft, ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := CheckMul(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft * ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity;
begin
  result.FDim := CheckMul(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue * ARight;
end;

class operator TComplexQuantity./(const ALeft, ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TComplexQuantity./(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ALeft / ARight.FValue;
end;

class operator TComplexQuantity./(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity;
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / ARight;
end;

class operator TComplexQuantity.+(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TComplexQuantity.+(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckSum(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TComplexQuantity.-(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TComplexQuantity.-(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckSub(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TComplexQuantity.*(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckMul(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TComplexQuantity./(const ALeft: TQuantity; const ARight: TComplexQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TComplexQuantity./(const ALeft: TComplexQuantity; const ARight: TQuantity): TComplexQuantity; inline;
begin
  result.FDim := CheckDiv(ALeft.FDim, ARight.FDim);
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
  result.FDim := CheckMul(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue * i;
end;

class operator TImaginaryNumber.*(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;
const
  i: TImaginaryNumber = ();
begin
  result.FDim := CheckMul(ScalarUnit.FDim, ARight.FDim);
  result.FValue := ARight.FValue * i;
end;

class operator TImaginaryNumber./(const ALeft: TQuantity; const ARight: TImaginaryNumber): TComplexQuantity;
const
  i: TImaginaryNumber = ();
begin
  result.FDim := CheckDiv(ALeft.FDim, ScalarUnit.FDim);
  result.FValue := ALeft.FValue / i;
end;

class operator TImaginaryNumber./(const ALeft: TImaginaryNumber; const ARight: TQuantity): TComplexQuantity;
const
  i: TImaginaryNumber = ();
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, ARight.FDim);
  result.FValue := i / ARight.FValue;
end;
{$ENDIF}

