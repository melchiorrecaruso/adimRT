
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

function SameValue(const AValue1, AValue2: double): boolean;
begin
  result := Math.SameValue(AValue1, AValue2);
end;

{$IFNDEF ADIMOFF}
function SameValue(const ALeft, ARight: TQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := Math.SameValue(ALeft.FValue, ARight.FValue);
end;
{$ENDIF}

function SameValue(const AValue1, AValue2: TComplex): boolean;
begin
  result := Math.SameValue(AValue1.fRe, AValue2.fRe) and
            Math.SameValue(AValue1.fIm, AValue2.fIm);
end;

function SameValue(const AValue1, AValue2: TC2Vector): boolean;
begin
  result := SameValue(AValue1.fm[1], AValue2.fm[1]) and
            SameValue(AValue1.fm[2], AValue2.fm[2]);
end;
function SameValue(const AValue1, AValue2: TC3Vector): boolean;
begin
  result := SameValue(AValue1.fm[1], AValue2.fm[1]) and
            SameValue(AValue1.fm[2], AValue2.fm[2]) and
            SameValue(AValue1.fm[3], AValue2.fm[3]);
end;

function SameValue(const AValue1, AValue2: TC4Vector): boolean;
begin
  result := SameValue(AValue1.fm[1], AValue2.fm[1]) and
            SameValue(AValue1.fm[2], AValue2.fm[2]) and
            SameValue(AValue1.fm[3], AValue2.fm[3]) and
            SameValue(AValue1.fm[4], AValue2.fm[4]);
end;

function SameValue(const AValue1, AValue2: TC2TransposedVector): boolean;
begin
  result := SameValue(AValue1.fm[1], AValue2.fm[1]) and
            SameValue(AValue1.fm[2], AValue2.fm[2]);
end;

function SameValue(const AValue1, AValue2: TC3TransposedVector): boolean;
begin
  result := SameValue(AValue1.fm[1], AValue2.fm[1]) and
            SameValue(AValue1.fm[2], AValue2.fm[2]) and
            SameValue(AValue1.fm[3], AValue2.fm[3]);
end;

function SameValue(const AValue1, AValue2: TC4TransposedVector): boolean;
begin
  result := SameValue(AValue1.fm[1], AValue2.fm[1]) and
            SameValue(AValue1.fm[2], AValue2.fm[2]) and
            SameValue(AValue1.fm[3], AValue2.fm[3]) and
            SameValue(AValue1.fm[4], AValue2.fm[4]);
end;

function SameValue(const AValue1, AValue2: TC2Matrix): boolean;
begin
  result := SameValue(AValue1.fm[1,1], AValue2.fm[1,1]) and
            SameValue(AValue1.fm[1,2], AValue2.fm[1,2]) and

            SameValue(AValue1.fm[2,1], AValue2.fm[2,1]) and
            SameValue(AValue1.fm[2,2], AValue2.fm[2,2]);
end;

function SameValue(const AValue1, AValue2: TC3Matrix): boolean;
begin
  result := SameValue(AValue1.fm[1,1], AValue2.fm[1,1]) and
            SameValue(AValue1.fm[1,2], AValue2.fm[1,2]) and
            SameValue(AValue1.fm[1,3], AValue2.fm[1,3]) and

            SameValue(AValue1.fm[2,1], AValue2.fm[2,1]) and
            SameValue(AValue1.fm[2,2], AValue2.fm[2,2]) and
            SameValue(AValue1.fm[2,3], AValue2.fm[2,3]) and

            SameValue(AValue1.fm[3,1], AValue2.fm[3,1]) and
            SameValue(AValue1.fm[3,2], AValue2.fm[3,2]) and
            SameValue(AValue1.fm[3,3], AValue2.fm[3,3]);
end;

function SameValue(const AValue1, AValue2: TC4Matrix): boolean;
begin
  result := SameValue(AValue1.fm[1,1], AValue2.fm[1,1]) and
            SameValue(AValue1.fm[1,2], AValue2.fm[1,2]) and
            SameValue(AValue1.fm[1,3], AValue2.fm[1,3]) and
            SameValue(AValue1.fm[1,4], AValue2.fm[1,4]) and

            SameValue(AValue1.fm[2,1], AValue2.fm[2,1]) and
            SameValue(AValue1.fm[2,2], AValue2.fm[2,2]) and
            SameValue(AValue1.fm[2,3], AValue2.fm[2,3]) and
            SameValue(AValue1.fm[2,4], AValue2.fm[2,4]) and

            SameValue(AValue1.fm[3,1], AValue2.fm[3,1]) and
            SameValue(AValue1.fm[3,2], AValue2.fm[3,2]) and
            SameValue(AValue1.fm[3,3], AValue2.fm[3,3]) and
            SameValue(AValue1.fm[3,4], AValue2.fm[3,4]) and

            SameValue(AValue1.fm[4,1], AValue2.fm[4,1]) and
            SameValue(AValue1.fm[4,2], AValue2.fm[4,2]) and
            SameValue(AValue1.fm[4,3], AValue2.fm[4,3]) and
            SameValue(AValue1.fm[4,4], AValue2.fm[4,4]);
end;

