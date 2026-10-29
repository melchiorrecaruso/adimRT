{ SpecRoots - SquareRoot, CubicRoot, QuarticRoot and the power functions.

  SquareRoot is required to be accurate per component: each of Re and Im
  must have a small relative error, which is achievable for the principal
  square root (W. Kahan, "Branch cuts for complex elementary functions",
  1987) and is what a residual |r^2 - z| cannot detect when one component
  is much smaller than the other. The first-order error estimate of the
  implementation is 5.5u.

  For cube and fourth roots the backward error |r^k - z| / (k*|z|) is
  measured with r^k evaluated in double-double; it equals the normwise
  relative forward error of r to first order. Powers use the composed
  multiplication bound (k-1)*sqrt(5)*u. }
unit SpecRoots;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}

interface

implementation

uses
  SysUtils, Math, ADimMath, TestRunner, TestDoubleDouble, TestGenerators,
  TestMeasures;

const
  Scales: array[0..8] of Double = (1E-300, 1E-150, 1E-50, 1E-8, 1,
    1E8, 1E50, 1E150, 1E300);

function ComponentRatio(AValue: Double; const AReference: TDD): Double;
var
  LReference: Double;
begin
  LReference := AReference.ToDouble;
  if LReference = 0 then
  begin
    if AValue = 0 then Exit(0) else Exit(Infinity);
  end;
  result := DDAbs(TDD(AValue) - AReference).ToDouble /
    (System.Abs(LReference) * UnitRoundoff);
end;

{ Distance between two angles, reduced to [-pi, pi]. }
function AngleDistance(A, B: Double): Double;
begin
  result := A - B;
  result := System.Abs(result - 2 * Pi * Round(result / (2 * Pi)));
end;

function DDPower(const AValue: TComplex; K: Integer): TDDComplex;
var
  LIndex: Integer;
begin
  result := TDDComplex(AValue);
  for LIndex := 2 to K do result := result * TDDComplex(AValue);
end;

procedure CheckSquareRoot(const ALabel: string; const Z: TComplex);
var
  R: TArrayOfComplex;
  LReference: TDDComplex;
begin
  R := SquareRoot(Z);
  LReference := DDComplexSqrt(TDDComplex(Z));
  CheckRatio(ALabel + ' Re', ComponentRatio(R[0].Re, LReference.Re));
  CheckRatio(ALabel + ' Im', ComponentRatio(R[0].Im, LReference.Im));
end;

procedure CheckRootBackward(const ALabel: string; const Z: TComplex; K: Integer);
var
  R: TArrayOfComplex;
  LIndex: Integer;
  LModulus: Double;
begin
  if K = 3 then R := CubicRoot(Z) else R := QuarticRoot(Z);
  LModulus := DDModulus(TDDComplex(Z)).ToDouble;
  for LIndex := 0 to K - 1 do
    CheckRatio(Format('%s root %d', [ALabel, LIndex]),
      DDModulus(DDPower(R[LIndex], K) - TDDComplex(Z)).ToDouble /
      (K * LModulus * UnitRoundoff));
end;

procedure ContractChecks;
var
  R: TArrayOfComplex;
  K, J: Integer;
  Z: TComplex;
  LExpected: Double;
begin
  Group('Root counts, principal root and documented ordering', ckContract);
  R := SquareRoot(Complex(-4, 0));
  CheckEqual('sqrt count', Length(R), 2);
  CheckEqual('sqrt(-4) principal', R[0], Complex(0, 2));
  CheckEqual('sqrt(-4) second = -first', R[1], Complex(0, -2));
  CheckEqual('sqrt(4)', SquareRoot(Complex(4, 0))[0], Complex(2, 0));
  CheckEqual('sqrt(-4-0i): sign of zero ignored', SquareRoot(Complex(-4, -0.0))[0],
    Complex(0, 2));
  CheckEqual('sqrt(0)', SquareRoot(Complex(0, 0))[0], Complex(0, 0));
  CheckEqual('sqrt(2i)', SquareRoot(Complex(0, 2))[0], Complex(1, 1));
  CheckEqual('sqrt(-2i)', SquareRoot(Complex(0, -2))[0], Complex(1, -1));
  SetSeed(301);
  for K := 1 to 100 do
  begin
    Z := RandomComplex;
    R := SquareRoot(Z);
    Check(Format('principal root has Re >= 0 #%d', [K]), R[0].Re >= 0);
    CheckEqual(Format('result[1] = -result[0] #%d', [K]), R[1], -R[0]);
  end;
  CheckEqual('cbrt count', Length(CubicRoot(Complex(8, 0))), 3);
  CheckEqual('4th root count', Length(QuarticRoot(Complex(16, 0))), 4);
  SetSeed(302);
  for K := 1 to 50 do
  begin
    Z := RandomComplex;
    R := CubicRoot(Z);
    for J := 0 to 2 do
    begin
      LExpected := (Z.Arg + 2 * Pi * J) / 3;
      Check(Format('cbrt #%d root %d at (arg+2*pi*k)/3', [K, J]),
        AngleDistance(R[J].Arg, LExpected) < 1E-12);
    end;
    R := QuarticRoot(Z);
    for J := 0 to 3 do
    begin
      LExpected := (Z.Arg + 2 * Pi * J) / 4;
      Check(Format('4th root #%d root %d at (arg+2*pi*k)/4', [K, J]),
        AngleDistance(R[J].Arg, LExpected) < 1E-12);
    end;
  end;
end;

procedure SquareRootAccuracy;
var
  S, T, K: Integer;
  Z: TComplex;
begin
  Group('SquareRoot, componentwise relative error', ckAccuracy, 8, tsProject,
    'first-order estimate 5.5u; Kahan 1987');
  SetSeed(311);
  for S := 0 to 8 do
    for K := 1 to 40 do
      CheckSquareRoot(Format('random scale %g #%d', [Scales[S], K]),
        RandomComplex * Scales[S]);
  { Components of very different magnitude in every quadrant. }
  for S := 1 to 7 do
    for T := 1 to 7 do
    begin
      CheckSquareRoot(Format('(+%g, +%g)', [Scales[S], Scales[T]]),
        Complex(Scales[S], Scales[T]));
      CheckSquareRoot(Format('(-%g, +%g)', [Scales[S], Scales[T]]),
        Complex(-Scales[S], Scales[T]));
      CheckSquareRoot(Format('(+%g, -%g)', [Scales[S], Scales[T]]),
        Complex(Scales[S], -Scales[T]));
      CheckSquareRoot(Format('(-%g, -%g)', [Scales[S], Scales[T]]),
        Complex(-Scales[S], -Scales[T]));
    end;
  CheckSquareRoot('1 + 1e-10i', Complex(1, 1E-10));
  CheckSquareRoot('-1 + 1e-10i', Complex(-1, 1E-10));
  CheckSquareRoot('near overflow', Complex(1.7E308, 1.7E308));
  CheckSquareRoot('near underflow', Complex(3E-308, -5E-308));
  CheckSquareRoot('subnormal', Complex(-4.9E-324, 0));
end;

procedure HigherRootAccuracy;
var
  S, K: Integer;
begin
  Group('CubicRoot and QuarticRoot, backward error', ckAccuracy, 8, tsProject,
    'normwise, a few ulps for Power and the trigonometric functions');
  SetSeed(321);
  for S := 1 to 7 do
    for K := 1 to 20 do
    begin
      CheckRootBackward(Format('cbrt scale %g #%d', [Scales[S], K]),
        RandomComplex * Scales[S], 3);
      CheckRootBackward(Format('4th root scale %g #%d', [Scales[S], K]),
        RandomComplex * Scales[S], 4);
    end;
  CheckRootBackward('cbrt(-1)', Complex(-1, 0), 3);
  CheckRootBackward('cbrt(1e-10 i)', Complex(0, 1E-10), 3);
  CheckRootBackward('4th root(1 + 1e-12 i)', Complex(1, 1E-12), 4);
end;

procedure PowerAccuracy;
var
  S, K: Integer;
  Z: TComplex;
  LDenominator: Double;
begin
  Group('Square, cubic and quartic powers, normwise relative error',
    ckAccuracy, 1.000001, tsProved, '(k-1)*sqrt(5)u by composition');
  SetSeed(331);
  for S := 2 to 6 do
    for K := 1 to 40 do
    begin
      Z := RandomComplex * Power(Scales[S], 0.25);
      LDenominator := Sqrt(5) * UnitRoundoff;
      CheckRatio(Format('z^2 #%d', [K]),
        DDModulus(TDDComplex(SquarePower(Z)) - DDPower(Z, 2)).ToDouble /
        (Sqr(Z.Norm) * LDenominator));
      CheckRatio(Format('z^3 #%d', [K]),
        DDModulus(TDDComplex(CubicPower(Z)) - DDPower(Z, 3)).ToDouble /
        (Power(Z.Norm, 3) * 2 * LDenominator * (1 + 3 * UnitRoundoff)));
      CheckRatio(Format('z^4 #%d', [K]),
        DDModulus(TDDComplex(QuarticPower(Z)) - DDPower(Z, 4)).ToDouble /
        (Power(Z.Norm, 4) * 3 * LDenominator * (1 + 5 * UnitRoundoff)));
    end;
end;

procedure Run;
begin
  Guard(@ContractChecks);
  Guard(@SquareRootAccuracy);
  Guard(@HigherRootAccuracy);
  Guard(@PowerAccuracy);
end;

initialization
  RegisterSpec('Scalar roots and powers', @Run);
end.
