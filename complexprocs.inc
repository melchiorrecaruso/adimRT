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
  result := Math.SameValue(fRe, 0) and
            Math.SameValue(FIm, 0);
end;

function TComplex.ToString: string;
begin
  result := '';
  if Math.SameValue(FRe, 0) = False then
    result := FloatToStr(FRe);

  if Math.SameValue(FIm, 0) = False then
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
  if Math.SameValue(FRe, 0) = False then
    result := FloatToStrF(FRe, ffGeneral, APrecision, ADigits);

  if Math.SameValue(FIm, 0) = False then
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

function TComplex.SameValue(const AComplex: TComplex): boolean;
begin
  result := Math.SameValue(FRe, AComplex.FRe) and
            Math.SameValue(FIm, AComplex.FIm);
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
  result := Math.SameValue(ALeft.FRe, ARight.FRe) and 
            Math.SameValue(ALeft.FIm, ARight.FIm);
end;

class operator TComplex.<>(const ALeft, ARight: TComplex): boolean;
begin
  result := (not Math.SameValue(ALeft.FRe, ARight.FRe)) or 
            (not Math.SameValue(ALeft.FIm, ARight.FIm));
end;

// TKet

function TKetHelper.SquareNorm: double;
begin
  result :=  fm1.SquaredNorm + fm2.SquaredNorm + fm3.SquaredNorm;
end;

function TKetHelper.Norm: double;
begin
  result := sqrt(SquareNorm);
end;

function TKetHelper.TransposeDual: TBra;
begin
  result.fm1 := fm1.Dual;
  result.fm2 := fm2.Dual;
  result.fm3 := fm3.Dual;
end;

function TKetHelper.IsNull: boolean;
begin
  result := fm1.IsNull and fm2.IsNull and fm3.IsNull;
end;

function TKetHelper.SameValue(const AVector: TKet): boolean;
begin
  result := fm1.SameValue(AVector.fm1) and
            fm2.SameValue(AVector.fm2) and
            fm3.SameValue(AVector.fm3);
end;

class operator TKet.+(const ALeft, ARight: TKet): TKet;
begin
  result.fm1 := ALeft.fm1 + ARight.fm1;
  result.fm2 := ALeft.fm2 + ARight.fm2;
  result.fm3 := ALeft.fm3 + ARight.fm3;
end;

class operator TKet.-(const ALeft, ARight: TKet): TKet;
begin
  result.fm1 := ALeft.fm1 - ARight.fm1;
  result.fm2 := ALeft.fm2 - ARight.fm2;
  result.fm3 := ALeft.fm3 - ARight.fm3;
end;

class operator TKet.*(const ALeft: double; const ARight: TKet): TKet;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TKet.*(const ALeft: TKet; const ARight: double): TKet;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TKet.*(const ALeft: TComplex; const ARight: TKet): TKet;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TKet.*(const ALeft: TKet; const ARight: TComplex): TKet;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TKet./(const ALeft: TKet; const ARight: double): TKet;
begin
  result.fm1 := ALeft.fm1 / ARight;
  result.fm2 := ALeft.fm2 / ARight;
  result.fm3 := ALeft.fm3 / ARight;
end;

class operator TKet.*(const ALeft: T3x3ComplexMatrix; const ARight: TKet): TKet;
begin
  result.fm1 := ALeft.fm11*ARight.fm1 + ALeft.fm12*ARight.fm2 + ALeft.fm13*ARight.fm3;
  result.fm2 := ALeft.fm21*ARight.fm1 + ALeft.fm22*ARight.fm2 + ALeft.fm23*ARight.fm3;
  result.fm3 := ALeft.fm31*ARight.fm1 + ALeft.fm32*ARight.fm2 + ALeft.fm33*ARight.fm3;
end;

class operator TKet.*(const ALeft: TKet; const ARight: T3x3ComplexMatrix): TKet;
begin
  result.fm1 := ALeft.fm1*ARight.fm11 + ALeft.fm1*ARight.fm12 + ALeft.fm1*ARight.fm13;
  result.fm2 := ALeft.fm2*ARight.fm21 + ALeft.fm2*ARight.fm22 + ALeft.fm2*ARight.fm23;
  result.fm3 := ALeft.fm3*ARight.fm31 + ALeft.fm3*ARight.fm32 + ALeft.fm3*ARight.fm33;
end;

// TBra

function TBraHelper.SquareNorm: double;
begin
  result :=  fm1.SquaredNorm + fm2.SquaredNorm + fm3.SquaredNorm;
end;

function TBraHelper.Norm: double;
begin
  result := sqrt(SquareNorm);
end;

function TBraHelper.TransposeDual: TKet;
begin
  result.fm1 := fm1.Dual;
  result.fm2 := fm2.Dual;
  result.fm3 := fm3.Dual;
end;

function TBraHelper.IsNull: boolean;
begin
  result := fm1.IsNull and fm2.IsNull and fm3.IsNull;
end;

function TBraHelper.SameValue(const AVector: TBra): boolean;
begin
  result := fm1.SameValue(AVector.fm1) and
            fm2.SameValue(AVector.fm2) and
            fm3.SameValue(AVector.fm3);
end;

class operator TBra.+(const ALeft, ARight: TBra): TBra;
begin
  result.fm1 := ALeft.fm1 + ARight.fm1;
  result.fm2 := ALeft.fm2 + ARight.fm2;
  result.fm3 := ALeft.fm3 + ARight.fm3;
end;

class operator TBra.-(const ALeft, ARight: TBra): TBra;
begin
  result.fm1 := ALeft.fm1 - ARight.fm1;
  result.fm2 := ALeft.fm2 - ARight.fm2;
  result.fm3 := ALeft.fm3 - ARight.fm3;
end;

class operator TBra.*(const ALeft: double; const ARight: TBra): TBra;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TBra.*(const ALeft: TBra; const ARight: double): TBra;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TBra.*(const ALeft: TComplex; const ARight: TBra): TBra;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TBra.*(const ALeft: TBra; const ARight: TComplex): TBra;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TBra./(const ALeft: TBra; const ARight: double): TBra;
begin
  result.fm1 := ALeft.fm1 / ARight;
  result.fm2 := ALeft.fm2 / ARight;
  result.fm3 := ALeft.fm3 / ARight;
end;

class operator TBra.*(const ALeft: TBra; const ARight: TKet): TComplex;
begin
  result := ALeft.fm1*ARight.fm1 + ALeft.fm2*ARight.fm2 + ALeft.fm3*ARight.fm3;
end;

class operator TBra.*(const ALeft: TKet; const ARight: TBra): T3x3ComplexMatrix;
begin
  result.fm11 := ALeft.fm1*ARight.fm1;
  result.fm12 := ALeft.fm1*ARight.fm2;
  result.fm13 := ALeft.fm1*ARight.fm3;
  result.fm21 := ALeft.fm2*ARight.fm1;
  result.fm22 := ALeft.fm2*ARight.fm2;
  result.fm23 := ALeft.fm2*ARight.fm3;
  result.fm31 := ALeft.fm3*ARight.fm1;
  result.fm32 := ALeft.fm3*ARight.fm2;
  result.fm33 := ALeft.fm3*ARight.fm3;
end;

class operator TBra.*(const ALeft: T3x3ComplexMatrix; const ARight: TBra): TBra;
begin
  result.fm1 := ALeft.fm11*ARight.fm1 + ALeft.fm12*ARight.fm2 + ALeft.fm13*ARight.fm3;
  result.fm2 := ALeft.fm21*ARight.fm1 + ALeft.fm22*ARight.fm2 + ALeft.fm23*ARight.fm3;
  result.fm3 := ALeft.fm31*ARight.fm1 + ALeft.fm32*ARight.fm2 + ALeft.fm33*ARight.fm3;
end;

class operator TBra.*(const ALeft: TBra; const ARight: T3x3ComplexMatrix): TBra;
begin
  result.fm1 := ALeft.fm1*ARight.fm11 + ALeft.fm1*ARight.fm12 + ALeft.fm1*ARight.fm13;
  result.fm2 := ALeft.fm2*ARight.fm21 + ALeft.fm2*ARight.fm22 + ALeft.fm2*ARight.fm23;
  result.fm3 := ALeft.fm3*ARight.fm31 + ALeft.fm3*ARight.fm32 + ALeft.fm3*ARight.fm33;
end;

// T3x3ComplexMatrix

class operator T3x3ComplexMatrix.+(const ALeft, ARight: T3x3ComplexMatrix): T3x3ComplexMatrix;
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

class operator T3x3ComplexMatrix.-(const ALeft, ARight: T3x3ComplexMatrix): T3x3ComplexMatrix;
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


class operator T3x3ComplexMatrix.*(const ALeft: double; const ARight: T3x3ComplexMatrix): T3x3ComplexMatrix;
begin
  result.fm11 := ALeft*ARight.fm11;
  result.fm12 := ALeft*ARight.fm12;
  result.fm13 := ALeft*ARight.fm13;
  result.fm21 := ALeft*ARight.fm21;
  result.fm22 := ALeft*ARight.fm22;
  result.fm23 := ALeft*ARight.fm23;
  result.fm31 := ALeft*ARight.fm31;
  result.fm32 := ALeft*ARight.fm32;
  result.fm33 := ALeft*ARight.fm33;
end;

class operator T3x3ComplexMatrix.*(const ALeft: T3x3ComplexMatrix; const ARight: double): T3x3ComplexMatrix;
begin
  result.fm11 := ALeft.fm11*ARight;
  result.fm12 := ALeft.fm12*ARight;
  result.fm13 := ALeft.fm13*ARight;
  result.fm21 := ALeft.fm21*ARight;
  result.fm22 := ALeft.fm22*ARight;
  result.fm23 := ALeft.fm23*ARight;
  result.fm31 := ALeft.fm31*ARight;
  result.fm32 := ALeft.fm32*ARight;
  result.fm33 := ALeft.fm33*ARight;
end;

class operator T3x3ComplexMatrix.*(const ALeft: TComplex; const ARight: T3x3ComplexMatrix): T3x3ComplexMatrix;
begin
  result.fm11 := ALeft*ARight.fm11;
  result.fm12 := ALeft*ARight.fm12;
  result.fm13 := ALeft*ARight.fm13;
  result.fm21 := ALeft*ARight.fm21;
  result.fm22 := ALeft*ARight.fm22;
  result.fm23 := ALeft*ARight.fm23;
  result.fm31 := ALeft*ARight.fm31;
  result.fm32 := ALeft*ARight.fm32;
  result.fm33 := ALeft*ARight.fm33;
end;

class operator T3x3ComplexMatrix.*(const ALeft: T3x3ComplexMatrix; const ARight: TComplex): T3x3ComplexMatrix;
begin
  result.fm11 := ALeft.fm11*ARight;
  result.fm12 := ALeft.fm12*ARight;
  result.fm13 := ALeft.fm13*ARight;
  result.fm21 := ALeft.fm21*ARight;
  result.fm22 := ALeft.fm22*ARight;
  result.fm23 := ALeft.fm23*ARight;
  result.fm31 := ALeft.fm31*ARight;
  result.fm32 := ALeft.fm32*ARight;
  result.fm33 := ALeft.fm33*ARight;
end;

class operator T3x3ComplexMatrix.*(const ALeft, ARight: T3x3ComplexMatrix): T3x3ComplexMatrix;
begin
  result.fm11 := ALeft.fm11*ARight.fm11 + ALeft.fm12*ARight.fm21 + ALeft.fm13*ARight.fm31;
  result.fm12 := ALeft.fm11*ARight.fm12 + ALeft.fm12*ARight.fm22 + ALeft.fm13*ARight.fm32;
  result.fm13 := ALeft.fm11*ARight.fm13 + ALeft.fm12*ARight.fm23 + ALeft.fm13*ARight.fm33;

  result.fm21 := ALeft.fm21*ARight.fm11 + ALeft.fm22*ARight.fm21 + ALeft.fm23*ARight.fm31;
  result.fm22 := ALeft.fm21*ARight.fm12 + ALeft.fm22*ARight.fm22 + ALeft.fm23*ARight.fm32;
  result.fm23 := ALeft.fm21*ARight.fm13 + ALeft.fm22*ARight.fm23 + ALeft.fm23*ARight.fm33;

  result.fm31 := ALeft.fm31*ARight.fm11 + ALeft.fm32*ARight.fm21 + ALeft.fm33*ARight.fm31;
  result.fm32 := ALeft.fm31*ARight.fm12 + ALeft.fm32*ARight.fm22 + ALeft.fm33*ARight.fm32;
  result.fm33 := ALeft.fm31*ARight.fm13 + ALeft.fm32*ARight.fm23 + ALeft.fm33*ARight.fm33;
end;

function T3x3ComplexMatrix.Dual: T3x3ComplexMatrix;
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

function T3x3ComplexMatrix.Transpose: T3x3ComplexMatrix;
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

function T3x3ComplexMatrix.TransposeDual: T3x3ComplexMatrix;
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

function T3x3ComplexMatrix.SameValue(const AMatrix: T3x3ComplexMatrix): boolean;
begin
  result := fm11.SameValue(AMatrix.fm11) and
            fm12.SameValue(AMatrix.fm12) and
            fm13.SameValue(AMatrix.fm13) and
            fm21.SameValue(AMatrix.fm21) and
            fm22.SameValue(AMatrix.fm22) and
            fm23.SameValue(AMatrix.fm23) and
            fm31.SameValue(AMatrix.fm31) and
            fm32.SameValue(AMatrix.fm32) and
            fm33.SameValue(AMatrix.fm33);
end;

function Ket(const a1, a2, a3: TComplex): TKet;
begin
  result.fm1 := a1;
  result.fm2 := a2;
  result.fm3 := a3;
end;

function Bra(const a1, a2, a3: TComplex): TBra;
begin
  result.fm1 := a1;
  result.fm2 := a2;
  result.fm3 := a3;
end;

function ComplexMatrix(const a11, a12, a13, a21, a22, a23, a31, a32, a33: TComplex): T3x3ComplexMatrix;
begin
  result.fm11 := a11;
  result.fm12 := a12;
  result.fm13 := a13;
  result.fm21 := a21;
  result.fm22 := a22;
  result.fm23 := a23;
  result.fm31 := a31;
  result.fm32 := a32;
  result.fm33 := a33;
end;

function Commutator(const ALeft, ARight: T3x3ComplexMatrix): T3x3ComplexMatrix;
begin
  result := ALeft*ARight - ARight*ALeft;
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

