{ Complex number implementation }

// TComplex

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
  result := sqrt(SquaredNorm);
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

function TComplex.ToString: string;
var
  sign: array[boolean] of string = ('+', '-');
begin
  if (not Math.SameValue(fRe, 0)) and
     (not Math.SameValue(fIm, 0)) then
    result := Format('%s %s%s∙i', [FloatToStr(fRe), sign[fIm < 0], FloatToStr(Abs(fIm))])
  else
    if (not Math.SameValue(fRe, 0)) then
      result := Format('%s', [FloatToStr(fRe)])
    else
      if (not Math.SameValue(fIm, 0)) then
        result := Format('%s∙i', [FloatToStr(fIm)])
      else
        result := '0';
end;

function TComplex.ToString(APrecision, ADigits: integer): string;
var
  sign: array[boolean] of string = ('+', '-');
begin
  if (not Math.SameValue(fRe, 0)) and
     (not Math.SameValue(fIm, 0)) then
    result := Format('%s %s%s∙i', [
      FloatToStrF(fRe, ffGeneral, APrecision, ADigits), sign[fIm < 0],
      FloatToStrF(fIm, ffGeneral, APrecision, ADigits)])
  else
    if (not Math.SameValue(fRe, 0)) then
      result := Format('%s', [FloatToStrF(fRe, ffGeneral, APrecision, ADigits)])
    else
      if (not Math.SameValue(fIm, 0)) then
        result := Format('%s∙i', [FloatToStrF(fIm, ffGeneral, APrecision, ADigits)])
      else
        result := '0';
end;

function TComplex.SameValue(const AComplex: TComplex): boolean;
begin
  result := Math.SameValue(fRe, AComplex.fRe) and
            Math.SameValue(fIm, AComplex.fIm);
end;

class operator TComplex.:= (const AValue: double): TComplex;
begin
  result.fRe := AValue;
  result.fIm := 0;
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
  result := Math.SameValue(ALeft.fRe, ARight.fRe) and
            Math.SameValue(ALeft.fIm, ARight.fIm);
end;

class operator TComplex.<>(const ALeft, ARight: TComplex): boolean;
begin
  result := (not Math.SameValue(ALeft.fRe, ARight.fRe)) or
            (not Math.SameValue(ALeft.fIm, ARight.fIm));
end;

// TC2Ket

function TC2KetHelper.SquareNorm: double;
begin
  result :=  fm1.SquaredNorm + fm2.SquaredNorm;
end;

function TC2KetHelper.Norm: double;
begin
  result := sqrt(SquareNorm);
end;

function TC2KetHelper.Normalize: TC2Ket;
begin
  result := Self / Norm;
end;

function TC2KetHelper.TransposeDual: TC2Bra;
begin
  result.fm1 := fm1.Dual;
  result.fm2 := fm2.Dual;
end;

function TC2KetHelper.IsNull: boolean;
begin
  result := fm1.IsNull and fm2.IsNull;
end;

function TC2KetHelper.SameValue(const AVector: TC2Ket): boolean;
begin
  result := fm1.SameValue(AVector.fm1) and
            fm2.SameValue(AVector.fm2);
end;

function TC2KetHelper.ToString: string;
begin
  result := Format('(%s, %s)', [fm1.ToString, fm2.ToString]);
end;

function TC2KetHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s)', [
    fm1.ToString(APrecision, ADigits),
    fm2.ToString(APrecision, ADigits)]);
end;

class operator TC2Ket.+(const ALeft, ARight: TC2Ket): TC2Ket;
begin
  result.fm1 := ALeft.fm1 + ARight.fm1;
  result.fm2 := ALeft.fm2 + ARight.fm2;
end;

class operator TC2Ket.-(const ALeft, ARight: TC2Ket): TC2Ket;
begin
  result.fm1 := ALeft.fm1 - ARight.fm1;
  result.fm2 := ALeft.fm2 - ARight.fm2;
end;

class operator TC2Ket.*(const ALeft: double; const ARight: TC2Ket): TC2Ket;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
end;

class operator TC2Ket.*(const ALeft: TC2Ket; const ARight: double): TC2Ket;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
end;

class operator TC2Ket.*(const ALeft: TComplex; const ARight: TC2Ket): TC2Ket;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
end;

class operator TC2Ket.*(const ALeft: TC2Ket; const ARight: TComplex): TC2Ket;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
end;

class operator TC2Ket./(const ALeft: TC2Ket; const ARight: double): TC2Ket;
begin
  result.fm1 := ALeft.fm1 / ARight;
  result.fm2 := ALeft.fm2 / ARight;
end;

class operator TC2Ket./(const ALeft: TC2Ket; const ARight: TComplex): TC2Ket;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TC2Ket.*(const ALeft: TC2Matrix; const ARight: TC2Ket): TC2Ket;
begin
  result.fm1 := ALeft.fm11*ARight.fm1 + ALeft.fm12*ARight.fm2;
  result.fm2 := ALeft.fm21*ARight.fm1 + ALeft.fm22*ARight.fm2;
end;

// TC3Ket

function TC3KetHelper.SquareNorm: double;
begin
  result :=  fm1.SquaredNorm + fm2.SquaredNorm + fm3.SquaredNorm;
end;

function TC3KetHelper.Norm: double;
begin
  result := sqrt(SquareNorm);
end;

function TC3KetHelper.TransposeDual: TC3Bra;
begin
  result.fm1 := fm1.Dual;
  result.fm2 := fm2.Dual;
  result.fm3 := fm3.Dual;
end;

function TC3KetHelper.IsNull: boolean;
begin
  result := fm1.IsNull and fm2.IsNull and fm3.IsNull;
end;

function TC3KetHelper.SameValue(const AVector: TC3Ket): boolean;
begin
  result := fm1.SameValue(AVector.fm1) and
            fm2.SameValue(AVector.fm2) and
            fm3.SameValue(AVector.fm3);
end;

function TC3KetHelper.ToString: string;
begin
  result := Format('(%s, %s, %s)', [
    fm1.ToString,
    fm2.ToString,
    fm3.ToString]);
end;

function TC3KetHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s)', [
    fm1.ToString(APrecision, ADigits),
    fm2.ToString(APrecision, ADigits),
    fm3.ToString(APrecision, ADigits)]);
end;

class operator TC3Ket.+(const ALeft, ARight: TC3Ket): TC3Ket;
begin
  result.fm1 := ALeft.fm1 + ARight.fm1;
  result.fm2 := ALeft.fm2 + ARight.fm2;
  result.fm3 := ALeft.fm3 + ARight.fm3;
end;

class operator TC3Ket.-(const ALeft, ARight: TC3Ket): TC3Ket;
begin
  result.fm1 := ALeft.fm1 - ARight.fm1;
  result.fm2 := ALeft.fm2 - ARight.fm2;
  result.fm3 := ALeft.fm3 - ARight.fm3;
end;

class operator TC3Ket.*(const ALeft: double; const ARight: TC3Ket): TC3Ket;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TC3Ket.*(const ALeft: TC3Ket; const ARight: double): TC3Ket;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TC3Ket.*(const ALeft: TComplex; const ARight: TC3Ket): TC3Ket;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TC3Ket.*(const ALeft: TC3Ket; const ARight: TComplex): TC3Ket;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TC3Ket./(const ALeft: TC3Ket; const ARight: double): TC3Ket;
begin
  result.fm1 := ALeft.fm1 / ARight;
  result.fm2 := ALeft.fm2 / ARight;
  result.fm3 := ALeft.fm3 / ARight;
end;

class operator TC3Ket./(const ALeft: TC3Ket; const ARight: TComplex): TC3Ket;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TC3Ket.*(const ALeft: TC3Matrix; const ARight: TC3Ket): TC3Ket;
begin
  result.fm1 := ALeft.fm11*ARight.fm1 + ALeft.fm12*ARight.fm2 + ALeft.fm13*ARight.fm3;
  result.fm2 := ALeft.fm21*ARight.fm1 + ALeft.fm22*ARight.fm2 + ALeft.fm23*ARight.fm3;
  result.fm3 := ALeft.fm31*ARight.fm1 + ALeft.fm32*ARight.fm2 + ALeft.fm33*ARight.fm3;
end;

// TC2Bra

function TC2BraHelper.SquareNorm: double;
begin
  result :=  fm1.SquaredNorm + fm2.SquaredNorm;
end;

function TC2BraHelper.Norm: double;
begin
  result := sqrt(SquareNorm);
end;

function TC2BraHelper.Normalize: TC2Bra;
begin
  result := Self / Norm;
end;

function TC2BraHelper.TransposeDual: TC2Ket;
begin
  result.fm1 := fm1.Dual;
  result.fm2 := fm2.Dual;
end;

function TC2BraHelper.IsNull: boolean;
begin
  result := fm1.IsNull and fm2.IsNull;
end;

function TC2BraHelper.SameValue(const AVector: TC2Bra): boolean;
begin
  result := fm1.SameValue(AVector.fm1) and
            fm2.SameValue(AVector.fm2);
end;

function TC2BraHelper.ToString: string;
begin
  result := Format('(%s, %s)', [fm1.ToString, fm2.ToString]);
end;

function TC2BraHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s)', [
    fm1.ToString(APrecision, ADigits),
    fm2.ToString(APrecision, ADigits)]);
end;

class operator TC2Bra.+(const ALeft, ARight: TC2Bra): TC2Bra;
begin
  result.fm1 := ALeft.fm1 + ARight.fm1;
  result.fm2 := ALeft.fm2 + ARight.fm2;
end;

class operator TC2Bra.-(const ALeft, ARight: TC2Bra): TC2Bra;
begin
  result.fm1 := ALeft.fm1 - ARight.fm1;
  result.fm2 := ALeft.fm2 - ARight.fm2;
end;

class operator TC2Bra.*(const ALeft: double; const ARight: TC2Bra): TC2Bra;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
end;

class operator TC2Bra.*(const ALeft: TC2Bra; const ARight: double): TC2Bra;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
end;

class operator TC2Bra.*(const ALeft: TComplex; const ARight: TC2Bra): TC2Bra;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
end;

class operator TC2Bra.*(const ALeft: TC2Bra; const ARight: TComplex): TC2Bra;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
end;

class operator TC2Bra./(const ALeft: TC2Bra; const ARight: double): TC2Bra;
begin
  result.fm1 := ALeft.fm1 / ARight;
  result.fm2 := ALeft.fm2 / ARight;
end;

class operator TC2Bra./(const ALeft: TC2Bra; const ARight: TComplex): TC2Bra;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TC2Bra.*(const ALeft: TC2Bra; const ARight: TC2Ket): TComplex;
begin
  result := ALeft.fm1*ARight.fm1 + ALeft.fm2*ARight.fm2;
end;

class operator TC2Bra.*(const ALeft: TC2Ket; const ARight: TC2Bra): TC2Matrix;
begin
  result.fm11 := ALeft.fm1*ARight.fm1;
  result.fm12 := ALeft.fm1*ARight.fm2;
  result.fm21 := ALeft.fm2*ARight.fm1;
  result.fm22 := ALeft.fm2*ARight.fm2;
end;

class operator TC2Bra.*(const ALeft: TC2Bra; const ARight: TC2Matrix): TC2Bra;
begin
  result.fm1 := ALeft.fm1*ARight.fm11 + ALeft.fm2*ARight.fm21;
  result.fm2 := ALeft.fm1*ARight.fm12 + ALeft.fm2*ARight.fm22;
end;

// TC3Bra

function TC3BraHelper.SquareNorm: double;
begin
  result :=  fm1.SquaredNorm + fm2.SquaredNorm + fm3.SquaredNorm;
end;

function TC3BraHelper.Norm: double;
begin
  result := sqrt(SquareNorm);
end;

function TC3BraHelper.TransposeDual: TC3Ket;
begin
  result.fm1 := fm1.Dual;
  result.fm2 := fm2.Dual;
  result.fm3 := fm3.Dual;
end;

function TC3BraHelper.IsNull: boolean;
begin
  result := fm1.IsNull and fm2.IsNull and fm3.IsNull;
end;

function TC3BraHelper.SameValue(const AVector: TC3Bra): boolean;
begin
  result := fm1.SameValue(AVector.fm1) and
            fm2.SameValue(AVector.fm2) and
            fm3.SameValue(AVector.fm3);
end;

function TC3BraHelper.ToString: string;
begin
  result := Format('(%s, %s, %s)', [fm1.ToString, fm2.ToString, fm3.ToString]);
end;

function TC3BraHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s)', [
    fm1.ToString(APrecision, ADigits),
    fm2.ToString(APrecision, ADigits),
    fm3.ToString(APrecision, ADigits)]);
end;

class operator TC3Bra.+(const ALeft, ARight: TC3Bra): TC3Bra;
begin
  result.fm1 := ALeft.fm1 + ARight.fm1;
  result.fm2 := ALeft.fm2 + ARight.fm2;
  result.fm3 := ALeft.fm3 + ARight.fm3;
end;

class operator TC3Bra.-(const ALeft, ARight: TC3Bra): TC3Bra;
begin
  result.fm1 := ALeft.fm1 - ARight.fm1;
  result.fm2 := ALeft.fm2 - ARight.fm2;
  result.fm3 := ALeft.fm3 - ARight.fm3;
end;

class operator TC3Bra.*(const ALeft: double; const ARight: TC3Bra): TC3Bra;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TC3Bra.*(const ALeft: TC3Bra; const ARight: double): TC3Bra;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TC3Bra.*(const ALeft: TComplex; const ARight: TC3Bra): TC3Bra;
begin
  result.fm1 := ALeft * ARight.fm1;
  result.fm2 := ALeft * ARight.fm2;
  result.fm3 := ALeft * ARight.fm3;
end;

class operator TC3Bra.*(const ALeft: TC3Bra; const ARight: TComplex): TC3Bra;
begin
  result.fm1 := ALeft.fm1 * ARight;
  result.fm2 := ALeft.fm2 * ARight;
  result.fm3 := ALeft.fm3 * ARight;
end;

class operator TC3Bra./(const ALeft: TC3Bra; const ARight: double): TC3Bra;
begin
  result.fm1 := ALeft.fm1 / ARight;
  result.fm2 := ALeft.fm2 / ARight;
  result.fm3 := ALeft.fm3 / ARight;
end;

class operator TC3Bra./(const ALeft: TC3Bra; const ARight: TComplex): TC3Bra;
begin
  result := ALeft * ARight.Reciprocal;
end;

class operator TC3Bra.*(const ALeft: TC3Bra; const ARight: TC3Ket): TComplex;
begin
  result := ALeft.fm1*ARight.fm1 + ALeft.fm2*ARight.fm2 + ALeft.fm3*ARight.fm3;
end;

class operator TC3Bra.*(const ALeft: TC3Ket; const ARight: TC3Bra): TC3Matrix;
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

class operator TC3Bra.*(const ALeft: TC3Bra; const ARight: TC3Matrix): TC3Bra;
begin
  result.fm1 := ALeft.fm1*ARight.fm11 + ALeft.fm1*ARight.fm12 + ALeft.fm1*ARight.fm13;
  result.fm2 := ALeft.fm2*ARight.fm21 + ALeft.fm2*ARight.fm22 + ALeft.fm2*ARight.fm23;
  result.fm3 := ALeft.fm3*ARight.fm31 + ALeft.fm3*ARight.fm32 + ALeft.fm3*ARight.fm33;
end;

// TC2Matrix

function TC2MatrixHelper.Trace: TComplex;
begin
  result := fm11 + fm22;
end;

function TC2MatrixHelper.EigenValues: TC2Ket;
var
  detA, TrA, TrA2: TComplex;
begin
  detA := Determinant;
  TrA  := fm11 + fm22;
  TrA2 := SquarePower(TrA);

  result.fm1 := 0.5*(TrA+SquareRoot(TrA2-4*detA).fm1);
  result.fm2 := 0.5*(TrA+SquareRoot(TrA2-4*detA).fm2);
end;

function TC2MatrixHelper.Eigenvector(const AEigenValue: TComplex): TC2Ket;
begin
  result.fm1 := AEigenValue - fm22;
  result.fm2 := fm21;

  if (result.fm1.SameValue(NullComplex)) and
     (result.fm2.SameValue(NullComplex)) then
  begin
    result.fm1 := fm12;
    result.fm2 := AEigenValue - fm11;
  end;
end;

function TC2MatrixHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm11.ToString,
    fm12.ToString,
    fm21.ToString,
    fm22.ToString]);
end;

function TC2MatrixHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm11.ToString(APrecision, ADigits),
    fm12.ToString(APrecision, ADigits),
    fm21.ToString(APrecision, ADigits),
    fm22.ToString(APrecision, ADigits)]);
end;

class operator TC2Matrix.+(const ALeft, ARight: TC2Matrix): TC2Matrix;
begin
  result.fm11 := ALeft.fm11 + ARight.fm11;
  result.fm12 := ALeft.fm12 + ARight.fm12;
  result.fm21 := ALeft.fm21 + ARight.fm21;
  result.fm22 := ALeft.fm22 + ARight.fm22;
end;

class operator TC2Matrix.-(const ALeft, ARight: TC2Matrix): TC2Matrix;
begin
  result.fm11 := ALeft.fm11 - ARight.fm11;
  result.fm12 := ALeft.fm12 - ARight.fm12;
  result.fm21 := ALeft.fm21 - ARight.fm21;
  result.fm22 := ALeft.fm22 - ARight.fm22;
end;


class operator TC2Matrix.*(const ALeft: double; const ARight: TC2Matrix): TC2Matrix;
begin
  result.fm11 := ALeft*ARight.fm11;
  result.fm12 := ALeft*ARight.fm12;
  result.fm21 := ALeft*ARight.fm21;
  result.fm22 := ALeft*ARight.fm22;
end;

class operator TC2Matrix.*(const ALeft: TC2Matrix; const ARight: double): TC2Matrix;
begin
  result.fm11 := ALeft.fm11*ARight;
  result.fm12 := ALeft.fm12*ARight;
  result.fm21 := ALeft.fm21*ARight;
  result.fm22 := ALeft.fm22*ARight;
end;

class operator TC2Matrix.*(const ALeft: TComplex; const ARight: TC2Matrix): TC2Matrix;
begin
  result.fm11 := ALeft*ARight.fm11;
  result.fm12 := ALeft*ARight.fm12;
  result.fm21 := ALeft*ARight.fm21;
  result.fm22 := ALeft*ARight.fm22;
end;

class operator TC2Matrix.*(const ALeft: TC2Matrix; const ARight: TComplex): TC2Matrix;
begin
  result.fm11 := ALeft.fm11*ARight;
  result.fm12 := ALeft.fm12*ARight;
  result.fm21 := ALeft.fm21*ARight;
  result.fm22 := ALeft.fm22*ARight;
end;

class operator TC2Matrix.*(const ALeft, ARight: TC2Matrix): TC2Matrix;
begin
  result.fm11 := ALeft.fm11*ARight.fm11 + ALeft.fm12*ARight.fm21;
  result.fm12 := ALeft.fm11*ARight.fm12 + ALeft.fm12*ARight.fm22;

  result.fm21 := ALeft.fm21*ARight.fm11 + ALeft.fm22*ARight.fm21;
  result.fm22 := ALeft.fm21*ARight.fm12 + ALeft.fm22*ARight.fm22;
end;

class operator TC2Matrix./(const ALeft: TC2Matrix; const ARight: double): TC2Matrix;
begin
  result.fm11 := ALeft.fm11/ARight;
  result.fm12 := ALeft.fm12/ARight;
  result.fm21 := ALeft.fm21/ARight;
  result.fm22 := ALeft.fm22/ARight;
end;

class operator TC2Matrix./(const ALeft: TC2Matrix; const ARight: TComplex): TC2Matrix;
begin
  result := ALeft * ARight.Reciprocal
end;

function TC2Matrix.Dual: TC2Matrix;
begin
  result.fm11 := fm11.Dual;
  result.fm12 := fm12.Dual;
  result.fm21 := fm21.Dual;
  result.fm22 := fm22.Dual;
end;

function TC2Matrix.Transpose: TC2Matrix;
begin
  result.fm11 := fm11;
  result.fm12 := fm21;
  result.fm21 := fm12;
  result.fm22 := fm22;
end;

function TC2Matrix.TransposeDual: TC2Matrix;
begin
  result.fm11 := fm11.Dual;
  result.fm12 := fm21.Dual;
  result.fm21 := fm12.Dual;
  result.fm22 := fm22.Dual;
end;

function TC2Matrix.SameValue(const AMatrix: TC2Matrix): boolean;
begin
  result := fm11.SameValue(AMatrix.fm11) and
            fm12.SameValue(AMatrix.fm12) and
            fm21.SameValue(AMatrix.fm21) and
            fm22.SameValue(AMatrix.fm22);
end;

function TC2Matrix.Determinant: TComplex;
begin
  result := fm11*fm22 - fm12*fm21;
end;

function TC2Matrix.Reciprocal(const ADeterminant: TComplex): TC2Matrix;
begin
  result.fm11 :=  fm22/ADeterminant;
  result.fm12 := -fm12/ADeterminant;
  result.fm21 := -fm21/ADeterminant;
  result.fm22 :=  fm11/ADeterminant;
end;

// TC3Matrix

function TC3MatrixHelper.Trace: TComplex;
begin
  result := fm11 + fm22 + fm33;
end;

function TC3MatrixHelper.Eigenvalues: TC3Ket;
var
  C1, C2, C3, p, q: TComplex;
  t1, t2, t3: TComplex;
begin
  t1 := Trace;
  t2 := (Self*Self).Trace;
  t3 := (Self*Self*Self).Trace;

  C1 := -t1;
  C2 := -0.5*(C1*t1+t2);
  C3 := -(C2*t1+C1*t2+t3)/3;

  p := -SquarePower(C1)/3 + C2;
  q :=  2*CubicPower(C1)/27 - C1*C2/3 + C3;

  result := CubicRoot(-q/2 + SquareRoot(q*q/4 + p*p*p/27).fm1) +
            CubicRoot(-q/2 - SquareRoot(q*q/4 + p*p*p/27).fm1);

  result.fm1 := result.fm1 - C1/3;
  result.fm2 := result.fm2 - C1/3;
  result.fm3 := result.fm3 - C1/3;
end;

function TC3MatrixHelper.Eigenvector(const AEigenValue: TComplex): TC3Ket;
begin

end;

function TC3MatrixHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm11.ToString,
    fm12.ToString,
    fm13.ToString,
    fm21.ToString,
    fm22.ToString,
    fm23.ToString,
    fm31.ToString,
    fm32.ToString,
    fm33.ToString]);
end;

function TC3MatrixHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm11.ToString(APrecision, ADigits),
    fm12.ToString(APrecision, ADigits),
    fm13.ToString(APrecision, ADigits),
    fm21.ToString(APrecision, ADigits),
    fm22.ToString(APrecision, ADigits),
    fm23.ToString(APrecision, ADigits),
    fm31.ToString(APrecision, ADigits),
    fm32.ToString(APrecision, ADigits),
    fm33.ToString(APrecision, ADigits)]);
end;

class operator TC3Matrix.+(const ALeft, ARight: TC3Matrix): TC3Matrix;
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

class operator TC3Matrix.-(const ALeft, ARight: TC3Matrix): TC3Matrix;
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

class operator TC3Matrix.*(const ALeft: double; const ARight: TC3Matrix): TC3Matrix;
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

class operator TC3Matrix.*(const ALeft: TC3Matrix; const ARight: double): TC3Matrix;
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

class operator TC3Matrix.*(const ALeft: TComplex; const ARight: TC3Matrix): TC3Matrix;
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

class operator TC3Matrix.*(const ALeft: TC3Matrix; const ARight: TComplex): TC3Matrix;
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

class operator TC3Matrix.*(const ALeft, ARight: TC3Matrix): TC3Matrix;
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

class operator TC3Matrix./(const ALeft: TC3Matrix; const ARight: double): TC3Matrix;
begin
  result.fm11 := ALeft.fm11/ARight;
  result.fm12 := ALeft.fm12/ARight;
  result.fm13 := ALeft.fm13/ARight;
  result.fm21 := ALeft.fm21/ARight;
  result.fm22 := ALeft.fm22/ARight;
  result.fm23 := ALeft.fm23/ARight;
  result.fm31 := ALeft.fm31/ARight;
  result.fm32 := ALeft.fm32/ARight;
  result.fm33 := ALeft.fm33/ARight;
end;

class operator TC3Matrix./(const ALeft: TC3Matrix; const ARight: TComplex): TC3Matrix;
begin
  result := ALeft * ARight.Reciprocal
end;

function TC3Matrix.Dual: TC3Matrix;
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

function TC3Matrix.Transpose: TC3Matrix;
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

function TC3Matrix.TransposeDual: TC3Matrix;
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

function TC3Matrix.SameValue(const AMatrix: TC3Matrix): boolean;
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

function TC3Matrix.Determinant: TComplex;
begin
  result :=  fm11*(fm22*fm33 -fm23*fm32)
            +fm12*(fm23*fm31 -fm21*fm33)
            +fm13*(fm21*fm32 -fm22*fm31);
end;

function TC3Matrix.Reciprocal(const ADeterminant: Tcomplex): TC3Matrix;
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

// Useful routines

function SquarePower(const AValue: TComplex): TComplex;
begin
  result := AValue*AValue;
end;

function SquareRoot(const AValue: TComplex): TC2Ket;
var
  norm: double;
begin
  norm := hypot(AValue.fRe, AValue.fIm);
  result.fm1.fRe := sqrt(0.5*(norm + AValue.fRe));
  if AValue.fIm >= 0 then
    result.fm1.fIm := sqrt(0.5*(norm - AValue.fRe))
  else
    result.fm1.fIm := -sqrt(0.5*(norm - AValue.fRe));
  result.fm2 := -result.fm1;
end;

function CubicPower(const AValue: TComplex): TComplex;
begin
  result := AValue*AValue*AValue;
end;

function CubicRoot(const AValue: TComplex): TC3Ket;
const
  i: TImaginaryNumber = ();
var
  theta, rootModulus, rootArgument: double;
begin
  rootModulus := Power(AValue.Norm, 1/3);
  theta := Math.ArcTan2(AValue.fIm, AValue.fRe);

  rootArgument := (theta)/3;
  result.fm1 := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);

  rootArgument := (theta+2*Pi)/3;
  result.fm2 := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);

  rootArgument := (theta+4*Pi)/3;
  result.fm3 := rootModulus*(Cos(rootArgument) + Sin(rootArgument)*i);
end;

function Commutator(const ALeft, ARight: TC2Matrix): TC2Matrix;
begin
  result := ALeft*ARight - ARight*ALeft;
end;

function Commutator(const ALeft, ARight: TC3Matrix): TC3Matrix;
begin
  result := ALeft*ARight - ARight*ALeft;
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

