{ SpecPerformance - Complexity and relative-cost checks (run with --perf).

  Wall-clock times depend on the machine, so two machine-independent
  quantities are checked instead:

  1. Complexity: T(2n) / T(n). An O(n^3) algorithm gives about 8; the
     limit 12 rejects O(n^4) behaviour (16) while tolerating timing noise.
     Linear-time algorithms are checked against 3.

  2. Relative cost: T(operation, n) / T(reference, n), where the reference
     is a plain triple-loop real matrix product on arrays of Double of the
     same order, timed in the same run. The budgets are project-defined:
     about three times the ratio measured for the current implementation,
     so that constant-factor regressions (a redundant dense product,
     strided inner loops, a slow complex kernel) are detected.

  Each time is the median of three runs of enough repetitions to last at
  least 40 ms. Orders are 64 and 128: smaller operands fit in the L1 cache
  and make T(2n)/T(n) overstate the growth. }
unit SpecPerformance;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}
{$modeswitch nestedprocvars}

interface

implementation

uses
  SysUtils, Math, ADimMath, TestRunner, TestGenerators, TestMeasures;

type
  TTimedProc = procedure is nested;

var
  RealA, RealB, RealP, RealV: TRealMatrix;
  ComplexA, ComplexB, ComplexP, ComplexV: TComplexMatrix;
  RealD: TRealVector;
  ComplexD: TComplexVector;
  RealX, RealBVector: TRealVector;
  TriD, TriE, TriValues: TRealVector;
  TriVectors: TArrayOfRealVector;

{ Median of three timings, in seconds per call. }
function TimePerCall(AProc: TTimedProc): Double;
var
  LTimes: array[0..2] of Double;
  LRun, LCount, LIndex: Integer;
  LStart, LElapsed: QWord;
  LSwap: Double;
begin
  LCount := 1;
  repeat
    LStart := GetTickCount64;
    for LIndex := 1 to LCount do AProc();
    LElapsed := GetTickCount64 - LStart;
    if LElapsed < 40 then LCount := LCount * 2;
  until LElapsed >= 40;
  for LRun := 0 to 2 do
  begin
    LStart := GetTickCount64;
    for LIndex := 1 to LCount do AProc();
    LTimes[LRun] := (GetTickCount64 - LStart) / 1000 / LCount;
  end;
  if LTimes[0] > LTimes[1] then
  begin
    LSwap := LTimes[0]; LTimes[0] := LTimes[1]; LTimes[1] := LSwap;
  end;
  if LTimes[1] > LTimes[2] then LTimes[1] := LTimes[2];
  if LTimes[0] > LTimes[1] then LTimes[1] := LTimes[0];
  result := Max(LTimes[1], 1E-9);
end;

function ReferenceTime(N: Integer): Double;
var
  LA, LB, LC: array of Double;
  I: Integer;

  procedure Kernel;
  var
    R, C, K: Integer;
    LSum: Double;
  begin
    for R := 0 to N - 1 do
      for C := 0 to N - 1 do
      begin
        LSum := 0;
        for K := 0 to N - 1 do LSum := LSum + LA[R * N + K] * LB[K * N + C];
        LC[R * N + C] := LSum;
      end;
  end;

begin
  SetLength(LA, N * N);
  SetLength(LB, N * N);
  SetLength(LC, N * N);
  for I := 0 to N * N - 1 do
  begin
    LA[I] := RandomUniform;
    LB[I] := RandomUniform;
  end;
  result := TimePerCall(@Kernel);
end;

procedure Prepare(N: Integer);
var
  I: Integer;
begin
  SetSeed(1101 + N);
  RealA := RandomRealMatrix(N);
  RealB := RandomRealMatrix(N);
  ComplexA := RandomComplexMatrix(N);
  ComplexB := RandomComplexMatrix(N);
  RealX := RandomRealVector(N);
  RealBVector := RandomRealVector(N);
  RealP := RealA + RealA.Transpose;
  ComplexP := ComplexA + ComplexA.TransposeConjugate;
  TriD := NewRealVector(N * 50);
  TriE := NewRealVector(N * 50 - 1);
  for I := 0 to N * 50 - 1 do TriD[I] := 2 + 0.1 * RandomUniform;
  for I := 0 to N * 50 - 2 do TriE[I] := -1;
end;

procedure RealProduct; begin RealV := RealA * RealB; end;
procedure ComplexProduct; begin ComplexV := ComplexA * ComplexB; end;
procedure Solve; begin RealX := RealA.SolveLinear(RealBVector); end;
procedure Invert; begin RealV := RealA.Inverse; end;
procedure Symmetric; begin RealP.SymmetricEigenpairs(RealD, RealV); end;
procedure Hermitian; begin ComplexP.HermitianEigenpairs(RealD, ComplexV); end;
procedure General; begin ComplexA.Eigenpairs(ComplexD, ComplexV); end;
procedure Tridiagonal; begin TridiagonalLowestEigenpairs(TriD, TriE, 10, TriValues, TriVectors); end;

type
  TOperation = record
    Name: string;
    Proc: TTimedProc;
    Budget: Double;     { relative-cost budget }
    Cubic: Boolean;     { complexity class: O(n^3) or O(n) }
  end;

procedure Run;
const
  { 64 -> 128 stays in one memory-hierarchy regime on common CPUs; below
    64 the operands fit in L1 and T(2n)/T(n) overstates the growth. }
  N = 128;
var
  LOperations: array[0..7] of TOperation;
  LIndex: Integer;
  LReference, LSmall, LLarge: Double;
begin
  if not PerfMode then Exit;
  LOperations[0].Name := 'real matrix product'; LOperations[0].Proc := @RealProduct;
  LOperations[0].Budget := 9; LOperations[0].Cubic := True;
  LOperations[1].Name := 'complex matrix product'; LOperations[1].Proc := @ComplexProduct;
  LOperations[1].Budget := 30; LOperations[1].Cubic := True;
  LOperations[2].Name := 'SolveLinear'; LOperations[2].Proc := @Solve;
  LOperations[2].Budget := 1.5; LOperations[2].Cubic := True;
  LOperations[3].Name := 'Inverse'; LOperations[3].Proc := @Invert;
  LOperations[3].Budget := 8; LOperations[3].Cubic := True;
  LOperations[4].Name := 'SymmetricEigenpairs'; LOperations[4].Proc := @Symmetric;
  LOperations[4].Budget := 24; LOperations[4].Cubic := True;
  LOperations[5].Name := 'HermitianEigenpairs'; LOperations[5].Proc := @Hermitian;
  LOperations[5].Budget := 60; LOperations[5].Cubic := True;
  LOperations[6].Name := 'Eigenpairs (general)'; LOperations[6].Proc := @General;
  LOperations[6].Budget := 225; LOperations[6].Cubic := True;
  LOperations[7].Name := 'TridiagonalLowestEigenpairs (50n, k=10)';
  LOperations[7].Proc := @Tridiagonal; LOperations[7].Budget := 36;
  LOperations[7].Cubic := False;

  Prepare(N);
  LReference := ReferenceTime(N);
  for LIndex := Low(LOperations) to High(LOperations) do
  begin
    Group('Relative cost against a plain triple-loop product', ckPerformance,
      1, tsProject, 'time / reference time / budget');
    LSmall := TimePerCall(LOperations[LIndex].Proc);
    CheckRatio(Format('%s n=%d (ratio %.2f, budget %g)', [LOperations[LIndex].Name,
      N, LSmall / LReference, LOperations[LIndex].Budget]),
      LSmall / LReference / LOperations[LIndex].Budget);
  end;

  for LIndex := Low(LOperations) to High(LOperations) do
  begin
    Prepare(N div 2);
    LSmall := TimePerCall(LOperations[LIndex].Proc);
    Prepare(N);
    LLarge := TimePerCall(LOperations[LIndex].Proc);
    if LOperations[LIndex].Cubic then
    begin
      Group('Complexity O(n^3): T(2n)/T(n)', ckPerformance, 12, tsProject,
        '8 expected, 16 for O(n^4)');
      CheckRatio(Format('%s n=%d->%d', [LOperations[LIndex].Name, N div 2, N]),
        LLarge / LSmall);
    end else
    begin
      Group('Complexity O(n): T(2n)/T(n)', ckPerformance, 3, tsProject,
        '2 expected');
      CheckRatio(Format('%s n=%d->%d', [LOperations[LIndex].Name, 50 * (N div 2),
        50 * N]), LLarge / LSmall);
    end;
  end;
end;

initialization
  RegisterSpec('Performance (complexity and relative cost)', @Run);
end.
