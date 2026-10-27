{ SpecPolynomials - SolveEquation for degrees 1 to 4.

  Each case starts from a known multiset of roots. The monic coefficients
  are formed in double-double and rounded once; the computed roots are
  then matched to the true ones as a multiset (best of all permutations),
  so that returning one root several times cannot pass.

  The error of each root is compared with its condition. With
  p(x) = sum c_k x^(n-k), S(r) = sum |c_k| |r|^(n-k) and t_m the m-th
  Taylor coefficient of p at a root r of multiplicity m, a relative
  perturbation eps of the coefficients moves the root by about

      delta = (eps * S(r) / |t_m|)^(1/m)

  (J. H. Wilkinson, Rounding Errors in Algebraic Processes, 1963;
  W. Gautschi, "On the condition of algebraic equations", Numer. Math.
  1973). The ratio |r_computed - r| / delta is checked with
  eps = 2*n*u, the size of the backward error of a Horner-based polishing
  step. For an exact zero root S(r) = 0; the error is then measured
  relative to the largest root modulus. }
unit SpecPolynomials;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}

interface

implementation

uses
  SysUtils, Math, ADimMath, TestRunner, TestDoubleDouble, TestGenerators,
  TestMeasures;

type
  TRootSet = array of TComplex;

function Solve(const ACoefficients: TArrayOfComplex): TArrayOfComplex;
begin
  case Length(ACoefficients) of
    1: begin
         result := nil;
         SetLength(result, 1);
         result[0] := SolveEquation(ACoefficients[0]);
       end;
    2: result := SolveEquation(ACoefficients[0], ACoefficients[1]);
    3: result := SolveEquation(ACoefficients[0], ACoefficients[1],
         ACoefficients[2]);
    4: result := SolveEquation(ACoefficients[0], ACoefficients[1],
         ACoefficients[2], ACoefficients[3]);
  else
    result := nil;
  end;
end;

{ Perturbation radius of a true root, as described in the unit header. }
function RootRadius(const ACoefficients: TArrayOfComplex; const ARoot: TComplex;
  AMultiplicity: Integer; ALargest: Double): Double;
var
  N, K, M: Integer;
  LTaylor: array of TDDComplex;
  LSum, LEpsilon, LModulus: Double;
begin
  N := Length(ACoefficients);
  LEpsilon := 2 * N * UnitRoundoff;
  LModulus := ARoot.Norm;
  LSum := Power(LModulus, N);
  for K := 0 to N - 1 do
    LSum := LSum + ACoefficients[K].Norm * Power(LModulus, N - 1 - K);
  if LSum = 0 then
    Exit(Power(LEpsilon, 1 / AMultiplicity) * ALargest);
  { Taylor coefficients of p at the root by repeated synthetic division. }
  SetLength(LTaylor, N + 1);
  LTaylor[0] := DDComplex(1, 0);
  for K := 1 to N do LTaylor[K] := TDDComplex(ACoefficients[K - 1]);
  for M := 0 to AMultiplicity do
    for K := 1 to N - M do
      LTaylor[K] := LTaylor[K] + TDDComplex(ARoot) * LTaylor[K - 1];
  { After the divisions, LTaylor[N - M] holds the M-th Taylor coefficient. }
  result := Power(LEpsilon * LSum /
    DDModulus(LTaylor[N - AMultiplicity]).ToDouble, 1 / AMultiplicity);
end;

procedure NextPermutation(var APermutation: array of Integer; out ADone: Boolean);
var
  I, J, T: Integer;
begin
  I := High(APermutation) - 1;
  while (I >= 0) and (APermutation[I] >= APermutation[I + 1]) do Dec(I);
  ADone := I < 0;
  if ADone then Exit;
  J := High(APermutation);
  while APermutation[J] <= APermutation[I] do Dec(J);
  T := APermutation[I]; APermutation[I] := APermutation[J]; APermutation[J] := T;
  Inc(I);
  J := High(APermutation);
  while I < J do
  begin
    T := APermutation[I]; APermutation[I] := APermutation[J]; APermutation[J] := T;
    Inc(I);
    Dec(J);
  end;
end;

procedure CheckRoots(const ALabel: string; const ARoots: array of TComplex);
var
  LCoefficients, LComputed: TArrayOfComplex;
  LRadius, LBestRatios, LRatios: array of Double;
  LPermutation: array of Integer;
  N, I, J, LMultiplicity: Integer;
  LLargest, LWorst, LBestWorst: Double;
  LDone: Boolean;
begin
  N := Length(ARoots);
  LCoefficients := CoefficientsFromRoots(ARoots);
  LComputed := Solve(LCoefficients);
  if Length(LComputed) <> N then
  begin
    CheckEqual(ALabel + ' root count', Length(LComputed), N);
    Exit;
  end;
  LLargest := 0;
  for I := 0 to N - 1 do LLargest := Max(LLargest, ARoots[I].Norm);
  SetLength(LRadius, N);
  for I := 0 to N - 1 do
  begin
    LMultiplicity := 0;
    for J := 0 to N - 1 do
      if ARoots[J] = ARoots[I] then Inc(LMultiplicity);
    LRadius[I] := RootRadius(LCoefficients, ARoots[I], LMultiplicity, LLargest);
  end;
  SetLength(LPermutation, N);
  SetLength(LRatios, N);
  SetLength(LBestRatios, N);
  for I := 0 to N - 1 do LPermutation[I] := I;
  LBestWorst := Infinity;
  repeat
    LWorst := 0;
    for I := 0 to N - 1 do
    begin
      LRatios[I] := (LComputed[LPermutation[I]] - ARoots[I]).Norm / LRadius[I];
      if IsNan(LRatios[I]) then LRatios[I] := Infinity;
      LWorst := Max(LWorst, LRatios[I]);
    end;
    if LWorst < LBestWorst then
    begin
      LBestWorst := LWorst;
      for I := 0 to N - 1 do LBestRatios[I] := LRatios[I];
    end;
    NextPermutation(LPermutation, LDone);
  until LDone;
  for I := 0 to N - 1 do
    CheckRatio(Format('%s root %d', [ALabel, I]), LBestRatios[I]);
end;

function C(ARe: Double; AIm: Double = 0): TComplex;
begin
  result := Complex(ARe, AIm);
end;

procedure ContractChecks;
var
  R: TArrayOfComplex;
  I: Integer;
begin
  Group('Root counts and the zero polynomial', ckContract);
  CheckEqual('degree 2 count', Length(SolveEquation(C(1), C(2))), 2);
  CheckEqual('degree 3 count', Length(SolveEquation(C(1), C(2), C(3))), 3);
  CheckEqual('degree 4 count', Length(SolveEquation(C(1), C(2), C(3), C(4))), 4);
  R := SolveEquation(C(0), C(0));
  for I := 0 to 1 do CheckEqual(Format('x^2 root %d', [I]), R[I], C(0));
  R := SolveEquation(C(0), C(0), C(0));
  for I := 0 to 2 do CheckEqual(Format('x^3 root %d', [I]), R[I], C(0));
  R := SolveEquation(C(0), C(0), C(0), C(0));
  for I := 0 to 3 do CheckEqual(Format('x^4 root %d', [I]), R[I], C(0));
end;

procedure RandomRoots(var ARoots: TRootSet; N: Integer; AScale: Double;
  AReal: Boolean);
var
  I: Integer;
begin
  SetLength(ARoots, N);
  for I := 0 to N - 1 do
    if AReal then ARoots[I] := C(RandomUniform * AScale)
    else ARoots[I] := RandomComplex * AScale;
end;

procedure GeneratedCases;
const
  Scales: array[0..6] of Double = (1E-150, 1E-30, 1E-8, 1, 1E8, 1E30, 1E150);
var
  N, K, S: Integer;
  LRoots: TRootSet;
  LPair: TComplex;
begin
  Group('Random simple roots, all scales', ckAccuracy, ProjectThreshold,
    tsProject, 'error / condition-based perturbation radius');
  SetSeed(401);
  LRoots := nil;
  for N := 1 to 4 do
    for S := Low(Scales) to High(Scales) do
      for K := 1 to 25 do
      begin
        { The coefficients scale like Scales[S]^k: skip cases where they
          leave the normal range, since the rounded polynomial would no
          longer have these roots. }
        if (Power(Scales[S], N) < 1E-290) or (Power(Scales[S], N) > 1E290) then
          Continue;
        RandomRoots(LRoots, N, Scales[S], False);
        CheckRoots(Format('complex n=%d scale %g #%d', [N, Scales[S], K]), LRoots);
        RandomRoots(LRoots, N, Scales[S], True);
        CheckRoots(Format('real n=%d scale %g #%d', [N, Scales[S], K]), LRoots);
      end;
  { Real polynomials with complex-conjugate roots. }
  for K := 1 to 50 do
  begin
    LPair := RandomComplex;
    CheckRoots(Format('conjugate pair #%d', [K]), [LPair, LPair.Conjugate]);
    CheckRoots(Format('conjugate pair + real #%d', [K]),
      [LPair, LPair.Conjugate, C(RandomUniform)]);
    CheckRoots(Format('two conjugate pairs #%d', [K]),
      [LPair, LPair.Conjugate, LPair * 3, LPair.Conjugate * 3]);
  end;
end;

procedure StructuredCases;
begin
  Group('Roots of widely different magnitudes', ckAccuracy, ProjectThreshold,
    tsProject, 'error / condition-based perturbation radius');
  CheckRoots('x^2+1e8x+1', [C(-1E-8), C(-1E8)]);
  CheckRoots('1e-8, 1', [C(1E-8), C(1)]);
  CheckRoots('1e-100, 1e100', [C(1E-100), C(1E100)]);
  CheckRoots('1e-8, 1, 2', [C(1E-8), C(1), C(2)]);
  CheckRoots('1e-8, 1, 1e8', [C(1E-8), C(1), C(1E8)]);
  CheckRoots('1e-6, 1e-3, 1', [C(1E-6), C(1E-3), C(1)]);
  CheckRoots('1e-60, 1, 1e60', [C(1E-60), C(1), C(1E60)]);
  CheckRoots('1e-9, 1e-3, 1e3, 1e9', [C(1E-9), C(1E-3), C(1E3), C(1E9)]);
  CheckRoots('1e-8, 1, 2, 3', [C(1E-8), C(1), C(2), C(3)]);
  CheckRoots('1e-12, 1, 2, 3', [C(1E-12), C(1), C(2), C(3)]);
  CheckRoots('1e5, 1e-5, i, -i', [C(1E5), C(1E-5), C(0, 1), C(0, -1)]);
  CheckRoots('complex 1e-7(1+i), 1, 2i', [C(1E-7, 1E-7), C(1), C(0, 2)]);

  Group('Roots at a tiny or huge common scale', ckAccuracy, ProjectThreshold,
    tsProject, 'error / condition-based perturbation radius');
  CheckRoots('1,2,3 x 1e-8', [C(1E-8), C(2E-8), C(3E-8)]);
  CheckRoots('1..4 x 1e-8', [C(1E-8), C(2E-8), C(3E-8), C(4E-8)]);
  CheckRoots('1,2,3 x 1e-90', [C(1E-90), C(2E-90), C(3E-90)]);
  CheckRoots('1..4 x 1e70', [C(1E70), C(2E70), C(3E70), C(4E70)]);
  CheckRoots('i, -i, 2i x 1e-100', [C(0, 1E-100), C(0, -1E-100), C(0, 2E-100)]);

  Group('Exact zero roots', ckAccuracy, ProjectThreshold, tsProject,
    'error relative to the largest root modulus');
  CheckRoots('0, 1', [C(0), C(1)]);
  CheckRoots('0, 1, 2', [C(0), C(1), C(2)]);
  CheckRoots('0, 0, 1', [C(0), C(0), C(1)]);
  CheckRoots('0, i, -i, 3', [C(0), C(0, 1), C(0, -1), C(3)]);

  Group('Multiple roots (multiplicity-aware radius)', ckAccuracy,
    ProjectThreshold, tsProject, 'radius (eps*S/|t_m|)^(1/m)');
  CheckRoots('1, 1', [C(1), C(1)]);
  CheckRoots('1, 1, 2', [C(1), C(1), C(2)]);
  CheckRoots('1, 1, 1', [C(1), C(1), C(1)]);
  CheckRoots('1, 1, 1, 1', [C(1), C(1), C(1), C(1)]);
  CheckRoots('2, 2, -1, -1', [C(2), C(2), C(-1), C(-1)]);
  CheckRoots('1+i, 1+i, 2', [C(1, 1), C(1, 1), C(2)]);
  CheckRoots('3, 3, 3, -1', [C(3), C(3), C(3), C(-1)]);
  CheckRoots('1e-8, 1e-8, 1', [C(1E-8), C(1E-8), C(1)]);
  CheckRoots('5e-9 triple', [C(5E-9), C(5E-9), C(5E-9)]);

  Group('Clustered roots', ckAccuracy, ProjectThreshold, tsProject,
    'error / condition-based perturbation radius');
  CheckRoots('1, 1+1e-6', [C(1), C(1 + 1E-6)]);
  CheckRoots('1, 1+1e-8, 2', [C(1), C(1 + 1E-8), C(2)]);
  CheckRoots('1, 1+1e-5, 1+2e-5', [C(1), C(1 + 1E-5), C(1 + 2E-5)]);
  CheckRoots('cluster of 4 near 1', [C(1), C(1 + 1E-4), C(1, 1E-4), C(1 - 1E-4)]);
end;

procedure ScalingProperty;
var
  K, N, I, E: Integer;
  LCoefficients, LScaled: TArrayOfComplex;
  LRoots, LScaledRoots: TArrayOfComplex;
  LFactor, LPower: Double;
  LExponentIndex: Integer;
const
  Exponents: array[0..3] of Integer = (-200, -7, 9, 200);
begin
  { Multiplying the variable by 2^e scales every root by 2^e exactly when
    the algorithm is invariant under power-of-two scaling. }
  Group('Exact equivariance under x -> 2^e x', ckExact);
  SetSeed(411);
  for N := 2 to 4 do
    for K := 1 to 30 do
    begin
      SetLength(LCoefficients, N);
      for I := 0 to N - 1 do LCoefficients[I] := RandomComplex;
      LRoots := Solve(LCoefficients);
      for LExponentIndex := Low(Exponents) to High(Exponents) do
      begin
        E := Exponents[LExponentIndex];
        LFactor := Ldexp(1, E);
        SetLength(LScaled, N);
        LPower := 1;
        for I := 0 to N - 1 do
        begin
          LPower := LPower * LFactor;
          LScaled[I] := LCoefficients[I] * LPower;
        end;
        LScaledRoots := Solve(LScaled);
        for I := 0 to N - 1 do
          CheckEqual(Format('n=%d #%d e=%d root %d', [N, K, E, I]),
            LScaledRoots[I], LRoots[I] * LFactor);
      end;
    end;
end;

procedure Run;
begin
  Guard(@ContractChecks);
  Guard(@GeneratedCases);
  Guard(@StructuredCases);
  Guard(@ScalingProperty);
end;

initialization
  RegisterSpec('Polynomial equations (SolveEquation)', @Run);
end.
