{ Complex number implementation }

// TComplex

function TComplex.Re: double;
begin
  result := FRe;
end;

function TComplex.Im: double;
begin
  result := FIm;
end;

function TComplex.Dual: TComplex;
begin
  result.FRe :=  FRe;
  result.FIm := -FIm;
end;

function TComplex.Reciprocal: TComplex;
begin
  result := Dual / SquaredNorm;
end;

function TComplex.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TComplex.SquaredNorm: double;
begin
  result := sqr(FRe) + sqr(FIm);
end;

function TComplex.ToString: string;
begin
  result := '';
  if SameValue(FRe, 0) = False then
    result := FloatToStr(FRe);

  if SameValue(FIm, 0) = False then
  begin
    if FIm < 0.0 then
      result := result + Format(' %si', [FloatToStr(FIm)])
    else
      result := result + Format(' +%si', [FloatToStr(FIm)]);
  end;

  if Length(result) = 0 then
    result := '0'
  else
    if result[1] = ' ' then
    begin
      Delete(result, 1, 1);
      if result[1] = '+' then
        Delete(result, 1, 1);
    end;
end;

function TComplex.ToString(APrecision, ADigits: integer): string;
begin
  result := '';
  if SameValue(FRe, 0) = False then
    result := FloatToStrF(FRe, ffGeneral, APrecision, ADigits);

  if SameValue(FIm, 0) = False then
  begin
    if FIm < 0.0 then
      result := result + Format(' %si', [FloatToStrF(FIm, ffGeneral, APrecision, ADigits)])
    else
      result := result + Format(' +%si', [FloatToStrF(FIm, ffGeneral, APrecision, ADigits)]);
  end;

  if Length(result) = 0 then
    result := '0'
  else
    if result[1] = ' ' then
    begin
      Delete(result, 1, 1);
      if result[1] = '+' then
        Delete(result, 1, 1);
    end;
end;

class operator TComplex.:= (const AValue: double): TComplex;
begin
  result.FRe := AValue;
  result.FIm := 0;
end;

class operator TComplex.+(const AValue: TComplex): TComplex;
begin
  result.FRe := AValue.FRe;
  result.FIm := AValue.FIm;
end;

class operator TComplex.+(const ALeft, ARight: TComplex): TComplex;
begin
  result.FRe := ALeft.FRe + ARight.FRe;
  result.FIm := ALeft.FIm + ARight.FIm;
end;

class operator TComplex.+(const ALeft: double; const ARight: TComplex): TComplex;
begin
  result.FRe := ALeft + ARight.FRe;
  result.FIm :=         ARight.FIm;
end;

class operator TComplex.+(const ALeft: TComplex; const ARight: double): TComplex;
begin
  result.FRe := ALeft.FRe + ARight;
  result.FIm := ALeft.FIm;
end;

class operator TComplex.-(const AValue: TComplex): TComplex;
begin
  result.FRe := -AValue.FRe;
  result.FIm := -AValue.FIm;
end;

class operator TComplex.-(const ALeft, ARight: TComplex): TComplex;
begin
  result.FRe := ALeft.FRe - ARight.FRe;
  result.FIm := ALeft.FIm - ARight.FIm;
end;

class operator TComplex.-(const ALeft: double; const ARight: TComplex): TComplex; inline;
begin
  result.FRe := ALeft - ARight.FRe;
  result.FIm :=       - ARight.FIm;;
end;

class operator TComplex.-(const ALeft: TComplex; const ARight: double): TComplex; inline;
begin
  result.FRe := ALeft.FRe - ARight;
  result.FIm := ALeft.FIm;
end;

class operator TComplex.*(const ALeft, ARight: TComplex): TComplex;
begin
  result.FRe := ALeft.FRe * ARight.FRe - ALeft.FIm * ARight.FIm;
  result.FIm := ALeft.FRe * ARight.FIm + ALeft.FIm * ARight.FRe;
end;

class operator TComplex.*(const ALeft: double; const ARight: TComplex): TComplex; inline;
begin
  result.FRe := ALeft * ARight.FRe;
  result.FIm := ALeft * ARight.FIm;
end;

class operator TComplex.*(const ALeft: TComplex; const ARight: double): TComplex; inline;
begin
  result.FRe := ALeft.FRe * ARight;
  result.FIm := ALeft.FIm * ARight;
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
  result.FRe := ALeft.FRe / ARight;
  result.FIm := ALeft.FIm / ARight;
end;

class operator TComplex.=(const ALeft, ARight: TComplex): boolean;
begin
  result := SameValue(ALeft.FRe, ARight.FRe) and 
            SameValue(ALeft.FIm, ARight.FIm);
end;

class operator TComplex.<>(const ALeft, ARight: TComplex): boolean;
begin
  result := (not SameValue(ALeft.FRe, ARight.FRe)) or 
            (not SameValue(ALeft.FIm, ARight.FIm));
end;

// TImaginayUnit

class operator TImaginaryUnit.*(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
begin
  result.FRe := 0;
  result.FIm := ALeft;
end;

class operator TImaginaryUnit.*(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
begin
  result.FRe := 0;
  result.FIm := ARight;
end;

class operator TImaginaryUnit.*(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
begin
  result.FRe := -ALeft.FIm;
  result.FIm :=  ALeft.FRe;
end;

class operator TImaginaryUnit.*(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
begin
  result.FRe := -ARight.FIm;
  result.FIm :=  ARight.FRe;
end;

class operator TImaginaryUnit./(const ALeft: double; const ARight: TImaginaryUnit): TComplex;
begin
  result.FRe :=  0;
  result.FIm := -ALeft;
end;

class operator TImaginaryUnit./(const ALeft: TImaginaryUnit; const ARight: double): TComplex;
begin
  result.FRe := 0;
  result.FIm := 1/ARight;
end;

class operator TImaginaryUnit./(const ALeft: TComplex; const ARight: TImaginaryUnit): TComplex;
begin
  result.FRe :=  ALeft.FIm;
  result.FIm := -ALeft.FRe;
end;

class operator TImaginaryUnit./(const ALeft: TImaginaryUnit; const ARight: TComplex): TComplex;
begin
  result.FRe := -ARight.FIm;
  result.FIm :=  ARight.FRe;
end;    

