{ Extra routines implementation }

// Versors

class operator TR2Versor1.*(const AValue: double; const ASelf: TR2Versor1): TR2Vector;
begin
  result[1] := AValue;
  result[2] := 0;
end;

class operator TR2Versor2.*(const AValue: double; const ASelf: TR2Versor2): TR2Vector;
begin
  result[1] := 0;
  result[2] := AValue;
end;

class operator TR3Versor1.*(const AValue: double; const ASelf: TR3Versor1): TR3Vector;
begin
  result[1] := AValue;
  result[2] := 0;
  result[3] := 0;
end;

class operator TR3Versor2.*(const AValue: double; const ASelf: TR3Versor2): TR3Vector;
begin
  result[1] := 0;
  result[2] := AValue;
  result[3] := 0;
end;

class operator TR3Versor3.*(const AValue: double; const ASelf: TR3Versor3): TR3Vector;
begin
  result[1] := 0;
  result[2] := 0;
  result[3] := AValue;
end;

class operator TR4Versor1.*(const AValue: double; const ASelf: TR4Versor1): TR4Vector;
begin
  result[1] := AValue;
  result[2] := 0;
  result[3] := 0;
  result[4] := 0;
end;

class operator TR4Versor2.*(const AValue: double; const ASelf: TR4Versor2): TR4Vector;
begin
  result[1] := 0;
  result[2] := AValue;
  result[3] := 0;
  result[4] := 0;
end;

class operator TR4Versor3.*(const AValue: double; const ASelf: TR4Versor3): TR4Vector;
begin
  result[1] := 0;
  result[2] := 0;
  result[3] := AValue;
  result[4] := 0;
end;

class operator TR4Versor4.*(const AValue: double; const ASelf: TR4Versor4): TR4Vector;
begin
  result[1] := 0;
  result[2] := 0;
  result[3] := 0;
  result[4] := AValue;
end;

// Power and root functions

function ComplexSquarePower(const AValue: TComplex): TComplex;
begin
  result := AValue*AValue;
end;

function ComplexCubicPower(const AValue: TComplex): TComplex;
begin
  result := AValue*AValue*AValue;
end;

function ComplexQuarticPower(const AValue: TComplex): TComplex;
begin
  result := AValue*AValue*AValue*AValue;
end;

function ComplexSquareRoot(const AValue: TComplex): TC2ArrayOfComplex;
var
  norm: double;
begin
  norm := hypot(AValue.fRe, AValue.fIm);
  result[1].fRe := sqrt(0.5*(norm + AValue.fRe));
  if AValue.fIm >= 0 then
    result[1].fIm := sqrt(0.5*(norm - AValue.fRe))
  else
    result[1].fIm := -sqrt(0.5*(norm - AValue.fRe));
  result[2] := -result[1];
end;

function ComplexCubicRoot(const AValue: TComplex): TC3ArrayOfComplex;
const
  i: TImaginaryNumber = ();
var
  theta, rootModulus, rootArgument: double;
begin
  rootModulus := Power(AValue.Norm, 1/3);
  theta := Math.ArcTan2(AValue.fIm, AValue.fRe);

  rootArgument := (theta)/3;
  result[1] := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);

  rootArgument := (theta+2*Pi)/3;
  result[2] := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);

  rootArgument := (theta+4*Pi)/3;
  result[3] := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);
end;

function ComplexQuarticRoot(const AValue: TComplex): TC4ArrayOfComplex;
const
  i: TImaginaryNumber = ();
var
  theta, rootModulus, rootArgument: double;
begin
  rootModulus := Power(AValue.Norm, 1/4);
  theta := Math.ArcTan2(AValue.fIm, AValue.fRe);

  rootArgument := (theta)/4;
  result[1] := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);

  rootArgument := (theta+2*Pi)/4;
  result[2] := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);

  rootArgument := (theta+4*Pi)/4;
  result[3] := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);

  rootArgument := (theta+6*Pi)/4;
  result[4] := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);
end;

{$IFNDEF ADIMOFF}
function ComplexSquarePower(const AQuantity: TComplexQuantity): TComplexQuantity;
begin
  result.FID := 2 * AQuantity.FID;
  result.FValue := AQuantity.FValue*AQuantity.FValue;
end;

function ComplexCubicPower(const AQuantity: TComplexQuantity): TComplexQuantity;
begin
  result.FID := 3 * AQuantity.FID;
  result.FValue := AQuantity.FValue*AQuantity.FValue*AQuantity.FValue;
end;

function ComplexQuarticPower(const AQuantity: TComplexQuantity): TComplexQuantity;
begin
  result.FID := 4 * AQuantity.FID;
  result.FValue := AQuantity.FValue*AQuantity.FValue*AQuantity.FValue*AQuantity.FValue;
end;
{$ENDIF}

// Usefull routines

function ToComplex(const AValue: double): TComplex;
begin
  result.FRe := AValue;
  result.FIm := 0;
end;

function Abs(const AValue: double): double;
begin
  result := System.Abs(AValue);
end;

function Abs(const AValue: TComplex): double;
begin
  result := AValue.Norm;
end;

function Commutator(const ALeft, ARight: TC2Matrix): TC2Matrix;
begin
  result := ALeft*ARight - ARight*ALeft;
end;

function Commutator(const ALeft, ARight: TC3Matrix): TC3Matrix;
begin
  result := ALeft*ARight - ARight*ALeft;
end;

function Commutator(const ALeft, ARight: TC4Matrix): TC4Matrix;
begin
  result := ALeft*ARight - ARight*ALeft;
end;

function SameValueEx(const AValue1, AValue2: double): boolean;
begin
  result := Math.SameValue(AValue1, AValue2, DefaultEpsilon);
end;

{$IFNDEF ADIMOFF}
function SameValueEx(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := SameValueEx(ALeft.FValue, ARight.FValue);
end;
{$ENDIF}

function SameValueEx(const AValue1, AValue2: TComplex): boolean;
begin
  result := SameValueEx(AValue1.fRe, AValue2.fRe) and
            SameValueEx(AValue1.fIm, AValue2.fIm);
end;

function SameValueEx(const AValue1, AValue2: TC2Vector): boolean;
begin
  result := SameValueEx(AValue1.fm[1], AValue2.fm[1]) and
            SameValueEx(AValue1.fm[2], AValue2.fm[2]);
end;

function SameValueEx(const AValue1, AValue2: TC3Vector): boolean;
begin
  result := SameValueEx(AValue1.fm[1], AValue2.fm[1]) and
            SameValueEx(AValue1.fm[2], AValue2.fm[2]) and
            SameValueEx(AValue1.fm[3], AValue2.fm[3]);
end;

function SameValueEx(const AValue1, AValue2: TC4Vector): boolean;
begin
  result := SameValueEx(AValue1.fm[1], AValue2.fm[1]) and
            SameValueEx(AValue1.fm[2], AValue2.fm[2]) and
            SameValueEx(AValue1.fm[3], AValue2.fm[3]) and
            SameValueEx(AValue1.fm[4], AValue2.fm[4]);
end;

function SameValueEx(const AValue1, AValue2: TC2Matrix): boolean;
begin
  result := SameValueEx(AValue1.fm[1,1], AValue2.fm[1,1]) and
            SameValueEx(AValue1.fm[1,2], AValue2.fm[1,2]) and

            SameValueEx(AValue1.fm[2,1], AValue2.fm[2,1]) and
            SameValueEx(AValue1.fm[2,2], AValue2.fm[2,2]);
end;

function SameValueEx(const AValue1, AValue2: TC3Matrix): boolean;
begin
  result := SameValueEx(AValue1.fm[1,1], AValue2.fm[1,1]) and
            SameValueEx(AValue1.fm[1,2], AValue2.fm[1,2]) and
            SameValueEx(AValue1.fm[1,3], AValue2.fm[1,3]) and

            SameValueEx(AValue1.fm[2,1], AValue2.fm[2,1]) and
            SameValueEx(AValue1.fm[2,2], AValue2.fm[2,2]) and
            SameValueEx(AValue1.fm[2,3], AValue2.fm[2,3]) and

            SameValueEx(AValue1.fm[3,1], AValue2.fm[3,1]) and
            SameValueEx(AValue1.fm[3,2], AValue2.fm[3,2]) and
            SameValueEx(AValue1.fm[3,3], AValue2.fm[3,3]);
end;

function SameValueEx(const AValue1, AValue2: TC4Matrix): boolean;
begin
  result := SameValueEx(AValue1.fm[1,1], AValue2.fm[1,1]) and
            SameValueEx(AValue1.fm[1,2], AValue2.fm[1,2]) and
            SameValueEx(AValue1.fm[1,3], AValue2.fm[1,3]) and
            SameValueEx(AValue1.fm[1,4], AValue2.fm[1,4]) and

            SameValueEx(AValue1.fm[2,1], AValue2.fm[2,1]) and
            SameValueEx(AValue1.fm[2,2], AValue2.fm[2,2]) and
            SameValueEx(AValue1.fm[2,3], AValue2.fm[2,3]) and
            SameValueEx(AValue1.fm[2,4], AValue2.fm[2,4]) and

            SameValueEx(AValue1.fm[3,1], AValue2.fm[3,1]) and
            SameValueEx(AValue1.fm[3,2], AValue2.fm[3,2]) and
            SameValueEx(AValue1.fm[3,3], AValue2.fm[3,3]) and
            SameValueEx(AValue1.fm[3,4], AValue2.fm[3,4]) and

            SameValueEx(AValue1.fm[4,1], AValue2.fm[4,1]) and
            SameValueEx(AValue1.fm[4,2], AValue2.fm[4,2]) and
            SameValueEx(AValue1.fm[4,3], AValue2.fm[4,3]) and
            SameValueEx(AValue1.fm[4,4], AValue2.fm[4,4]);
end;

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

// Solvers for linear, quadratic, cubic and quartic equation

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

