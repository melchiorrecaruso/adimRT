{ TestFramework.pas - Common test infrastructure for the ADimMath test suite.

  This unit provides:
    * A correctness layer (PASS/FAIL):  Check, CheckNear, CheckCplxNear, Section.
    * A numpy-alignment layer (max-error tracking per category):
        BeginCategory + CmpR / CmpC / CmpRAbs / CmpRRel / CmpCRel.
    * Shared helpers:  C (complex constructor), SortAscArray, the EPS constant.
    * A self-registration mechanism so each structure-specific test unit can
      add itself to the run with a single line in its initialization section:

          initialization
            RegisterSuite('Real matrix', @Run);

  The main program only needs to list the test units in its uses clause and
  call RunAllSuites; every registered suite runs automatically and contributes
  to the combined correctness summary and alignment report.

  ADDING NEW TESTS
    * New case for an existing structure -> edit that structure's test unit.
    * New structure -> create a new unit that registers a Run procedure, then
      add it to the main program's uses clause. Nothing else changes.

  Pass -v (or --verbose) on the command line to print every individual PASS
  line and section header; by default only failures and summaries are shown.

  @author  Melchiorre Caruso
}
unit TestFramework;

{$mode objfpc}{$H+}{$J-}
{$modeswitch advancedrecords}
{$modeswitch typehelpers}

interface

uses
  ADimMath;

const
  EPS = 1e-8;   // default tolerance for correctness comparisons

type
  TTestProc = procedure;

{ --- suite registration / execution --- }
procedure RegisterSuite(const AName: string; AProc: TTestProc);
procedure RunAllSuites;

{ --- shared helpers --- }
function  C(ARe, AIm: double): TComplex;
procedure SortAscArray(var A: TArrayOfDouble);

{ --- correctness layer (PASS/FAIL) --- }
procedure Check(const AName: string; AOk: boolean);
procedure CheckNear(const AName: string; AActual, AExpected, ATol: double);
procedure CheckCplxNear(const AName: string; AActual, AExpected: TComplex; ATol: double);
procedure Section(const ATitle: string);

{ --- numpy-alignment layer (max-error tracking) --- }
procedure BeginCategory(const AName: string);
procedure Track(AErr: double);
procedure TrackTol(AErr, ATol: double);
procedure CmpR(const ALabel: string; AGot, AExpected: double);
procedure CmpC(const ALabel: string; AGot: TComplex; ARe, AIm: double);
procedure CmpRAbs(const ALabel: string; AGot, AExpected, ATol: double);
procedure CmpRRel(const ALabel: string; AGot, AExpected, ATol: double);
procedure CmpCRel(const ALabel: string; AGot: TComplex; ARe, AIm, ATol: double);

implementation

uses
  Math, SysUtils, StrUtils;

type
  TCategory = record
    Name:   string;
    MaxErr: double;
    Count:  integer;
    Fails:  integer;
  end;

  TSuite = record
    Name: string;
    Proc: TTestProc;
  end;

var
  GTotalPass, GTotalFail: integer;
  GVerbose: boolean = False;
  GCats:    array of TCategory;
  GCur:     integer = -1;
  GTolPass: double  = 1e-9;        // "aligned to numpy" threshold
  GSuites:  array of TSuite;

// -- suite registration ---------------------------------------------------------

procedure RegisterSuite(const AName: string; AProc: TTestProc);
begin
  SetLength(GSuites, Length(GSuites) + 1);
  GSuites[High(GSuites)].Name := AName;
  GSuites[High(GSuites)].Proc := AProc;
end;

// -- shared helpers --------------------------------------------------------------

function C(ARe, AIm: double): TComplex;
begin
  result := Complex(ARe, AIm);
end;

procedure SortAscArray(var A: TArrayOfDouble);
var
  i, j: integer;
  t:    double;
begin
  for i := 0 to High(A) - 1 do
    for j := i + 1 to High(A) do
      if A[i] > A[j] then
      begin
        t := A[i]; A[i] := A[j]; A[j] := t;
      end;
end;

// -- correctness layer ---------------------------------------------------------

procedure Check(const AName: string; AOk: boolean);
begin
  if AOk then
  begin
    if GVerbose then WriteLn('  PASS  ', AName);
    Inc(GTotalPass);
  end else
  begin
    WriteLn('  FAIL  ', AName);
    Inc(GTotalFail);
  end;
end;

procedure CheckNear(const AName: string; AActual, AExpected, ATol: double);
begin
  Check(AName + Format(' (got %.10g, exp %.10g)', [AActual, AExpected]),
        Math.SameValue(AActual, AExpected, ATol));
end;

procedure CheckCplxNear(const AName: string; AActual, AExpected: TComplex;
                        ATol: double);
begin
  Check(AName,
        Math.SameValue(AActual.Re, AExpected.Re, ATol) and
        Math.SameValue(AActual.Im, AExpected.Im, ATol));
end;

procedure Section(const ATitle: string);
begin
  if not GVerbose then Exit;
  WriteLn;
  WriteLn('-- ', ATitle, ' --');
end;

// -- numpy-alignment layer -------------------------------------------------------

procedure BeginCategory(const AName: string);
begin
  SetLength(GCats, Length(GCats) + 1);
  GCur := High(GCats);
  GCats[GCur].Name   := AName;
  GCats[GCur].MaxErr := 0;
  GCats[GCur].Count  := 0;
  GCats[GCur].Fails  := 0;
end;

procedure Track(AErr: double);
begin
  Inc(GCats[GCur].Count);
  if AErr > GCats[GCur].MaxErr then GCats[GCur].MaxErr := AErr;
  if AErr > GTolPass then Inc(GCats[GCur].Fails);
end;

procedure TrackTol(AErr, ATol: double);
begin
  Inc(GCats[GCur].Count);
  if AErr > GCats[GCur].MaxErr then GCats[GCur].MaxErr := AErr;
  if AErr > ATol then Inc(GCats[GCur].Fails);
end;

procedure CmpR(const ALabel: string; AGot, AExpected: double);
var
  e: double;
begin
  e := Abs(AGot - AExpected);
  Track(e);
  if e > GTolPass then
    WriteLn(Format('    DEV  %-28s got %.17g  exp %.17g  |err|=%.3e',
                   [ALabel, AGot, AExpected, e]));
end;

procedure CmpC(const ALabel: string; AGot: TComplex; ARe, AIm: double);
var
  e: double;
begin
  e := Sqrt(Sqr(AGot.Re - ARe) + Sqr(AGot.Im - AIm));
  Track(e);
  if e > GTolPass then
    WriteLn(Format('    DEV  %-28s got (%.15g,%.15g)  exp (%.15g,%.15g)  |err|=%.3e',
                   [ALabel, AGot.Re, AGot.Im, ARe, AIm, e]));
end;

procedure CmpRAbs(const ALabel: string; AGot, AExpected, ATol: double);
var
  e: double;
begin
  e := Abs(AGot - AExpected);
  TrackTol(e, ATol);
  if e > ATol then
    WriteLn(Format('    DEV  %-28s got %.17g  exp %.17g  |err|=%.3e',
                   [ALabel, AGot, AExpected, e]));
end;

procedure CmpRRel(const ALabel: string; AGot, AExpected, ATol: double);
var
  e: double;
begin
  e := Abs(AGot - AExpected) / (1 + Abs(AExpected));
  TrackTol(e, ATol);
  if e > ATol then
    WriteLn(Format('    DEV  %-28s got %.17g  exp %.17g  rel=%.3e',
                   [ALabel, AGot, AExpected, e]));
end;

procedure CmpCRel(const ALabel: string; AGot: TComplex; ARe, AIm, ATol: double);
var
  e, m: double;
begin
  m := Sqrt(Sqr(ARe) + Sqr(AIm));
  e := Sqrt(Sqr(AGot.Re - ARe) + Sqr(AGot.Im - AIm)) / (1 + m);
  TrackTol(e, ATol);
  if e > ATol then
    WriteLn(Format('    DEV  %-28s got (%.15g,%.15g)  exp (%.15g,%.15g)  rel=%.3e',
                   [ALabel, AGot.Re, AGot.Im, ARe, AIm, e]));
end;

// -- runner & report ----------------------------------------------------------

procedure RunAllSuites;
var
  i, dev, totChecks: integer;
  worst: double;
begin
  GVerbose := FindCmdLineSwitch('v', ['-', '/'], True) or
              FindCmdLineSwitch('verbose', ['-', '/'], True);

  GTotalPass := 0;
  GTotalFail := 0;
  SetLength(GCats, 0);

  WriteLn('====================================================================');
  WriteLn('  ADimMath test suite  (', Length(GSuites), ' suites registered)');
  WriteLn('====================================================================');

  for i := 0 to High(GSuites) do
  begin
    if GVerbose then
    begin
      WriteLn;
      WriteLn('### ', GSuites[i].Name);
    end;
    GSuites[i].Proc();
  end;

  // ---- correctness summary ----
  WriteLn;
  WriteLn('-- correctness ----------------------------------------------------');
  WriteLn(Format('  PASS: %d   FAIL: %d   TOTAL: %d',
                 [GTotalPass, GTotalFail, GTotalPass + GTotalFail]));

  // ---- alignment table ----
  WriteLn;
  WriteLn('-- numpy alignment (tolerance ', Format('%.0e', [GTolPass]), ') -----------------------');
  WriteLn(Format('  %-44s %-12s %s', ['CATEGORY', 'MAX |err|', 'CHECKS']));
  dev := 0; totChecks := 0; worst := 0;
  for i := 0 to High(GCats) do
  begin
    WriteLn(Format('  %-44s %-12.3e %d%s',
      [GCats[i].Name, GCats[i].MaxErr, GCats[i].Count,
       IfThen(GCats[i].Fails > 0, Format('  (%d DEV)', [GCats[i].Fails]), '')]));
    Inc(dev, GCats[i].Fails);
    Inc(totChecks, GCats[i].Count);
    if GCats[i].MaxErr > worst then worst := GCats[i].MaxErr;
  end;
  WriteLn('-------------------------------------------------------------------');
  WriteLn(Format('  Alignment checks: %d   Deviations(>%.0e): %d   Worst |err|: %.3e',
                 [totChecks, GTolPass, dev, worst]));

  // ---- combined verdict ----
  WriteLn;
  WriteLn('====================================================================');
  if (GTotalFail = 0) and (dev = 0) then
    WriteLn('  RESULT: all correctness checks passed and all values aligned to NumPy.')
  else
    WriteLn(Format('  RESULT: %d correctness failure(s), %d numpy deviation(s).',
                   [GTotalFail, dev]));
  WriteLn('====================================================================');

  // Flush before any finalization so the full report is always visible.
  Flush(Output);
  ExitCode := GTotalFail + dev;
end;

end.
