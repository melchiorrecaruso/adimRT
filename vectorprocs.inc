{ Vector implementation }

// TRVector

procedure TRVector.Put(ARow: longint; AValue: double);
begin
  fm[ARow] := AValue;
end;

function TRVector.Get(ARow: longint): double;
begin
  result := fm[ARow];
end;

function TRVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
  begin
    if not SameValueEx(fm[i], 0) then Exit(False);
  end;
  result := True;
end;

function TRVector.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TRVector.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TRVector.Normalize: TRVector;
var
  i: longint;
  n: double;
begin
  n := Norm;
  for i := 1 to TSpace.N do
    result[i] := fm[i] / n;
end;

function TRVector.Reciprocal: TRVector;
var
  i: longint;
  sn: double;
begin
  sn := SquaredNorm;
  for i := 1 to Tspace.N do
    result[i] := fm[i] / sn;
end;

function TRVector.SquaredNorm: double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + sqr(fm[i]);
end;

class operator TRVector.<>(const ALeft, ARight: TRVector): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(True);
  result := False;
end;

class operator TRVector.=(const ALeft, ARight: TRVector): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(False);
  result := True;
end;

class operator TRVector.+(const ASelf: TRVector): TRVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ASelf[i];
end;

class operator TRVector.+(const ALeft, ARight: TRVector): TRVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] + ARight[i];
end;

class operator TRVector.-(const ASelf: TRVector): TRVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := -ASelf[i];
end;

class operator TRVector.-(const ALeft, ARight: TRVector): TRVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] - ARight[i];
end;

class operator TRVector.*(const ALeft: double; const ARight: TRVector): TRVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft * ARight[i];
end;

class operator TRVector.*(const ALeft: TRVector; const ARight: double): TRVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] * ARight;
end;

class operator  TRVector.*(const ALeft, ARight: TRVector): double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + ALeft[i] * ARight[i];
end;

class operator TRVector.*(const ALeft: TMatrix; const ARight: TRVector): TRVector;
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

class operator TRVector./(const ALeft: TRVector; const ARight: double): TRVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] / ARight;
end;

class operator TRVector./(const ALeft: double; const ARight: TRVector): TRVector;
var
  i: longint;
  AReciprocal: TRVector;
begin
  AReciprocal := ARight.Reciprocal;
  for i := 1 to TSpace.N do
    result[i] := ALeft * AReciprocal[i];
end;

// TCVector

procedure TCVector.Put(ARow: longint; AValue: TComplex);
begin
  fm[ARow] := AValue;
end;

function TCVector.Get(ARow: longint): TComplex;
begin
  result := fm[ARow];
end;

function TCVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
  begin
    if not SameValueEx(fm[i], 0) then Exit(False);
  end;
  result := True;
end;

function TCVector.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TCVector.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TCVector.Normalize: TCVector;
var
  i: longint;
  n: double;
begin
  n := Norm;
  for i := 1 to TSpace.N do
    result[i] := fm[i] / n;
end;

function TCVector.Reciprocal: TCVector;
var
  i: longint;
  sn: double;
begin
  sn := SquaredNorm;
  for i := 1 to Tspace.N do
    result[i] := fm[i] / sn;
end;

function TCVector.SquaredNorm: double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + fm[i].SquaredNorm;
end;

class operator TCVector.:=(const ASelf: TRVector): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ASelf[i];
end;

class operator TCVector.<>(const ALeft, ARight: TCVector): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(True);
  result := False;
end;

class operator TCVector.=(const ALeft, ARight: TCVector): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(False);
  result := True;
end;

class operator TCVector.+(const ASelf: TCVector): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ASelf[i];
end;

class operator TCVector.+(const ALeft, ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] + ARight[i];
end;

class operator TCVector.-(const ASelf: TCVector): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := -ASelf[i];
end;

class operator TCVector.-(const ALeft, ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] - ARight[i];
end;

class operator TCVector.*(const ALeft: double; const ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft * ARight[i];
end;

class operator TCVector.*(const ALeft: TCVector; const ARight: double): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] * ARight;
end;

class operator TCVector.*(const ALeft: TComplex; const ARight: TCVector): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft * ARight[i];
end;

class operator TCVector.*(const ALeft: TCVector; const ARight: TComplex): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] * ARight;
end;

class operator TCVector.*(const ALeft: TCMatrix; const ARight: TCVector): TCVector;
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

class operator TCVector./(const ALeft: TCVector; const ARight: double): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] / ARight;
end;

class operator TCVector./(const ALeft: double; const ARight: TCVector): TCVector;
var
  i: longint;
  AReciprocal: TCVector;
begin
  AReciprocal := ARight.Reciprocal;
  for i := 1 to TSpace.N do
    result[i] := ALeft * AReciprocal[i];
end;

class operator TCVector./(const ALeft: TCVector; const ARight: TComplex): TCVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] / ARight;
end;

class operator TCVector./(const ALeft: TComplex; const ARight: TCVector): TCVector;
var
  i: longint;
  AReciprocal: TCVector;
begin
  AReciprocal := ARight.Reciprocal;
  for i := 1 to TSpace.N do
    result[i] := ALeft * AReciprocal[i];
end;

// TCTransposedVector

procedure TCTransposedVector.Put(ACol: longint; AValue: TComplex);
begin
  fm[ACol] := AValue;
end;

function TCTransposedVector.Get(ACol: longint): TComplex;
begin
  result := fm[ACol];
end;

function TCTransposedVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    if not SameValueEx(fm[i], 0) then Exit(False);
  result := True;
end;

function TCTransposedVector.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TCTransposedVector.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TCTransposedVector.Normalize: TCTransposedVector;
var
  i: longint;
  n: double;
begin
  n := Norm;
  for i := 1 to TSpace.N do
    result[i] := fm[i] / n;
end;

function TCTransposedVector.Reciprocal: TCTransposedVector;
var
  i: longint;
  sn: double;
begin
  sn := SquaredNorm;
  for i := 1 to Tspace.N do
    result[i] := fm[i] / sn;
end;

function TCTransposedVector.SquaredNorm: double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + fm[i].SquaredNorm;
end;

class operator TCTransposedVector.<>(const ALeft, ARight: TCTransposedVector): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(True);
  result := False;
end;

class operator TCTransposedVector.=(const ALeft, ARight: TCTransposedVector): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(False);
  result := True;
end;

class operator TCTransposedVector.+(const ASelf: TCTransposedVector): TCTransposedVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ASelf[i];
end;

class operator TCTransposedVector.+(const ALeft, ARight: TCTransposedVector): TCTransposedVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] + ARight[i];
end;

class operator TCTransposedVector.-(const ASelf: TCTransposedVector): TCTransposedVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := -ASelf[i];
end;

class operator TCTransposedVector.-(const ALeft, ARight: TCTransposedVector): TCTransposedVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] - ARight[i];
end;

class operator TCTransposedVector.*(const ALeft: TComplex; const ARight: TCTransposedVector): TCTransposedVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft * ARight[i];
end;

class operator TCTransposedVector.*(const ALeft: TCTransposedVector; const ARight: TComplex): TCTransposedVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] * ARight;
end;

class operator TCTransposedVector.*(const ALeft: TCTransposedVector; const ARight: TCVector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + ALeft[i] * ARight[i];
end;

(*
class operator TCTransposedVector.*(const ALeft: TCVector; const ARight: TCTransposedVector): TCMatrix;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
    for j := 1 to TSpace.N do
      result[i, j] := ALeft[i] * ARight[j];
end;
*)

class operator TCTransposedVector.*(const ALeft: TCTransposedVector; const ARight: TCMatrix): TCTransposedVector;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
  begin
    result[i] := 0;
    for j := 1 to  TSpace.N do
      result[i] := result[i] + ALeft[j] * ARight[j, i];
  end;
end;

class operator TCTransposedVector./(const ALeft: TCTransposedVector; const ARight: TComplex): TCTransposedVector;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] / ARight;
end;

class operator TCTransposedVector./(const ALeft: TComplex; const ARight: TCTransposedVector): TCTransposedVector;
var
  i: longint;
  AReciprocal: TCTransposedVector;
begin
  AReciprocal := ARight.Reciprocal;
  for i := 1 to TSpace.N do
    result[i] := ALeft * AReciprocal[i];
end;

// TRVecQuantity

{$IFNDEF ADIMOFF}
procedure TRVecQuantity.Put(ARow: longint; const AQuantity: TQuantity);
begin
  Check(FID, AQuantity.FID);
  FValue[ARow] := AQuantity.FValue;
end;

function TRVecQuantity.Get(ARow: longint): TQuantity;
begin
  result.FID := FID;
  result.FValue := FValue[ARow];
end;

function TRVecQuantity.Normalize: TRVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue / FValue.Norm;
end;

class operator TRVecQuantity.<>(const ALeft, ARight: TRVecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID );
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TRVecQuantity.=(const ALeft, ARight: TRVecQuantity): boolean;
begin
  Check(ALeft.FID, ARight.FID );
  result := ALeft.FValue = ARight.FValue;
end;

class operator TRVecQuantity.+(const AValue: TRVecQuantity): TRVecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TRVecQuantity.+(const ALeft, ARight: TRVecQuantity): TRVecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TRVecQuantity.-(const AValue: TRVecQuantity): TRVecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := -AValue.FValue;
end;

class operator TRVecQuantity.-(const ALeft, ARight: TRVecQuantity): TRVecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TRVecQuantity.*(const ALeft: TRMatrixQuantity; const ARight: TRVecQuantity): TRVecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRVecQuantity.*(const ALeft, ARight: TRVecQuantity): TQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRVecQuantity.*(const ALeft: TQuantity; const ARight: TRVecQuantity): TRVecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRVecQuantity.*(const ALeft: TRVecQuantity; const ARight: TQuantity): TRVecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TRVecQuantity./(const ALeft: TQuantity; const ARight: TRVecQuantity): TRVecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TRVecQuantity./(const ALeft: TRVecQuantity; const ARight: TQuantity): TRVecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

// TCVecQuantity

{$IFNDEF ADIMOFF}
function TCVecQuantity.Get(ARow: longint): TComplexQuantity;
begin
  result.FID := FID;
  result.FValue := FValue[ARow];
end;

procedure TCVecQuantity.Put(ARow: longint; const AQuantity: TComplexQuantity);
begin
  Check(FID, AQuantity.FID);
  FValue[ARow] := AQuantity.FValue;
end;

function TCVecQuantity.Normalize: TCVecQuantity;
begin
  result.FID := FID;
  result.FValue := FValue / FValue.Norm;
end;

class operator TCVecQuantity.:=(const AValue: TCVector): TCVecQuantity;
begin
  result.FID := ScalarID;
  result.FValue := AValue;
end;

class operator TCVecQuantity.<>(const ALeft, ARight: TCVecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then Exit(True);
  if ALeft.FValue <> ARight.FValue then Exit(True);
  result := False;
end;

class operator TCVecQuantity.=(const ALeft, ARight: TCVecQuantity): boolean;
begin
  if ALeft.FID <> ARight.FID then Exit(False);
  if ALeft.FValue <> ARight.FValue then Exit(False);
  result := True;
end;

class operator TCVecQuantity.+(const AValue: TCVecQuantity): TCVecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TCVecQuantity.+(const ALeft, ARight: TCVecQuantity): TCVecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCVecQuantity.-(const AValue: TCVecQuantity): TCVecQuantity;
begin
  result.FID := AValue.FID;
  result.FValue := -AValue.FValue;
end;

class operator TCVecQuantity.-(const ALeft, ARight: TCVecQuantity): TCVecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TCMatrixQuantity; const ARight: TCVecQuantity): TCVecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TCTransposedVector; const ARight: TCVecQuantity): TComplexQuantity;
begin
  result.FID := CheckMul(ScalarID, ARight.FID);
  result.FValue := ALeft * ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TQuantity; const ARight: TCVecQuantity): TCVecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TCVecQuantity; const ARight: TQuantity): TCVecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCVecQuantity./(const ALeft: TQuantity; const ARight: TCVecQuantity): TCVecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TCVecQuantity./(const ALeft: TCVecQuantity; const ARight: TQuantity): TCVecQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue / ARight.FValue;
end;
{$ENDIF}

// TCTransposedVecQuantity

{$IFNDEF ADIMOFF}
class operator TCTransposedVecQuantity.<>(const ALeft, ARight: TCTransposedVecQuantity): boolean;
begin
  CheckEqual(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCTransposedVecQuantity.=(const ALeft, ARight: TCTransposedVecQuantity): boolean;
begin
  CheckEqual(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCTransposedVecQuantity.+(const ALeft, ARight: TCTransposedVecQuantity): TCTransposedVecQuantity;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCTransposedVecQuantity.-(const ALeft, ARight: TCTransposedVecQuantity): TCTransposedVecQuantity;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

(*
class operator TCTransposedVecQuantity.*(const ALeft: TCVecQuantity; const ARight: TCTransposedVecQuantity): TCMatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;
*)

class operator TCTransposedVecQuantity.*(const ALeft: TCTransposedVecQuantity; const ARight: TCMatrixQuantity): TCTransposedVecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCTransposedVecQuantity.*(const ALeft: TCTransposedVecQuantity; const ARight: TCVecQuantity): TComplexQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCTransposedVecQuantity./(const ALeft: TCTransposedVecQuantity; const ARight: TCVecQuantity): TComplexQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
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
      if SameValueEx(AEigenvalues[j], AEigenvalues[i]) then
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
      if SameValueEx(AEigenvalues[j], AEigenvalues[i]) then
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
      if SameValueEx(AEigenvalues[j], AEigenvalues[i]) then
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

function TC2TransposedVectorHelper.Dot(const AVector: TC2Vector): TComplex;
begin
  result := Self * AVector;
end;

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

function TC3TransposedVectorHelper.Dot(const AVector: TC3Vector): TComplex;
begin
  result := Self * AVector;
end;

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

function TC4TransposedVectorHelper.Dot(const AVector: TC4Vector): TComplex;
begin
  result := Self * AVector;
end;

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

function TR3VectorHelper.Dot(const AVector: TR3Vector): double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to 3 do
    result := result + fm[i] * AVector[i];
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
  if not SameValueEx(fm[1], 0) then result := result + Fmt(fm[1],  APrecision, ADigits) + 'e1 ';
  if not SameValueEx(fm[2], 0) then result := result + Fmt(fm[2],  APrecision, ADigits) + 'e2 ';
  if not SameValueEx(fm[3], 0) then result := result + Fmt(fm[3],  APrecision, ADigits) + 'e3 ';

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
  if not SameValueEx(fm[1], 0.0) then result := result + Fmt(fm[1]) + 'e1 ';
  if not SameValueEx(fm[2], 0.0) then result := result + Fmt(fm[2]) + 'e2 ';
  if not SameValueEx(fm[3], 0.0) then result := result + Fmt(fm[3]) + 'e3 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

