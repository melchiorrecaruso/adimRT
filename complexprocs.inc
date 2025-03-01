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

function TComplex.IsNull: boolean;
begin
  result := SameValue(fRe, 0) and SameValue(FIm, 0);
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

// TKet3

class operator TKet3.+(const ALeft, ARight: TKet3): TKet3;
begin
  result.fm1 := ALeft.fm1 + ARight.fm1;
  result.fm2 := ALeft.fm2 + ARight.fm2;
  result.fm3 := ALeft.fm3 + ARight.fm3;
end;

class operator TKet3.-(const ALeft, ARight: TKet3): TKet3;
begin
  result.fm1 := ALeft.fm1 - ARight.fm1;
  result.fm2 := ALeft.fm2 - ARight.fm2;
  result.fm3 := ALeft.fm3 - ARight.fm3;
end;

class operator TKet3.*(const ALeft: double; const ARight: TKet3): TKet3;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TKet3.*(const ALeft: TKet3; const ARight: double): TKet3;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TKet3.*(const ALeft: TComplex; const ARight: TKet3): TKet3;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TKet3.*(const ALeft: TKet3; const ARight: TComplex): TKet3;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TKet3./(const ALeft: TKet3; const ARight: double): TKet3;
begin
  result.fm1 := ALeft.fm1 / ARight;
  result.fm2 := ALeft.fm2 / ARight;
  result.fm3 := ALeft.fm3 / ARight;
end;

// TBra3

class operator TBra3.+(const ALeft, ARight: TBra3): TBra3;
begin
  result.fm1 := ALeft.fm1 + ARight.fm1;
  result.fm2 := ALeft.fm2 + ARight.fm2;
  result.fm3 := ALeft.fm3 + ARight.fm3;
end;

class operator TBra3.-(const ALeft, ARight: TBra3): TBra3;
begin
  result.fm1 := ALeft.fm1 - ARight.fm1;
  result.fm2 := ALeft.fm2 - ARight.fm2;
  result.fm3 := ALeft.fm3 - ARight.fm3;
end;

class operator TBra3.*(const ALeft: double; const ARight: TBra3): TBra3;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TBra3.*(const ALeft: TBra3; const ARight: double): TBra3;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TBra3.*(const ALeft: TComplex; const ARight: TBra3): TBra3;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TBra3.*(const ALeft: TBra3; const ARight: TComplex): TBra3;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TBra3.*(const ALeft: TBra3; const ARight: TKet3): TComplex;
begin
  result := ALeft.fm1*ARight.fm1 + ALeft.fm2*ARight.fm2 + ALeft.fm3*ARight.fm3;
end;

class operator TBra3./(const ALeft: TBra3; const ARight: double): TBra3;
begin
  result.fm1 := ALeft.fm1 / ARight;
  result.fm2 := ALeft.fm2 / ARight;
  result.fm3 := ALeft.fm3 / ARight;
end;

// TKet3Helper

function TKet3Helper.Bra: TBra3;
begin
  result.fm1 := fm1.Dual;
  result.fm2 := fm2.Dual;
  result.fm3 := fm3.Dual;
end;

function TKet3Helper.SquareNorm: double;
begin
  result :=   fm1.SquaredNorm
            + fm2.SquaredNorm
            + fm3.SquaredNorm;
end;

function TKet3Helper.Norm: double;
begin
  result := sqrt(SquareNorm);
end;

function TKet3Helper.IsNull: boolean;
begin
  result := fm1.IsNull and fm2.IsNull and fm3.IsNull;
end;

// TBra3Helper

function TBra3Helper.Ket: TKet3;
begin
  result.fm1 := fm1.Dual;
  result.fm2 := fm2.Dual;
  result.fm3 := fm3.Dual;
end;

function TBra3Helper.IsNull: boolean;
begin
  result := fm1.IsNull and fm2.IsNull and fm3.IsNull;
end;

// T3x3Complex

class operator T3x3Complex.*(const ALeft: T3x3Complex; const ARight: TKet3): TKet3;
begin
  result.fm1 := ALeft.fm11*ARight.fm1 + ALeft.fm12*ARight.fm2 + ALeft.fm13*ARight.fm3;
  result.fm2 := ALeft.fm21*ARight.fm1 + ALeft.fm22*ARight.fm2 + ALeft.fm23*ARight.fm3;
  result.fm3 := ALeft.fm31*ARight.fm1 + ALeft.fm32*ARight.fm2 + ALeft.fm33*ARight.fm3;
end;

function T3x3Complex.Dual: T3x3Complex;
begin
  result.fm11 := fm11.Dual;
  result.fm12 := fm12.Dual;
  result.fm13 := fm13.Dual;
  result.fm21 := fm21.Dual;
  result.fm22 := fm22.Dual;
  result.fm23 := fm23.Dual;
  result.fm31 := fm31.Dual;
  result.fm32 := fm32.Dual;
  result.fm33 := fm33.Dual;
end;

function T3x3Complex.Transpose: T3x3Complex;
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

function T3x3Complex.TransposeDual: T3x3Complex;
begin
  result.fm11 := fm11.Dual;
  result.fm12 := fm21.Dual;
  result.fm13 := fm31.Dual;
  result.fm21 := fm12.Dual;
  result.fm22 := fm22.Dual;
  result.fm23 := fm32.Dual;
  result.fm31 := fm13.Dual;
  result.fm32 := fm23.Dual;
  result.fm33 := fm33.Dual;
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

