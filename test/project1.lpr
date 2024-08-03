program project1;

{$H+}{$J-}
{$modeswitch typehelpers}
{$modeswitch advancedrecords}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function's return value.
{$MACRO ON}

uses
  ADim, DateUtils, Sysutils;

type
  TUnitOfMeasurement = (uScalar = 0, uMeter, uSquareMeter, uNewton, uPascal);

  {$IFOPT D+}
  TQuantity = record
  private
    FValue: double;
    FUnitOfMeasurement: array[1..9] of double;
  public
    class operator Copy(constref ASrc: TQuantity; var ADst: TQuantity);
    class operator :=(const AValue: double): TQuantity;

    class operator +(const ALeft, ARight: TQuantity): TQuantity;
    class operator -(const ALeft, ARight: TQuantity): TQuantity;
    class operator *(const ALeft, ARight: TQuantity): TQuantity;
    class operator /(const ALeft, ARight: TQuantity): TQuantity;

    property Value: double read FValue;
  end;
  {$ELSE}
  TQuantity = double;
  {$ENDIF}

  TNewtons      = record class operator *(const AValue: double; const ASelf: TNewtons): TQuantity; inline; end;
  TSquareMeters = record class operator *(const AValue: double; const ASelf: TSquareMeters): TQuantity; inline; end;
  TPascals      = record class operator *(const AValue: double; const ASelf: TPascals): TQuantity; inline; end;

const
  DivTable : array[uScalar..uPascal, uScalar..uPascal] of TUnitOfMeasurement = (
    (uScalar, uScalar, uScalar, uScalar, uScalar),
    (uScalar, uScalar, uScalar, uScalar, uScalar),
    (uScalar, uScalar, uScalar, uScalar, uScalar),
    (uScalar, uScalar, uPascal, uScalar, uScalar),
    (uScalar, uScalar, uScalar, uScalar, uScalar));

  MulTable : array[uScalar..uPascal, uScalar..uPascal] of TUnitOfMeasurement = (
    (uScalar, uScalar, uScalar, uScalar, uScalar),
    (uScalar, uScalar, uScalar, uScalar, uScalar),
    (uScalar, uScalar, uScalar, uScalar, uScalar),
    (uScalar, uScalar, uPascal, uScalar, uScalar),
    (uScalar, uScalar, uScalar, uScalar, uScalar));


procedure Init(var AQuantity: TQuantity; const AUnitOfMeasurement: TUnitOfMeasurement);
begin
  {$IFOPT D+}
  AQuantity.FUnitOfMeasurement[1] := 0.0;
  AQuantity.FUnitOfMeasurement[2] := 0.0;
  AQuantity.FUnitOfMeasurement[3] := 0.0;
  AQuantity.FUnitOfMeasurement[4] := 0.0;
  AQuantity.FUnitOfMeasurement[5] := 0.0;
  AQuantity.FUnitOfMeasurement[6] := 0.0;
  AQuantity.FUnitOfMeasurement[7] := 0.0;
  AQuantity.FUnitOfMeasurement[8] := 0.0;
  AQuantity.FUnitOfMeasurement[9] := 0.0;
  AQuantity.FValue := 0;
  {$ELSE}
  AQuantity := 0;
  {$ENDIF}
end;

{$IFOPT D+}
class operator TQuantity.+(const ALeft, ARight: TQuantity): TQuantity;
begin
  //if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
  //  raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement[1] := ALeft.FUnitOfMeasurement[1];
  result.FUnitOfMeasurement[2] := ALeft.FUnitOfMeasurement[2];
  result.FUnitOfMeasurement[3] := ALeft.FUnitOfMeasurement[3];
  result.FUnitOfMeasurement[4] := ALeft.FUnitOfMeasurement[4];
  result.FUnitOfMeasurement[5] := ALeft.FUnitOfMeasurement[5];
  result.FUnitOfMeasurement[6] := ALeft.FUnitOfMeasurement[6];
  result.FUnitOfMeasurement[7] := ALeft.FUnitOfMeasurement[7];
  result.FUnitOfMeasurement[8] := ALeft.FUnitOfMeasurement[8];
  result.FUnitOfMeasurement[9] := ALeft.FUnitOfMeasurement[9];

  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.-(const ALeft, ARight: TQuantity): TQuantity;
begin
  //if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
  //  raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement[1] := ALeft.FUnitOfMeasurement[1];
  result.FUnitOfMeasurement[2] := ALeft.FUnitOfMeasurement[2];
  result.FUnitOfMeasurement[3] := ALeft.FUnitOfMeasurement[3];
  result.FUnitOfMeasurement[4] := ALeft.FUnitOfMeasurement[4];
  result.FUnitOfMeasurement[5] := ALeft.FUnitOfMeasurement[5];
  result.FUnitOfMeasurement[6] := ALeft.FUnitOfMeasurement[6];
  result.FUnitOfMeasurement[7] := ALeft.FUnitOfMeasurement[7];
  result.FUnitOfMeasurement[8] := ALeft.FUnitOfMeasurement[8];
  result.FUnitOfMeasurement[9] := ALeft.FUnitOfMeasurement[9];

  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.*(const ALeft, ARight: TQuantity): TQuantity;
begin
  // result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];

  result.FUnitOfMeasurement[1] := ALeft.FUnitOfMeasurement[1] + ARight.FUnitOfMeasurement[1];
  result.FUnitOfMeasurement[2] := ALeft.FUnitOfMeasurement[2] + ARight.FUnitOfMeasurement[2];
  result.FUnitOfMeasurement[3] := ALeft.FUnitOfMeasurement[3] + ARight.FUnitOfMeasurement[3];
  result.FUnitOfMeasurement[4] := ALeft.FUnitOfMeasurement[4] + ARight.FUnitOfMeasurement[4];
  result.FUnitOfMeasurement[5] := ALeft.FUnitOfMeasurement[5] + ARight.FUnitOfMeasurement[5];
  result.FUnitOfMeasurement[6] := ALeft.FUnitOfMeasurement[6] + ARight.FUnitOfMeasurement[6];
  result.FUnitOfMeasurement[7] := ALeft.FUnitOfMeasurement[7] + ARight.FUnitOfMeasurement[7];
  result.FUnitOfMeasurement[8] := ALeft.FUnitOfMeasurement[8] + ARight.FUnitOfMeasurement[8];
  result.FUnitOfMeasurement[9] := ALeft.FUnitOfMeasurement[9] + ARight.FUnitOfMeasurement[9];

  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft, ARight: TQuantity): TQuantity;
begin
  // result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];

  result.FUnitOfMeasurement[1] := ALeft.FUnitOfMeasurement[1] - ARight.FUnitOfMeasurement[1];
  result.FUnitOfMeasurement[2] := ALeft.FUnitOfMeasurement[2] - ARight.FUnitOfMeasurement[2];
  result.FUnitOfMeasurement[3] := ALeft.FUnitOfMeasurement[3] - ARight.FUnitOfMeasurement[3];
  result.FUnitOfMeasurement[4] := ALeft.FUnitOfMeasurement[4] - ARight.FUnitOfMeasurement[4];
  result.FUnitOfMeasurement[5] := ALeft.FUnitOfMeasurement[5] - ARight.FUnitOfMeasurement[5];
  result.FUnitOfMeasurement[6] := ALeft.FUnitOfMeasurement[6] - ARight.FUnitOfMeasurement[6];
  result.FUnitOfMeasurement[7] := ALeft.FUnitOfMeasurement[7] - ARight.FUnitOfMeasurement[7];
  result.FUnitOfMeasurement[8] := ALeft.FUnitOfMeasurement[8] - ARight.FUnitOfMeasurement[8];
  result.FUnitOfMeasurement[9] := ALeft.FUnitOfMeasurement[9] - ARight.FUnitOfMeasurement[9];

  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity.Copy(constref ASrc: TQuantity; var ADst: TQuantity);
begin
  //if ASrc.FUnitOfMeasurement <> ADst.FUnitOfMeasurement then
  //  raise Exception.Create('Assignment operator (:=) has detected wrong unit of measurements.');

  ADst.FValue := ASrc.FValue;
end;

class operator TQuantity.:=(const AValue: double): TQuantity;
begin
  result.FValue := AValue;
end;

function ToString(const AUnitOfMeasurement: TUnitOfMeasurement; const AQuantity: TQuantity): string;
begin
  //if AUnitOfMeasurement <> AQuantity.FUnitOfMeasurement then
  //  raise Exception.Create('ToString function has detected wrong unit of measurements.');

  result := AQuantity.FValue.ToString + ' [' + Ord(AUnitOfMeasurement).ToString + ']';
end;
{$ENDIF}

class operator TNewtons.*(const AValue: double; const ASelf: TNewtons): TQuantity;
begin
  {$IFOPT D+}
  result.FValue := AValue;
  result.FUnitOfMeasurement[1] :=  1.0;
  result.FUnitOfMeasurement[2] :=  1.0;
  result.FUnitOfMeasurement[3] := -2.0;
  result.FUnitOfMeasurement[4] :=  0.0;
  result.FUnitOfMeasurement[5] :=  0.0;
  result.FUnitOfMeasurement[6] :=  0.0;
  result.FUnitOfMeasurement[7] :=  0.0;
  result.FUnitOfMeasurement[8] :=  0.0;
  result.FUnitOfMeasurement[9] :=  0.0;
  {$ELSE}
  result := AValue;
  {$ENDIF}
end;

class operator TSquareMeters.*(const AValue: double; const ASelf: TSquareMeters): TQuantity;
begin
  {$IFOPT D+}
  result.FValue := AValue;
  result.FUnitOfMeasurement[1] :=  0.0;
  result.FUnitOfMeasurement[2] :=  2.0;
  result.FUnitOfMeasurement[3] :=  0.0;
  result.FUnitOfMeasurement[4] :=  0.0;
  result.FUnitOfMeasurement[5] :=  0.0;
  result.FUnitOfMeasurement[6] :=  0.0;
  result.FUnitOfMeasurement[7] :=  0.0;
  result.FUnitOfMeasurement[8] :=  0.0;
  result.FUnitOfMeasurement[9] :=  0.0;
  {$ELSE}
  result := AValue;
  {$ENDIF}
end;

class operator TPascals.*(const AValue: double; const ASelf: TPascals): TQuantity;
begin
  {$IFOPT D+}
  result.FValue := AValue;
  result.FUnitOfMeasurement[1] :=  1.0;
  result.FUnitOfMeasurement[2] := -1.0;
  result.FUnitOfMeasurement[3] := -2.0;
  result.FUnitOfMeasurement[4] :=  0.0;
  result.FUnitOfMeasurement[5] :=  0.0;
  result.FUnitOfMeasurement[6] :=  0.0;
  result.FUnitOfMeasurement[7] :=  0.0;
  result.FUnitOfMeasurement[8] :=  0.0;
  result.FUnitOfMeasurement[9] :=  0.0;
  {$ELSE}
  result := AValue;
  {$ENDIF}
end;

var
  A1: double;
  B1: double;
  C1: double;

  A2: TQuantity;
  B2: TQuantity;
  C2: TQuantity;

  N: TNewtons;
  mm2: TSquareMeters;
  Pa: TPascals;

  A3: ADim.TNewtons;
  B3: ADim.TSquareMeters;
  C3: ADim.TPascals;

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

  Init(A2, uNewton);
  Init(B2, uSquareMeter);
  Init(C2, uPascal);

  Start := Now;
  for i := 0 to 100000000 do
  begin
    A2 := 10*N;
    B2 :=  2*mm2;
    C2 := A2/B2;
    A2 := B2*C2;
  end;
  writeln(MillisecondsBetween(Now, start));

  Start := Now;
  for i := 0 to 100000000 do
  begin
    A3 := 10*ADim.N;
    B3 :=  2*ADim.m2;
    C3 := A3/B3;
    A3 := B3*C3;
  end;
  writeln(MillisecondsBetween(Now, start));

end.

