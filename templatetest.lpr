program TemplateTest;

{$mode ObjFPC}{$H+}

uses
  Math, SysUtils, Template, ADimMath, ADimCL3;

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

procedure TestCorrectedMathFunctions;
var
  LRatio: TReal;
begin
  LRatio := ScalarUnit.ToFloat(MolarGasConstant /
    (BoltzmannConstant * AvogadroConstant));
  Require(Abs(LRatio - 1) < 1E-9,
    'Molar gas constant dimension and value');

  RequireSame(Pi / 2, ScalarUnit.ToFloat(ArcTan2(1, 0)),
    'ArcTan2 positive y-axis');
  RequireSame(Pi, ScalarUnit.ToFloat(ArcTan2(0, -1)),
    'ArcTan2 negative x-axis');
  RequireSame(-Pi / 2, ScalarUnit.ToFloat(ArcTan2(-1, 0)),
    'ArcTan2 negative y-axis');

  RequireSame(-2, ScalarUnit.ToFloat(Template.CubicRoot(TRealQuantity(-8))),
    'Real cubic root of a negative value');
  RequireSame(-2, ScalarUnit.ToFloat(Template.QuinticRoot(TRealQuantity(-32))),
    'Real quintic root of a negative value');
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
  LRawMatrix: TRealMatrix;
  LRawVector: TRealVector;
  LDimensionless, LLengthMatrix, LInverse: TRealMatrixQuantity;
  LRightHandSide, LSolution: TRealVectorQuantity;
  LEigenvalues: TComplexVectorQuantity;
  LEigenvectors: TComplexMatrix;
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

  LLengthMatrix.Eigenpairs(LEigenvalues, LEigenvectors);
  LComplexTrace := LLengthMatrix.Trace;
  Require((LEigenvalues[0] + LEigenvalues[1]).SameValue(LComplexTrace),
    'Dimensional eigenvalues');
  Require(LEigenvectors.Order = 2, 'Dimensional eigenvector count');
  RequireSame(1, Sqrt(LEigenvectors[0, 0].SquaredNorm +
    LEigenvectors[1, 0].SquaredNorm), 'First eigenvector norm');
  RequireSame(1, Sqrt(LEigenvectors[0, 1].SquaredNorm +
    LEigenvectors[1, 1].SquaredNorm), 'Second eigenvector norm');
  Require((LEigenvectors[0, 0].Conjugate * LEigenvectors[0, 1] +
    LEigenvectors[1, 0].Conjugate * LEigenvectors[1, 1]).Norm < 1e-12,
    'Dimensionless orthogonal eigenvectors');

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
  LEigenvalues: TComplexVectorQuantity;
  LEigenvectors: TComplexMatrix;
  LHermitianRaw: TComplexMatrix;
  LHermitian: TComplexMatrixQuantity;
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
  LQuantity.Eigenpairs(LEigenvalues, LEigenvectors);
  Require((LEigenvalues[0] + LEigenvalues[1]).SameValue(LQuantity.Trace),
    'Complex dimensional eigenvalues');
  Require(LEigenvectors.Order = LRaw.Order,
    'Complex dimensionless eigenvectors');

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

{ The same code must compile and give the same results with and without
  ADIMOFF: every routine of a quantity type has a counterpart on the value
  type that replaces it when the dimensional checks are disabled. }
procedure TestModeAlignment;
var
  LReal: TRealQuantity;
  LComplex: TComplexQuantity;
  LRawVector: TRealVector;
  LRawMatrix: TRealMatrix;
  LRawComplexMatrix: TComplexMatrix;
  LVector: TRealVectorQuantity;
  LMatrix: TRealMatrixQuantity;
  LComplexMatrix: TComplexMatrixQuantity;
  LValues: TRealVectorQuantity;
  LVectors: TRealMatrix;
  LComplexVectors: TComplexMatrix;
  LCL3: TCL3VecQuantity;
begin
  LReal := -2 * BohrRadius;
  Require(QuantitiesSame(Abs(LReal), 2 * BohrRadius), 'Abs of a real quantity');
  Require(QuantitiesSame(LReal.Norm, 2 * BohrRadius), 'Norm of a real quantity');
  Require(QuantitiesSame(LReal.SquaredNorm, 4 * BohrRadius * BohrRadius),
    'Squared norm of a real quantity');
  Require(QuantitiesSame(LReal.Conjugate, LReal), 'Conjugate of a real quantity');
  Require(QuantitiesSame(LReal.Reciprocal * LReal, TRealQuantity(1)),
    'Reciprocal of a real quantity');
  Require(Abs(-3) = 3, 'Abs of an integer is still the system Abs');

  LComplex := Complex(0, 2) * BohrRadius;
  RequireSame(Pi / 2, LComplex.Arg, 'Argument of a complex quantity');
  Require(LComplex.IsNotNull and not LComplex.IsNull, 'Null test of a complex quantity');
  Require(SameValueEx(LComplex, LComplex), 'SameValueEx of complex quantities');
  Require(QuinticPower(TComplexQuantity(Complex(0, 1))).SameValue(Complex(0, 1)),
    'Fifth power of a complex quantity');
  Require(SexticPower(TComplexQuantity(Complex(0, 1))).SameValue(Complex(-1, 0)),
    'Sixth power of a complex quantity');
  Require((2.0 / TComplexQuantity(Complex(0, 2))).SameValue(Complex(0, -1)),
    'Real scalar divided by a complex quantity');

  LRawVector.Init([1.0, 2.0]);
  LVector := BohrRadius * LRawVector;
  Require(LVector.SameValue(LRawVector * BohrRadius), 'Real quantity times a vector');
  Require(QuantitiesSame((LRawVector / BohrRadius)[1] * BohrRadius, TRealQuantity(2)),
    'Vector divided by a real quantity');

  LRawMatrix.Init([
    2.0, 1.0,
    1.0, 2.0
  ]);
  LMatrix := BohrRadius * LRawMatrix;
  Require((-LMatrix + LMatrix).IsNull, 'Unary minus of a matrix quantity');
  LMatrix.SymmetricEigenpairs(LValues, LVectors);
  Require(QuantitiesSame(LValues[0], BohrRadius) and
    QuantitiesSame(LValues[1], 3 * BohrRadius), 'Symmetric eigenvalues');

  LRawComplexMatrix.Init([
    Complex(2, 0), Complex(1, 1),
    Complex(1, -1), Complex(3, 0)
  ]);
  LComplexMatrix := TComplexQuantity(BohrRadius) * LRawComplexMatrix;
  Require(LComplexMatrix.IsHermitian, 'Hermitian quantity matrix');
  LComplexMatrix.HermitianEigenpairs(LValues, LComplexVectors);
  Require(QuantitiesSame(LValues[0], BohrRadius) and
    QuantitiesSame(LValues[1], 4 * BohrRadius), 'Hermitian eigenvalues');

  Require(QuantitiesSame(ScalarUnit * LReal, LReal), 'Unit on the left of a quantity');
  Require(QuantitiesSame((ScalarUnit / LReal) * LReal, TRealQuantity(1)),
    'Unit divided by a quantity');

  LCL3 := (1*e1 + 2*e3) * BohrRadius;
  Require(ScalarUnit.ToVector(LCL3 / BohrRadius).ToString = '+1e1 +2e3',
    'Clifford vector expressed in a unit');
  Require(ScalarUnit.ToString(LCL3 / BohrRadius, 3, 0, []) = '(+1e1 +2e3) ',
    'Clifford vector formatted with a precision');
  Require(ScalarUnit.ToString(LRawVector * ScalarUnit, 3, 0, []) = '(1,2) ',
    'Vector formatted with a precision');
  Require(ScalarUnit.ToString(LRawMatrix * ScalarUnit, 3, 0, []) = '((2, 1), (1, 2)) ',
    'Matrix formatted with a precision');
  Require(ScalarUnit.ToString(TComplexQuantity(Complex(1.5, 2)), []) = '(1.5 +2∙i) ',
    'Complex quantity formatted with prefixes');
end;

{$IFNDEF ADIMOFF}
procedure TestDimensionChecks;
var
  LText: string;
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

  LRaised := False;
  try
    LText := ScalarUnit.ToString(TRealQuantity(1), BohrRadius, 4, 2, []);
    Require(LText <> '', 'Compatible formatting must return text');
  except
    on EDimensionError do LRaised := True;
  end;
  Require(LRaised, 'Formatting rejects a tolerance with incompatible dimensions');

  LValue := BohrRadius;
  Require(LValue.SameValue(BohrRadius), 'Dimension check test completion');
end;
{$ENDIF}

procedure RunTemplateTests;
begin
  TestScalarQuantities;
  TestCorrectedMathFunctions;
  TestRealVectorQuantities;
  TestComplexVectorQuantities;
  TestMatrixQuantities;
  TestComplexMatrixQuantities;
  TestRuntimeSizedUnitConversions;
  TestLargeMatrixOperations;
  TestRuntimeSizeChecks;
  TestModeAlignment;
  {$IFNDEF ADIMOFF}
  TestDimensionChecks;
  {$ENDIF}
end;


begin
  RunTemplateTests;
end.
