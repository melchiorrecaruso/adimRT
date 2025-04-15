{ Complex numbers implementation }

function TComplex.Dual: TComplex;
begin
  result.fRe :=  fRe;
  result.fIm := -fIm;
end;

function TComplex.Reciprocal: TComplex;
begin
  result := Dual / SquaredNorm;
end;

function TComplex.Norm: double;
begin
  result := hypot(fRe, fIm);
end;

function TComplex.SquaredNorm: double;
begin
  result := sqr(fRe) + sqr(fIm);
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

class operator TComplex.:=(const AValue: double): TComplex;
begin
  result.fRe := AValue;
  result.fIm := 0;
end;

{$IFNDEF ADIMOFF}
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
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;

class operator TComplexQuantity./(const ALeft: double; const ARight: TComplexQuantity): TComplexQuantity;
begin
  result.FID := CheckDiv(ScalarID, ARight.FID);
  result.FValue := ALeft * ARight.FValue.Reciprocal;
end;

class operator TComplexQuantity./(const ALeft: TComplexQuantity; const ARight: double): TComplexQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ScalarID);
  result.FValue := ALeft.FValue / ARight;
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

class operator TComplexQuantity.:=(const AQuantity: TQuantity): TComplexQuantity;
begin
  result.FID := AQuantity.FID;
  result.FValue := AQuantity.FValue;
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
  result.FID := CheckSum(ALeft.FID, ARight.FID);
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

// Useful routines

function SolveEquation(const a: double): double;
begin
  result := -a;
end;

function SolveEquation(const a: TComplex): TComplex;
begin
  result := -a;
end;

function SolveEquation(const a, b: TComplex): TC2ArrayOfComplex;
var
  delta: TComplex;
begin
  delta := ComplexSquareRoot(ComplexSquarePower(a) - 4*b)[1];
  result[1] := (-a + delta)/2;
  result[2] := (-a - delta)/2;
end;

function SolveEquation(const a, b, c: TComplex): TC3ArrayOfComplex;
var
  p, q, s1, t: TComplex;

  u: TC3ArrayOfComplex;
  v: TC2ArrayOfComplex;
begin
  p := 9*b -3*ComplexSquarePower(a);
  q := 27*c -9*a*b +2*ComplexCubicPower(a);

  if p.IsNotNull and q.IsNotNull then
  begin
    s1 := -q/2 + ComplexSquareRoot(ComplexSquarePower(q)/4 + ComplexCubicPower(p)/27)[1];
  //s2 := -q/2 - ComplexSquareRoot(ComplexSquarePower(q)/4 + ComplexCubicPower(p)/27)[2];
    u := ComplexCubicRoot(s1);
    t := u[1] - p/(3*u[1]); result[1] := (t - a)/3;
    t := u[2] - p/(3*u[2]); result[2] := (t - a)/3;
    t := u[3] - p/(3*u[3]); result[3] := (t - a)/3;
  end else
    if p.IsNull and q.IsNull then
    begin
      result[1] := -a/3;
      result[2] := -a/3;
      result[3] := -a/3;
    end else
      if q.IsNull then
      begin
        v := ComplexSquareRoot(p);
        result[1] := 0;
        result[2] := v[1];
        result[3] := v[2];
      end else
      begin
        u := ComplexCubicRoot(q);
        result[1] := u[1];
        result[2] := u[2];
        result[3] := u[3];
      end;
end;

function SolveEquation(const a, b, c, d: TComplex): TC4ArrayOfComplex;
var
  p, q, r: TComplex;
  u1, u2, u3: TC2ArrayOfComplex;
  v1: TC3ArrayOfComplex;
  v2, v3: TC2ArrayOfComplex;

  alpha: TComplex;
  beta: TComplex;
  gamma: Tcomplex;
begin
  p := 16*b -6*ComplexSquarePower(a);
  q := 64*c -32*a*b +8*ComplexCubicPower(a);
  r := 256*d -64*a*c +16*b*ComplexSquarePower(a) -3*ComplexQuarticPower(a);

  if q.IsNull then
  begin
    u1 := SolveEquation(p, r);
    u2 := ComplexSquareRoot(u1[1]);
    u3 := ComplexSquareRoot(u1[2]);

    result[1] := (u2[1] -a)/4;
    result[2] := (u2[2] -a)/4;
    result[3] := (u3[1] -a)/4;
    result[4] := (u3[2] -a)/4;
  end else
  begin
    v1 := SolveEquation(2*p, ComplexSquarePower(p)-4*r, -ComplexSquarePower(q));

    alpha := ComplexSquareRoot(v1[1])[1];
    beta  := ((alpha*alpha*alpha)+p*alpha-q)/(2*alpha);
    gamma := ((alpha*alpha*alpha)+p*alpha+q)/(2*alpha);

    v2 := SolveEquation( alpha,  beta);
    v3 := SolveEquation(-alpha, gamma);

    result[1] := (v2[1] -a)/4;
    result[2] := (v2[2] -a)/4;
    result[3] := (v3[1] -a)/4;
    result[4] := (v3[2] -a)/4;
  end;
end;

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
  result.fIm := ALeft.fIm+1;
end;

class operator TImaginaryNumber.+(const ALeft: TImaginaryNumber; const ARight: TComplex): TComplex;
begin
  result.fRe :=   ARight.fRe;
  result.fIm := 1+ARight.fIm;
end;

class operator TImaginaryNumber.-(const ALeft: TComplex; const ARight: TImaginaryNumber): TComplex;
begin
  result.fRe := ALeft.fRe;
  result.fIm := ALeft.fIm-1;
end;

class operator TImaginaryNumber.-(const ALeft: TImaginaryNumber; const ARight: TComplex): TComplex;
begin
  result.fRe :=  -ARight.fRe;
  result.fIm := 1-ARight.fIm;
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
class operator TImaginaryNumber.*(const ALeft: TQuantity; const ARight: TSelf): TComplexQuantity;
const
  i: TSelf = ();
begin
  result.FID := CheckMul(ALeft.FID, ScalarID);
  result.FValue := ALeft.FValue * i;
end;

class operator TImaginaryNumber.*(const ALeft: TSelf; const ARight: TQuantity): TComplexQuantity;
const
  i: TSelf = ();
begin
  result.FID := CheckMul(ScalarID, ARight.FID);
  result.FValue := ARight.FValue * i;
end;

class operator TImaginaryNumber./(const ALeft: TQuantity; const ARight: TSelf): TComplexQuantity;
const
  i: TSelf = ();
begin
  result.FID := CheckDiv(ALeft.FID, ScalarID);
  result.FValue := -ALeft.FValue * i;
end;

class operator TImaginaryNumber./(const ALeft: TSelf; const ARight: TQuantity): TComplexQuantity;
const
  i: TSelf = ();
begin
  result.FID := CheckDiv(ScalarID, ARight.FID);
  result.FValue := i / ARight.FValue;
end;
{$ENDIF}

// Usefull routines

function NullComplex: TComplex;
begin
  result.FRe := 0;
  result.FIm := 0;
end;

function C2NullVector: TC2Vector;
begin
  result[1] := 0;
  result[2] := 0;
end;

function C3NullVector: TC3Vector;
begin
  result[1] := 0;
  result[2] := 0;
  result[3] := 0;
end;

function C4NullVector: TC4Vector;
begin
  result[1] := 0;
  result[2] := 0;
  result[3] := 0;
  result[4] := 0;
end;

function C2NullTransposedVector: TC2TransposedVector;
begin
  result[1] := 0;
  result[2] := 0;
end;

function C3NullTransposedVector: TC3TransposedVector;
begin
  result[1] := 0;
  result[2] := 0;
  result[3] := 0;
end;

function C4NullTransposedVector: TC4TransposedVector;
begin
  result[1] := 0;
  result[2] := 0;
  result[3] := 0;
  result[4] := 0;
end;

function C2NullMatrix: TC2Matrix;
begin
  result[1,1] := 0;
  result[1,2] := 0;
  result[2,1] := 0;
  result[2,2] := 0;
end;

function C3NullMatrix: TC3Matrix;
begin
  result[1,1] := 0;
  result[1,2] := 0;
  result[1,3] := 0;
  result[2,1] := 0;
  result[2,2] := 0;
  result[2,3] := 0;
  result[3,1] := 0;
  result[3,2] := 0;
  result[3,3] := 0;
end;

function C4NullMatrix: TC4Matrix;
begin
  result[1,1] := 0;
  result[1,2] := 0;
  result[1,3] := 0;
  result[1,4] := 0;

  result[2,1] := 0;
  result[2,2] := 0;
  result[2,3] := 0;
  result[2,4] := 0;

  result[3,1] := 0;
  result[3,2] := 0;
  result[3,3] := 0;
  result[3,4] := 0;

  result[4,1] := 0;
  result[4,2] := 0;
  result[4,3] := 0;
  result[4,4] := 0;
end;

function C2IdMatrix: TC2Matrix;
begin
  result[1,1] := 1;
  result[1,2] := 0;

  result[2,1] := 0;
  result[2,2] := 1;
end;

function C3IdMatrix: TC3Matrix;
begin
  result[1,1] := 1;
  result[1,2] := 0;
  result[1,3] := 0;

  result[2,1] := 0;
  result[2,2] := 1;
  result[2,3] := 0;

  result[3,1] := 0;
  result[3,2] := 0;
  result[3,3] := 1;
end;

function C4IdMatrix: TC4Matrix;
begin
  result[1,1] := 1;
  result[1,2] := 0;
  result[1,3] := 0;
  result[1,4] := 0;

  result[2,1] := 0;
  result[2,2] := 1;
  result[2,3] := 0;
  result[2,4] := 0;

  result[3,1] := 0;
  result[3,2] := 0;
  result[3,3] := 1;
  result[3,4] := 0;

  result[4,1] := 0;
  result[4,2] := 0;
  result[4,3] := 0;
  result[4,4] := 1;
end;

