
{ Matrix and vector implementation }

// TCMatrix

function TCMatrix.Get(ARow, ACol: longint): TComplex;
begin
  result := fm[ARow, ACol];
end;

procedure TCMatrix.Put(ARow, ACol: longint; AValue: TComplex);
begin
  fm[ARow, ACol] := AValue;
end;

function TCMatrix.IsNull: boolean;
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

function TCMatrix.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TCMatrix.RowReduction: TCMatrix;
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
      if Abs(result[j ,i]) > Abs(result[maxRow, i]) then maxRow := j;

    // Swap the current row with the row having the largest pivot
    if maxRow <> i then
      result.Swap(maxRow, i);

    if result[i, i] <> 0 then
    begin
      // Normalize the pivot row (Make the pivot element 1)
      for j := i + 1 to TSpace.N do
        result[i, j] := result[i, j] / result[i, i];
      result[i, i] := 1;
      // Eliminate elements below the pivot (Create upper triangular form)
      for j := i + 1 to TSpace.N do
        if result[j, i] <> 0 then
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
    if result[i, i] <> 0 then
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

procedure TCMatrix.Swap(ARow1, ARow2: longint);
var
  i: longint;
  r: array[1..TSpace.N] of TComplex;
begin
  for i := 1 to TSpace.N do r[i]           := Self[ARow1, i];
  for i := 1 to TSpace.N do Self[ARow1, i] := Self[ARow2, i];
  for i := 1 to TSpace.N do Self[ARow2, i] := r[i];
end;

function TCMatrix.Trace: TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + fm[i, i];
end;

function TCMatrix.Transpose: TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := fm[j, i];
    end;
end;

class operator TCMatrix.<>(const ALeft, ARight: TSelf): boolean;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      if ALeft[i, j] <> ARight[i, j] then Exit(True);
    end;

  result := False;
end;

class operator TCMatrix.=(const ALeft, ARight: TSelf): boolean;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      if ALeft[i, j] <> ARight[i, j] then Exit(False);
    end;

  result := True;
end;

class operator TCMatrix.+(const ALeft, ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] + ARight[i, j];
    end;
end;

class operator TCMatrix.-(const ALeft, ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] - ARight[i, j];
    end;
end;

class operator TCMatrix.*(const ALeft: TComplex; const ARight: TCMatrix): TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft * ARight[i, j];
    end;
end;

class operator TCMatrix.*(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] * ARight;
    end;
end;

class operator TCMatrix.*(const ALeft, ARight: TCMatrix): TCMatrix;
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

class operator TCMatrix./(const ALeft: TCMatrix; const ARight: TComplex): TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] / ARight;
    end;
end;

// TRMatrix

function TRMatrix.Get(ARow, ACol: longint): double;
begin
  result := fm[ARow, ACol];
end;

procedure TRMatrix.Put(ARow, ACol: longint; AValue: double);
begin
  fm[ARow, ACol] := AValue;
end;

function TRMatrix.IsNull: boolean;
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

function TRMatrix.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TRMatrix.RowReduction: TRMatrix;
var
  ratio: double;
  var i, j, k, maxRow: longint;
begin
  result := Self;
  // Step 1: Forward elimination (Gaussian elimination)
  for i := 1 to TSpace.N do
  begin
    // Find the row with the largest absolute value in the current column (Partial Pivoting)
    maxRow := i;
    for j := i + 1 to TSpace.N do
      if Abs(result[j ,i]) > Abs(result[maxRow, i]) then maxRow := j;

    // Swap the current row with the row having the largest pivot
    if maxRow <> i then
      result.Swap(maxRow, i);

    if result[i, i] <> 0 then
    begin
      // Normalize the pivot row (Make the pivot element 1)
      for j := i + 1 to TSpace.N do
        result[i, j] := result[i, j] / result[i, i];
      result[i, i] := 1;
      // Eliminate elements below the pivot (Create upper triangular form)
      for j := i + 1 to TSpace.N do
        if result[j, i] <> 0 then
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
    if result[i, i] <> 0 then
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

procedure TRMatrix.Swap(ARow1, ARow2: longint);
var
  i: longint;
  r: array[1..TSpace.N] of double;
begin
  for i := 1 to TSpace.N do r[i]           := Self[ARow1, i];
  for i := 1 to TSpace.N do Self[ARow1, i] := Self[ARow2, i];
  for i := 1 to TSpace.N do Self[ARow2, i] := r[i];
end;

function TRMatrix.Trace: double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + fm[i, i];
end;

function TRMatrix.Transpose: TRMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := fm[j, i];
    end;
end;

class operator TRMatrix.<>(const ALeft, ARight: TSelf): boolean;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      if ALeft[i, j] <> ARight[i, j] then Exit(True);
    end;

  result := False;
end;

class operator TRMatrix.=(const ALeft, ARight: TSelf): boolean;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      if ALeft[i, j] <> ARight[i, j] then Exit(False);
    end;

  result := True;
end;

class operator TRMatrix.+(const ALeft, ARight: TRMatrix): TRMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] + ARight[i, j];
    end;
end;

class operator TRMatrix.-(const ALeft, ARight: TRMatrix): TRMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] - ARight[i, j];
    end;
end;

class operator TRMatrix.*(const ALeft: double; const ARight: TRMatrix): TRMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft * ARight[i, j];
    end;
end;

class operator TRMatrix.*(const ALeft: TRMatrix; const ARight: double): TRMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] * ARight;
    end;
end;

class operator TRMatrix.*(const ALeft, ARight: TRMatrix): TRMatrix;
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

class operator TRMatrix./(const ALeft: TRMatrix; const ARight: double): TRMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := ALeft[i, j] / ARight;
    end;
end;

// TCMatrixQuantity

{$IFNDEF ADIMOFF}
class operator TCMatrixQuantity.:=(const AMatrix: TMatrix): TSelf;
var
  i, j: longint;
begin
  result.FID := ScalarID;
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
      result.FValue[i, j] := AMatrix[i, j];
end;

class operator TCMatrixQuantity.+(const ALeft, ARight: TSelf): TSelf;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCMatrixQuantity.-(const ALeft, ARight: TSelf): TSelf;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;
{$ENDIF}

// TRMatrixQuantity

{$IFNDEF ADIMOFF}
class operator TRMatrixQuantity.:=(const AMatrix: TMatrix): TSelf;
var
  i, j: longint;
begin
  result.FID := ScalarID;
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
      result.FValue[i, j] := AMatrix[i, j];
end;

class operator TRMatrixQuantity.+(const ALeft, ARight: TSelf): TSelf;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TRMatrixQuantity.-(const ALeft, ARight: TSelf): TSelf;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;
{$ENDIF}

// TC2MatrixHelper

function TC2MatrixHelper.Diagonalize(const AEigenValues: TC2ArrayOfComplex): TC2Matrix;
begin
  result[1,1] := AEigenValues[1];
  result[1,2] := 0;
  result[2,1] := 0;
  result[2,2] := AEigenValues[2];
end;

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

function TC2MatrixHelper.EigenValues: TC2ArrayOfComplex;
var
  detA, TrA, TrA2: TComplex;
begin
  detA := Determinant;
  TrA  := fm[1,1] + fm[2,2];
  TrA2 := ComplexSquarePower(TrA);

  result[1] := 0.5*(TrA+ComplexSquareRoot(TrA2-4*detA)[1]);
  result[2] := 0.5*(TrA+ComplexSquareRoot(TrA2-4*detA)[2]);
end;

function TC2MatrixHelper.Eigenvectors(const AEigenValues: TC2ArrayOfComplex): TC2ArrayOfVector;
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

function TC2MatrixHelper.TransposeDual: TC2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
    begin
      result[i, j] := fm[j, i].Dual;
    end;
end;

// TC3MatrixHelper

function TC3MatrixHelper.Diagonalize(const AEigenValues: TC3ArrayOfComplex): TC3Matrix;
begin
  result[1,1] := AEigenValues[1];
  result[1,2] := 0;
  result[1,3] := 0;

  result[2,1] := 0;
  result[2,2] := AEigenValues[2];
  result[2,3] := 0;

  result[3,1] := 0;
  result[3,2] := 0;
  result[3,3] := AEigenValues[3];
end;

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

function TC3MatrixHelper.Eigenvalues: TC3ArrayOfComplex;
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

function TC3MatrixHelper.Eigenvectors(const AEigenvalues: TC3ArrayOfComplex): TC3ArrayOfVector;
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

function TC3MatrixHelper.TransposeDual: TC3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
    begin
      result[i, j] := fm[j, i].Dual;
    end;
end;

// TC4MatrixHelper

function TC4MatrixHelper.Diagonalize(const AEigenValues: TC4ArrayOfComplex): TC4Matrix;
begin
  result[1,1] := AEigenValues[1];
  result[1,2] := 0;
  result[1,3] := 0;
  result[1,4] := 0;

  result[2,1] := 0;
  result[2,2] := AEigenValues[2];
  result[2,3] := 0;
  result[2,4] := 0;

  result[3,1] := 0;
  result[3,2] := 0;
  result[3,3] := AEigenValues[3];
  result[3,4] := 0;

  result[4,1] := 0;
  result[4,2] := 0;
  result[4,3] := 0;
  result[4,4] := AEigenValues[4];
end;

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

function TC4MatrixHelper.Eigenvalues: TC4ArrayOfComplex;
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

function TC4MatrixHelper.Eigenvectors(const AEigenvalues: TC4ArrayOfComplex): TC4ArrayOfVector;
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

function TC4MatrixHelper.TransposeDual: TC4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      result[i, j] := fm[j, i].Dual;
    end;
end;

// TC2VectorHelper

function TC2VectorHelper.Dot(const AVector: TC2Vector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to 2 do
    result := result + fm[i] * AVector[i];
end;

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

function TC3VectorHelper.Dot(const AVector: TC3Vector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to 2 do
    result := result + fm[i] * AVector[i];
end;

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

function TC4VectorHelper.Dot(const AVector: TC4Vector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to 2 do
    result := result + fm[i] * AVector[i];
end;

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

// TR3VectorHelper

function TR3VectorHelper.Dot(const AVector: TR3Vector): double;
begin
 result := fm[1]*AVector[1] + fm[2]*AVector[2] +fm[3]*AVector[3];
end;

function TR3VectorHelper.Projection(const AVector: TR3Vector): TR3Vector;
begin
  result := Dot(AVector) * AVector.Reciprocal;
end;

function TR3VectorHelper.Rejection(const AVector: TR3Vector): TR3Vector;
begin
  result := Self - Dot(AVector) * AVector.Reciprocal;
end;

function TR3VectorHelper.Reflection(const AVector: TR3Vector): TR3Vector;
begin
  result := Projection(AVector.Normalize) - Rejection(AVector.Normalize);
end;

function TR3VectorHelper.Cross(const AVector: TR3Vector): TR3Vector;
begin
  result[1] :=  fm[2]*AVector[3] - fm[3]*AVector[2];
  result[2] :=  fm[1]*AVector[3] - fm[3]*AVector[1];
  result[3] :=  fm[1]*AVector[2] - fm[2]*AVector[1];
end;

function TR3VectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not Math.SameValue(fm[1], 0) then result := result + Fmt(fm[1],  APrecision, ADigits) + 'e1 ';
  if not Math.SameValue(fm[2], 0) then result := result + Fmt(fm[2],  APrecision, ADigits) + 'e2 ';
  if not Math.SameValue(fm[3], 0) then result := result + Fmt(fm[3],  APrecision, ADigits) + 'e3 ';

    i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

function TR3VectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not Math.SameValue(fm[1], 0.0) then result := result + Fmt(fm[1]) + 'e1 ';
  if not Math.SameValue(fm[2], 0.0) then result := result + Fmt(fm[2]) + 'e2 ';
  if not Math.SameValue(fm[3], 0.0) then result := result + Fmt(fm[3]) + 'e3 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;


