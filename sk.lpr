program SK;

{$mode ObjFPC}{$H+}

uses
  Skeleton, ADimMath, Math, SysUtils;

procedure Require(ACondition: boolean; const AMessage: string);
begin
  if not ACondition then
    raise Exception.Create(AMessage);
end;

procedure RequireSame(const AExpected, AActual: TReal; const AMessage: string);
begin
  if not Math.SameValue(AExpected, AActual, DefaultEpsilon) then
    raise Exception.CreateFmt('%s: expected %.16g, found %.16g',
      [AMessage, AExpected, AActual]);
end;

function QuantitiesSame(const ALeft, ARight: TRealQuantity): boolean;
begin
  {$IFNDEF ADIMOFF}
  result := ALeft.SameValue(ARight);
  {$ELSE}
  result := Math.SameValue(ALeft, ARight, DefaultEpsilon);
  {$ENDIF}
end;

procedure TestScalarQuantities;
var
  LReal: TRealQuantity;
  LComplex: TComplexQuantity;
begin
  LReal := 2 * BohrRadius;
  Require(LReal = BohrRadius + BohrRadius, 'Real quantity arithmetic');
  LComplex := LReal;
  Require(LComplex.SameValue(Complex(2, 0) * TComplexQuantity(BohrRadius)),
    'Real-to-complex quantity conversion');
  Require(LComplex.Conjugate.SameValue(LComplex), 'Complex quantity conjugate');
  Require(QuantitiesSame(LComplex.Norm, LReal), 'Complex quantity norm');
  LComplex := 2.0 * LComplex / 2.0;
  Require(LComplex.SameValue(TComplexQuantity(LReal)),
    'Complex quantity real-scalar arithmetic');
end;

procedure TestRealVectorQuantities;
var
  LRaw, LNormalized, LRightHandSide: TRealVector;
  LDimensionless, LLength, LSquaredLength, LSolution: TRealVectorQuantity;
begin
  LRaw.Init([3.0, 4.0]);
  LDimensionless := LRaw * ScalarUnit;
  LLength := BohrRadius * LDimensionless;

  Require(LLength.Size = 2, 'Quantity vector size');
  Require(QuantitiesSame(LLength[0], 3 * BohrRadius), 'Quantity vector component');
  Require(QuantitiesSame(LLength.Norm, 5 * BohrRadius), 'Quantity vector norm');
  Require(QuantitiesSame(LLength.SquaredNorm, 25 * BohrRadius * BohrRadius),
    'Quantity vector squared norm');

  LNormalized := LLength.Normalize;
  RequireSame(0.6, LNormalized[0], 'Normalized vector first component');
  RequireSame(0.8, LNormalized[1], 'Normalized vector second component');
  RequireSame(1, LNormalized.Norm, 'Normalized vector norm');

  LRaw.Init([4.0, 9.0]);
  LRightHandSide := LRaw;
  LDimensionless := LRightHandSide * ScalarUnit;
  LSquaredLength := (BohrRadius * BohrRadius) * LDimensionless;

  LRaw.Init([2.0, 0.0, 0.0]);
  LLength := BohrRadius * (LRaw * ScalarUnit);
  LRaw.Init([0.0, 3.0, 0.0]);
  LDimensionless := LRaw * ScalarUnit;
  Require(QuantitiesSame(
    LLength.Cross(BohrRadius * LDimensionless)[2],
    6 * BohrRadius * BohrRadius), 'Quantity vector cross product');

  { Keep the dimensioned right-hand side live for the matrix solve test. }
  LSolution := LSquaredLength;
  Require(LSolution.Size = 2, 'Squared-dimension vector construction');
end;

procedure TestComplexVectorQuantities;
var
  LRaw, LNormalized: TComplexVector;
  LQuantity, LConjugate: TComplexVectorQuantity;
  LLength: TComplexQuantity;
begin
  LRaw.Init([Complex(3, 4), Complex(0, 0)]);
  LQuantity := BohrRadius * (LRaw * ScalarUnit);
  LLength := BohrRadius;

  Require(QuantitiesSame(LQuantity.Norm, 5 * BohrRadius),
    'Complex quantity vector norm');
  LNormalized := LQuantity.Normalize;
  Require(LNormalized[0].SameValue(Complex(0.6, 0.8)),
    'Complex normalized vector');

  LConjugate := LQuantity.Conjugate;
  Require(LConjugate[0].SameValue(Complex(3, -4) * LLength),
    'Complex quantity vector conjugate');
end;

procedure TestMatrixQuantities;
var
  LRawMatrix, LReduced: TRealMatrix;
  LRawVector: TRealVector;
  LDimensionless, LLengthMatrix, LInverse: TRealMatrixQuantity;
  LRightHandSide, LSolution: TRealVectorQuantity;
  LEigenvalues: TComplexVectorQuantity;
  LEigenvectors, LIdentity: TComplexMatrix;
  LComplexTrace: TComplexQuantity;
begin
  LRawMatrix.Init([
    2.0, 0.0,
    0.0, 3.0
  ]);
  LDimensionless := LRawMatrix * ScalarUnit;
  LLengthMatrix := BohrRadius * LDimensionless;

  Require(LLengthMatrix.Order = 2, 'Quantity matrix order');
  Require(QuantitiesSame(LLengthMatrix.Trace, 5 * BohrRadius),
    'Quantity matrix trace');
  Require(QuantitiesSame(LLengthMatrix.Determinant,
    6 * BohrRadius * BohrRadius), 'Quantity matrix determinant');
  Require(QuantitiesSame(LLengthMatrix.Norm, Sqrt(13) * BohrRadius),
    'Quantity matrix norm');

  LInverse := LLengthMatrix.Inverse;
  Require(QuantitiesSame((LInverse * LLengthMatrix)[0, 0], TRealQuantity(1)),
    'Quantity matrix inverse dimension');
  Require(QuantitiesSame((LInverse * LLengthMatrix)[1, 1], TRealQuantity(1)),
    'Quantity matrix inverse value');

  LReduced := LLengthMatrix.RowReduction;
  RequireSame(1, LReduced[0, 0], 'Dimensionless row reduction');
  RequireSame(1, LReduced[1, 1], 'Dimensionless row reduction diagonal');

  LEigenvalues := LLengthMatrix.Eigenvalues;
  LComplexTrace := LLengthMatrix.Trace;
  Require((LEigenvalues[0] + LEigenvalues[1]).SameValue(LComplexTrace),
    'Dimensional eigenvalues');
  LEigenvectors := LLengthMatrix.Eigenvectors(LEigenvalues);
  LIdentity := LEigenvectors.Identity;
  Require((LEigenvectors.TransposeConjugate * LEigenvectors).SameValue(LIdentity),
    'Dimensionless normalized eigenvectors');

  LRawVector.Init([4.0, 9.0]);
  LRightHandSide := (BohrRadius * BohrRadius) *
    (LRawVector * ScalarUnit);
  LSolution := LLengthMatrix.SolveLinear(LRightHandSide);
  Require(QuantitiesSame(LSolution[0], 2 * BohrRadius),
    'Dimension-aware linear solve first component');
  Require(QuantitiesSame(LSolution[1], 3 * BohrRadius),
    'Dimension-aware linear solve second component');
end;

procedure TestComplexMatrixQuantities;
var
  LRaw: TComplexMatrix;
  LQuantity, LConjugate: TComplexMatrixQuantity;
  {$IFNDEF ADIMOFF}
  LHermitianRaw: TComplexMatrix;
  LHermitian: TComplexMatrixQuantity;
  {$ENDIF}
begin
  LRaw.Init([
    Complex(0, 0), Complex(0, 1),
    Complex(0, 1), Complex(0, 0)
  ]);
  LQuantity := LRaw * ScalarUnit;
  Require(LQuantity.IsUnitary, 'Dimensionless complex unitary matrix');
  LConjugate := LQuantity.Conjugate;
  Require(LConjugate[0, 1].SameValue(Complex(0, -1)),
    'Complex quantity matrix conjugate');
  Require(LQuantity.TransposeConjugate.SameValue(LConjugate.Transpose),
    'Complex quantity matrix adjoint');

  {$IFNDEF ADIMOFF}
  LHermitianRaw.Init([
    Complex(2, 0), Complex(1, 1),
    Complex(1, -1), Complex(3, 0)
  ]);
  LHermitian := LHermitianRaw * ScalarUnit;
  Require(LHermitian.IsHermitian, 'Hermitian quantity matrix');

  LHermitianRaw.Init([
    Complex(2, 0), Complex(1, 1),
    Complex(1, 1), Complex(3, 0)
  ]);
  LHermitian := LHermitianRaw * ScalarUnit;
  Require(not LHermitian.IsHermitian, 'Non-Hermitian quantity matrix');
  {$ENDIF}
end;

procedure TestRuntimeSizedUnitConversions;
var
  LRawVector, LConvertedVector, LExtractedVector: TRealVector;
  LRawMatrix, LConvertedMatrix, LExtractedMatrix: TRealMatrix;
  LVectorQuantity: TRealVectorQuantity;
  LMatrixQuantity: TRealMatrixQuantity;
begin
  LRawVector.Init([1.0, 2.0, 3.0, 4.0, 5.0]);
  LConvertedVector := ScalarUnit.GetValue(LRawVector, []);
  Require(LConvertedVector.Size = 5, 'Unit conversion preserves runtime vector size');
  RequireSame(5, LConvertedVector[4], 'Unit conversion preserves vector values');

  LVectorQuantity := LRawVector * ScalarUnit;
  LRawVector[0] := 99;
  Require(QuantitiesSame(LVectorQuantity[0], TRealQuantity(1)),
    'Vector quantity owns an independent mathematical value');
  LExtractedVector := ScalarUnit.ToVector(LVectorQuantity);
  LExtractedVector[1] := 99;
  Require(QuantitiesSame(LVectorQuantity[1], TRealQuantity(2)),
    'Extracted vector is independent from its quantity');

  LRawMatrix.Init([
    1.0, 2.0, 3.0,
    4.0, 5.0, 6.0,
    7.0, 8.0, 9.0
  ]);
  LConvertedMatrix := ScalarUnit.GetValue(LRawMatrix, []);
  Require(LConvertedMatrix.Order = 3, 'Unit conversion preserves runtime matrix order');
  RequireSame(8, LConvertedMatrix[2, 1], 'Unit conversion preserves matrix values');

  LMatrixQuantity := LRawMatrix * ScalarUnit;
  LRawMatrix[0, 0] := 99;
  Require(QuantitiesSame(LMatrixQuantity[0, 0], TRealQuantity(1)),
    'Matrix quantity owns an independent mathematical value');
  LExtractedMatrix := ScalarUnit.ToMatrix(LMatrixQuantity);
  LExtractedMatrix[1, 1] := 99;
  Require(QuantitiesSame(LMatrixQuantity[1, 1], TRealQuantity(5)),
    'Extracted matrix is independent from its quantity');
end;

procedure TestLargeMatrixOperations;
const
  MatrixOrder = 64;
var
  LIndex: longint;
  LLeftData, LRightData, LExpectedData: TArrayOfReal;
  LLeft, LRight, LExpected: TRealMatrix;
  LProduct, LExpectedQuantity: TRealMatrixQuantity;
begin
  SetLength(LLeftData, MatrixOrder * MatrixOrder);
  SetLength(LRightData, MatrixOrder * MatrixOrder);
  SetLength(LExpectedData, MatrixOrder * MatrixOrder);
  for LIndex := 0 to MatrixOrder - 1 do
  begin
    LLeftData[LIndex * MatrixOrder + LIndex] := LIndex + 1;
    LRightData[LIndex * MatrixOrder + LIndex] := MatrixOrder - LIndex;
    LExpectedData[LIndex * MatrixOrder + LIndex] :=
      (LIndex + 1) * (MatrixOrder - LIndex);
  end;

  LLeft.Init(LLeftData);
  LRight.Init(LRightData);
  LExpected.Init(LExpectedData);
  LProduct := (LLeft * ScalarUnit) * (LRight * ScalarUnit);
  LExpectedQuantity := LExpected * ScalarUnit;

  Require(LProduct.Order = MatrixOrder, 'Large matrix product order');
  Require(LProduct.SameValue(LExpectedQuantity), 'Large matrix product values');
end;

procedure TestRuntimeSizeChecks;
var
  LTwo, LThree: TRealMatrix;
  LLeft, LRight: TRealMatrixQuantity;
  LRaised: boolean;
begin
  LTwo.Init([
    1.0, 0.0,
    0.0, 1.0
  ]);
  LThree.Init([
    1.0, 0.0, 0.0,
    0.0, 1.0, 0.0,
    0.0, 0.0, 1.0
  ]);
  LLeft := LTwo * ScalarUnit;
  LRight := LThree * ScalarUnit;

  LRaised := False;
  try
    Require((LLeft * LRight).Order = -1,
      'Matrix product must not accept incompatible runtime orders');
  except
    on EDimensionError do LRaised := True;
  end;
  Require(LRaised, 'Matrix product rejects incompatible runtime orders');
end;

{$IFNDEF ADIMOFF}
procedure TestDimensionChecks;
var
  LValue: TRealQuantity;
  LRaised: boolean;
begin
  LRaised := False;
  try
    LValue := BohrRadius + PlanckConstant;
  except
    on EDimensionError do LRaised := True;
  end;
  Require(LRaised, 'Incompatible physical dimensions must raise');
  LValue := BohrRadius;
  Require(LValue.SameValue(BohrRadius), 'Dimension check test completion');
end;
{$ENDIF}

procedure RunSkeletonTests;
begin
  TestScalarQuantities;
  TestRealVectorQuantities;
  TestComplexVectorQuantities;
  TestMatrixQuantities;
  TestComplexMatrixQuantities;
  TestRuntimeSizedUnitConversions;
  TestLargeMatrixOperations;
  TestRuntimeSizeChecks;
  {$IFNDEF ADIMOFF}
  TestDimensionChecks;
  {$ENDIF}
end;


begin
  RunSkeletonTests;
end.
