
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
  Result := NullVector;
  if vc1 in AComponents then result.fm1 := fm1;
  if vc2 in AComponents then result.fm2 := fm2;
  if vc3 in AComponents then result.fm3 := fm3;
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
