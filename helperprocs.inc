
// TComplexQuantityHelper

{$IFNDEF ADIMOFF}
function TComplexQuantityHelper.Conjugate: TComplexQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TComplexQuantityHelper.Reciprocal: TComplexQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Reciprocal;
end;

function TComplexQuantityHelper.Norm: TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TComplexQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;
{$ENDIF}

// TC2MatrixQuantityHelper

{$IFNDEF ADIMOFF}
function TC2MatrixQuantityHelper.Diagonalize(const AEigenvalues: TC2ArrayOfQuantity): TC2MatrixQuantity;
var
  EigenVals: TC2ArrayOfComplex;
begin
  EigenVals[1] := AEigenvalues[1].FValue;
  EigenVals[2] := AEigenvalues[2].FValue;

  result.FDim := FDim;
  result.FValue := FValue.Diagonalize(EigenVals);
end;

function TC2MatrixQuantityHelper.Conjugate: TC2MatrixQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TC2MatrixQuantityHelper.Determinant: TComplexQuantity;
begin
  result.FDim := FDim*2;
  result.FValue := FValue.Determinant;
end;

function TC2MatrixQuantityHelper.Eigenvalues: TC2ArrayOfQuantity;
var
  i: longint;
  EigenVals: TC2ArrayOfComplex;
begin
  EigenVals := FValue.Eigenvalues;
  for i := 1 to 2 do
  begin
    result[i].FDim := FDim;
    result[i].FValue := EigenVals[i];
  end;
end;

function TC2MatrixQuantityHelper.Eigenvectors(const AEigenValues: TC2ArrayOfQuantity): TC2ArrayOfVector;
var
  i: longint;
  EigenVals: TC2ArrayOfComplex;
  EigenVecs: TC2ArrayOfVector;
begin
  EigenVals[1] := AEigenValues[1].FValue;
  EigenVals[2] := AEigenValues[2].FValue;

  EigenVecs := FValue.EigenVectors(EigenVals);
  for i := 1 to 2 do
  begin
    result[i] := EigenVecs[i];
  end;
end;

function TC2MatrixQuantityHelper.Reciprocal(const ADeterminant: TComplexQuantity): TC2MatrixQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Reciprocal(ADeterminant.FValue);
end;

function TC2MatrixQuantityHelper.TransposeConjugate: TC2MatrixQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.TransposeConjugate;
end;
{$ENDIF}

// TC2VecQuantityHelper

{$IFNDEF ADIMOFF}
function TC2VecQuantityHelper.Dot(const AVector: TC2VecQuantity): TComplexQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TC2VecQuantityHelper.Conjugate: TC2VecQuantity;
begin
  result.FDim := FDim;
  result.FValue:= FValue.Conjugate;
end;
{$ENDIF}

// TC3VecQuantityHelper

{$IFNDEF ADIMOFF}
function TC3VecQuantityHelper.Dot(const AVector: TC3VecQuantity): TComplexQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TC3VecQuantityHelper.Conjugate: TC3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue:= FValue.Conjugate;
end;
{$ENDIF}

// TC4VecQuantityHelper

{$IFNDEF ADIMOFF}
function TC4VecQuantityHelper.Dot(const AVector: TC4VecQuantity): TComplexQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TC4VecQuantityHelper.Conjugate: TC4VecQuantity;
begin
  result.FDim := FDim;
  result.FValue:= FValue.Conjugate;
end;
{$ENDIF}

// TR2VecQuantityHelper

{$IFNDEF ADIMOFF}
function TR2VecQuantityHelper.Dot(const AVector: TR2VecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;
{$ENDIF}

// TR3VecQuantityHelper

{$IFNDEF ADIMOFF}
function TR3VecQuantityHelper.Dot(const AVector: TR3VecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TR3VecQuantityHelper.Cross(const AVector: TR3VecQuantity): TR3VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Cross(AVector.FValue);
end;
{$ENDIF}

// TR4VecQuantityHelper

{$IFNDEF ADIMOFF}
function TR4VecQuantityHelper.Dot(const AVector: TR4VecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;
{$ENDIF}

// TCL3MultivecQuantityHelper

{$IFNDEF ADIMOFF}
function TCL3MultivecQuantityHelper.Dual: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL3MultivecQuantityHelper.Inverse: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Inverse;
end;

function TCL3MultivecQuantityHelper.Reverse: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL3MultivecQuantityHelper.Conjugate: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL3MultivecQuantityHelper.Reciprocal: TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Reciprocal;
end;

function TCL3MultivecQuantityHelper.LeftReciprocal: TCL3MultivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.LeftReciprocal;
end;

function TCL3MultivecQuantityHelper.Normalized: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL3MultivecQuantityHelper.Norm: TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL3MultivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL3MultivecQuantityHelper.Dot(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Dot(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Wedge(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Projection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Projection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rejection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Reflection(const AVector: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Reflection(const AVector: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TCL3MultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TCL3TrivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TCL3BivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TCL3VecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.SameValue(const AVector: TQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3MultivecQuantityHelper.ExtractMultivector(AComponents: TCL3MultivectorComponents): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractMultivector(AComponents);
end;

function TCL3MultivecQuantityHelper.ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractBivector(AComponents);
end;

function TCL3MultivecQuantityHelper.ExtractVector(AComponents: TCL3MultivectorComponents): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractVector(AComponents);
end;

function TCL3MultivecQuantityHelper.ExtractTrivector: TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractTrivector;
end;

function TCL3MultivecQuantityHelper.ExtractBivector: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractBivector;
end;

function TCL3MultivecQuantityHelper.ExtractVector: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractVector;
end;

function TCL3MultivecQuantityHelper.ExtractScalar: TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractScalar;
end;

function TCL3MultivecQuantityHelper.IsNull: boolean;
begin
  result := FValue.SameValue(CL3NullMultivector);
end;

function TCL3MultivecQuantityHelper.IsScalar: boolean;
begin
  result := FValue.IsScalar;
end;

function TCL3MultivecQuantityHelper.IsVector: boolean;
begin
  result := FValue.IsVector;
end;

function TCL3MultivecQuantityHelper.IsBiVector: boolean;
begin
  result := FValue.IsBiVector;
end;

function TCL3MultivecQuantityHelper.IsTrivector: boolean;
begin
  result := FValue.IsTrivector;
end;

function TCL3MultivecQuantityHelper.IsA: string;
begin
  result := FValue.IsA;
end;
{$ENDIF}

// TCL3TrivecQuantityHelper

{$IFNDEF ADIMOFF}
function TCL3TrivecQuantityHelper.Dual: TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL3TrivecQuantityHelper.Inverse: TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Inverse;
end;

function TCL3TrivecQuantityHelper.Reverse: TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL3TrivecQuantityHelper.Conjugate: TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL3TrivecQuantityHelper.Reciprocal: TCL3TrivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Reciprocal;
end;

function TCL3TrivecQuantityHelper.Normalized: TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL3TrivecQuantityHelper.Norm: TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL3TrivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3VecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TCL3VecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Projection(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3VecQuantity): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3TrivecQuantityHelper.Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TCL3VecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Reflection(const AVector: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3TrivecQuantityHelper.SameValue(const AVector: TCL3MultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.SameValue(const AVector: TCL3TrivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3TrivecQuantityHelper.ToMultivector: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TCL3BivecQuantityHelper

{$IFNDEF ADIMOFF}
function TCL3BivecQuantityHelper.Dual: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL3BivecQuantityHelper.Inverse: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Inverse;
end;

function TCL3BivecQuantityHelper.Conjugate: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL3BivecQuantityHelper.Reverse: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL3BivecQuantityHelper.Reciprocal: TCL3BivecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Reciprocal;
end;

function TCL3BivecQuantityHelper.Normalized: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL3BivecQuantityHelper.Norm: TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL3BivecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL3BivecQuantityHelper.Dot(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Dot(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3VecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := 0.0;
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := 0.0;
end;

function TCL3BivecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Projection(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Projection(const AVector: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3BivecQuantityHelper.Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Reflection(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Reflection(const AVector: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3BivecQuantityHelper.SameValue(const AVector: TCL3MultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3BivecQuantityHelper.SameValue(const AVector: TCL3BivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3BivecQuantityHelper.ExtractBivector(AComponents: TCL3MultivectorComponents): TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractBivector(AComponents);
end;

function TCL3BivecQuantityHelper.ToMultivector: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}

// TCL3VecQuantityHelper

{$IFNDEF ADIMOFF}
function TCL3VecQuantityHelper.Dual: TCL3BivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Dual;
end;

function TCL3VecQuantityHelper.Inverse: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Inverse;
end;

function TCL3VecQuantityHelper.Reverse: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reverse;
end;

function TCL3VecQuantityHelper.Conjugate: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Conjugate;
end;

function TCL3VecQuantityHelper.Reciprocal: TCL3VecQuantity;
begin
  result.FDim := CheckDiv(ScalarUnit.FDim, FDim);
  result.FValue := FValue.Reciprocal;
end;

function TCL3VecQuantityHelper.Normalized: TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Normalized;
end;

function TCL3VecQuantityHelper.Norm: TQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Norm;
end;

function TCL3VecQuantityHelper.SquaredNorm: TQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := FValue.SquaredNorm;
end;

function TCL3VecQuantityHelper.Dot(const AVector: TCL3VecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3VecQuantityHelper.Dot(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3VecQuantityHelper.Dot(const AVector: TCL3TrivecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3VecQuantityHelper.Dot(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Dot(AVector.FValue);
end;

function TCL3VecQuantityHelper.Wedge(const AVector: TCL3VecQuantity): TCL3BivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3VecQuantityHelper.Wedge(const AVector: TCL3BivecQuantity): TCL3TrivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3VecQuantityHelper.Wedge(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := CheckMul(FDim, FDim);
  result.FValue := 0.0;
end;

function TCL3VecQuantityHelper.Wedge(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Wedge(AVector.FValue);
end;

function TCL3VecQuantityHelper.Projection(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Projection(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Projection(const AVector: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Projection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Projection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Rejection(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function  TCL3VecQuantityHelper.Rejection(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Rejection(const AVector: TCL3TrivecQuantity): TQuantity;
begin
  result.FDim := FDim;
  result.FValue := 0.0;
end;

function TCL3VecQuantityHelper.Rejection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rejection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Reflection(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Reflection(const AVector: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Reflection(const AVector: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Reflection(const AVector: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Reflection(AVector.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1, AVector2: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1, AVector2: TCL3BivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1, AVector2: TCL3TrivecQuantity): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Rotation(const AVector1, AVector2: TCL3MultivecQuantity): TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.Rotation(AVector1.FValue, AVector2.FValue);
end;

function TCL3VecQuantityHelper.Cross(const AVector: TCL3VecQuantity): TCL3VecQuantity;
begin
  result.FDim := CheckMul(FDim, AVector.FDim);
  result.FValue := FValue.Cross(AVector.FValue);
end;

function TCL3VecQuantityHelper.SameValue(const AVector: TCL3MultivecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3VecQuantityHelper.SameValue(const AVector: TCL3VecQuantity): boolean;
begin
  result := FValue.SameValue(AVector.FValue);
end;

function TCL3VecQuantityHelper.ExtractVector(AComponents: TCL3MultivectorComponents): TCL3VecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ExtractVector(AComponents);
end;

function TCL3VecQuantityHelper.ToMultivector: TCL3MultivecQuantity;
begin
  result.FDim := FDim;
  result.FValue := FValue.ToMultivector;
end;
{$ENDIF}
