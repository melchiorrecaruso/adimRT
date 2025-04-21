{ Matrix implementation }

// TRMatrix

procedure TRMatrix.Put(ARow, ACol: longint; AValue: double);
begin
  fm[ARow, ACol] := AValue;
end;

function TRMatrix.Get(ARow, ACol: longint): double;
begin
  result := fm[ARow, ACol];
end;

function TRMatrix.IsNull: boolean;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      if not SameValueEx(fm[i, j], 0) then Exit(False);
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

    if not SameValueEx(result[i, i], 0) then
    begin
      // Normalize the pivot row (Make the pivot element 1)
      for j := i + 1 to TSpace.N do
        result[i, j] := result[i, j] / result[i, i];
      result[i, i] := 1;
      // Eliminate elements below the pivot (Create upper triangular form)
      for j := i + 1 to TSpace.N do
        if not SameValueEx(result[j, i], 0) then
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
    if not SameValueEx(result[i, i], 0) then
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

class operator TRMatrix.<>(const ALeft, ARight: TRMatrix): boolean;
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

class operator TRMatrix.=(const ALeft, ARight: TRMatrix): boolean;
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

// TCMatrix

procedure TCMatrix.Put(ARow, ACol: longint; AValue: TComplex);
begin
  fm[ARow, ACol] := AValue;
end;

function TCMatrix.Get(ARow, ACol: longint): TComplex;
begin
  result := fm[ARow, ACol];
end;

function TCMatrix.IsNull: boolean;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      if not SameValueEx(fm[i, j], 0) then Exit(False);
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

    if result[i, i].IsNotNull then
    begin
      // Normalize the pivot row (Make the pivot element 1)
      for j := i + 1 to TSpace.N do
        result[i, j] := result[i, j] / result[i, i];
      result[i, i] := 1;
      // Eliminate elements below the pivot (Create upper triangular form)
      for j := i + 1 to TSpace.N do
        if result[j, i].IsNotNull then
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

class operator TCMatrix.:=(const AMatrix: TRMatrix): TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
    begin
      result[i, j] := AMatrix[j, i];
    end;
end;

class operator TCMatrix.<>(const ALeft, ARight: TCMatrix): boolean;
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

class operator TCMatrix.=(const ALeft, ARight: TCMatrix): boolean;
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

// TRMatrixQuantity

{$IFNDEF ADIMOFF}
procedure TRMatrixQuantity.Put(ARow, ACol: longint; AQuantity: TQuantity);
begin
  Check(FID, AQuantity.FID);
  FValue[ARow, ACol] := AQuantity.FValue;
end;

function TRMatrixQuantity.Get(ARow, ACol: longint): TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue[ARow, ACol];
end;

class operator TRMatrixQuantity.:=(const AMatrix: TRMatrix): TRMatrixQuantity;
var
  i, j: longint;
begin
  result.FID := ScalarID;
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
      result.FValue[i, j] := AMatrix[i, j];
end;

class operator TRMatrixQuantity.<>(const ALeft, ARight: TRMatrixQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TRMatrixQuantity.=(const ALeft, ARight: TRMatrixQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TRMatrixQuantity.+(const ALeft, ARight: TRMatrixQuantity): TRMatrixQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TRMatrixQuantity.-(const ALeft, ARight: TRMatrixQuantity): TRMatrixQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TRMatrixQuantity.*(const ALeft, ARight: TRMatrixQuantity): TRMatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRMatrixQuantity.*(const ALeft: TQuantity; const ARight: TRMatrixQuantity): TRMatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRMatrixQuantity.*(const ALeft: TRMatrixQuantity; const ARight: TQuantity): TRMatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRMatrixQuantity./(const ALeft: TRMatrixQuantity; const ARight: TQuantity): TRMatrixQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

// TCMatrixQuantity

{$IFNDEF ADIMOFF}
procedure TCMatrixQuantity.Put(ARow, ACol: longint; AQuantity: TComplexQuantity);
begin
  Check(FID, AQuantity.FID);
  FValue[ARow, ACol] := AQuantity.FValue;
end;

function TCMatrixQuantity.Get(ARow, ACol: longint): TComplexQuantity;
begin
  result.FID := FID;
  result.FValue := FValue[ARow, ACol];
end;

class operator TCMatrixQuantity.:=(const AMatrix: TCMatrix): TCMatrixQuantity;
var
  i, j: longint;
begin
  result.FID := ScalarID;
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
      result.FValue[i, j] := AMatrix[i, j];
end;

class operator TCMatrixQuantity.<>(const ALeft, ARight: TCMatrixQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCMatrixQuantity.=(const ALeft, ARight: TCMatrixQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCMatrixQuantity.+(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCMatrixQuantity.-(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCMatrixQuantity.*(const ALeft, ARight: TCMatrixQuantity): TCMatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCMatrixQuantity.*(const ALeft: TComplexQuantity; const ARight: TCMatrixQuantity): TCMatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCMatrixQuantity.*(const ALeft: TCMatrixQuantity; const ARight: TComplexQuantity): TCMatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCMatrixQuantity./(const ALeft: TCMatrixQuantity; const ARight: TComplexQuantity): TCMatrixQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

{$IFNDEF ADIMOFF}
operator * (const ALeft: TQuantity; const ARight: TR2Matrix): TR2MatrixQuantity;
begin
  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue * ARight;
end;

operator * (const ALeft: TR2Matrix; const ARight: TQuantity): TR2MatrixQuantity;
begin
  result.FID := ARight.FID;
  result.FValue := ALeft * ARight.FValue;
end;

operator * (const ALeft: TQuantity; const ARight: TR3Matrix): TR3MatrixQuantity;
begin
  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue * ARight;
end;

operator * (const ALeft: TR3Matrix; const ARight: TQuantity): TR3MatrixQuantity;
begin
  result.FID := ARight.FID;
  result.FValue := ALeft * ARight.FValue;
end;

operator * (const ALeft: TQuantity; const ARight: TR4Matrix): TR4MatrixQuantity;
begin
  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue * ARight;
end;

operator * (const ALeft: TR4Matrix; const ARight: TQuantity): TR4MatrixQuantity;
begin
  result.FID := ARight.FID;
  result.FValue := ALeft * ARight.FValue;
end;

operator * (const ALeft: TQuantity; const ARight: TC2Matrix): TC2MatrixQuantity;
begin
  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue * ARight;
end;

operator * (const ALeft: TC2Matrix; const ARight: TQuantity): TC2MatrixQuantity;
begin
  result.FID := ARight.FID;
  result.FValue := ALeft * ARight.FValue;
end;

operator * (const ALeft: TQuantity; const ARight: TC3Matrix): TC3MatrixQuantity;
begin
  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue * ARight;
end;

operator * (const ALeft: TC3Matrix; const ARight: TQuantity): TC3MatrixQuantity;
begin
  result.FID := ARight.FID;
  result.FValue := ALeft * ARight.FValue;
end;

operator * (const ALeft: TQuantity; const ARight: TC4Matrix): TC4MatrixQuantity;
begin
  result.FID := ALeft.FID;
  result.FValue := ALeft.FValue * ARight;
end;

operator * (const ALeft: TC4Matrix; const ARight: TQuantity): TC4MatrixQuantity;
begin
  result.FID := ARight.FID;
  result.FValue := ALeft * ARight.FValue;
end;
{$ENDIF}

