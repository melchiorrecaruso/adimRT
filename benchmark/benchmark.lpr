program benchmark;

{$H+}{$J-}
{$modeswitch typehelpers}
{$modeswitch advancedrecords}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function's return value.
{$MACRO ON}

uses
  ADimPas, ADim, DateUtils, Sysutils;

var
  A1: double;
  B1: double;
  C1: double;

  A2: TQuantity;
  B2: TQuantity;
  C2: TQuantity;

  A3: TNewtons;
  B3: TSquareMeters;
  C3: TPascals;

  Start: TDateTime;
  i: longint;

begin
  Start := Now;
  for i := 0 to 100000000 do
  begin
    A1 := 10;
    B1 :=  2;
    C1 := A1/B1;
    A1 := B1*C1;
  end;
  writeln(MillisecondsBetween(Now, Start));

  Start := Now;
  for i := 0 to 100000000 do
  begin
    A2 := 10*ADim.N;
    B2 :=  2*ADim.m2;
    C2 := A2/B2;
    A2 := B2*C2;
  end;
  writeln('ADim = ', MillisecondsBetween(Now, start));

  Start := Now;
  for i := 0 to 100000000 do
  begin
    A3 := 10*ADimPas.N;
    B3 :=  2*ADimPas.m2;
    C3 := A3/B3;
    A3 := B3*C3;
  end;
  writeln('ADimPas = ', MillisecondsBetween(Now, start));
end.

