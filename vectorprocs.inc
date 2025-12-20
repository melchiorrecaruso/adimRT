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

class operator TRVector.*(const ALeft, ARight: TRVector): double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + ALeft[i] * ARight[i];
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

class operator TRVector.*(const ALeft: TRVector; const ARight: TRMatrix): TRVector;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
  begin
    result[i] := 0;
    for j := 1 to TSpace.N do
    begin
      result[i] := result[i] + ALeft[j] * ARight[j, i];
    end;
  end;
end;

class operator TRVector.*(const ALeft: TRMatrix; const ARight: TRVector): TRVector;
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

class operator TCVector.*(const ALeft, ARight: TCVector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to TSpace.N do
    result := result + ALeft[i] * ARight[i];
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

class operator TCVector.*(const ALeft: TCVector; const ARight: TCMatrix): TCVector;
var
  i, j: longint;
begin
  for i := 1 to TSpace.N do
  begin
    result[i] := 0;
    for j := 1 to TSpace.N do
    begin
      result[i] := result[i] + ALeft[j] * ARight[j, i];
    end;
  end;
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
  result.FID := ScalarUnit.FID;
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

class operator TCVecQuantity.*(const ALeft, ARight: TCVecQuantity): TComplexQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TCVecQuantity; const ARight: TCMatrixQuantity): TCVecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TCMatrixQuantity; const ARight: TCVecQuantity): TCVecQuantity;
begin
  result.FID := CheckMul(ALeft.FID, ARight.FID);
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TCVecQuantity.*(const ALeft: TCVector; const ARight: TCVecQuantity): TComplexQuantity;
begin
  result.FID := CheckMul(ScalarUnit.FID, ARight.FID);
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

// TR2MatrixHelper

function TR2MatrixHelper.Determinant: double;
begin
  result := fm[1,1]*fm[2,2] - fm[1,2]*fm[2,1];
end;

function TR2MatrixHelper.Reciprocal(const ADeterminant: double): TR2Matrix;
begin
  result[1,1] :=  fm[2,2]/ADeterminant;
  result[1,2] := -fm[1,2]/ADeterminant;
  result[2,1] := -fm[2,1]/ADeterminant;
  result[2,2] :=  fm[1,1]/ADeterminant;
end;

function TR2MatrixHelper.Transpose: TR2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
    begin
      result[i,j] := fm[j,i];
    end;
end;

function TR2MatrixHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm[1,1].ToString, fm[1,2].ToString,
    fm[2,1].ToString, fm[2,2].ToString]);
end;

function TR2MatrixHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s)', [
    fm[1,1].ToString(ffGeneral, APrecision, ADigits),
    fm[1,2].ToString(ffGeneral, APrecision, ADigits),

    fm[2,1].ToString(ffGeneral, APrecision, ADigits),
    fm[2,2].ToString(ffGeneral, APrecision, ADigits)]);
end;

// TR3MatrixHelper

function TR3MatrixHelper.Determinant: double;
begin
  result :=  fm[1,1]*(fm[2,2]*fm[3,3]-fm[2,3]*fm[3,2])
            +fm[1,2]*(fm[2,3]*fm[3,1]-fm[2,1]*fm[3,3])
            +fm[1,3]*(fm[2,1]*fm[3,2]-fm[2,2]*fm[3,1]);
end;

function TR3MatrixHelper.Reciprocal(const ADeterminant: double): TR3Matrix;
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

function TR3MatrixHelper.Transpose: TR3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
    begin
      result[i,j] := fm[j,i];
    end;
end;

function TR3MatrixHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString, fm[1,2].ToString, fm[1,3].ToString,
    fm[2,1].ToString, fm[2,2].ToString, fm[2,3].ToString,
    fm[3,1].ToString, fm[3,2].ToString, fm[3,3].ToString]);
end;

function TR3MatrixHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString(ffGeneral, APrecision, ADigits),
    fm[1,2].ToString(ffGeneral, APrecision, ADigits),
    fm[1,3].ToString(ffGeneral, APrecision, ADigits),

    fm[2,1].ToString(ffGeneral, APrecision, ADigits),
    fm[2,2].ToString(ffGeneral, APrecision, ADigits),
    fm[2,3].ToString(ffGeneral, APrecision, ADigits),

    fm[3,1].ToString(ffGeneral, APrecision, ADigits),
    fm[3,2].ToString(ffGeneral, APrecision, ADigits),
    fm[3,3].ToString(ffGeneral, APrecision, ADigits)]);
end;

// TR4MatrixHelper

function TR4MatrixHelper.Determinant: double;
begin
  result := (fm[1,1]*fm[2,2]-fm[1,2]*fm[2,1])*(fm[3,3]*fm[4,4]-fm[3,4]*fm[4,3]) -
            (fm[1,1]*fm[2,3]-fm[1,3]*fm[2,1])*(fm[3,2]*fm[4,4]-fm[3,4]*fm[4,2]) +
            (fm[1,1]*fm[2,4]-fm[1,4]*fm[2,1])*(fm[3,2]*fm[4,3]-fm[3,3]*fm[4,2]) +
            (fm[1,2]*fm[2,3]-fm[1,3]*fm[2,2])*(fm[3,1]*fm[4,4]-fm[3,4]*fm[4,1]) -
            (fm[1,2]*fm[2,4]-fm[1,4]*fm[2,2])*(fm[3,1]*fm[4,3]-fm[3,3]*fm[4,1]) +
            (fm[1,3]*fm[2,4]-fm[1,4]*fm[2,3])*(fm[3,1]*fm[4,2]-fm[3,2]*fm[4,1]) ;
end;

function TR4MatrixHelper.Reciprocal(const ADeterminant: double): TR4Matrix;
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

function TR4MatrixHelper.Transpose: TR4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      result[i,j] := fm[j,i];
    end;
end;

function TR4MatrixHelper.ToString: string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString, fm[1,2].ToString, fm[1,3].ToString, fm[1,4].ToString,
    fm[2,1].ToString, fm[2,2].ToString, fm[2,3].ToString, fm[2,4].ToString,
    fm[3,1].ToString, fm[3,2].ToString, fm[3,3].ToString, fm[3,4].ToString,
    fm[4,1].ToString, fm[4,2].ToString, fm[4,3].ToString, fm[4,4].ToString]);
end;

function TR4MatrixHelper.ToString(APrecision, ADigits: integer): string;
begin
  result := Format('(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)', [
    fm[1,1].ToString(ffGeneral, APrecision, ADigits),
    fm[1,2].ToString(ffGeneral, APrecision, ADigits),
    fm[1,3].ToString(ffGeneral, APrecision, ADigits),
    fm[1,4].ToString(ffGeneral, APrecision, ADigits),

    fm[2,1].ToString(ffGeneral, APrecision, ADigits),
    fm[2,2].ToString(ffGeneral, APrecision, ADigits),
    fm[2,3].ToString(ffGeneral, APrecision, ADigits),
    fm[2,4].ToString(ffGeneral, APrecision, ADigits),

    fm[3,1].ToString(ffGeneral, APrecision, ADigits),
    fm[3,2].ToString(ffGeneral, APrecision, ADigits),
    fm[3,3].ToString(ffGeneral, APrecision, ADigits),
    fm[3,4].ToString(ffGeneral, APrecision, ADigits),

    fm[4,1].ToString(ffGeneral, APrecision, ADigits),
    fm[4,2].ToString(ffGeneral, APrecision, ADigits),
    fm[4,3].ToString(ffGeneral, APrecision, ADigits),
    fm[4,4].ToString(ffGeneral, APrecision, ADigits)]);
end;

// TC2MatrixHelper

function TC2MatrixHelper.Diagonalize(const AEigenValues: TC2ArrayOfComplex): TC2Matrix;
begin
  result[1,1] := AEigenValues[1];
  result[1,2] := 0;
  result[2,1] := 0;
  result[2,2] := AEigenValues[2];
end;

function TC2MatrixHelper.Conjugate: TC2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
    begin
      result[i,j] := fm[i,j].Conjugate;
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

function TC2MatrixHelper.Transpose: TC2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
    begin
      result[i,j] := fm[j,i];
    end;
end;

function TC2MatrixHelper.TransposeConjugate: TC2Matrix;
var
  i, j: longint;
begin
  for i := 1 to 2 do
    for j := 1 to 2 do
    begin
      result[i,j] := fm[j,i].Conjugate;
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

function TC3MatrixHelper.Conjugate: TC3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
    begin
      result[i,j] := fm[i,j].Conjugate;
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

function TC3MatrixHelper.Transpose: TC3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
    begin
      result[i,j] := fm[j,i];
    end;
end;

function TC3MatrixHelper.TransposeConjugate: TC3Matrix;
var
  i, j: longint;
begin
  for i := 1 to 3 do
    for j := 1 to 3 do
    begin
      result[i,j] := fm[j,i].Conjugate;
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

function TC4MatrixHelper.Conjugate: TC4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      result[i,j] := fm[i,j].Conjugate;
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

function TC4MatrixHelper.Transpose: TC4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      result[i,j] := fm[j,i];
    end;
end;

function TC4MatrixHelper.TransposeConjugate: TC4Matrix;
var
  i, j: longint;
begin
  for i := 1 to 4 do
    for j := 1 to 4 do
    begin
      result[i,j] := fm[j,i].Conjugate;
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

function TC2VectorHelper.Conjugate: TC2Vector;
var
  i: longint;
begin
  for i := 1 to 2 do
    result[i] := fm[i].Conjugate;
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

function TC3VectorHelper.Conjugate: TC3Vector;
var
  i: longint;
begin
  for i := 1 to 3 do
    result[i] := fm[i].Conjugate;
end;

function TC3VectorHelper.Dot(const AVector: TC3Vector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to 3 do
    result := result + fm[i] * AVector[i];
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

function TC4VectorHelper.Conjugate: TC4Vector;
var
  i: longint;
begin
  for i := 1 to 4 do
    result[i] := fm[i].Conjugate;
end;

function TC4VectorHelper.Dot(const AVector: TC4Vector): TComplex;
var
  i: longint;
begin
  result := 0;
  for i := 1 to 4 do
    result := result + fm[i] * AVector[i];
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

// TR2VectorHelper

function TR2VectorHelper.Dot(const AVector: TR2Vector): double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to 2 do
    result := result + fm[i] * AVector[i];
end;

function TR2VectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm[1], 0.0) then result := result + Fmt(fm[1]) + 'e1 ';
  if not SameValueEx(fm[2], 0.0) then result := result + Fmt(fm[2]) + 'e2 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

function TR2VectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm[1], 0) then result := result + Fmt(fm[1],  APrecision, ADigits) + 'e1 ';
  if not SameValueEx(fm[2], 0) then result := result + Fmt(fm[2],  APrecision, ADigits) + 'e2 ';

    i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

// TR3VectorHelper

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

// TR4VectorHelper

function TR4VectorHelper.Dot(const AVector: TR4Vector): double;
var
  i: longint;
begin
  result := 0;
  for i := 1 to 4 do
    result := result + fm[i] * AVector[i];
end;

function TR4VectorHelper.ToString: string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm[1], 0.0) then result := result + Fmt(fm[1]) + 'e1 ';
  if not SameValueEx(fm[2], 0.0) then result := result + Fmt(fm[2]) + 'e2 ';
  if not SameValueEx(fm[3], 0.0) then result := result + Fmt(fm[3]) + 'e3 ';
  if not SameValueEx(fm[4], 0.0) then result := result + Fmt(fm[4]) + 'e4 ';

  i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

function TR4VectorHelper.ToString(APrecision, ADigits: longint): string;
var
  i: longint;
begin
  result := '';
  if not SameValueEx(fm[1], 0) then result := result + Fmt(fm[1],  APrecision, ADigits) + 'e1 ';
  if not SameValueEx(fm[2], 0) then result := result + Fmt(fm[2],  APrecision, ADigits) + 'e2 ';
  if not SameValueEx(fm[3], 0) then result := result + Fmt(fm[3],  APrecision, ADigits) + 'e3 ';
  if not SameValueEx(fm[4], 0) then result := result + Fmt(fm[4],  APrecision, ADigits) + 'e4 ';

    i := Length(result);
  if i > 0 then
    SetLength(result, i - 1)
  else
    result := '0e1';

  result := '(' + result + ')';
end;

