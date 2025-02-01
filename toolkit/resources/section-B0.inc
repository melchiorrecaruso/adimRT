
implementation

uses Math;

// Format routines

function Fmt(const AValue: double): string;
begin
  if AValue < 0.0 then
    result := FloatToStr(AValue)
  else
    result := '+' + FloatToStr(AValue);
end;

function Fmt(const AValue: double; APrecision, ADigits: longint): string;
begin
  if AValue < 0.0 then
    result := FloatToStrF(AValue, ffGeneral, APrecision, ADigits)
  else
    result := '+' + FloatToStrF(AValue, ffGeneral, APrecision, ADigits);
end;

// Check routines

procedure Check(ALeft, ARight: longint); inline;
begin
  if ALeft <> ARight then
    raise Exception.Create('FATAL ERROR: Check routine has detected wrong units of measurements.');
end;

function CheckEqual(ALeft, ARight: longint): longint; inline;
begin
  result := ALeft;
  if ALeft <> ARight then
    raise Exception.Create('FATAL ERROR: Check routine has detected wrong units of measurements.');
end;

function CheckSum(ALeft, ARight: longint): longint; inline;
begin
  result := ALeft;
  if ALeft <> ARight then
    raise Exception.Create('FATAL ERROR: Check routine has detected wrong units of measurements.');
end;

function CheckSub(ALeft, ARight: longint): longint; inline;
begin
  result := ALeft;
  if ALeft <> ARight then
    raise Exception.Create('FATAL ERROR: Check routine has detected wrong units of measurements.');
end;

function CheckMul(ALeft, ARight: longint): longint; inline;
begin
  result := ALeft + ARight;
end;

function CheckDiv(ALeft, ARight: longint): longint; inline;
begin
  result := ALeft - ARight;
end;

