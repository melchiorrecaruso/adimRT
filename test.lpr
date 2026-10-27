{ Test - Validation suite for ADimMath.

  Each Spec* unit registers its specification during initialization; the
  specs run in the order of the uses clause. See docs/TESTING.md for the
  validation policy, the acceptance thresholds and their sources.

  Build from the repository root with Lazarus (test.lpi: range, overflow
  and stack checks plus heaptrc) or with Free Pascal 3.2.2 or later:
    lazbuild test.lpi
    fpc -Mobjfpc -O2 -Fu. -Futests -FEbuild test.lpr
  Run:
    build/test [-v] [--extended] [--perf] [--filter=TEXT] }
program Test;

{$mode objfpc}{$H+}{$J-}

uses
  TestRunner,
  SpecComplex,
  SpecRoots,
  SpecPolynomials,
  SpecVectors,
  SpecMatrices,
  SpecLinear,
  SpecEigenSymmetric,
  SpecEigenGeneral,
  SpecEigenTridiagonal,
  SpecPerformance;

begin
  RunAll;
end.
