{
  Description: ADimRT library.

  Copyright (C) 2024 Melchiorre Caruso <melchiorrecaruso@gmail.com>

  This library is free software: you can redistribute it and/or modify
  it under the terms of the GNU Lesser General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU Lesser General Public License
  along with this program. If not, see <http://www.gnu.org/licenses/>.
}

unit ADimRT;

{$H+}{$J-}
{$modeswitch typehelpers}
{$modeswitch advancedrecords}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function's return value.
{$MACRO ON}

{
  ADimRT library built on 27-10-24.

  Number of base units: 159
  Number of factored units: 121
  Number of operators: 0 (0 external, 0 internal)
}

interface

uses SysUtils;

type
  { Prefix }
  TPrefix = (pQuetta, pRonna, pYotta, pZetta, pExa, pPeta, pTera, pGiga, pMega, pKilo, pHecto, pDeca,
    pNone, pDeci, pCenti, pMilli, pMicro, pNano, pPico, pFemto, pAtto, pZepto, pYocto, pRonto, pQuecto);

  { Prefixes }
  TPrefixes = array of TPrefix;

  { Exponents }
  TExponents = array of longint;

  { TQuantity }

  {$IFOPT D+}
  TQuantity = record
  private
    FUnitOfMeasurement: longint;
    FValue: double;
  public
    class operator + (const ASelf: TQuantity): TQuantity;
    class operator - (const ASelf: TQuantity): TQuantity;
    class operator + (const ALeft, ARight: TQuantity): TQuantity;
    class operator - (const ALeft, ARight: TQuantity): TQuantity;
    class operator * (const ALeft, ARight: TQuantity): TQuantity;
    class operator / (const ALeft, ARight: TQuantity): TQuantity;
    class operator * (const ALeft: double; const ARight: TQuantity): TQuantity;
    class operator / (const ALeft: double; const ARight: TQuantity): TQuantity;
    class operator * (const ALeft: TQuantity; const ARight: double): TQuantity;
    class operator / (const ALeft: TQuantity; const ARight: double): TQuantity;

    class operator = (const ALeft, ARight: TQuantity): boolean;
    class operator < (const ALeft, ARight: TQuantity): boolean;
    class operator > (const ALeft, ARight: TQuantity): boolean;
    class operator <=(const ALeft, ARight: TQuantity): boolean;
    class operator >=(const ALeft, ARight: TQuantity): boolean;
    class operator <>(const ALeft, ARight: TQuantity): boolean;
    class operator :=(const ASelf: double): TQuantity;
    class operator :=(const ASelf: TQuantity): double;
  end;
  {$ELSE}
  TQuantity = double;
  {$ENDIF}

  { TUnit }

  generic TSymbol<U> = record
    type TSelf = specialize TSymbol<U>;
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  public
    function ToFloat(const AQuantity: TQuantity): double;
    function ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
    function ToString(const AQuantity: TQuantity): string;
    function ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TQuantity): string;
    function ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    class operator *(const AValue: double; const ASelf: TSelf): TQuantity; inline;
    class operator /(const AValue: double; const ASelf: TSelf): TQuantity; inline;
  {$IFOPT D+}
    class operator *(const AQuantity: TQuantity; const ASelf: TSelf): TQuantity; inline;
    class operator /(const AQuantity: TQuantity; const ASelf: TSelf): TQuantity; inline;
  {$ENDIF}
  end;

  { TFactoredSymbol }

  generic TFactoredSymbol<U> = record
    type TSelf = specialize TFactoredSymbol<U>;
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  public
    function ToFloat(const AQuantity: TQuantity): double;
    function ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
    function ToString(const AQuantity: TQuantity): string;
    function ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TQuantity): string;
    function ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    class operator *(const AValue: double; const ASelf: TSelf): TQuantity; inline;
    class operator /(const AValue: double; const ASelf: TSelf): TQuantity; inline;
  {$IFOPT D+}
    class operator *(const AQuantity: TQuantity; const ASelf: TSelf): TQuantity; inline;
    class operator /(const AQuantity: TQuantity; const ASelf: TSelf): TQuantity; inline;
  {$ENDIF}
  end;

{ TScalar }

const
  cScalar = 0;

type
  TScalarRec = record
    const FUnitOfMeasurement = cScalar;
    const FSymbol            = '';
    const FName              = '';
    const FPluralName        = '';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
  end;
  TScalarUnit = specialize TSymbol<TScalarRec>;
  TScalar = TQuantity;

var
  Scalar : TScalarUnit;
  ScalarUnit : TScalarUnit;

{ TRadian }

type
  TRadianRec = record
    const FUnitOfMeasurement = cScalar;
    const FSymbol            = 'rad';
    const FName              = 'radian';
    const FPluralName        = 'radians';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
  end;
  TRadianUnit = specialize TSymbol<TRadianRec>;
  TRadians = TQuantity;

var
  rad : TRadianUnit;
  RadianUnit : TRadianUnit;

{ TDegree }

type
  TDegreeRec = record
    const FUnitOfMeasurement = cScalar;
    const FSymbol            = 'deg';
    const FName              = 'degree';
    const FPluralName        = 'degrees';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TDegreeUnit = specialize TFactoredSymbol<TDegreeRec>;
  TDegrees = TQuantity;

const
  deg        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 0; FValue: Pi/180); {$ELSE} (Pi/180); {$ENDIF}

var
  DegreeUnit : TDegreeUnit;

{ TSteradian }

type
  TSteradianRec = record
    const FUnitOfMeasurement = cScalar;
    const FSymbol            = 'sr';
    const FName              = 'steradian';
    const FPluralName        = 'steradians';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
  end;
  TSteradianUnit = specialize TSymbol<TSteradianRec>;
  TSteradians = TQuantity;

var
  sr : TSteradianUnit;
  SteradianUnit : TSteradianUnit;

{ TSquareDegree }

type
  TSquareDegreeRec = record
    const FUnitOfMeasurement = cScalar;
    const FSymbol            = 'deg2';
    const FName              = 'square degree';
    const FPluralName        = 'square degrees';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TSquareDegreeUnit = specialize TFactoredSymbol<TSquareDegreeRec>;
  TSquareDegrees = TQuantity;

const
  deg2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 0; FValue: Pi*Pi/32400); {$ELSE} (Pi*Pi/32400); {$ENDIF}

var
  SquareDegreeUnit : TSquareDegreeUnit;

{ TSecond }

const
  cSecond = 1;

type
  TSecondRec = record
    const FUnitOfMeasurement = cSecond;
    const FSymbol            = '%ss';
    const FName              = '%ssecond';
    const FPluralName        = '%sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TSecondUnit = specialize TSymbol<TSecondRec>;
  TSeconds = TQuantity;

var
  s : TSecondUnit;
  SecondUnit : TSecondUnit;

const
  ds         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cs         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  ms         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  mis        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  ns         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  ps         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TDay }

type
  TDayRec = record
    const FUnitOfMeasurement = cSecond;
    const FSymbol            = 'd';
    const FName              = 'day';
    const FPluralName        = 'days';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TDayUnit = specialize TFactoredSymbol<TDayRec>;
  TDays = TQuantity;

const
  day        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 86400); {$ELSE} (86400); {$ENDIF}

var
  DayUnit : TDayUnit;

{ THour }

type
  THourRec = record
    const FUnitOfMeasurement = cSecond;
    const FSymbol            = 'h';
    const FName              = 'hour';
    const FPluralName        = 'hours';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  THourUnit = specialize TFactoredSymbol<THourRec>;
  THours = TQuantity;

const
  hr         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 3600); {$ELSE} (3600); {$ENDIF}

var
  HourUnit : THourUnit;

{ TMinute }

type
  TMinuteRec = record
    const FUnitOfMeasurement = cSecond;
    const FSymbol            = 'min';
    const FName              = 'minute';
    const FPluralName        = 'minutes';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TMinuteUnit = specialize TFactoredSymbol<TMinuteRec>;
  TMinutes = TQuantity;

const
  minute     : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 60); {$ELSE} (60); {$ENDIF}

var
  MinuteUnit : TMinuteUnit;

{ TSquareSecond }

const
  cSquareSecond = 2;

type
  TSquareSecondRec = record
    const FUnitOfMeasurement = cSquareSecond;
    const FSymbol            = '%ss2';
    const FName              = 'square %ssecond';
    const FPluralName        = 'square %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareSecondUnit = specialize TSymbol<TSquareSecondRec>;
  TSquareSeconds = TQuantity;

var
  s2 : TSquareSecondUnit;
  SquareSecondUnit : TSquareSecondUnit;

const
  ds2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cs2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  ms2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mis2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  ns2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ps2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareDay }

type
  TSquareDayRec = record
    const FUnitOfMeasurement = cSquareSecond;
    const FSymbol            = 'd2';
    const FName              = 'square day';
    const FPluralName        = 'square days';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TSquareDayUnit = specialize TFactoredSymbol<TSquareDayRec>;
  TSquareDays = TQuantity;

const
  day2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 7464960000); {$ELSE} (7464960000); {$ENDIF}

var
  SquareDayUnit : TSquareDayUnit;

{ TSquareHour }

type
  TSquareHourRec = record
    const FUnitOfMeasurement = cSquareSecond;
    const FSymbol            = 'h2';
    const FName              = 'square hour';
    const FPluralName        = 'square hours';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TSquareHourUnit = specialize TFactoredSymbol<TSquareHourRec>;
  TSquareHours = TQuantity;

const
  hr2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 12960000); {$ELSE} (12960000); {$ENDIF}

var
  SquareHourUnit : TSquareHourUnit;

{ TSquareMinute }

type
  TSquareMinuteRec = record
    const FUnitOfMeasurement = cSquareSecond;
    const FSymbol            = 'min2';
    const FName              = 'square minute';
    const FPluralName        = 'square minutes';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TSquareMinuteUnit = specialize TFactoredSymbol<TSquareMinuteRec>;
  TSquareMinutes = TQuantity;

const
  minute2    : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 3600); {$ELSE} (3600); {$ENDIF}

var
  SquareMinuteUnit : TSquareMinuteUnit;

{ TCubicSecond }

const
  cCubicSecond = 3;

type
  TCubicSecondRec = record
    const FUnitOfMeasurement = cCubicSecond;
    const FSymbol            = '%ss3';
    const FName              = 'cubic %ssecond';
    const FPluralName        = 'cubic %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (3);
  end;
  TCubicSecondUnit = specialize TSymbol<TCubicSecondRec>;
  TCubicSeconds = TQuantity;

var
  s3 : TCubicSecondUnit;
  CubicSecondUnit : TCubicSecondUnit;

const
  ds3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 3; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  cs3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 3; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  ms3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 3; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  mis3       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 3; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ns3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 3; FValue: 1E-27); {$ELSE} (1E-27); {$ENDIF}
  ps3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 3; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}

{ TQuarticSecond }

const
  cQuarticSecond = 4;

type
  TQuarticSecondRec = record
    const FUnitOfMeasurement = cQuarticSecond;
    const FSymbol            = '%ss4';
    const FName              = 'quartic %ssecond';
    const FPluralName        = 'quartic %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (4);
  end;
  TQuarticSecondUnit = specialize TSymbol<TQuarticSecondRec>;
  TQuarticSeconds = TQuantity;

var
  s4 : TQuarticSecondUnit;
  QuarticSecondUnit : TQuarticSecondUnit;

const
  ds4        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 4; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cs4        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 4; FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  ms4        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 4; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mis4       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 4; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  ns4        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 4; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  ps4        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 4; FValue: 1E-48); {$ELSE} (1E-48); {$ENDIF}

{ TQuinticSecond }

const
  cQuinticSecond = 5;

type
  TQuinticSecondRec = record
    const FUnitOfMeasurement = cQuinticSecond;
    const FSymbol            = '%ss5';
    const FName              = 'quintic %ssecond';
    const FPluralName        = 'quintic %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (5);
  end;
  TQuinticSecondUnit = specialize TSymbol<TQuinticSecondRec>;
  TQuinticSeconds = TQuantity;

var
  s5 : TQuinticSecondUnit;
  QuinticSecondUnit : TQuinticSecondUnit;

const
  ds5        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 5; FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  cs5        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 5; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  ms5        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 5; FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}
  mis5       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 5; FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}
  ns5        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 5; FValue: 1E-45); {$ELSE} (1E-45); {$ENDIF}
  ps5        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 5; FValue: 1E-60); {$ELSE} (1E-60); {$ENDIF}

{ TSexticSecond }

const
  cSexticSecond = 6;

type
  TSexticSecondRec = record
    const FUnitOfMeasurement = cSexticSecond;
    const FSymbol            = '%ss6';
    const FName              = 'sextic %ssecond';
    const FPluralName        = 'sextic %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (6);
  end;
  TSexticSecondUnit = specialize TSymbol<TSexticSecondRec>;
  TSexticSeconds = TQuantity;

var
  s6 : TSexticSecondUnit;
  SexticSecondUnit : TSexticSecondUnit;

const
  ds6        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 6; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  cs6        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 6; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  ms6        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 6; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  mis6       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 6; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  ns6        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 6; FValue: 1E-54); {$ELSE} (1E-54); {$ENDIF}
  ps6        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 6; FValue: 1E-72); {$ELSE} (1E-72); {$ENDIF}

{ TMeter }

const
  cMeter = 7;

type
  TMeterRec = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = '%sm';
    const FName              = '%smeter';
    const FPluralName        = '%smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TMeterUnit = specialize TSymbol<TMeterRec>;
  TMeters = TQuantity;

var
  m : TMeterUnit;
  MeterUnit : TMeterUnit;

const
  km         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  dm         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cm         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mm         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  mim        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nm         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pm         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TAstronomical }

type
  TAstronomicalRec = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = 'au';
    const FName              = 'astronomical unit';
    const FPluralName        = 'astronomical units';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TAstronomicalUnit = specialize TFactoredSymbol<TAstronomicalRec>;
  TAstronomical = TQuantity;

const
  au         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 149597870691); {$ELSE} (149597870691); {$ENDIF}

var
  AstronomicalUnit : TAstronomicalUnit;

{ TInch }

type
  TInchRec = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = 'in';
    const FName              = 'inch';
    const FPluralName        = 'inches';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TInchUnit = specialize TFactoredSymbol<TInchRec>;
  TInches = TQuantity;

const
  inch       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 0.0254); {$ELSE} (0.0254); {$ENDIF}

var
  InchUnit : TInchUnit;

{ TFoot }

type
  TFootRec = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = 'ft';
    const FName              = 'foot';
    const FPluralName        = 'feet';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TFootUnit = specialize TFactoredSymbol<TFootRec>;
  TFeet = TQuantity;

const
  ft         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 0.3048); {$ELSE} (0.3048); {$ENDIF}

var
  FootUnit : TFootUnit;

{ TYard }

type
  TYardRec = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = 'yd';
    const FName              = 'yard';
    const FPluralName        = 'yards';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TYardUnit = specialize TFactoredSymbol<TYardRec>;
  TYards = TQuantity;

const
  yd         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 0.9144); {$ELSE} (0.9144); {$ENDIF}

var
  YardUnit : TYardUnit;

{ TMile }

type
  TMileRec = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = 'mi';
    const FName              = 'mile';
    const FPluralName        = 'miles';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TMileUnit = specialize TFactoredSymbol<TMileRec>;
  TMiles = TQuantity;

const
  mi         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 1609.344); {$ELSE} (1609.344); {$ENDIF}

var
  MileUnit : TMileUnit;

{ TNauticalMile }

type
  TNauticalMileRec = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = 'nmi';
    const FName              = 'nautical mile';
    const FPluralName        = 'nautical miles';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TNauticalMileUnit = specialize TFactoredSymbol<TNauticalMileRec>;
  TNauticalMiles = TQuantity;

const
  nmi        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 1852); {$ELSE} (1852); {$ENDIF}

var
  NauticalMileUnit : TNauticalMileUnit;

{ TAngstrom }

type
  TAngstromRec = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = '%sÅ';
    const FName              = '%sangstrom';
    const FPluralName        = '%sangstroms';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TAngstromUnit = specialize TFactoredSymbol<TAngstromRec>;
  TAngstroms = TQuantity;

const
  angstrom   : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}

var
  AngstromUnit : TAngstromUnit;

{ TSquareRootMeter }

const
  cSquareRootMeter = 8;

type
  TSquareRootMeterRec = record
    const FUnitOfMeasurement = cSquareRootMeter;
    const FSymbol            = '√%sm';
    const FName              = 'square root %smeter';
    const FPluralName        = 'square root %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TSquareRootMeterUnit = specialize TSymbol<TSquareRootMeterRec>;
  TSquareRootMeters = TQuantity;

var
  SquareRootMeter : TSquareRootMeterUnit;
  SquareRootMeterUnit : TSquareRootMeterUnit;

{ TSquareMeter }

const
  cSquareMeter = 9;

type
  TSquareMeterRec = record
    const FUnitOfMeasurement = cSquareMeter;
    const FSymbol            = '%sm2';
    const FName              = 'square %smeter';
    const FPluralName        = 'square %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareMeterUnit = specialize TSymbol<TSquareMeterRec>;
  TSquareMeters = TQuantity;

var
  m2 : TSquareMeterUnit;
  SquareMeterUnit : TSquareMeterUnit;

const
  km2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  dm2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cm2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mm2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mim2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nm2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  pm2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareInch }

type
  TSquareInchRec = record
    const FUnitOfMeasurement = cSquareMeter;
    const FSymbol            = 'in2';
    const FName              = 'square inch';
    const FPluralName        = 'square inches';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TSquareInchUnit = specialize TFactoredSymbol<TSquareInchRec>;
  TSquareInches = TQuantity;

const
  inch2      : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 0.00064516); {$ELSE} (0.00064516); {$ENDIF}

var
  SquareInchUnit : TSquareInchUnit;

{ TSquareFoot }

type
  TSquareFootRec = record
    const FUnitOfMeasurement = cSquareMeter;
    const FSymbol            = 'ft2';
    const FName              = 'square foot';
    const FPluralName        = 'square feet';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TSquareFootUnit = specialize TFactoredSymbol<TSquareFootRec>;
  TSquareFeet = TQuantity;

const
  ft2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 0.09290304); {$ELSE} (0.09290304); {$ENDIF}

var
  SquareFootUnit : TSquareFootUnit;

{ TSquareYard }

type
  TSquareYardRec = record
    const FUnitOfMeasurement = cSquareMeter;
    const FSymbol            = 'yd2';
    const FName              = 'square yard';
    const FPluralName        = 'square yards';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TSquareYardUnit = specialize TFactoredSymbol<TSquareYardRec>;
  TSquareYards = TQuantity;

const
  yd2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 0.83612736); {$ELSE} (0.83612736); {$ENDIF}

var
  SquareYardUnit : TSquareYardUnit;

{ TSquareMile }

type
  TSquareMileRec = record
    const FUnitOfMeasurement = cSquareMeter;
    const FSymbol            = 'mi2';
    const FName              = 'square mile';
    const FPluralName        = 'square miles';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TSquareMileUnit = specialize TFactoredSymbol<TSquareMileRec>;
  TSquareMiles = TQuantity;

const
  mi2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 2589988.110336); {$ELSE} (2589988.110336); {$ENDIF}

var
  SquareMileUnit : TSquareMileUnit;

{ TCubicMeter }

const
  cCubicMeter = 10;

type
  TCubicMeterRec = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = '%sm3';
    const FName              = 'cubic %smeter';
    const FPluralName        = 'cubic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (3);
  end;
  TCubicMeterUnit = specialize TSymbol<TCubicMeterRec>;
  TCubicMeters = TQuantity;

var
  m3 : TCubicMeterUnit;
  CubicMeterUnit : TCubicMeterUnit;

const
  km3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  dm3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  cm3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mm3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  mim3       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  nm3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E-27); {$ELSE} (1E-27); {$ENDIF}
  pm3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}

{ TCubicInch }

type
  TCubicInchRec = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = 'in3';
    const FName              = 'cubic inch';
    const FPluralName        = 'cubic inches';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TCubicInchUnit = specialize TFactoredSymbol<TCubicInchRec>;
  TCubicInches = TQuantity;

const
  inch3      : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 0.000016387064); {$ELSE} (0.000016387064); {$ENDIF}

var
  CubicInchUnit : TCubicInchUnit;

{ TCubicFoot }

type
  TCubicFootRec = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = 'ft3';
    const FName              = 'cubic foot';
    const FPluralName        = 'cubic feet';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TCubicFootUnit = specialize TFactoredSymbol<TCubicFootRec>;
  TCubicFeet = TQuantity;

const
  ft3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 0.028316846592); {$ELSE} (0.028316846592); {$ENDIF}

var
  CubicFootUnit : TCubicFootUnit;

{ TCubicYard }

type
  TCubicYardRec = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = 'yd3';
    const FName              = 'cubic yard';
    const FPluralName        = 'cubic yards';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TCubicYardUnit = specialize TFactoredSymbol<TCubicYardRec>;
  TCubicYards = TQuantity;

const
  yd3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 0.764554857984); {$ELSE} (0.764554857984); {$ENDIF}

var
  CubicYardUnit : TCubicYardUnit;

{ TLitre }

type
  TLitreRec = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = '%sL';
    const FName              = '%slitre';
    const FPluralName        = '%slitres';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TLitreUnit = specialize TFactoredSymbol<TLitreRec>;
  TLitres = TQuantity;

const
  L          : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

var
  LitreUnit : TLitreUnit;

const
  dL         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E-03 * 1E-01); {$ELSE} (1E-03 * 1E-01); {$ENDIF}
  cL         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E-03 * 1E-02); {$ELSE} (1E-03 * 1E-02); {$ENDIF}
  mL         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E-03 * 1E-03); {$ELSE} (1E-03 * 1E-03); {$ENDIF}

{ TGallon }

type
  TGallonRec = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = 'gal';
    const FName              = 'gallon';
    const FPluralName        = 'gallons';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TGallonUnit = specialize TFactoredSymbol<TGallonRec>;
  TGallons = TQuantity;

const
  gal        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 0.0037854119678); {$ELSE} (0.0037854119678); {$ENDIF}

var
  GallonUnit : TGallonUnit;

{ TQuarticMeter }

const
  cQuarticMeter = 11;

type
  TQuarticMeterRec = record
    const FUnitOfMeasurement = cQuarticMeter;
    const FSymbol            = '%sm4';
    const FName              = 'quartic %smeter';
    const FPluralName        = 'quartic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (4);
  end;
  TQuarticMeterUnit = specialize TSymbol<TQuarticMeterRec>;
  TQuarticMeters = TQuantity;

var
  m4 : TQuarticMeterUnit;
  QuarticMeterUnit : TQuarticMeterUnit;

const
  km4        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 11; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  dm4        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 11; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cm4        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 11; FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  mm4        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 11; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mim4       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 11; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  nm4        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 11; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  pm4        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 11; FValue: 1E-48); {$ELSE} (1E-48); {$ENDIF}

{ TQuinticMeter }

const
  cQuinticMeter = 12;

type
  TQuinticMeterRec = record
    const FUnitOfMeasurement = cQuinticMeter;
    const FSymbol            = '%sm5';
    const FName              = 'quintic %smeter';
    const FPluralName        = 'quintic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (5);
  end;
  TQuinticMeterUnit = specialize TSymbol<TQuinticMeterRec>;
  TQuinticMeters = TQuantity;

var
  m5 : TQuinticMeterUnit;
  QuinticMeterUnit : TQuinticMeterUnit;

const
  km5        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 12; FValue: 1E+15); {$ELSE} (1E+15); {$ENDIF}
  dm5        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 12; FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  cm5        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 12; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  mm5        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 12; FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}
  mim5       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 12; FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}
  nm5        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 12; FValue: 1E-45); {$ELSE} (1E-45); {$ENDIF}
  pm5        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 12; FValue: 1E-60); {$ELSE} (1E-60); {$ENDIF}

{ TSexticMeter }

const
  cSexticMeter = 13;

type
  TSexticMeterRec = record
    const FUnitOfMeasurement = cSexticMeter;
    const FSymbol            = '%sm6';
    const FName              = 'sextic %smeter';
    const FPluralName        = 'sextic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (6);
  end;
  TSexticMeterUnit = specialize TSymbol<TSexticMeterRec>;
  TSexticMeters = TQuantity;

var
  m6 : TSexticMeterUnit;
  SexticMeterUnit : TSexticMeterUnit;

const
  km6        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 13; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  dm6        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 13; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  cm6        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 13; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mm6        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 13; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  mim6       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 13; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  nm6        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 13; FValue: 1E-54); {$ELSE} (1E-54); {$ENDIF}
  pm6        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 13; FValue: 1E-72); {$ELSE} (1E-72); {$ENDIF}

{ TKilogram }

const
  cKilogram = 14;

type
  TKilogramRec = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = '%sg';
    const FName              = '%sgram';
    const FPluralName        = '%sgrams';
    const FPrefixes          : TPrefixes  = (pKilo);
    const FExponents         : TExponents = (1);
  end;
  TKilogramUnit = specialize TSymbol<TKilogramRec>;
  TKilograms = TQuantity;

var
  kg : TKilogramUnit;
  KilogramUnit : TKilogramUnit;

const
  hg         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  dag        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  g          : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  dg         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cg         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  mg         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mig        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  ng         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  pg         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}

{ TTonne }

type
  TTonneRec = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = '%st';
    const FName              = '%stonne';
    const FPluralName        = '%stonnes';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TTonneUnit = specialize TFactoredSymbol<TTonneRec>;
  TTonnes = TQuantity;

const
  tonne      : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

var
  TonneUnit : TTonneUnit;

const
  gigatonne  : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E+03 * 1E+09); {$ELSE} (1E+03 * 1E+09); {$ENDIF}
  megatonne  : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E+03 * 1E+06); {$ELSE} (1E+03 * 1E+06); {$ENDIF}
  kilotonne  : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E+03 * 1E+03); {$ELSE} (1E+03 * 1E+03); {$ENDIF}

{ TPound }

type
  TPoundRec = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = 'lb';
    const FName              = 'pound';
    const FPluralName        = 'pounds';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TPoundUnit = specialize TFactoredSymbol<TPoundRec>;
  TPounds = TQuantity;

const
  lb         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 0.45359237); {$ELSE} (0.45359237); {$ENDIF}

var
  PoundUnit : TPoundUnit;

{ TOunce }

type
  TOunceRec = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = 'oz';
    const FName              = 'ounce';
    const FPluralName        = 'ounces';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TOunceUnit = specialize TFactoredSymbol<TOunceRec>;
  TOunces = TQuantity;

const
  oz         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 0.028349523125); {$ELSE} (0.028349523125); {$ENDIF}

var
  OunceUnit : TOunceUnit;

{ TStone }

type
  TStoneRec = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = 'st';
    const FName              = 'stone';
    const FPluralName        = 'stones';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TStoneUnit = specialize TFactoredSymbol<TStoneRec>;
  TStones = TQuantity;

const
  st         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 6.35029318); {$ELSE} (6.35029318); {$ENDIF}

var
  StoneUnit : TStoneUnit;

{ TTon }

type
  TTonRec = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = 'ton';
    const FName              = 'ton';
    const FPluralName        = 'tons';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TTonUnit = specialize TFactoredSymbol<TTonRec>;
  TTons = TQuantity;

const
  ton        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 907.18474); {$ELSE} (907.18474); {$ENDIF}

var
  TonUnit : TTonUnit;

{ TElectronvoltPerSquareSpeedOfLight }

type
  TElectronvoltPerSquareSpeedOfLightRec = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = '%seV/c2';
    const FName              = '%selectronvolt per squared speed of light';
    const FPluralName        = '%selectronvolts per squared speed of light';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TElectronvoltPerSquareSpeedOfLightUnit = specialize TFactoredSymbol<TElectronvoltPerSquareSpeedOfLightRec>;
  TElectronvoltsPerSquareSpeedOfLight = TQuantity;

const
  ElectronvoltPerSquareSpeedOfLight : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1.7826619216279E-36); {$ELSE} (1.7826619216279E-36); {$ENDIF}

var
  ElectronvoltPerSquareSpeedOfLightUnit : TElectronvoltPerSquareSpeedOfLightUnit;

{ TSquareKilogram }

const
  cSquareKilogram = 15;

type
  TSquareKilogramRec = record
    const FUnitOfMeasurement = cSquareKilogram;
    const FSymbol            = '%sg2';
    const FName              = 'square %sgram';
    const FPluralName        = 'square %sgrams';
    const FPrefixes          : TPrefixes  = (pKilo);
    const FExponents         : TExponents = (2);
  end;
  TSquareKilogramUnit = specialize TSymbol<TSquareKilogramRec>;
  TSquareKilograms = TQuantity;

var
  kg2 : TSquareKilogramUnit;
  SquareKilogramUnit : TSquareKilogramUnit;

const
  hg2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 15; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  dag2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 15; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  g2         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 15; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  dg2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 15; FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  cg2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 15; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  mg2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 15; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mig2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 15; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ng2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 15; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  pg2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 15; FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}

{ TAmpere }

const
  cAmpere = 16;

type
  TAmpereRec = record
    const FUnitOfMeasurement = cAmpere;
    const FSymbol            = '%sA';
    const FName              = '%sampere';
    const FPluralName        = '%samperes';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TAmpereUnit = specialize TSymbol<TAmpereRec>;
  TAmperes = TQuantity;

var
  A : TAmpereUnit;
  AmpereUnit : TAmpereUnit;

const
  kA         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 16; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hA         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 16; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daA        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 16; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}
  dA         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 16; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cA         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 16; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mA         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 16; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miA        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 16; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nA         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 16; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  picoA      : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 16; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TSquareAmpere }

const
  cSquareAmpere = 17;

type
  TSquareAmpereRec = record
    const FUnitOfMeasurement = cSquareAmpere;
    const FSymbol            = '%sA2';
    const FName              = 'square %sampere';
    const FPluralName        = 'square %samperes';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareAmpereUnit = specialize TSymbol<TSquareAmpereRec>;
  TSquareAmperes = TQuantity;

var
  A2 : TSquareAmpereUnit;
  SquareAmpereUnit : TSquareAmpereUnit;

const
  kA2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 17; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hA2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 17; FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daA2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 17; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  dA2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 17; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cA2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 17; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mA2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 17; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  miA2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 17; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nA2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 17; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  picoA2     : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 17; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TKelvin }

const
  cKelvin = 18;

type
  TKelvinRec = record
    const FUnitOfMeasurement = cKelvin;
    const FSymbol            = '%sK';
    const FName              = '%skelvin';
    const FPluralName        = '%skelvins';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TKelvinUnit = specialize TSymbol<TKelvinRec>;
  TKelvins = TQuantity;

var
  K : TKelvinUnit;
  KelvinUnit : TKelvinUnit;

{ TDegreeCelsius }

type
  TDegreeCelsiusRec = record
    const FUnitOfMeasurement = cKelvin;
    const FSymbol            = 'ºC';
    const FName              = 'degree Celsius';
    const FPluralName        = 'degrees Celsius';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TDegreeCelsiusUnit = specialize TFactoredSymbol<TDegreeCelsiusRec>;
  TDegreesCelsius = TQuantity;

var
  degC : TDegreeCelsiusUnit;

{ TDegreeFahrenheit }

type
  TDegreeFahrenheitRec = record
    const FUnitOfMeasurement = cKelvin;
    const FSymbol            = 'ºF';
    const FName              = 'degree Fahrenheit';
    const FPluralName        = 'degrees Fahrenheit';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TDegreeFahrenheitUnit = specialize TFactoredSymbol<TDegreeFahrenheitRec>;
  TDegreesFahrenheit = TQuantity;

var
  degF : TDegreeFahrenheitUnit;

{ TSquareKelvin }

const
  cSquareKelvin = 19;

type
  TSquareKelvinRec = record
    const FUnitOfMeasurement = cSquareKelvin;
    const FSymbol            = '%sK2';
    const FName              = 'square %skelvin';
    const FPluralName        = 'square %skelvins';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareKelvinUnit = specialize TSymbol<TSquareKelvinRec>;
  TSquareKelvins = TQuantity;

var
  K2 : TSquareKelvinUnit;
  SquareKelvinUnit : TSquareKelvinUnit;

{ TCubicKelvin }

const
  cCubicKelvin = 20;

type
  TCubicKelvinRec = record
    const FUnitOfMeasurement = cCubicKelvin;
    const FSymbol            = '%sK3';
    const FName              = 'cubic %skelvin';
    const FPluralName        = 'cubic %skelvins';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (3);
  end;
  TCubicKelvinUnit = specialize TSymbol<TCubicKelvinRec>;
  TCubicKelvins = TQuantity;

var
  K3 : TCubicKelvinUnit;
  CubicKelvinUnit : TCubicKelvinUnit;

{ TQuarticKelvin }

const
  cQuarticKelvin = 21;

type
  TQuarticKelvinRec = record
    const FUnitOfMeasurement = cQuarticKelvin;
    const FSymbol            = '%sK4';
    const FName              = 'quartic %skelvin';
    const FPluralName        = 'quartic %skelvins';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (4);
  end;
  TQuarticKelvinUnit = specialize TSymbol<TQuarticKelvinRec>;
  TQuarticKelvins = TQuantity;

var
  K4 : TQuarticKelvinUnit;
  QuarticKelvinUnit : TQuarticKelvinUnit;

{ TMole }

const
  cMole = 22;

type
  TMoleRec = record
    const FUnitOfMeasurement = cMole;
    const FSymbol            = '%smol';
    const FName              = '%smole';
    const FPluralName        = '%smoles';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TMoleUnit = specialize TSymbol<TMoleRec>;
  TMoles = TQuantity;

var
  mol : TMoleUnit;
  MoleUnit : TMoleUnit;

const
  kmol       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 22; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hmol       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 22; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  damol      : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 22; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}

{ TCandela }

const
  cCandela = 23;

type
  TCandelaRec = record
    const FUnitOfMeasurement = cCandela;
    const FSymbol            = '%scd';
    const FName              = '%scandela';
    const FPluralName        = '%scandelas';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TCandelaUnit = specialize TSymbol<TCandelaRec>;
  TCandelas = TQuantity;

var
  cd : TCandelaUnit;
  CandelaUnit : TCandelaUnit;

{ THertz }

const
  cHertz = 24;

type
  THertzRec = record
    const FUnitOfMeasurement = cHertz;
    const FSymbol            = '%sHz';
    const FName              = '%shertz';
    const FPluralName        = '%shertz';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  THertzUnit = specialize TSymbol<THertzRec>;
  THertz = TQuantity;

var
  Hz : THertzUnit;
  HertzUnit : THertzUnit;

const
  THz        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GHz        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MHz        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kHz        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TReciprocalSecond }

type
  TReciprocalSecondRec = record
    const FUnitOfMeasurement = cHertz;
    const FSymbol            = '1/%ss';
    const FName              = 'reciprocal %ssecond';
    const FPluralName        = 'reciprocal %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalSecondUnit = specialize TSymbol<TReciprocalSecondRec>;
  TReciprocalSeconds = TQuantity;

var
  ReciprocalSecond : TReciprocalSecondUnit;
  ReciprocalSecondUnit : TReciprocalSecondUnit;

{ TRadianPerSecond }

type
  TRadianPerSecondRec = record
    const FUnitOfMeasurement = cHertz;
    const FSymbol            = 'rad/%ss';
    const FName              = 'radian per %ssecond';
    const FPluralName        = 'radians per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TRadianPerSecondUnit = specialize TSymbol<TRadianPerSecondRec>;
  TRadiansPerSecond = TQuantity;

var
  RadianPerSecond : TRadianPerSecondUnit;
  RadianPerSecondUnit : TRadianPerSecondUnit;

{ TSquareHertz }

const
  cSquareHertz = 25;

type
  TSquareHertzRec = record
    const FUnitOfMeasurement = cSquareHertz;
    const FSymbol            = '%sHz2';
    const FName              = 'square %shertz';
    const FPluralName        = 'square %shertz';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareHertzUnit = specialize TSymbol<TSquareHertzRec>;
  TSquareHertz = TQuantity;

var
  Hz2 : TSquareHertzUnit;
  SquareHertzUnit : TSquareHertzUnit;

const
  THz2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 25; FValue: 1E+24); {$ELSE} (1E+24); {$ENDIF}
  GHz2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 25; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MHz2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 25; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kHz2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 25; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}

{ TReciprocalSquareSecond }

type
  TReciprocalSquareSecondRec = record
    const FUnitOfMeasurement = cSquareHertz;
    const FSymbol            = '1/%ss2';
    const FName              = 'reciprocal square %ssecond';
    const FPluralName        = 'reciprocal square %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-2);
  end;
  TReciprocalSquareSecondUnit = specialize TSymbol<TReciprocalSquareSecondRec>;
  TReciprocalSquareSeconds = TQuantity;

var
  ReciprocalSquareSecond : TReciprocalSquareSecondUnit;
  ReciprocalSquareSecondUnit : TReciprocalSquareSecondUnit;

{ TRadianPerSquareSecond }

type
  TRadianPerSquareSecondRec = record
    const FUnitOfMeasurement = cSquareHertz;
    const FSymbol            = 'rad/%ss2';
    const FName              = 'radian per square %ssecond';
    const FPluralName        = 'radians per square %ssecond';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-2);
  end;
  TRadianPerSquareSecondUnit = specialize TSymbol<TRadianPerSquareSecondRec>;
  TRadiansPerSquareSecond = TQuantity;

var
  RadianPerSquareSecond : TRadianPerSquareSecondUnit;
  RadianPerSquareSecondUnit : TRadianPerSquareSecondUnit;

{ TSteradianPerSquareSecond }

const
  cSteradianPerSquareSecond = 26;

type
  TSteradianPerSquareSecondRec = record
    const FUnitOfMeasurement = cSteradianPerSquareSecond;
    const FSymbol            = 'sr/%ss2';
    const FName              = 'steradian per square %ssecond';
    const FPluralName        = 'steradians per square %ssecond';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-2);
  end;
  TSteradianPerSquareSecondUnit = specialize TSymbol<TSteradianPerSquareSecondRec>;
  TSteradiansPerSquareSecond = TQuantity;

var
  SteradianPerSquareSecond : TSteradianPerSquareSecondUnit;
  SteradianPerSquareSecondUnit : TSteradianPerSquareSecondUnit;

{ TMeterPerSecond }

const
  cMeterPerSecond = 27;

type
  TMeterPerSecondRec = record
    const FUnitOfMeasurement = cMeterPerSecond;
    const FSymbol            = '%sm/%ss';
    const FName              = '%smeter per %ssecond';
    const FPluralName        = '%smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TMeterPerSecondUnit = specialize TSymbol<TMeterPerSecondRec>;
  TMetersPerSecond = TQuantity;

var
  MeterPerSecond : TMeterPerSecondUnit;
  MeterPerSecondUnit : TMeterPerSecondUnit;

{ TMeterPerHour }

type
  TMeterPerHourRec = record
    const FUnitOfMeasurement = cMeterPerSecond;
    const FSymbol            = '%sm/h';
    const FName              = '%smeter per hour';
    const FPluralName        = '%smeters per hour';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TMeterPerHourUnit = specialize TFactoredSymbol<TMeterPerHourRec>;
  TMetersPerHour = TQuantity;

const
  MeterPerHour : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 27; FValue: 1/3600); {$ELSE} (1/3600); {$ENDIF}

var
  MeterPerHourUnit : TMeterPerHourUnit;

{ TMilePerHour }

type
  TMilePerHourRec = record
    const FUnitOfMeasurement = cMeterPerSecond;
    const FSymbol            = 'mi/h';
    const FName              = 'mile per hour';
    const FPluralName        = 'miles per hour';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TMilePerHourUnit = specialize TFactoredSymbol<TMilePerHourRec>;
  TMilesPerHour = TQuantity;

const
  MilePerHour : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 27; FValue: 0.44704); {$ELSE} (0.44704); {$ENDIF}

var
  MilePerHourUnit : TMilePerHourUnit;

{ TNauticalMilePerHour }

type
  TNauticalMilePerHourRec = record
    const FUnitOfMeasurement = cMeterPerSecond;
    const FSymbol            = 'nmi/h';
    const FName              = 'nautical mile per hour';
    const FPluralName        = 'nautical miles per hour';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TNauticalMilePerHourUnit = specialize TFactoredSymbol<TNauticalMilePerHourRec>;
  TNauticalMilesPerHour = TQuantity;

const
  NauticalMilePerHour : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 27; FValue: 463/900); {$ELSE} (463/900); {$ENDIF}

var
  NauticalMilePerHourUnit : TNauticalMilePerHourUnit;

{ TMeterPerSquareSecond }

const
  cMeterPerSquareSecond = 28;

type
  TMeterPerSquareSecondRec = record
    const FUnitOfMeasurement = cMeterPerSquareSecond;
    const FSymbol            = '%sm/%ss2';
    const FName              = '%smeter per %ssecond squared';
    const FPluralName        = '%smeters per %ssecond squared';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TMeterPerSquareSecondUnit = specialize TSymbol<TMeterPerSquareSecondRec>;
  TMetersPerSquareSecond = TQuantity;

var
  MeterPerSquareSecond : TMeterPerSquareSecondUnit;
  MeterPerSquareSecondUnit : TMeterPerSquareSecondUnit;

{ TMeterPerSecondPerSecond }

type
  TMeterPerSecondPerSecondRec = record
    const FUnitOfMeasurement = cMeterPerSquareSecond;
    const FSymbol            = '%sm/%ss/%ss';
    const FName              = '%smeter per %ssecond per %ssecond';
    const FPluralName        = '%smeters per %ssecond per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -1, -1);
  end;
  TMeterPerSecondPerSecondUnit = specialize TSymbol<TMeterPerSecondPerSecondRec>;
  TMetersPerSecondPerSecond = TQuantity;

var
  MeterPerSecondPerSecond : TMeterPerSecondPerSecondUnit;
  MeterPerSecondPerSecondUnit : TMeterPerSecondPerSecondUnit;

{ TMeterPerHourPerSecond }

type
  TMeterPerHourPerSecondRec = record
    const FUnitOfMeasurement = cMeterPerSquareSecond;
    const FSymbol            = '%sm/h/%ss';
    const FName              = '%smeter per hour per %ssecond';
    const FPluralName        = '%smeters per hour per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TMeterPerHourPerSecondUnit = specialize TFactoredSymbol<TMeterPerHourPerSecondRec>;
  TMetersPerHourPerSecond = TQuantity;

const
  MeterPerHourPerSecond : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 28; FValue: 1/3600); {$ELSE} (1/3600); {$ENDIF}

var
  MeterPerHourPerSecondUnit : TMeterPerHourPerSecondUnit;

{ TMeterPerCubicSecond }

const
  cMeterPerCubicSecond = 29;

type
  TMeterPerCubicSecondRec = record
    const FUnitOfMeasurement = cMeterPerCubicSecond;
    const FSymbol            = '%sm/%ss3';
    const FName              = '%smeter per cubic %ssecond';
    const FPluralName        = '%smeters per cubic %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TMeterPerCubicSecondUnit = specialize TSymbol<TMeterPerCubicSecondRec>;
  TMetersPerCubicSecond = TQuantity;

var
  MeterPerCubicSecond : TMeterPerCubicSecondUnit;
  MeterPerCubicSecondUnit : TMeterPerCubicSecondUnit;

{ TMeterPerQuarticSecond }

const
  cMeterPerQuarticSecond = 30;

type
  TMeterPerQuarticSecondRec = record
    const FUnitOfMeasurement = cMeterPerQuarticSecond;
    const FSymbol            = '%sm/%ss4';
    const FName              = '%smeter per quartic %ssecond';
    const FPluralName        = '%smeters per quartic %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -4);
  end;
  TMeterPerQuarticSecondUnit = specialize TSymbol<TMeterPerQuarticSecondRec>;
  TMetersPerQuarticSecond = TQuantity;

var
  MeterPerQuarticSecond : TMeterPerQuarticSecondUnit;
  MeterPerQuarticSecondUnit : TMeterPerQuarticSecondUnit;

{ TMeterPerQuinticSecond }

const
  cMeterPerQuinticSecond = 31;

type
  TMeterPerQuinticSecondRec = record
    const FUnitOfMeasurement = cMeterPerQuinticSecond;
    const FSymbol            = '%sm/%ss5';
    const FName              = '%smeter per quintic %ssecond';
    const FPluralName        = '%smeters per quintic %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -5);
  end;
  TMeterPerQuinticSecondUnit = specialize TSymbol<TMeterPerQuinticSecondRec>;
  TMetersPerQuinticSecond = TQuantity;

var
  MeterPerQuinticSecond : TMeterPerQuinticSecondUnit;
  MeterPerQuinticSecondUnit : TMeterPerQuinticSecondUnit;

{ TMeterPerSexticSecond }

const
  cMeterPerSexticSecond = 32;

type
  TMeterPerSexticSecondRec = record
    const FUnitOfMeasurement = cMeterPerSexticSecond;
    const FSymbol            = '%sm/%ss6';
    const FName              = '%smeter per sextic %ssecond';
    const FPluralName        = '%smeters per sextic %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -6);
  end;
  TMeterPerSexticSecondUnit = specialize TSymbol<TMeterPerSexticSecondRec>;
  TMetersPerSexticSecond = TQuantity;

var
  MeterPerSexticSecond : TMeterPerSexticSecondUnit;
  MeterPerSexticSecondUnit : TMeterPerSexticSecondUnit;

{ TSquareMeterPerSquareSecond }

const
  cSquareMeterPerSquareSecond = 33;

type
  TSquareMeterPerSquareSecondRec = record
    const FUnitOfMeasurement = cSquareMeterPerSquareSecond;
    const FSymbol            = '%sm2/%ss2';
    const FName              = 'square %smeter per square %ssecond';
    const FPluralName        = 'square %smeters per square %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareMeterPerSquareSecondUnit = specialize TSymbol<TSquareMeterPerSquareSecondRec>;
  TSquareMetersPerSquareSecond = TQuantity;

var
  SquareMeterPerSquareSecond : TSquareMeterPerSquareSecondUnit;
  SquareMeterPerSquareSecondUnit : TSquareMeterPerSquareSecondUnit;

{ TJoulePerKilogram }

type
  TJoulePerKilogramRec = record
    const FUnitOfMeasurement = cSquareMeterPerSquareSecond;
    const FSymbol            = '%sJ/%sg';
    const FName              = '%sjoule per %sgram';
    const FPluralName        = '%sjoules per %sgram';
    const FPrefixes          : TPrefixes  = (pNone, pKilo);
    const FExponents         : TExponents = (1, -1);
  end;
  TJoulePerKilogramUnit = specialize TSymbol<TJoulePerKilogramRec>;
  TJoulesPerKilogram = TQuantity;

var
  JoulePerKilogram : TJoulePerKilogramUnit;
  JoulePerKilogramUnit : TJoulePerKilogramUnit;

{ TGray }

type
  TGrayRec = record
    const FUnitOfMeasurement = cSquareMeterPerSquareSecond;
    const FSymbol            = '%sGy';
    const FName              = '%sgray';
    const FPluralName        = '%sgrays';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TGrayUnit = specialize TSymbol<TGrayRec>;
  TGrays = TQuantity;

var
  Gy : TGrayUnit;
  GrayUnit : TGrayUnit;

const
  kGy        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mGy        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miGy       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nGy        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TSievert }

type
  TSievertRec = record
    const FUnitOfMeasurement = cSquareMeterPerSquareSecond;
    const FSymbol            = '%sSv';
    const FName              = '%ssievert';
    const FPluralName        = '%ssieverts';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TSievertUnit = specialize TSymbol<TSievertRec>;
  TSieverts = TQuantity;

var
  Sv : TSievertUnit;
  SievertUnit : TSievertUnit;

const
  kSv        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mSv        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miSv       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nSv        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TMeterSecond }

const
  cMeterSecond = 34;

type
  TMeterSecondRec = record
    const FUnitOfMeasurement = cMeterSecond;
    const FSymbol            = '%sm.%ss';
    const FName              = '%smeter %ssecond';
    const FPluralName        = '%smeter %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TMeterSecondUnit = specialize TSymbol<TMeterSecondRec>;
  TMeterSeconds = TQuantity;

var
  MeterSecond : TMeterSecondUnit;
  MeterSecondUnit : TMeterSecondUnit;

{ TKilogramMeter }

const
  cKilogramMeter = 35;

type
  TKilogramMeterRec = record
    const FUnitOfMeasurement = cKilogramMeter;
    const FSymbol            = '%sg.%sm';
    const FName              = '%sgram %smeter';
    const FPluralName        = '%sgram %smeters';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TKilogramMeterUnit = specialize TSymbol<TKilogramMeterRec>;
  TKilogramMeters = TQuantity;

var
  KilogramMeter : TKilogramMeterUnit;
  KilogramMeterUnit : TKilogramMeterUnit;

{ TKilogramPerSecond }

const
  cKilogramPerSecond = 36;

type
  TKilogramPerSecondRec = record
    const FUnitOfMeasurement = cKilogramPerSecond;
    const FSymbol            = '%sg/%ss';
    const FName              = '%sgram per %ssecond';
    const FPluralName        = '%sgrams per %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TKilogramPerSecondUnit = specialize TSymbol<TKilogramPerSecondRec>;
  TKilogramsPerSecond = TQuantity;

var
  KilogramPerSecond : TKilogramPerSecondUnit;
  KilogramPerSecondUnit : TKilogramPerSecondUnit;

{ TJoulePerSquareMeterPerHertz }

type
  TJoulePerSquareMeterPerHertzRec = record
    const FUnitOfMeasurement = cKilogramPerSecond;
    const FSymbol            = '%sJ/%sm2/%sHz';
    const FName              = '%sjoule per square %smeter per %shertz';
    const FPluralName        = '%sjoules per square %smeter per %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -2, -1);
  end;
  TJoulePerSquareMeterPerHertzUnit = specialize TSymbol<TJoulePerSquareMeterPerHertzRec>;
  TJoulesPerSquareMeterPerHertz = TQuantity;

var
  JoulePerSquareMeterPerHertz : TJoulePerSquareMeterPerHertzUnit;
  JoulePerSquareMeterPerHertzUnit : TJoulePerSquareMeterPerHertzUnit;

{ TKilogramMeterPerSecond }

const
  cKilogramMeterPerSecond = 37;

type
  TKilogramMeterPerSecondRec = record
    const FUnitOfMeasurement = cKilogramMeterPerSecond;
    const FSymbol            = '%sg.%sm/%ss';
    const FName              = '%sgram %smeter per %ssecond';
    const FPluralName        = '%sgram %smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -1);
  end;
  TKilogramMeterPerSecondUnit = specialize TSymbol<TKilogramMeterPerSecondRec>;
  TKilogramMetersPerSecond = TQuantity;

var
  KilogramMeterPerSecond : TKilogramMeterPerSecondUnit;
  KilogramMeterPerSecondUnit : TKilogramMeterPerSecondUnit;

{ TNewtonSecond }

type
  TNewtonSecondRec = record
    const FUnitOfMeasurement = cKilogramMeterPerSecond;
    const FSymbol            = '%sN.%ss';
    const FName              = '%snewton %ssecond';
    const FPluralName        = '%snewton %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TNewtonSecondUnit = specialize TSymbol<TNewtonSecondRec>;
  TNewtonSeconds = TQuantity;

var
  NewtonSecond : TNewtonSecondUnit;
  NewtonSecondUnit : TNewtonSecondUnit;

{ TSquareKilogramSquareMeterPerSquareSecond }

const
  cSquareKilogramSquareMeterPerSquareSecond = 38;

type
  TSquareKilogramSquareMeterPerSquareSecondRec = record
    const FUnitOfMeasurement = cSquareKilogramSquareMeterPerSquareSecond;
    const FSymbol            = '%sg2.%sm2/%ss2';
    const FName              = 'square%sgram square%smeter per square%ssecond';
    const FPluralName        = 'square%sgram square%smeters per square%ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (2, 2, -2);
  end;
  TSquareKilogramSquareMeterPerSquareSecondUnit = specialize TSymbol<TSquareKilogramSquareMeterPerSquareSecondRec>;
  TSquareKilogramSquareMetersPerSquareSecond = TQuantity;

var
  SquareKilogramSquareMeterPerSquareSecond : TSquareKilogramSquareMeterPerSquareSecondUnit;
  SquareKilogramSquareMeterPerSquareSecondUnit : TSquareKilogramSquareMeterPerSquareSecondUnit;

{ TReciprocalSquareRootMeter }

const
  cReciprocalSquareRootMeter = 39;

type
  TReciprocalSquareRootMeterRec = record
    const FUnitOfMeasurement = cReciprocalSquareRootMeter;
    const FSymbol            = '1/√%sm';
    const FName              = 'reciprocal square root %smeter';
    const FPluralName        = 'reciprocal square root %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalSquareRootMeterUnit = specialize TSymbol<TReciprocalSquareRootMeterRec>;
  TReciprocalSquareRootMeters = TQuantity;

var
  ReciprocalSquareRootMeter : TReciprocalSquareRootMeterUnit;
  ReciprocalSquareRootMeterUnit : TReciprocalSquareRootMeterUnit;

{ TReciprocalMeter }

const
  cReciprocalMeter = 40;

type
  TReciprocalMeterRec = record
    const FUnitOfMeasurement = cReciprocalMeter;
    const FSymbol            = '1/%sm';
    const FName              = 'reciprocal %smeter';
    const FPluralName        = 'reciprocal %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalMeterUnit = specialize TSymbol<TReciprocalMeterRec>;
  TReciprocalMeters = TQuantity;

var
  ReciprocalMeter : TReciprocalMeterUnit;
  ReciprocalMeterUnit : TReciprocalMeterUnit;

{ TDioptre }

type
  TDioptreRec = record
    const FUnitOfMeasurement = cReciprocalMeter;
    const FSymbol            = 'dpt';
    const FName              = '%sdioptre';
    const FPluralName        = '%sdioptres';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
  end;
  TDioptreUnit = specialize TSymbol<TDioptreRec>;
  TDioptres = TQuantity;

var
  Dioptre : TDioptreUnit;
  DioptreUnit : TDioptreUnit;

{ TReciprocalSquareRootCubicMeter }

const
  cReciprocalSquareRootCubicMeter = 41;

type
  TReciprocalSquareRootCubicMeterRec = record
    const FUnitOfMeasurement = cReciprocalSquareRootCubicMeter;
    const FSymbol            = '1/√%sm3';
    const FName              = 'reciprocal square root cubic %smeter';
    const FPluralName        = 'reciprocal square root cubic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-3);
  end;
  TReciprocalSquareRootCubicMeterUnit = specialize TSymbol<TReciprocalSquareRootCubicMeterRec>;
  TReciprocalSquareRootCubicMeters = TQuantity;

var
  ReciprocalSquareRootCubicMeter : TReciprocalSquareRootCubicMeterUnit;
  ReciprocalSquareRootCubicMeterUnit : TReciprocalSquareRootCubicMeterUnit;

{ TReciprocalSquareMeter }

const
  cReciprocalSquareMeter = 42;

type
  TReciprocalSquareMeterRec = record
    const FUnitOfMeasurement = cReciprocalSquareMeter;
    const FSymbol            = '1/%sm2';
    const FName              = 'reciprocal square %smeter';
    const FPluralName        = 'reciprocal square %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-2);
  end;
  TReciprocalSquareMeterUnit = specialize TSymbol<TReciprocalSquareMeterRec>;
  TReciprocalSquareMeters = TQuantity;

var
  ReciprocalSquareMeter : TReciprocalSquareMeterUnit;
  ReciprocalSquareMeterUnit : TReciprocalSquareMeterUnit;

{ TReciprocalCubicMeter }

const
  cReciprocalCubicMeter = 43;

type
  TReciprocalCubicMeterRec = record
    const FUnitOfMeasurement = cReciprocalCubicMeter;
    const FSymbol            = '1/%sm3';
    const FName              = 'reciprocal cubic %smeter';
    const FPluralName        = 'reciprocal cubic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-3);
  end;
  TReciprocalCubicMeterUnit = specialize TSymbol<TReciprocalCubicMeterRec>;
  TReciprocalCubicMeters = TQuantity;

var
  ReciprocalCubicMeter : TReciprocalCubicMeterUnit;
  ReciprocalCubicMeterUnit : TReciprocalCubicMeterUnit;

{ TReciprocalQuarticMeter }

const
  cReciprocalQuarticMeter = 44;

type
  TReciprocalQuarticMeterRec = record
    const FUnitOfMeasurement = cReciprocalQuarticMeter;
    const FSymbol            = '1/%sm4';
    const FName              = 'reciprocal quartic %smeter';
    const FPluralName        = 'reciprocal quartic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-4);
  end;
  TReciprocalQuarticMeterUnit = specialize TSymbol<TReciprocalQuarticMeterRec>;
  TReciprocalQuarticMeters = TQuantity;

var
  ReciprocalQuarticMeter : TReciprocalQuarticMeterUnit;
  ReciprocalQuarticMeterUnit : TReciprocalQuarticMeterUnit;

{ TKilogramSquareMeter }

const
  cKilogramSquareMeter = 45;

type
  TKilogramSquareMeterRec = record
    const FUnitOfMeasurement = cKilogramSquareMeter;
    const FSymbol            = '%sg.%sm2';
    const FName              = '%sgram square %smeter';
    const FPluralName        = '%sgram square %smeters';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, 2);
  end;
  TKilogramSquareMeterUnit = specialize TSymbol<TKilogramSquareMeterRec>;
  TKilogramSquareMeters = TQuantity;

var
  KilogramSquareMeter : TKilogramSquareMeterUnit;
  KilogramSquareMeterUnit : TKilogramSquareMeterUnit;

{ TKilogramSquareMeterPerSecond }

const
  cKilogramSquareMeterPerSecond = 46;

type
  TKilogramSquareMeterPerSecondRec = record
    const FUnitOfMeasurement = cKilogramSquareMeterPerSecond;
    const FSymbol            = '%sg.%sm2/%ss';
    const FName              = '%sgram square %smeter per %ssecond';
    const FPluralName        = '%sgram square %smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -1);
  end;
  TKilogramSquareMeterPerSecondUnit = specialize TSymbol<TKilogramSquareMeterPerSecondRec>;
  TKilogramSquareMetersPerSecond = TQuantity;

var
  KilogramSquareMeterPerSecond : TKilogramSquareMeterPerSecondUnit;
  KilogramSquareMeterPerSecondUnit : TKilogramSquareMeterPerSecondUnit;

{ TNewtonMeterSecond }

type
  TNewtonMeterSecondRec = record
    const FUnitOfMeasurement = cKilogramSquareMeterPerSecond;
    const FSymbol            = '%sN.%sm.%ss';
    const FName              = '%snewton %smeter %ssecond';
    const FPluralName        = '%snewton %smeter %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 1, 1);
  end;
  TNewtonMeterSecondUnit = specialize TSymbol<TNewtonMeterSecondRec>;
  TNewtonMeterSeconds = TQuantity;

var
  NewtonMeterSecond : TNewtonMeterSecondUnit;
  NewtonMeterSecondUnit : TNewtonMeterSecondUnit;

{ TSecondPerMeter }

const
  cSecondPerMeter = 47;

type
  TSecondPerMeterRec = record
    const FUnitOfMeasurement = cSecondPerMeter;
    const FSymbol            = '%ss/%sm';
    const FName              = '%ssecond per %smeter';
    const FPluralName        = '%sseconds per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TSecondPerMeterUnit = specialize TSymbol<TSecondPerMeterRec>;
  TSecondsPerMeter = TQuantity;

var
  SecondPerMeter : TSecondPerMeterUnit;
  SecondPerMeterUnit : TSecondPerMeterUnit;

{ TKilogramPerMeter }

const
  cKilogramPerMeter = 48;

type
  TKilogramPerMeterRec = record
    const FUnitOfMeasurement = cKilogramPerMeter;
    const FSymbol            = '%sg/%sm';
    const FName              = '%sgram per %smeter';
    const FPluralName        = '%sgrams per %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TKilogramPerMeterUnit = specialize TSymbol<TKilogramPerMeterRec>;
  TKilogramsPerMeter = TQuantity;

var
  KilogramPerMeter : TKilogramPerMeterUnit;
  KilogramPerMeterUnit : TKilogramPerMeterUnit;

{ TKilogramPerSquareMeter }

const
  cKilogramPerSquareMeter = 49;

type
  TKilogramPerSquareMeterRec = record
    const FUnitOfMeasurement = cKilogramPerSquareMeter;
    const FSymbol            = '%sg/%sm2';
    const FName              = '%sgram per square %smeter';
    const FPluralName        = '%sgrams per square %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TKilogramPerSquareMeterUnit = specialize TSymbol<TKilogramPerSquareMeterRec>;
  TKilogramsPerSquareMeter = TQuantity;

var
  KilogramPerSquareMeter : TKilogramPerSquareMeterUnit;
  KilogramPerSquareMeterUnit : TKilogramPerSquareMeterUnit;

{ TKilogramPerCubicMeter }

const
  cKilogramPerCubicMeter = 50;

type
  TKilogramPerCubicMeterRec = record
    const FUnitOfMeasurement = cKilogramPerCubicMeter;
    const FSymbol            = '%sg/%sm3';
    const FName              = '%sgram per cubic %smeter';
    const FPluralName        = '%sgrams per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TKilogramPerCubicMeterUnit = specialize TSymbol<TKilogramPerCubicMeterRec>;
  TKilogramsPerCubicMeter = TQuantity;

var
  KilogramPerCubicMeter : TKilogramPerCubicMeterUnit;
  KilogramPerCubicMeterUnit : TKilogramPerCubicMeterUnit;

{ TPoundPerCubicInch }

type
  TPoundPerCubicInchRec = record
    const FUnitOfMeasurement = cKilogramPerCubicMeter;
    const FSymbol            = 'lb/in3';
    const FName              = 'pound per cubic inch';
    const FPluralName        = 'pounds per cubic inch';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TPoundPerCubicInchUnit = specialize TFactoredSymbol<TPoundPerCubicInchRec>;
  TPoundsPerCubicInch = TQuantity;

const
  PoundPerCubicInch : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 50; FValue: 27679.9047102031); {$ELSE} (27679.9047102031); {$ENDIF}

var
  PoundPerCubicInchUnit : TPoundPerCubicInchUnit;

{ TNewton }

const
  cNewton = 51;

type
  TNewtonRec = record
    const FUnitOfMeasurement = cNewton;
    const FSymbol            = '%sN';
    const FName              = '%snewton';
    const FPluralName        = '%snewtons';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TNewtonUnit = specialize TSymbol<TNewtonRec>;
  TNewtons = TQuantity;

var
  N : TNewtonUnit;
  NewtonUnit : TNewtonUnit;

const
  GN         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 51; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MN         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 51; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kN         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 51; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hN         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 51; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daN        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 51; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}

{ TPoundForce }

type
  TPoundForceRec = record
    const FUnitOfMeasurement = cNewton;
    const FSymbol            = 'lbf';
    const FName              = 'pound-force';
    const FPluralName        = 'pounds-force';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TPoundForceUnit = specialize TFactoredSymbol<TPoundForceRec>;
  TPoundsForce = TQuantity;

const
  lbf        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 51; FValue: 4.4482216152605); {$ELSE} (4.4482216152605); {$ENDIF}

var
  PoundForceUnit : TPoundForceUnit;

{ TKilogramMeterPerSquareSecond }

type
  TKilogramMeterPerSquareSecondRec = record
    const FUnitOfMeasurement = cNewton;
    const FSymbol            = '%sg.%sm/%ss2';
    const FName              = '%sgram %smeter per square %ssecond';
    const FPluralName        = '%sgram %smeters per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -2);
  end;
  TKilogramMeterPerSquareSecondUnit = specialize TSymbol<TKilogramMeterPerSquareSecondRec>;
  TKilogramMetersPerSquareSecond = TQuantity;

var
  KilogramMeterPerSquareSecond : TKilogramMeterPerSquareSecondUnit;
  KilogramMeterPerSquareSecondUnit : TKilogramMeterPerSquareSecondUnit;

{ TNewtonRadian }

const
  cNewtonRadian = 52;

type
  TNewtonRadianRec = record
    const FUnitOfMeasurement = cNewtonRadian;
    const FSymbol            = '%sN.%srad';
    const FName              = '%snewton %sradian';
    const FPluralName        = '%snewton %sradians';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TNewtonRadianUnit = specialize TSymbol<TNewtonRadianRec>;
  TNewtonRadians = TQuantity;

var
  NewtonRadian : TNewtonRadianUnit;
  NewtonRadianUnit : TNewtonRadianUnit;

{ TSquareNewton }

const
  cSquareNewton = 53;

type
  TSquareNewtonRec = record
    const FUnitOfMeasurement = cSquareNewton;
    const FSymbol            = '%sN2';
    const FName              = 'square %snewton';
    const FPluralName        = 'square %snewtons';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareNewtonUnit = specialize TSymbol<TSquareNewtonRec>;
  TSquareNewtons = TQuantity;

var
  N2 : TSquareNewtonUnit;
  SquareNewtonUnit : TSquareNewtonUnit;

const
  GN2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 53; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MN2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 53; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kN2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 53; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hN2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 53; FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daN2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 53; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}

{ TSquareKilogramSquareMeterPerQuarticSecond }

type
  TSquareKilogramSquareMeterPerQuarticSecondRec = record
    const FUnitOfMeasurement = cSquareNewton;
    const FSymbol            = '%sg2.%sm2/%ss4';
    const FName              = 'square %sgram square %smeter per quartic %ssecond';
    const FPluralName        = 'square %sgram square %smeters per quartic %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (2, 2, -4);
  end;
  TSquareKilogramSquareMeterPerQuarticSecondUnit = specialize TSymbol<TSquareKilogramSquareMeterPerQuarticSecondRec>;
  TSquareKilogramSquareMetersPerQuarticSecond = TQuantity;

var
  SquareKilogramSquareMeterPerQuarticSecond : TSquareKilogramSquareMeterPerQuarticSecondUnit;
  SquareKilogramSquareMeterPerQuarticSecondUnit : TSquareKilogramSquareMeterPerQuarticSecondUnit;

{ TPascal }

const
  cPascal = 54;

type
  TPascalRec = record
    const FUnitOfMeasurement = cPascal;
    const FSymbol            = '%sPa';
    const FName              = '%spascal';
    const FPluralName        = '%spascals';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TPascalUnit = specialize TSymbol<TPascalRec>;
  TPascals = TQuantity;

var
  Pa : TPascalUnit;
  PascalUnit : TPascalUnit;

const
  TPa        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GPa        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MPa        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kPa        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TNewtonPerSquareMeter }

type
  TNewtonPerSquareMeterRec = record
    const FUnitOfMeasurement = cPascal;
    const FSymbol            = '%sN/%sm2';
    const FName              = '%snewton per square %smeter';
    const FPluralName        = '%snewtons per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TNewtonPerSquareMeterUnit = specialize TSymbol<TNewtonPerSquareMeterRec>;
  TNewtonsPerSquareMeter = TQuantity;

var
  NewtonPerSquareMeter : TNewtonPerSquareMeterUnit;
  NewtonPerSquareMeterUnit : TNewtonPerSquareMeterUnit;

{ TBar }

type
  TBarRec = record
    const FUnitOfMeasurement = cPascal;
    const FSymbol            = '%sbar';
    const FName              = '%sbar';
    const FPluralName        = '%sbars';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TBarUnit = specialize TFactoredSymbol<TBarRec>;
  TBars = TQuantity;

const
  bar        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 1E+05); {$ELSE} (1E+05); {$ENDIF}

var
  BarUnit : TBarUnit;

const
  kbar       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 1E+05 * 1E+03); {$ELSE} (1E+05 * 1E+03); {$ENDIF}
  mbar       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 1E+05 * 1E-03); {$ELSE} (1E+05 * 1E-03); {$ENDIF}

{ TPoundPerSquareInch }

type
  TPoundPerSquareInchRec = record
    const FUnitOfMeasurement = cPascal;
    const FSymbol            = '%spsi';
    const FName              = '%spound per square inch';
    const FPluralName        = '%spounds per square inch';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TPoundPerSquareInchUnit = specialize TFactoredSymbol<TPoundPerSquareInchRec>;
  TPoundsPerSquareInch = TQuantity;

const
  psi        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 6894.75729316836); {$ELSE} (6894.75729316836); {$ENDIF}

var
  PoundPerSquareInchUnit : TPoundPerSquareInchUnit;

const
  kpsi       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 6894.75729316836 * 1E+03); {$ELSE} (6894.75729316836 * 1E+03); {$ENDIF}

{ TJoulePerCubicMeter }

type
  TJoulePerCubicMeterRec = record
    const FUnitOfMeasurement = cPascal;
    const FSymbol            = '%sJ/%sm3';
    const FName              = '%sjoule per cubic %smeter';
    const FPluralName        = '%sjoules per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TJoulePerCubicMeterUnit = specialize TSymbol<TJoulePerCubicMeterRec>;
  TJoulesPerCubicMeter = TQuantity;

var
  JoulePerCubicMeter : TJoulePerCubicMeterUnit;
  JoulePerCubicMeterUnit : TJoulePerCubicMeterUnit;

{ TKilogramPerMeterPerSquareSecond }

type
  TKilogramPerMeterPerSquareSecondRec = record
    const FUnitOfMeasurement = cPascal;
    const FSymbol            = '%sg/%sm/%ss2';
    const FName              = '%sgram per %smeter per square %ssecond';
    const FPluralName        = '%sgrams per %smeter per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, -1, -2);
  end;
  TKilogramPerMeterPerSquareSecondUnit = specialize TSymbol<TKilogramPerMeterPerSquareSecondRec>;
  TKilogramsPerMeterPerSquareSecond = TQuantity;

var
  KilogramPerMeterPerSquareSecond : TKilogramPerMeterPerSquareSecondUnit;
  KilogramPerMeterPerSquareSecondUnit : TKilogramPerMeterPerSquareSecondUnit;

{ TJoule }

const
  cJoule = 55;

type
  TJouleRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sJ';
    const FName              = '%sjoule';
    const FPluralName        = '%sjoules';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TJouleUnit = specialize TSymbol<TJouleRec>;
  TJoules = TQuantity;

var
  J : TJouleUnit;
  JouleUnit : TJouleUnit;

const
  TJ         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GJ         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MJ         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kJ         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TWattHour }

type
  TWattHourRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sW.h';
    const FName              = '%swatt hour';
    const FPluralName        = '%swatt hours';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TWattHourUnit = specialize TFactoredSymbol<TWattHourRec>;
  TWattHours = TQuantity;

const
  WattHour   : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 3600); {$ELSE} (3600); {$ENDIF}

var
  WattHourUnit : TWattHourUnit;

{ TWattSecond }

type
  TWattSecondRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sW.%ss';
    const FName              = '%swatt %ssecond';
    const FPluralName        = '%swatt %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TWattSecondUnit = specialize TSymbol<TWattSecondRec>;
  TWattSeconds = TQuantity;

var
  WattSecond : TWattSecondUnit;
  WattSecondUnit : TWattSecondUnit;

{ TWattPerHertz }

type
  TWattPerHertzRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sW/%shz';
    const FName              = '%swatt per %shertz';
    const FPluralName        = '%swatts per %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TWattPerHertzUnit = specialize TSymbol<TWattPerHertzRec>;
  TWattsPerHertz = TQuantity;

var
  WattPerHertz : TWattPerHertzUnit;
  WattPerHertzUnit : TWattPerHertzUnit;

{ TElectronvolt }

type
  TElectronvoltRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%seV';
    const FName              = '%selectronvolt';
    const FPluralName        = '%selectronvolts';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TElectronvoltUnit = specialize TFactoredSymbol<TElectronvoltRec>;
  TElectronvolts = TQuantity;

const
  eV         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019); {$ELSE} (1.602176634E-019); {$ENDIF}

var
  ElectronvoltUnit : TElectronvoltUnit;

const
  TeV        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+12); {$ELSE} (1.602176634E-019 * 1E+12); {$ENDIF}
  GeV        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+09); {$ELSE} (1.602176634E-019 * 1E+09); {$ENDIF}
  MeV        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+06); {$ELSE} (1.602176634E-019 * 1E+06); {$ENDIF}
  keV        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+03); {$ELSE} (1.602176634E-019 * 1E+03); {$ENDIF}

{ TNewtonMeter }

type
  TNewtonMeterRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sN.%sm';
    const FName              = '%snewton %smeter';
    const FPluralName        = '%snewton %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TNewtonMeterUnit = specialize TSymbol<TNewtonMeterRec>;
  TNewtonMeters = TQuantity;

var
  NewtonMeter : TNewtonMeterUnit;
  NewtonMeterUnit : TNewtonMeterUnit;

{ TPoundForceInch }

type
  TPoundForceInchRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = 'lbf.in';
    const FName              = 'pound-force inch';
    const FPluralName        = 'pound-force inches';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TPoundForceInchUnit = specialize TFactoredSymbol<TPoundForceInchRec>;
  TPoundForceInches = TQuantity;

const
  PoundForceInch : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 0.112984829027617); {$ELSE} (0.112984829027617); {$ENDIF}

var
  PoundForceInchUnit : TPoundForceInchUnit;

{ TRydberg }

type
  TRydbergRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sRy';
    const FName              = '%srydberg';
    const FPluralName        = '%srydbergs';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TRydbergUnit = specialize TFactoredSymbol<TRydbergRec>;
  TRydbergs = TQuantity;

const
  Ry         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 2.1798723611035E-18); {$ELSE} (2.1798723611035E-18); {$ENDIF}

var
  RydbergUnit : TRydbergUnit;

{ TCalorie }

type
  TCalorieRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%scal';
    const FName              = '%scalorie';
    const FPluralName        = '%scalories';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TCalorieUnit = specialize TFactoredSymbol<TCalorieRec>;
  TCalories = TQuantity;

const
  cal        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 4.184); {$ELSE} (4.184); {$ENDIF}

var
  CalorieUnit : TCalorieUnit;

const
  Mcal       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 4.184 * 1E+06); {$ELSE} (4.184 * 1E+06); {$ENDIF}
  kcal       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 4.184 * 1E+03); {$ELSE} (4.184 * 1E+03); {$ENDIF}

{ TKilogramSquareMeterPerSquareSecond }

type
  TKilogramSquareMeterPerSquareSecondRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sg.%sm2/%ss2';
    const FName              = '%sgram square %smeter per square %ssecond';
    const FPluralName        = '%sgram square %smeters per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -2);
  end;
  TKilogramSquareMeterPerSquareSecondUnit = specialize TSymbol<TKilogramSquareMeterPerSquareSecondRec>;
  TKilogramSquareMetersPerSquareSecond = TQuantity;

var
  KilogramSquareMeterPerSquareSecond : TKilogramSquareMeterPerSquareSecondUnit;
  KilogramSquareMeterPerSquareSecondUnit : TKilogramSquareMeterPerSquareSecondUnit;

{ TJoulePerRadian }

const
  cJoulePerRadian = 56;

type
  TJoulePerRadianRec = record
    const FUnitOfMeasurement = cJoulePerRadian;
    const FSymbol            = '%sJ/rad';
    const FName              = '%sjoule per radian';
    const FPluralName        = '%sjoules per radian';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TJoulePerRadianUnit = specialize TSymbol<TJoulePerRadianRec>;
  TJoulesPerRadian = TQuantity;

var
  JoulePerRadian : TJoulePerRadianUnit;
  JoulePerRadianUnit : TJoulePerRadianUnit;

{ TJoulePerDegree }

type
  TJoulePerDegreeRec = record
    const FUnitOfMeasurement = cJoulePerRadian;
    const FSymbol            = '%sJ/deg';
    const FName              = '%sjoule per degree';
    const FPluralName        = '%sjoules per degree';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TJoulePerDegreeUnit = specialize TFactoredSymbol<TJoulePerDegreeRec>;
  TJoulesPerDegree = TQuantity;

const
  JoulePerDegree : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 56; FValue: 180/Pi); {$ELSE} (180/Pi); {$ENDIF}

var
  JoulePerDegreeUnit : TJoulePerDegreeUnit;

{ TNewtonMeterPerRadian }

type
  TNewtonMeterPerRadianRec = record
    const FUnitOfMeasurement = cJoulePerRadian;
    const FSymbol            = '%sN.%sm/rad';
    const FName              = '%snewton %smeter per radian';
    const FPluralName        = '%snewton %smeters per radian';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TNewtonMeterPerRadianUnit = specialize TSymbol<TNewtonMeterPerRadianRec>;
  TNewtonMetersPerRadian = TQuantity;

var
  NewtonMeterPerRadian : TNewtonMeterPerRadianUnit;
  NewtonMeterPerRadianUnit : TNewtonMeterPerRadianUnit;

{ TNewtonMeterPerDegree }

type
  TNewtonMeterPerDegreeRec = record
    const FUnitOfMeasurement = cJoulePerRadian;
    const FSymbol            = '%sN.%sm/deg';
    const FName              = '%snewton %smeter per degree';
    const FPluralName        = '%snewton %smeters per degree';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TNewtonMeterPerDegreeUnit = specialize TFactoredSymbol<TNewtonMeterPerDegreeRec>;
  TNewtonMetersPerDegree = TQuantity;

const
  NewtonMeterPerDegree : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 56; FValue: 180/Pi); {$ELSE} (180/Pi); {$ENDIF}

var
  NewtonMeterPerDegreeUnit : TNewtonMeterPerDegreeUnit;

{ TKilogramSquareMeterPerSquareSecondPerRadian }

type
  TKilogramSquareMeterPerSquareSecondPerRadianRec = record
    const FUnitOfMeasurement = cJoulePerRadian;
    const FSymbol            = '%sg.%sm2/%ss2/rad';
    const FName              = '%sgram square %smeter per square %ssecond per radian';
    const FPluralName        = '%sgram square %smeters per square %ssecond per radian';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -2);
  end;
  TKilogramSquareMeterPerSquareSecondPerRadianUnit = specialize TSymbol<TKilogramSquareMeterPerSquareSecondPerRadianRec>;
  TKilogramSquareMetersPerSquareSecondPerRadian = TQuantity;

var
  KilogramSquareMeterPerSquareSecondPerRadian : TKilogramSquareMeterPerSquareSecondPerRadianUnit;
  KilogramSquareMeterPerSquareSecondPerRadianUnit : TKilogramSquareMeterPerSquareSecondPerRadianUnit;

{ TWatt }

const
  cWatt = 57;

type
  TWattRec = record
    const FUnitOfMeasurement = cWatt;
    const FSymbol            = '%sW';
    const FName              = '%swatt';
    const FPluralName        = '%swatts';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TWattUnit = specialize TSymbol<TWattRec>;
  TWatts = TQuantity;

var
  W : TWattUnit;
  WattUnit : TWattUnit;

const
  TW         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 57; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GW         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 57; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MW         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 57; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kW         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 57; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  milliW     : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 57; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

{ TKilogramSquareMeterPerCubicSecond }

type
  TKilogramSquareMeterPerCubicSecondRec = record
    const FUnitOfMeasurement = cWatt;
    const FSymbol            = '%sg.%sm2/%ss3';
    const FName              = '%sgram square %smeter per cubic %ssecond';
    const FPluralName        = '%sgram square %smeters per cubic %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -3);
  end;
  TKilogramSquareMeterPerCubicSecondUnit = specialize TSymbol<TKilogramSquareMeterPerCubicSecondRec>;
  TKilogramSquareMetersPerCubicSecond = TQuantity;

var
  KilogramSquareMeterPerCubicSecond : TKilogramSquareMeterPerCubicSecondUnit;
  KilogramSquareMeterPerCubicSecondUnit : TKilogramSquareMeterPerCubicSecondUnit;

{ TCoulomb }

const
  cCoulomb = 58;

type
  TCoulombRec = record
    const FUnitOfMeasurement = cCoulomb;
    const FSymbol            = '%sC';
    const FName              = '%scoulomb';
    const FPluralName        = '%scoulombs';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TCoulombUnit = specialize TSymbol<TCoulombRec>;
  TCoulombs = TQuantity;

var
  C : TCoulombUnit;
  CoulombUnit : TCoulombUnit;

const
  kC         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 58; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hC         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 58; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daC        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 58; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}
  dC         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 58; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cC         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 58; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mC         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 58; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miC        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 58; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nC         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 58; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pC         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 58; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TAmpereHour }

type
  TAmpereHourRec = record
    const FUnitOfMeasurement = cCoulomb;
    const FSymbol            = '%sA.h';
    const FName              = '%sampere hour';
    const FPluralName        = '%sampere hours';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TAmpereHourUnit = specialize TFactoredSymbol<TAmpereHourRec>;
  TAmpereHours = TQuantity;

const
  AmpereHour : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 58; FValue: 3600); {$ELSE} (3600); {$ENDIF}

var
  AmpereHourUnit : TAmpereHourUnit;

{ TAmpereSecond }

type
  TAmpereSecondRec = record
    const FUnitOfMeasurement = cCoulomb;
    const FSymbol            = '%sA.%ss';
    const FName              = '%sampere %ssecond';
    const FPluralName        = '%sampere %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TAmpereSecondUnit = specialize TSymbol<TAmpereSecondRec>;
  TAmpereSeconds = TQuantity;

var
  AmpereSecond : TAmpereSecondUnit;
  AmpereSecondUnit : TAmpereSecondUnit;

{ TSquareCoulomb }

const
  cSquareCoulomb = 59;

type
  TSquareCoulombRec = record
    const FUnitOfMeasurement = cSquareCoulomb;
    const FSymbol            = '%sC2';
    const FName              = 'square %scoulomb';
    const FPluralName        = 'square %scoulombs';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareCoulombUnit = specialize TSymbol<TSquareCoulombRec>;
  TSquareCoulombs = TQuantity;

var
  C2 : TSquareCoulombUnit;
  SquareCoulombUnit : TSquareCoulombUnit;

const
  kC2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 59; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hC2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 59; FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daC2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 59; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  dC2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 59; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cC2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 59; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mC2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 59; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  miC2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 59; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nC2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 59; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  pC2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 59; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareAmpereSquareSecond }

type
  TSquareAmpereSquareSecondRec = record
    const FUnitOfMeasurement = cSquareCoulomb;
    const FSymbol            = '%sA2.%ss2';
    const FName              = 'square %sampere square %ssecond';
    const FPluralName        = 'square %sampere square %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 2);
  end;
  TSquareAmpereSquareSecondUnit = specialize TSymbol<TSquareAmpereSquareSecondRec>;
  TSquareAmpereSquareSeconds = TQuantity;

var
  SquareAmpereSquareSecond : TSquareAmpereSquareSecondUnit;
  SquareAmpereSquareSecondUnit : TSquareAmpereSquareSecondUnit;

{ TCoulombMeter }

const
  cCoulombMeter = 60;

type
  TCoulombMeterRec = record
    const FUnitOfMeasurement = cCoulombMeter;
    const FSymbol            = '%sC.%sm';
    const FName              = '%scoulomb %smeter';
    const FPluralName        = '%scoulomb %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TCoulombMeterUnit = specialize TSymbol<TCoulombMeterRec>;
  TCoulombMeters = TQuantity;

var
  CoulombMeter : TCoulombMeterUnit;
  CoulombMeterUnit : TCoulombMeterUnit;

{ TVolt }

const
  cVolt = 61;

type
  TVoltRec = record
    const FUnitOfMeasurement = cVolt;
    const FSymbol            = '%sV';
    const FName              = '%svolt';
    const FPluralName        = '%svolts';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TVoltUnit = specialize TSymbol<TVoltRec>;
  TVolts = TQuantity;

var
  V : TVoltUnit;
  VoltUnit : TVoltUnit;

const
  kV         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 61; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mV         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 61; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

{ TJoulePerCoulomb }

type
  TJoulePerCoulombRec = record
    const FUnitOfMeasurement = cVolt;
    const FSymbol            = '%sJ/%sC';
    const FName              = '%sJoule per %scoulomb';
    const FPluralName        = '%sJoules per %scoulomb';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TJoulePerCoulombUnit = specialize TSymbol<TJoulePerCoulombRec>;
  TJoulesPerCoulomb = TQuantity;

var
  JoulePerCoulomb : TJoulePerCoulombUnit;
  JoulePerCoulombUnit : TJoulePerCoulombUnit;

{ TKilogramSquareMeterPerAmperePerCubicSecond }

type
  TKilogramSquareMeterPerAmperePerCubicSecondRec = record
    const FUnitOfMeasurement = cVolt;
    const FSymbol            = '%sg.%sm2/%sA/%ss3';
    const FName              = '%sgram square %smeter per %sampere per cubic %ssecond';
    const FPluralName        = '%sgram square %smeters per %sampere per cubic %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -1, -3);
  end;
  TKilogramSquareMeterPerAmperePerCubicSecondUnit = specialize TSymbol<TKilogramSquareMeterPerAmperePerCubicSecondRec>;
  TKilogramSquareMetersPerAmperePerCubicSecond = TQuantity;

var
  KilogramSquareMeterPerAmperePerCubicSecond : TKilogramSquareMeterPerAmperePerCubicSecondUnit;
  KilogramSquareMeterPerAmperePerCubicSecondUnit : TKilogramSquareMeterPerAmperePerCubicSecondUnit;

{ TSquareVolt }

const
  cSquareVolt = 62;

type
  TSquareVoltRec = record
    const FUnitOfMeasurement = cSquareVolt;
    const FSymbol            = '%sV2';
    const FName              = 'square %svolt';
    const FPluralName        = 'square %svolts';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareVoltUnit = specialize TSymbol<TSquareVoltRec>;
  TSquareVolts = TQuantity;

var
  V2 : TSquareVoltUnit;
  SquareVoltUnit : TSquareVoltUnit;

const
  kV2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 62; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  mV2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 62; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}

{ TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecond }

type
  TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondRec = record
    const FUnitOfMeasurement = cSquareVolt;
    const FSymbol            = '%sg2.%sm3/%sA2/%ss6';
    const FName              = 'square %sgram quartic %smeter per square %sampere per sextic %ssecond';
    const FPluralName        = 'square %sgram quartic %smeters per square %sampere per sextic %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (2, 3, -2, -6);
  end;
  TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondUnit = specialize TSymbol<TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondRec>;
  TSquareKilogramQuarticMetersPerSquareAmperePerSexticSecond = TQuantity;

var
  SquareKilogramQuarticMeterPerSquareAmperePerSexticSecond : TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondUnit;
  SquareKilogramQuarticMeterPerSquareAmperePerSexticSecondUnit : TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondUnit;

{ TFarad }

const
  cFarad = 63;

type
  TFaradRec = record
    const FUnitOfMeasurement = cFarad;
    const FSymbol            = '%sF';
    const FName              = '%sfarad';
    const FPluralName        = '%sfarads';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TFaradUnit = specialize TSymbol<TFaradRec>;
  TFarads = TQuantity;

var
  F : TFaradUnit;
  FaradUnit : TFaradUnit;

const
  mF         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 63; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miF        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 63; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nF         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 63; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pF         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 63; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TCoulombPerVolt }

type
  TCoulombPerVoltRec = record
    const FUnitOfMeasurement = cFarad;
    const FSymbol            = '%sC/%sV';
    const FName              = '%scoulomb per %svolt';
    const FPluralName        = '%scoulombs per %svolt';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TCoulombPerVoltUnit = specialize TSymbol<TCoulombPerVoltRec>;
  TCoulombsPerVolt = TQuantity;

var
  CoulombPerVolt : TCoulombPerVoltUnit;
  CoulombPerVoltUnit : TCoulombPerVoltUnit;

{ TSquareAmpereQuarticSecondPerKilogramPerSquareMeter }

type
  TSquareAmpereQuarticSecondPerKilogramPerSquareMeterRec = record
    const FUnitOfMeasurement = cFarad;
    const FSymbol            = '%sA2.%ss4/%sg/%sm2';
    const FName              = 'square %sampere quartic %ssecond per %sgram per square %smeter';
    const FPluralName        = 'square %sampere quartic %sseconds per %sgram per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pKilo, pNone);
    const FExponents         : TExponents = (2, 4, -1, -2);
  end;
  TSquareAmpereQuarticSecondPerKilogramPerSquareMeterUnit = specialize TSymbol<TSquareAmpereQuarticSecondPerKilogramPerSquareMeterRec>;
  TSquareAmpereQuarticSecondsPerKilogramPerSquareMeter = TQuantity;

var
  SquareAmpereQuarticSecondPerKilogramPerSquareMeter : TSquareAmpereQuarticSecondPerKilogramPerSquareMeterUnit;
  SquareAmpereQuarticSecondPerKilogramPerSquareMeterUnit : TSquareAmpereQuarticSecondPerKilogramPerSquareMeterUnit;

{ TOhm }

const
  cOhm = 64;

type
  TOhmRec = record
    const FUnitOfMeasurement = cOhm;
    const FSymbol            = '%sΩ';
    const FName              = '%sohm';
    const FPluralName        = '%sohms';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TOhmUnit = specialize TSymbol<TOhmRec>;
  TOhms = TQuantity;

var
  ohm : TOhmUnit;
  OhmUnit : TOhmUnit;

const
  Gohm       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 64; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  megaohm    : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 64; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kohm       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 64; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mohm       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 64; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miohm      : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 64; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nohm       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 64; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TKilogramSquareMeterPerSquareAmperePerCubicSecond }

type
  TKilogramSquareMeterPerSquareAmperePerCubicSecondRec = record
    const FUnitOfMeasurement = cOhm;
    const FSymbol            = '%sg.%sm2/%sA/%ss3';
    const FName              = '%sgram square %smeter per square %sampere per cubic %ssecond';
    const FPluralName        = '%sgram square %smeters per square %sampere per cubic %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -1, -3);
  end;
  TKilogramSquareMeterPerSquareAmperePerCubicSecondUnit = specialize TSymbol<TKilogramSquareMeterPerSquareAmperePerCubicSecondRec>;
  TKilogramSquareMetersPerSquareAmperePerCubicSecond = TQuantity;

var
  KilogramSquareMeterPerSquareAmperePerCubicSecond : TKilogramSquareMeterPerSquareAmperePerCubicSecondUnit;
  KilogramSquareMeterPerSquareAmperePerCubicSecondUnit : TKilogramSquareMeterPerSquareAmperePerCubicSecondUnit;

{ TSiemens }

const
  cSiemens = 65;

type
  TSiemensRec = record
    const FUnitOfMeasurement = cSiemens;
    const FSymbol            = '%sS';
    const FName              = '%ssiemens';
    const FPluralName        = '%ssiemens';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TSiemensUnit = specialize TSymbol<TSiemensRec>;
  TSiemens = TQuantity;

var
  siemens : TSiemensUnit;
  SiemensUnit : TSiemensUnit;

const
  millisiemens : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 65; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  microsiemens : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 65; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
   nanosiemens : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 65; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TSquareAmpereCubicSecondPerKilogramPerSquareMeter }

type
  TSquareAmpereCubicSecondPerKilogramPerSquareMeterRec = record
    const FUnitOfMeasurement = cSiemens;
    const FSymbol            = '%sA2.%ss3/%sg/%sm2';
    const FName              = 'square %sampere cubic %ssecond per %sgram per square %smeter';
    const FPluralName        = 'square %sampere cubic %sseconds per %sgram per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pKilo, pNone);
    const FExponents         : TExponents = (2, 3, -1, -2);
  end;
  TSquareAmpereCubicSecondPerKilogramPerSquareMeterUnit = specialize TSymbol<TSquareAmpereCubicSecondPerKilogramPerSquareMeterRec>;
  TSquareAmpereCubicSecondsPerKilogramPerSquareMeter = TQuantity;

var
  SquareAmpereCubicSecondPerKilogramPerSquareMeter : TSquareAmpereCubicSecondPerKilogramPerSquareMeterUnit;
  SquareAmpereCubicSecondPerKilogramPerSquareMeterUnit : TSquareAmpereCubicSecondPerKilogramPerSquareMeterUnit;

{ TSiemensPerMeter }

const
  cSiemensPerMeter = 66;

type
  TSiemensPerMeterRec = record
    const FUnitOfMeasurement = cSiemensPerMeter;
    const FSymbol            = '%sS/%sm';
    const FName              = '%ssiemens per %smeter';
    const FPluralName        = '%ssiemens per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TSiemensPerMeterUnit = specialize TSymbol<TSiemensPerMeterRec>;
  TSiemensPerMeter = TQuantity;

var
  SiemensPerMeter : TSiemensPerMeterUnit;
  SiemensPerMeterUnit : TSiemensPerMeterUnit;

{ TTesla }

const
  cTesla = 67;

type
  TTeslaRec = record
    const FUnitOfMeasurement = cTesla;
    const FSymbol            = '%sT';
    const FName              = '%stesla';
    const FPluralName        = '%steslas';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TTeslaUnit = specialize TSymbol<TTeslaRec>;
  TTeslas = TQuantity;

var
  T : TTeslaUnit;
  TeslaUnit : TTeslaUnit;

const
  mT         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 67; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miT        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 67; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nT         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 67; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TWeberPerSquareMeter }

type
  TWeberPerSquareMeterRec = record
    const FUnitOfMeasurement = cTesla;
    const FSymbol            = '%sWb/%m2';
    const FName              = '%sweber per square %smeter';
    const FPluralName        = '%swebers per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TWeberPerSquareMeterUnit = specialize TSymbol<TWeberPerSquareMeterRec>;
  TWebersPerSquareMeter = TQuantity;

var
  WeberPerSquareMeter : TWeberPerSquareMeterUnit;
  WeberPerSquareMeterUnit : TWeberPerSquareMeterUnit;

{ TKilogramPerAmperePerSquareSecond }

type
  TKilogramPerAmperePerSquareSecondRec = record
    const FUnitOfMeasurement = cTesla;
    const FSymbol            = '%sg/%sA/%ss2';
    const FName              = '%sgram per %sampere per square %ssecond';
    const FPluralName        = '%sgrams per %sampere per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, -1, -2);
  end;
  TKilogramPerAmperePerSquareSecondUnit = specialize TSymbol<TKilogramPerAmperePerSquareSecondRec>;
  TKilogramsPerAmperePerSquareSecond = TQuantity;

var
  KilogramPerAmperePerSquareSecond : TKilogramPerAmperePerSquareSecondUnit;
  KilogramPerAmperePerSquareSecondUnit : TKilogramPerAmperePerSquareSecondUnit;

{ TWeber }

const
  cWeber = 68;

type
  TWeberRec = record
    const FUnitOfMeasurement = cWeber;
    const FSymbol            = '%sWb';
    const FName              = '%sweber';
    const FPluralName        = '%swebers';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TWeberUnit = specialize TSymbol<TWeberRec>;
  TWebers = TQuantity;

var
  Wb : TWeberUnit;
  WeberUnit : TWeberUnit;

{ TKilogramSquareMeterPerAmperePerSquareSecond }

type
  TKilogramSquareMeterPerAmperePerSquareSecondRec = record
    const FUnitOfMeasurement = cWeber;
    const FSymbol            = '%sg.%sm2/%sA/%ss2';
    const FName              = '%sgram square %smeter per %sampere per square %ssecond';
    const FPluralName        = '%sgram square %smeters per %sampere per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -1, -2);
  end;
  TKilogramSquareMeterPerAmperePerSquareSecondUnit = specialize TSymbol<TKilogramSquareMeterPerAmperePerSquareSecondRec>;
  TKilogramSquareMetersPerAmperePerSquareSecond = TQuantity;

var
  KilogramSquareMeterPerAmperePerSquareSecond : TKilogramSquareMeterPerAmperePerSquareSecondUnit;
  KilogramSquareMeterPerAmperePerSquareSecondUnit : TKilogramSquareMeterPerAmperePerSquareSecondUnit;

{ THenry }

const
  cHenry = 69;

type
  THenryRec = record
    const FUnitOfMeasurement = cHenry;
    const FSymbol            = '%sH';
    const FName              = '%shenry';
    const FPluralName        = '%shenries';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  THenryUnit = specialize TSymbol<THenryRec>;
  THenries = TQuantity;

var
  H : THenryUnit;
  HenryUnit : THenryUnit;

const
  mH         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 69; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miH        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 69; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nH         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 69; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TKilogramSquareMeterPerSquareAmperePerSquareSecond }

type
  TKilogramSquareMeterPerSquareAmperePerSquareSecondRec = record
    const FUnitOfMeasurement = cHenry;
    const FSymbol            = '%sg.%sm2/%sA2/%ss2';
    const FName              = '%sgram square %smeter per square %sampere per square %ssecond';
    const FPluralName        = '%sgram square %smeters per square %sampere per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -2, -2);
  end;
  TKilogramSquareMeterPerSquareAmperePerSquareSecondUnit = specialize TSymbol<TKilogramSquareMeterPerSquareAmperePerSquareSecondRec>;
  TKilogramSquareMetersPerSquareAmperePerSquareSecond = TQuantity;

var
  KilogramSquareMeterPerSquareAmperePerSquareSecond : TKilogramSquareMeterPerSquareAmperePerSquareSecondUnit;
  KilogramSquareMeterPerSquareAmperePerSquareSecondUnit : TKilogramSquareMeterPerSquareAmperePerSquareSecondUnit;

{ TReciprocalHenry }

const
  cReciprocalHenry = 70;

type
  TReciprocalHenryRec = record
    const FUnitOfMeasurement = cReciprocalHenry;
    const FSymbol            = '1/%sH';
    const FName              = 'reciprocal %shenry';
    const FPluralName        = 'reciprocal %shenries';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalHenryUnit = specialize TSymbol<TReciprocalHenryRec>;
  TReciprocalHenries = TQuantity;

var
  ReciprocalHenry : TReciprocalHenryUnit;
  ReciprocalHenryUnit : TReciprocalHenryUnit;

{ TLumen }

type
  TLumenRec = record
    const FUnitOfMeasurement = cCandela;
    const FSymbol            = '%slm';
    const FName              = '%slumen';
    const FPluralName        = '%slumens';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TLumenUnit = specialize TSymbol<TLumenRec>;
  TLumens = TQuantity;

var
  lm : TLumenUnit;
  LumenUnit : TLumenUnit;

{ TCandelaSteradian }

type
  TCandelaSteradianRec = record
    const FUnitOfMeasurement = cCandela;
    const FSymbol            = '%scd.%ssr';
    const FName              = '%scandela %ssteradian';
    const FPluralName        = '%scandela %ssteradians';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TCandelaSteradianUnit = specialize TSymbol<TCandelaSteradianRec>;
  TCandelaSteradians = TQuantity;

var
  CandelaSteradian : TCandelaSteradianUnit;
  CandelaSteradianUnit : TCandelaSteradianUnit;

{ TLumenSecond }

const
  cLumenSecond = 71;

type
  TLumenSecondRec = record
    const FUnitOfMeasurement = cLumenSecond;
    const FSymbol            = '%slm.%ss';
    const FName              = '%slumen %ssecond';
    const FPluralName        = '%slumen %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TLumenSecondUnit = specialize TSymbol<TLumenSecondRec>;
  TLumenSeconds = TQuantity;

var
  LumenSecond : TLumenSecondUnit;
  LumenSecondUnit : TLumenSecondUnit;

{ TLumenSecondPerCubicMeter }

const
  cLumenSecondPerCubicMeter = 72;

type
  TLumenSecondPerCubicMeterRec = record
    const FUnitOfMeasurement = cLumenSecondPerCubicMeter;
    const FSymbol            = '%slm.%ss/%sm3';
    const FName              = '%slumen %ssecond per cubic meter';
    const FPluralName        = '%slumen %sseconds per cubic meter';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -3);
  end;
  TLumenSecondPerCubicMeterUnit = specialize TSymbol<TLumenSecondPerCubicMeterRec>;
  TLumenSecondsPerCubicMeter = TQuantity;

var
  LumenSecondPerCubicMeter : TLumenSecondPerCubicMeterUnit;
  LumenSecondPerCubicMeterUnit : TLumenSecondPerCubicMeterUnit;

{ TLux }

const
  cLux = 73;

type
  TLuxRec = record
    const FUnitOfMeasurement = cLux;
    const FSymbol            = '%slx';
    const FName              = '%slux';
    const FPluralName        = '%slux';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TLuxUnit = specialize TSymbol<TLuxRec>;
  TLux = TQuantity;

var
  lx : TLuxUnit;
  LuxUnit : TLuxUnit;

{ TCandelaSteradianPerSquareMeter }

type
  TCandelaSteradianPerSquareMeterRec = record
    const FUnitOfMeasurement = cLux;
    const FSymbol            = '%scd.%ssr/%sm2';
    const FName              = '%scandela %ssteradian per square %smeter';
    const FPluralName        = '%scandela %ssteradians per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -2);
  end;
  TCandelaSteradianPerSquareMeterUnit = specialize TSymbol<TCandelaSteradianPerSquareMeterRec>;
  TCandelaSteradiansPerSquareMeter = TQuantity;

var
  CandelaSteradianPerSquareMeter : TCandelaSteradianPerSquareMeterUnit;
  CandelaSteradianPerSquareMeterUnit : TCandelaSteradianPerSquareMeterUnit;

{ TLuxSecond }

const
  cLuxSecond = 74;

type
  TLuxSecondRec = record
    const FUnitOfMeasurement = cLuxSecond;
    const FSymbol            = '%slx.%ss';
    const FName              = '%slux %ssecond';
    const FPluralName        = '%slux %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TLuxSecondUnit = specialize TSymbol<TLuxSecondRec>;
  TLuxSeconds = TQuantity;

var
  LuxSecond : TLuxSecondUnit;
  LuxSecondUnit : TLuxSecondUnit;

{ TBequerel }

type
  TBequerelRec = record
    const FUnitOfMeasurement = cHertz;
    const FSymbol            = '%sBq';
    const FName              = '%sbequerel';
    const FPluralName        = '%sbequerels';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TBequerelUnit = specialize TSymbol<TBequerelRec>;
  TBequerels = TQuantity;

var
  Bq : TBequerelUnit;
  BequerelUnit : TBequerelUnit;

const
  kBq        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mBq        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miBq       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nBq        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pBq        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TKatal }

const
  cKatal = 75;

type
  TKatalRec = record
    const FUnitOfMeasurement = cKatal;
    const FSymbol            = '%skat';
    const FName              = '%skatal';
    const FPluralName        = '%skatals';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TKatalUnit = specialize TSymbol<TKatalRec>;
  TKatals = TQuantity;

var
  kat : TKatalUnit;
  KatalUnit : TKatalUnit;

{ TMolePerSecond }

type
  TMolePerSecondRec = record
    const FUnitOfMeasurement = cKatal;
    const FSymbol            = '%smol/%ss';
    const FName              = '%smole per %ssecond';
    const FPluralName        = '%smoles per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TMolePerSecondUnit = specialize TSymbol<TMolePerSecondRec>;
  TMolesPerSecond = TQuantity;

var
  MolePerSecond : TMolePerSecondUnit;
  MolePerSecondUnit : TMolePerSecondUnit;

{ TNewtonPerCubicMeter }

const
  cNewtonPerCubicMeter = 76;

type
  TNewtonPerCubicMeterRec = record
    const FUnitOfMeasurement = cNewtonPerCubicMeter;
    const FSymbol            = '%sN/%sm3';
    const FName              = '%snewton per cubic %smeter';
    const FPluralName        = '%snewtons per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TNewtonPerCubicMeterUnit = specialize TSymbol<TNewtonPerCubicMeterRec>;
  TNewtonsPerCubicMeter = TQuantity;

var
  NewtonPerCubicMeter : TNewtonPerCubicMeterUnit;
  NewtonPerCubicMeterUnit : TNewtonPerCubicMeterUnit;

{ TPascalPerMeter }

type
  TPascalPerMeterRec = record
    const FUnitOfMeasurement = cNewtonPerCubicMeter;
    const FSymbol            = '%sPa/%sm';
    const FName              = '%spascal per %smeter';
    const FPluralName        = '%spascals per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TPascalPerMeterUnit = specialize TSymbol<TPascalPerMeterRec>;
  TPascalsPerMeter = TQuantity;

var
  PascalPerMeter : TPascalPerMeterUnit;
  PascalPerMeterUnit : TPascalPerMeterUnit;

{ TKilogramPerSquareMeterPerSquareSecond }

type
  TKilogramPerSquareMeterPerSquareSecondRec = record
    const FUnitOfMeasurement = cNewtonPerCubicMeter;
    const FSymbol            = '%sg/%sm2/%ss2';
    const FName              = '%sgram per square %smeter per square %ssecond';
    const FPluralName        = '%sgrams per square %smeter per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, -2, -2);
  end;
  TKilogramPerSquareMeterPerSquareSecondUnit = specialize TSymbol<TKilogramPerSquareMeterPerSquareSecondRec>;
  TKilogramsPerSquareMeterPerSquareSecond = TQuantity;

var
  KilogramPerSquareMeterPerSquareSecond : TKilogramPerSquareMeterPerSquareSecondUnit;
  KilogramPerSquareMeterPerSquareSecondUnit : TKilogramPerSquareMeterPerSquareSecondUnit;

{ TNewtonPerMeter }

const
  cNewtonPerMeter = 77;

type
  TNewtonPerMeterRec = record
    const FUnitOfMeasurement = cNewtonPerMeter;
    const FSymbol            = '%sN/%sm';
    const FName              = '%snewton per %smeter';
    const FPluralName        = '%snewtons per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TNewtonPerMeterUnit = specialize TSymbol<TNewtonPerMeterRec>;
  TNewtonsPerMeter = TQuantity;

var
  NewtonPerMeter : TNewtonPerMeterUnit;
  NewtonPerMeterUnit : TNewtonPerMeterUnit;

{ TJoulePerSquareMeter }

type
  TJoulePerSquareMeterRec = record
    const FUnitOfMeasurement = cNewtonPerMeter;
    const FSymbol            = '%sJ/%sm2';
    const FName              = '%sjoule per square %smeter';
    const FPluralName        = '%sjoules per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TJoulePerSquareMeterUnit = specialize TSymbol<TJoulePerSquareMeterRec>;
  TJoulesPerSquareMeter = TQuantity;

var
  JoulePerSquareMeter : TJoulePerSquareMeterUnit;
  JoulePerSquareMeterUnit : TJoulePerSquareMeterUnit;

{ TWattPerSquareMeterPerHertz }

type
  TWattPerSquareMeterPerHertzRec = record
    const FUnitOfMeasurement = cNewtonPerMeter;
    const FSymbol            = '%sW/%sm2/%sHz';
    const FName              = '%swatt per square %smeter per %shertz';
    const FPluralName        = '%swatts per square %smeter per %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -2, -1);
  end;
  TWattPerSquareMeterPerHertzUnit = specialize TSymbol<TWattPerSquareMeterPerHertzRec>;
  TWattsPerSquareMeterPerHertz = TQuantity;

var
  WattPerSquareMeterPerHertz : TWattPerSquareMeterPerHertzUnit;
  WattPerSquareMeterPerHertzUnit : TWattPerSquareMeterPerHertzUnit;

{ TPoundForcePerInch }

type
  TPoundForcePerInchRec = record
    const FUnitOfMeasurement = cNewtonPerMeter;
    const FSymbol            = 'lbf/in';
    const FName              = 'pound-force per inch';
    const FPluralName        = 'pounds-force per inch';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TPoundForcePerInchUnit = specialize TFactoredSymbol<TPoundForcePerInchRec>;
  TPoundsForcePerInch = TQuantity;

const
  PoundForcePerInch : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 77; FValue: 175.126835246476); {$ELSE} (175.126835246476); {$ENDIF}

var
  PoundForcePerInchUnit : TPoundForcePerInchUnit;

{ TKilogramPerSquareSecond }

type
  TKilogramPerSquareSecondRec = record
    const FUnitOfMeasurement = cNewtonPerMeter;
    const FSymbol            = '%sg/%ss2';
    const FName              = '%sgram per square %ssecond';
    const FPluralName        = '%sgrams per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TKilogramPerSquareSecondUnit = specialize TSymbol<TKilogramPerSquareSecondRec>;
  TKilogramsPerSquareSecond = TQuantity;

var
  KilogramPerSquareSecond : TKilogramPerSquareSecondUnit;
  KilogramPerSquareSecondUnit : TKilogramPerSquareSecondUnit;

{ TCubicMeterPerSecond }

const
  cCubicMeterPerSecond = 78;

type
  TCubicMeterPerSecondRec = record
    const FUnitOfMeasurement = cCubicMeterPerSecond;
    const FSymbol            = '%sm3/%ss';
    const FName              = 'cubic %smeter per %ssecond';
    const FPluralName        = 'cubic %smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (3, -1);
  end;
  TCubicMeterPerSecondUnit = specialize TSymbol<TCubicMeterPerSecondRec>;
  TCubicMetersPerSecond = TQuantity;

var
  CubicMeterPerSecond : TCubicMeterPerSecondUnit;
  CubicMeterPerSecondUnit : TCubicMeterPerSecondUnit;

{ TPoiseuille }

const
  cPoiseuille = 79;

type
  TPoiseuilleRec = record
    const FUnitOfMeasurement = cPoiseuille;
    const FSymbol            = '%sPl';
    const FName              = '%spoiseuille';
    const FPluralName        = '%spoiseuilles';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TPoiseuilleUnit = specialize TSymbol<TPoiseuilleRec>;
  TPoiseuilles = TQuantity;

var
  Pl : TPoiseuilleUnit;
  PoiseuilleUnit : TPoiseuilleUnit;

const
  cPl        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 79; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mPl        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 79; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miPl       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 79; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}

{ TPascalSecond }

type
  TPascalSecondRec = record
    const FUnitOfMeasurement = cPoiseuille;
    const FSymbol            = '%sPa.%ss';
    const FName              = '%spascal %ssecond';
    const FPluralName        = '%spascal %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TPascalSecondUnit = specialize TSymbol<TPascalSecondRec>;
  TPascalSeconds = TQuantity;

var
  PascalSecond : TPascalSecondUnit;
  PascalSecondUnit : TPascalSecondUnit;

{ TKilogramPerMeterPerSecond }

type
  TKilogramPerMeterPerSecondRec = record
    const FUnitOfMeasurement = cPoiseuille;
    const FSymbol            = '%sg/%sm/%ss';
    const FName              = '%sgram per %smeter per %ssecond';
    const FPluralName        = '%sgrams per %smeter per %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, -1, -1);
  end;
  TKilogramPerMeterPerSecondUnit = specialize TSymbol<TKilogramPerMeterPerSecondRec>;
  TKilogramsPerMeterPerSecond = TQuantity;

var
  KilogramPerMeterPerSecond : TKilogramPerMeterPerSecondUnit;
  KilogramPerMeterPerSecondUnit : TKilogramPerMeterPerSecondUnit;

{ TSquareMeterPerSecond }

const
  cSquareMeterPerSecond = 80;

type
  TSquareMeterPerSecondRec = record
    const FUnitOfMeasurement = cSquareMeterPerSecond;
    const FSymbol            = '%sm2/%ss';
    const FName              = 'square %smeter per %ssecond';
    const FPluralName        = 'square %smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, -1);
  end;
  TSquareMeterPerSecondUnit = specialize TSymbol<TSquareMeterPerSecondRec>;
  TSquareMetersPerSecond = TQuantity;

var
  SquareMeterPerSecond : TSquareMeterPerSecondUnit;
  SquareMeterPerSecondUnit : TSquareMeterPerSecondUnit;

{ TKilogramPerQuarticMeter }

const
  cKilogramPerQuarticMeter = 81;

type
  TKilogramPerQuarticMeterRec = record
    const FUnitOfMeasurement = cKilogramPerQuarticMeter;
    const FSymbol            = '%sg/%sm4';
    const FName              = '%sgram per quartic %smeter';
    const FPluralName        = '%sgrams per quartic %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -4);
  end;
  TKilogramPerQuarticMeterUnit = specialize TSymbol<TKilogramPerQuarticMeterRec>;
  TKilogramsPerQuarticMeter = TQuantity;

var
  KilogramPerQuarticMeter : TKilogramPerQuarticMeterUnit;
  KilogramPerQuarticMeterUnit : TKilogramPerQuarticMeterUnit;

{ TQuarticMeterSecond }

const
  cQuarticMeterSecond = 82;

type
  TQuarticMeterSecondRec = record
    const FUnitOfMeasurement = cQuarticMeterSecond;
    const FSymbol            = '%sm4.%ss';
    const FName              = 'quartic %smeter %ssecond';
    const FPluralName        = 'quartic %smeter %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (4, 1);
  end;
  TQuarticMeterSecondUnit = specialize TSymbol<TQuarticMeterSecondRec>;
  TQuarticMeterSeconds = TQuantity;

var
  QuarticMeterSecond : TQuarticMeterSecondUnit;
  QuarticMeterSecondUnit : TQuarticMeterSecondUnit;

{ TKilogramPerQuarticMeterPerSecond }

const
  cKilogramPerQuarticMeterPerSecond = 83;

type
  TKilogramPerQuarticMeterPerSecondRec = record
    const FUnitOfMeasurement = cKilogramPerQuarticMeterPerSecond;
    const FSymbol            = '%sg/%sm4/%ss';
    const FName              = '%sgram per quartic %smeter per %ssecond';
    const FPluralName        = '%sgrams per quartic %smeter per %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, -4, -1);
  end;
  TKilogramPerQuarticMeterPerSecondUnit = specialize TSymbol<TKilogramPerQuarticMeterPerSecondRec>;
  TKilogramsPerQuarticMeterPerSecond = TQuantity;

var
  KilogramPerQuarticMeterPerSecond : TKilogramPerQuarticMeterPerSecondUnit;
  KilogramPerQuarticMeterPerSecondUnit : TKilogramPerQuarticMeterPerSecondUnit;

{ TCubicMeterPerKilogram }

const
  cCubicMeterPerKilogram = 84;

type
  TCubicMeterPerKilogramRec = record
    const FUnitOfMeasurement = cCubicMeterPerKilogram;
    const FSymbol            = '%sm3/%sg';
    const FName              = 'cubic %smeter per %sgram';
    const FPluralName        = 'cubic %smeters per %sgram';
    const FPrefixes          : TPrefixes  = (pNone, pKilo);
    const FExponents         : TExponents = (3, -1);
  end;
  TCubicMeterPerKilogramUnit = specialize TSymbol<TCubicMeterPerKilogramRec>;
  TCubicMetersPerKilogram = TQuantity;

var
  CubicMeterPerKilogram : TCubicMeterPerKilogramUnit;
  CubicMeterPerKilogramUnit : TCubicMeterPerKilogramUnit;

{ TKilogramSquareSecond }

const
  cKilogramSquareSecond = 85;

type
  TKilogramSquareSecondRec = record
    const FUnitOfMeasurement = cKilogramSquareSecond;
    const FSymbol            = '%sg.%ss2';
    const FName              = '%sgram square %ssecond';
    const FPluralName        = '%sgram square %sseconds';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, 2);
  end;
  TKilogramSquareSecondUnit = specialize TSymbol<TKilogramSquareSecondRec>;
  TKilogramSquareSeconds = TQuantity;

var
  KilogramSquareSecond : TKilogramSquareSecondUnit;
  KilogramSquareSecondUnit : TKilogramSquareSecondUnit;

{ TCubicMeterPerSquareSecond }

const
  cCubicMeterPerSquareSecond = 86;

type
  TCubicMeterPerSquareSecondRec = record
    const FUnitOfMeasurement = cCubicMeterPerSquareSecond;
    const FSymbol            = '%sm3/%ss2';
    const FName              = 'cubic %smeter per square %ssecond';
    const FPluralName        = 'cubic %smeters per square %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (3, -2);
  end;
  TCubicMeterPerSquareSecondUnit = specialize TSymbol<TCubicMeterPerSquareSecondRec>;
  TCubicMetersPerSquareSecond = TQuantity;

var
  CubicMeterPerSquareSecond : TCubicMeterPerSquareSecondUnit;
  CubicMeterPerSquareSecondUnit : TCubicMeterPerSquareSecondUnit;

{ TNewtonSquareMeter }

const
  cNewtonSquareMeter = 87;

type
  TNewtonSquareMeterRec = record
    const FUnitOfMeasurement = cNewtonSquareMeter;
    const FSymbol            = '%sN.%sm2';
    const FName              = '%snewton square %smeter';
    const FPluralName        = '%snewton square %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 2);
  end;
  TNewtonSquareMeterUnit = specialize TSymbol<TNewtonSquareMeterRec>;
  TNewtonSquareMeters = TQuantity;

var
  NewtonSquareMeter : TNewtonSquareMeterUnit;
  NewtonSquareMeterUnit : TNewtonSquareMeterUnit;

{ TKilogramCubicMeterPerSquareSecond }

type
  TKilogramCubicMeterPerSquareSecondRec = record
    const FUnitOfMeasurement = cNewtonSquareMeter;
    const FSymbol            = '%sg.%sm3/%ss2';
    const FName              = '%sgram cubic %smeter per square %ssecond';
    const FPluralName        = '%sgram cubic %smeters per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 3, -2);
  end;
  TKilogramCubicMeterPerSquareSecondUnit = specialize TSymbol<TKilogramCubicMeterPerSquareSecondRec>;
  TKilogramCubicMetersPerSquareSecond = TQuantity;

var
  KilogramCubicMeterPerSquareSecond : TKilogramCubicMeterPerSquareSecondUnit;
  KilogramCubicMeterPerSquareSecondUnit : TKilogramCubicMeterPerSquareSecondUnit;

{ TNewtonCubicMeter }

const
  cNewtonCubicMeter = 88;

type
  TNewtonCubicMeterRec = record
    const FUnitOfMeasurement = cNewtonCubicMeter;
    const FSymbol            = '%sN.%sm3';
    const FName              = '%snewton cubic %smeter';
    const FPluralName        = '%snewton cubic %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 3);
  end;
  TNewtonCubicMeterUnit = specialize TSymbol<TNewtonCubicMeterRec>;
  TNewtonCubicMeters = TQuantity;

var
  NewtonCubicMeter : TNewtonCubicMeterUnit;
  NewtonCubicMeterUnit : TNewtonCubicMeterUnit;

{ TKilogramQuarticMeterPerSquareSecond }

type
  TKilogramQuarticMeterPerSquareSecondRec = record
    const FUnitOfMeasurement = cNewtonCubicMeter;
    const FSymbol            = '%sg.%sm4/%ss2';
    const FName              = '%sgram quartic %smeter per square %ssecond';
    const FPluralName        = '%sgram quartic %smeters per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 4, -2);
  end;
  TKilogramQuarticMeterPerSquareSecondUnit = specialize TSymbol<TKilogramQuarticMeterPerSquareSecondRec>;
  TKilogramQuarticMetersPerSquareSecond = TQuantity;

var
  KilogramQuarticMeterPerSquareSecond : TKilogramQuarticMeterPerSquareSecondUnit;
  KilogramQuarticMeterPerSquareSecondUnit : TKilogramQuarticMeterPerSquareSecondUnit;

{ TNewtonPerSquareKilogram }

const
  cNewtonPerSquareKilogram = 89;

type
  TNewtonPerSquareKilogramRec = record
    const FUnitOfMeasurement = cNewtonPerSquareKilogram;
    const FSymbol            = '%sN/%sg2';
    const FName              = '%snewton per square %sgram';
    const FPluralName        = '%snewtons per square %sgram';
    const FPrefixes          : TPrefixes  = (pNone, pKilo);
    const FExponents         : TExponents = (1, -2);
  end;
  TNewtonPerSquareKilogramUnit = specialize TSymbol<TNewtonPerSquareKilogramRec>;
  TNewtonsPerSquareKilogram = TQuantity;

var
  NewtonPerSquareKilogram : TNewtonPerSquareKilogramUnit;
  NewtonPerSquareKilogramUnit : TNewtonPerSquareKilogramUnit;

{ TMeterPerKilogramPerSquareSecond }

type
  TMeterPerKilogramPerSquareSecondRec = record
    const FUnitOfMeasurement = cNewtonPerSquareKilogram;
    const FSymbol            = '%sm/%sg/%ss2';
    const FName              = '%smeter per %sgram per square %ssecond';
    const FPluralName        = '%smeters per %sgram per square %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pKilo, pNone);
    const FExponents         : TExponents = (1, -1, -2);
  end;
  TMeterPerKilogramPerSquareSecondUnit = specialize TSymbol<TMeterPerKilogramPerSquareSecondRec>;
  TMetersPerKilogramPerSquareSecond = TQuantity;

var
  MeterPerKilogramPerSquareSecond : TMeterPerKilogramPerSquareSecondUnit;
  MeterPerKilogramPerSquareSecondUnit : TMeterPerKilogramPerSquareSecondUnit;

{ TSquareKilogramPerMeter }

const
  cSquareKilogramPerMeter = 90;

type
  TSquareKilogramPerMeterRec = record
    const FUnitOfMeasurement = cSquareKilogramPerMeter;
    const FSymbol            = '%sg2/%sm';
    const FName              = 'square %sgram per %smeter';
    const FPluralName        = 'square %sgrams per %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (2, -1);
  end;
  TSquareKilogramPerMeterUnit = specialize TSymbol<TSquareKilogramPerMeterRec>;
  TSquareKilogramsPerMeter = TQuantity;

var
  SquareKilogramPerMeter : TSquareKilogramPerMeterUnit;
  SquareKilogramPerMeterUnit : TSquareKilogramPerMeterUnit;

{ TSquareKilogramPerSquareMeter }

const
  cSquareKilogramPerSquareMeter = 91;

type
  TSquareKilogramPerSquareMeterRec = record
    const FUnitOfMeasurement = cSquareKilogramPerSquareMeter;
    const FSymbol            = '%sg2/%sm2';
    const FName              = 'square %sgram per square %smeter';
    const FPluralName        = 'square %sgrams per square %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareKilogramPerSquareMeterUnit = specialize TSymbol<TSquareKilogramPerSquareMeterRec>;
  TSquareKilogramsPerSquareMeter = TQuantity;

var
  SquareKilogramPerSquareMeter : TSquareKilogramPerSquareMeterUnit;
  SquareKilogramPerSquareMeterUnit : TSquareKilogramPerSquareMeterUnit;

{ TSquareMeterPerSquareKilogram }

const
  cSquareMeterPerSquareKilogram = 92;

type
  TSquareMeterPerSquareKilogramRec = record
    const FUnitOfMeasurement = cSquareMeterPerSquareKilogram;
    const FSymbol            = '%sm2/%sg2';
    const FName              = 'square %smeter per square %sgram';
    const FPluralName        = 'square %smeters per square %sgram';
    const FPrefixes          : TPrefixes  = (pNone, pKilo);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareMeterPerSquareKilogramUnit = specialize TSymbol<TSquareMeterPerSquareKilogramRec>;
  TSquareMetersPerSquareKilogram = TQuantity;

var
  SquareMeterPerSquareKilogram : TSquareMeterPerSquareKilogramUnit;
  SquareMeterPerSquareKilogramUnit : TSquareMeterPerSquareKilogramUnit;

{ TNewtonSquareMeterPerSquareKilogram }

const
  cNewtonSquareMeterPerSquareKilogram = 93;

type
  TNewtonSquareMeterPerSquareKilogramRec = record
    const FUnitOfMeasurement = cNewtonSquareMeterPerSquareKilogram;
    const FSymbol            = '%sN.%sm2/%sg2';
    const FName              = '%snewton square %smeter per square %sgram';
    const FPluralName        = '%snewton square %smeters per square %sgram';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pKilo);
    const FExponents         : TExponents = (1, 2, -2);
  end;
  TNewtonSquareMeterPerSquareKilogramUnit = specialize TSymbol<TNewtonSquareMeterPerSquareKilogramRec>;
  TNewtonSquareMetersPerSquareKilogram = TQuantity;

var
  NewtonSquareMeterPerSquareKilogram : TNewtonSquareMeterPerSquareKilogramUnit;
  NewtonSquareMeterPerSquareKilogramUnit : TNewtonSquareMeterPerSquareKilogramUnit;

{ TCubicMeterPerKilogramPerSquareSecond }

type
  TCubicMeterPerKilogramPerSquareSecondRec = record
    const FUnitOfMeasurement = cNewtonSquareMeterPerSquareKilogram;
    const FSymbol            = '%sm3/%sg/%ss2';
    const FName              = 'cubic %smeter per %sgram per square %ssecond';
    const FPluralName        = 'cubic %smeters per %sgram per square %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pKilo, pNone);
    const FExponents         : TExponents = (3, -1, -2);
  end;
  TCubicMeterPerKilogramPerSquareSecondUnit = specialize TSymbol<TCubicMeterPerKilogramPerSquareSecondRec>;
  TCubicMetersPerKilogramPerSquareSecond = TQuantity;

var
  CubicMeterPerKilogramPerSquareSecond : TCubicMeterPerKilogramPerSquareSecondUnit;
  CubicMeterPerKilogramPerSquareSecondUnit : TCubicMeterPerKilogramPerSquareSecondUnit;

{ TReciprocalKelvin }

const
  cReciprocalKelvin = 94;

type
  TReciprocalKelvinRec = record
    const FUnitOfMeasurement = cReciprocalKelvin;
    const FSymbol            = '1/%sK';
    const FName              = 'reciprocal %skelvin';
    const FPluralName        = 'reciprocal %skelvin';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalKelvinUnit = specialize TSymbol<TReciprocalKelvinRec>;
  TReciprocalKelvins = TQuantity;

var
  ReciprocalKelvin : TReciprocalKelvinUnit;
  ReciprocalKelvinUnit : TReciprocalKelvinUnit;

{ TKilogramKelvin }

const
  cKilogramKelvin = 95;

type
  TKilogramKelvinRec = record
    const FUnitOfMeasurement = cKilogramKelvin;
    const FSymbol            = '%sg.%sK';
    const FName              = '%sgram %skelvin';
    const FPluralName        = '%sgram %skelvins';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TKilogramKelvinUnit = specialize TSymbol<TKilogramKelvinRec>;
  TKilogramKelvins = TQuantity;

var
  KilogramKelvin : TKilogramKelvinUnit;
  KilogramKelvinUnit : TKilogramKelvinUnit;

{ TJoulePerKelvin }

const
  cJoulePerKelvin = 96;

type
  TJoulePerKelvinRec = record
    const FUnitOfMeasurement = cJoulePerKelvin;
    const FSymbol            = '%sJ/%sK';
    const FName              = '%sjoule per %skelvin';
    const FPluralName        = '%sjoules per %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TJoulePerKelvinUnit = specialize TSymbol<TJoulePerKelvinRec>;
  TJoulesPerKelvin = TQuantity;

var
  JoulePerKelvin : TJoulePerKelvinUnit;
  JoulePerKelvinUnit : TJoulePerKelvinUnit;

{ TKilogramSquareMeterPerSquareSecondPerKelvin }

type
  TKilogramSquareMeterPerSquareSecondPerKelvinRec = record
    const FUnitOfMeasurement = cJoulePerKelvin;
    const FSymbol            = '%sg.%sm2/%ss2/%sK';
    const FName              = '%sgram square %smeter per square %ssecond per %skelvin';
    const FPluralName        = '%sgram square %smeters per square %ssecond per %skelvin';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -2, -1);
  end;
  TKilogramSquareMeterPerSquareSecondPerKelvinUnit = specialize TSymbol<TKilogramSquareMeterPerSquareSecondPerKelvinRec>;
  TKilogramSquareMetersPerSquareSecondPerKelvin = TQuantity;

var
  KilogramSquareMeterPerSquareSecondPerKelvin : TKilogramSquareMeterPerSquareSecondPerKelvinUnit;
  KilogramSquareMeterPerSquareSecondPerKelvinUnit : TKilogramSquareMeterPerSquareSecondPerKelvinUnit;

{ TJoulePerKilogramPerKelvin }

const
  cJoulePerKilogramPerKelvin = 97;

type
  TJoulePerKilogramPerKelvinRec = record
    const FUnitOfMeasurement = cJoulePerKilogramPerKelvin;
    const FSymbol            = '%sJ/%sg/%sK';
    const FName              = '%sjoule per %sgram per %skelvin';
    const FPluralName        = '%sjoules per %sgram per %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pKilo, pNone);
    const FExponents         : TExponents = (1, -1, -1);
  end;
  TJoulePerKilogramPerKelvinUnit = specialize TSymbol<TJoulePerKilogramPerKelvinRec>;
  TJoulesPerKilogramPerKelvin = TQuantity;

var
  JoulePerKilogramPerKelvin : TJoulePerKilogramPerKelvinUnit;
  JoulePerKilogramPerKelvinUnit : TJoulePerKilogramPerKelvinUnit;

{ TSquareMeterPerSquareSecondPerKelvin }

type
  TSquareMeterPerSquareSecondPerKelvinRec = record
    const FUnitOfMeasurement = cJoulePerKilogramPerKelvin;
    const FSymbol            = '%sm2/%ss2/%sK';
    const FName              = 'square %smeter per square %ssecond per %skelvin';
    const FPluralName        = 'square %smeters per square %ssecond per %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (2, -2, -1);
  end;
  TSquareMeterPerSquareSecondPerKelvinUnit = specialize TSymbol<TSquareMeterPerSquareSecondPerKelvinRec>;
  TSquareMetersPerSquareSecondPerKelvin = TQuantity;

var
  SquareMeterPerSquareSecondPerKelvin : TSquareMeterPerSquareSecondPerKelvinUnit;
  SquareMeterPerSquareSecondPerKelvinUnit : TSquareMeterPerSquareSecondPerKelvinUnit;

{ TMeterKelvin }

const
  cMeterKelvin = 98;

type
  TMeterKelvinRec = record
    const FUnitOfMeasurement = cMeterKelvin;
    const FSymbol            = '%sm.%sK';
    const FName              = '%smeter %skelvin';
    const FPluralName        = '%smeter %skelvins';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TMeterKelvinUnit = specialize TSymbol<TMeterKelvinRec>;
  TMeterKelvins = TQuantity;

var
  MeterKelvin : TMeterKelvinUnit;
  MeterKelvinUnit : TMeterKelvinUnit;

{ TKelvinPerMeter }

const
  cKelvinPerMeter = 99;

type
  TKelvinPerMeterRec = record
    const FUnitOfMeasurement = cKelvinPerMeter;
    const FSymbol            = '%sK/%sm';
    const FName              = '%skelvin per %smeter';
    const FPluralName        = '%skelvins per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TKelvinPerMeterUnit = specialize TSymbol<TKelvinPerMeterRec>;
  TKelvinsPerMeter = TQuantity;

var
  KelvinPerMeter : TKelvinPerMeterUnit;
  KelvinPerMeterUnit : TKelvinPerMeterUnit;

{ TWattPerMeter }

const
  cWattPerMeter = 100;

type
  TWattPerMeterRec = record
    const FUnitOfMeasurement = cWattPerMeter;
    const FSymbol            = '%sW/%sm';
    const FName              = '%swatt per %smeter';
    const FPluralName        = '%swatts per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TWattPerMeterUnit = specialize TSymbol<TWattPerMeterRec>;
  TWattsPerMeter = TQuantity;

var
  WattPerMeter : TWattPerMeterUnit;
  WattPerMeterUnit : TWattPerMeterUnit;

{ TKilogramMeterPerCubicSecond }

type
  TKilogramMeterPerCubicSecondRec = record
    const FUnitOfMeasurement = cWattPerMeter;
    const FSymbol            = '%sg.%sm/%ss3';
    const FName              = '%sgram %smeter per cubic %ssecond';
    const FPluralName        = '%sgram %smeters per cubic %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -3);
  end;
  TKilogramMeterPerCubicSecondUnit = specialize TSymbol<TKilogramMeterPerCubicSecondRec>;
  TKilogramMetersPerCubicSecond = TQuantity;

var
  KilogramMeterPerCubicSecond : TKilogramMeterPerCubicSecondUnit;
  KilogramMeterPerCubicSecondUnit : TKilogramMeterPerCubicSecondUnit;

{ TWattPerSquareMeter }

const
  cWattPerSquareMeter = 101;

type
  TWattPerSquareMeterRec = record
    const FUnitOfMeasurement = cWattPerSquareMeter;
    const FSymbol            = '%sW/%sm2';
    const FName              = '%swatt per square %smeter';
    const FPluralName        = '%swatts per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TWattPerSquareMeterUnit = specialize TSymbol<TWattPerSquareMeterRec>;
  TWattsPerSquareMeter = TQuantity;

var
  WattPerSquareMeter : TWattPerSquareMeterUnit;
  WattPerSquareMeterUnit : TWattPerSquareMeterUnit;

{ TKilogramPerCubicSecond }

type
  TKilogramPerCubicSecondRec = record
    const FUnitOfMeasurement = cWattPerSquareMeter;
    const FSymbol            = '%sg/%ss3';
    const FName              = '%sgram per cubic %ssecond';
    const FPluralName        = '%sgrams per cubic %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TKilogramPerCubicSecondUnit = specialize TSymbol<TKilogramPerCubicSecondRec>;
  TKilogramsPerCubicSecond = TQuantity;

var
  KilogramPerCubicSecond : TKilogramPerCubicSecondUnit;
  KilogramPerCubicSecondUnit : TKilogramPerCubicSecondUnit;

{ TWattPerCubicMeter }

const
  cWattPerCubicMeter = 102;

type
  TWattPerCubicMeterRec = record
    const FUnitOfMeasurement = cWattPerCubicMeter;
    const FSymbol            = '%sW/%sm3';
    const FName              = '%swatt per cubic %smeter';
    const FPluralName        = '%swatts per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TWattPerCubicMeterUnit = specialize TSymbol<TWattPerCubicMeterRec>;
  TWattsPerCubicMeter = TQuantity;

var
  WattPerCubicMeter : TWattPerCubicMeterUnit;
  WattPerCubicMeterUnit : TWattPerCubicMeterUnit;

{ TWattPerKelvin }

const
  cWattPerKelvin = 103;

type
  TWattPerKelvinRec = record
    const FUnitOfMeasurement = cWattPerKelvin;
    const FSymbol            = '%sW/%sK';
    const FName              = '%swatt per %skelvin';
    const FPluralName        = '%swatts per %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TWattPerKelvinUnit = specialize TSymbol<TWattPerKelvinRec>;
  TWattsPerKelvin = TQuantity;

var
  WattPerKelvin : TWattPerKelvinUnit;
  WattPerKelvinUnit : TWattPerKelvinUnit;

{ TKilogramSquareMeterPerCubicSecondPerKelvin }

type
  TKilogramSquareMeterPerCubicSecondPerKelvinRec = record
    const FUnitOfMeasurement = cWattPerKelvin;
    const FSymbol            = '%sg.%sm2/%ss3/%sK';
    const FName              = '%sgram square %smeter per cubic %ssecond per %skelvin';
    const FPluralName        = '%sgram square %smeters per cubic %ssecond per %skelvin';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -3, -1);
  end;
  TKilogramSquareMeterPerCubicSecondPerKelvinUnit = specialize TSymbol<TKilogramSquareMeterPerCubicSecondPerKelvinRec>;
  TKilogramSquareMetersPerCubicSecondPerKelvin = TQuantity;

var
  KilogramSquareMeterPerCubicSecondPerKelvin : TKilogramSquareMeterPerCubicSecondPerKelvinUnit;
  KilogramSquareMeterPerCubicSecondPerKelvinUnit : TKilogramSquareMeterPerCubicSecondPerKelvinUnit;

{ TWattPerMeterPerKelvin }

const
  cWattPerMeterPerKelvin = 104;

type
  TWattPerMeterPerKelvinRec = record
    const FUnitOfMeasurement = cWattPerMeterPerKelvin;
    const FSymbol            = '%sW/%sm/%sK';
    const FName              = '%swatt per %smeter per %skelvin';
    const FPluralName        = '%swatts per %smeter per %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -1, -1);
  end;
  TWattPerMeterPerKelvinUnit = specialize TSymbol<TWattPerMeterPerKelvinRec>;
  TWattsPerMeterPerKelvin = TQuantity;

var
  WattPerMeterPerKelvin : TWattPerMeterPerKelvinUnit;
  WattPerMeterPerKelvinUnit : TWattPerMeterPerKelvinUnit;

{ TKilogramMeterPerCubicSecondPerKelvin }

type
  TKilogramMeterPerCubicSecondPerKelvinRec = record
    const FUnitOfMeasurement = cWattPerMeterPerKelvin;
    const FSymbol            = '%sg.%sm/%ss3/%sK';
    const FName              = '%sgram %smeter per cubic %ssecond per %skelvin';
    const FPluralName        = '%sgram %smeters per cubic %ssecond per %skelvin';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -3, -1);
  end;
  TKilogramMeterPerCubicSecondPerKelvinUnit = specialize TSymbol<TKilogramMeterPerCubicSecondPerKelvinRec>;
  TKilogramMetersPerCubicSecondPerKelvin = TQuantity;

var
  KilogramMeterPerCubicSecondPerKelvin : TKilogramMeterPerCubicSecondPerKelvinUnit;
  KilogramMeterPerCubicSecondPerKelvinUnit : TKilogramMeterPerCubicSecondPerKelvinUnit;

{ TKelvinPerWatt }

const
  cKelvinPerWatt = 105;

type
  TKelvinPerWattRec = record
    const FUnitOfMeasurement = cKelvinPerWatt;
    const FSymbol            = '%sK/%sW';
    const FName              = '%skelvin per %swatt';
    const FPluralName        = '%skelvins per %swatt';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TKelvinPerWattUnit = specialize TSymbol<TKelvinPerWattRec>;
  TKelvinsPerWatt = TQuantity;

var
  KelvinPerWatt : TKelvinPerWattUnit;
  KelvinPerWattUnit : TKelvinPerWattUnit;

{ TMeterPerWatt }

const
  cMeterPerWatt = 106;

type
  TMeterPerWattRec = record
    const FUnitOfMeasurement = cMeterPerWatt;
    const FSymbol            = '%sm/%sW';
    const FName              = '%smeter per %swatt';
    const FPluralName        = '%smeters per %swatts';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TMeterPerWattUnit = specialize TSymbol<TMeterPerWattRec>;
  TMetersPerWatt = TQuantity;

var
  MeterPerWatt : TMeterPerWattUnit;
  MeterPerWattUnit : TMeterPerWattUnit;

{ TMeterKelvinPerWatt }

const
  cMeterKelvinPerWatt = 107;

type
  TMeterKelvinPerWattRec = record
    const FUnitOfMeasurement = cMeterKelvinPerWatt;
    const FSymbol            = '%sK.%sm/%sW';
    const FName              = '%skelvin %smeter per %swatt';
    const FPluralName        = '%skelvin %smeters per %swatt';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -1);
  end;
  TMeterKelvinPerWattUnit = specialize TSymbol<TMeterKelvinPerWattRec>;
  TMeterKelvinsPerWatt = TQuantity;

var
  MeterKelvinPerWatt : TMeterKelvinPerWattUnit;
  MeterKelvinPerWattUnit : TMeterKelvinPerWattUnit;

{ TSquareMeterKelvin }

const
  cSquareMeterKelvin = 108;

type
  TSquareMeterKelvinRec = record
    const FUnitOfMeasurement = cSquareMeterKelvin;
    const FSymbol            = '%sm2.%sK';
    const FName              = 'square %smeter %skelvin';
    const FPluralName        = 'square %smeter %skelvins';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 1);
  end;
  TSquareMeterKelvinUnit = specialize TSymbol<TSquareMeterKelvinRec>;
  TSquareMeterKelvins = TQuantity;

var
  SquareMeterKelvin : TSquareMeterKelvinUnit;
  SquareMeterKelvinUnit : TSquareMeterKelvinUnit;

{ TWattPerSquareMeterPerKelvin }

const
  cWattPerSquareMeterPerKelvin = 109;

type
  TWattPerSquareMeterPerKelvinRec = record
    const FUnitOfMeasurement = cWattPerSquareMeterPerKelvin;
    const FSymbol            = '%sW/%sm2/%sK';
    const FName              = '%swatt per square %smeter per %skelvin';
    const FPluralName        = '%swatts per square %smeter per %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -2, -1);
  end;
  TWattPerSquareMeterPerKelvinUnit = specialize TSymbol<TWattPerSquareMeterPerKelvinRec>;
  TWattsPerSquareMeterPerKelvin = TQuantity;

var
  WattPerSquareMeterPerKelvin : TWattPerSquareMeterPerKelvinUnit;
  WattPerSquareMeterPerKelvinUnit : TWattPerSquareMeterPerKelvinUnit;

{ TKilogramPerCubicSecondPerKelvin }

type
  TKilogramPerCubicSecondPerKelvinRec = record
    const FUnitOfMeasurement = cWattPerSquareMeterPerKelvin;
    const FSymbol            = '%sg/%ss3/%sK';
    const FName              = '%sgram per cubic %ssecond per %skelvin';
    const FPluralName        = '%sgrams per cubic %ssecond per %skelvin';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, -3, -1);
  end;
  TKilogramPerCubicSecondPerKelvinUnit = specialize TSymbol<TKilogramPerCubicSecondPerKelvinRec>;
  TKilogramsPerCubicSecondPerKelvin = TQuantity;

var
  KilogramPerCubicSecondPerKelvin : TKilogramPerCubicSecondPerKelvinUnit;
  KilogramPerCubicSecondPerKelvinUnit : TKilogramPerCubicSecondPerKelvinUnit;

{ TSquareMeterQuarticKelvin }

const
  cSquareMeterQuarticKelvin = 110;

type
  TSquareMeterQuarticKelvinRec = record
    const FUnitOfMeasurement = cSquareMeterQuarticKelvin;
    const FSymbol            = '%sm2.%sK4';
    const FName              = 'square %smeter quartic %skelvin';
    const FPluralName        = 'square %smeter quartic %skelvins';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 4);
  end;
  TSquareMeterQuarticKelvinUnit = specialize TSymbol<TSquareMeterQuarticKelvinRec>;
  TSquareMeterQuarticKelvins = TQuantity;

var
  SquareMeterQuarticKelvin : TSquareMeterQuarticKelvinUnit;
  SquareMeterQuarticKelvinUnit : TSquareMeterQuarticKelvinUnit;

{ TWattPerQuarticKelvin }

const
  cWattPerQuarticKelvin = 111;

type
  TWattPerQuarticKelvinRec = record
    const FUnitOfMeasurement = cWattPerQuarticKelvin;
    const FSymbol            = '%sW/%sK4';
    const FName              = '%swatt per quartic %skelvin';
    const FPluralName        = '%swatts per quartic %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -4);
  end;
  TWattPerQuarticKelvinUnit = specialize TSymbol<TWattPerQuarticKelvinRec>;
  TWattsPerQuarticKelvin = TQuantity;

var
  WattPerQuarticKelvin : TWattPerQuarticKelvinUnit;
  WattPerQuarticKelvinUnit : TWattPerQuarticKelvinUnit;

{ TWattPerSquareMeterPerQuarticKelvin }

const
  cWattPerSquareMeterPerQuarticKelvin = 112;

type
  TWattPerSquareMeterPerQuarticKelvinRec = record
    const FUnitOfMeasurement = cWattPerSquareMeterPerQuarticKelvin;
    const FSymbol            = '%sW/%sm2/%sK4';
    const FName              = '%swatt per square %smeter per quartic %skelvin';
    const FPluralName        = '%swatts per square %smeter per quartic %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -2, -4);
  end;
  TWattPerSquareMeterPerQuarticKelvinUnit = specialize TSymbol<TWattPerSquareMeterPerQuarticKelvinRec>;
  TWattsPerSquareMeterPerQuarticKelvin = TQuantity;

var
  WattPerSquareMeterPerQuarticKelvin : TWattPerSquareMeterPerQuarticKelvinUnit;
  WattPerSquareMeterPerQuarticKelvinUnit : TWattPerSquareMeterPerQuarticKelvinUnit;

{ TJoulePerMole }

const
  cJoulePerMole = 113;

type
  TJoulePerMoleRec = record
    const FUnitOfMeasurement = cJoulePerMole;
    const FSymbol            = '%sJ/%smol';
    const FName              = '%sjoule per %smole';
    const FPluralName        = '%sjoules per %smole';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TJoulePerMoleUnit = specialize TSymbol<TJoulePerMoleRec>;
  TJoulesPerMole = TQuantity;

var
  JoulePerMole : TJoulePerMoleUnit;
  JoulePerMoleUnit : TJoulePerMoleUnit;

{ TMoleKelvin }

const
  cMoleKelvin = 114;

type
  TMoleKelvinRec = record
    const FUnitOfMeasurement = cMoleKelvin;
    const FSymbol            = '%smol.%sK';
    const FName              = '%smole %skelvin';
    const FPluralName        = '%smole %skelvins';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TMoleKelvinUnit = specialize TSymbol<TMoleKelvinRec>;
  TMoleKelvins = TQuantity;

var
  MoleKelvin : TMoleKelvinUnit;
  MoleKelvinUnit : TMoleKelvinUnit;

{ TJoulePerMolePerKelvin }

const
  cJoulePerMolePerKelvin = 115;

type
  TJoulePerMolePerKelvinRec = record
    const FUnitOfMeasurement = cJoulePerMolePerKelvin;
    const FSymbol            = '%sJ/%smol/%sK';
    const FName              = '%sjoule per %smole per %skelvin';
    const FPluralName        = '%sjoules per %smole per %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -1, -1);
  end;
  TJoulePerMolePerKelvinUnit = specialize TSymbol<TJoulePerMolePerKelvinRec>;
  TJoulesPerMolePerKelvin = TQuantity;

var
  JoulePerMolePerKelvin : TJoulePerMolePerKelvinUnit;
  JoulePerMolePerKelvinUnit : TJoulePerMolePerKelvinUnit;

{ TOhmMeter }

const
  cOhmMeter = 116;

type
  TOhmMeterRec = record
    const FUnitOfMeasurement = cOhmMeter;
    const FSymbol            = '%sΩ.%sm';
    const FName              = '%sohm %smeter';
    const FPluralName        = '%sohm %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TOhmMeterUnit = specialize TSymbol<TOhmMeterRec>;
  TOhmMeters = TQuantity;

var
  OhmMeter : TOhmMeterUnit;
  OhmMeterUnit : TOhmMeterUnit;

{ TVoltPerMeter }

const
  cVoltPerMeter = 117;

type
  TVoltPerMeterRec = record
    const FUnitOfMeasurement = cVoltPerMeter;
    const FSymbol            = '%sV/%sm';
    const FName              = '%svolt per %smeter';
    const FPluralName        = '%svolts per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TVoltPerMeterUnit = specialize TSymbol<TVoltPerMeterRec>;
  TVoltsPerMeter = TQuantity;

var
  VoltPerMeter : TVoltPerMeterUnit;
  VoltPerMeterUnit : TVoltPerMeterUnit;

{ TNewtonPerCoulomb }

type
  TNewtonPerCoulombRec = record
    const FUnitOfMeasurement = cVoltPerMeter;
    const FSymbol            = '%sN/%sC';
    const FName              = '%snewton per %scoulomb';
    const FPluralName        = '%snewtons per %scoulomb';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TNewtonPerCoulombUnit = specialize TSymbol<TNewtonPerCoulombRec>;
  TNewtonsPerCoulomb = TQuantity;

var
  NewtonPerCoulomb : TNewtonPerCoulombUnit;
  NewtonPerCoulombUnit : TNewtonPerCoulombUnit;

{ TCoulombPerMeter }

const
  cCoulombPerMeter = 118;

type
  TCoulombPerMeterRec = record
    const FUnitOfMeasurement = cCoulombPerMeter;
    const FSymbol            = '%sC/%sm';
    const FName              = '%scoulomb per %smeter';
    const FPluralName        = '%scoulombs per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TCoulombPerMeterUnit = specialize TSymbol<TCoulombPerMeterRec>;
  TCoulombsPerMeter = TQuantity;

var
  CoulombPerMeter : TCoulombPerMeterUnit;
  CoulombPerMeterUnit : TCoulombPerMeterUnit;

{ TSquareCoulombPerMeter }

const
  cSquareCoulombPerMeter = 119;

type
  TSquareCoulombPerMeterRec = record
    const FUnitOfMeasurement = cSquareCoulombPerMeter;
    const FSymbol            = '%sC2/%sm';
    const FName              = 'square %scoulomb per %smeter';
    const FPluralName        = 'square %scoulombs per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, -1);
  end;
  TSquareCoulombPerMeterUnit = specialize TSymbol<TSquareCoulombPerMeterRec>;
  TSquareCoulombsPerMeter = TQuantity;

var
  SquareCoulombPerMeter : TSquareCoulombPerMeterUnit;
  SquareCoulombPerMeterUnit : TSquareCoulombPerMeterUnit;

{ TCoulombPerSquareMeter }

const
  cCoulombPerSquareMeter = 120;

type
  TCoulombPerSquareMeterRec = record
    const FUnitOfMeasurement = cCoulombPerSquareMeter;
    const FSymbol            = '%sC/%sm2';
    const FName              = '%scoulomb per square %smeter';
    const FPluralName        = '%scoulombs per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TCoulombPerSquareMeterUnit = specialize TSymbol<TCoulombPerSquareMeterRec>;
  TCoulombsPerSquareMeter = TQuantity;

var
  CoulombPerSquareMeter : TCoulombPerSquareMeterUnit;
  CoulombPerSquareMeterUnit : TCoulombPerSquareMeterUnit;

{ TSquareMeterPerSquareCoulomb }

const
  cSquareMeterPerSquareCoulomb = 121;

type
  TSquareMeterPerSquareCoulombRec = record
    const FUnitOfMeasurement = cSquareMeterPerSquareCoulomb;
    const FSymbol            = '%sm2/%sC2';
    const FName              = 'square %smeter per square %scoulomb';
    const FPluralName        = 'square %smeters per square %scoulomb';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareMeterPerSquareCoulombUnit = specialize TSymbol<TSquareMeterPerSquareCoulombRec>;
  TSquareMetersPerSquareCoulomb = TQuantity;

var
  SquareMeterPerSquareCoulomb : TSquareMeterPerSquareCoulombUnit;
  SquareMeterPerSquareCoulombUnit : TSquareMeterPerSquareCoulombUnit;

{ TNewtonPerSquareCoulomb }

const
  cNewtonPerSquareCoulomb = 122;

type
  TNewtonPerSquareCoulombRec = record
    const FUnitOfMeasurement = cNewtonPerSquareCoulomb;
    const FSymbol            = '%sN/%sC2';
    const FName              = '%snewton per square %scoulomb';
    const FPluralName        = '%snewtons per square %scoulomb';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TNewtonPerSquareCoulombUnit = specialize TSymbol<TNewtonPerSquareCoulombRec>;
  TNewtonsPerSquareCoulomb = TQuantity;

var
  NewtonPerSquareCoulomb : TNewtonPerSquareCoulombUnit;
  NewtonPerSquareCoulombUnit : TNewtonPerSquareCoulombUnit;

{ TNewtonSquareMeterPerSquareCoulomb }

const
  cNewtonSquareMeterPerSquareCoulomb = 123;

type
  TNewtonSquareMeterPerSquareCoulombRec = record
    const FUnitOfMeasurement = cNewtonSquareMeterPerSquareCoulomb;
    const FSymbol            = '%sN.%sm2/%sC2';
    const FName              = '%snewton square %smeter per square %scoulomb';
    const FPluralName        = '%snewton square %smeters per square %scoulomb';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -2);
  end;
  TNewtonSquareMeterPerSquareCoulombUnit = specialize TSymbol<TNewtonSquareMeterPerSquareCoulombRec>;
  TNewtonSquareMetersPerSquareCoulomb = TQuantity;

var
  NewtonSquareMeterPerSquareCoulomb : TNewtonSquareMeterPerSquareCoulombUnit;
  NewtonSquareMeterPerSquareCoulombUnit : TNewtonSquareMeterPerSquareCoulombUnit;

{ TVoltMeter }

const
  cVoltMeter = 124;

type
  TVoltMeterRec = record
    const FUnitOfMeasurement = cVoltMeter;
    const FSymbol            = '%sV.%sm';
    const FName              = '%svolt %smeter';
    const FPluralName        = '%svolt %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TVoltMeterUnit = specialize TSymbol<TVoltMeterRec>;
  TVoltMeters = TQuantity;

var
  VoltMeter : TVoltMeterUnit;
  VoltMeterUnit : TVoltMeterUnit;

{ TNewtonSquareMeterPerCoulomb }

type
  TNewtonSquareMeterPerCoulombRec = record
    const FUnitOfMeasurement = cVoltMeter;
    const FSymbol            = '%sN.%sm2/%sC';
    const FName              = '%snewton square %smeter per %scoulomb';
    const FPluralName        = '%snewton square %smeters per %scoulomb';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -1);
  end;
  TNewtonSquareMeterPerCoulombUnit = specialize TSymbol<TNewtonSquareMeterPerCoulombRec>;
  TNewtonSquareMetersPerCoulomb = TQuantity;

var
  NewtonSquareMeterPerCoulomb : TNewtonSquareMeterPerCoulombUnit;
  NewtonSquareMeterPerCoulombUnit : TNewtonSquareMeterPerCoulombUnit;

{ TVoltMeterPerSecond }

const
  cVoltMeterPerSecond = 125;

type
  TVoltMeterPerSecondRec = record
    const FUnitOfMeasurement = cVoltMeterPerSecond;
    const FSymbol            = '%sV.%sm/%ss';
    const FName              = '%svolt %smeter per %ssecond';
    const FPluralName        = '%svolt %smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -1);
  end;
  TVoltMeterPerSecondUnit = specialize TSymbol<TVoltMeterPerSecondRec>;
  TVoltMetersPerSecond = TQuantity;

var
  VoltMeterPerSecond : TVoltMeterPerSecondUnit;
  VoltMeterPerSecondUnit : TVoltMeterPerSecondUnit;

{ TFaradPerMeter }

const
  cFaradPerMeter = 126;

type
  TFaradPerMeterRec = record
    const FUnitOfMeasurement = cFaradPerMeter;
    const FSymbol            = '%sF/%sm';
    const FName              = '%sfarad per %smeter';
    const FPluralName        = '%sfarads per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TFaradPerMeterUnit = specialize TSymbol<TFaradPerMeterRec>;
  TFaradsPerMeter = TQuantity;

var
  FaradPerMeter : TFaradPerMeterUnit;
  FaradPerMeterUnit : TFaradPerMeterUnit;

{ TAmperePerMeter }

const
  cAmperePerMeter = 127;

type
  TAmperePerMeterRec = record
    const FUnitOfMeasurement = cAmperePerMeter;
    const FSymbol            = '%sA/%sm';
    const FName              = '%sampere per %smeter';
    const FPluralName        = '%samperes per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TAmperePerMeterUnit = specialize TSymbol<TAmperePerMeterRec>;
  TAmperesPerMeter = TQuantity;

var
  AmperePerMeter : TAmperePerMeterUnit;
  AmperePerMeterUnit : TAmperePerMeterUnit;

{ TMeterPerAmpere }

const
  cMeterPerAmpere = 128;

type
  TMeterPerAmpereRec = record
    const FUnitOfMeasurement = cMeterPerAmpere;
    const FSymbol            = '%sm/%sA';
    const FName              = '%smeter per %sampere';
    const FPluralName        = '%smeters per %sampere';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TMeterPerAmpereUnit = specialize TSymbol<TMeterPerAmpereRec>;
  TMetersPerAmpere = TQuantity;

var
  MeterPerAmpere : TMeterPerAmpereUnit;
  MeterPerAmpereUnit : TMeterPerAmpereUnit;

{ TTeslaMeter }

const
  cTeslaMeter = 129;

type
  TTeslaMeterRec = record
    const FUnitOfMeasurement = cTeslaMeter;
    const FSymbol            = '%sT.%sm';
    const FName              = '%stesla %smeter';
    const FPluralName        = '%stesla %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TTeslaMeterUnit = specialize TSymbol<TTeslaMeterRec>;
  TTeslaMeters = TQuantity;

var
  TeslaMeter : TTeslaMeterUnit;
  TeslaMeterUnit : TTeslaMeterUnit;

{ TNewtonPerAmpere }

type
  TNewtonPerAmpereRec = record
    const FUnitOfMeasurement = cTeslaMeter;
    const FSymbol            = '%sN/%sA';
    const FName              = '%snewton per %sampere';
    const FPluralName        = '%snewtons per %sampere';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TNewtonPerAmpereUnit = specialize TSymbol<TNewtonPerAmpereRec>;
  TNewtonsPerAmpere = TQuantity;

var
  NewtonPerAmpere : TNewtonPerAmpereUnit;
  NewtonPerAmpereUnit : TNewtonPerAmpereUnit;

{ TTeslaPerAmpere }

const
  cTeslaPerAmpere = 130;

type
  TTeslaPerAmpereRec = record
    const FUnitOfMeasurement = cTeslaPerAmpere;
    const FSymbol            = '%sT/%sA';
    const FName              = '%stesla per %sampere';
    const FPluralName        = '%steslas per %sampere';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TTeslaPerAmpereUnit = specialize TSymbol<TTeslaPerAmpereRec>;
  TTeslasPerAmpere = TQuantity;

var
  TeslaPerAmpere : TTeslaPerAmpereUnit;
  TeslaPerAmpereUnit : TTeslaPerAmpereUnit;

{ THenryPerMeter }

const
  cHenryPerMeter = 131;

type
  THenryPerMeterRec = record
    const FUnitOfMeasurement = cHenryPerMeter;
    const FSymbol            = '%sH/%sm';
    const FName              = '%shenry per %smeter';
    const FPluralName        = '%shenries per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  THenryPerMeterUnit = specialize TSymbol<THenryPerMeterRec>;
  THenriesPerMeter = TQuantity;

var
  HenryPerMeter : THenryPerMeterUnit;
  HenryPerMeterUnit : THenryPerMeterUnit;

{ TTeslaMeterPerAmpere }

type
  TTeslaMeterPerAmpereRec = record
    const FUnitOfMeasurement = cHenryPerMeter;
    const FSymbol            = '%sT.%sm/%sA';
    const FName              = '%stesla %smeter per %sampere';
    const FPluralName        = '%stesla %smeters per %sampere';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -1);
  end;
  TTeslaMeterPerAmpereUnit = specialize TSymbol<TTeslaMeterPerAmpereRec>;
  TTeslaMetersPerAmpere = TQuantity;

var
  TeslaMeterPerAmpere : TTeslaMeterPerAmpereUnit;
  TeslaMeterPerAmpereUnit : TTeslaMeterPerAmpereUnit;

{ TNewtonPerSquareAmpere }

type
  TNewtonPerSquareAmpereRec = record
    const FUnitOfMeasurement = cHenryPerMeter;
    const FSymbol            = '%sN/%sA2';
    const FName              = '%snewton per square %sampere';
    const FPluralName        = '%snewtons per square %sampere';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TNewtonPerSquareAmpereUnit = specialize TSymbol<TNewtonPerSquareAmpereRec>;
  TNewtonsPerSquareAmpere = TQuantity;

var
  NewtonPerSquareAmpere : TNewtonPerSquareAmpereUnit;
  NewtonPerSquareAmpereUnit : TNewtonPerSquareAmpereUnit;

{ TRadianPerMeter }

const
  cRadianPerMeter = 132;

type
  TRadianPerMeterRec = record
    const FUnitOfMeasurement = cRadianPerMeter;
    const FSymbol            = 'rad/%sm';
    const FName              = 'radian per %smeter';
    const FPluralName        = 'radians per %smeter';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TRadianPerMeterUnit = specialize TSymbol<TRadianPerMeterRec>;
  TRadiansPerMeter = TQuantity;

var
  RadianPerMeter : TRadianPerMeterUnit;
  RadianPerMeterUnit : TRadianPerMeterUnit;

{ TSquareKilogramPerSquareSecond }

const
  cSquareKilogramPerSquareSecond = 133;

type
  TSquareKilogramPerSquareSecondRec = record
    const FUnitOfMeasurement = cSquareKilogramPerSquareSecond;
    const FSymbol            = '%sg2/%ss2';
    const FName              = 'square %sgram per square %ssecond';
    const FPluralName        = 'square %sgrams per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareKilogramPerSquareSecondUnit = specialize TSymbol<TSquareKilogramPerSquareSecondRec>;
  TSquareKilogramsPerSquareSecond = TQuantity;

var
  SquareKilogramPerSquareSecond : TSquareKilogramPerSquareSecondUnit;
  SquareKilogramPerSquareSecondUnit : TSquareKilogramPerSquareSecondUnit;

{ TSquareSecondPerSquareMeter }

const
  cSquareSecondPerSquareMeter = 134;

type
  TSquareSecondPerSquareMeterRec = record
    const FUnitOfMeasurement = cSquareSecondPerSquareMeter;
    const FSymbol            = '%ss2/%sm2';
    const FName              = 'square %ssecond per square %smeter';
    const FPluralName        = 'square %sseconds per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareSecondPerSquareMeterUnit = specialize TSymbol<TSquareSecondPerSquareMeterRec>;
  TSquareSecondsPerSquareMeter = TQuantity;

var
  SquareSecondPerSquareMeter : TSquareSecondPerSquareMeterUnit;
  SquareSecondPerSquareMeterUnit : TSquareSecondPerSquareMeterUnit;

{ TSquareJoule }

const
  cSquareJoule = 135;

type
  TSquareJouleRec = record
    const FUnitOfMeasurement = cSquareJoule;
    const FSymbol            = '%sJ2';
    const FName              = 'square %sjoule';
    const FPluralName        = 'square %sjoules';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareJouleUnit = specialize TSymbol<TSquareJouleRec>;
  TSquareJoules = TQuantity;

var
  J2 : TSquareJouleUnit;
  SquareJouleUnit : TSquareJouleUnit;

const
  TJ2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 135; FValue: 1E+24); {$ELSE} (1E+24); {$ENDIF}
  GJ2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 135; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MJ2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 135; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kJ2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 135; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}

{ TJouleSecond }

type
  TJouleSecondRec = record
    const FUnitOfMeasurement = cKilogramSquareMeterPerSecond;
    const FSymbol            = '%sJ.%ss';
    const FName              = '%sjoule %ssecond';
    const FPluralName        = '%sjoule %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TJouleSecondUnit = specialize TSymbol<TJouleSecondRec>;
  TJouleSeconds = TQuantity;

var
  JouleSecond : TJouleSecondUnit;
  JouleSecondUnit : TJouleSecondUnit;

{ TJoulePerHertz }

type
  TJoulePerHertzRec = record
    const FUnitOfMeasurement = cKilogramSquareMeterPerSecond;
    const FSymbol            = '%sJ/%sHz';
    const FName              = '%sjoule per %shertz';
    const FPluralName        = '%sjoules per %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TJoulePerHertzUnit = specialize TSymbol<TJoulePerHertzRec>;
  TJoulePerHertzs = TQuantity;

var
  JoulePerHertz : TJoulePerHertzUnit;
  JoulePerHertzUnit : TJoulePerHertzUnit;

{ TElectronvoltSecond }

type
  TElectronvoltSecondRec = record
    const FUnitOfMeasurement = cKilogramSquareMeterPerSecond;
    const FSymbol            = '%seV.%ss';
    const FName              = '%selectronvolt %ssecond';
    const FPluralName        = '%selectronvolt %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TElectronvoltSecondUnit = specialize TFactoredSymbol<TElectronvoltSecondRec>;
  TElectronvoltSeconds = TQuantity;

const
  ElectronvoltSecond : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 46; FValue: 1.60217742320523E-019); {$ELSE} (1.60217742320523E-019); {$ENDIF}

var
  ElectronvoltSecondUnit : TElectronvoltSecondUnit;

{ TElectronvoltMeterPerSpeedOfLight }

type
  TElectronvoltMeterPerSpeedOfLightRec = record
    const FUnitOfMeasurement = cKilogramSquareMeterPerSecond;
    const FSymbol            = '%seV.%sm/c';
    const FName              = '%selectronvolt %smeter per speed of  light';
    const FPluralName        = '%selectronvolt %smeters per speed of  light';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
    class function GetValue(const AQuantity: double): double; static;
    class function PutValue(const AQuantity: double): double; static;
  end;
  TElectronvoltMeterPerSpeedOfLightUnit = specialize TFactoredSymbol<TElectronvoltMeterPerSpeedOfLightRec>;
  TElectronvoltMetersPerSpeedOfLight = TQuantity;

const
  ElectronvoltMeterPerSpeedOfLight : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 46; FValue: 1.7826619216279E-36); {$ELSE} (1.7826619216279E-36); {$ENDIF}

var
  ElectronvoltMeterPerSpeedOfLightUnit : TElectronvoltMeterPerSpeedOfLightUnit;

{ TSquareJouleSquareSecond }

const
  cSquareJouleSquareSecond = 136;

type
  TSquareJouleSquareSecondRec = record
    const FUnitOfMeasurement = cSquareJouleSquareSecond;
    const FSymbol            = '%sJ2.%ss2';
    const FName              = 'square %sjoule square %ssecond';
    const FPluralName        = 'square %sjoule square %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 2);
  end;
  TSquareJouleSquareSecondUnit = specialize TSymbol<TSquareJouleSquareSecondRec>;
  TSquareJouleSquareSeconds = TQuantity;

var
  SquareJouleSquareSecond : TSquareJouleSquareSecondUnit;
  SquareJouleSquareSecondUnit : TSquareJouleSquareSecondUnit;

{ TCoulombPerKilogram }

const
  cCoulombPerKilogram = 137;

type
  TCoulombPerKilogramRec = record
    const FUnitOfMeasurement = cCoulombPerKilogram;
    const FSymbol            = '%sC/%sg';
    const FName              = '%scoulomb per %sgram';
    const FPluralName        = '%scoulombs per %sgram';
    const FPrefixes          : TPrefixes  = (pNone, pKilo);
    const FExponents         : TExponents = (1, -1);
  end;
  TCoulombPerKilogramUnit = specialize TSymbol<TCoulombPerKilogramRec>;
  TCoulombsPerKilogram = TQuantity;

var
  CoulombPerKilogram : TCoulombPerKilogramUnit;
  CoulombPerKilogramUnit : TCoulombPerKilogramUnit;

{ TSquareMeterAmpere }

const
  cSquareMeterAmpere = 138;

type
  TSquareMeterAmpereRec = record
    const FUnitOfMeasurement = cSquareMeterAmpere;
    const FSymbol            = '%sm2.%sA';
    const FName              = 'square %smeter %sampere';
    const FPluralName        = 'square %smeter %samperes';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 1);
  end;
  TSquareMeterAmpereUnit = specialize TSymbol<TSquareMeterAmpereRec>;
  TSquareMeterAmperes = TQuantity;

var
  SquareMeterAmpere : TSquareMeterAmpereUnit;
  SquareMeterAmpereUnit : TSquareMeterAmpereUnit;

{ TJoulePerTesla }

type
  TJoulePerTeslaRec = record
    const FUnitOfMeasurement = cSquareMeterAmpere;
    const FSymbol            = '%sJ/%sT';
    const FName              = '%sjoule per %stesla';
    const FPluralName        = '%sjoules per %stesla';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TJoulePerTeslaUnit = specialize TSymbol<TJoulePerTeslaRec>;
  TJoulesPerTesla = TQuantity;

var
  JoulePerTesla : TJoulePerTeslaUnit;
  JoulePerTeslaUnit : TJoulePerTeslaUnit;

{ TLumenPerWatt }

const
  cLumenPerWatt = 139;

type
  TLumenPerWattRec = record
    const FUnitOfMeasurement = cLumenPerWatt;
    const FSymbol            = '%slm/%sW';
    const FName              = '%slumen per %swatt';
    const FPluralName        = '%slumens per %swatt';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TLumenPerWattUnit = specialize TSymbol<TLumenPerWattRec>;
  TLumensPerWatt = TQuantity;

var
  LumenPerWatt : TLumenPerWattUnit;
  LumenPerWattUnit : TLumenPerWattUnit;

{ TReciprocalMole }

const
  cReciprocalMole = 140;

type
  TReciprocalMoleRec = record
    const FUnitOfMeasurement = cReciprocalMole;
    const FSymbol            = '1/%smol';
    const FName              = 'reciprocal %smole';
    const FPluralName        = 'reciprocal %smoles';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalMoleUnit = specialize TSymbol<TReciprocalMoleRec>;
  TReciprocalMoles = TQuantity;

var
  ReciprocalMole : TReciprocalMoleUnit;
  ReciprocalMoleUnit : TReciprocalMoleUnit;

{ TAmperePerSquareMeter }

const
  cAmperePerSquareMeter = 141;

type
  TAmperePerSquareMeterRec = record
    const FUnitOfMeasurement = cAmperePerSquareMeter;
    const FSymbol            = '%sA/%sm2';
    const FName              = '%sampere per square %smeter';
    const FPluralName        = '%samperes per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TAmperePerSquareMeterUnit = specialize TSymbol<TAmperePerSquareMeterRec>;
  TAmperesPerSquareMeter = TQuantity;

var
  AmperePerSquareMeter : TAmperePerSquareMeterUnit;
  AmperePerSquareMeterUnit : TAmperePerSquareMeterUnit;

{ TMolePerCubicMeter }

const
  cMolePerCubicMeter = 142;

type
  TMolePerCubicMeterRec = record
    const FUnitOfMeasurement = cMolePerCubicMeter;
    const FSymbol            = '%smol/%sm3';
    const FName              = '%smole per cubic %smeter';
    const FPluralName        = '%smoles per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TMolePerCubicMeterUnit = specialize TSymbol<TMolePerCubicMeterRec>;
  TMolesPerCubicMeter = TQuantity;

var
  MolePerCubicMeter : TMolePerCubicMeterUnit;
  MolePerCubicMeterUnit : TMolePerCubicMeterUnit;

{ TCandelaPerSquareMeter }

const
  cCandelaPerSquareMeter = 143;

type
  TCandelaPerSquareMeterRec = record
    const FUnitOfMeasurement = cCandelaPerSquareMeter;
    const FSymbol            = '%scd/%sm2';
    const FName              = '%scandela per square %smeter';
    const FPluralName        = '%scandelas per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TCandelaPerSquareMeterUnit = specialize TSymbol<TCandelaPerSquareMeterRec>;
  TCandelasPerSquareMeter = TQuantity;

var
  CandelaPerSquareMeter : TCandelaPerSquareMeterUnit;
  CandelaPerSquareMeterUnit : TCandelaPerSquareMeterUnit;

{ TCoulombPerCubicMeter }

const
  cCoulombPerCubicMeter = 144;

type
  TCoulombPerCubicMeterRec = record
    const FUnitOfMeasurement = cCoulombPerCubicMeter;
    const FSymbol            = '%sC/%sm3';
    const FName              = '%scoulomb per cubic %smeter';
    const FPluralName        = '%scoulombs per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TCoulombPerCubicMeterUnit = specialize TSymbol<TCoulombPerCubicMeterRec>;
  TCoulombsPerCubicMeter = TQuantity;

var
  CoulombPerCubicMeter : TCoulombPerCubicMeterUnit;
  CoulombPerCubicMeterUnit : TCoulombPerCubicMeterUnit;

{ TGrayPerSecond }

const
  cGrayPerSecond = 145;

type
  TGrayPerSecondRec = record
    const FUnitOfMeasurement = cGrayPerSecond;
    const FSymbol            = '%sGy/%ss';
    const FName              = '%sgray per %ssecond';
    const FPluralName        = '%sgrays per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TGrayPerSecondUnit = specialize TSymbol<TGrayPerSecondRec>;
  TGraysPerSecond = TQuantity;

var
  GrayPerSecond : TGrayPerSecondUnit;
  GrayPerSecondUnit : TGrayPerSecondUnit;

{ TSteradianHertz }

const
  cSteradianHertz = 146;

type
  TSteradianHertzRec = record
    const FUnitOfMeasurement = cSteradianHertz;
    const FSymbol            = 'sr.%sHz';
    const FName              = 'steradian %shertz';
    const FPluralName        = 'steradian %shertz';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TSteradianHertzUnit = specialize TSymbol<TSteradianHertzRec>;
  TSteradianHertz = TQuantity;

var
  SteradianHertz : TSteradianHertzUnit;
  SteradianHertzUnit : TSteradianHertzUnit;

{ TMeterSteradian }

const
  cMeterSteradian = 147;

type
  TMeterSteradianRec = record
    const FUnitOfMeasurement = cMeterSteradian;
    const FSymbol            = '%sm.sr';
    const FName              = '%smeter steradian';
    const FPluralName        = '%smeter steradians';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TMeterSteradianUnit = specialize TSymbol<TMeterSteradianRec>;
  TMeterSteradians = TQuantity;

var
  MeterSteradian : TMeterSteradianUnit;
  MeterSteradianUnit : TMeterSteradianUnit;

{ TSquareMeterSteradian }

const
  cSquareMeterSteradian = 148;

type
  TSquareMeterSteradianRec = record
    const FUnitOfMeasurement = cSquareMeterSteradian;
    const FSymbol            = '%sm2.sr';
    const FName              = 'square %smeter steradian';
    const FPluralName        = 'square %smeter steradians';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareMeterSteradianUnit = specialize TSymbol<TSquareMeterSteradianRec>;
  TSquareMeterSteradians = TQuantity;

var
  SquareMeterSteradian : TSquareMeterSteradianUnit;
  SquareMeterSteradianUnit : TSquareMeterSteradianUnit;

{ TCubicMeterSteradian }

const
  cCubicMeterSteradian = 149;

type
  TCubicMeterSteradianRec = record
    const FUnitOfMeasurement = cCubicMeterSteradian;
    const FSymbol            = '%sm3.sr';
    const FName              = 'cubic %smeter steradian';
    const FPluralName        = 'cubic %smeter steradians';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (3);
  end;
  TCubicMeterSteradianUnit = specialize TSymbol<TCubicMeterSteradianRec>;
  TCubicMeterSteradians = TQuantity;

var
  CubicMeterSteradian : TCubicMeterSteradianUnit;
  CubicMeterSteradianUnit : TCubicMeterSteradianUnit;

{ TSquareMeterSteradianHertz }

const
  cSquareMeterSteradianHertz = 150;

type
  TSquareMeterSteradianHertzRec = record
    const FUnitOfMeasurement = cSquareMeterSteradianHertz;
    const FSymbol            = '%sm2.sr.%shertz';
    const FName              = 'square %smeter steradian %shertz';
    const FPluralName        = 'square %smeter steradian %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 1);
  end;
  TSquareMeterSteradianHertzUnit = specialize TSymbol<TSquareMeterSteradianHertzRec>;
  TSquareMeterSteradianHertz = TQuantity;

var
  SquareMeterSteradianHertz : TSquareMeterSteradianHertzUnit;
  SquareMeterSteradianHertzUnit : TSquareMeterSteradianHertzUnit;

{ TWattPerSteradian }

const
  cWattPerSteradian = 151;

type
  TWattPerSteradianRec = record
    const FUnitOfMeasurement = cWattPerSteradian;
    const FSymbol            = '%sW/sr';
    const FName              = '%swatt per steradian';
    const FPluralName        = '%swatts per steradian';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TWattPerSteradianUnit = specialize TSymbol<TWattPerSteradianRec>;
  TWattsPerSteradian = TQuantity;

var
  WattPerSteradian : TWattPerSteradianUnit;
  WattPerSteradianUnit : TWattPerSteradianUnit;

{ TWattPerSteradianPerHertz }

const
  cWattPerSteradianPerHertz = 152;

type
  TWattPerSteradianPerHertzRec = record
    const FUnitOfMeasurement = cWattPerSteradianPerHertz;
    const FSymbol            = '%sW/sr/%sHz';
    const FName              = '%swatt per steradian per %shertz';
    const FPluralName        = '%swatts per steradian per %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TWattPerSteradianPerHertzUnit = specialize TSymbol<TWattPerSteradianPerHertzRec>;
  TWattsPerSteradianPerHertz = TQuantity;

var
  WattPerSteradianPerHertz : TWattPerSteradianPerHertzUnit;
  WattPerSteradianPerHertzUnit : TWattPerSteradianPerHertzUnit;

{ TWattPerMeterPerSteradian }

const
  cWattPerMeterPerSteradian = 153;

type
  TWattPerMeterPerSteradianRec = record
    const FUnitOfMeasurement = cWattPerMeterPerSteradian;
    const FSymbol            = '%sW/sr/%sm';
    const FName              = '%swatt per steradian per %smeter';
    const FPluralName        = '%swatts per steradian per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TWattPerMeterPerSteradianUnit = specialize TSymbol<TWattPerMeterPerSteradianRec>;
  TWattsPerMeterPerSteradian = TQuantity;

var
  WattPerMeterPerSteradian : TWattPerMeterPerSteradianUnit;
  WattPerMeterPerSteradianUnit : TWattPerMeterPerSteradianUnit;

{ TWattPerSquareMeterPerSteradian }

const
  cWattPerSquareMeterPerSteradian = 154;

type
  TWattPerSquareMeterPerSteradianRec = record
    const FUnitOfMeasurement = cWattPerSquareMeterPerSteradian;
    const FSymbol            = '%sW/%sm2/sr';
    const FName              = '%swatt per square %smeter per steradian';
    const FPluralName        = '%swatts per square %smeter per steradian';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TWattPerSquareMeterPerSteradianUnit = specialize TSymbol<TWattPerSquareMeterPerSteradianRec>;
  TWattsPerSquareMeterPerSteradian = TQuantity;

var
  WattPerSquareMeterPerSteradian : TWattPerSquareMeterPerSteradianUnit;
  WattPerSquareMeterPerSteradianUnit : TWattPerSquareMeterPerSteradianUnit;

{ TWattPerCubicMeterPerSteradian }

const
  cWattPerCubicMeterPerSteradian = 155;

type
  TWattPerCubicMeterPerSteradianRec = record
    const FUnitOfMeasurement = cWattPerCubicMeterPerSteradian;
    const FSymbol            = '%sW/%sm3/sr';
    const FName              = '%swatt per cubic %smeter per steradian';
    const FPluralName        = '%swatts per cubic %smeter per steradian';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TWattPerCubicMeterPerSteradianUnit = specialize TSymbol<TWattPerCubicMeterPerSteradianRec>;
  TWattsPerCubicMeterPerSteradian = TQuantity;

var
  WattPerCubicMeterPerSteradian : TWattPerCubicMeterPerSteradianUnit;
  WattPerCubicMeterPerSteradianUnit : TWattPerCubicMeterPerSteradianUnit;

{ TWattPerSquareMeterPerSteradianPerHertz }

const
  cWattPerSquareMeterPerSteradianPerHertz = 156;

type
  TWattPerSquareMeterPerSteradianPerHertzRec = record
    const FUnitOfMeasurement = cWattPerSquareMeterPerSteradianPerHertz;
    const FSymbol            = '%sW/%sm2/sr/%sHz';
    const FName              = '%swatt per square %smeter per steradian per %shertz';
    const FPluralName        = '%swatts per square %smeter per steradian per %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -2, -1);
  end;
  TWattPerSquareMeterPerSteradianPerHertzUnit = specialize TSymbol<TWattPerSquareMeterPerSteradianPerHertzRec>;
  TWattsPerSquareMeterPerSteradianPerHertz = TQuantity;

var
  WattPerSquareMeterPerSteradianPerHertz : TWattPerSquareMeterPerSteradianPerHertzUnit;
  WattPerSquareMeterPerSteradianPerHertzUnit : TWattPerSquareMeterPerSteradianPerHertzUnit;

{ TKatalPerCubicMeter }

const
  cKatalPerCubicMeter = 157;

type
  TKatalPerCubicMeterRec = record
    const FUnitOfMeasurement = cKatalPerCubicMeter;
    const FSymbol            = '%skat/%sm3';
    const FName              = '%skatal per cubic %smeter';
    const FPluralName        = '%skatals per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TKatalPerCubicMeterUnit = specialize TSymbol<TKatalPerCubicMeterRec>;
  TKatalsPerCubicMeter = TQuantity;

var
  KatalPerCubicMeter : TKatalPerCubicMeterUnit;
  KatalPerCubicMeterUnit : TKatalPerCubicMeterUnit;

{ TCoulombPerMole }

const
  cCoulombPerMole = 158;

type
  TCoulombPerMoleRec = record
    const FUnitOfMeasurement = cCoulombPerMole;
    const FSymbol            = '%sC/%smol';
    const FName              = '%scoulomb per %smole';
    const FPluralName        = '%scoulombs per %smole';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TCoulombPerMoleUnit = specialize TSymbol<TCoulombPerMoleRec>;
  TCoulombsPerMole = TQuantity;

var
  CoulombPerMole : TCoulombPerMoleUnit;
  CoulombPerMoleUnit : TCoulombPerMoleUnit;

const

  { Mul Table }

  MulTable : array[0..158, 0..158] of longint = (
    (cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, cMeter, cSquareRootMeter, cSquareMeter, cCubicMeter, cQuarticMeter, cQuinticMeter, cSexticMeter, cKilogram, cSquareKilogram, cAmpere, cSquareAmpere, cKelvin, cSquareKelvin, cCubicKelvin, cQuarticKelvin, cMole, cCandela, cHertz, cSquareHertz, cSquareHertz, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, cSquareMeterPerSquareSecond, cMeterSecond, cKilogramMeter, cKilogramPerSecond, cKilogramMeterPerSecond, cSquareKilogramSquareMeterPerSquareSecond, cReciprocalSquareRootMeter, cReciprocalMeter, cReciprocalSquareRootCubicMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, cKilogramSquareMeter, cKilogramSquareMeterPerSecond, cSecondPerMeter, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cNewton, cNewtonRadian, cSquareNewton, cPascal, cJoule, cJoulePerRadian, cWatt, cCoulomb, cSquareCoulomb, cCoulombMeter, cVolt, cSquareVolt, cFarad, cOhm, cSiemens, cSiemensPerMeter, cTesla, cWeber, cHenry, cReciprocalHenry, cLumenSecond, cLumenSecondPerCubicMeter, cLux, cLuxSecond, cKatal, cNewtonPerCubicMeter, cNewtonPerMeter, cCubicMeterPerSecond, cPoiseuille, cSquareMeterPerSecond, cKilogramPerQuarticMeter, cQuarticMeterSecond, cKilogramPerQuarticMeterPerSecond, cCubicMeterPerKilogram, cKilogramSquareSecond, cCubicMeterPerSquareSecond, cNewtonSquareMeter, cNewtonCubicMeter, cNewtonPerSquareKilogram, cSquareKilogramPerMeter, cSquareKilogramPerSquareMeter, cSquareMeterPerSquareKilogram, cNewtonSquareMeterPerSquareKilogram, cReciprocalKelvin, cKilogramKelvin, cJoulePerKelvin, cJoulePerKilogramPerKelvin, cMeterKelvin, cKelvinPerMeter, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, cWattPerKelvin, cWattPerMeterPerKelvin, cKelvinPerWatt, cMeterPerWatt, cMeterKelvinPerWatt, cSquareMeterKelvin, cWattPerSquareMeterPerKelvin, cSquareMeterQuarticKelvin, cWattPerQuarticKelvin, cWattPerSquareMeterPerQuarticKelvin, cJoulePerMole, cMoleKelvin, cJoulePerMolePerKelvin, cOhmMeter, cVoltPerMeter, cCoulombPerMeter, cSquareCoulombPerMeter, cCoulombPerSquareMeter, cSquareMeterPerSquareCoulomb, cNewtonPerSquareCoulomb, cNewtonSquareMeterPerSquareCoulomb, cVoltMeter, cVoltMeterPerSecond, cFaradPerMeter, cAmperePerMeter, cMeterPerAmpere, cTeslaMeter, cTeslaPerAmpere, cHenryPerMeter, cRadianPerMeter, cSquareKilogramPerSquareSecond, cSquareSecondPerSquareMeter, cSquareJoule, cSquareJouleSquareSecond, cCoulombPerKilogram, cSquareMeterAmpere, cLumenPerWatt, cReciprocalMole, cAmperePerSquareMeter, cMolePerCubicMeter, cLux, cCoulombPerCubicMeter, cGrayPerSecond, cHertz, cMeter, cSquareMeter, cCubicMeter, cSquareMeterPerSecond, cWatt, cJoule, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, cNewtonPerMeter, cKatalPerCubicMeter, cCoulombPerMole),
    (cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, -1, cMeterSecond, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, -1, cLumenSecond, cScalar, cHertz, cHertz, cMeter, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cSquareMeterPerSecond, -1, -1, cKilogram, cKilogramMeter, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, cKilogramMeterPerSecond, cKilogramMeterPerSecond, -1, cPoiseuille, cKilogramSquareMeterPerSecond, cKilogramSquareMeterPerSecond, cJoule, -1, -1, -1, cWeber, -1, -1, cHenry, cFarad, cFaradPerMeter, -1, -1, -1, cSiemens, -1, -1, cLuxSecond, -1, cMole, -1, cKilogramPerSecond, cCubicMeter, cKilogramPerMeter, cSquareMeter, -1, -1, cKilogramPerQuarticMeter, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, cNewtonPerMeter, cPascal, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, cOhmMeter, -1, cVoltMeter, -1, cCoulombPerMeter, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, cLuxSecond, -1, cSquareMeterPerSquareSecond, cScalar, cMeterSecond, -1, -1, cSquareMeter, cJoule, cKilogramSquareMeterPerSecond, cNewton, cNewtonPerMeter, cPascal, cKilogramPerSecond, cMolePerCubicMeter, -1),
    (cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, cSecond, cScalar, cScalar, cMeterSecond, cMeter, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cKilogramMeter, cSquareKilogramSquareMeterPerSquareSecond, cKilogramPerMeter, cKilogramSquareMeter, cKilogramSquareMeter, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, cSquareMeterKelvin, -1, -1, cKilogramMeterPerSecond, cKilogramPerSecond, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, cSecond, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, cKilogramMeterPerSecond, cKilogramPerSecond, cPoiseuille, cKilogram, -1, -1),
    (cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cSecond, cSecond, -1, cMeterSecond, cMeter, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cKilogram, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, cSquareSecond, -1, -1, -1, -1, cKilogramSquareMeter, -1, cKilogramMeter, cKilogram, cKilogramPerMeter, -1, -1, -1),
    (cQuarticSecond, cQuinticSecond, cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, cSquareSecond, cSquareSecond, -1, -1, cMeterSecond, cMeter, cMeterPerSecond, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1),
    (cQuinticSecond, cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticSecond, cCubicSecond, cCubicSecond, -1, -1, -1, cMeterSecond, cMeter, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticSecond, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1),
    (cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticSecond, cQuarticSecond, cQuarticSecond, -1, -1, -1, -1, cMeterSecond, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeter, cMeterSecond, -1, -1, -1, -1, -1, cSquareMeter, -1, cCubicMeter, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, cKilogramMeter, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerSquareSecond, cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, cCubicMeterPerSquareSecond, -1, cKilogramSquareMeter, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, cSquareRootMeter, cScalar, cReciprocalSquareRootMeter, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, -1, -1, cSecond, cKilogram, cKilogramPerMeter, cKilogramPerSquareMeter, cJoule, cJoule, -1, cNewtonPerMeter, cNewtonSquareMeter, cNewtonSquareMeter, -1, cCoulombMeter, -1, -1, cVoltMeter, -1, -1, cOhmMeter, -1, cSiemens, cTeslaMeter, -1, -1, -1, -1, cLuxSecond, -1, -1, -1, cPascal, cNewton, -1, cKilogramPerSecond, cCubicMeterPerSecond, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, cSquareKilogram, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, cKelvin, cWatt, cWattPerMeter, cWattPerSquareMeter, -1, cWattPerKelvin, cMeterKelvinPerWatt, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, cVolt, cCoulomb, cSquareCoulomb, cCoulombPerMeter, -1, -1, -1, -1, -1, cFarad, cAmpere, -1, cWeber, cHenryPerMeter, cHenry, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, cCoulombPerSquareMeter, -1, cMeterPerSecond, cSquareMeter, cCubicMeter, cQuarticMeter, cCubicMeterPerSecond, -1, cNewtonSquareMeter, cWatt, cWattPerMeter, cWattPerSquareMeter, cNewton, -1, -1),
    (cSquareRootMeter, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cReciprocalSquareRootMeter, cReciprocalMeter, cReciprocalSquareRootCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareRootMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeter, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, -1, cKilogramSquareMeter, -1, cSquareMeterAmpere, -1, -1, -1, -1, cSquareMeterQuarticKelvin, -1, -1, cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, cSquareJouleSquareSecond, -1, cMeter, cSquareRootMeter, cScalar, cReciprocalMeter, cReciprocalSquareMeter, -1, -1, cMeterSecond, cKilogramMeter, cKilogram, cKilogramPerMeter, cNewtonSquareMeter, cNewtonSquareMeter, cSquareJoule, cNewton, cNewtonCubicMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, cCandela, cLumenSecond, -1, cNewtonPerMeter, cJoule, -1, cKilogramMeterPerSecond, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, cSquareKilogram, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, cMeterKelvin, -1, cWatt, cWattPerMeter, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, cCoulombMeter, -1, cCoulomb, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, cMeter, cSquareKilogramSquareMeterPerSquareSecond, cSquareSecond, -1, -1, -1, -1, -1, -1, cAmpere, -1, cCandela, cCoulombPerMeter, -1, cSquareMeterPerSecond, cCubicMeter, cQuarticMeter, cQuinticMeter, -1, -1, cNewtonCubicMeter, -1, cWatt, cWattPerMeter, cJoule, -1, -1),
    (cCubicMeter, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, cQuinticMeter, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cCubicMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, -1, cSquareMeter, -1, cMeter, cScalar, cReciprocalMeter, -1, -1, -1, cKilogramSquareMeter, cKilogramMeter, cKilogram, cNewtonCubicMeter, cNewtonCubicMeter, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecond, -1, -1, -1, cNewton, cNewtonSquareMeter, -1, cKilogramSquareMeterPerSecond, -1, cKilogramPerMeter, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, -1, cCoulomb, -1, cCubicMeterPerSecond, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, -1, -1, -1, -1, cWatt, cNewtonSquareMeter, cKatal, -1),
    (cQuarticMeter, cQuarticMeterSecond, -1, -1, -1, -1, -1, cQuinticMeter, -1, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, cSquareMeter, cMeter, cScalar, -1, -1, -1, -1, cKilogramSquareMeter, cKilogramMeter, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cNewtonCubicMeter, -1, -1, -1, cKilogram, -1, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, cCoulombMeter, -1, -1, cQuinticMeter, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1),
    (cQuinticMeter, -1, -1, -1, -1, -1, -1, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, cCubicMeter, cSquareMeter, cMeter, -1, -1, cQuarticMeterSecond, -1, -1, cKilogramSquareMeter, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, cKilogramMeter, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, -1, cQuarticMeter, cCubicMeter, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, cKilogramSquareMeter, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogram, -1, cKilogramSquareSecond, -1, -1, -1, -1, cKilogramMeter, -1, cKilogramSquareMeter, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, cKilogramKelvin, -1, -1, -1, -1, -1, cKilogramPerSecond, cNewtonPerMeter, cNewtonPerMeter, cKilogramMeterPerSecond, cNewton, cWattPerMeter, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, -1, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, -1, -1, cSquareKilogramPerMeter, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, cCubicMeter, -1, cNewtonSquareMeter, -1, cSquareJouleSquareSecond, cMeterPerSquareSecond, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, -1, -1, cWatt, cKilogramPerSecond, cKilogramMeter, cKilogramSquareMeter, -1, cKilogramSquareMeterPerSecond, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1),
    (cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, -1, cSquareMeter, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cAmpere, cCoulomb, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, cAmperePerMeter, -1, cAmperePerSquareMeter, -1, -1, -1, -1, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, cVolt, -1, -1, cNewtonPerMeter, cJoule, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, cWattPerMeter, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, cMeter, cNewton, cTesla, cTeslaMeter, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareAmpere, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKelvin, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, cKilogramKelvin, -1, -1, -1, cSquareKelvin, cCubicKelvin, cQuarticKelvin, -1, cMoleKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, cJoule, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, cWatt, cWattPerMeter, -1, cMeterKelvinPerWatt, -1, cSquareMeter, cWattPerSquareMeter, -1, -1, -1, -1, -1, cJoulePerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicKelvin, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCubicKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicKelvin, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterQuarticKelvin, -1, -1, -1, -1, -1, cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1),
    (cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMoleKelvin, -1, -1, -1, -1, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb),
    (cCandela, cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cHertz, cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cMeterPerSecond, -1, cSquareMeterPerSecond, cCubicMeterPerSecond, -1, -1, -1, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, cSquareHertz, -1, -1, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, cGrayPerSecond, cMeter, cKilogramMeterPerSecond, cNewtonPerMeter, cNewton, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cJoule, cReciprocalMeter, cPoiseuille, -1, -1, cWattPerMeter, cWattPerMeter, -1, cWattPerCubicMeter, cWatt, cWatt, -1, cAmpere, -1, -1, -1, -1, cSiemens, -1, cReciprocalHenry, -1, -1, cVolt, cOhm, -1, cCandela, -1, -1, cLux, -1, -1, cWattPerSquareMeter, cCubicMeterPerSquareSecond, cPascal, cSquareMeterPerSquareSecond, cKilogramPerQuarticMeterPerSecond, cQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cAmperePerMeter, -1, cAmperePerSquareMeter, -1, -1, -1, cVoltMeterPerSecond, -1, cSiemensPerMeter, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatalPerCubicMeter, -1, -1, -1, cSquareHertz, cMeterPerSecond, cSquareMeterPerSecond, cCubicMeterPerSecond, cSquareMeterPerSquareSecond, -1, cWatt, -1, -1, -1, cWattPerSquareMeter, -1, -1),
    (cSquareHertz, cHertz, cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cMeterPerSquareSecond, -1, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, cNewtonPerMeter, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, -1, -1, cMeterPerSecond, cNewton, cWattPerSquareMeter, cWattPerMeter, cSquareNewton, -1, -1, -1, -1, -1, -1, cJoule, cWatt, -1, cPascal, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, cGrayPerSecond, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, cReciprocalSquareMeter, -1, cSquareJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareHertz, cHertz, cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cMeterPerSquareSecond, -1, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, cNewtonPerMeter, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, -1, -1, cMeterPerSecond, cNewton, cWattPerSquareMeter, cWattPerMeter, cSquareNewton, -1, -1, -1, -1, -1, -1, cJoule, cWatt, -1, cPascal, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, cGrayPerSecond, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, cReciprocalSquareMeter, -1, cSquareJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerSecond, cMeter, cMeterSecond, -1, -1, -1, -1, cSquareMeterPerSecond, -1, cCubicMeterPerSecond, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerCubicSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, -1, -1, cSquareMeter, cKilogramSquareMeterPerSecond, cNewton, cJoule, -1, -1, cHertz, -1, -1, -1, -1, -1, cNewtonSquareMeter, cScalar, cKilogramPerSecond, cPoiseuille, -1, cWatt, cWatt, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, cSquareMeterAmpere, cVoltMeterPerSecond, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cReciprocalHenry, cVoltPerMeter, cVoltMeter, cOhmMeter, -1, -1, cLux, -1, -1, -1, cWattPerCubicMeter, cWattPerMeter, -1, cNewtonPerMeter, cCubicMeterPerSquareSecond, -1, cQuinticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, cAmperePerMeter, -1, -1, -1, -1, -1, cSiemens, -1, -1, cVolt, -1, cOhm, cHertz, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, cMeterPerSquareSecond, cSquareMeterPerSecond, cCubicMeterPerSecond, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1),
    (cMeterPerSquareSecond, cMeterPerSecond, cMeter, cMeterSecond, -1, -1, -1, cSquareMeterPerSquareSecond, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuarticSecond, cGrayPerSecond, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, cJoule, cWattPerMeter, cWatt, -1, -1, cSquareHertz, -1, -1, -1, -1, cNewtonSquareMeter, -1, cHertz, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, cKilogramMeter, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, cNewtonPerSquareCoulomb, -1, cSquareHertz, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerCubicSecond, cMeterPerSquareSecond, cMeterPerSecond, cMeter, cMeterSecond, -1, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareHertz, cWattPerSquareMeter, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuarticSecond, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerQuarticSecond, cMeterPerCubicSecond, cMeterPerSquareSecond, cMeterPerSecond, cMeter, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, cMeterPerSexticSecond, cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerQuinticSecond, cMeterPerQuarticSecond, cMeterPerCubicSecond, cMeterPerSquareSecond, cMeterPerSecond, cMeter, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerSexticSecond, cMeterPerQuinticSecond, cMeterPerQuarticSecond, cMeterPerCubicSecond, cMeterPerSquareSecond, cMeterPerSecond, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSquareSecond, cSquareMeterPerSecond, cSquareMeter, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cJoule, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cNewtonSquareMeter, cWatt, -1, cSquareJoule, -1, cMeterPerSquareSecond, -1, cSquareHertz, -1, -1, cNewtonCubicMeter, -1, cMeterPerSecond, cNewton, cNewtonPerMeter, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, cNewtonPerCubicMeter, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, cNewtonSquareMeterPerSquareCoulomb, cMeterPerSquareSecond, cSquareNewton, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, cMeter, cMeterPerSecond, cMeterPerSecond, cSquareMeter, cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, cCubicMeterPerSecond, -1, -1, cKilogramMeter, cKilogramSquareMeter, -1, -1, cSecond, -1, cSecondPerMeter, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, cKilogramSquareMeterPerSecond, cKilogramSquareMeterPerSecond, -1, cKilogramPerSecond, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, cKilogramMeterPerSecond, cQuarticMeter, cKilogram, cCubicMeter, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cNewton, cNewtonPerMeter, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, -1, -1, cCubicMeterPerSquareSecond, cMeter, -1, -1, cQuarticMeterSecond, cCubicMeter, cNewtonSquareMeter, -1, cJoule, cNewton, cNewtonPerMeter, cKilogramMeterPerSecond, -1, -1),
    (cKilogramMeter, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, cNewton, cNewton, cKilogramSquareMeterPerSecond, cJoule, cWatt, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, cKilogram, -1, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogramPerCubicMeter, -1, -1, -1, cSquareKilogram, cSquareKilogramPerMeter, cSquareKilogramPerSquareMeter, cSquareKilogramSquareMeterPerSquareSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, cNewtonCubicMeter, cSquareJouleSquareSecond, -1, cSquareMeterPerSquareSecond, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, cKilogramKelvin, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, -1, -1, cKilogramMeterPerSecond, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, cWattPerSquareMeter, cWattPerSquareMeter, cNewton, cWattPerMeter, -1, -1, -1, -1, cWatt, cKilogramMeter, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, cPoiseuille, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, cSquareKilogramSquareMeterPerSquareSecond, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cJoule, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, cMeterPerCubicSecond, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, cJoule, cSquareNewton, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, cWattPerMeter, cWattPerMeter, cJoule, cWatt, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, cKilogramPerSecond, -1, cPoiseuille, -1, -1, -1, -1, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, cSquareKilogramPerSquareSecond, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, cKilogramSquareMeterPerSecond, -1, -1, cNewtonSquareMeter, -1, -1, cSquareNewton, -1, -1, -1, -1, -1),
    (cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, cSquareNewton, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalSquareRootMeter, -1, -1, -1, -1, -1, -1, cSquareRootMeter, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cReciprocalSquareRootCubicMeter, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareRootCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareRootMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalMeter, cSecondPerMeter, -1, -1, -1, -1, -1, cScalar, cReciprocalSquareRootMeter, cMeter, cSquareMeter, cCubicMeter, cQuarticMeter, cQuinticMeter, cKilogramPerMeter, cSquareKilogramPerMeter, cAmperePerMeter, -1, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, cSquareHertz, -1, -1, -1, -1, cMeterPerSquareSecond, cSecond, cKilogram, cPoiseuille, cKilogramPerSecond, -1, cReciprocalSquareRootCubicMeter, cReciprocalSquareMeter, -1, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, cKilogramMeter, cKilogramMeterPerSecond, -1, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, cNewtonPerMeter, cNewtonPerMeter, -1, cNewtonPerCubicMeter, cNewton, cNewton, cWattPerMeter, cCoulombPerMeter, cSquareCoulombPerMeter, cCoulomb, cVoltPerMeter, -1, cFaradPerMeter, -1, cSiemensPerMeter, -1, -1, cTeslaMeter, cHenryPerMeter, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, cPascal, cSquareMeterPerSecond, -1, cMeterPerSecond, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cJoule, cNewtonSquareMeter, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, cWattPerSquareMeter, cWattPerCubicMeter, -1, cWattPerMeterPerKelvin, cWattPerSquareMeterPerKelvin, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, cCoulombPerSquareMeter, -1, cCoulombPerCubicMeter, -1, -1, -1, cVolt, -1, -1, cAmperePerSquareMeter, -1, cTesla, -1, cTeslaPerAmpere, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, -1, cScalar, cMeter, cSquareMeter, cMeterPerSecond, cWattPerMeter, cNewton, cWattPerSquareMeter, cWattPerCubicMeter, -1, cPascal, -1, -1),
    (cReciprocalSquareRootCubicMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareRootMeter, cReciprocalMeter, cSquareRootMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareRootMeter, cSquareRootMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalSquareMeter, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, cReciprocalMeter, cReciprocalSquareRootCubicMeter, cScalar, cMeter, cSquareMeter, cCubicMeter, cQuarticMeter, cKilogramPerSquareMeter, cSquareKilogramPerSquareMeter, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareHertz, cSecondPerMeter, cKilogramPerMeter, -1, cPoiseuille, cSquareKilogramPerSquareSecond, -1, cReciprocalCubicMeter, -1, cReciprocalQuarticMeter, -1, -1, cKilogram, cKilogramPerSecond, -1, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, cPascal, cPascal, -1, -1, cNewtonPerMeter, cNewtonPerMeter, cWattPerSquareMeter, cCoulombPerSquareMeter, -1, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cTesla, cTeslaPerAmpere, -1, cLuxSecond, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, cMeterPerSecond, -1, cHertz, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cNewton, cJoule, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, cKelvinPerMeter, -1, cWattPerCubicMeter, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, cReciprocalKelvin, -1, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, cNewtonPerSquareCoulomb, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, cSquareNewton, cSquareKilogramSquareMeterPerSquareSecond, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cScalar, cMeter, cHertz, cWattPerSquareMeter, cNewtonPerMeter, cWattPerCubicMeter, -1, -1, cNewtonPerCubicMeter, -1, -1),
    (cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cReciprocalMeter, cScalar, cMeter, cSquareMeter, cCubicMeter, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, cKilogramPerMeter, cPoiseuille, -1, cKilogramPerQuarticMeter, -1, -1, cNewtonPerCubicMeter, cNewtonPerCubicMeter, -1, -1, cPascal, cPascal, cWattPerCubicMeter, cCoulombPerCubicMeter, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, cKatalPerCubicMeter, -1, -1, cHertz, cKilogramPerQuarticMeterPerSecond, -1, -1, cMeterSecond, -1, -1, -1, cSquareHertz, cNewtonPerMeter, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cReciprocalMeter, cScalar, -1, cWattPerCubicMeter, cPascal, -1, -1, -1, -1, -1, -1),
    (cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, cReciprocalSquareMeter, cReciprocalMeter, cScalar, cMeter, cSquareMeter, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, cNewtonPerCubicMeter, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, -1, -1, -1, cPascal, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, cReciprocalSquareMeter, cReciprocalMeter, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1),
    (cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cJoule, cJoule, -1, cNewtonSquareMeter, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, cKilogramMeter, -1, cKilogram, cKilogramPerMeter, cKilogramPerSquareMeter, -1, -1, -1, -1, cSquareKilogram, cSquareKilogramPerMeter, -1, -1, -1, -1, cSquareJouleSquareSecond, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, cQuinticMeter, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, cSquareJouleSquareSecond, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1),
    (cKilogramSquareMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cWatt, cWatt, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, cKilogramMeterPerSecond, -1, cKilogramPerSecond, cPoiseuille, -1, -1, cSquareJouleSquareSecond, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, cNewtonCubicMeter, cSquareJoule, -1, -1, cSquareNewton, -1, -1, -1, -1),
    (cSecondPerMeter, -1, -1, -1, -1, -1, -1, cSecond, -1, cMeterSecond, -1, -1, cQuarticMeterSecond, -1, -1, -1, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, -1, cScalar, cHertz, cSquareHertz, -1, -1, -1, cMeterPerSecond, cSquareSecond, -1, cKilogramPerMeter, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cSquareSecondPerSquareMeter, -1, -1, -1, cKilogramPerSecond, cKilogramPerSecond, -1, -1, cKilogramMeterPerSecond, cKilogramMeterPerSecond, cNewton, -1, -1, -1, cTeslaMeter, -1, -1, cHenryPerMeter, cFaradPerMeter, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, cPoiseuille, cSquareMeter, cKilogramPerSquareMeter, cMeter, -1, -1, -1, -1, -1, cSquareMeterPerSecond, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, cTesla, -1, -1, -1, -1, -1, cOhm, cWeber, cVolt, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, cCoulombPerCubicMeter, -1, cLumenSecondPerCubicMeter, -1, cMeterPerSquareSecond, cReciprocalMeter, cSecond, cMeterSecond, -1, cMeter, cNewton, cKilogramMeterPerSecond, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, cPoiseuille, -1, -1),
    (cKilogramPerMeter, -1, -1, -1, -1, -1, -1, cKilogram, -1, cKilogramMeter, cKilogramSquareMeter, -1, -1, -1, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, cPascal, cPascal, cKilogramPerSecond, cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, cNewton, -1, cSquareKilogram, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, cSquareKilogramPerSquareSecond, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, cKilogramMeterPerSecond, -1, -1, -1, cSquareMeter, -1, cJoule, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareHertz, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, cPoiseuille, cKilogram, cKilogramMeter, cKilogramSquareMeter, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, -1, cKilogram, cKilogramMeter, cKilogramSquareMeter, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, cNewtonPerCubicMeter, cPoiseuille, cPascal, cWattPerCubicMeter, -1, -1, -1, cNewtonPerMeter, -1, cSquareKilogramPerMeter, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, cKilogramPerQuarticMeter, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, cKilogramPerSecond, -1, -1, -1, cMeter, -1, cNewton, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, cKilogramPerMeter, cKilogram, cKilogramMeter, cKilogramPerSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1),
    (cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, cKilogramPerMeter, cKilogram, cKilogramMeter, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, cPascal, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, -1, cPoiseuille, -1, -1, -1, cScalar, -1, cNewtonPerMeter, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1, cKilogramPerSquareMeter, cKilogramPerMeter, cKilogram, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewton, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, -1, cJoule, -1, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, cNewtonPerMeter, -1, cPascal, cNewtonPerCubicMeter, -1, -1, -1, cKilogramPerSecond, cSquareKilogramPerSquareSecond, -1, -1, cSquareNewton, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cSquareVolt, -1, -1, -1, -1, cWeber, -1, -1, -1, cNewtonPerMeter, -1, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonRadian, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, -1, cJoule, -1, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, cNewtonPerMeter, -1, cPascal, cNewtonPerCubicMeter, -1, -1, -1, cKilogramPerSecond, cSquareKilogramPerSquareSecond, -1, -1, cSquareNewton, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cSquareVolt, -1, -1, -1, -1, cWeber, -1, -1, -1, cNewtonPerMeter, -1, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareNewton, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cPascal, cPoiseuille, cKilogramPerMeter, -1, -1, -1, -1, cNewtonPerMeter, -1, cNewton, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, cWattPerMeter, -1, -1, -1, cSquareMeterPerSquareSecond, cSquareKilogramPerMeter, -1, cSquareNewton, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, cNewtonPerCubicMeter, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, cNewtonPerMeter, cNewton, cJoule, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoule, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, cNewtonSquareMeter, -1, cNewtonCubicMeter, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, cSquareJouleSquareSecond, -1, cKilogramMeterPerSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, cSquareJoule, cSquareJoule, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, cNewtonRadian, -1, cKilogram, -1, -1, -1, -1, cLumenSecond, cJoulePerMole, -1, -1, -1, -1, -1, cWatt, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, cSquareJoule, -1, -1, -1, cSquareNewton, -1, -1),
    (cJoulePerRadian, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, cNewtonSquareMeter, -1, cNewtonCubicMeter, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, cSquareJouleSquareSecond, -1, cKilogramMeterPerSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, cSquareJoule, cSquareJoule, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, cNewton, -1, cKilogram, -1, -1, -1, -1, cLumenSecond, cJoulePerMole, -1, -1, -1, -1, -1, cWatt, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, cSquareJoule, -1, -1, -1, cSquareNewton, -1, -1),
    (cWatt, cJoule, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cSquareNewton, -1, -1, -1, cWattPerMeter, -1, cWattPerSquareMeter, cWattPerCubicMeter, -1, -1, cSquareJoule, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, cMeter, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, cWattPerMeter, -1, cKilogramPerSecond, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCoulomb, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, cJoule, -1, -1, cWeber, -1, -1, cKilogramPerSecond, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, cSquareCoulombPerMeter, -1, -1, -1, cVoltPerMeter, cVoltMeter, cNewtonSquareMeter, -1, -1, -1, cMeterSecond, cKilogramMeterPerSecond, -1, -1, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMole, -1, -1, -1, -1, -1, cAmpere, cCoulombMeter, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, cNewton, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, cKilogram, cKilogramMeter, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, -1, cCoulombPerMeter, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cSquareCoulomb, -1, cSquareCoulombPerMeter, -1, cVolt, -1, cNewtonCubicMeter, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cVolt, cWeber, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, cNewtonSquareMeter, cSquareVolt, -1, cCoulomb, -1, cAmpere, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, cCoulombPerMeter, cWattPerMeter, cOhmMeter, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, cWattPerSquareMeter, -1, -1, cPascal, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole),
    (cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1, -1, cJoule, -1, cWatt, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, cReciprocalHenry, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, cSquareCoulombPerMeter, -1, -1, cSquareCoulomb, cSquareCoulomb, -1, -1, -1, -1, cCoulomb, cJoule, -1, cSecond, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, cCoulombPerMeter, -1, -1, -1, -1, cReciprocalMeter, cMeter, cCoulombMeter, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1),
    (cOhm, cHenry, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, cWeber, cKilogramSquareMeterPerSecond, -1, -1, -1, cSecond, -1, cScalar, cReciprocalMeter, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, cKilogramMeterPerSecond, cTesla, -1, -1, -1, -1, -1, cSecondPerMeter, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1),
    (cSiemens, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, cSquareCoulomb, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, cAmpere, cWatt, -1, cScalar, -1, -1, cCoulombPerSquareMeter, cCoulomb, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, cAmperePerMeter, -1, -1, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, cSecondPerMeter, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1),
    (cSiemensPerMeter, cFaradPerMeter, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, cWattPerMeter, -1, cReciprocalMeter, -1, -1, cCoulombPerCubicMeter, cCoulombPerMeter, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cAmperePerSquareMeter, -1, -1, -1, -1, -1, cHertz, cAmpere, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cTesla, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, cWeber, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, cVolt, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, cJoule, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, cTeslaMeter, cWeber, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWeber, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, cVoltMeter, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, cCoulomb, cCoulombPerMeter, -1, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, cNewton, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, cSquareMeterPerSecond, cNewtonCubicMeter, -1, -1, cNewtonPerMeter, -1, -1, cPoiseuille, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, cJoule, -1, -1, -1, -1, -1, -1, cOhm, -1, -1, cOhmMeter, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, cSquareSecond, -1, cSecond, cSecondPerMeter, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalHenry, cSiemens, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, cAmperePerSquareMeter, cAmpere, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, cAmperePerMeter, cReciprocalSquareMeter, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1),
    (cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLuxSecond, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, cLuxSecond, -1, -1, cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLuxSecond, -1, cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cLux, cLuxSecond, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cLuxSecond, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLux, -1, cLumenSecond, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKatal, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatalPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere),
    (cNewtonPerCubicMeter, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, cPascal, -1, cNewtonPerMeter, cNewton, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, cWattPerSquareMeter, -1, cKilogramSquareMeterPerSecond, -1, cMeterPerSquareSecond, cSquareKilogramPerSquareMeter, -1, -1, cSquareNewton, -1, -1, -1, -1, cMeterPerQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cNewtonPerMeter, cNewton, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonPerMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, -1, cNewton, -1, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, cPascal, -1, cNewtonPerCubicMeter, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, cCubicMeterPerSquareSecond, cSquareKilogram, -1, -1, cSquareJoule, cMeterPerQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, cPascal, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, cNewton, cJoule, cNewtonSquareMeter, cWatt, -1, cSquareNewton, -1, -1, -1, -1, -1, -1),
    (cCubicMeterPerSecond, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, cSquareMeterPerSecond, -1, cMeterPerSecond, cHertz, -1, -1, -1, cSquareMeter, cKilogramSquareMeterPerSecond, cKilogramMeterPerSecond, cKilogramPerSecond, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, -1, cCandela, -1, -1, -1, cWattPerMeter, -1, -1, cJoule, -1, cPoiseuille, -1, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, cSquareMeterPerSecond, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, cAmpere, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cPoiseuille, cKilogramPerMeter, -1, -1, -1, -1, -1, cKilogramPerSecond, -1, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cWattPerCubicMeter, cWattPerCubicMeter, cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, -1, cWattPerMeter, cKilogram, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, cNewton, -1, -1, -1, cSquareMeterPerSecond, -1, cWatt, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cKilogramPerSecond, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, cNewton, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSecond, cSquareMeter, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cGrayPerSecond, cGrayPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, cJoule, cNewtonSquareMeter, -1, -1, cMeterPerSecond, -1, cHertz, -1, -1, -1, cNewtonCubicMeter, cMeter, cKilogramMeterPerSecond, cKilogramPerSecond, cPoiseuille, -1, -1, -1, cWattPerMeter, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, -1, -1, -1, -1, cCandela, -1, cWattPerSquareMeter, cWatt, -1, cNewton, -1, -1, cSexticMeter, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, cOhm, cOhmMeter, cMeterPerSecond, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, cSquareMeterPerSquareSecond, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1),
    (cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, cKilogramPerSquareMeter, cKilogramPerMeter, cKilogram, cKilogramMeter, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, cReciprocalMeter, -1, cPascal, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, cKilogramPerCubicMeter, cKilogramPerSquareMeter, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuarticMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, -1, cQuinticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, cSexticMeter, -1, -1, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, -1, -1, cSexticMeter, -1, -1, -1, cNewtonCubicMeter, cNewtonSquareMeter, -1, -1, -1),
    (cKilogramPerQuarticMeterPerSecond, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, cKilogramPerSecond, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, -1, cNewtonPerCubicMeter, -1, cKilogram, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, -1, -1, cSquareMeter, cMeter, cScalar, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, cSquareMeterPerSecond, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, cCubicMeterPerSquareSecond, -1, -1),
    (cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, cKilogram, -1, cKilogramMeter, cKilogramMeterPerSecond, cNewton, cWattPerMeter, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, -1),
    (cCubicMeterPerSquareSecond, cCubicMeterPerSecond, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, cMeterPerSquareSecond, cSquareHertz, -1, -1, -1, cSquareMeterPerSecond, cJoule, cNewton, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, cPascal, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cSquareMeterPerSquareSecond, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJouleSquareSecond, -1, -1, -1, -1, cJoule, -1, cNewton, cNewtonPerMeter, cPascal, -1, -1, cKilogramSquareMeterPerSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareKilogramPerSquareSecond, cSquareJoule, cSquareJoule, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, cJoule, -1, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cJoule, cNewton, cNewtonPerMeter, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, cSquareJoule, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1),
    (cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, cMeterPerSquareSecond, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cMeterPerCubicSecond, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuarticSecond, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, -1, -1, -1, cNewtonPerMeter, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, cMeterPerQuarticSecond, -1, -1),
    (cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, cNewtonPerMeter, -1, -1, cMeter, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, -1, -1, -1, -1, cPascal, -1, -1, cScalar, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, cNewtonSquareMeterPerSquareKilogram, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonSquareMeterPerSquareKilogram, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cMeterPerSquareSecond, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuarticSecond, -1, -1, cGrayPerSecond, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, cJoule, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cKelvin, cSquareKelvin, cCubicKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, cJoulePerKelvin, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, -1, -1, cMeter, cReciprocalMeter, cWattPerMeterPerKelvin, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterKelvin, -1, -1, cWattPerKelvin, cJoulePerKelvin, cWattPerMeterPerKelvin, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1),
    (cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, -1, cSquareKilogramSquareMeterPerSquareSecond, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, cNewtonSquareMeter, cNewton, -1, -1, -1, -1, -1, cSecond, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoulePerKilogramPerKelvin, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, cCubicMeterPerSquareSecond, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, cKelvinPerMeter, -1, -1, -1, -1, -1, cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, cNewtonSquareMeter, cCubicMeterPerSquareSecond, -1, cSquareKelvin, -1, -1, -1, -1, cWatt, -1, -1, -1, cCubicMeter, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKelvinPerMeter, -1, -1, -1, -1, -1, -1, cKelvin, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, cNewton, cMeterPerSquareSecond, cSquareKelvin, -1, -1, -1, -1, cWattPerMeter, cWattPerSquareMeter, -1, cKelvinPerWatt, -1, cMeter, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerMeter, cNewton, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, cSquareNewton, -1, -1, cWattPerSquareMeter, -1, cWattPerCubicMeter, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, cScalar, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, -1, cWattPerSquareMeter, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerSquareMeter, cNewtonPerMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, cWattPerMeter, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, cSquareNewton, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cKelvinPerMeter, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerCubicMeter, cPascal, cPoiseuille, cKilogramPerMeter, -1, -1, -1, cWattPerSquareMeter, -1, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerKelvin, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, cScalar, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, cWattPerSquareMeter, -1, -1, -1, -1, -1, cReciprocalMeter, cReciprocalKelvin, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKelvinPerWatt, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, -1, -1, cKelvinPerMeter, -1, -1, cScalar, cReciprocalMeter, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, cKelvin, -1, cKelvinPerMeter, -1, -1, -1, -1, -1),
    (cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, cSecond, cKilogramMeterPerSecond, -1, cMeterSecond, cMeterSecond, cMeter, -1, -1, -1, cMeterPerAmpere, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, cScalar, cReciprocalMeter, cReciprocalSquareMeter, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, cMeterSecond, cScalar, cReciprocalMeter, cReciprocalSquareMeter, cSecondPerMeter, -1, -1),
    (cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, cMeterSecond, -1, -1, -1, cKelvin, cKelvinPerMeter, -1, cMeter, cScalar, -1, -1, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, cKelvin, cKelvinPerMeter, -1, -1, -1, -1),
    (cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, cCubicMeter, cMeter, -1, cWattPerKelvin, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, cWattPerMeterPerKelvin, cJoulePerKelvin, -1, -1),
    (cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, cWattPerCubicMeter, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoulePerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1),
    (cMoleKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, cMeter, cScalar, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, cKilogramSquareMeterPerSecond, cTeslaMeter, -1, -1, -1, -1, -1, cSecond, cVolt, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, cTesla, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1),
    (cVoltPerMeter, cTeslaMeter, -1, -1, -1, -1, -1, cVolt, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, cJoule, -1, -1, cCoulombPerMeter, -1, cAmperePerMeter, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, cPascal, -1, -1, -1, cSquareVolt, -1, cCoulombPerSquareMeter, cWattPerSquareMeter, cOhm, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, cWattPerCubicMeter, -1, -1, cNewtonPerCubicMeter, -1, -1, cVolt, cVoltMeter, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCoulombPerMeter, -1, -1, -1, -1, -1, -1, cCoulomb, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, cSquareCoulomb, cNewton, -1, -1, cTeslaMeter, -1, -1, cPoiseuille, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, cNewtonPerMeter, -1, -1, -1, -1, -1, cVolt, cJoule, cWatt, -1, -1, cSecond, cKilogramPerSecond, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, cCoulomb, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, cMeter, cNewtonPerMeter, cJoule, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, cCoulomb, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, cNewtonPerMeter, -1, -1, cTesla, -1, -1, -1, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, cPascal, -1, -1, -1, -1, -1, cVoltPerMeter, cNewton, cWattPerMeter, -1, -1, cSecondPerMeter, cPoiseuille, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, cCoulombPerMeter, cCoulomb, cCoulombMeter, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, cTeslaPerAmpere, -1, cNewtonSquareMeterPerSquareCoulomb, cNewtonSquareMeterPerSquareCoulomb, cSquareVolt, cNewtonPerSquareCoulomb, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonPerSquareCoulomb, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, cNewton, cVolt, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonSquareMeterPerSquareCoulomb, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, cOhm, -1, -1, -1, cSquareVolt, cSquareVolt, -1, -1, -1, -1, -1, cVoltMeter, cNewtonSquareMeter, -1, -1, -1, cMeter, -1, cMeterPerSecond, cHertz, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, cJoule, cVoltPerMeter, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, cVoltPerMeter, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cNewtonCubicMeter, -1, -1, cCoulombMeter, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, cJoule, -1, cNewton, -1, -1, -1, -1, -1, cCoulomb, cWatt, -1, -1, -1, -1, cVolt, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, cWattPerMeter, -1, -1, cNewtonPerMeter, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cVoltMeterPerSecond, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, cWattPerMeter, -1, -1, -1, -1, -1, cAmpere, -1, -1, cSquareVolt, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cFaradPerMeter, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, cSiemens, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, cSquareCoulombPerMeter, -1, -1, -1, -1, cCoulombPerMeter, cNewton, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, cCoulombPerSquareMeter, -1, -1, -1, -1, cReciprocalSquareMeter, cScalar, cCoulomb, cAmpere, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, cFarad, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1),
    (cAmperePerMeter, cCoulombPerMeter, -1, -1, -1, -1, -1, cAmpere, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, cVoltPerMeter, -1, -1, cPascal, cNewton, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, cScalar, cNewtonPerMeter, -1, cTesla, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, cWeber, -1, cTesla, -1, -1, cVoltMeter, cMeterSecond, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, cSecond, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, cScalar, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, cVolt, cVoltPerMeter, -1, cTeslaMeter, -1, -1),
    (cTeslaMeter, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, cVolt, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, cCoulombPerMeter, cCoulombPerSquareMeter, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, -1, cPoiseuille, -1, -1, -1, -1, cSquareVolt, -1, cNewtonPerMeter, cHenry, -1, -1, -1, cTesla, -1, -1, -1, -1, cMeterPerSecond, cNewtonSquareMeter, -1, -1, cPascal, -1, -1, -1, -1, cVoltPerMeter, cWeber, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, cHenry, -1, -1, -1, -1, -1, -1, cTesla, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, cOhm, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, cHenry, -1, cOhm, -1, -1, -1, -1, -1, -1, -1, -1),
    (cHenryPerMeter, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, cNewton, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, cNewtonPerSquareCoulomb, cOhm, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, cTesla, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cRadianPerMeter, cSecondPerMeter, -1, -1, -1, -1, -1, cScalar, cReciprocalSquareRootMeter, cMeter, cSquareMeter, cCubicMeter, cQuarticMeter, cQuinticMeter, cKilogramPerMeter, cSquareKilogramPerMeter, cAmperePerMeter, -1, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, cSquareHertz, -1, -1, -1, -1, cMeterPerSquareSecond, cSecond, cKilogram, cPoiseuille, cKilogramPerSecond, -1, cReciprocalSquareRootCubicMeter, cReciprocalSquareMeter, -1, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, cKilogramMeter, cKilogramMeterPerSecond, -1, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, cNewtonPerMeter, cNewtonPerMeter, -1, cNewtonPerCubicMeter, cNewtonRadian, cNewton, cWattPerMeter, cCoulombPerMeter, cSquareCoulombPerMeter, cCoulomb, cVoltPerMeter, -1, cFaradPerMeter, -1, cSiemensPerMeter, -1, -1, cTeslaMeter, cHenryPerMeter, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, cPascal, cSquareMeterPerSecond, -1, cMeterPerSecond, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cJoule, cNewtonSquareMeter, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, cWattPerSquareMeter, cWattPerCubicMeter, -1, cWattPerMeterPerKelvin, cWattPerSquareMeterPerKelvin, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, cCoulombPerSquareMeter, -1, cCoulombPerCubicMeter, -1, -1, -1, cVolt, -1, -1, cAmperePerSquareMeter, -1, cTesla, -1, cTeslaPerAmpere, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, -1, cScalar, cMeter, cSquareMeter, cMeterPerSecond, cWattPerMeter, cNewtonRadian, cWattPerSquareMeter, cWattPerCubicMeter, -1, cPascal, -1, -1),
    (cSquareKilogramPerSquareSecond, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cReciprocalSquareMeter, cSecondPerMeter, cReciprocalMeter, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, cKilogramPerMeter, cKilogramPerMeter, cSquareKilogramPerSquareSecond, cKilogramPerCubicMeter, cKilogram, cKilogram, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, cKilogramPerSquareMeter, cMeterSecond, -1, cSecond, -1, -1, -1, -1, -1, cMeter, cKilogramMeter, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, cSquareSecond, -1, cSecond, cKilogramPerSecond, cKilogram, cPoiseuille, -1, -1, cKilogramPerSquareMeter, -1, -1),
    (cSquareJoule, -1, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, cSquareJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, cCoulombPerMeter, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, cHertz, cSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, cReciprocalHenry, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, cAmperePerMeter, cAmperePerSquareMeter, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, cCubicMeter, cNewtonSquareMeter, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, cLumenSecond, cLumenSecond, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, cLumenSecond, -1, cLux, -1, cLuxSecond, -1, -1),
    (cReciprocalMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, cJoulePerMole, -1, cCoulombPerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, -1, -1, -1, -1, -1),
    (cAmperePerSquareMeter, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, cAmperePerMeter, -1, cAmpere, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, cNewtonPerMeter, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, cReciprocalMeter, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatalPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, cKatalPerCubicMeter, -1, -1, cMole, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter),
    (cLux, cLuxSecond, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, cCoulombPerMeter, cCoulomb, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, -1, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, cAmperePerMeter, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, cCoulombPerMeter, cCoulomb, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cGrayPerSecond, cSquareMeterPerSquareSecond, cSquareMeterPerSecond, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, cMeterPerCubicSecond, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cHertz, cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cMeterPerSecond, -1, cSquareMeterPerSecond, cCubicMeterPerSecond, -1, -1, -1, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, cSquareHertz, -1, -1, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, cGrayPerSecond, cMeter, cKilogramMeterPerSecond, cNewtonPerMeter, cNewton, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cJoule, cReciprocalMeter, cPoiseuille, -1, -1, cWattPerMeter, cWattPerMeter, -1, cWattPerCubicMeter, cWatt, cWatt, -1, cAmpere, -1, -1, -1, -1, cSiemens, -1, cReciprocalHenry, -1, -1, cVolt, cOhm, -1, cCandela, -1, -1, cLux, -1, -1, cWattPerSquareMeter, cCubicMeterPerSquareSecond, cPascal, cSquareMeterPerSquareSecond, cKilogramPerQuarticMeterPerSecond, cQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cAmperePerMeter, -1, cAmperePerSquareMeter, -1, -1, -1, cVoltMeterPerSecond, -1, cSiemensPerMeter, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatalPerCubicMeter, -1, -1, -1, cSquareHertz, cMeterPerSecond, cSquareMeterPerSecond, cCubicMeterPerSecond, cSquareMeterPerSquareSecond, -1, cWatt, -1, -1, -1, cWattPerSquareMeter, -1, -1),
    (cMeter, cMeterSecond, -1, -1, -1, -1, -1, cSquareMeter, -1, cCubicMeter, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, cKilogramMeter, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerSquareSecond, cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, cCubicMeterPerSquareSecond, -1, cKilogramSquareMeter, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, cSquareRootMeter, cScalar, cReciprocalSquareRootMeter, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, -1, -1, cSecond, cKilogram, cKilogramPerMeter, cKilogramPerSquareMeter, cJoule, cJoule, -1, cNewtonPerMeter, cNewtonSquareMeter, cNewtonSquareMeter, -1, cCoulombMeter, -1, -1, cVoltMeter, -1, -1, cOhmMeter, -1, cSiemens, cTeslaMeter, -1, -1, -1, -1, cLuxSecond, -1, -1, -1, cPascal, cNewton, -1, cKilogramPerSecond, cCubicMeterPerSecond, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, cSquareKilogram, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, cKelvin, cWatt, cWattPerMeter, cWattPerSquareMeter, -1, cWattPerKelvin, cMeterKelvinPerWatt, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, cVolt, cCoulomb, cSquareCoulomb, cCoulombPerMeter, -1, -1, -1, -1, -1, cFarad, cAmpere, -1, cWeber, cHenryPerMeter, cHenry, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, cCoulombPerSquareMeter, -1, cMeterPerSecond, cSquareMeter, cCubicMeter, cQuarticMeter, cCubicMeterPerSecond, -1, cNewtonSquareMeter, cWatt, cWattPerMeter, cWattPerSquareMeter, cNewton, -1, -1),
    (cSquareMeter, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, -1, cKilogramSquareMeter, -1, cSquareMeterAmpere, -1, -1, -1, -1, cSquareMeterQuarticKelvin, -1, -1, cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, cSquareJouleSquareSecond, -1, cMeter, cSquareRootMeter, cScalar, cReciprocalMeter, cReciprocalSquareMeter, -1, -1, cMeterSecond, cKilogramMeter, cKilogram, cKilogramPerMeter, cNewtonSquareMeter, cNewtonSquareMeter, cSquareJoule, cNewton, cNewtonCubicMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, cCandela, cLumenSecond, -1, cNewtonPerMeter, cJoule, -1, cKilogramMeterPerSecond, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, cSquareKilogram, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, cMeterKelvin, -1, cWatt, cWattPerMeter, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, cCoulombMeter, -1, cCoulomb, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, cMeter, cSquareKilogramSquareMeterPerSquareSecond, cSquareSecond, -1, -1, -1, -1, -1, -1, cAmpere, -1, cCandela, cCoulombPerMeter, -1, cSquareMeterPerSecond, cCubicMeter, cQuarticMeter, cQuinticMeter, -1, -1, cNewtonCubicMeter, -1, cWatt, cWattPerMeter, cJoule, -1, -1),
    (cCubicMeter, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, cQuinticMeter, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cCubicMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, -1, cSquareMeter, -1, cMeter, cScalar, cReciprocalMeter, -1, -1, -1, cKilogramSquareMeter, cKilogramMeter, cKilogram, cNewtonCubicMeter, cNewtonCubicMeter, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecond, -1, -1, -1, cNewton, cNewtonSquareMeter, -1, cKilogramSquareMeterPerSecond, -1, cKilogramPerMeter, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, -1, cCoulomb, -1, cCubicMeterPerSecond, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, -1, -1, -1, -1, cWatt, cNewtonSquareMeter, cKatal, -1),
    (cSquareMeterPerSecond, cSquareMeter, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cGrayPerSecond, cGrayPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, cJoule, cNewtonSquareMeter, -1, -1, cMeterPerSecond, -1, cHertz, -1, -1, -1, cNewtonCubicMeter, cMeter, cKilogramMeterPerSecond, cKilogramPerSecond, cPoiseuille, -1, -1, -1, cWattPerMeter, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, -1, -1, -1, -1, cCandela, -1, cWattPerSquareMeter, cWatt, -1, cNewton, -1, -1, cSexticMeter, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, cOhm, cOhmMeter, cMeterPerSecond, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, cSquareMeterPerSquareSecond, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1),
    (cWatt, cJoule, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cSquareNewton, -1, -1, -1, cWattPerMeter, -1, cWattPerSquareMeter, cWattPerCubicMeter, -1, -1, cSquareJoule, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, cMeter, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, cWattPerMeter, -1, cKilogramPerSecond, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoule, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, cNewtonSquareMeter, -1, cNewtonCubicMeter, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, cSquareJouleSquareSecond, -1, cKilogramMeterPerSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, cSquareJoule, cSquareJoule, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, cNewtonRadian, -1, cKilogram, -1, -1, -1, -1, cLumenSecond, cJoulePerMole, -1, -1, -1, -1, -1, cWatt, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, cSquareJoule, -1, -1, -1, cSquareNewton, -1, -1),
    (cWattPerMeter, cNewton, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, cSquareNewton, -1, -1, cWattPerSquareMeter, -1, cWattPerCubicMeter, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, cScalar, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, -1, cWattPerSquareMeter, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerSquareMeter, cNewtonPerMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, cWattPerMeter, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, cSquareNewton, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cKelvinPerMeter, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerCubicMeter, cPascal, cPoiseuille, cKilogramPerMeter, -1, -1, -1, cWattPerSquareMeter, -1, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonPerMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, -1, cNewton, -1, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, cPascal, -1, cNewtonPerCubicMeter, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, cCubicMeterPerSquareSecond, cSquareKilogram, -1, -1, cSquareJoule, cMeterPerQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, cPascal, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, cNewton, cJoule, cNewtonSquareMeter, cWatt, -1, cSquareNewton, -1, -1, -1, -1, -1, -1),
    (cKatalPerCubicMeter, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCoulombPerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1)
  );

  { Div Table }

  DivTable : array[0..158, 0..158] of longint = (
    (cScalar, cHertz, cSquareHertz, -1, -1, -1, -1, cReciprocalMeter, cReciprocalSquareRootMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, cReciprocalMole, -1, cSecond, cSquareSecond, cSquareSecond, cSecondPerMeter, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, cSquareRootMeter, cMeter, -1, cSquareMeter, cCubicMeter, cQuarticMeter, -1, -1, cMeterPerSecond, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, cOhm, cOhmMeter, -1, -1, cReciprocalHenry, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareKilogram, cSquareKilogramPerSquareMeter, -1, cKelvin, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, cKelvinPerWatt, cMeterKelvinPerWatt, cWattPerKelvin, cWattPerMeter, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, cNewtonSquareMeterPerSquareCoulomb, cMeterPerAmpere, cAmperePerMeter, -1, -1, -1, cMeter, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, cMole, -1, -1, -1, -1, -1, cSecond, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1),
    (cSecond, cScalar, cHertz, cSquareHertz, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cCubicSecond, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, cQuarticMeterSecond, -1, -1, cMeter, -1, -1, -1, cMeterPerWatt, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, cFarad, cHenry, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, cCoulombPerMeter, -1, -1, -1, cMeterSecond, -1, cSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cSecondPerMeter, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareSecond, cSecond, cScalar, cHertz, cSquareHertz, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, cQuarticSecond, cQuarticSecond, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCubicSecond, cSquareSecond, cSecond, cScalar, cHertz, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticSecond, cQuinticSecond, cQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuarticSecond, cCubicSecond, cSquareSecond, cSecond, cScalar, cHertz, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticSecond, cSexticSecond, cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuinticSecond, cQuarticSecond, cCubicSecond, cSquareSecond, cSecond, cScalar, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSexticSecond, cQuinticSecond, cQuarticSecond, cCubicSecond, cSquareSecond, cSecond, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeter, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, cScalar, cSquareRootMeter, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, -1, cHertz, -1, -1, -1, -1, -1, cSquareMeter, -1, cCubicMeter, cQuarticMeter, cQuinticMeter, -1, -1, cSquareMeterPerSecond, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, cKilogramPerSquareMeter, cNewtonPerSquareKilogram, cSquareSecondPerSquareMeter, -1, -1, cKilogramSquareSecond, cSquareMeterPerSquareKilogram, -1, cSquareKilogramPerMeter, -1, cMeterKelvin, -1, -1, -1, cReciprocalKelvin, cSquareMeterKelvin, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, cWatt, cWattPerKelvin, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, cSquareMeterPerSquareCoulomb, -1, cSquareCoulombPerMeter, -1, cFarad, -1, -1, -1, -1, cAmpere, -1, -1, -1, cSquareMeter, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, cScalar, cReciprocalMeter, cReciprocalSquareMeter, cSecondPerMeter, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1),
    (cSquareRootMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareRootMeter, cScalar, cReciprocalSquareRootCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareRootMeter, cReciprocalSquareRootCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeter, cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, cMeter, -1, cScalar, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, cSquareMeterPerSquareKilogram, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, cSquareSecond, cMeterPerSecond, -1, -1, -1, -1, -1, cCubicMeter, -1, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, -1, cCubicMeterPerSecond, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, cSecond, -1, -1, -1, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, cMeter, cScalar, cReciprocalMeter, cSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCubicMeter, cCubicMeterPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, cSquareMeter, -1, cMeter, cScalar, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, -1, -1, -1, -1, -1, cQuarticMeter, -1, cQuinticMeter, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, cMeterSecond, -1, -1, -1, cKilogram, cNewtonSquareMeterPerSquareKilogram, cSquareSecond, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, cQuarticMeter, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, cMeter, cScalar, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuarticMeter, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, cSquareMeter, cMeter, cScalar, cReciprocalMeter, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cCubicMeterPerKilogram, -1, -1, -1, -1, cQuinticMeter, -1, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, cHertz, -1, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, cCubicMeter, cSquareMeter, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuinticMeter, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, cCubicMeter, cSquareMeter, cMeter, cScalar, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSexticMeter, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, cCubicMeter, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSexticMeter, -1, -1, -1, -1, -1, -1, cQuinticMeter, -1, cQuarticMeter, cCubicMeter, cSquareMeter, cMeter, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, cSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, cQuarticMeter, cCubicMeter, cQuarticMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogram, cKilogramPerSecond, cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, cKilogramPerMeter, -1, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, cReciprocalMeter, cSecond, cSecondPerMeter, -1, -1, cKilogramMeter, -1, cKilogramSquareMeter, -1, -1, cReciprocalSquareMeter, -1, cKilogramMeterPerSecond, cMeter, cSquareMeter, cCubicMeter, -1, -1, -1, -1, cSquareSecondPerSquareMeter, cSquareSecondPerSquareMeter, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, -1, cMeterSecond, -1, cQuarticMeter, cKilogramPerQuarticMeterPerSecond, cQuarticMeterSecond, -1, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramKelvin, cReciprocalKelvin, -1, -1, -1, -1, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, cSquareCoulombPerMeter, cKilogramMeter, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogramPerCubicMeter, -1, -1, cSquareSecondPerSquareMeter, -1, cCubicSecond, -1, cSquareSecond, -1, -1),
    (cSquareKilogram, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, cSquareKilogramPerMeter, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, cKilogram, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, cKilogramMeter, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, cMeter, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1),
    (cAmpere, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, cCoulomb, -1, -1, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, cSiemens, -1, -1, -1, cVolt, cVoltMeter, -1, cReciprocalHenry, -1, cWeber, -1, -1, -1, -1, cCoulombPerMole, -1, -1, cCoulombPerCubicMeter, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, cSquareMeterPerSecond, -1, -1, -1, cSiemensPerMeter, cFaradPerMeter, cVoltMeterPerSecond, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, cReciprocalSquareMeter, -1, -1, cSquareMeter, -1, -1, cCubicMeterPerSecond, -1, cCoulomb, cAmperePerMeter, cAmperePerSquareMeter, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cKatal),
    (cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, cScalar, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, cSquareCoulomb, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, cReciprocalHenry, cSiemens, -1, cSquareHertz, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, cReciprocalHenry, -1, -1, -1, -1, -1, -1),
    (cKelvin, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKelvin, -1, -1, -1, cReciprocalMeter, cMeter, cMeterKelvinPerWatt, -1, -1, -1, -1, cWatt, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, cReciprocalMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, cMoleKelvin, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, cKelvinPerWatt, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1),
    (cSquareKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, cScalar, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicKelvin, -1, -1, -1, cKelvinPerMeter, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCubicKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKelvin, cKelvin, cScalar, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicKelvin, cSquareKelvin, cKelvin, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMole, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMoleKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCandela, -1, -1, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, cCubicMeterPerSecond, cSquareMeter, cSquareMeterPerSecond, -1, -1, -1, cLumenSecondPerCubicMeter, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, cSquareMeter, -1, -1, cLumenSecond, -1, cLux, -1, cLuxSecond, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1),
    (cHertz, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cSecond, cSecond, cReciprocalMeter, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, cSquareMeterPerSecond, cCubicMeterPerSecond, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, cNewtonSquareMeterPerSquareCoulomb, cCoulombPerKilogram, -1, -1, cOhm, -1, -1, -1, -1, cReciprocalMole, -1, -1, cReciprocalCubicMeter, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, cGrayPerSecond, -1, -1, cTesla, -1, -1, cKatal, -1, -1, -1, -1, cSquareSecondPerSquareMeter, cScalar, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, cScalar, cScalar, -1, cReciprocalMeter, cSecondPerMeter, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, cMeterPerCubicSecond, cNewtonPerSquareKilogram, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, cKilogramPerMeter, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, cScalar, cScalar, -1, cReciprocalMeter, cSecondPerMeter, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, cMeterPerCubicSecond, cNewtonPerSquareKilogram, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, cKilogramPerMeter, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, cMeterSecond, cMeterSecond, cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSecondPerMeter, cSquareHertz, -1, -1, -1, -1, -1, cSquareMeterPerSecond, -1, cCubicMeterPerSecond, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, cSquareMeterPerSecond, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, cHertz, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, -1, cSquareHertz, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, cMeter, cMeter, cHertz, cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cReciprocalMeter, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, cGrayPerSecond, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, cReciprocalSquareMeter, -1, -1, cKilogram, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, cKelvinPerMeter, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, cMeterPerSecond, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cMeterPerSecond, cMeterPerSecond, cSquareHertz, cHertz, cScalar, cSecond, cSquareSecond, cCubicSecond, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cMeterPerSquareSecond, cMeterPerSquareSecond, -1, cSquareHertz, cHertz, cScalar, cSecond, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1),
    (cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuarticSecond, cMeterPerCubicSecond, cMeterPerCubicSecond, -1, -1, cSquareHertz, cHertz, cScalar, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuarticSecond, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1),
    (cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, cMeterPerQuarticSecond, cMeterPerQuarticSecond, -1, -1, -1, cSquareHertz, cHertz, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, cSquareMeterPerSecond, cSquareMeter, cSquareMeter, cMeterPerSecond, cMeter, cMeterSecond, -1, -1, -1, cScalar, cMeterPerCubicSecond, cNewtonPerSquareKilogram, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, cPascal, -1, cReciprocalMeter, -1, -1, cKilogramMeter, -1, -1, cSquareKilogramPerSquareSecond, cKilogramPerMeter, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, cSquareMeterPerSquareKilogram, -1, -1, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, cSecond, cSquareMeterPerSecond, cMeterPerSquareSecond, cSquareHertz, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterSecond, cMeter, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cSecond, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, cMeterPerWatt, -1, cMeterPerAmpere, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, cSecondPerMeter, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1),
    (cKilogramMeter, cKilogramMeterPerSecond, cNewton, cWattPerMeter, -1, -1, -1, cKilogram, -1, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, cKilogramPerSecond, cScalar, cMeterSecond, cSecond, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, cReciprocalMeter, cSecondPerMeter, cKilogramSquareMeterPerSecond, cSquareMeter, cCubicMeter, cQuarticMeter, cSquareSecond, cSquareSecond, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, -1, -1, cSquareKilogramPerSquareMeter, cMeterPerSquareSecond, -1, cSquareSecondPerSquareMeter, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, cKilogramSquareMeter, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, cKilogramPerMeter, cKilogramPerSquareMeter, -1, -1, -1, cCubicSecond, -1, -1, -1, -1, -1),
    (cKilogramPerSecond, cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, -1, -1, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, cPascal, -1, cScalar, cReciprocalMeter, -1, -1, cKilogramMeterPerSecond, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, cReciprocalSquareMeter, cNewton, cMeterPerSecond, cSquareMeterPerSecond, cCubicMeterPerSecond, cSecondPerMeter, cSecondPerMeter, -1, cMeterSecond, -1, -1, cSquareSecondPerSquareMeter, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, cKilogramPerCubicMeter, cMeter, cKilogramPerSquareMeter, -1, -1, cQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, -1, cKilogramMeterPerSecond, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, cPoiseuille, -1, -1, cKilogramPerSquareMeter, cSquareSecondPerSquareMeter, -1, -1, cSquareSecond, -1, cSecond, -1, -1),
    (cKilogramMeterPerSecond, cNewton, cWattPerMeter, -1, -1, -1, -1, cKilogramPerSecond, -1, cPoiseuille, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, -1, -1, cKilogram, -1, cKilogramSquareSecond, -1, -1, -1, -1, cNewtonPerMeter, cHertz, cMeter, cScalar, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, cReciprocalMeter, cJoule, cSquareMeterPerSecond, cCubicMeterPerSecond, -1, cSecond, cSecond, cMeterPerWatt, -1, cSecondPerMeter, cSecondPerMeter, -1, cTeslaMeter, -1, cTesla, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, cCoulombMeter, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, cKilogramPerSquareMeter, cSquareMeter, cKilogramPerMeter, -1, -1, cQuinticMeter, -1, cMeterPerCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, cOhm, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cKilogramPerSecond, cPoiseuille, -1, cKilogramPerMeter, -1, cSecondPerMeter, cSquareSecond, -1, -1, cMeterSecond, -1, -1),
    (cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, cJoule, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, cNewton, cKilogramSquareMeterPerSecond, cKilogramMeterPerSecond, cScalar, -1, -1, -1, cSquareJouleSquareSecond, -1, -1, cNewtonPerMeter, cKilogramPerSecond, -1, cNewtonSquareMeter, cNewtonCubicMeter, -1, cKilogramMeter, cKilogramMeter, cSquareSecond, -1, cKilogram, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, cKilogramPerMeter, cKilogramPerSquareMeter, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, cJoulePerKelvin, cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, cSquareJoule, cSquareSecondPerSquareMeter, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, cKilogram, -1, -1, -1, cKilogramSquareMeter, -1, -1),
    (cReciprocalSquareRootMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareRootCubicMeter, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cSquareRootMeter, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareRootMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareRootCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cReciprocalSquareRootCubicMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareRootMeter, cScalar, cSquareRootMeter, cMeter, cSquareMeter, cCubicMeter, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, cSiemensPerMeter, -1, cOhm, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, -1, cReciprocalKelvin, -1, cMeterPerWatt, -1, -1, cKelvinPerWatt, cWattPerMeterPerKelvin, cWattPerSquareMeter, cWattPerSquareMeterPerKelvin, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, cReciprocalHenry, cScalar, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, cSecondPerMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1),
    (cReciprocalSquareRootCubicMeter, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cReciprocalSquareRootMeter, cScalar, cSquareRootMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareRootMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareRootCubicMeter, cReciprocalMeter, cReciprocalSquareRootMeter, cScalar, cMeter, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, cWattPerSquareMeterPerKelvin, cWattPerCubicMeter, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, -1, cReciprocalHenry, -1, cReciprocalMeter, -1, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1),
    (cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cReciprocalSquareRootCubicMeter, cReciprocalMeter, cScalar, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, cReciprocalMole, -1, -1, -1, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, cReciprocalSquareMeter, cReciprocalMeter, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramSquareMeter, cKilogramSquareMeterPerSecond, cJoule, cWatt, -1, -1, -1, cKilogramMeter, -1, cKilogram, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, cKilogramMeterPerSecond, cMeter, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, cScalar, cSecond, -1, cCubicMeter, cQuarticMeter, cQuinticMeter, -1, -1, -1, -1, cSquareSecond, cSquareSecond, cCubicSecond, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSexticMeter, -1, -1, cSquareKilogramPerMeter, cSquareMeterPerSquareSecond, -1, -1, cSquareSecondPerSquareMeter, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cKilogram, cKilogramPerMeter, -1, cCubicSecond, cSquareSecond, -1, -1, -1, -1, -1, -1),
    (cKilogramSquareMeterPerSecond, cJoule, cWatt, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, cKilogramPerSecond, cPoiseuille, -1, -1, cKilogramPerQuarticMeterPerSecond, cSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, cKilogramMeter, -1, -1, -1, -1, -1, -1, cNewton, cMeterPerSecond, cSquareMeter, cMeter, -1, -1, -1, -1, -1, -1, -1, cHertz, cScalar, cNewtonSquareMeter, cCubicMeterPerSecond, -1, -1, cMeterSecond, cMeterSecond, -1, -1, cSecond, cSecond, cSquareSecond, cWeber, cOhm, cTeslaMeter, -1, -1, -1, cSquareCoulomb, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, cKilogramPerMeter, cCubicMeter, cKilogram, -1, cNewtonPerCubicMeter, cSexticMeter, -1, cGrayPerSecond, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, cKilogramSquareMeter, cKilogramMeterPerSecond, cKilogramPerSecond, cPoiseuille, cKilogram, cSquareSecond, cSecond, -1, -1, -1, -1, -1, -1),
    (cSecondPerMeter, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, cSecond, -1, cMeterSecond, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, cHenryPerMeter, cHenry, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, cOhm, -1, cCoulombPerSquareMeter, -1, -1, cSiemens, cSecond, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1),
    (cKilogramPerMeter, cPoiseuille, cPascal, cWattPerCubicMeter, -1, -1, -1, cKilogramPerSquareMeter, -1, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cSecondPerMeter, -1, -1, -1, cKilogram, -1, cKilogramMeter, cKilogramSquareMeter, -1, cReciprocalCubicMeter, -1, cKilogramPerSecond, cScalar, cMeter, cSquareMeter, cSquareSecondPerSquareMeter, cSquareSecondPerSquareMeter, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, cKilogram, -1, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, cCubicSecond, -1, -1, -1),
    (cKilogramPerSquareMeter, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, cKilogramPerMeter, -1, cKilogram, cKilogramMeter, cKilogramSquareMeter, cReciprocalQuarticMeter, -1, cPoiseuille, cReciprocalMeter, cScalar, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cSquareSecondPerSquareMeter, -1, cSecondPerMeter, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1),
    (cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, cReciprocalQuarticMeter, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, cKilogramPerMeter, cKilogram, cKilogramMeter, -1, -1, -1, cReciprocalSquareMeter, cReciprocalMeter, cScalar, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewton, cWattPerMeter, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, cPascal, cNewtonPerCubicMeter, -1, -1, -1, cMeterPerSquareSecond, cNewtonPerSquareKilogram, cTeslaMeter, cHenryPerMeter, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, cKilogramMeter, cKilogramMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, -1, cKilogramPerMeter, cWattPerSquareMeter, cSquareHertz, cMeterPerSecond, cHertz, -1, -1, cJoule, -1, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, cWatt, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, cScalar, cScalar, -1, cSquareMeter, cReciprocalMeter, cRadianPerMeter, cSecondPerMeter, cVoltPerMeter, cNewtonPerSquareCoulomb, -1, cCoulombPerMeter, cFaradPerMeter, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, cMeter, -1, cSquareMeterPerSecond, cPoiseuille, -1, -1, -1, -1, cMeterPerQuarticSecond, cKilogramPerSquareMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cSquareKilogram, -1, cNewtonSquareMeterPerSquareKilogram, -1, cSquareKilogramPerSquareMeter, -1, -1, cKelvinPerMeter, -1, -1, cJoulePerKelvin, cSecond, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, cVolt, -1, cVoltMeter, -1, cSquareCoulomb, -1, cCoulombPerSquareMeter, -1, cSquareVolt, cWeber, -1, cAmpere, -1, cSquareAmpere, cJoulePerRadian, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, cPoiseuille, cSecondPerMeter, cReciprocalMeter, cSecond, cMeterSecond, -1, cMeter, -1, -1),
    (cNewtonRadian, cWattPerMeter, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, cPascal, cNewtonPerCubicMeter, -1, -1, -1, cMeterPerSquareSecond, cNewtonPerSquareKilogram, cTeslaMeter, cHenryPerMeter, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, cKilogramMeter, cKilogramMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, -1, cKilogramPerMeter, cWattPerSquareMeter, cSquareHertz, cMeterPerSecond, cHertz, -1, -1, cJoule, -1, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, cWatt, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, cScalar, cScalar, -1, cSquareMeter, cRadianPerMeter, cReciprocalMeter, cSecondPerMeter, cVoltPerMeter, cNewtonPerSquareCoulomb, -1, cCoulombPerMeter, cFaradPerMeter, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, cMeter, -1, cSquareMeterPerSecond, cPoiseuille, -1, -1, -1, -1, cMeterPerQuarticSecond, cKilogramPerSquareMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cSquareKilogram, -1, cNewtonSquareMeterPerSquareKilogram, -1, cSquareKilogramPerSquareMeter, -1, -1, cKelvinPerMeter, -1, -1, cJoulePerKelvin, cSecond, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, cVolt, -1, cVoltMeter, -1, cSquareCoulomb, -1, cCoulombPerSquareMeter, -1, cSquareVolt, cWeber, -1, cAmpere, -1, cSquareAmpere, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, cPoiseuille, cSecondPerMeter, cRadianPerMeter, cSecond, cMeterSecond, -1, cMeter, -1, -1),
    (cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, cWatt, cWattPerMeter, cSquareHertz, -1, -1, -1, cSquareJoule, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, cNewton, cNewton, cScalar, cNewtonSquareMeter, cNewtonPerMeter, cNewtonPerMeter, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, cNewtonPerMeter, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, cJoule, -1, -1),
    (cPascal, cWattPerCubicMeter, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, cKilogramPerMeter, cKilogramPerMeter, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, cNewton, cJoule, cNewtonSquareMeter, -1, -1, cWattPerSquareMeter, cSquareHertz, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, cReciprocalSquareMeter, cReciprocalSquareMeter, -1, cScalar, cReciprocalCubicMeter, cReciprocalCubicMeter, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, cReciprocalMeter, cKilogramPerQuarticMeterPerSecond, cHertz, -1, cCubicMeterPerSquareSecond, -1, cCubicMeterPerSecond, -1, -1, cKilogramPerQuarticMeter, cReciprocalQuarticMeter, -1, cSquareKilogramPerSquareMeter, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, cTesla, -1, cAmperePerSquareMeter, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, cJoulePerMole, -1, cVolt, -1, cPoiseuille, cNewtonPerCubicMeter, -1, -1, -1, -1, cReciprocalCubicMeter, -1, cSecondPerMeter, cSecond, cReciprocalMeter, -1, -1),
    (cJoule, cWatt, -1, -1, -1, -1, -1, cNewton, -1, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, -1, -1, cSquareMeterPerSquareSecond, -1, cWeber, cHenry, cJoulePerKelvin, -1, -1, -1, cJoulePerMole, -1, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, cKilogramSquareMeter, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, -1, cKilogram, cWattPerMeter, cMeterPerSquareSecond, cSquareMeterPerSecond, cMeterPerSecond, -1, -1, cNewtonSquareMeter, -1, cNewtonCubicMeter, -1, -1, cSquareHertz, cHertz, -1, cCubicMeterPerSquareSecond, -1, -1, cMeter, cMeter, -1, cCubicMeter, cScalar, cScalar, cSecond, cVolt, -1, cVoltPerMeter, cCoulomb, cFarad, cSquareVolt, -1, -1, -1, cSquareMeterAmpere, cAmpere, cSquareAmpere, -1, -1, -1, -1, -1, -1, cQuarticMeter, cSquareMeter, cPoiseuille, cCubicMeterPerSecond, cKilogramPerSecond, -1, -1, -1, -1, -1, cKilogramPerMeter, cReciprocalMeter, cReciprocalSquareMeter, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, cSquareKilogramPerMeter, -1, cJoulePerKilogramPerKelvin, cKelvin, cKilogramKelvin, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, cJoulePerMolePerKelvin, cMoleKelvin, -1, cCoulombMeter, cVoltMeter, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, cSquareCoulombPerMeter, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cNewton, cNewtonPerMeter, cPascal, cKilogramPerSecond, cSecond, cScalar, cMeterSecond, -1, -1, cSquareMeter, -1, -1),
    (cJoulePerRadian, cWatt, -1, -1, -1, -1, -1, cNewton, -1, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, -1, -1, cSquareMeterPerSquareSecond, -1, cWeber, cHenry, cJoulePerKelvin, -1, -1, -1, cJoulePerMole, -1, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, cKilogramSquareMeter, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, -1, cKilogram, cWattPerMeter, cMeterPerSquareSecond, cSquareMeterPerSecond, cMeterPerSecond, -1, -1, cNewtonSquareMeter, -1, cNewtonCubicMeter, -1, -1, cSquareHertz, cHertz, -1, cCubicMeterPerSquareSecond, -1, -1, cMeter, cMeter, -1, cCubicMeter, cScalar, cScalar, cSecond, cVolt, -1, cVoltPerMeter, cCoulomb, cFarad, cSquareVolt, -1, -1, -1, cSquareMeterAmpere, cAmpere, cSquareAmpere, -1, -1, -1, -1, -1, -1, cQuarticMeter, cSquareMeter, cPoiseuille, cCubicMeterPerSecond, cKilogramPerSecond, -1, -1, -1, -1, -1, cKilogramPerMeter, cReciprocalMeter, cReciprocalSquareMeter, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, cSquareKilogramPerMeter, -1, cJoulePerKilogramPerKelvin, cKelvin, cKilogramKelvin, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, cJoulePerMolePerKelvin, cMoleKelvin, -1, cCoulombMeter, cVoltMeter, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, cSquareCoulombPerMeter, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cNewton, cNewtonPerMeter, cPascal, cKilogramPerSecond, cSecond, cScalar, cMeterSecond, -1, -1, cSquareMeter, -1, -1),
    (cWatt, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, cWattPerSquareMeter, cWattPerCubicMeter, -1, -1, -1, cGrayPerSecond, -1, cVolt, cOhm, cWattPerKelvin, -1, -1, cWattPerQuarticKelvin, -1, -1, cJoule, cKilogramSquareMeterPerSecond, cKilogramSquareMeterPerSecond, cNewton, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, cKilogramPerSecond, -1, cMeterPerCubicSecond, cSquareMeterPerSquareSecond, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, cSquareHertz, -1, -1, -1, -1, cMeterPerSecond, cMeterPerSecond, -1, cCubicMeterPerSecond, cHertz, cHertz, cScalar, -1, -1, -1, cAmpere, cSiemens, -1, cSquareAmpere, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, cSquareMeterPerSecond, cPascal, cCubicMeterPerSquareSecond, cNewtonPerMeter, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, cMeter, cSquareMeter, cCubicMeter, cKelvin, cMeterKelvin, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, cKatal, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, cAmperePerMeter, cCoulombPerMeter, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, cJoule, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, cNewtonPerMeter, cScalar, cHertz, cMeter, cSquareMeter, cCubicMeter, cSquareMeterPerSecond, -1, -1),
    (cCoulomb, cAmpere, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, cCoulombPerKilogram, -1, cSecond, -1, -1, -1, -1, -1, cCoulombPerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, cReciprocalMeter, cFarad, -1, cVolt, -1, cWeber, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, cSquareMeter, -1, -1, -1, cFaradPerMeter, -1, cVoltMeter, cMeterSecond, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, cKilogram, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, cCoulombPerMeter, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMole),
    (cSquareCoulomb, -1, cSquareAmpere, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, cFarad, -1, cCoulomb, cScalar, cCoulombPerMeter, -1, -1, cJoule, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, cMeter, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1),
    (cCoulombMeter, -1, -1, -1, -1, -1, -1, cCoulomb, -1, cCoulombPerMeter, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, cScalar, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, cCubicMeter, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cSecondPerMeter, -1, -1, -1, -1, -1, cQuarticMeter, -1, -1, cCoulomb, cCoulombPerMeter, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cVolt, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, cScalar, -1, -1, cAmpere, -1, -1, cSquareMeterPerSecond, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, cMeter, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, cCoulombMeter, cCoulombPerMeter, cReciprocalMeter, cSecondPerMeter, -1, cOhmMeter, cWattPerMeter, cMeterPerSecond, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, cVoltPerMeter, -1, -1, cTesla, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1),
    (cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, cNewtonSquareMeterPerSquareCoulomb, cSquareMeterPerSquareCoulomb, -1, -1, -1, cOhm, -1, -1, -1, cVolt, cScalar, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, cVoltMeter, -1, -1, -1, cSquareNewton, cNewtonSquareMeter, cNewton, cVoltPerMeter, cTeslaMeter, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, cOhmMeter, -1, -1, -1, -1, -1),
    (cFarad, cSiemens, cReciprocalHenry, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, cSecond, cMeterSecond, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cOhm, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cMeterPerAmpere, -1, -1, -1, cKilogramPerSecond, cMeterSecond, cSecondPerMeter, -1, -1, -1, -1, cVoltPerMeter, -1, cSquareMeterPerSecond, cMeterPerSecond, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSiemens, cReciprocalHenry, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, cScalar, cMeter, -1, -1, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cScalar, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, cWeber, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, cScalar, cReciprocalSquareMeter, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, cSecondPerMeter, -1, -1, cOhm, -1, -1, -1, -1, -1, -1, cHenryPerMeter, cPascal, cReciprocalMeter, cAmpere, cAmperePerMeter, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWeber, cVolt, -1, -1, -1, -1, -1, cTeslaMeter, -1, cTesla, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, cMeterPerAmpere, cMeterPerAmpere, -1, -1, -1, -1, -1, cOhm, -1, -1, cSecond, -1, -1, cCoulomb, -1, -1, cSquareMeter, cScalar, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, cMeterSecond, cOhmMeter, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, cNewton, cMeter, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cHenry, cOhm, -1, -1, -1, -1, -1, cHenryPerMeter, -1, cTeslaPerAmpere, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, cKilogram, -1, -1, -1, -1, -1, -1, cTeslaMeter, cMeterPerAmpere, cSquareMeter, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, cFarad, cFarad, cSiemensPerMeter, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareHertz, -1, cHertz, cMeterPerSecond, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cLumenSecond, cCandela, -1, -1, -1, -1, -1, -1, -1, cLuxSecond, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cCubicMeter, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, cLuxSecond, cLumenSecondPerCubicMeter, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1),
    (cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLuxSecond, -1, -1, cLumenSecond, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, cScalar, cSecondPerMeter, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, cPascal, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cLuxSecond, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, cScalar, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, cScalar, -1, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1),
    (cLuxSecond, cLux, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cMeter, cSecond, cScalar, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, cSecond, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1),
    (cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatalPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, cMole, -1, -1, cKatalPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1),
    (cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, cKilogramPerSquareMeter, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, cPascal, -1, cNewtonPerMeter, cNewton, cJoule, -1, -1, cWattPerCubicMeter, -1, cSquareHertz, cMeterPerSquareSecond, cReciprocalCubicMeter, cReciprocalCubicMeter, -1, cReciprocalMeter, cReciprocalQuarticMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cReciprocalSquareMeter, -1, -1, cKilogramPerQuarticMeterPerSecond, cSquareMeterPerSquareSecond, -1, cSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, cReciprocalQuarticMeter, -1, -1, cSecondPerMeter, cReciprocalSquareMeter, -1, -1),
    (cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, -1, -1, cPascal, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, cSquareHertz, -1, cTesla, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, cKilogram, cKilogram, cPoiseuille, cKilogramPerMeter, -1, -1, -1, -1, cKilogramPerSquareMeter, cWattPerCubicMeter, -1, cHertz, -1, -1, -1, cNewton, -1, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, cWattPerMeter, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, cReciprocalMeter, cReciprocalMeter, -1, cMeter, cReciprocalSquareMeter, cReciprocalSquareMeter, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, cAmpere, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, cScalar, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, cSquareKilogramPerMeter, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, cSecond, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, cVoltPerMeter, cNewtonPerSquareCoulomb, cVolt, -1, cSquareCoulombPerMeter, -1, cCoulombPerCubicMeter, -1, -1, cTeslaMeter, -1, cAmperePerMeter, cSquareAmpere, -1, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, cVoltMeter, -1, cKilogramPerSecond, cPascal, cNewtonPerCubicMeter, -1, -1, -1, cReciprocalSquareMeter, cSecondPerMeter, cSecond, cMeterSecond, cScalar, -1, -1),
    (cCubicMeterPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, cSquareMeterPerSecond, -1, cMeterPerSecond, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, cMeterSecond, cSquareMeterPerSquareSecond, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, cMeter, -1, -1, -1, cKilogramPerSecond, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, cSquareMeterPerSecond, cMeterPerSecond, cHertz, cMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cPoiseuille, cPascal, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, cReciprocalMeter, cReciprocalSquareMeter, -1, -1, cKilogramPerSecond, -1, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, -1, cReciprocalCubicMeter, cNewtonPerMeter, cHertz, cMeterPerSecond, cSquareMeterPerSecond, -1, -1, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, cSecondPerMeter, cKilogramPerQuarticMeter, cScalar, cKilogramPerCubicMeter, cCubicMeterPerSecond, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, cKilogramPerSecond, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, cKilogramPerMeter, -1, -1, cKilogramPerQuarticMeterPerSecond, cKilogramPerCubicMeter, -1, -1, cSquareSecondPerSquareMeter, -1, cSquareSecond, cSecondPerMeter, -1, -1),
    (cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, -1, cMeterPerSecond, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, -1, cMeter, cMeterSecond, -1, -1, -1, -1, cSecond, cMeterPerSquareSecond, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cCubicMeterPerKilogram, cScalar, -1, -1, -1, cPoiseuille, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cSquareMeter, cMeterPerSecond, cHertz, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramPerQuarticMeter, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, cKilogramPerSquareMeter, cKilogramPerMeter, cKilogram, -1, -1, -1, cReciprocalCubicMeter, cReciprocalSquareMeter, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, cScalar, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuarticMeterSecond, cQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, cSecond, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, cPoiseuille, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, cHertz, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCubicMeterPerKilogram, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramSquareSecond, -1, cKilogram, cKilogramPerSecond, cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticSecond, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticSecond, -1, cQuarticSecond, -1, -1),
    (cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, cMeterPerSquareSecond, cSquareHertz, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cCubicMeter, cCubicMeter, cSquareMeterPerSecond, cSquareMeter, -1, -1, -1, -1, cMeter, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, cHertz, -1, cMeterPerSecond, -1, -1, -1, cNewtonPerMeter, -1, cScalar, -1, -1, cKilogramSquareMeter, -1, -1, -1, cKilogram, -1, -1, -1, cMeterKelvin, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, cCubicMeterPerSecond, cSquareMeterPerSquareSecond, cMeterPerSquareSecond, cSquareHertz, cMeterPerSecond, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1),
    (cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, cJoule, -1, cNewton, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, -1, cCubicMeterPerSquareSecond, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, cKilogramMeter, cWatt, cSquareMeterPerSquareSecond, cCubicMeterPerSecond, cSquareMeterPerSecond, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, cMeterPerSquareSecond, cMeterPerSecond, -1, -1, -1, -1, cSquareMeter, cSquareMeter, -1, cQuarticMeter, cMeter, cMeter, cMeterSecond, cVoltMeter, cNewtonSquareMeterPerSquareCoulomb, cVolt, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, cCubicMeter, cKilogramPerSecond, -1, cKilogramMeterPerSecond, -1, cWattPerCubicMeter, -1, cSquareKilogramPerSquareSecond, -1, cKilogram, cScalar, cReciprocalMeter, -1, -1, -1, -1, cSquareKilogram, -1, -1, cMeterKelvin, -1, cJoulePerKelvin, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, cCoulomb, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, cNewtonCubicMeter, cCubicMeterPerKilogram, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cNewton, cNewtonPerMeter, cKilogramMeterPerSecond, cMeterSecond, cMeter, -1, -1, cQuarticMeterSecond, cCubicMeter, -1, -1),
    (cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cJoule, cNewton, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, cCubicMeterPerSquareSecond, -1, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cSquareMeterPerSecond, -1, -1, -1, -1, cCubicMeter, cCubicMeter, -1, cQuinticMeter, cSquareMeter, cSquareMeter, -1, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, cSexticMeter, cQuarticMeter, cKilogramMeterPerSecond, -1, cKilogramSquareMeterPerSecond, -1, cWattPerSquareMeter, -1, -1, -1, cKilogramMeter, cMeter, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, cJoule, cNewton, cKilogramSquareMeterPerSecond, -1, cSquareMeter, -1, cQuarticMeterSecond, -1, cQuarticMeter, -1, -1),
    (cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, cPascal, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, cKilogram, cKilogramMeter, cKilogramSquareMeter, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, -1, -1, -1, -1, cScalar, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, cSquareKilogramPerMeter, -1, cSquareKilogram, -1, -1, cKilogramPerQuarticMeter, -1, -1, cKilogramPerMeter, cKilogram, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, cReciprocalMeter, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, cSquareSecondPerSquareMeter, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareKilogram, cSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareHertz, -1, -1, -1, -1, cSquareMeter, -1, -1, cNewton, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, cWattPerMeterPerKelvin, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, cKilogramPerMeter, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoulePerKelvin, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, cScalar, cKilogram, -1, -1, -1, -1, -1, cSecond, cMeterSecond, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, cSquareMeterKelvin, -1, -1),
    (cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterKelvin, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterKelvin, -1, -1, -1, -1, -1, -1, cKelvin, -1, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, cKelvinPerMeter, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1),
    (cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cScalar, cKelvinPerWatt, cMeterKelvinPerWatt, -1, -1, -1, cWattPerMeter, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, cMeterKelvinPerWatt, -1, -1, -1, -1),
    (cWattPerMeter, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, cWattPerCubicMeter, -1, -1, -1, -1, cMeterPerCubicSecond, -1, cVoltPerMeter, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, cNewton, cKilogramMeterPerSecond, cKilogramMeterPerSecond, cNewtonPerMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, cPoiseuille, -1, -1, cMeterPerSquareSecond, cSquareHertz, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, cHertz, cHertz, -1, cSquareMeterPerSecond, -1, -1, cReciprocalMeter, -1, -1, -1, cAmperePerMeter, cSiemensPerMeter, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cMeterPerSecond, cNewtonPerCubicMeter, cSquareMeterPerSquareSecond, cPascal, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, cWattPerKelvin, cScalar, cMeter, cSquareMeter, cKelvinPerMeter, cKelvin, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, -1, cVoltMeterPerSecond, -1, -1, -1, cAmperePerSquareMeter, cCoulombPerSquareMeter, -1, cVolt, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, cKilogramPerMeter, cNewton, cWattPerSquareMeter, cWattPerCubicMeter, -1, cPascal, cReciprocalMeter, -1, cScalar, cMeter, cSquareMeter, cMeterPerSecond, -1, -1),
    (cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, cNewtonPerMeter, cKilogramPerSecond, cKilogramPerSecond, cPascal, cPoiseuille, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, cSquareHertz, -1, -1, -1, cWattPerMeter, -1, cWatt, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cGrayPerSecond, -1, -1, -1, -1, cMeterPerSecond, -1, -1, cReciprocalSquareMeter, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, cHertz, -1, cMeterPerSquareSecond, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, cReciprocalMeter, cScalar, cMeter, -1, cKelvinPerMeter, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, cVoltPerMeter, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, cVoltMeterPerSecond, cKilogramPerSquareMeter, cNewtonPerMeter, cWattPerCubicMeter, -1, -1, cNewtonPerCubicMeter, cReciprocalSquareMeter, -1, cReciprocalMeter, cScalar, cMeter, cHertz, -1, -1),
    (cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cPoiseuille, cPoiseuille, cNewtonPerCubicMeter, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cGrayPerSecond, -1, -1, -1, cHertz, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, -1, cSquareHertz, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, cReciprocalSquareMeter, cReciprocalMeter, cScalar, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, cKatalPerCubicMeter, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, cKilogramPerCubicMeter, cPascal, -1, -1, -1, -1, cReciprocalCubicMeter, -1, cReciprocalSquareMeter, cReciprocalMeter, cScalar, -1, cJoulePerMole, -1),
    (cWattPerKelvin, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerQuarticKelvin, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, cHertz, cKilogramPerSecond, -1, -1, -1, cSquareMeterKelvin, -1, cScalar, cMeter, -1, -1, -1, cWattPerSquareMeter, cSquareMeter, -1, cCubicKelvin, -1, -1, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, cWattPerMeterPerKelvin, cWattPerSquareMeterPerKelvin, -1, -1, cReciprocalKelvin, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1),
    (cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, cPoiseuille, -1, -1, cReciprocalKelvin, -1, cSquareMeterKelvin, cReciprocalMeter, cScalar, -1, -1, -1, cWattPerCubicMeter, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, cSquareMeterKelvin, -1, -1, -1),
    (cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, cScalar, cKelvinPerMeter, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, cKelvin, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterKelvin, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, cReciprocalSquareMeter, cReciprocalMeter, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1),
    (cSquareMeterQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, -1, -1, -1),
    (cJoulePerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMole, cReciprocalMole, -1, -1, -1, -1, cCoulombPerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMole, -1, -1, -1, -1, -1, cVolt),
    (cMoleKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, cReciprocalMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cOhmMeter, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, cMeterPerWatt, -1, cMeter, -1, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, cSecond, -1, -1, -1, -1, cVolt, -1, cCubicMeterPerSecond, cSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, cReciprocalMeter, -1, -1, cAmperePerMeter, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, cScalar, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cCoulomb, cCoulombPerSquareMeter, cReciprocalSquareMeter, -1, -1, cOhm, cWattPerSquareMeter, cHertz, -1, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1),
    (cCoulombPerMeter, cAmperePerMeter, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, cCoulomb, -1, cCoulombMeter, -1, -1, -1, -1, cAmpere, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, cReciprocalSquareMeter, cFaradPerMeter, -1, cVoltPerMeter, -1, cTeslaMeter, cWeber, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, cScalar, -1, cMeter, -1, -1, -1, -1, -1, cVolt, cSecond, -1, cSiemens, -1, -1, cCoulomb, -1, -1, -1, -1, cKilogramPerMeter, -1, -1, -1, cMeterSecond, -1, -1, cSquareMeter, -1, -1, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, cSiemens, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, cFarad, cFarad, -1, -1, cFaradPerMeter, cFaradPerMeter, -1, cCoulombPerMeter, cReciprocalMeter, cCoulombPerSquareMeter, -1, -1, cNewton, -1, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, -1, -1, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, cScalar, cCoulombMeter, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1),
    (cCoulombPerSquareMeter, cAmperePerSquareMeter, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, cCoulomb, cCoulombMeter, -1, -1, -1, cAmperePerMeter, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cReciprocalCubicMeter, -1, -1, -1, -1, cTesla, cTeslaMeter, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, cReciprocalMeter, -1, cScalar, -1, -1, -1, -1, -1, cVoltPerMeter, cSecondPerMeter, -1, cSiemensPerMeter, -1, -1, cCoulombPerMeter, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, cSecond, -1, -1, cMeter, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, cHenryPerMeter, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cScalar, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, cOhm, cHenry, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, cNewton, cSquareMeter, cScalar, -1, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cVoltMeter, cVoltMeterPerSecond, -1, -1, -1, -1, -1, cVolt, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, cNewtonSquareMeterPerSquareCoulomb, -1, -1, cMeter, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, cSquareMeter, -1, -1, -1, -1, -1, cCoulomb, cScalar, cSecond, -1, -1, cWatt, cSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, cVoltPerMeter, -1, cTeslaMeter, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1),
    (cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, cVolt, cWeber, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, -1, -1, -1, -1, cSquareMeterAmpere, cAmpere, cHertz, cScalar, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cFaradPerMeter, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, cSecondPerMeter, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cAmperePerMeter, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, cVoltPerMeter, cVolt, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, cHertz, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, cScalar, -1, cReciprocalHenry, -1, -1, cAmpere, -1, -1, -1, -1, cPoiseuille, cReciprocalCubicMeter, -1, -1, cMeter, -1, -1, cSquareMeterPerSecond, -1, cCoulombPerMeter, cAmperePerSquareMeter, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cTeslaMeter, cVoltPerMeter, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, cCoulombPerMeter, -1, -1, cMeter, cReciprocalMeter, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, cSecond, cOhm, -1, cOhmMeter, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, cHenry, cNewtonPerMeter, cScalar, -1, cAmpere, cWeber, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1),
    (cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, cHenry, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cReciprocalMeter, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cHenryPerMeter, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, -1, cOhm, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, cMeterPerAmpere, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, cSquareSecond, cSquareSecondPerSquareMeter, -1, -1, -1, -1, cTesla, -1, cMeter, cScalar, cHenry, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cRadianPerMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cReciprocalSquareRootCubicMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareRootMeter, cScalar, cSquareRootMeter, cMeter, cSquareMeter, cCubicMeter, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, cSiemensPerMeter, -1, cOhm, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, -1, cReciprocalKelvin, -1, cMeterPerWatt, -1, -1, cKelvinPerWatt, cWattPerMeterPerKelvin, cWattPerSquareMeter, cWattPerSquareMeterPerKelvin, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, cReciprocalHenry, cScalar, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, cSecondPerMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1),
    (cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, cSquareKilogram, -1, cSquareKilogramPerMeter, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, cPascal, cKilogramPerSecond, cPoiseuille, cReciprocalSquareMeter, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareJouleSquareSecond, cNewtonPerCubicMeter, -1, -1, cNewton, cJoule, cNewtonSquareMeter, cKilogramPerMeter, cKilogramPerMeter, cSquareSecondPerSquareMeter, cKilogramMeter, cKilogramPerSquareMeter, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, cKilogram, -1, cKilogramMeterPerSecond, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cSquareNewton, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, cKilogram, -1, -1),
    (cSquareSecondPerSquareMeter, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, cFarad, cFaradPerMeter, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareJoule, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJouleSquareSecond, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, cNewtonSquareMeter, cNewtonSquareMeter, cSquareMeter, -1, cJoule, cJoule, cKilogramSquareMeterPerSecond, -1, cSquareVolt, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, cKilogramSquareMeterPerSecond, cJoule, -1, -1, -1, cNewtonCubicMeter, -1, -1),
    (cSquareJouleSquareSecond, -1, cSquareJoule, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, cJoule, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, cSquareSecond, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1),
    (cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, cAmperePerMeter, cAmperePerSquareMeter, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cScalar, -1, -1, cQuarticMeter, -1, -1, -1, -1, -1, -1, cAmpere, cAmperePerMeter, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1),
    (cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, cAmpere, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, cReciprocalHenry, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, cReciprocalQuarticMeter, -1, -1, cScalar, -1, -1, cMeterPerSecond, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMolePerCubicMeter, cKatalPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1),
    (cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cLuxSecond, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, cScalar, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, cScalar, -1, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1),
    (cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, cCoulombPerMeter, cCoulomb, cCoulombMeter, -1, -1, cAmperePerSquareMeter, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, cTesla, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, cSecondPerMeter, cCoulombPerMole, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter),
    (cGrayPerSecond, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cSquareMeterPerSecond, cSquareMeterPerSecond, cMeterPerSquareSecond, cMeterPerSecond, cMeter, cMeterSecond, -1, -1, cHertz, cMeterPerQuarticSecond, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, cSquareHertz, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cSquareMeterPerSquareSecond, cMeterPerCubicSecond, -1, -1, cSquareHertz, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1),
    (cHertz, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cSecond, cSecond, cReciprocalMeter, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, cSquareMeterPerSecond, cCubicMeterPerSecond, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, cNewtonSquareMeterPerSquareCoulomb, cCoulombPerKilogram, -1, -1, cOhm, -1, -1, -1, -1, cReciprocalMole, -1, -1, cReciprocalCubicMeter, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, cGrayPerSecond, -1, -1, cTesla, -1, -1, cKatal, -1, -1, -1, -1, cSquareSecondPerSquareMeter, cScalar, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeter, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, cScalar, cSquareRootMeter, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, -1, cHertz, -1, -1, -1, -1, -1, cSquareMeter, -1, cCubicMeter, cQuarticMeter, cQuinticMeter, -1, -1, cSquareMeterPerSecond, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, cKilogramPerSquareMeter, cNewtonPerSquareKilogram, cSquareSecondPerSquareMeter, -1, -1, cKilogramSquareSecond, cSquareMeterPerSquareKilogram, -1, cSquareKilogramPerMeter, -1, cMeterKelvin, -1, -1, -1, cReciprocalKelvin, cSquareMeterKelvin, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, cWatt, cWattPerKelvin, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, cSquareMeterPerSquareCoulomb, -1, cSquareCoulombPerMeter, -1, cFarad, -1, -1, -1, -1, cAmpere, -1, -1, -1, cSquareMeter, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, cScalar, cReciprocalMeter, cReciprocalSquareMeter, cSecondPerMeter, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeter, cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, cMeter, -1, cScalar, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, cSquareMeterPerSquareKilogram, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, cSquareSecond, cMeterPerSecond, -1, -1, -1, -1, -1, cCubicMeter, -1, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, -1, cCubicMeterPerSecond, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, cSecond, -1, -1, -1, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, cMeter, cScalar, cReciprocalMeter, cSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCubicMeter, cCubicMeterPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, cSquareMeter, -1, cMeter, cScalar, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, -1, -1, -1, -1, -1, cQuarticMeter, -1, cQuinticMeter, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, cMeterSecond, -1, -1, -1, cKilogram, cNewtonSquareMeterPerSquareKilogram, cSquareSecond, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, cQuarticMeter, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, cMeter, cScalar, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, -1, cMeterPerSecond, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, -1, cMeter, cMeterSecond, -1, -1, -1, -1, cSecond, cMeterPerSquareSecond, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cCubicMeterPerKilogram, cScalar, -1, -1, -1, cPoiseuille, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cSquareMeter, cMeterPerSecond, cHertz, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWatt, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, cWattPerSquareMeter, cWattPerCubicMeter, -1, -1, -1, cGrayPerSecond, -1, cVolt, cOhm, cWattPerKelvin, -1, -1, cWattPerQuarticKelvin, -1, -1, cJoule, cKilogramSquareMeterPerSecond, cKilogramSquareMeterPerSecond, cNewton, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, cKilogramPerSecond, -1, cMeterPerCubicSecond, cSquareMeterPerSquareSecond, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, cSquareHertz, -1, -1, -1, -1, cMeterPerSecond, cMeterPerSecond, -1, cCubicMeterPerSecond, cHertz, cHertz, cScalar, -1, -1, -1, cAmpere, cSiemens, -1, cSquareAmpere, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, cSquareMeterPerSecond, cPascal, cCubicMeterPerSquareSecond, cNewtonPerMeter, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, cMeter, cSquareMeter, cCubicMeter, cKelvin, cMeterKelvin, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, cKatal, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, cAmperePerMeter, cCoulombPerMeter, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, cJoule, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, cNewtonPerMeter, cScalar, cHertz, cMeter, cSquareMeter, cCubicMeter, cSquareMeterPerSecond, -1, -1),
    (cJoule, cWatt, -1, -1, -1, -1, -1, cNewton, -1, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, -1, -1, cSquareMeterPerSquareSecond, -1, cWeber, cHenry, cJoulePerKelvin, -1, -1, -1, cJoulePerMole, -1, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, cKilogramSquareMeter, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, -1, cKilogram, cWattPerMeter, cMeterPerSquareSecond, cSquareMeterPerSecond, cMeterPerSecond, -1, -1, cNewtonSquareMeter, -1, cNewtonCubicMeter, -1, -1, cSquareHertz, cHertz, -1, cCubicMeterPerSquareSecond, -1, -1, cMeter, cMeter, -1, cCubicMeter, cScalar, cScalar, cSecond, cVolt, -1, cVoltPerMeter, cCoulomb, cFarad, cSquareVolt, -1, -1, -1, cSquareMeterAmpere, cAmpere, cSquareAmpere, -1, -1, -1, -1, -1, -1, cQuarticMeter, cSquareMeter, cPoiseuille, cCubicMeterPerSecond, cKilogramPerSecond, -1, -1, -1, -1, -1, cKilogramPerMeter, cReciprocalMeter, cReciprocalSquareMeter, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, cSquareKilogramPerMeter, -1, cJoulePerKilogramPerKelvin, cKelvin, cKilogramKelvin, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, cJoulePerMolePerKelvin, cMoleKelvin, -1, cCoulombMeter, cVoltMeter, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, cSquareCoulombPerMeter, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cNewton, cNewtonPerMeter, cPascal, cKilogramPerSecond, cSecond, cScalar, cMeterSecond, -1, -1, cSquareMeter, -1, -1),
    (cWattPerMeter, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, cWattPerCubicMeter, -1, -1, -1, -1, cMeterPerCubicSecond, -1, cVoltPerMeter, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, cNewton, cKilogramMeterPerSecond, cKilogramMeterPerSecond, cNewtonPerMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, cPoiseuille, -1, -1, cMeterPerSquareSecond, cSquareHertz, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, cHertz, cHertz, -1, cSquareMeterPerSecond, -1, -1, cReciprocalMeter, -1, -1, -1, cAmperePerMeter, cSiemensPerMeter, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cMeterPerSecond, cNewtonPerCubicMeter, cSquareMeterPerSquareSecond, cPascal, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, cWattPerKelvin, cScalar, cMeter, cSquareMeter, cKelvinPerMeter, cKelvin, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, -1, cVoltMeterPerSecond, -1, -1, -1, cAmperePerSquareMeter, cCoulombPerSquareMeter, -1, cVolt, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, cKilogramPerMeter, cNewton, cWattPerSquareMeter, cWattPerCubicMeter, -1, cPascal, cReciprocalMeter, -1, cScalar, cMeter, cSquareMeter, cMeterPerSecond, -1, -1),
    (cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, cNewtonPerMeter, cKilogramPerSecond, cKilogramPerSecond, cPascal, cPoiseuille, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, cSquareHertz, -1, -1, -1, cWattPerMeter, -1, cWatt, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cGrayPerSecond, -1, -1, -1, -1, cMeterPerSecond, -1, -1, cReciprocalSquareMeter, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, cHertz, -1, cMeterPerSquareSecond, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, cReciprocalMeter, cScalar, cMeter, -1, cKelvinPerMeter, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, cVoltPerMeter, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, cVoltMeterPerSecond, cKilogramPerSquareMeter, cNewtonPerMeter, cWattPerCubicMeter, -1, -1, cNewtonPerCubicMeter, cReciprocalSquareMeter, -1, cReciprocalMeter, cScalar, cMeter, cHertz, -1, -1),
    (cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cPoiseuille, cPoiseuille, cNewtonPerCubicMeter, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cGrayPerSecond, -1, -1, -1, cHertz, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, -1, cSquareHertz, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, cReciprocalSquareMeter, cReciprocalMeter, cScalar, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, cKatalPerCubicMeter, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, cKilogramPerCubicMeter, cPascal, -1, -1, -1, -1, cReciprocalCubicMeter, -1, cReciprocalSquareMeter, cReciprocalMeter, cScalar, -1, cJoulePerMole, -1),
    (cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, -1, -1, cPascal, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, cSquareHertz, -1, cTesla, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, cKilogram, cKilogram, cPoiseuille, cKilogramPerMeter, -1, -1, -1, -1, cKilogramPerSquareMeter, cWattPerCubicMeter, -1, cHertz, -1, -1, -1, cNewton, -1, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, cWattPerMeter, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, cReciprocalMeter, cReciprocalMeter, -1, cMeter, cReciprocalSquareMeter, cReciprocalSquareMeter, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, cAmpere, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, cScalar, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, cSquareKilogramPerMeter, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, cSecond, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, cVoltPerMeter, cNewtonPerSquareCoulomb, cVolt, -1, cSquareCoulombPerMeter, -1, cCoulombPerCubicMeter, -1, -1, cTeslaMeter, -1, cAmperePerMeter, cSquareAmpere, -1, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, cVoltMeter, -1, cKilogramPerSecond, cPascal, cNewtonPerCubicMeter, -1, -1, -1, cReciprocalSquareMeter, cSecondPerMeter, cSecond, cMeterSecond, cScalar, -1, -1),
    (cKatalPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1),
    (cCoulombPerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar)
  );

const
  PowerTable : array[0..158] of
    record  Square, Cubic, Quartic, Quintic, Sextic: longint; end = (
    (Square: 0; Cubic: 0; Quartic: 0; Quintic: 0; Sextic: 0),
    (Square: 2; Cubic: 3; Quartic: 4; Quintic: 5; Sextic: 6),
    (Square: 4; Cubic: 6; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 6; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 9; Cubic: 10; Quartic: 11; Quintic: 12; Sextic: 13),
    (Square: 7; Cubic: -1; Quartic: 9; Quintic: -1; Sextic: 10),
    (Square: 11; Cubic: 13; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 13; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 15; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 17; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 19; Cubic: 20; Quartic: 21; Quintic: -1; Sextic: -1),
    (Square: 21; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 25; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 33; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 133; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 38; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 40; Cubic: 41; Quartic: 42; Quintic: -1; Sextic: 43),
    (Square: 42; Cubic: 43; Quartic: 44; Quintic: -1; Sextic: -1),
    (Square: 43; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 44; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 136; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 134; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 91; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 53; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 53; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 135; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 135; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 59; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 62; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 42; Cubic: 43; Quartic: 44; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 25; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 9; Cubic: 10; Quartic: 11; Quintic: 12; Sextic: 13),
    (Square: 11; Cubic: 13; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 13; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 135; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1)
  );

const
  RootTable : array[0..158] of
    record  Square, Cubic, Quartic, Quintic, Sextic: longint; end = (
    (Square: 0; Cubic: 0; Quartic: 0; Quintic: 0; Sextic: 0),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: 1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 2; Cubic: -1; Quartic: 1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: 1; Sextic: -1),
    (Square: 3; Cubic: 2; Quartic: -1; Quintic: -1; Sextic: 1),
    (Square: 8; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 7; Cubic: -1; Quartic: 8; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: 7; Quartic: -1; Quintic: -1; Sextic: 8),
    (Square: 9; Cubic: -1; Quartic: 7; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: 7; Sextic: -1),
    (Square: 10; Cubic: 9; Quartic: -1; Quintic: -1; Sextic: 7),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 14; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 16; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 18; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: 18; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 19; Cubic: -1; Quartic: 18; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 24; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 24; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 27; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 37; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 39; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: 39; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 40; Cubic: -1; Quartic: 39; Quintic: -1; Sextic: -1),
    (Square: 41; Cubic: 40; Quartic: -1; Quintic: -1; Sextic: 39),
    (Square: 42; Cubic: -1; Quartic: 40; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 51; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 58; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 61; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 48; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 39; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 36; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 47; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 55; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 46; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 8; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 7; Cubic: -1; Quartic: 8; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: 7; Quartic: -1; Quintic: -1; Sextic: 8),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1)
  );

{ Power functions }

function SquarePower(const AQuantity: TQuantity): TQuantity;
function CubicPower(const AQuantity: TQuantity): TQuantity;
function QuarticPower(const AQuantity: TQuantity): TQuantity;
function QuinticPower(const AQuantity: TQuantity): TQuantity;
function SexticPower(const AQuantity: TQuantity): TQuantity;
function SquareRoot(const AQuantity: TQuantity): TQuantity;
function CubicRoot(const AQuantity: TQuantity): TQuantity;
function QuarticRoot(const AQuantity: TQuantity): TQuantity;
function QuinticRoot(const AQuantity: TQuantity): TQuantity;
function SexticRoot(const AQuantity: TQuantity): TQuantity;

{ Trigonometric functions }

function Cos(const AQuantity: TQuantity): double;
function Sin(const AQuantity: TQuantity): double;
function Tan(const AQuantity: TQuantity): double;
function Cotan(const AQuantity: TQuantity): double;
function Secant(const AQuantity: TQuantity): double;
function Cosecant(const AQuantity: TQuantity): double;

function ArcCos(const AValue: double): TQuantity;
function ArcSin(const AValue: double): TQuantity;
function ArcTan(const AValue: double): TQuantity;
function ArcTan2(const x, y: double): TQuantity;

{ Override trigonometric functions }

{$IFOPT D+}
function Cos(const AValue: double): double;
function Sin(const AValue: double): double;
function Tan(const AValue: double): double;
function Cotan(const AValue: double): double;
function Secant(const AValue: double): double;
function Cosecant(const AValue: double): double;
{$ENDIF}

{ Math functions }

function Min(const ALeft, ARight: TQuantity): TQuantity;
function Max(const ALeft, ARight: TQuantity): TQuantity;
function Exp(const AQuantity: TQuantity): TQuantity;

function Log10(const AQuantity : TQuantity) : double;
function Log2(const AQuantity : TQuantity) : double;
function LogN(ABase: longint; const AQuantity: TQuantity): double;
function LogN(const ABase, AQuantity: TQuantity): double;

function Power(const ABase: TQuantity; AExponent: double): double;

{ Helper functions }

function LessThanOrEqualToZero(const AQuantity: TQuantity): boolean;
function LessThanZero(const AQuantity: TQuantity): boolean;
function EqualToZero(const AQuantity: TQuantity): boolean;
function NotEqualToZero(const AQuantity: TQuantity): boolean;
function GreaterThanOrEqualToZero(const AQuantity: TQuantity): boolean;
function GreaterThanZero(const AQuantity: TQuantity): boolean;
function SameValue(const ALeft, ARight: TQuantity): boolean;

{ Constants }

const
  AvogadroConstant               : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cReciprocalMole;                     FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}
  BohrMagneton                   : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cSquareMeterAmpere;                  FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}
  BohrRadius                     : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cMeter;                              FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}
  BoltzmannConstant              : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cJoulePerKelvin;                     FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}
  ComptonWaveLength              : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cMeter;                              FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}
  CoulombConstant                : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cNewtonSquareMeterPerSquareCoulomb;  FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}
  DeuteronMass                   : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cKilogram;                           FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}
  ElectricPermittivity           : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cFaradPerMeter;                      FValue:     8.8541878128E-12); {$ELSE} (    8.8541878128E-12); {$ENDIF}
  ElectronMass                   : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cKilogram;                           FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}
  ElectronCharge                 : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cCoulomb;                            FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}
  MagneticPermeability           : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cHenryPerMeter;                      FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}
  MolarGasConstant               : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cJoulePerMolePerKelvin;              FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}
  NeutronMass                    : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cKilogram;                           FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}
  NewtonianConstantOfGravitation : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cNewtonSquareMeterPerSquareKilogram; FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}
  PlanckConstant                 : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cKilogramSquareMeterPerSecond;       FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}
  ProtonMass                     : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cKilogram;                           FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}
  RydbergConstant                : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cReciprocalMeter;                    FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}
  SpeedOfLight                   : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cMeterPerSecond;                     FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}
  SquaredSpeedOfLight            : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cSquareMeterPerSquareSecond;         FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}
  StandardAccelerationOfGravity  : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cMeterPerSquareSecond;               FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}
  ReducedPlanckConstant          : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cKilogramSquareMeterPerSecond;       FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}
  UnifiedAtomicMassUnit          : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: cKilogram;                           FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}

{ Prefix Table }

const
  PrefixTable: array[pQuetta..pQuecto] of
    record  Symbol, Name: string; Exponent: longint end = (
    (Symbol: 'Q';   Name: 'quetta';  Exponent: +30),
    (Symbol: 'R';   Name: 'ronna';   Exponent: +27),
    (Symbol: 'Y';   Name: 'yotta';   Exponent: +24),
    (Symbol: 'Z';   Name: 'zetta';   Exponent: +21),
    (Symbol: 'E';   Name: 'exa';     Exponent: +18),
    (Symbol: 'P';   Name: 'peta';    Exponent: +15),
    (Symbol: 'T';   Name: 'tera';    Exponent: +12),
    (Symbol: 'G';   Name: 'giga';    Exponent: +09),
    (Symbol: 'M';   Name: 'mega';    Exponent: +06),
    (Symbol: 'k';   Name: 'kilo';    Exponent: +03),
    (Symbol: 'h';   Name: 'hecto';   Exponent: +02),
    (Symbol: 'da';  Name: 'deca';    Exponent: +01),
    (Symbol: '';    Name: '';        Exponent:  00),
    (Symbol: 'd';   Name: 'deci';    Exponent: -01),
    (Symbol: 'c';   Name: 'centi';   Exponent: -02),
    (Symbol: 'm';   Name: 'milli';   Exponent: -03),
    (Symbol: 'μ';   Name: 'micro';   Exponent: -06),
    (Symbol: 'n';   Name: 'nano';    Exponent: -09),
    (Symbol: 'p';   Name: 'pico';    Exponent: -12),
    (Symbol: 'f';   Name: 'femto';   Exponent: -15),
    (Symbol: 'a';   Name: 'atto';    Exponent: -18),
    (Symbol: 'z';   Name: 'zepto';   Exponent: -21),
    (Symbol: 'y';   Name: 'yocto';   Exponent: -24),
    (Symbol: 'r';   Name: 'ronto';   Exponent: -27),
    (Symbol: 'q';   Name: 'quecto';  Exponent: -30)
  );

{ Helpers }

{ Power functions }

implementation

uses Math;

{ TQuantity }

{$IFOPT D+}
class operator TQuantity.:=(const ASelf: double): TQuantity;
begin
  result.FUnitOfMeasurement := cScalar;
  result.FValue := ASelf;
end;

class operator TQuantity.:=(const ASelf: TQuantity): double;
begin
  if ASelf.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Assign operator (:=) has detected wrong unit of measurements.');
  result := ASelf.FValue;
end;

class operator TQuantity.+(const ASelf: TQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := ASelf.FValue;
end;

class operator TQuantity.-(const ASelf: TQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TQuantity.+(const ALeft, ARight: TQuantity): TQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TQuantity.-(const ALeft, ARight: TQuantity): TQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TQuantity.*(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TQuantity./(const ALeft, ARight: TQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TQuantity.*(const ALeft: double; const ARight: TQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := ARight.FUnitOfMeasurement;
  result.FValue:= ALeft * ARight.FValue;
end;

class operator TQuantity./(const ALeft: double; const ARight: TQuantity): TQuantity;
begin
  result.FUnitOfMeasurement := DivTable[cScalar, ARight.FUnitOfMeasurement];
  result.FValue:= ALeft / ARight.FValue;
end;

class operator TQuantity.*(const ALeft: TQuantity; const ARight: double): TQuantity;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue:= ALeft.FValue * ARight;
end;

class operator TQuantity./(const ALeft: TQuantity; const ARight: double): TQuantity;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue:= ALeft.FValue / ARight;
end;

class operator TQuantity.=(const ALeft, ARight: TQuantity): boolean; inline;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := ALeft.FValue = ARight.FValue;
end;

class operator TQuantity.<(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := ALeft.FValue < ARight.FValue;
end;

class operator TQuantity.>(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := ALeft.FValue > ARight.FValue;
end;

class operator TQuantity.<=(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := ALeft.FValue <= ARight.FValue;
end;

class operator TQuantity.>=(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := ALeft.FValue >= ARight.FValue;
end;

class operator TQuantity.<>(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := ALeft.FValue <> ARight.FValue;
end;
{$ENDIF}

{ TSymbol }

class operator TSymbol.*(const AValue: double; const ASelf: TSymbol): TQuantity; inline;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TSymbol./(const AValue: double; const ASelf: TSymbol): TQuantity; inline;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

{$IFOPT D+}
class operator TSymbol.*(const AQuantity: TQuantity; const ASelf: TSymbol): TQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TSymbol./(const AQuantity: TQuantity; const ASelf: TSymbol): TQuantity; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;
{$ENDIF}

function TSymbol.GetName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := U.FName;
    1:  result := Format(U.FName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(U.FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(U.FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TSymbol.GetPluralName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := U.FPluralName;
    1:  result := Format(U.FPluralName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(U.FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(U.FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TSymbol.GetSymbol(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := U.FSymbol;
    1:  result := Format(U.FSymbol, [
          PrefixTable[Prefixes[0]].Symbol]);
    2:  result := Format(U.FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol]);
    3:  result := Format(U.FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol,
          PrefixTable[Prefixes[2]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TSymbol.GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
var
  I: longint;
  Exponent: longint;
  PrefixCount: longint;
begin
  PrefixCount := Length(APrefixes);
  if PrefixCount = Length(U.FPrefixes) then
  begin
    Exponent := 0;
    for I := 0 to PrefixCount -1 do
      Inc(Exponent, PrefixTable[U.FPREFIXES[I]].Exponent * U.FEXPONENTS[I]);

    for I := 0 to PrefixCount -1 do
      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * U.FEXPONENTS[I]);

    if Exponent <> 0 then
      {$IFOPT D+} result := AQuantity.FValue * IntPower(10, Exponent) {$ELSE} result := AQuantity * IntPower(10, Exponent) {$ENDIF}
    else
      {$IFOPT D+} result := AQuantity.FValue; {$ELSE} result := AQuantity; {$ENDIF}

  end else
    if PrefixCount = 0 then
      {$IFOPT D+} result := AQuantity.FValue {$ELSE} result := AQuantity {$ENDIF}
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

function TSymbol.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TSymbol.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TSymbol.ToString(const AQuantity: TQuantity): string;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := FloatToStr(AQuantity.FValue) + ' ' + GetSymbol(U.FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity) + ' ' + GetSymbol(U.FPrefixes);
{$ENDIF}
end;

function TSymbol.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  if Length(APrefixes) = 0 then
     result := FloatToStr(FactoredValue) + ' ' + GetSymbol(U.FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TSymbol.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}
  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(U.FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TSymbol.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(U.FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;

function TSymbol.ToVerboseString(const AQuantity: TQuantity): string;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');

  if (AQuantity.FValue > -1) and (AQuantity.FValue < 1) then
    result := FloatToStr(AQuantity.FValue) + ' ' + GetName(U.FPrefixes)
  else
    result := FloatToStr(AQuantity.FValue) + ' ' + GetPluralName(U.FPrefixes);
{$ELSE}
  if (AQuantity > -1) and (AQuantity < 1) then
    result := FloatToStr(AQuantity) + ' ' + GetName(U.FPrefixes)
  else
    result := FloatToStr(AQuantity) + ' ' + GetPluralName(U.FPrefixes);
{$ENDIF}
end;

function TSymbol.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
{$ENDIF}
  FactoredValue := GetValue(AQuantity, APrefixes);

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(U.FPRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(U.FPRefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(APRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TSymbol.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
{$ENDIF}
  FactoredValue := GetValue(AQuantity, APrefixes);

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.FPRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(U.FPRefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(APRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TSymbol.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(U.FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

{ TFactoredSymbol }

class operator TFactoredSymbol.*(const AValue: double; const ASelf: TFactoredSymbol): TQuantity; inline;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[cScalar, U.FUnitOfMeasurement];
{$ENDIF}
  result.FValue := U.PutValue(AValue);
end;

class operator TFactoredSymbol./(const AValue: double; const ASelf: TFactoredSymbol): TQuantity; inline;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
{$ENDIF}
  result.FValue := U.PutValue(AValue);
end;

{$IFOPT D+}
class operator TFactoredSymbol.*(const AQuantity: TQuantity; const ASelf: TFactoredSymbol): TQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := U.PutValue(AQuantity.FValue);
end;

class operator TFactoredSymbol./(const AQuantity: TQuantity; const ASelf: TFactoredSymbol): TQuantity; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := U.PutValue(AQuantity.FValue);
end;
{$ENDIF}

function TFactoredSymbol.GetName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := U.FName;
    1:  result := Format(U.FName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(U.FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(U.FName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TFactoredSymbol.GetPluralName(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := U.FPluralName;
    1:  result := Format(U.FPluralName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(U.FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(U.FPluralName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

function TFactoredSymbol.GetSymbol(const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := U.FSymbol;
    1:  result := Format(U.FSymbol, [
          PrefixTable[Prefixes[0]].Symbol]);
    2:  result := Format(U.FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol]);
    3:  result := Format(U.FSymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol,
          PrefixTable[Prefixes[2]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function TFactoredSymbol.GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
var
  I: longint;
  Exponent: longint;
  PrefixCount: longint;
begin
  PrefixCount := Length(APrefixes);
  if PrefixCount = Length(U.FPrefixes) then
  begin
    Exponent := 0;
    for I := 0 to PrefixCount -1 do
      Inc(Exponent, PrefixTable[U.FPREFIXES[I]].Exponent * U.FEXPONENTS[I]);

    for I := 0 to PrefixCount -1 do
      Dec(Exponent, PrefixTable[APrefixes[I]].Exponent * U.FEXPONENTS[I]);

    if Exponent <> 0 then
      {$IFOPT D+} result := AQuantity.FValue * IntPower(10, Exponent) {$ELSE} result := AQuantity * IntPower(10, Exponent) {$ENDIF}
    else
      {$IFOPT D+} result := AQuantity.FValue; {$ELSE} result :=AQuantity; {$ENDIF}

  end else
    if PrefixCount = 0 then
      {$IFOPT D+} result := AQuantity.FValue {$ELSE} result := AQuantity {$ENDIF}
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

function TFactoredSymbol.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := U.GetValue(AQuantity.FValue);
{$ELSE}
  result := U.GetValue(AQuantity);
{$ENDIF}
end;

function TFactoredSymbol.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := U.GetValue(GetValue(AQuantity.FValue, APrefixes));
{$ELSE}
  result := U.GetValue(GetValue(AQuantity, APrefixes));
{$ENDIF}
end;

function TFactoredSymbol.ToString(const AQuantity: TQuantity): string;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');

  result := FloatToStr(U.GetValue(AQuantity.FValue)) + ' ' + GetSymbol(U.FPrefixes);
{$ELSE}
  result := FloatToStr(U.GetValue(AQuantity)) + ' ' + GetSymbol(U.FPrefixes);
{$ENDIF}
end;

function TFactoredSymbol.ToString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
{$ENDIF}
  FactoredValue := U.GetValue(GetValue(AQuantity.FValue, APrefixes));

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(U.FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredSymbol.ToString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
{$ENDIF}
  FactoredValue := U.GetValue(GetValue(AQuantity.FValue, APrefixes));

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(U.FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredSymbol.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
  FactoredValue := U.GetValue(GetValue(AQuantity.FValue, APrefixes));
  FactoredTol   := U.GetValue(GetValue(ATolerance.FValue, APrefixes));

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(U.FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
  end;
end;

function TFactoredSymbol.ToVerboseString(const AQuantity: TQuantity): string;
var
  FactoredValue: double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');

  FactoredValue := U.GetValue(AQuantity.FValue);
  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(U.FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(U.FPrefixes);
{$ELSE}
  FactoredValue := U.GetValue(AQuantity);
  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(U.FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(U.FPrefixes);
{$ENDIF}
end;

function TFactoredSymbol.ToVerboseString(const AQuantity: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
{$ENDIF}
  FactoredValue := U.GetValue(GetValue(AQuantity.FValue, APrefixes));

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(U.FPRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(U.FPRefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStr(FactoredValue) + ' ' + GetName(APRefixes)
    else
      result := FloatToStr(FactoredValue) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TFactoredSymbol.ToVerboseString(const AQuantity: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
{$ENDIF}
  FactoredValue := U.GetValue(GetValue(AQuantity.FValue, APrefixes));

  if Length(APrefixes) = 0 then
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.FPRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(U.FPRefixes);
  end else
  begin
    if (FactoredValue > -1) and (FactoredValue < 1) then
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(APRefixes)
    else
      result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APRefixes);
  end;
end;

function TFactoredSymbol.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
{$ENDIF}
  FactoredValue := U.GetValue(GetValue(AQuantity.FValue, APrefixes));
  FactoredTol   := U.GetValue(GetValue(ATolerance.FValue, APrefixes));

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(U.FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetPluralName(APrefixes);
  end;
end;

class  function TDegreeRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (Pi/180);
end;

class  function TDegreeRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (Pi/180);
end;

class  function TSquareDegreeRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (Pi*Pi/32400);
end;

class  function TSquareDegreeRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (Pi*Pi/32400);
end;

class  function TDayRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (86400);
end;

class  function TDayRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (86400);
end;

class  function THourRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (3600);
end;

class  function THourRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (3600);
end;

class  function TMinuteRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (60);
end;

class  function TMinuteRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (60);
end;

class  function TSquareDayRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (7464960000);
end;

class  function TSquareDayRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (7464960000);
end;

class  function TSquareHourRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (12960000);
end;

class  function TSquareHourRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (12960000);
end;

class  function TSquareMinuteRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (3600);
end;

class  function TSquareMinuteRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (3600);
end;

class  function TAstronomicalRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (149597870691);
end;

class  function TAstronomicalRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (149597870691);
end;

class  function TInchRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (0.0254);
end;

class  function TInchRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (0.0254);
end;

class  function TFootRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (0.3048);
end;

class  function TFootRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (0.3048);
end;

class  function TYardRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (0.9144);
end;

class  function TYardRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (0.9144);
end;

class  function TMileRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (1609.344);
end;

class  function TMileRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (1609.344);
end;

class  function TNauticalMileRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (1852);
end;

class  function TNauticalMileRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (1852);
end;

class  function TAngstromRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (1E-10);
end;

class  function TAngstromRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (1E-10);
end;

class  function TSquareInchRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (0.00064516);
end;

class  function TSquareInchRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (0.00064516);
end;

class  function TSquareFootRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (0.09290304);
end;

class  function TSquareFootRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (0.09290304);
end;

class  function TSquareYardRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (0.83612736);
end;

class  function TSquareYardRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (0.83612736);
end;

class  function TSquareMileRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (2589988.110336);
end;

class  function TSquareMileRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (2589988.110336);
end;

class  function TCubicInchRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (0.000016387064);
end;

class  function TCubicInchRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (0.000016387064);
end;

class  function TCubicFootRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (0.028316846592);
end;

class  function TCubicFootRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (0.028316846592);
end;

class  function TCubicYardRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (0.764554857984);
end;

class  function TCubicYardRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (0.764554857984);
end;

class  function TLitreRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (1E-03);
end;

class  function TLitreRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (1E-03);
end;

class  function TGallonRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (0.0037854119678);
end;

class  function TGallonRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (0.0037854119678);
end;

class  function TTonneRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (1E+03);
end;

class  function TTonneRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (1E+03);
end;

class  function TPoundRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (0.45359237);
end;

class  function TPoundRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (0.45359237);
end;

class  function TOunceRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (0.028349523125);
end;

class  function TOunceRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (0.028349523125);
end;

class  function TStoneRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (6.35029318);
end;

class  function TStoneRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (6.35029318);
end;

class  function TTonRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (907.18474);
end;

class  function TTonRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (907.18474);
end;

class  function TElectronvoltPerSquareSpeedOfLightRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (1.7826619216279E-36);
end;

class  function TElectronvoltPerSquareSpeedOfLightRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (1.7826619216279E-36);
end;

class function TDegreeCelsiusRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity + 273.15;
end;

class function TDegreeCelsiusRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity - 273.15;
end;

class function TDegreeFahrenheitRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := 5/9 * (AQuantity - 32) + 273.15;
end;

class function TDegreeFahrenheitRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := 9/5 * AQuantity - 459.67;
end;

class  function TMeterPerHourRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (1/3600);
end;

class  function TMeterPerHourRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (1/3600);
end;

class  function TMilePerHourRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (0.44704);
end;

class  function TMilePerHourRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (0.44704);
end;

class  function TNauticalMilePerHourRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (463/900);
end;

class  function TNauticalMilePerHourRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (463/900);
end;

class  function TMeterPerHourPerSecondRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (1/3600);
end;

class  function TMeterPerHourPerSecondRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (1/3600);
end;

class  function TPoundPerCubicInchRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (27679.9047102031);
end;

class  function TPoundPerCubicInchRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (27679.9047102031);
end;

class  function TPoundForceRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (4.4482216152605);
end;

class  function TPoundForceRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (4.4482216152605);
end;

class  function TBarRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (1E+05);
end;

class  function TBarRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (1E+05);
end;

class  function TPoundPerSquareInchRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (6894.75729316836);
end;

class  function TPoundPerSquareInchRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (6894.75729316836);
end;

class  function TWattHourRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (3600);
end;

class  function TWattHourRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (3600);
end;

class  function TElectronvoltRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (1.602176634E-019);
end;

class  function TElectronvoltRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (1.602176634E-019);
end;

class  function TPoundForceInchRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (0.112984829027617);
end;

class  function TPoundForceInchRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (0.112984829027617);
end;

class  function TRydbergRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (2.1798723611035E-18);
end;

class  function TRydbergRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (2.1798723611035E-18);
end;

class  function TCalorieRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (4.184);
end;

class  function TCalorieRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (4.184);
end;

class  function TJoulePerDegreeRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (180/Pi);
end;

class  function TJoulePerDegreeRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (180/Pi);
end;

class  function TNewtonMeterPerDegreeRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (180/Pi);
end;

class  function TNewtonMeterPerDegreeRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (180/Pi);
end;

class  function TAmpereHourRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (3600);
end;

class  function TAmpereHourRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (3600);
end;

class  function TPoundForcePerInchRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (175.126835246476);
end;

class  function TPoundForcePerInchRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (175.126835246476);
end;

class  function TElectronvoltSecondRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (1.60217742320523E-019);
end;

class  function TElectronvoltSecondRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (1.60217742320523E-019);
end;

class  function TElectronvoltMeterPerSpeedOfLightRec.PutValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity * (1.7826619216279E-36);
end;

class  function TElectronvoltMeterPerSpeedOfLightRec.GetValue(const AQuantity: double): double;
begin
{$IFOPT D+}
{$ENDIF}
  result := AQuantity / (1.7826619216279E-36);
end;

{ Power functions }

function SquarePower(const AQuantity: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Square;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AQuantity.FValue, 2);
{$ELSE}
  result := IntPower(AQuantity, 2);
{$ENDIF}
end;

function CubicPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Cubic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AQuantity.FValue, 3);
{$ELSE}
  result := IntPower(AQuantity, 3);
{$ENDIF}
end;

function QuarticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Quartic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AQuantity.FValue, 4);
{$ELSE}
  result := IntPower(AQuantity, 4);
{$ENDIF}
end;

function QuinticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Quintic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AQuantity.FValue, 5);
{$ELSE}
  result := IntPower(AQuantity, 5);
{$ENDIF}
end;

function SexticPower(const AQuantity: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Sextic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
   result.FValue := IntPower(AQuantity.FValue, 6);
{$ELSE}
  result := IntPower(AQuantity, 6);
{$ENDIF}
end;

function SquareRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Square;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/2);
{$ELSE};
  result := Power(AQuantity, 1/2);
{$ENDIF}
end;

function CubicRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Cubic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/3);
{$ELSE}
  result := Power(AQuantity, 1/3);
{$ENDIF}
end;

function QuarticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Quartic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/4);
{$ELSE}
  result := Power(AQuantity, 1/4);
{$ENDIF}
end;

function QuinticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Quintic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/5);
{$ELSE}
  result := Power(AQuantity, 1/5);
{$ENDIF}
end;

function SexticRoot(const AQuantity: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Sextic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/6);
{$ELSE}
  result := Power(AQuantity, 1/6);
{$ENDIF}
end;

{ Trigonometric functions }

function Cos(const AQuantity: TQuantity): double;
begin
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Wrong units of measurements');
  result := System.Cos(AQuantity.FValue);
end;

function Sin(const AQuantity: TQuantity): double;
begin
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Wrong units of measurements');
  result := System.Sin(AQuantity.FValue);
end;

function Tan(const AQuantity: TQuantity): double;
begin
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Wrong units of measurements');
  result := Math.Tan(AQuantity.FValue);
end;

function Cotan(const AQuantity: TQuantity): double;
begin
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Wrong units of measurements');
  result := Math.Cotan(AQuantity.FValue);
end;

function Secant(const AQuantity: TQuantity): double;
begin
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Wrong units of measurements');
  result := Math.Secant(AQuantity.FValue);
end;

function Cosecant(const AQuantity: TQuantity): double;
begin
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Wrong units of measurements');
  result := Math.Cosecant(AQuantity.FValue);
end;

function ArcCos(const AValue: double): TQuantity;
begin
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcCos(AValue);
end;

function ArcSin(const AValue: double): TQuantity;
begin
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcSin(AValue);
end;

function ArcTan(const AValue: double): TQuantity;
begin
  result.FUnitOfMeasurement := cScalar;
  result.FValue := System.ArcTan(AValue);
end;

function ArcTan2(const x, y: double): TQuantity;
begin
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcTan2(x, y);
end;

{ Override trigonometric functions }

{$IFOPT D+}
function Cos(const AValue: double): double;
begin
  result := System.Cos(AValue);
end;

function Sin(const AValue: double): double;
begin
  result := System.Sin(AValue);
end;

function Tan(const AValue: double): double;
begin
  result := Math.Tan(AValue);
end;

function Cotan(const AValue: double): double;
begin
  result := Math.Cotan(AValue);
end;

function Secant(const AValue: double): double;
begin
  result := Math.Secant(AValue);
end;

function Cosecant(const AValue: double): double;
begin
  result := Math.Cosecant(AValue);
end;
{$ENDIF}

{ Math functions }

function Min(const ALeft, ARight: TQuantity): TQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result.FUnitOfMeasurement := ARight.FUnitOfMeasurement;
  result.FValue := Math.Min(ALeft.FValue, ARight.FValue);
end;

function Max(const ALeft, ARight: TQuantity): TQuantity;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result.FUnitOfMeasurement := ARight.FUnitOfMeasurement;
  result.FValue := Math.Max(ALeft.FValue, ARight.FValue);
end;

function Exp(const AQuantity: TQuantity): TQuantity;
begin
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Wrong units of measurements');
  result.FUnitOfMeasurement := cScalar;
  result.FValue := System.Exp(AQuantity.FValue);
end;

function Log10(const AQuantity : TQuantity) : double;
begin
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Wrong units of measurements');
  result := Math.Log10(AQuantity.FValue);
end;

function Log2(const AQuantity : TQuantity) : double;
begin
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Wrong units of measurements');
  result := Math.Log2(AQuantity.FValue);
end;

function LogN(ABase: longint; const AQuantity: TQuantity): double;
begin
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Wrong units of measurements');
  result := Math.LogN(ABase, AQuantity.FValue);
end;

function LogN(const ABase, AQuantity: TQuantity): double;
begin
  if ABase.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Wrong units of measurements');

  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Wrong units of measurements');

  result := Math.LogN(ABase.FValue, AQuantity.FValue);
end;

function Power(const ABase: TQuantity; AExponent: double): double;
begin
  if ABase.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Wrong units of measurements');

   result := Math.Power(ABase.FValue, AExponent);
end;

{ Helper functions }

function LessThanOrEqualToZero(const AQuantity: TQuantity): boolean;
begin
  result := AQuantity.FValue <= 0;
end;

function LessThanZero(const AQuantity: TQuantity): boolean;
begin
  result := AQuantity.FValue < 0;
end;

function EqualToZero(const AQuantity: TQuantity): boolean;
begin
  result := AQuantity.FValue = 0;
end;

function NotEqualToZero(const AQuantity: TQuantity): boolean;
begin
  result := AQuantity.FValue <> 0;
end;

function GreaterThanOrEqualToZero(const AQuantity: TQuantity): boolean;
begin
  result := AQuantity.FValue >= 0;
end;

function GreaterThanZero(const AQuantity: TQuantity): boolean;
begin
  result := AQuantity.FValue > 0;
end;

function SameValue(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := Math.SameValue(ALeft.FValue, ARight.FValue);
end;

end.

{ Helpers }

{ Power functions }

end.
