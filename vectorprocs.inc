{ Vector implementation }

// TCVector

function TCVector.Get(ARow: longint): TComplex;
begin
  result := fm[ARow];
end;

procedure TCVector.Put(ARow: longint; AValue: TComplex);
begin
  fm[ARow] := AValue;
end;

function TCVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
  begin
    if not SameValue(fm[i], 0) then Exit(False);
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

function TCVector.Normalize: TSelf;
var
  i: longint;
  n: double;
begin
  n := Norm;
  for i := 1 to TSpace.N do
    result[i] := fm[i] / n;
end;

function TCVector.Reciprocal: TSelf;
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

class operator TCVector.<>(const ALeft, ARight: TSelf): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(True);
  result := False;
end;

class operator TCVector.=(const ALeft, ARight: TSelf): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(False);
  result := True;
end;

class operator TCVector.+(const ASelf: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ASelf[i];
end;

class operator TCVector.+(const ALeft, ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] + ARight[i];
end;

class operator TCVector.-(const ASelf: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := -ASelf[i];
end;

class operator TCVector.-(const ALeft, ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] - ARight[i];
end;

class operator TCVector.*(const ALeft: double; const ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft * ARight[i];
end;

class operator TCVector.*(const ALeft: TSelf; const ARight: double): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] * ARight;
end;

class operator TCVector.*(const ALeft: TComplex; const ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft * ARight[i];
end;

class operator TCVector.*(const ALeft: TSelf; const ARight: TComplex): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] * ARight;
end;

class operator TCVector.*(const ALeft: TMatrix; const ARight: TSelf): TSelf;
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

class operator TCVector./(const ALeft: TSelf; const ARight: double): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] / ARight;
end;

class operator TCVector./(const ALeft: double; const ARight: TSelf): TSelf;
var
  i: longint;
  AReciprocal: TSelf;
begin
  AReciprocal := ARight.Reciprocal;
  for i := 1 to TSpace.N do
    result[i] := ALeft * AReciprocal[i];
end;

class operator TCVector./(const ALeft: TSelf; const ARight: TComplex): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] / ARight;
end;

class operator TCVector./(const ALeft: TComplex; const ARight: TSelf): TSelf;
var
  i: longint;
  AReciprocal: TSelf;
begin
  AReciprocal := ARight.Reciprocal;
  for i := 1 to TSpace.N do
    result[i] := ALeft * AReciprocal[i];
end;

// TRVector

function TRVector.Get(ARow: longint): double;
begin
  result := fm[ARow];
end;

procedure TRVector.Put(ARow: longint; AValue: double);
begin
  fm[ARow] := AValue;
end;

function TRVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
  begin
    if not SameValue(fm[i], 0) then Exit(False);
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

function TRVector.Normalize: TSelf;
var
  i: longint;
  n: double;
begin
  n := Norm;
  for i := 1 to TSpace.N do
    result[i] := fm[i] / n;
end;

function TRVector.Reciprocal: TSelf;
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

class operator TRVector.<>(const ALeft, ARight: TSelf): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(True);
  result := False;
end;

class operator TRVector.=(const ALeft, ARight: TSelf): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(False);
  result := True;
end;

class operator TRVector.+(const ASelf: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ASelf[i];
end;

class operator TRVector.+(const ALeft, ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] + ARight[i];
end;

class operator TRVector.-(const ASelf: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := -ASelf[i];
end;

class operator TRVector.-(const ALeft, ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] - ARight[i];
end;

class operator TRVector.*(const ALeft: double; const ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft * ARight[i];
end;

class operator TRVector.*(const ALeft: TSelf; const ARight: double): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] * ARight;
end;

class operator TRVector.*(const ALeft: TMatrix; const ARight: TSelf): TSelf;
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

class operator TRVector./(const ALeft: TSelf; const ARight: double): TSelf;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    result[i] := ALeft[i] / ARight;
end;

class operator TRVector./(const ALeft: double; const ARight: TSelf): TSelf;
var
  i: longint;
  AReciprocal: TSelf;
begin
  AReciprocal := ARight.Reciprocal;
  for i := 1 to TSpace.N do
    result[i] := ALeft * AReciprocal[i];
end;

// TCTransposedVector

function TCTransposedVector.Get(ACol: longint): TComplex;
begin
  result := fm[ACol];
end;

procedure TCTransposedVector.Put(ACol: longint; AValue: TComplex);
begin
  fm[ACol] := AValue;
end;

function TCTransposedVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    if not SameValue(fm[i], 0) then Exit(False);
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

function TCTransposedVector.Normalize: TSelf;
var
  i: longint;
  n: double;
begin
  n := Norm;
  for i := 1 to TSpace.N do
    result[i] := fm[i] / n;
end;

function TCTransposedVector.Reciprocal: TSelf;
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

class operator TCTransposedVector.<>(const ALeft, ARight: TSelf): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(True);

  result := False;
end;

class operator TCTransposedVector.=(const ALeft, ARight: TSelf): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(False);
  result := True;
end;

class operator TCTransposedVector.+(const ALeft, ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft[i] + ARight[i];
end;

class operator TCTransposedVector.-(const ALeft, ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft[i] - ARight[i];
end;

class operator TCTransposedVector.*(const ALeft: TComplex; const ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft * ARight[i];
end;

class operator TCTransposedVector.*(const ALeft: TSelf; const ARight: TComplex): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft[i] * ARight;
end;

class operator TCTransposedVector.*(const ALeft: TSelf; const ARight: TVector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to  TSpace.N do
    result := result + ALeft[i] * ARight[i];
end;

class operator TCTransposedVector.*(const ALeft: TVector; const ARight: TSelf): TMatrix;
var
  i, j: longint;
begin
  for i := 1 to  TSpace.N do
    for j := 1 to  TSpace.N do
      result[i, j] := ALeft[i] * ARight[j];
end;

class operator TCTransposedVector.*(const ALeft: TSelf; const ARight: TMatrix): TSelf;
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

class operator TCTransposedVector./(const ALeft: TSelf; const ARight: TComplex): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft[i] / ARight;
end;

class operator TCTransposedVector./(const ALeft: TComplex; const ARight: TSelf): TSelf;
var
  i: longint;
  AReciprocal: TSelf;
begin
  AReciprocal := ARight.Reciprocal;
  for i := 1 to TSpace.N do
    result[i] := ALeft * AReciprocal[i];
end;

// TRTransposedVector

function TRTransposedVector.Get(ACol: longint): double;
begin
  result := fm[ACol];
end;

procedure TRTransposedVector.Put(ACol: longint; AValue: double);
begin
  fm[ACol] := AValue;
end;

function TRTransposedVector.IsNull: boolean;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    if not SameValue(fm[i], 0) then Exit(False);
  result := True;
end;

function TRTransposedVector.IsNotNull: boolean;
begin
  result := not IsNull;
end;

function TRTransposedVector.Norm: double;
begin
  result := sqrt(SquaredNorm);
end;

function TRTransposedVector.Normalize: TSelf;
var
  i: longint;
  n: double;
begin
  n := Norm;
  for i := 1 to TSpace.N do
    result[i] := fm[i] / n;
end;

function TRTransposedVector.Reciprocal: TSelf;
var
  i: longint;
  sn: double;
begin
  sn := SquaredNorm;
  for i := 1 to Tspace.N do
    result[i] := fm[i] / sn;
end;

function TRTransposedVector.SquaredNorm: double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + sqr(fm[i]);
end;

class operator TRTransposedVector.<>(const ALeft, ARight: TSelf): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(True);

  result := False;
end;

class operator TRTransposedVector.=(const ALeft, ARight: TSelf): boolean;
var
  i: longint;
begin
  for i := 1 to TSpace.N do
    if ALeft[i] <> ARight[i] then Exit(False);
  result := True;
end;

class operator TRTransposedVector.+(const ALeft, ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft[i] + ARight[i];
end;

class operator TRTransposedVector.-(const ALeft, ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft[i] - ARight[i];
end;

class operator TRTransposedVector.*(const ALeft: double; const ARight: TSelf): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft * ARight[i];
end;

class operator TRTransposedVector.*(const ALeft: TSelf; const ARight: double): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft[i] * ARight;
end;

class operator TRTransposedVector.*(const ALeft: TSelf; const ARight: TVector): double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to  TSpace.N do
    result := result + ALeft[i] * ARight[i];
end;

class operator TRTransposedVector.*(const ALeft: TVector; const ARight: TSelf): TMatrix;
var
  i, j: longint;
begin
  for i := 1 to  TSpace.N do
    for j := 1 to  TSpace.N do
      result[i, j] := ALeft[i] * ARight[j];
end;

class operator TRTransposedVector.*(const ALeft: TSelf; const ARight: TMatrix): TSelf;
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

class operator TRTransposedVector./(const ALeft: TSelf; const ARight: double): TSelf;
var
  i: longint;
begin
  for i := 1 to  TSpace.N do
    result[i] := ALeft[i] / ARight;
end;

class operator TRTransposedVector./(const ALeft: double; const ARight: TSelf): TSelf;
var
  i: longint;
  AReciprocal: TSelf;
begin
  AReciprocal := ARight.Reciprocal;
  for i := 1 to TSpace.N do
    result[i] := ALeft * AReciprocal[i];
end;

{$IFNDEF ADIMOFF}
function TCVecQuantity.Normalize: TSelf;
begin
  result.FID := FID;
  result.FValue := FValue / FValue.Norm;
end;

class operator TCVecQuantity.:=(const AValue: TVector): TSelf;
begin
  result.FID := ScalarID;
  result.FValue := AValue;
end;

class operator TCVecQuantity.<>(const ALeft, ARight: TSelf): boolean;
begin
  if ALeft.FID <> ARight.FID then Exit(True);
  if ALeft.FValue <> ARight.FValue then Exit(True);
  result := False;
end;

class operator TCVecQuantity.=(const ALeft, ARight: TSelf): boolean;
begin
  if ALeft.FID <> ARight.FID then Exit(False);
  if ALeft.FValue <> ARight.FValue then Exit(False);
  result := True;
end;

class operator TCVecQuantity.+(const AValue: TSelf): TSelf;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TCVecQuantity.+(const ALeft, ARight: TSelf): TSelf;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCVecQuantity.-(const AValue: TCVecQuantity): TSelf;
begin
  result.FID := AValue.FID;
  result.FValue := -AValue.FValue;
end;

class operator TCVecQuantity.-(const ALeft, ARight: TCVecQuantity): TSelf;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TMatrixQuantity; const ARight: TSelf): TSelf;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCVecQuantity./(const ALeft: TMatrixQuantity; const ARight: TSelf): TSelf;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

{$IFNDEF ADIMOFF}
function TRVecQuantity.Normalize: TSelf;
begin
  result.FID := FID;
  result.FValue := FValue / FValue.Norm;
end;

class operator TRVecQuantity.<>(const ALeft, ARight: TSelf): boolean;
begin
  if ALeft.FID <> ARight.FID then Exit(True);
  if ALeft.FValue <> ARight.FValue then Exit(True);
  result := False;
end;

class operator TRVecQuantity.=(const ALeft, ARight: TSelf): boolean;
begin
  if ALeft.FID <> ARight.FID then Exit(False);
  if ALeft.FValue <> ARight.FValue then Exit(False);
  result := True;
end;

class operator TRVecQuantity.+(const AValue: TSelf): TSelf;
begin
  result.FID := AValue.FID;
  result.FValue := AValue.FValue;
end;

class operator TRVecQuantity.+(const ALeft, ARight: TSelf): TSelf;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TRVecQuantity.-(const AValue: TRVecQuantity): TSelf;
begin
  result.FID := AValue.FID;
  result.FValue := -AValue.FValue;
end;

class operator TRVecQuantity.-(const ALeft, ARight: TRVecQuantity): TSelf;
begin
  result.FID := CheckSub(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;
{$ENDIF}

{$IFNDEF ADIMOFF}
class operator TCTransposedVecQuantity.<>(const ALeft, ARight: TSelf): boolean;
begin
  CheckEqual(ALeft.FID, ARight.FID);
  result := ALeft.FValue <> ARight.FValue;
end;

class operator TCTransposedVecQuantity.=(const ALeft, ARight: TSelf): boolean;
begin
  CheckEqual(ALeft.FID, ARight.FID);
  result := ALeft.FValue = ARight.FValue;
end;

class operator TCTransposedVecQuantity.+(const ALeft, ARight: TSelf): TSelf;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TCTransposedVecQuantity.-(const ALeft, ARight: TSelf): TSelf;
begin
  result.FID := CheckSum(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TCTransposedVecQuantity.*(const ALeft: TVecQuantity; const ARight: TSelf): TMatrixQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCTransposedVecQuantity.*(const ALeft: TSelf; const ARight: TMatrixQuantity): TSelf;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCTransposedVecQuantity.*(const ALeft: TSelf; const ARight: TVecQuantity): TComplexQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCTransposedVecQuantity./(const ALeft: TSelf; const ARight: TVecQuantity): TComplexQuantity;
begin
  result.FID := CheckDiv(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue.Reciprocal;
end;
{$ENDIF}

