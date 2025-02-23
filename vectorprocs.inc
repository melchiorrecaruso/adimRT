{ Vector implemenation }

// TVector

class operator TVector.<>(const ALeft, ARight: TVector): boolean;
begin
  result := (ALeft.fm1 <> ARight.fm1) or
            (ALeft.fm2 <> ARight.fm2) or
            (ALeft.fm3 <> ARight.fm3);
end;

class operator TVector.=(const ALeft, ARight: TVector): boolean;
begin
  result := (ALeft.fm1 = ARight.fm1) or
            (ALeft.fm2 = ARight.fm2) or
            (ALeft.fm3 = ARight.fm3);
end;

class operator TVector.+(const AValue: TVector): TVector;
begin
  result := AValue;
end;

class operator TVector.+(const ALeft, ARight: TVector): TVector;
begin
  result.fm1 := ALeft.fm1 + ARight.fm1;
  result.fm2 := ALeft.fm2 + ARight.fm2;
  result.fm3 := ALeft.fm3 + ARight.fm3;
end;

class operator TVector.-(const AValue: TVector): TVector;
begin
  result.fm1 := -AValue.fm1;
  result.fm2 := -AValue.fm2;
  result.fm3 := -AValue.fm3;
end;

class operator TVector.-(const ALeft, ARight: TVector): TVector;
begin
  result.fm1 := ALeft.fm1 - ARight.fm1;
  result.fm2 := ALeft.fm2 - ARight.fm2;
  result.fm3 := ALeft.fm3 - ARight.fm3;
end;

class operator TVector.*(const ALeft: double; const ARight: TVector): TVector;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TVector.*(const ALeft: TVector; const ARight: double): TVector;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TVector./ (const ALeft: TVector; const ARight: double): TVector;
begin
  result.fm1 := ALeft.fm1 / ARight;
  result.fm2 := ALeft.fm2 / ARight;
  result.fm3 := ALeft.fm3 / ARight;
end;

class operator TVector./(const ALeft: double; const ARight: TVector): TVector;
begin
  result := ALeft * ARight.Reciprocal;
end;

// TVectorHelper

function TVectorHelper.Reciprocal: TVector;
begin
  result := Self / SquaredNorm;
end;

function TVectorHelper.Normalized: TVector;
begin
  result := Self / Norm;
end;

function TVectorHelper.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TVectorHelper.SquaredNorm: double;
begin
  result := fm1*fm1 + fm2*fm2 + fm3*fm3;
end;

function TVectorHelper.Dot(const AVector: TVector): double;
begin
 result :=  fm1 * AVector.fm1
           +fm2 * AVector.fm2
           +fm3 * AVector.fm3;
end;

function TVectorHelper.Projection(const AVector: TVector): TVector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TVectorHelper.Rejection(const AVector: TVector): TVector;
begin
  result := Self - Dot(AVector) * AVector.Reciprocal;
end;

function TVectorHelper.Reflection(const AVector: TVector): TVector;
begin
  result := Projection(AVector.Normalized) - Rejection(AVector.Normalized);
end;

function TVectorHelper.Cross(const AVector: TVector): TVector;
begin
  result.fm1 :=  fm2*AVector.fm3 - fm3*AVector.fm2;
  result.fm2 :=  fm1*AVector.fm3 - fm3*AVector.fm1;
  result.fm3 :=  fm1*AVector.fm2 - fm2*AVector.fm1;
end;

function TVectorHelper.SameValue(const AValue: TVector): boolean;
begin
  result := Math.SameValue(fm1, AValue.fm1) and
            Math.SameValue(fm2, AValue.fm2) and
            Math.SameValue(fm3, AValue.fm3);
end;

function TVectorHelper.ExtractVector(AComponents: TVectorComponents): TVector;
begin
  result := NullVector;
  if vcm1 in AComponents then result.fm1 := fm1;
  if vcm2 in AComponents then result.fm2 := fm2;
  if vcm3 in AComponents then result.fm3 := fm3;
end;


function TVectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not Math.SameValue(fm1, 0.0) then result := result + Fmt(fm1,  APrecision, ADigits) + 'e1 ';
  if not Math.SameValue(fm2, 0.0) then result := result + Fmt(fm2,  APrecision, ADigits) + 'e2 ';
  if not Math.SameValue(fm3, 0.0) then result := result + Fmt(fm3,  APrecision, ADigits) + 'e3 ';

    i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

function TVectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not Math.SameValue(fm1, 0.0) then result := result + Fmt(fm1) + 'e1 ';
  if not Math.SameValue(fm2, 0.0) then result := result + Fmt(fm2) + 'e2 ';
  if not Math.SameValue(fm3, 0.0) then result := result + Fmt(fm3) + 'e3 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

// TVersors

class operator TVersor1.*(const AValue: double; const ASelf: TVersor1): TVector;
begin
  result.fm1 := AValue;
  result.fm2 := 0.0;
  result.fm3 := 0.0;
end;

class operator TVersor2.*(const AValue: double; const ASelf: TVersor2): TVector;
begin
  result.fm1 := 0.0;
  result.fm2 := AValue;
  result.fm3 := 0.0;
end;

class operator TVersor3.*(const AValue: double; const ASelf: TVersor3): TVector;
begin
  result.fm1 := 0.0;
  result.fm2 := 0.0;
  result.fm3 := AValue;
end;

// T2x2Matrix

function T2x2Matrix.Transpose: T2x2Matrix;
begin
  result.fm11 := fm11;
  result.fm12 := fm21;

  result.fm21 := fm12;
  result.fm22 := fm22;
end;

function T2x2Matrix.Determinant: double;
begin
  result := fm11*fm22 - fm12*fm21;
end;

function T2x2Matrix.Reciprocal(const ADeterminant: double): T2x2Matrix;
begin
  result.fm11 :=  fm22/ADeterminant;
  result.fm12 := -fm12/ADeterminant;
  result.fm21 := -fm21/ADeterminant;
  result.fm22 :=  fm11/ADeterminant;
end;

function T2x2Matrix.ToString: string;
begin
  result := Format('(%s, %s, %s, %s)',
    [FloatToStr(fm11), FloatToStr(fm12),
     FloatToStr(fm21), FloatToStr(fm22)]);
end;

class operator T2x2Matrix.+(const ALeft, ARight: T2x2Matrix): T2x2Matrix;
begin
  result.fm11 := ALeft.fm11 + ARight.fm11;
  result.fm12 := ALeft.fm12 + ARight.fm12;

  result.fm21 := ALeft.fm21 + ARight.fm21;
  result.fm22 := ALeft.fm22 + ARight.fm22;
end;

class operator T2x2Matrix.-(const ALeft, ARight: T2x2Matrix): T2x2Matrix;
begin
  result.fm11 := ALeft.fm11 - ARight.fm11;
  result.fm12 := ALeft.fm12 - ARight.fm12;

  result.fm21 := ALeft.fm21 - ARight.fm21;
  result.fm22 := ALeft.fm22 - ARight.fm22;
end;

class operator T2x2Matrix.*(const ALeft: double; const ARight: T2x2Matrix): T2x2Matrix;
begin
  result.fm11 := ALeft * ARight.fm11;
  result.fm12 := ALeft * ARight.fm12;

  result.fm21 := ALeft * ARight.fm21;
  result.fm22 := ALeft * ARight.fm22;
end;

class operator T2x2Matrix.*(const ALeft, ARight: T2x2Matrix): T2x2Matrix;
begin
  result.fm11 := ALeft.fm11*ARight.fm11 + ALeft.fm12*ARight.fm21;
  result.fm12 := ALeft.fm11*ARight.fm12 + ALeft.fm12*ARight.fm22;

  result.fm21 := ALeft.fm21*ARight.fm11 + ALeft.fm22*ARight.fm21;
  result.fm22 := ALeft.fm21*ARight.fm12 + ALeft.fm22*ARight.fm22;
end;

class operator T2x2Matrix.*(const ALeft: T2x2Matrix; const ARight: double): T2x2Matrix;
begin
  result.fm11 := ALeft.fm11 * ARight;
  result.fm12 := ALeft.fm12 * ARight;

  result.fm21 := ALeft.fm21 * ARight;
  result.fm22 := ALeft.fm22 * ARight;
end;

class operator T2x2Matrix./(const ALeft: T2x2Matrix; const ARight: double): T2x2Matrix;
begin
  result.fm11 := ALeft.fm11 / ARight;
  result.fm12 := ALeft.fm12 / ARight;

  result.fm21 := ALeft.fm21 / ARight;
  result.fm22 := ALeft.fm22 / ARight;
end;

class operator T2x2Matrix./(const ALeft: double; const ARight: T2x2Matrix): T2x2Matrix;
begin
  result := ALeft * ARight.Reciprocal(ARight.Determinant);
end;

class operator T2x2Matrix./(const ALeft, ARight: T2x2Matrix): T2x2Matrix;
begin
  result := ALeft * ARight.Reciprocal(ARight.Determinant);
end;

// T3x3Matrix

function T3x3Matrix.Transpose: T3x3Matrix;
begin
  result.fm11 := fm11;
  result.fm12 := fm21;
  result.fm13 := fm31;

  result.fm21 := fm12;
  result.fm22 := fm22;
  result.fm23 := fm32;

  result.fm31 := fm13;
  result.fm32 := fm23;
  result.fm33 := fm33;
end;

function T3x3Matrix.Determinant: double;
begin
  result :=  fm11*(fm22*fm33 -fm23*fm32)
            +fm12*(fm23*fm31 -fm21*fm33)
            +fm13*(fm21*fm32 -fm22*fm31);
end;

function T3x3Matrix.Reciprocal(const ADeterminant: double): T3x3Matrix;
begin
  result.fm11 :=  (fm22*fm33 -fm23*fm32) / ADeterminant;
  result.fm12 := -(fm12*fm33 -fm13*fm32) / ADeterminant;
  result.fm13 :=  (fm12*fm23 -fm13*fm22) / ADeterminant;
  result.fm21 := -(fm21*fm33 -fm23*fm31) / ADeterminant;
  result.fm22 :=  (fm11*fm33 -fm13*fm31) / ADeterminant;
  result.fm23 := -(fm11*fm23 -fm13*fm21) / ADeterminant;
  result.fm31 :=  (fm21*fm32 -fm22*fm31) / ADeterminant;
  result.fm32 := -(fm11*fm32 -fm12*fm31) / ADeterminant;
  result.fm33 :=  (fm11*fm22 -fm12*fm21) / ADeterminant;
end;

function T3x3Matrix.ToString: string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s)',
    [FloatToStr(fm11), FloatToStr(fm12), FloatToStr(fm13),
     FloatToStr(fm21), FloatToStr(fm22), FloatToStr(fm23),
     FloatToStr(fm31), FloatToStr(fm32), FloatToStr(fm33)]);
end;

class operator T3x3Matrix.+(const ALeft, ARight: T3x3Matrix): T3x3Matrix;
begin
  result.fm11 := ALeft.fm11 + ARight.fm11;
  result.fm12 := ALeft.fm12 + ARight.fm12;
  result.fm13 := ALeft.fm13 + ARight.fm13;

  result.fm21 := ALeft.fm21 + ARight.fm21;
  result.fm22 := ALeft.fm22 + ARight.fm22;
  result.fm23 := ALeft.fm23 + ARight.fm23;

  result.fm31 := ALeft.fm31 + ARight.fm31;
  result.fm32 := ALeft.fm32 + ARight.fm32;
  result.fm33 := ALeft.fm33 + ARight.fm33;
end;

class operator T3x3Matrix.-(const ALeft, ARight: T3x3Matrix): T3x3Matrix;
begin
  result.fm11 := ALeft.fm11 - ARight.fm11;
  result.fm12 := ALeft.fm12 - ARight.fm12;
  result.fm13 := ALeft.fm13 - ARight.fm13;

  result.fm21 := ALeft.fm21 - ARight.fm21;
  result.fm22 := ALeft.fm22 - ARight.fm22;
  result.fm23 := ALeft.fm23 - ARight.fm23;

  result.fm31 := ALeft.fm31 - ARight.fm31;
  result.fm32 := ALeft.fm32 - ARight.fm32;
  result.fm33 := ALeft.fm33 - ARight.fm33;
end;

class operator T3x3Matrix.*(const ALeft: double; const ARight: T3x3Matrix): T3x3Matrix;
begin
  result.fm11 := ALeft * ARight.fm11;
  result.fm12 := ALeft * ARight.fm12;
  result.fm13 := ALeft * ARight.fm13;

  result.fm21 := ALeft * ARight.fm21;
  result.fm22 := ALeft * ARight.fm22;
  result.fm23 := ALeft *ARight.fm23;

  result.fm31 := ALeft * ARight.fm31;
  result.fm32 := ALeft * ARight.fm32;
  result.fm33 := ALeft * ARight.fm33;
end;

class operator T3x3Matrix.*(const ALeft: T3x3Matrix; const ARight: double): T3x3Matrix;
begin
  result.fm11 := ALeft.fm11 * ARight;
  result.fm12 := ALeft.fm12 * ARight;
  result.fm13 := ALeft.fm13 * ARight;

  result.fm21 := ALeft.fm21 * ARight;
  result.fm22 := ALeft.fm22 * ARight;
  result.fm23 := ALeft.fm23 * ARight;

  result.fm31 := ALeft.fm31 * ARight;
  result.fm32 := ALeft.fm32 * ARight;
  result.fm33 := ALeft.fm33 * ARight;
end;

class operator T3x3Matrix.*(const ALeft, ARight: T3x3Matrix): T3x3Matrix;
begin
  result.fm11 := ALeft.fm11*ARight.fm11 +ALeft.fm12*ARight.fm21 +ALeft.fm13*ARight.fm31;
  result.fm12 := ALeft.fm11*ARight.fm12 +ALeft.fm12*ARight.fm22 +ALeft.fm13*ARight.fm32;
  result.fm13 := ALeft.fm11*ARight.fm13 +ALeft.fm12*ARight.fm23 +ALeft.fm13*ARight.fm33;

  result.fm21 := ALeft.fm21*ARight.fm11 +ALeft.fm22*ARight.fm21 +ALeft.fm23*ARight.fm31;
  result.fm22 := ALeft.fm21*ARight.fm12 +ALeft.fm22*ARight.fm22 +ALeft.fm23*ARight.fm32;
  result.fm23 := ALeft.fm21*ARight.fm13 +ALeft.fm22*ARight.fm23 +ALeft.fm23*ARight.fm33;

  result.fm31 := ALeft.fm31*ARight.fm11 +ALeft.fm32*ARight.fm21 +ALeft.fm33*ARight.fm31;
  result.fm32 := ALeft.fm31*ARight.fm12 +ALeft.fm32*ARight.fm22 +ALeft.fm33*ARight.fm32;
  result.fm33 := ALeft.fm31*ARight.fm13 +ALeft.fm32*ARight.fm23 +ALeft.fm33*ARight.fm33;
end;

class operator T3x3Matrix./(const ALeft: T3x3Matrix; const ARight: double): T3x3Matrix;
begin
  result.fm11 := ALeft.fm11 / ARight;
  result.fm12 := ALeft.fm12 / ARight;
  result.fm13 := ALeft.fm13 / ARight;

  result.fm21 := ALeft.fm21 / ARight;
  result.fm22 := ALeft.fm22 / ARight;
  result.fm23 := ALeft.fm23 / ARight;

  result.fm31 := ALeft.fm31 / ARight;
  result.fm32 := ALeft.fm32 / ARight;
  result.fm33 := ALeft.fm33 / ARight;
end;

class operator T3x3Matrix./(const ALeft: double; const ARight: T3x3Matrix): T3x3Matrix;
begin
  result := ALeft * ARight.Reciprocal(ARight.Determinant);
end;

class operator T3x3Matrix./(const ALeft, ARight: T3x3Matrix): T3x3Matrix;
begin
  result := ALeft * ARight.Reciprocal(ARight.Determinant);
end;

// T4x4Matrix

function T4x4Matrix.Transpose: T4x4Matrix;
begin
  result.fm11 := fm11;
  result.fm12 := fm21;
  result.fm13 := fm31;
  result.fm14 := fm41;

  result.fm21 := fm12;
  result.fm22 := fm22;
  result.fm23 := fm32;
  result.fm24 := fm42;

  result.fm31 := fm13;
  result.fm32 := fm23;
  result.fm33 := fm33;
  result.fm34 := fm43;

  result.fm41 := fm14;
  result.fm42 := fm24;
  result.fm43 := fm34;
  result.fm44 := fm44;
end;

function T4x4Matrix.Determinant: double;
begin
  result := fm11*(fm22*fm33*fm44 +fm23*fm34*fm42 +fm24*fm32*fm43 -fm24*fm33*fm42 -fm23*fm32*fm44 -fm22*fm34*fm43)
           -fm12*(fm21*fm33*fm44 +fm23*fm34*fm41 +fm24*fm31*fm43 -fm24*fm33*fm41 -fm23*fm31*fm44 -fm21*fm34*fm43)
           +fm13*(fm21*fm32*fm44 +fm22*fm34*fm41 +fm24*fm31*fm42 -fm24*fm32*fm41 -fm22*fm31*fm44 -fm21*fm34*fm42)
           -fm14*(fm21*fm32*fm43 +fm22*fm33*fm41 +fm23*fm31*fm42 -fm23*fm32*fm41 -fm22*fm31*fm43 -fm21*fm33*fm42);
end;

function T4x4Matrix.Reciprocal(const ADeterminant: double): T4x4Matrix;
begin
  result.fm11 := (fm22*fm33*fm44 + fm23*fm34*fm42 + fm24*fm32*fm43 - fm24*fm33*fm42 - fm23*fm32*fm44 - fm22*fm34*fm43) / ADeterminant;
  result.fm12 := (fm14*fm33*fm42 + fm13*fm32*fm44 + fm12*fm34*fm43 - fm12*fm33*fm44 - fm13*fm34*fm42 - fm14*fm32*fm43) / ADeterminant;
  result.fm13 := (fm12*fm23*fm44 + fm13*fm24*fm42 + fm14*fm22*fm43 - fm14*fm23*fm42 - fm13*fm22*fm44 - fm12*fm24*fm43) / ADeterminant;
  result.fm14 := (fm14*fm23*fm32 + fm13*fm22*fm34 + fm12*fm24*fm33 - fm12*fm23*fm34 - fm13*fm24*fm32 - fm14*fm22*fm33) / ADeterminant;
  result.fm21 := (fm24*fm33*fm41 + fm23*fm31*fm44 + fm21*fm34*fm43 - fm21*fm33*fm44 - fm23*fm34*fm41 - fm24*fm31*fm43) / ADeterminant;
  result.fm22 := (fm11*fm33*fm44 + fm13*fm34*fm41 + fm14*fm31*fm43 - fm14*fm33*fm41 - fm13*fm31*fm44 - fm11*fm34*fm43) / ADeterminant;
  result.fm23 := (fm14*fm23*fm41 + fm13*fm21*fm44 + fm11*fm24*fm43 - fm11*fm23*fm44 - fm13*fm24*fm41 - fm14*fm21*fm43) / ADeterminant;
  result.fm24 := (fm11*fm23*fm34 + fm13*fm24*fm31 + fm14*fm21*fm33 - fm14*fm23*fm31 - fm13*fm21*fm34 - fm11*fm24*fm33) / ADeterminant;
  result.fm31 := (fm21*fm32*fm44 + fm22*fm34*fm41 + fm24*fm31*fm42 - fm24*fm32*fm41 - fm22*fm31*fm44 - fm21*fm34*fm42) / ADeterminant;
  result.fm32 := (fm14*fm32*fm41 + fm12*fm31*fm44 + fm11*fm34*fm42 - fm11*fm32*fm44 - fm12*fm34*fm41 - fm14*fm31*fm42) / ADeterminant;
  result.fm33 := (fm11*fm22*fm44 + fm12*fm24*fm41 + fm14*fm21*fm42 - fm14*fm22*fm41 - fm12*fm21*fm44 - fm11*fm24*fm42) / ADeterminant;
  result.fm34 := (fm11*fm22*fm34 + fm12*fm24*fm31 + fm14*fm21*fm32 - fm14*fm22*fm31 - fm12*fm21*fm34 - fm11*fm24*fm32) / ADeterminant;
  result.fm41 := (fm22*fm31*fm43 + fm21*fm33*fm42 + fm23*fm32*fm41 - fm23*fm31*fm42 - fm22*fm33*fm41 - fm21*fm32*fm43) / ADeterminant;
  result.fm42 := (fm12*fm31*fm43 + fm11*fm33*fm42 + fm13*fm32*fm41 - fm13*fm31*fm42 - fm12*fm33*fm41 - fm11*fm32*fm43) / ADeterminant;
  result.fm43 := (fm12*fm21*fm43 + fm11*fm23*fm42 + fm13*fm22*fm41 - fm13*fm21*fm42 - fm12*fm23*fm41 - fm11*fm22*fm43) / ADeterminant;
  result.fm44 := (fm12*fm21*fm33 + fm11*fm23*fm32 + fm13*fm22*fm31 - fm13*fm21*fm32 - fm12*fm23*fm31 - fm11*fm22*fm33) / ADeterminant;
end;

function T4x4Matrix.ToString: string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s ,%s, %s, %s, %s, %s)',
    [FloatToStr(fm11), FloatToStr(fm12), FloatToStr(fm13), FloatToStr(fm14),
     FloatToStr(fm21), FloatToStr(fm22), FloatToStr(fm23), FloatToStr(fm24),
     FloatToStr(fm31), FloatToStr(fm32), FloatToStr(fm33), FloatToStr(fm34),
     FloatToStr(fm41), FloatToStr(fm42), FloatToStr(fm43), FloatToStr(fm44)]);
end;

class operator T4x4Matrix.+(const ALeft, ARight: T4x4Matrix): T4x4Matrix;
begin
  result.fm11 := ALeft.fm11 + ARight.fm11;
  result.fm12 := ALeft.fm12 + ARight.fm12;
  result.fm13 := ALeft.fm13 + ARight.fm13;
  result.fm14 := ALeft.fm14 + ARight.fm14;

  result.fm21 := ALeft.fm21 + ARight.fm21;
  result.fm22 := ALeft.fm22 + ARight.fm22;
  result.fm23 := ALeft.fm23 + ARight.fm23;
  result.fm24 := ALeft.fm24 + ARight.fm24;

  result.fm31 := ALeft.fm31 + ARight.fm31;
  result.fm32 := ALeft.fm32 + ARight.fm32;
  result.fm33 := ALeft.fm33 + ARight.fm33;
  result.fm34 := ALeft.fm34 + ARight.fm34;

  result.fm41 := ALeft.fm41 + ARight.fm41;
  result.fm42 := ALeft.fm42 + ARight.fm42;
  result.fm43 := ALeft.fm43 + ARight.fm43;
  result.fm44 := ALeft.fm44 + ARight.fm44;
end;

class operator T4x4Matrix.-(const ALeft, ARight: T4x4Matrix): T4x4Matrix;
begin
  result.fm11 := ALeft.fm11 - ARight.fm11;
  result.fm12 := ALeft.fm12 - ARight.fm12;
  result.fm13 := ALeft.fm13 - ARight.fm13;
  result.fm14 := ALeft.fm14 - ARight.fm14;

  result.fm21 := ALeft.fm21 - ARight.fm21;
  result.fm22 := ALeft.fm22 - ARight.fm22;
  result.fm23 := ALeft.fm23 - ARight.fm23;
  result.fm24 := ALeft.fm24 - ARight.fm24;

  result.fm31 := ALeft.fm31 - ARight.fm31;
  result.fm32 := ALeft.fm32 - ARight.fm32;
  result.fm33 := ALeft.fm33 - ARight.fm33;
  result.fm34 := ALeft.fm34 - ARight.fm34;

  result.fm41 := ALeft.fm41 - ARight.fm41;
  result.fm42 := ALeft.fm42 - ARight.fm42;
  result.fm43 := ALeft.fm43 - ARight.fm43;
  result.fm44 := ALeft.fm44 - ARight.fm44;
end;

class operator T4x4Matrix.*(const ALeft: double; const ARight: T4x4Matrix): T4x4Matrix;
begin
  result.fm11 := ALeft * ARight.fm11;
  result.fm12 := ALeft * ARight.fm12;
  result.fm13 := ALeft * ARight.fm13;
  result.fm14 := ALeft * ARight.fm14;

  result.fm21 := ALeft * ARight.fm21;
  result.fm22 := ALeft * ARight.fm22;
  result.fm23 := ALeft * ARight.fm23;
  result.fm24 := ALeft * ARight.fm24;

  result.fm31 := ALeft * ARight.fm31;
  result.fm32 := ALeft * ARight.fm32;
  result.fm33 := ALeft * ARight.fm33;
  result.fm34 := ALeft * ARight.fm34;

  result.fm41 := ALeft * ARight.fm41;
  result.fm42 := ALeft * ARight.fm42;
  result.fm43 := ALeft * ARight.fm43;
  result.fm44 := ALeft * ARight.fm44;
end;

class operator T4x4Matrix.*(const ALeft: T4x4Matrix; const ARight: double): T4x4Matrix;
begin
  result.fm11 := ALeft.fm11 * ARight;
  result.fm12 := ALeft.fm12 * ARight;
  result.fm13 := ALeft.fm13 * ARight;
  result.fm14 := ALeft.fm14 * ARight;

  result.fm21 := ALeft.fm21 * ARight;
  result.fm22 := ALeft.fm22 * ARight;
  result.fm23 := ALeft.fm23 * ARight;
  result.fm24 := ALeft.fm24 * ARight;

  result.fm31 := ALeft.fm31 * ARight;
  result.fm32 := ALeft.fm32 * ARight;
  result.fm33 := ALeft.fm33 * ARight;
  result.fm34 := ALeft.fm34 * ARight;

  result.fm41 := ALeft.fm41 * ARight;
  result.fm42 := ALeft.fm42 * ARight;
  result.fm43 := ALeft.fm43 * ARight;
  result.fm44 := ALeft.fm44 * ARight;
end;

class operator T4x4Matrix.*(const ALeft, ARight: T4x4Matrix): T4x4Matrix;
begin
  result.fm11 := ALeft.fm11*ARight.fm11 +ALeft.fm12*ARight.fm21 +ALeft.fm13*ARight.fm31 +ALeft.fm14*ARight.fm41;
  result.fm12 := ALeft.fm11*ARight.fm12 +ALeft.fm12*ARight.fm22 +ALeft.fm13*ARight.fm32 +ALeft.fm14*ARight.fm42;
  result.fm13 := ALeft.fm11*ARight.fm13 +ALeft.fm12*ARight.fm23 +ALeft.fm13*ARight.fm33 +ALeft.fm14*ARight.fm43;
  result.fm14 := ALeft.fm11*ARight.fm14 +ALeft.fm12*ARight.fm24 +ALeft.fm13*ARight.fm34 +ALeft.fm14*ARight.fm44;

  result.fm21 := ALeft.fm21*ARight.fm11 +ALeft.fm22*ARight.fm21 +ALeft.fm23*ARight.fm31 +ALeft.fm24*ARight.fm41;
  result.fm22 := ALeft.fm21*ARight.fm12 +ALeft.fm22*ARight.fm22 +ALeft.fm23*ARight.fm32 +ALeft.fm24*ARight.fm42;
  result.fm23 := ALeft.fm21*ARight.fm13 +ALeft.fm22*ARight.fm23 +ALeft.fm23*ARight.fm33 +ALeft.fm24*ARight.fm43;
  result.fm24 := ALeft.fm21*ARight.fm14 +ALeft.fm22*ARight.fm24 +ALeft.fm23*ARight.fm34 +ALeft.fm24*ARight.fm44;

  result.fm31 := ALeft.fm31*ARight.fm11 +ALeft.fm32*ARight.fm21 +ALeft.fm33*ARight.fm31 +ALeft.fm34*ARight.fm41;
  result.fm32 := ALeft.fm31*ARight.fm12 +ALeft.fm32*ARight.fm22 +ALeft.fm33*ARight.fm32 +ALeft.fm34*ARight.fm42;
  result.fm33 := ALeft.fm31*ARight.fm13 +ALeft.fm32*ARight.fm23 +ALeft.fm33*ARight.fm33 +ALeft.fm34*ARight.fm43;
  result.fm34 := ALeft.fm31*ARight.fm14 +ALeft.fm32*ARight.fm24 +ALeft.fm33*ARight.fm34 +ALeft.fm34*ARight.fm44;

  result.fm41 := ALeft.fm41*ARight.fm11 +ALeft.fm42*ARight.fm21 +ALeft.fm43*ARight.fm31 +ALeft.fm44*ARight.fm41;
  result.fm42 := ALeft.fm41*ARight.fm12 +ALeft.fm42*ARight.fm22 +ALeft.fm43*ARight.fm32 +ALeft.fm44*ARight.fm42;
  result.fm43 := ALeft.fm41*ARight.fm13 +ALeft.fm42*ARight.fm23 +ALeft.fm43*ARight.fm33 +ALeft.fm44*ARight.fm43;
  result.fm44 := ALeft.fm41*ARight.fm14 +ALeft.fm42*ARight.fm24 +ALeft.fm43*ARight.fm34 +ALeft.fm44*ARight.fm44;
end;

class operator T4x4Matrix./(const ALeft: T4x4Matrix; const ARight: double): T4x4Matrix;
begin
  result.fm11 := ALeft.fm11 / ARight;
  result.fm12 := ALeft.fm12 / ARight;
  result.fm13 := ALeft.fm13 / ARight;
  result.fm14 := ALeft.fm14 / ARight;

  result.fm21 := ALeft.fm21 / ARight;
  result.fm22 := ALeft.fm22 / ARight;
  result.fm23 := ALeft.fm23 / ARight;
  result.fm24 := ALeft.fm24 / ARight;

  result.fm31 := ALeft.fm31 / ARight;
  result.fm32 := ALeft.fm32 / ARight;
  result.fm33 := ALeft.fm33 / ARight;
  result.fm34 := ALeft.fm34 / ARight;

  result.fm41 := ALeft.fm41 / ARight;
  result.fm42 := ALeft.fm42 / ARight;
  result.fm43 := ALeft.fm43 / ARight;
  result.fm44 := ALeft.fm44 / ARight;
end;

class operator T4x4Matrix./(const ALeft: double; const ARight: T4x4Matrix): T4x4Matrix;
begin
  result := ALeft * ARight.Reciprocal(ARight.Determinant);
end;

class operator T4x4Matrix./(const ALeft, ARight: T4x4Matrix): T4x4Matrix;
begin
  result := ALeft * ARight.Reciprocal(ARight.Determinant);
end;

//

function Vector(const m1, m2, m3: double): TVector;
begin
  result.fm1 := m1;
  result.fm2 := m2;
  result.fm3 := m3;
end;

function Matrix(const m11, m12, m21, m22: double): T2x2Matrix;
begin
  result.fm11 := m11;
  result.fm12 := m12;
  result.fm21 := m21;
  result.fm22 := m22;
end;

function Matrix(const m11, m12, m13, m21, m22, m23, m31, m32, m33: double): T3x3Matrix;
begin
  result.fm11 := m11;
  result.fm12 := m12;
  result.fm13 := m13;

  result.fm21 := m21;
  result.fm22 := m22;
  result.fm23 := m23;

  result.fm31 := m31;
  result.fm32 := m32;
  result.fm33 := m33;
end;

function Matrix(const m11, m12, m13, m14, m21, m22, m23, m24, m31, m32, m33, m34, m41, m42, m43, m44: double): T4x4Matrix;
begin
  result.fm11 := m11;
  result.fm12 := m12;
  result.fm13 := m13;
  result.fm14 := m14;

  result.fm21 := m21;
  result.fm22 := m22;
  result.fm23 := m23;
  result.fm24 := m24;

  result.fm31 := m31;
  result.fm32 := m32;
  result.fm33 := m33;
  result.fm34 := m34;

  result.fm41 := m41;
  result.fm42 := m42;
  result.fm43 := m43;
  result.fm44 := m44;
end;

