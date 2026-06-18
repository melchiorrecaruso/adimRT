{ TestADimMath.pas - Main program of the modular ADimMath test suite.

  Each test unit listed below registers its own suite with TestFramework
  during initialization, so this program merely runs them all and prints
  the combined report.

  Build (Free Pascal 3.2.2):
    fpc -Mobjfpc -O2 TestADimMath.pas
    ./TestADimMath          (quiet: only failures + summary)
    ./TestADimMath -v       (verbose: every individual check)

  All units (ADimMath.pas, TestFramework.pas and the Test* units) must be
  in the same directory or on the unit search path.

  TO ADD A NEW STRUCTURE'S TESTS: create a unit that registers a Run
  procedure (see any Test* unit as a template) and add it to the uses
  clause below. No other change is required.

  @author  Melchiorre Caruso
}
program test;

{$mode objfpc}{$H+}{$J-}

uses
//Skeleton,
  TestFramework,
  TestComplexNumbers,
  TestRealMatrix,
  TestRealVector,
  TestComplexMatrix,
  TestComplexVector;

begin
  RunAllSuites;
end.
