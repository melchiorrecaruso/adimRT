{ TestRunner - Specification-based test runner for the ADimMath suite.

  A specification (spec) groups the checks of one area of the public API.
  Inside a spec, checks are organised in groups; every group declares the
  kind of property it verifies and, for numerical ratios, the acceptance
  threshold together with its source:

    tsProved   a published error bound for the algorithm in use;
    tsLAPACK   the threshold used by the corresponding LAPACK test program;
    tsProject  a threshold defined by this project (documented in
               tests/TESTING.md), used where no external reference exists.

  Command line:
    -v            print every check
    --extended    larger orders and stress inputs
    --perf        also run timing-based performance checks
    --filter=TEXT run only specs whose name contains TEXT
    --list        list specs and exit

  The exit code is 0 when every check passes, 1 when a check fails and 2
  for an unknown option. }
unit TestRunner;

{$mode objfpc}{$H+}{$J-}
{$modeswitch nestedprocvars}

interface

uses
  SysUtils, Math, ADimMath;

type
  TCheckKind = (ckContract, ckExact, ckAccuracy, ckStability, ckProperty,
    ckPerformance);

  TThresholdSource = (tsNone, tsProved, tsLAPACK, tsProject);

  TSpecProc = procedure;
  TNestedProc = procedure is nested;

{ Registers a specification; called from the initialization section of the
  spec units, in the order in which the units appear in the program. }
procedure RegisterSpec(const AName: string; AProc: TSpecProc);

{ Opens a group of checks inside the running spec, or reopens the group
  of the same name. AThreshold applies to CheckRatio: a ratio passes when
  it is finite and below the threshold. }
procedure Group(const AName: string; AKind: TCheckKind); overload;
procedure Group(const AName: string; AKind: TCheckKind; AThreshold: Double;
  ASource: TThresholdSource; const AReference: string); overload;

procedure Check(const ALabel: string; ACondition: Boolean);
{ Exact numeric equality (+0 = -0); two NaNs compare equal. }
procedure CheckEqual(const ALabel: string; AActual, AExpected: Double); overload;
procedure CheckEqual(const ALabel: string; const AActual, AExpected: TComplex); overload;
procedure CheckEqual(const ALabel: string; AActual, AExpected: Int64); overload;
procedure CheckEqual(const ALabel, AActual, AExpected: string); overload;
{ Passes when AProc raises an exception of class AClass or a descendant. }
procedure CheckRaises(const ALabel: string; AClass: ExceptClass;
  AProc: TNestedProc);
{ Passes when AProc completes without raising. }
procedure CheckNoRaise(const ALabel: string; AProc: TNestedProc);
procedure CheckRatio(const ALabel: string; ARatio: Double);

{ Runs one section of a spec; an exception escaping it is recorded as a
  failure of the current group and the spec continues with the next
  section. }
procedure Guard(AProc: TSpecProc);

function ExtendedMode: Boolean;
function PerfMode: Boolean;

{ Runs the registered specs, prints the report and sets ExitCode. }
procedure RunAll;

implementation

type
  TGroupRecord = record
    Spec, Name, Reference: string;
    Kind: TCheckKind;
    Source: TThresholdSource;
    Threshold, Worst: Double;
    WorstLabel: string;
    Checks, Failures: Integer;
    FailureLines: array of string;
  end;

  TSpecRecord = record
    Name: string;
    Proc: TSpecProc;
  end;

const
  KindNames: array[TCheckKind] of string = (
    'CONTRACT', 'EXACT', 'ACCURACY', 'STABILITY', 'PROPERTY', 'PERFORMANCE');
  SourceNames: array[TThresholdSource] of string = (
    '', 'proved bound', 'LAPACK', 'project');
  MaxFailureLines = 8;

var
  Specs: array of TSpecRecord;
  Groups: array of TGroupRecord;
  CurrentSpec: string;
  CurrentGroup: Integer = -1;
  OptVerbose, OptExtended, OptPerf, OptList: Boolean;
  OptFilter: string;

procedure RegisterSpec(const AName: string; AProc: TSpecProc);
begin
  SetLength(Specs, Length(Specs) + 1);
  Specs[High(Specs)].Name := AName;
  Specs[High(Specs)].Proc := AProc;
end;

procedure Group(const AName: string; AKind: TCheckKind);
begin
  Group(AName, AKind, 0, tsNone, '');
end;

procedure Group(const AName: string; AKind: TCheckKind; AThreshold: Double;
  ASource: TThresholdSource; const AReference: string);
var
  LIndex: Integer;
begin
  { Reopen a group of the running spec that has the same name. }
  for LIndex := 0 to High(Groups) do
    if (Groups[LIndex].Spec = CurrentSpec) and (Groups[LIndex].Name = AName) then
    begin
      CurrentGroup := LIndex;
      Exit;
    end;
  SetLength(Groups, Length(Groups) + 1);
  CurrentGroup := High(Groups);
  with Groups[CurrentGroup] do
  begin
    Spec := CurrentSpec;
    Name := AName;
    Kind := AKind;
    Threshold := AThreshold;
    Source := ASource;
    Reference := AReference;
    Worst := 0;
    WorstLabel := '';
    Checks := 0;
    Failures := 0;
    FailureLines := nil;
  end;
  if OptVerbose then
    WriteLn('  -- ', KindNames[AKind], ': ', AName);
end;

procedure RequireGroup;
begin
  if CurrentGroup < 0 then
    Group('(ungrouped)', ckContract);
end;

procedure Record_(const ALabel: string; APassed: Boolean; const ADetail: string);
begin
  RequireGroup;
  with Groups[CurrentGroup] do
  begin
    Inc(Checks);
    if not APassed then
    begin
      Inc(Failures);
      if Length(FailureLines) < MaxFailureLines then
      begin
        SetLength(FailureLines, Length(FailureLines) + 1);
        FailureLines[High(FailureLines)] := ALabel + ADetail;
      end;
    end;
  end;
  if OptVerbose then
    if APassed then
      WriteLn('     pass  ', ALabel, ADetail)
    else
      WriteLn('     FAIL  ', ALabel, ADetail);
end;

procedure Check(const ALabel: string; ACondition: Boolean);
begin
  Record_(ALabel, ACondition, '');
end;

{ Numeric equality (so +0 = -0) where two NaNs also compare equal. }
function SameNumber(A, B: Double): Boolean;
begin
  result := (A = B) or (IsNan(A) and IsNan(B));
end;

function ComplexText(const AValue: TComplex): string;
begin
  result := Format('%.17g', [AValue.Re]);
  if (AValue.Im >= 0) or IsNan(AValue.Im) then result := result + '+';
  result := result + Format('%.17gi', [AValue.Im]);
end;

procedure CheckEqual(const ALabel: string; AActual, AExpected: Double);
begin
  Record_(ALabel, SameNumber(AActual, AExpected),
    Format('  [got %.17g, expected %.17g]', [AActual, AExpected]));
end;

procedure CheckEqual(const ALabel: string; const AActual, AExpected: TComplex);
begin
  Record_(ALabel, SameNumber(AActual.Re, AExpected.Re) and
    SameNumber(AActual.Im, AExpected.Im),
    Format('  [got %s, expected %s]', [ComplexText(AActual), ComplexText(AExpected)]));
end;

procedure CheckEqual(const ALabel: string; AActual, AExpected: Int64);
begin
  Record_(ALabel, AActual = AExpected,
    Format('  [got %d, expected %d]', [AActual, AExpected]));
end;

procedure CheckEqual(const ALabel, AActual, AExpected: string);
begin
  Record_(ALabel, AActual = AExpected,
    Format('  [got "%s", expected "%s"]', [AActual, AExpected]));
end;

procedure CheckRaises(const ALabel: string; AClass: ExceptClass;
  AProc: TNestedProc);
var
  LDetail: string;
  LPassed: Boolean;
begin
  LPassed := False;
  LDetail := '  [no exception]';
  try
    AProc();
  except
    on E: Exception do
    begin
      LPassed := E is AClass;
      if not LPassed then
        LDetail := Format('  [raised %s, expected %s]',
          [E.ClassName, AClass.ClassName]);
    end;
  end;
  if LPassed then LDetail := '';
  Record_(ALabel, LPassed, LDetail);
end;

procedure CheckNoRaise(const ALabel: string; AProc: TNestedProc);
begin
  try
    AProc();
    Record_(ALabel, True, '');
  except
    on E: Exception do
      Record_(ALabel, False, Format('  [raised %s: %s]',
        [E.ClassName, E.Message]));
  end;
end;

procedure CheckRatio(const ALabel: string; ARatio: Double);
var
  LPassed: Boolean;
begin
  RequireGroup;
  with Groups[CurrentGroup] do
  begin
    LPassed := (not IsNan(ARatio)) and (not IsInfinite(ARatio)) and
      (ARatio < Threshold);
    { A NaN ratio is kept as the worst value once seen. }
    if (not IsNan(Worst)) and (IsNan(ARatio) or (ARatio > Worst)) then
    begin
      Worst := ARatio;
      WorstLabel := ALabel;
    end;
  end;
  Record_(ALabel, LPassed, Format('  [ratio %.3g]', [ARatio]));
end;

function ExtendedMode: Boolean;
begin
  result := OptExtended;
end;

function PerfMode: Boolean;
begin
  result := OptPerf;
end;

procedure ParseOptions;
var
  LIndex: Integer;
  LArg: string;
begin
  for LIndex := 1 to ParamCount do
  begin
    LArg := ParamStr(LIndex);
    if LArg = '-v' then OptVerbose := True
    else if LArg = '--extended' then OptExtended := True
    else if LArg = '--perf' then OptPerf := True
    else if LArg = '--list' then OptList := True
    else if Copy(LArg, 1, 9) = '--filter=' then
      OptFilter := LowerCase(Copy(LArg, 10, MaxInt))
    else
    begin
      WriteLn('Unknown option: ', LArg);
      Halt(2);
    end;
  end;
end;

function ThresholdText(const AGroup: TGroupRecord): string;
begin
  if AGroup.Source = tsNone then Exit('');
  result := Format('< %.4g (%s', [AGroup.Threshold, SourceNames[AGroup.Source]]);
  if AGroup.Reference <> '' then
    result := result + ': ' + AGroup.Reference;
  result := result + ')';
end;

procedure PrintReport;
var
  LIndex, LLine: Integer;
  LSpec, LStatus, LWorst: string;
  LTotalChecks, LTotalFailures, LFailedGroups: Integer;
  LKindChecks, LKindFailures: array[TCheckKind] of Integer;
  LKind: TCheckKind;
begin
  LTotalChecks := 0;
  LTotalFailures := 0;
  LFailedGroups := 0;
  for LKind := Low(TCheckKind) to High(TCheckKind) do
  begin
    LKindChecks[LKind] := 0;
    LKindFailures[LKind] := 0;
  end;
  LSpec := '';
  WriteLn;
  for LIndex := 0 to High(Groups) do
    with Groups[LIndex] do
    begin
      if Spec <> LSpec then
      begin
        LSpec := Spec;
        WriteLn;
        WriteLn('== ', Spec, ' ==');
      end;
      Inc(LTotalChecks, Checks);
      Inc(LTotalFailures, Failures);
      Inc(LKindChecks[Kind], Checks);
      Inc(LKindFailures[Kind], Failures);
      if Failures = 0 then LStatus := 'PASS'
      else
      begin
        LStatus := Format('FAIL %d', [Failures]);
        Inc(LFailedGroups);
      end;
      if Source <> tsNone then
        LWorst := Format('  worst %.3g %s', [Worst, ThresholdText(Groups[LIndex])])
      else
        LWorst := '';
      WriteLn(Format('  %-6s [%s] %s  (%d checks)%s',
        [LStatus, KindNames[Kind], Name, Checks, LWorst]));
      for LLine := 0 to High(FailureLines) do
        WriteLn('           ', FailureLines[LLine]);
      if Failures > Length(FailureLines) then
        WriteLn(Format('           ... %d more', [Failures - Length(FailureLines)]));
    end;
  WriteLn;
  WriteLn('-------------------------------------------------------------------');
  for LKind := Low(TCheckKind) to High(TCheckKind) do
    if LKindChecks[LKind] > 0 then
      WriteLn(Format('  %-12s checks %7d   failures %d',
        [KindNames[LKind], LKindChecks[LKind], LKindFailures[LKind]]));
  WriteLn(Format('  TOTAL        checks %7d   failures %d   failed groups %d of %d',
    [LTotalChecks, LTotalFailures, LFailedGroups, Length(Groups)]));
  WriteLn('-------------------------------------------------------------------');
  if LTotalFailures = 0 then
    WriteLn('RESULT: PASS')
  else
    WriteLn('RESULT: FAIL');
end;

{ Source locations of the frames of the current exception (needs -gl). }
function ExceptionTrace: string;
var
  LFrames: PCodePointer;
  LIndex: Integer;
begin
  result := Trim(BackTraceStrFunc(ExceptAddr));
  LFrames := ExceptFrames;
  for LIndex := 0 to Min(ExceptFrameCount, 4) - 1 do
    result := result + ' <- ' + Trim(BackTraceStrFunc(LFrames[LIndex]));
end;

procedure Guard(AProc: TSpecProc);
begin
  try
    AProc();
  except
    on E: Exception do
      Record_('section aborted', False,
        Format('  [%s: %s at %s]', [E.ClassName, E.Message, ExceptionTrace]));
  end;
end;

procedure RunAll;
var
  LIndex: Integer;
begin
  ParseOptions;
  {$ifdef CPUI386}
  { The double-double oracle needs binary64 rounding of every operation. }
  SetPrecisionMode(pmDouble);
  {$endif}
  if OptList then
  begin
    for LIndex := 0 to High(Specs) do WriteLn(Specs[LIndex].Name);
    Exit;
  end;
  WriteLn('ADimMath validation suite');
  WriteLn(Format('  target %s-%s, FPC %s, SizeOf(Extended)=%d%s%s',
    [{$I %FPCTARGETCPU%}, {$I %FPCTARGETOS%}, {$I %FPCVERSION%},
     SizeOf(Extended), BoolToStr(OptExtended, ', extended', ''),
     BoolToStr(OptPerf, ', performance', '')]));
  for LIndex := 0 to High(Specs) do
  begin
    if (OptFilter <> '') and
       (Pos(OptFilter, LowerCase(Specs[LIndex].Name)) = 0) then Continue;
    CurrentSpec := Specs[LIndex].Name;
    CurrentGroup := -1;
    if OptVerbose then WriteLn('== ', CurrentSpec);
    try
      Specs[LIndex].Proc();
    except
      on E: Exception do
      begin
        Group('unexpected exception', ckContract);
        Record_('spec aborted', False,
          Format('  [%s: %s at %s]', [E.ClassName, E.Message, ExceptionTrace]));
      end;
    end;
  end;
  PrintReport;
  { The exit code is set rather than calling Halt, so that managed locals
    are finalized (Halt here would show up as a leak under heaptrc). }
  ExitCode := 0;
  for LIndex := 0 to High(Groups) do
    if Groups[LIndex].Failures > 0 then ExitCode := 1;
end;

end.
