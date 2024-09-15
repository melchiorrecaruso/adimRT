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
    FUnitOfMeasurement: TUnitOfMeasurement;
    FValue: double;
  public
    class operator Copy(constref ASrc: TQuantity; var ADst: TQuantity); inline;

    class operator +(const ALeft, ARight: TQuantity): TQuantity; inline;
    class operator -(const ALeft, ARight: TQuantity): TQuantity; inline;
    class operator *(const ALeft, ARight: TQuantity): TQuantity; inline;
    class operator /(const ALeft, ARight: TQuantity): TQuantity; inline;

    class operator *(const ALeft: double; const ARight: TQuantity): TQuantity; inline;
    class operator *(const ALeft: TQuantity; const ARight: double): TQuantity; inline;
    class operator /(const ALeft: TQuantity; const ARight: double): TQuantity; inline;
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
    (uScalar, uScalar, uScalar, uScalar, uNewton),
    (uScalar, uScalar, uScalar, uScalar, uScalar),
    (uScalar, uScalar, uNewton, uScalar, uScalar));


procedure Init(var AQuantity: TQuantity; const AUnitOfMeasurement: TUnitOfMeasurement);
begin
  {$IFOPT D+}
  AQuantity.FUnitOfMeasurement := AUnitOfMeasurement;
  AQuantity.FValue := 0;
  {$ELSE}
  AQuantity := 0;
  {$ENDIF}
end;

procedure RaiseException(const AMessage: string);
begin
  raise Exception.Create(AMessage);
end;


{$IFOPT D+}
class operator TQuantity.Copy(constref ASrc: TQuantity; var ADst: TQuantity); inline;
begin

end;

class operator TQuantity.+(const ALeft, ARight: TQuantity): TQuantity; inline;
begin

end;

class operator TQuantity.-(const ALeft, ARight: TQuantity): TQuantity; inline;
begin

end;

class operator TQuantity.*(const ALeft, ARight: TQuantity): TQuantity; inline;
begin

end;

class operator TQuantity./(const ALeft, ARight: TQuantity): TQuantity; inline;
begin

end;

class operator TQuantity.*(const ALeft: double; const ARight: TQuantity): TQuantity; inline;
begin

end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: double): TQuantity; inline;
begin

end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: double): TQuantity; inline;
begin

end;
{$ENDIF}

function PascalToString(const AQuantity: TQuantity): string; inline;
begin
  {$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> uPascal then
    RaiseException('ToString function has detected wrong unit of measurements.');
  {$ENDIF}
  result := AQuantity.FValue.ToString + ' [' + Ord(uPascal).ToString + ']';
end;

function PascalToFloat(const AQuantity: TQuantity): double; inline;
begin
  {$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> uPascal then
    RaiseException('ToFloat function has detected wrong unit of measurements.');
  {$ENDIF}
  result := AQuantity.FValue;
end;


class operator TNewtons.*(const AValue: double; const ASelf: TNewtons): TQuantity;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uNewton;
  result.FValue := AValue;
  {$ELSE}
  result := AValue;
  {$ENDIF}
end;

class operator TSquareMeters.*(const AValue: double; const ASelf: TSquareMeters): TQuantity;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uSquareMeter;
  result.FValue := AValue;
  {$ELSE}
  result := AValue;
  {$ENDIF}
end;

class operator TPascals.*(const AValue: double; const ASelf: TPascals): TQuantity;
begin
  {$IFOPT D+}
  result.FUnitOfMeasurement := uPascal;
  result.FValue := AValue;
  {$ELSE}
  result := AValue;
  {$ENDIF}
end;

const
  {$IFOPT D+}
  mm2 : TQuantity = (FUnitOfMeasurement: uSquareMeter; FValue: 1/100000);
  {$ELSE}
  mm2 : TQuantity = 1/100000;
 {$ENDIF}

var
  A1: double;
  B1: double;
  C1: double;

  A2: TQuantity;
  B2: TQuantity;
  C2: TQuantity;

  N: TNewtons;
  m2: TSquareMeters;
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
    B2 :=  2*m2;
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

