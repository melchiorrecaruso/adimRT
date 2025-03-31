
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

// Usefull routines

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

