{ Complex numbers, vectors and matrixes implementation }

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

// TC2VectorHelper

function TC2VectorHelper.Dual: TC2Vector;
var
  i: longint;
begin
  for i := 1 to 2 do
    result[i] := fm[i].Dual;
end;

function TC2VectorHelper.Transpose: TC2TransposedVector;
begin
  result[1] := fm[1];
  result[2] := fm[2];
end;

function TC2VectorHelper.TransposeDual: TC2TransposedVector;
begin
  result[1] := fm[1].Dual;
  result[2] := fm[2].Dual;
end;

function TC2VectorHelper.ToString: string;
begin
  result := Format('(%s, %s)', [
    fm[1].ToString,
    fm[2].ToString]);
end;

function TC2VectorHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s)', [
    fm[1].ToString(APrecision, ADigits),
    fm[2].ToString(APrecision, ADigits)]);
end;

// TC3VectorHelper

function TC3VectorHelper.Dual: TC3Vector;
var
  i: longint;
begin
  for i := 1 to 3 do
    result[i] := fm[i].Dual;
end;

function TC3VectorHelper.Transpose: TC3TransposedVector;
begin
  result[1] := fm[1];
  result[2] := fm[2];
  result[3] := fm[3];
end;

function TC3VectorHelper.TransposeDual: TC3TransposedVector;
begin
  result[1] := fm[1].Dual;
  result[2] := fm[2].Dual;
  result[3] := fm[3].Dual;
end;

function TC3VectorHelper.ToString: string;
begin
  result := Format('(%s, %s, %s)', [
    fm[1].ToString,
    fm[2].ToString,
    fm[3].ToString]);
end;

function TC3VectorHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s)', [
    fm[1].ToString(APrecision, ADigits),
    fm[2].ToString(APrecision, ADigits),
    fm[3].ToString(APrecision, ADigits)]);
end;

// TC4VectorHelper

function TC4VectorHelper.Dual: TC4Vector;
var
  i: longint;
begin
  for i := 1 to 4 do
    result[i] := fm[i].Dual;
end;

function TC4VectorHelper.Transpose: TC4TransposedVector;
begin
  result[1] := fm[1];
  result[2] := fm[2];
  result[3] := fm[3];
  result[4] := fm[4];
end;

function TC4VectorHelper.TransposeDual: TC4TransposedVector;
begin
  result[1] := fm[1].Dual;
  result[2] := fm[2].Dual;
  result[3] := fm[3].Dual;
  result[4] := fm[4].Dual;
end;

function TC4VectorHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm[1].ToString,
    fm[2].ToString,
    fm[3].ToString,
    fm[4].ToString]);
end;

function TC4VectorHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm[1].ToString(APrecision, ADigits),
    fm[2].ToString(APrecision, ADigits),
    fm[3].ToString(APrecision, ADigits),
    fm[4].ToString(APrecision, ADigits)]);
end;

// TC2TransposedVectorHelper

function TC2TransposedVectorHelper.Dual: TC2TransposedVector;
var
  i: longint;
begin
  for i := 1 to 2 do
    result[i] := fm[i].Dual;
end;

function TC2TransposedVectorHelper.Transpose: TC2Vector;
begin
  result[1] := fm[1];
  result[2] := fm[2];
end;

function TC2TransposedVectorHelper.TransposeDual: TC2Vector;
begin
  result[1] := fm[1].Dual;
  result[2] := fm[2].Dual;
end;

function TC2TransposedVectorHelper.ToString: string;
begin
  result := Format('(%s, %s)', [
    fm[1].ToString,
    fm[2].ToString]);
end;

function TC2TransposedVectorHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s)', [
    fm[1].ToString(APrecision, ADigits),
    fm[2].ToString(APrecision, ADigits)]);
end;

// TC3TransposedVectorHelper

function TC3TransposedVectorHelper.Dual: TC3TransposedVector;
var
  i: longint;
begin
  for i := 1 to 3 do
    result[i] := fm[i].Dual;
end;

function TC3TransposedVectorHelper.Transpose: TC3Vector;
begin
  result[1] := fm[1];
  result[2] := fm[2];
  result[3] := fm[3];
end;

function TC3TransposedVectorHelper.TransposeDual: TC3Vector;
begin
  result[1] := fm[1].Dual;
  result[2] := fm[2].Dual;
  result[3] := fm[3].Dual;
end;

function TC3TransposedVectorHelper.ToString: string;
begin
  result := Format('(%s, %s, %s)', [
    fm[1].ToString,
    fm[2].ToString,
    fm[3].ToString]);
end;

function TC3TransposedVectorHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s)', [
    fm[1].ToString(APrecision, ADigits),
    fm[2].ToString(APrecision, ADigits),
    fm[3].ToString(APrecision, ADigits)]);
end;

// TC4TransposedVectorHelper

function TC4TransposedVectorHelper.Dual: TC4TransposedVector;
var
  i: longint;
begin
  for i := 1 to 4 do
    result[i] := fm[i].Dual;
end;

function TC4TransposedVectorHelper.Transpose: TC4Vector;
begin
  result[1] := fm[1];
  result[2] := fm[2];
  result[3] := fm[3];
  result[4] := fm[4];
end;

function TC4TransposedVectorHelper.TransposeDual: TC4Vector;
begin
  result[1] := fm[1].Dual;
  result[2] := fm[2].Dual;
  result[3] := fm[3].Dual;
  result[4] := fm[4].Dual;
end;

function TC4TransposedVectorHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm[1].ToString,
    fm[2].ToString,
    fm[3].ToString,
    fm[4].ToString]);
end;

function TC4TransposedVectorHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm[1].ToString(APrecision, ADigits),
    fm[2].ToString(APrecision, ADigits),
    fm[3].ToString(APrecision, ADigits),
    fm[4].ToString(APrecision, ADigits)]);
end;

// TC2MatrixHelper

function TC2MatrixHelper.Dual: TC2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
    begin
      result[i, j] := fm[i, j].Dual;
    end;
end;

function TC2MatrixHelper.Determinant: TComplex;
begin
  result := fm[1,1]*fm[2,2] - fm[1,2]*fm[2,1];
end;

function TC2MatrixHelper.Reciprocal(const ADeterminant: TComplex): TC2Matrix;
begin
  result[1,1] :=  fm[2,2]/ADeterminant;
  result[1,2] := -fm[1,2]/ADeterminant;
  result[2,1] := -fm[2,1]/ADeterminant;
  result[2,2] :=  fm[1,1]/ADeterminant;
end;

function TC2MatrixHelper.EigenValues: TC2Array;
var
  detA, TrA, TrA2: TComplex;
begin
  detA := Determinant;
  TrA  := fm[1,1] + fm[2,2];
  TrA2 := SquarePower(TrA);

  result[1] := 0.5*(TrA+SquareRoot(TrA2-4*detA)[1]);
  result[2] := 0.5*(TrA+SquareRoot(TrA2-4*detA)[2]);
end;

function TC2MatrixHelper.Eigenvectors(const AEigenValues: TC2Array): TC2Eigenvectors;
var
  A: TC2Matrix;
  i, j, Multiplicity: longint;
begin
  for i := Low(result) to High(result) do
  begin
    A := (Self - AEigenvalues[i]*C2IdMatrix).RowReduction;

    Multiplicity := 1;
    // Calculate algebraic multiplicity of eigenvalues
    for j := (i - 1) downto Low(AEigenvalues) do
      if SameValue(AEigenvalues[j], AEigenvalues[i]) then
        Inc(Multiplicity);

    // Assign a value to free parameter, ensuring only one assignment
    for j := Low(AEigenvalues) to High(AEigenvalues) do
    begin
      result[i].fm[j]:= 0;
      if A[j, j].IsNull then
      begin
        if Multiplicity = 1 then
          result[i].fm[j]:= 1;

        Dec(Multiplicity);
      end;
    end;

    // Solve linear system
    if A[1,1].IsNotNull then
    begin
      result[i].fm[1] := -(A[1,2]*result[i].fm[2])/A[1,1];
    end;
  end;
end;

function TC2MatrixHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm[1,1].ToString, fm[1,2].ToString,
    fm[2,1].ToString, fm[2,2].ToString]);
end;

function TC2MatrixHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm[1,1].ToString(APrecision, ADigits), fm[1,2].ToString(APrecision, ADigits),
    fm[2,1].ToString(APrecision, ADigits), fm[2,2].ToString(APrecision, ADigits)]);
end;


// TC3MatrixHelper

function TC3MatrixHelper.Dual: TC3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
    begin
      result[i, j] := fm[i, j].Dual;
    end;
end;

function TC3MatrixHelper.Determinant: TComplex;
begin
  result :=  fm[1,1]*(fm[2,2]*fm[3,3]-fm[2,3]*fm[3,2])
            +fm[1,2]*(fm[2,3]*fm[3,1]-fm[2,1]*fm[3,3])
            +fm[1,3]*(fm[2,1]*fm[3,2]-fm[2,2]*fm[3,1]);
end;

function TC3MatrixHelper.Eigenvalues: TC3Array;
var
  C1, C2, C3: TComplex;
  t1, t2, t3: TComplex;
begin
  t1 := Trace;
  t2 := (Self*Self).Trace;
  t3 := (Self*Self*Self).Trace;

  C1 := -t1;
  C2 := -(C1*t1+t2)/2;
  C3 := -(C2*t1+C1*t2+t3)/3;

  result := SolveEquation(C1, C2, C3);
end;

function TC3MatrixHelper.Eigenvectors(const AEigenvalues: TC3Array): TC3Eigenvectors;
var
  A: TC3Matrix;
  i, j, Multiplicity: longint;
begin
  for i := Low(AEigenvalues) to High(AEigenvalues) do
  begin
    A := (Self - AEigenvalues[i] * C3IdMatrix).RowReduction;

    Multiplicity := 1;
    // Calculate algebraic multiplicity of eigenvalues
    for j := (i - 1) downto Low(AEigenvalues) do
      if SameValue(AEigenvalues[j], AEigenvalues[i]) then
        Inc(Multiplicity);

    // Assign a value to free parameter, ensuring only one assignment
    for j := Low(AEigenvalues) to High(AEigenvalues) do
    begin
      result[i].fm[j]:= 0;
      if A[j, j].IsNull then
      begin
        if Multiplicity = 1 then
          result[i].fm[j]:= 1;

        Dec(Multiplicity);
      end;
    end;

    // Solve linear system
    if A[2,2].IsNotNull then
      result[i].fm[2] := -(A[2,3] * result[i].fm[3]) / A[2,2];

    if A[1,1].IsNotNull then
    begin
      result[i].fm[1] := -(A[1,2] * result[i].fm[2] + A[1,3] * result[i].fm[3]) / A[1,1];
    end else
      if A[1,2].IsNotNull then
      begin
        result[i].fm[2] := -(A[1,3] * result[i].fm[3]) / A[1,2];
      end;
  end;
end;

function TC3MatrixHelper.Reciprocal(const ADeterminant: TComplex): TC3Matrix;
begin
  result.fm[1,1] :=  (fm[2,2]*fm[3,3] -fm[2,3]*fm[3,2]) / ADeterminant;
  result.fm[1,2] := -(fm[1,2]*fm[3,3] -fm[1,3]*fm[3,2]) / ADeterminant;
  result.fm[1,3] :=  (fm[1,2]*fm[2,3] -fm[1,3]*fm[2,2]) / ADeterminant;
  result.fm[2,1] := -(fm[2,1]*fm[3,3] -fm[2,3]*fm[3,1]) / ADeterminant;
  result.fm[2,2] :=  (fm[1,1]*fm[3,3] -fm[1,3]*fm[3,1]) / ADeterminant;
  result.fm[2,3] := -(fm[1,1]*fm[2,3] -fm[1,3]*fm[2,1]) / ADeterminant;
  result.fm[3,1] :=  (fm[2,1]*fm[3,2] -fm[2,2]*fm[3,1]) / ADeterminant;
  result.fm[3,2] := -(fm[1,1]*fm[3,2] -fm[1,2]*fm[3,1]) / ADeterminant;
  result.fm[3,3] :=  (fm[1,1]*fm[2,2] -fm[1,2]*fm[2,1]) / ADeterminant;
end;


function TC3MatrixHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString, fm[1,2].ToString, fm[1,3].ToString,
    fm[2,1].ToString, fm[2,2].ToString, fm[2,3].ToString,
    fm[3,1].ToString, fm[3,2].ToString, fm[3,3].ToString]);
end;

function TC3MatrixHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString(APrecision, ADigits), fm[1,2].ToString(APrecision, ADigits), fm[1,3].ToString(APrecision, ADigits),
    fm[2,1].ToString(APrecision, ADigits), fm[2,2].ToString(APrecision, ADigits), fm[2,3].ToString(APrecision, ADigits),
    fm[3,1].ToString(APrecision, ADigits), fm[3,2].ToString(APrecision, ADigits), fm[3,3].ToString(APrecision, ADigits)]);
end;

// TC4MatrixHelper

function TC4MatrixHelper.Dual: TC4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      result[i, j] := fm[i, j].Dual;
    end;
end;

function TC4MatrixHelper.Determinant: TComplex;
begin
  result := (fm[1,1]*fm[2,2]-fm[1,2]*fm[2,1])*(fm[3,3]*fm[4,4]-fm[3,4]*fm[4,3]) -
            (fm[1,1]*fm[2,3]-fm[1,3]*fm[2,1])*(fm[3,2]*fm[4,4]-fm[3,4]*fm[4,2]) +
            (fm[1,1]*fm[2,4]-fm[1,4]*fm[2,1])*(fm[3,2]*fm[4,3]-fm[3,3]*fm[4,2]) +
            (fm[1,2]*fm[2,3]-fm[1,3]*fm[2,2])*(fm[3,1]*fm[4,4]-fm[3,4]*fm[4,1]) -
            (fm[1,2]*fm[2,4]-fm[1,4]*fm[2,2])*(fm[3,1]*fm[4,3]-fm[3,3]*fm[4,1]) +
            (fm[1,3]*fm[2,4]-fm[1,4]*fm[2,3])*(fm[3,1]*fm[4,2]-fm[3,2]*fm[4,1]) ;
end;

function TC4MatrixHelper.Eigenvalues: TC4Array;
var
  C1, C2, C3, C4: TComplex;
  t1, t2, t3, t4: TComplex;
begin
  t1 := Trace;
  t2 := (Self*Self).Trace;
  t3 := (Self*Self*Self).Trace;
  t4 := (Self*Self*Self*Self).Trace;

  C1 := -(t1);
  C2 := -(C1*t1+t2)/2;
  C3 := -(C2*t1+C1*t2+t3)/3;
  C4 := -(C3*t1+C2*t2+C1*t3+t4)/4;

  result := SolveEquation(C1, C2, C3, C4);
end;

function TC4MatrixHelper.Eigenvectors(const AEigenvalues: TC4Array): TC4Eigenvectors;
var
  A: TC4Matrix;
  i, j, Multiplicity: longint;
begin
  for i := Low(AEigenvalues) to High(AEigenvalues) do
  begin
    A := (Self - AEigenvalues[i] * C4IdMatrix).RowReduction;

    Multiplicity := 1;
    // Calculate algebraic multiplicity of eigenvalues
    for j := (i - 1) downto Low(AEigenvalues) do
      if SameValue(AEigenvalues[j], AEigenvalues[i]) then
        Inc(Multiplicity);

    // Assign a value to free parameter, ensuring only one assignment
    for j := Low(AEigenvalues) to High(AEigenvalues) do
    begin
      result[i].fm[j]:= 0;
      if A[j, j].IsNull then
      begin
        if Multiplicity = 1 then
          result[i].fm[j]:= 1;

        Dec(Multiplicity);
      end;
    end;

    // Solve linear system
    if A[3,3].IsNotNull and A[3,4].IsNotNull then
      result[i].fm[3] := -(A[3,4] * result[i].fm[4]) / A[3,3];

    if A[2,2].IsNotNull then
    begin
      result[i].fm[2] := -(A[2,3] * result[i].fm[3] + A[2,4] * result[i].fm[4]) / A[2,2];
    end else
      if A[2,3].IsNotNull then
      begin
        result[i].fm[3] := -(A[2,4] * result[i].fm[4]) / A[2,3];
      end;

    if A[1,1].IsNotNull then
    begin
      result[i].fm[1] := -(A[1,2] * result[i].fm[2] + A[1,3] * result[i].fm[3] + A[1,4] * result[i].fm[4]) / A[1,1];
    end else
      if A[1,2].IsNotNull then
      begin
        result[i].fm[2] := -(A[1,3] * result[i].fm[3] + A[1,4] * result[i].fm[4]) / A[1,2];
      end else
        if A[1,3].IsNotNull then
        begin
          result[i].fm[3] := -(A[1,4] * result[i].fm[4]) / A[1,3];
        end;
  end;
end;

function TC4MatrixHelper.Reciprocal(const ADeterminant: TComplex): TC4Matrix;
begin
  result[1,1]:= (fm[2,2]*(fm[3,3]*fm[4,4]-fm[3,4]*fm[4,3])+
                 fm[2,3]*(fm[3,4]*fm[4,2]-fm[3,2]*fm[4,4])+
                 fm[2,4]*(fm[3,2]*fm[4,3]-fm[3,3]*fm[4,2]))/Adeterminant;
  result[1,2]:= (fm[3,2]*(fm[1,3]*fm[4,4]-fm[1,4]*fm[4,3])+
                 fm[3,3]*(fm[1,4]*fm[4,2]-fm[1,2]*fm[4,4])+
                 fm[3,4]*(fm[1,2]*fm[4,3]-fm[1,3]*fm[4,2]))/Adeterminant;
  result[1,3]:= (fm[4,2]*(fm[1,3]*fm[2,4]-fm[1,4]*fm[2,3])+
                 fm[4,3]*(fm[1,4]*fm[2,2]-fm[1,2]*fm[2,4])+
                 fm[4,4]*(fm[1,2]*fm[2,3]-fm[1,3]*fm[2,2]))/Adeterminant;
  result[1,4]:= (fm[1,2]*(fm[2,4]*fm[3,3]-fm[2,3]*fm[3,4])+
                 fm[1,3]*(fm[2,2]*fm[3,4]-fm[2,4]*fm[3,2])+
                 fm[1,4]*(fm[2,3]*fm[3,2]-fm[2,2]*fm[3,3]))/Adeterminant;
  result[2,1]:= (fm[2,3]*(fm[3,1]*fm[4,4]-fm[3,4]*fm[4,1])+
                 fm[2,4]*(fm[3,3]*fm[4,1]-fm[3,1]*fm[4,3])+
                 fm[2,1]*(fm[3,4]*fm[4,3]-fm[3,3]*fm[4,4]))/Adeterminant;
  result[2,2]:= (fm[3,3]*(fm[1,1]*fm[4,4]-fm[1,4]*fm[4,1])+
                 fm[3,4]*(fm[1,3]*fm[4,1]-fm[1,1]*fm[4,3])+
                 fm[3,1]*(fm[1,4]*fm[4,3]-fm[1,3]*fm[4,4]))/Adeterminant;
  result[2,3]:= (fm[4,3]*(fm[1,1]*fm[2,4]-fm[1,4]*fm[2,1])+
                 fm[4,4]*(fm[1,3]*fm[2,1]-fm[1,1]*fm[2,3])+
                 fm[4,1]*(fm[1,4]*fm[2,3]-fm[1,3]*fm[2,4]))/Adeterminant;
  result[2,4]:= (fm[1,3]*(fm[2,4]*fm[3,1]-fm[2,1]*fm[3,4])+
                 fm[1,4]*(fm[2,1]*fm[3,3]-fm[2,3]*fm[3,1])+
                 fm[1,1]*(fm[2,3]*fm[3,4]-fm[2,4]*fm[3,3]))/Adeterminant;
  result[3,1]:= (fm[2,4]*(fm[3,1]*fm[4,2]-fm[3,2]*fm[4,1])+
                 fm[2,1]*(fm[3,2]*fm[4,4]-fm[3,4]*fm[4,2])+
                 fm[2,2]*(fm[3,4]*fm[4,1]-fm[3,1]*fm[4,4]))/Adeterminant;
  result[3,2]:= (fm[3,4]*(fm[1,1]*fm[4,2]-fm[1,2]*fm[4,1])+
                 fm[3,1]*(fm[1,2]*fm[4,4]-fm[1,4]*fm[4,2])+
                 fm[3,2]*(fm[1,4]*fm[4,1]-fm[1,1]*fm[4,4]))/Adeterminant;
  result[3,3]:= (fm[4,4]*(fm[1,1]*fm[2,2]-fm[1,2]*fm[2,1])+
                 fm[4,1]*(fm[1,2]*fm[2,4]-fm[1,4]*fm[2,2])+
                 fm[4,2]*(fm[1,4]*fm[2,1]-fm[1,1]*fm[2,4]))/Adeterminant;
  result[3,4]:= (fm[1,4]*(fm[2,2]*fm[3,1]-fm[2,1]*fm[3,2])+
                 fm[1,1]*(fm[2,4]*fm[3,2]-fm[2,2]*fm[3,4])+
                 fm[1,2]*(fm[2,1]*fm[3,4]-fm[2,4]*fm[3,1]))/Adeterminant;
  result[4,1]:= (fm[2,1]*(fm[3,3]*fm[4,2]-fm[3,2]*fm[4,3])+
                 fm[2,2]*(fm[3,1]*fm[4,3]-fm[3,3]*fm[4,1])+
                 fm[2,3]*(fm[3,2]*fm[4,1]-fm[3,1]*fm[4,2]))/Adeterminant;
  result[4,2]:= (fm[3,1]*(fm[1,3]*fm[4,2]-fm[1,2]*fm[4,3])+
                 fm[3,2]*(fm[1,1]*fm[4,3]-fm[1,3]*fm[4,1])+
                 fm[3,3]*(fm[1,2]*fm[4,1]-fm[1,1]*fm[4,2]))/Adeterminant;
  result[4,3]:= (fm[4,1]*(fm[1,3]*fm[2,2]-fm[1,2]*fm[2,3])+
                 fm[4,2]*(fm[1,1]*fm[2,3]-fm[1,3]*fm[2,1])+
                 fm[4,3]*(fm[1,2]*fm[2,1]-fm[1,1]*fm[2,2]))/Adeterminant;
  result[4,4]:= (fm[1,1]*(fm[2,2]*fm[3,3]-fm[2,3]*fm[3,2])+
                 fm[1,2]*(fm[2,3]*fm[3,1]-fm[2,1]*fm[3,3])+
                 fm[1,3]*(fm[2,1]*fm[3,2]-fm[2,2]*fm[3,1]))/Adeterminant;

end;

function TC4MatrixHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString, fm[1,2].ToString, fm[1,3].ToString, fm[1,4].ToString,
    fm[2,1].ToString, fm[2,2].ToString, fm[2,3].ToString, fm[2,4].ToString,
    fm[3,1].ToString, fm[3,2].ToString, fm[3,3].ToString, fm[3,4].ToString,
    fm[4,1].ToString, fm[4,2].ToString, fm[4,3].ToString, fm[4,4].ToString]);
end;

function TC4MatrixHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString(APrecision, ADigits), fm[1,2].ToString(APrecision, ADigits), fm[1,3].ToString, fm[1,4].ToString(APrecision, ADigits),
    fm[2,1].ToString(APrecision, ADigits), fm[2,2].ToString(APrecision, ADigits), fm[2,3].ToString, fm[2,4].ToString(APrecision, ADigits),
    fm[3,1].ToString(APrecision, ADigits), fm[3,2].ToString(APrecision, ADigits), fm[3,3].ToString, fm[3,4].ToString(APrecision, ADigits),
    fm[4,1].ToString(APrecision, ADigits), fm[4,2].ToString(APrecision, ADigits), fm[4,3].ToString, fm[4,4].ToString(APrecision, ADigits)]);
end;

// TMatrix

function TMatrix.Get(ARow, ACol: longint): TType;
begin
  result := fm[ARow, ACol];
end;

procedure TMatrix.Put(ARow, ACol: longint; AValue: TType);
begin
  fm[ARow, ACol] := AValue;
end;

function TMatrix.IsNull: boolean;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      if not SameValue(fm[i, j], 0) then Exit(False);
    end;
  result := True;
end;

function TMatrix.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TMatrix.RowReduction: TMatrix;
var
  ratio: TComplex;
  var i, j, k, maxRow: longint;
begin
  result := Self;
  // Step 1: Forward elimination (Gaussian elimination)
  for i := 1 to TSpace.N do
  begin
    // Find the row with the largest absolute value in the current column (Partial Pivoting)
    maxRow := i;
    for j := i + 1 to TSpace.N do
      if result[j ,i].Norm > result[maxRow, i].Norm then maxRow := j;

    // Swap the current row with the row having the largest pivot
    if maxRow <> i then
      result.Swap(maxRow, i);

    if result[i, i].IsNotNull then
    begin
      // Normalize the pivot row (Make the pivot element 1)
      for j := i + 1 to TSpace.N do
        result[i, j] := result[i, j] / result[i, i];
      result[i, i] := 1;
      // Eliminate elements below the pivot (Create upper triangular form)
      for j := i + 1 to TSpace.N do
        if result[j, i].Norm <> 0 then
        begin
          // Factor to eliminate the element
          ratio := result[j, i];

          for k := i + 1 to TSpace.N do
          begin
            result[j, k] := result[j, k] - ratio*result[i, k]
          end;
          // Explicitly set to zero for numerical stability
          result[j , i] := 0;
        end;
    end;
  end;

  // Step 2: Back-substitution (Convert to reduced row echelon form)
  for i := TSpace.N downto 1 do
    if result[i, i].IsNotNull then
    begin
      // Eliminate elements above the pivot
      for j := i - 1 downto 1 do
      begin
        // Factor to eliminate the element
        ratio := result[j, i];

        for k := i to TSpace.N do
          result[j, k] := result[j, k] - ratio * result[i, k];
        // Explicitly set to zero
        result[j, i] := 0;
      end;
    end;
end;

procedure TMatrix.Swap(ARow1, ARow2: longint);
var
  i: longint;
  r: array[1..TSpace.N] of TComplex;
begin
  for i := 1 to TSpace.N do r[i]           := Self[ARow1, i];
  for i := 1 to TSpace.N do Self[ARow1, i] := Self[ARow2, i];
  for i := 1 to TSpace.N do Self[ARow2, i] := r[i];
end;

function TMatrix.Trace: TType;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + fm[i, i];
end;

function TMatrix.Transpose: TMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := fm[j, i];
    end;
end;

function TMatrix.TransposeDual: TMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := fm[j, i].Dual;
    end;
end;

class operator TMatrix.+(const ALeft, ARight: TMatrix): TMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] + ARight[i, j];
    end;
end;

class operator TMatrix.-(const ALeft, ARight: TMatrix): TMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] - ARight[i, j];
    end;
end;

class operator TMatrix.*(const ALeft: TType; const ARight: TMatrix): TMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft * ARight[i, j];
    end;
end;

class operator TMatrix.*(const ALeft: TMatrix; const ARight: TType): TMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] * ARight;
    end;
end;

class operator TMatrix.*(const ALeft, ARight: TMatrix): TMatrix;
var
  i, j, k: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := 0;
      for k := 1 to TSpace.N do
        result[i, j] := result[i, j] + ALeft[i, k] * ARight[k, j];
    end;
end;

class operator TMatrix./(const ALeft: TMatrix; const ARight: TType): TMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] / ARight;
    end;
end;

// TVector

function TVector.Get(ARow: longint): TType;
begin
  result := fm[ARow];
end;

procedure TVector.Put(ARow: longint; AValue: TType);
begin
  fm[ARow] := AValue;
end;

function TVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
  begin
    if not SameValue(fm[i], 0) then Exit(False);
  end;
  result := True;
end;

function TVector.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TVector.Norm: double;
begin
  result := sqrt(SquareNorm);
end;

function TVector.Normalize: TSelf;
var
  i: longint;
  n: double;
begin
  n := Norm;
  for i := 1 to TSpace.N do
    result[i] := fm[i] / n;
end;

function TVector.SquareNorm: double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + fm[i].SquaredNorm;
end;

class operator TVector.+(const ALeft, ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] + ARight[i];
end;

class operator TVector.-(const ALeft, ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] - ARight[i];
end;

class operator TVector.*(const ALeft: TType; const ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft * ARight[i];
end;

class operator TVector.*(const ALeft: TSelf; const ARight: TType): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] * ARight;
end;

class operator TVector.*(const ALeft: TMatrix; const ARight: TSelf): TSelf;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
  begin
    result[i] := 0;
    for j := 1 to TSpace.N do
    begin
      result[i] := result[i] + ALeft[i, j] * ARight[j];
    end;
  end;
end;

class operator TVector./(const ALeft: TSelf; const ARight: TType): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] / ARight;
end;

// TTransposedVector

function TTransposedVector.Get(ACol: longint): TType;
begin
  result := fm[ACol];
end;

procedure TTransposedVector.Put(ACol: longint; AValue: TType);
begin
  fm[ACol] := AValue;
end;

function TTransposedVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    if not SameValue(fm[i], 0) then Exit(False);
  result := True;
end;

function TTransposedVector.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TTransposedVector.Norm: double;
begin
  result := sqrt(SquareNorm);
end;

function TTransposedVector.SquareNorm: double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + fm[i].SquaredNorm;
end;

function TTransposedVector.Normalize: TSelf;
var
  i: longint;
  n: double;
begin
  n := Norm;
  for i := 1 to TSpace.N do
    result[i] := fm[i] / n;
end;

class operator TTransposedVector.+(const ALeft, ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft[i] + ARight[i];
end;

class operator TTransposedVector.-(const ALeft, ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft[i] - ARight[i];
end;

class operator TTransposedVector.*(const ALeft: TType; const ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft * ARight[i];
end;

class operator TTransposedVector.*(const ALeft: TSelf; const ARight: TType): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft[i] * ARight;
end;

class operator TTransposedVector.*(const ALeft: TSelf; const ARight: TVector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to  TSpace.N do
    result := result + ALeft[i] * ARight[i];
end;

class operator TTransposedVector.*(const ALeft: TVector; const ARight: TSelf): TMatrix;
var
  i, j: longint;
begin
  for i := 1 to  TSpace.N do
    for j := 1 to  TSpace.N do
      result[i, j] := ALeft[i] * ARight[j];
end;

class operator TTransposedVector.*(const ALeft: TSelf; const ARight: TMatrix): TSelf;
var
  i, j: longint;
begin
  for i := 1 to  TSpace.N do
  begin
    result[i] := 0;
    for j := 1 to  TSpace.N do
      result[i] := result[i] + ALeft[i] * ARight[i, j];
  end;
end;

class operator TTransposedVector./(const ALeft: TSelf; const ARight: TType): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft[i] / ARight;
end;

// Useful routines

function SquarePower(const AValue: TComplex): TComplex;
begin
  result := AValue*AValue;
end;

function CubicPower(const AValue: TComplex): TComplex;
begin
  result := AValue*AValue*AValue;
end;

function QuarticPower(const AValue: TComplex): TComplex;
begin
  result := AValue*AValue*AValue*AValue;
end;

function SquareRoot(const AValue: TComplex): TC2Array;
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

function CubicRoot(const AValue: TComplex): TC3Array;
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

function QuarticRoot(const AValue: TComplex): TC4Array;
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

function SolveEquation(const a: double): double;
begin
  result := -a;
end;

function SolveEquation(const a: TComplex): TComplex;
begin
  result := -a;
end;

function SolveEquation(const a, b: TComplex): TC2Array;
var
  delta: TComplex;
begin
  delta := SquareRoot(SquarePower(a) - 4*b)[1];
  result[1] := (-a + delta)/2;
  result[2] := (-a - delta)/2;
end;

function SolveEquation(const a, b, c: TComplex): TC3Array;
var
  p, q, s1, t: TComplex;

  u: TC3Array;
  v: TC2Array;
begin
  p := 9*b -3*SquarePower(a);
  q := 27*c -9*a*b +2*CubicPower(a);

  if p.IsNotNull and q.IsNotNull then
  begin
    s1 := -q/2 + SquareRoot(SquarePower(q)/4 + CubicPower(p)/27)[1];
  //s2 := -q/2 - SquareRoot(SquarePower(q)/4 + CubicPower(p)/27)[2];
    u := CubicRoot(s1);
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
        v := SquareRoot(p);
        result[1] :=0;
        result[2] := v[1];
        result[3] := v[2];
      end else
      begin
        u := CubicRoot(q);
        result[1] := u[1];
        result[2] := u[2];
        result[3] := u[3];
      end;
end;

function SolveEquation(const a, b, c, d: TComplex): TC4Array;
var
  p, q, r: TComplex;
  u1, u2, u3: TC2Array;
  v1: TC3Array;
  v2, v3: TC2Array;

  alpha: TComplex;
  beta: TComplex;
  gamma: Tcomplex;
begin
  p := 16*b -6*SquarePower(a);
  q := 64*c -32*a*b +8*CubicPower(a);
  r := 256*d -64*a*c +16*b*SquarePower(a) -3*QuarticPower(a);

  if q.IsNull then
  begin
    u1 := SolveEquation(p, r);
    u2 := SquareRoot(u1[1]);
    u3 := SquareRoot(u1[2]);

    result[1] := (u2[1] -a)/4;
    result[2] := (u2[2] -a)/4;
    result[3] := (u3[1] -a)/4;
    result[4] := (u3[2] -a)/4;
  end else
  begin
    v1 := SolveEquation(2*p, SquarePower(p)-4*r, -SquarePower(q));

    alpha := SquareRoot(v1[1])[1];
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

// Usefull routines

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
  result[1,1] := 0; result[1,2] := 0;
  result[2,1] := 0; result[2,2] := 0;
end;

function C3NullMatrix: TC3Matrix;
begin
  result[1,1] := 0; result[1,2] := 0; result[1,3] := 0;
  result[2,1] := 0; result[2,2] := 0; result[2,3] := 0;
  result[3,1] := 0; result[3,2] := 0; result[3,3] := 0;
end;

function C4NullMatrix: TC4Matrix;
begin
  result[1,1] := 0; result[1,2] := 0; result[1,3] := 0; result[1,4] := 0;
  result[2,1] := 0; result[2,2] := 0; result[2,3] := 0; result[2,4] := 0;
  result[3,1] := 0; result[3,2] := 0; result[3,3] := 0; result[3,4] := 0;
  result[4,1] := 0; result[4,2] := 0; result[4,3] := 0; result[4,4] := 0;
end;

function C2IdMatrix: TC2Matrix;
begin
  result[1,1] := 1; result[1,2] := 0;
  result[2,1] := 0; result[2,2] := 1;
end;

function C3IdMatrix: TC3Matrix;
begin
  result[1,1] := 1; result[1,2] := 0; result[1,3] := 0;
  result[2,1] := 0; result[2,2] := 1; result[2,3] := 0;
  result[3,1] := 0; result[3,2] := 0; result[3,3] := 1;
end;

function C4IdMatrix: TC4Matrix;
begin
  result[1,1] := 1; result[1,2] := 0; result[1,3] := 0; result[1,4] := 0;
  result[2,1] := 0; result[2,2] := 1; result[2,3] := 0; result[2,4] := 0;
  result[3,1] := 0; result[3,2] := 0; result[3,3] := 1; result[3,4] := 0;
  result[4,1] := 0; result[4,2] := 0; result[4,3] := 0; result[4,4] := 1;
end;

