{
  Description: ADim Run-time library.

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

unit ADim;

{$H+}{$J-}
{$modeswitch typehelpers}
{$modeswitch advancedrecords}
{$WARN 5024 OFF} // Suppress warning for unused routine parameter.
{$WARN 5033 OFF} // Suppress warning for unassigned function's return value.
{$IFOPT D+}
  {$DEFINE USEADIM}
{$ENDIF}

{
  ADim Run-time library built on 28/12/2024.

  Number of base units: 158
  Number of factored units: 122
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

  { TAScalar }

  {$IFDEF USEADIM}
  TAScalar = record
  private
    FUnitOfMeasurement: longint;
    FValue: double;
  public
    class operator + (const ASelf: TAScalar): TAScalar;
    class operator - (const ASelf: TAScalar): TAScalar;
    class operator + (const ALeft, ARight: TAScalar): TAScalar;
    class operator - (const ALeft, ARight: TAScalar): TAScalar;
    class operator * (const ALeft, ARight: TAScalar): TAScalar;
    class operator / (const ALeft, ARight: TAScalar): TAScalar;
    class operator * (const ALeft: double; const ARight: TAScalar): TAScalar;
    class operator / (const ALeft: double; const ARight: TAScalar): TAScalar;
    class operator * (const ALeft: TAScalar; const ARight: double): TAScalar;
    class operator / (const ALeft: TAScalar; const ARight: double): TAScalar;

    class operator = (const ALeft, ARight: TAScalar): boolean;
    class operator < (const ALeft, ARight: TAScalar): boolean;
    class operator > (const ALeft, ARight: TAScalar): boolean;
    class operator <=(const ALeft, ARight: TAScalar): boolean;
    class operator >=(const ALeft, ARight: TAScalar): boolean;
    class operator <>(const ALeft, ARight: TAScalar): boolean;
    class operator :=(const ASelf: double): TAScalar;
  end;
  {$ELSE}
  TAScalar = double;
  {$ENDIF}

  { TUnit }

  generic TUnit<U> = record
    type TSelf = specialize TUnit<U>;
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
  public
    procedure Check(var AQuantity: TAScalar);
    function ToFloat(const AQuantity: TAScalar): double;
    function ToFloat(const AQuantity: TAScalar; const APrefixes: TPrefixes): double;
    function ToString(const AQuantity: TAScalar): string;
    function ToString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TAScalar): string;
    function ToVerboseString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    class operator *(const AQuantity: double; const ASelf: TSelf): TAScalar; inline;
    class operator /(const AQuantity: double; const ASelf: TSelf): TAScalar; inline;
  {$IFDEF USEADIM}
    class operator *(const AQuantity: TAScalar; const ASelf: TSelf): TAScalar; inline;
    class operator /(const AQuantity: TAScalar; const ASelf: TSelf): TAScalar; inline;
  {$ENDIF}
  end;

  { TFactoredUnit }

  generic TFactoredUnit<U> = record
    type TSelf = specialize TFactoredUnit<U>;
  public
    function GetName(const Prefixes: TPrefixes): string;
    function GetPluralName(const Prefixes: TPrefixes): string;
    function GetSymbol(const Prefixes: TPrefixes): string;
    function GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
  public
    procedure Check(var AQuantity: TAScalar);
    function ToFloat(const AQuantity: TAScalar): double;
    function ToFloat(const AQuantity: TAScalar; const APrefixes: TPrefixes): double;
    function ToString(const AQuantity: TAScalar): string;
    function ToString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TAScalar): string;
    function ToVerboseString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    function ToVerboseString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
    class operator *(const AQuantity: double; const ASelf: TSelf): TAScalar; inline;
    class operator /(const AQuantity: double; const ASelf: TSelf): TAScalar; inline;
  {$IFDEF USEADIM}
    class operator *(const AQuantity: TAScalar; const ASelf: TSelf): TAScalar; inline;
    class operator /(const AQuantity: TAScalar; const ASelf: TSelf): TAScalar; inline;
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
  TScalarUnit = specialize TUnit<TScalarRec>;

var
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
  TRadianUnit = specialize TUnit<TRadianRec>;

var
  rad, RadianUnit : TRadianUnit;

{ TDegree }

type
  TDegreeRec = record
    const FUnitOfMeasurement = cScalar;
    const FSymbol            = 'deg';
    const FName              = 'degree';
    const FPluralName        = 'degrees';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TDegreeUnit = specialize TFactoredUnit<TDegreeRec>;

const
  deg        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 0; FValue: Pi/180); {$ELSE} (Pi/180); {$ENDIF}

var
  DegreeUnit : TDegreeUnit;

{ TSteradian }

const
  cSteradian = 1;

type
  TSteradianRec = record
    const FUnitOfMeasurement = cSteradian;
    const FSymbol            = 'sr';
    const FName              = 'steradian';
    const FPluralName        = 'steradians';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
  end;
  TSteradianUnit = specialize TUnit<TSteradianRec>;

var
  sr, SteradianUnit : TSteradianUnit;

{ TSquareDegree }

type
  TSquareDegreeRec = record
    const FUnitOfMeasurement = cSteradian;
    const FSymbol            = 'deg2';
    const FName              = 'square degree';
    const FPluralName        = 'square degrees';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TSquareDegreeUnit = specialize TFactoredUnit<TSquareDegreeRec>;

const
  deg2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 1; FValue: Pi*Pi/32400); {$ELSE} (Pi*Pi/32400); {$ENDIF}

var
  SquareDegreeUnit : TSquareDegreeUnit;

{ TSecond }

const
  cSecond = 2;

type
  TSecondRec = record
    const FUnitOfMeasurement = cSecond;
    const FSymbol            = '%ss';
    const FName              = '%ssecond';
    const FPluralName        = '%sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TSecondUnit = specialize TUnit<TSecondRec>;

var
  s, SecondUnit : TSecondUnit;

const
  ds         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 2; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cs         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 2; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  ms         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 2; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  mis        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 2; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  ns         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 2; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  ps         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 2; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TDay }

type
  TDayRec = record
    const FUnitOfMeasurement = cSecond;
    const FSymbol            = 'd';
    const FName              = 'day';
    const FPluralName        = 'days';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TDayUnit = specialize TFactoredUnit<TDayRec>;

const
  day        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 2; FValue: 86400); {$ELSE} (86400); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  THourUnit = specialize TFactoredUnit<THourRec>;

const
  hr         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 2; FValue: 3600); {$ELSE} (3600); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TMinuteUnit = specialize TFactoredUnit<TMinuteRec>;

const
  minute     : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 2; FValue: 60); {$ELSE} (60); {$ENDIF}

var
  MinuteUnit : TMinuteUnit;

{ TSquareSecond }

const
  cSquareSecond = 3;

type
  TSquareSecondRec = record
    const FUnitOfMeasurement = cSquareSecond;
    const FSymbol            = '%ss2';
    const FName              = 'square %ssecond';
    const FPluralName        = 'square %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareSecondUnit = specialize TUnit<TSquareSecondRec>;

var
  s2, SquareSecondUnit : TSquareSecondUnit;

const
  ds2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 3; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cs2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 3; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  ms2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 3; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mis2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 3; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  ns2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 3; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ps2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 3; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareDay }

type
  TSquareDayRec = record
    const FUnitOfMeasurement = cSquareSecond;
    const FSymbol            = 'd2';
    const FName              = 'square day';
    const FPluralName        = 'square days';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TSquareDayUnit = specialize TFactoredUnit<TSquareDayRec>;

const
  day2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 3; FValue: 7464960000); {$ELSE} (7464960000); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TSquareHourUnit = specialize TFactoredUnit<TSquareHourRec>;

const
  hr2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 3; FValue: 12960000); {$ELSE} (12960000); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TSquareMinuteUnit = specialize TFactoredUnit<TSquareMinuteRec>;

const
  minute2    : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 3; FValue: 3600); {$ELSE} (3600); {$ENDIF}

var
  SquareMinuteUnit : TSquareMinuteUnit;

{ TCubicSecond }

const
  cCubicSecond = 4;

type
  TCubicSecondRec = record
    const FUnitOfMeasurement = cCubicSecond;
    const FSymbol            = '%ss3';
    const FName              = 'cubic %ssecond';
    const FPluralName        = 'cubic %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (3);
  end;
  TCubicSecondUnit = specialize TUnit<TCubicSecondRec>;

var
  s3, CubicSecondUnit : TCubicSecondUnit;

const
  ds3        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 4; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  cs3        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 4; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  ms3        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 4; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  mis3       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 4; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ns3        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 4; FValue: 1E-27); {$ELSE} (1E-27); {$ENDIF}
  ps3        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 4; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}

{ TQuarticSecond }

const
  cQuarticSecond = 5;

type
  TQuarticSecondRec = record
    const FUnitOfMeasurement = cQuarticSecond;
    const FSymbol            = '%ss4';
    const FName              = 'quartic %ssecond';
    const FPluralName        = 'quartic %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (4);
  end;
  TQuarticSecondUnit = specialize TUnit<TQuarticSecondRec>;

var
  s4, QuarticSecondUnit : TQuarticSecondUnit;

const
  ds4        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 5; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cs4        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 5; FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  ms4        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 5; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mis4       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 5; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  ns4        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 5; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  ps4        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 5; FValue: 1E-48); {$ELSE} (1E-48); {$ENDIF}

{ TQuinticSecond }

const
  cQuinticSecond = 6;

type
  TQuinticSecondRec = record
    const FUnitOfMeasurement = cQuinticSecond;
    const FSymbol            = '%ss5';
    const FName              = 'quintic %ssecond';
    const FPluralName        = 'quintic %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (5);
  end;
  TQuinticSecondUnit = specialize TUnit<TQuinticSecondRec>;

var
  s5, QuinticSecondUnit : TQuinticSecondUnit;

const
  ds5        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 6; FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  cs5        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 6; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  ms5        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 6; FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}
  mis5       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 6; FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}
  ns5        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 6; FValue: 1E-45); {$ELSE} (1E-45); {$ENDIF}
  ps5        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 6; FValue: 1E-60); {$ELSE} (1E-60); {$ENDIF}

{ TSexticSecond }

const
  cSexticSecond = 7;

type
  TSexticSecondRec = record
    const FUnitOfMeasurement = cSexticSecond;
    const FSymbol            = '%ss6';
    const FName              = 'sextic %ssecond';
    const FPluralName        = 'sextic %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (6);
  end;
  TSexticSecondUnit = specialize TUnit<TSexticSecondRec>;

var
  s6, SexticSecondUnit : TSexticSecondUnit;

const
  ds6        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 7; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  cs6        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 7; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  ms6        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 7; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  mis6       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 7; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  ns6        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 7; FValue: 1E-54); {$ELSE} (1E-54); {$ENDIF}
  ps6        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 7; FValue: 1E-72); {$ELSE} (1E-72); {$ENDIF}

{ TMeter }

const
  cMeter = 8;

type
  TMeterRec = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = '%sm';
    const FName              = '%smeter';
    const FPluralName        = '%smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TMeterUnit = specialize TUnit<TMeterRec>;

var
  m, MeterUnit : TMeterUnit;

const
  km         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 8; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  dm         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 8; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cm         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 8; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mm         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 8; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  mim        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 8; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nm         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 8; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pm         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 8; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TAstronomical }

type
  TAstronomicalRec = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = 'au';
    const FName              = 'astronomical unit';
    const FPluralName        = 'astronomical units';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TAstronomicalUnit = specialize TFactoredUnit<TAstronomicalRec>;

const
  au         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 8; FValue: 149597870691); {$ELSE} (149597870691); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TInchUnit = specialize TFactoredUnit<TInchRec>;

const
  inch       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 8; FValue: 0.0254); {$ELSE} (0.0254); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TFootUnit = specialize TFactoredUnit<TFootRec>;

const
  ft         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 8; FValue: 0.3048); {$ELSE} (0.3048); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TYardUnit = specialize TFactoredUnit<TYardRec>;

const
  yd         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 8; FValue: 0.9144); {$ELSE} (0.9144); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TMileUnit = specialize TFactoredUnit<TMileRec>;

const
  mi         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 8; FValue: 1609.344); {$ELSE} (1609.344); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TNauticalMileUnit = specialize TFactoredUnit<TNauticalMileRec>;

const
  nmi        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 8; FValue: 1852); {$ELSE} (1852); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TAngstromUnit = specialize TFactoredUnit<TAngstromRec>;

const
  angstrom   : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 8; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}

var
  AngstromUnit : TAngstromUnit;

{ TSquareRootMeter }

const
  cSquareRootMeter = 9;

type
  TSquareRootMeterRec = record
    const FUnitOfMeasurement = cSquareRootMeter;
    const FSymbol            = '√%sm';
    const FName              = 'square root %smeter';
    const FPluralName        = 'square root %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TSquareRootMeterUnit = specialize TUnit<TSquareRootMeterRec>;

var
  SquareRootMeterUnit : TSquareRootMeterUnit;

{ TSquareMeter }

const
  cSquareMeter = 10;

type
  TSquareMeterRec = record
    const FUnitOfMeasurement = cSquareMeter;
    const FSymbol            = '%sm2';
    const FName              = 'square %smeter';
    const FPluralName        = 'square %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareMeterUnit = specialize TUnit<TSquareMeterRec>;

var
  m2, SquareMeterUnit : TSquareMeterUnit;

const
  km2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 10; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  dm2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 10; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cm2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 10; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mm2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 10; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mim2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 10; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nm2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 10; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  pm2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 10; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareInch }

type
  TSquareInchRec = record
    const FUnitOfMeasurement = cSquareMeter;
    const FSymbol            = 'in2';
    const FName              = 'square inch';
    const FPluralName        = 'square inches';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TSquareInchUnit = specialize TFactoredUnit<TSquareInchRec>;

const
  inch2      : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 10; FValue: 0.00064516); {$ELSE} (0.00064516); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TSquareFootUnit = specialize TFactoredUnit<TSquareFootRec>;

const
  ft2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 10; FValue: 0.09290304); {$ELSE} (0.09290304); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TSquareYardUnit = specialize TFactoredUnit<TSquareYardRec>;

const
  yd2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 10; FValue: 0.83612736); {$ELSE} (0.83612736); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TSquareMileUnit = specialize TFactoredUnit<TSquareMileRec>;

const
  mi2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 10; FValue: 2589988.110336); {$ELSE} (2589988.110336); {$ENDIF}

var
  SquareMileUnit : TSquareMileUnit;

{ TCubicMeter }

const
  cCubicMeter = 11;

type
  TCubicMeterRec = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = '%sm3';
    const FName              = 'cubic %smeter';
    const FPluralName        = 'cubic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (3);
  end;
  TCubicMeterUnit = specialize TUnit<TCubicMeterRec>;

var
  m3, CubicMeterUnit : TCubicMeterUnit;

const
  km3        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  dm3        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  cm3        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mm3        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  mim3       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  nm3        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 1E-27); {$ELSE} (1E-27); {$ENDIF}
  pm3        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}

{ TCubicInch }

type
  TCubicInchRec = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = 'in3';
    const FName              = 'cubic inch';
    const FPluralName        = 'cubic inches';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TCubicInchUnit = specialize TFactoredUnit<TCubicInchRec>;

const
  inch3      : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 0.000016387064); {$ELSE} (0.000016387064); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TCubicFootUnit = specialize TFactoredUnit<TCubicFootRec>;

const
  ft3        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 0.028316846592); {$ELSE} (0.028316846592); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TCubicYardUnit = specialize TFactoredUnit<TCubicYardRec>;

const
  yd3        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 0.764554857984); {$ELSE} (0.764554857984); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TLitreUnit = specialize TFactoredUnit<TLitreRec>;

const
  L          : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

var
  LitreUnit : TLitreUnit;

const
  dL         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 1E-03 * 1E-01); {$ELSE} (1E-03 * 1E-01); {$ENDIF}
  cL         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 1E-03 * 1E-02); {$ELSE} (1E-03 * 1E-02); {$ENDIF}
  mL         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 1E-03 * 1E-03); {$ELSE} (1E-03 * 1E-03); {$ENDIF}

{ TGallon }

type
  TGallonRec = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = 'gal';
    const FName              = 'gallon';
    const FPluralName        = 'gallons';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TGallonUnit = specialize TFactoredUnit<TGallonRec>;

const
  gal        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 11; FValue: 0.0037854119678); {$ELSE} (0.0037854119678); {$ENDIF}

var
  GallonUnit : TGallonUnit;

{ TQuarticMeter }

const
  cQuarticMeter = 12;

type
  TQuarticMeterRec = record
    const FUnitOfMeasurement = cQuarticMeter;
    const FSymbol            = '%sm4';
    const FName              = 'quartic %smeter';
    const FPluralName        = 'quartic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (4);
  end;
  TQuarticMeterUnit = specialize TUnit<TQuarticMeterRec>;

var
  m4, QuarticMeterUnit : TQuarticMeterUnit;

const
  km4        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 12; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  dm4        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 12; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cm4        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 12; FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  mm4        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 12; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mim4       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 12; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  nm4        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 12; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  pm4        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 12; FValue: 1E-48); {$ELSE} (1E-48); {$ENDIF}

{ TQuinticMeter }

const
  cQuinticMeter = 13;

type
  TQuinticMeterRec = record
    const FUnitOfMeasurement = cQuinticMeter;
    const FSymbol            = '%sm5';
    const FName              = 'quintic %smeter';
    const FPluralName        = 'quintic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (5);
  end;
  TQuinticMeterUnit = specialize TUnit<TQuinticMeterRec>;

var
  m5, QuinticMeterUnit : TQuinticMeterUnit;

const
  km5        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 13; FValue: 1E+15); {$ELSE} (1E+15); {$ENDIF}
  dm5        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 13; FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  cm5        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 13; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  mm5        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 13; FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}
  mim5       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 13; FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}
  nm5        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 13; FValue: 1E-45); {$ELSE} (1E-45); {$ENDIF}
  pm5        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 13; FValue: 1E-60); {$ELSE} (1E-60); {$ENDIF}

{ TSexticMeter }

const
  cSexticMeter = 14;

type
  TSexticMeterRec = record
    const FUnitOfMeasurement = cSexticMeter;
    const FSymbol            = '%sm6';
    const FName              = 'sextic %smeter';
    const FPluralName        = 'sextic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (6);
  end;
  TSexticMeterUnit = specialize TUnit<TSexticMeterRec>;

var
  m6, SexticMeterUnit : TSexticMeterUnit;

const
  km6        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 14; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  dm6        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 14; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  cm6        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 14; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mm6        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 14; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  mim6       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 14; FValue: 1E-36); {$ELSE} (1E-36); {$ENDIF}
  nm6        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 14; FValue: 1E-54); {$ELSE} (1E-54); {$ENDIF}
  pm6        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 14; FValue: 1E-72); {$ELSE} (1E-72); {$ENDIF}

{ TKilogram }

const
  cKilogram = 15;

type
  TKilogramRec = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = '%sg';
    const FName              = '%sgram';
    const FPluralName        = '%sgrams';
    const FPrefixes          : TPrefixes  = (pKilo);
    const FExponents         : TExponents = (1);
  end;
  TKilogramUnit = specialize TUnit<TKilogramRec>;

var
  kg, KilogramUnit : TKilogramUnit;

const
  hg         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  dag        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  g          : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  dg         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  cg         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 1E-05); {$ELSE} (1E-05); {$ENDIF}
  mg         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mig        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  ng         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  pg         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 1E-15); {$ELSE} (1E-15); {$ENDIF}

{ TTonne }

type
  TTonneRec = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = '%st';
    const FName              = '%stonne';
    const FPluralName        = '%stonnes';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TTonneUnit = specialize TFactoredUnit<TTonneRec>;

const
  tonne      : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

var
  TonneUnit : TTonneUnit;

const
  gigatonne  : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 1E+03 * 1E+09); {$ELSE} (1E+03 * 1E+09); {$ENDIF}
  megatonne  : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 1E+03 * 1E+06); {$ELSE} (1E+03 * 1E+06); {$ENDIF}
  kilotonne  : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 1E+03 * 1E+03); {$ELSE} (1E+03 * 1E+03); {$ENDIF}

{ TPound }

type
  TPoundRec = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = 'lb';
    const FName              = 'pound';
    const FPluralName        = 'pounds';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TPoundUnit = specialize TFactoredUnit<TPoundRec>;

const
  lb         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 0.45359237); {$ELSE} (0.45359237); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TOunceUnit = specialize TFactoredUnit<TOunceRec>;

const
  oz         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 0.028349523125); {$ELSE} (0.028349523125); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TStoneUnit = specialize TFactoredUnit<TStoneRec>;

const
  st         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 6.35029318); {$ELSE} (6.35029318); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TTonUnit = specialize TFactoredUnit<TTonRec>;

const
  ton        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 15; FValue: 907.18474); {$ELSE} (907.18474); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TElectronvoltPerSquareSpeedOfLightUnit = specialize TFactoredUnit<TElectronvoltPerSquareSpeedOfLightRec>;

var
  ElectronvoltPerSquareSpeedOfLightUnit : TElectronvoltPerSquareSpeedOfLightUnit;

{ TSquareKilogram }

const
  cSquareKilogram = 16;

type
  TSquareKilogramRec = record
    const FUnitOfMeasurement = cSquareKilogram;
    const FSymbol            = '%sg2';
    const FName              = 'square %sgram';
    const FPluralName        = 'square %sgrams';
    const FPrefixes          : TPrefixes  = (pKilo);
    const FExponents         : TExponents = (2);
  end;
  TSquareKilogramUnit = specialize TUnit<TSquareKilogramRec>;

var
  kg2, SquareKilogramUnit : TSquareKilogramUnit;

const
  hg2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 16; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  dag2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 16; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  g2         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 16; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  dg2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 16; FValue: 1E-08); {$ELSE} (1E-08); {$ENDIF}
  cg2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 16; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}
  mg2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 16; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  mig2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 16; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ng2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 16; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}
  pg2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 16; FValue: 1E-30); {$ELSE} (1E-30); {$ENDIF}

{ TAmpere }

const
  cAmpere = 17;

type
  TAmpereRec = record
    const FUnitOfMeasurement = cAmpere;
    const FSymbol            = '%sA';
    const FName              = '%sampere';
    const FPluralName        = '%samperes';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TAmpereUnit = specialize TUnit<TAmpereRec>;

var
  A, AmpereUnit : TAmpereUnit;

const
  kA         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 17; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hA         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 17; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daA        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 17; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}
  dA         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 17; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cA         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 17; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mA         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 17; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miA        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 17; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nA         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 17; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  picoA      : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 17; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TSquareAmpere }

const
  cSquareAmpere = 18;

type
  TSquareAmpereRec = record
    const FUnitOfMeasurement = cSquareAmpere;
    const FSymbol            = '%sA2';
    const FName              = 'square %sampere';
    const FPluralName        = 'square %samperes';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareAmpereUnit = specialize TUnit<TSquareAmpereRec>;

var
  A2, SquareAmpereUnit : TSquareAmpereUnit;

const
  kA2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 18; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hA2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 18; FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daA2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 18; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  dA2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 18; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cA2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 18; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mA2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 18; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  miA2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 18; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nA2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 18; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  picoA2     : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 18; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TKelvin }

const
  cKelvin = 19;

type
  TKelvinRec = record
    const FUnitOfMeasurement = cKelvin;
    const FSymbol            = '%sK';
    const FName              = '%skelvin';
    const FPluralName        = '%skelvins';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TKelvinUnit = specialize TUnit<TKelvinRec>;

var
  K, KelvinUnit : TKelvinUnit;

{ TDegreeCelsius }

type
  TDegreeCelsiusRec = record
    const FUnitOfMeasurement = cKelvin;
    const FSymbol            = 'ºC';
    const FName              = 'degree Celsius';
    const FPluralName        = 'degrees Celsius';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TDegreeCelsiusUnit = specialize TFactoredUnit<TDegreeCelsiusRec>;

var
  degC, DegreeCelsiusUnit : TDegreeCelsiusUnit;

{ TDegreeFahrenheit }

type
  TDegreeFahrenheitRec = record
    const FUnitOfMeasurement = cKelvin;
    const FSymbol            = 'ºF';
    const FName              = 'degree Fahrenheit';
    const FPluralName        = 'degrees Fahrenheit';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TDegreeFahrenheitUnit = specialize TFactoredUnit<TDegreeFahrenheitRec>;

var
  degF, DegreeFahrenheitUnit : TDegreeFahrenheitUnit;

{ TSquareKelvin }

const
  cSquareKelvin = 20;

type
  TSquareKelvinRec = record
    const FUnitOfMeasurement = cSquareKelvin;
    const FSymbol            = '%sK2';
    const FName              = 'square %skelvin';
    const FPluralName        = 'square %skelvins';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareKelvinUnit = specialize TUnit<TSquareKelvinRec>;

var
  K2, SquareKelvinUnit : TSquareKelvinUnit;

{ TCubicKelvin }

const
  cCubicKelvin = 21;

type
  TCubicKelvinRec = record
    const FUnitOfMeasurement = cCubicKelvin;
    const FSymbol            = '%sK3';
    const FName              = 'cubic %skelvin';
    const FPluralName        = 'cubic %skelvins';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (3);
  end;
  TCubicKelvinUnit = specialize TUnit<TCubicKelvinRec>;

var
  K3, CubicKelvinUnit : TCubicKelvinUnit;

{ TQuarticKelvin }

const
  cQuarticKelvin = 22;

type
  TQuarticKelvinRec = record
    const FUnitOfMeasurement = cQuarticKelvin;
    const FSymbol            = '%sK4';
    const FName              = 'quartic %skelvin';
    const FPluralName        = 'quartic %skelvins';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (4);
  end;
  TQuarticKelvinUnit = specialize TUnit<TQuarticKelvinRec>;

var
  K4, QuarticKelvinUnit : TQuarticKelvinUnit;

{ TMole }

const
  cMole = 23;

type
  TMoleRec = record
    const FUnitOfMeasurement = cMole;
    const FSymbol            = '%smol';
    const FName              = '%smole';
    const FPluralName        = '%smoles';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TMoleUnit = specialize TUnit<TMoleRec>;

var
  mol, MoleUnit : TMoleUnit;

const
  kmol       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 23; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hmol       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 23; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  damol      : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 23; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}

{ TCandela }

const
  cCandela = 24;

type
  TCandelaRec = record
    const FUnitOfMeasurement = cCandela;
    const FSymbol            = '%scd';
    const FName              = '%scandela';
    const FPluralName        = '%scandelas';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TCandelaUnit = specialize TUnit<TCandelaRec>;

var
  cd, CandelaUnit : TCandelaUnit;

{ THertz }

const
  cHertz = 25;

type
  THertzRec = record
    const FUnitOfMeasurement = cHertz;
    const FSymbol            = '%sHz';
    const FName              = '%shertz';
    const FPluralName        = '%shertz';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  THertzUnit = specialize TUnit<THertzRec>;

var
  Hz, HertzUnit : THertzUnit;

const
  THz        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 25; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GHz        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 25; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MHz        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 25; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kHz        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 25; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

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
  TReciprocalSecondUnit = specialize TUnit<TReciprocalSecondRec>;

var
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
  TRadianPerSecondUnit = specialize TUnit<TRadianPerSecondRec>;

var
  RadianPerSecondUnit : TRadianPerSecondUnit;

{ TSquareHertz }

const
  cSquareHertz = 26;

type
  TSquareHertzRec = record
    const FUnitOfMeasurement = cSquareHertz;
    const FSymbol            = '%sHz2';
    const FName              = 'square %shertz';
    const FPluralName        = 'square %shertz';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareHertzUnit = specialize TUnit<TSquareHertzRec>;

var
  Hz2, SquareHertzUnit : TSquareHertzUnit;

const
  THz2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 26; FValue: 1E+24); {$ELSE} (1E+24); {$ENDIF}
  GHz2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 26; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MHz2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 26; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kHz2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 26; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}

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
  TReciprocalSquareSecondUnit = specialize TUnit<TReciprocalSquareSecondRec>;

var
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
  TRadianPerSquareSecondUnit = specialize TUnit<TRadianPerSquareSecondRec>;

var
  RadianPerSquareSecondUnit : TRadianPerSquareSecondUnit;

{ TSteradianPerSquareSecond }

const
  cSteradianPerSquareSecond = 27;

type
  TSteradianPerSquareSecondRec = record
    const FUnitOfMeasurement = cSteradianPerSquareSecond;
    const FSymbol            = 'sr/%ss2';
    const FName              = 'steradian per square %ssecond';
    const FPluralName        = 'steradians per square %ssecond';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-2);
  end;
  TSteradianPerSquareSecondUnit = specialize TUnit<TSteradianPerSquareSecondRec>;

var
  SteradianPerSquareSecondUnit : TSteradianPerSquareSecondUnit;

{ TMeterPerSecond }

const
  cMeterPerSecond = 28;

type
  TMeterPerSecondRec = record
    const FUnitOfMeasurement = cMeterPerSecond;
    const FSymbol            = '%sm/%ss';
    const FName              = '%smeter per %ssecond';
    const FPluralName        = '%smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TMeterPerSecondUnit = specialize TUnit<TMeterPerSecondRec>;

var
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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TMeterPerHourUnit = specialize TFactoredUnit<TMeterPerHourRec>;

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TMilePerHourUnit = specialize TFactoredUnit<TMilePerHourRec>;

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TNauticalMilePerHourUnit = specialize TFactoredUnit<TNauticalMilePerHourRec>;

var
  NauticalMilePerHourUnit : TNauticalMilePerHourUnit;

{ TMeterPerSquareSecond }

const
  cMeterPerSquareSecond = 29;

type
  TMeterPerSquareSecondRec = record
    const FUnitOfMeasurement = cMeterPerSquareSecond;
    const FSymbol            = '%sm/%ss2';
    const FName              = '%smeter per %ssecond squared';
    const FPluralName        = '%smeters per %ssecond squared';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TMeterPerSquareSecondUnit = specialize TUnit<TMeterPerSquareSecondRec>;

var
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
  TMeterPerSecondPerSecondUnit = specialize TUnit<TMeterPerSecondPerSecondRec>;

var
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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TMeterPerHourPerSecondUnit = specialize TFactoredUnit<TMeterPerHourPerSecondRec>;

var
  MeterPerHourPerSecondUnit : TMeterPerHourPerSecondUnit;

{ TMeterPerCubicSecond }

const
  cMeterPerCubicSecond = 30;

type
  TMeterPerCubicSecondRec = record
    const FUnitOfMeasurement = cMeterPerCubicSecond;
    const FSymbol            = '%sm/%ss3';
    const FName              = '%smeter per cubic %ssecond';
    const FPluralName        = '%smeters per cubic %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TMeterPerCubicSecondUnit = specialize TUnit<TMeterPerCubicSecondRec>;

var
  MeterPerCubicSecondUnit : TMeterPerCubicSecondUnit;

{ TMeterPerQuarticSecond }

const
  cMeterPerQuarticSecond = 31;

type
  TMeterPerQuarticSecondRec = record
    const FUnitOfMeasurement = cMeterPerQuarticSecond;
    const FSymbol            = '%sm/%ss4';
    const FName              = '%smeter per quartic %ssecond';
    const FPluralName        = '%smeters per quartic %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -4);
  end;
  TMeterPerQuarticSecondUnit = specialize TUnit<TMeterPerQuarticSecondRec>;

var
  MeterPerQuarticSecondUnit : TMeterPerQuarticSecondUnit;

{ TMeterPerQuinticSecond }

const
  cMeterPerQuinticSecond = 32;

type
  TMeterPerQuinticSecondRec = record
    const FUnitOfMeasurement = cMeterPerQuinticSecond;
    const FSymbol            = '%sm/%ss5';
    const FName              = '%smeter per quintic %ssecond';
    const FPluralName        = '%smeters per quintic %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -5);
  end;
  TMeterPerQuinticSecondUnit = specialize TUnit<TMeterPerQuinticSecondRec>;

var
  MeterPerQuinticSecondUnit : TMeterPerQuinticSecondUnit;

{ TMeterPerSexticSecond }

const
  cMeterPerSexticSecond = 33;

type
  TMeterPerSexticSecondRec = record
    const FUnitOfMeasurement = cMeterPerSexticSecond;
    const FSymbol            = '%sm/%ss6';
    const FName              = '%smeter per sextic %ssecond';
    const FPluralName        = '%smeters per sextic %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -6);
  end;
  TMeterPerSexticSecondUnit = specialize TUnit<TMeterPerSexticSecondRec>;

var
  MeterPerSexticSecondUnit : TMeterPerSexticSecondUnit;

{ TSquareMeterPerSquareSecond }

const
  cSquareMeterPerSquareSecond = 34;

type
  TSquareMeterPerSquareSecondRec = record
    const FUnitOfMeasurement = cSquareMeterPerSquareSecond;
    const FSymbol            = '%sm2/%ss2';
    const FName              = 'square %smeter per square %ssecond';
    const FPluralName        = 'square %smeters per square %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareMeterPerSquareSecondUnit = specialize TUnit<TSquareMeterPerSquareSecondRec>;

var
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
  TJoulePerKilogramUnit = specialize TUnit<TJoulePerKilogramRec>;

var
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
  TGrayUnit = specialize TUnit<TGrayRec>;

var
  Gy, GrayUnit : TGrayUnit;

const
  kGy        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 34; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mGy        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 34; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miGy       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 34; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nGy        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 34; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

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
  TSievertUnit = specialize TUnit<TSievertRec>;

var
  Sv, SievertUnit : TSievertUnit;

const
  kSv        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 34; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mSv        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 34; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miSv       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 34; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nSv        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 34; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TMeterSecond }

const
  cMeterSecond = 35;

type
  TMeterSecondRec = record
    const FUnitOfMeasurement = cMeterSecond;
    const FSymbol            = '%sm.%ss';
    const FName              = '%smeter %ssecond';
    const FPluralName        = '%smeter %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TMeterSecondUnit = specialize TUnit<TMeterSecondRec>;

var
  MeterSecondUnit : TMeterSecondUnit;

{ TKilogramMeter }

const
  cKilogramMeter = 36;

type
  TKilogramMeterRec = record
    const FUnitOfMeasurement = cKilogramMeter;
    const FSymbol            = '%sg.%sm';
    const FName              = '%sgram %smeter';
    const FPluralName        = '%sgram %smeters';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TKilogramMeterUnit = specialize TUnit<TKilogramMeterRec>;

var
  KilogramMeterUnit : TKilogramMeterUnit;

{ TKilogramPerSecond }

const
  cKilogramPerSecond = 37;

type
  TKilogramPerSecondRec = record
    const FUnitOfMeasurement = cKilogramPerSecond;
    const FSymbol            = '%sg/%ss';
    const FName              = '%sgram per %ssecond';
    const FPluralName        = '%sgrams per %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TKilogramPerSecondUnit = specialize TUnit<TKilogramPerSecondRec>;

var
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
  TJoulePerSquareMeterPerHertzUnit = specialize TUnit<TJoulePerSquareMeterPerHertzRec>;

var
  JoulePerSquareMeterPerHertzUnit : TJoulePerSquareMeterPerHertzUnit;

{ TKilogramMeterPerSecond }

const
  cKilogramMeterPerSecond = 38;

type
  TKilogramMeterPerSecondRec = record
    const FUnitOfMeasurement = cKilogramMeterPerSecond;
    const FSymbol            = '%sg.%sm/%ss';
    const FName              = '%sgram %smeter per %ssecond';
    const FPluralName        = '%sgram %smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -1);
  end;
  TKilogramMeterPerSecondUnit = specialize TUnit<TKilogramMeterPerSecondRec>;

var
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
  TNewtonSecondUnit = specialize TUnit<TNewtonSecondRec>;

var
  NewtonSecondUnit : TNewtonSecondUnit;

{ TSquareKilogramSquareMeterPerSquareSecond }

const
  cSquareKilogramSquareMeterPerSquareSecond = 39;

type
  TSquareKilogramSquareMeterPerSquareSecondRec = record
    const FUnitOfMeasurement = cSquareKilogramSquareMeterPerSquareSecond;
    const FSymbol            = '%sg2.%sm2/%ss2';
    const FName              = 'square%sgram square%smeter per square%ssecond';
    const FPluralName        = 'square%sgram square%smeters per square%ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (2, 2, -2);
  end;
  TSquareKilogramSquareMeterPerSquareSecondUnit = specialize TUnit<TSquareKilogramSquareMeterPerSquareSecondRec>;

var
  SquareKilogramSquareMeterPerSquareSecondUnit : TSquareKilogramSquareMeterPerSquareSecondUnit;

{ TReciprocalSquareRootMeter }

const
  cReciprocalSquareRootMeter = 40;

type
  TReciprocalSquareRootMeterRec = record
    const FUnitOfMeasurement = cReciprocalSquareRootMeter;
    const FSymbol            = '1/√%sm';
    const FName              = 'reciprocal square root %smeter';
    const FPluralName        = 'reciprocal square root %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalSquareRootMeterUnit = specialize TUnit<TReciprocalSquareRootMeterRec>;

var
  ReciprocalSquareRootMeterUnit : TReciprocalSquareRootMeterUnit;

{ TReciprocalMeter }

const
  cReciprocalMeter = 41;

type
  TReciprocalMeterRec = record
    const FUnitOfMeasurement = cReciprocalMeter;
    const FSymbol            = '1/%sm';
    const FName              = 'reciprocal %smeter';
    const FPluralName        = 'reciprocal %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalMeterUnit = specialize TUnit<TReciprocalMeterRec>;

var
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
  TDioptreUnit = specialize TUnit<TDioptreRec>;

var
  DioptreUnit : TDioptreUnit;

{ TReciprocalSquareRootCubicMeter }

const
  cReciprocalSquareRootCubicMeter = 42;

type
  TReciprocalSquareRootCubicMeterRec = record
    const FUnitOfMeasurement = cReciprocalSquareRootCubicMeter;
    const FSymbol            = '1/√%sm3';
    const FName              = 'reciprocal square root cubic %smeter';
    const FPluralName        = 'reciprocal square root cubic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-3);
  end;
  TReciprocalSquareRootCubicMeterUnit = specialize TUnit<TReciprocalSquareRootCubicMeterRec>;

var
  ReciprocalSquareRootCubicMeterUnit : TReciprocalSquareRootCubicMeterUnit;

{ TReciprocalSquareMeter }

const
  cReciprocalSquareMeter = 43;

type
  TReciprocalSquareMeterRec = record
    const FUnitOfMeasurement = cReciprocalSquareMeter;
    const FSymbol            = '1/%sm2';
    const FName              = 'reciprocal square %smeter';
    const FPluralName        = 'reciprocal square %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-2);
  end;
  TReciprocalSquareMeterUnit = specialize TUnit<TReciprocalSquareMeterRec>;

var
  ReciprocalSquareMeterUnit : TReciprocalSquareMeterUnit;

{ TReciprocalCubicMeter }

const
  cReciprocalCubicMeter = 44;

type
  TReciprocalCubicMeterRec = record
    const FUnitOfMeasurement = cReciprocalCubicMeter;
    const FSymbol            = '1/%sm3';
    const FName              = 'reciprocal cubic %smeter';
    const FPluralName        = 'reciprocal cubic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-3);
  end;
  TReciprocalCubicMeterUnit = specialize TUnit<TReciprocalCubicMeterRec>;

var
  ReciprocalCubicMeterUnit : TReciprocalCubicMeterUnit;

{ TReciprocalQuarticMeter }

const
  cReciprocalQuarticMeter = 45;

type
  TReciprocalQuarticMeterRec = record
    const FUnitOfMeasurement = cReciprocalQuarticMeter;
    const FSymbol            = '1/%sm4';
    const FName              = 'reciprocal quartic %smeter';
    const FPluralName        = 'reciprocal quartic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-4);
  end;
  TReciprocalQuarticMeterUnit = specialize TUnit<TReciprocalQuarticMeterRec>;

var
  ReciprocalQuarticMeterUnit : TReciprocalQuarticMeterUnit;

{ TKilogramSquareMeter }

const
  cKilogramSquareMeter = 46;

type
  TKilogramSquareMeterRec = record
    const FUnitOfMeasurement = cKilogramSquareMeter;
    const FSymbol            = '%sg.%sm2';
    const FName              = '%sgram square %smeter';
    const FPluralName        = '%sgram square %smeters';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, 2);
  end;
  TKilogramSquareMeterUnit = specialize TUnit<TKilogramSquareMeterRec>;

var
  KilogramSquareMeterUnit : TKilogramSquareMeterUnit;

{ TKilogramSquareMeterPerSecond }

const
  cKilogramSquareMeterPerSecond = 47;

type
  TKilogramSquareMeterPerSecondRec = record
    const FUnitOfMeasurement = cKilogramSquareMeterPerSecond;
    const FSymbol            = '%sg.%sm2/%ss';
    const FName              = '%sgram square %smeter per %ssecond';
    const FPluralName        = '%sgram square %smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -1);
  end;
  TKilogramSquareMeterPerSecondUnit = specialize TUnit<TKilogramSquareMeterPerSecondRec>;

var
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
  TNewtonMeterSecondUnit = specialize TUnit<TNewtonMeterSecondRec>;

var
  NewtonMeterSecondUnit : TNewtonMeterSecondUnit;

{ TSecondPerMeter }

const
  cSecondPerMeter = 48;

type
  TSecondPerMeterRec = record
    const FUnitOfMeasurement = cSecondPerMeter;
    const FSymbol            = '%ss/%sm';
    const FName              = '%ssecond per %smeter';
    const FPluralName        = '%sseconds per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TSecondPerMeterUnit = specialize TUnit<TSecondPerMeterRec>;

var
  SecondPerMeterUnit : TSecondPerMeterUnit;

{ TKilogramPerMeter }

const
  cKilogramPerMeter = 49;

type
  TKilogramPerMeterRec = record
    const FUnitOfMeasurement = cKilogramPerMeter;
    const FSymbol            = '%sg/%sm';
    const FName              = '%sgram per %smeter';
    const FPluralName        = '%sgrams per %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TKilogramPerMeterUnit = specialize TUnit<TKilogramPerMeterRec>;

var
  KilogramPerMeterUnit : TKilogramPerMeterUnit;

{ TKilogramPerSquareMeter }

const
  cKilogramPerSquareMeter = 50;

type
  TKilogramPerSquareMeterRec = record
    const FUnitOfMeasurement = cKilogramPerSquareMeter;
    const FSymbol            = '%sg/%sm2';
    const FName              = '%sgram per square %smeter';
    const FPluralName        = '%sgrams per square %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TKilogramPerSquareMeterUnit = specialize TUnit<TKilogramPerSquareMeterRec>;

var
  KilogramPerSquareMeterUnit : TKilogramPerSquareMeterUnit;

{ TKilogramPerCubicMeter }

const
  cKilogramPerCubicMeter = 51;

type
  TKilogramPerCubicMeterRec = record
    const FUnitOfMeasurement = cKilogramPerCubicMeter;
    const FSymbol            = '%sg/%sm3';
    const FName              = '%sgram per cubic %smeter';
    const FPluralName        = '%sgrams per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TKilogramPerCubicMeterUnit = specialize TUnit<TKilogramPerCubicMeterRec>;

var
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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TPoundPerCubicInchUnit = specialize TFactoredUnit<TPoundPerCubicInchRec>;

var
  PoundPerCubicInchUnit : TPoundPerCubicInchUnit;

{ TNewton }

const
  cNewton = 52;

type
  TNewtonRec = record
    const FUnitOfMeasurement = cNewton;
    const FSymbol            = '%sN';
    const FName              = '%snewton';
    const FPluralName        = '%snewtons';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TNewtonUnit = specialize TUnit<TNewtonRec>;

var
  N, NewtonUnit : TNewtonUnit;

const
  GN         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 52; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MN         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 52; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kN         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 52; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hN         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 52; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daN        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 52; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}

{ TPoundForce }

type
  TPoundForceRec = record
    const FUnitOfMeasurement = cNewton;
    const FSymbol            = 'lbf';
    const FName              = 'pound-force';
    const FPluralName        = 'pounds-force';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TPoundForceUnit = specialize TFactoredUnit<TPoundForceRec>;

const
  lbf        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 52; FValue: 4.4482216152605); {$ELSE} (4.4482216152605); {$ENDIF}

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
  TKilogramMeterPerSquareSecondUnit = specialize TUnit<TKilogramMeterPerSquareSecondRec>;

var
  KilogramMeterPerSquareSecondUnit : TKilogramMeterPerSquareSecondUnit;

{ TNewtonRadian }

type
  TNewtonRadianRec = record
    const FUnitOfMeasurement = cNewton;
    const FSymbol            = '%sN.%srad';
    const FName              = '%snewton %sradian';
    const FPluralName        = '%snewton %sradians';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TNewtonRadianUnit = specialize TUnit<TNewtonRadianRec>;

var
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
  TSquareNewtonUnit = specialize TUnit<TSquareNewtonRec>;

var
  N2, SquareNewtonUnit : TSquareNewtonUnit;

const
  GN2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 53; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MN2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 53; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kN2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 53; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hN2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 53; FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daN2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 53; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}

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
  TSquareKilogramSquareMeterPerQuarticSecondUnit = specialize TUnit<TSquareKilogramSquareMeterPerQuarticSecondRec>;

var
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
  TPascalUnit = specialize TUnit<TPascalRec>;

var
  Pa, PascalUnit : TPascalUnit;

const
  TPa        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 54; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GPa        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 54; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MPa        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 54; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kPa        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 54; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

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
  TNewtonPerSquareMeterUnit = specialize TUnit<TNewtonPerSquareMeterRec>;

var
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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TBarUnit = specialize TFactoredUnit<TBarRec>;

const
  bar        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 54; FValue: 1E+05); {$ELSE} (1E+05); {$ENDIF}

var
  BarUnit : TBarUnit;

const
  kbar       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 54; FValue: 1E+05 * 1E+03); {$ELSE} (1E+05 * 1E+03); {$ENDIF}
  mbar       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 54; FValue: 1E+05 * 1E-03); {$ELSE} (1E+05 * 1E-03); {$ENDIF}

{ TPoundPerSquareInch }

type
  TPoundPerSquareInchRec = record
    const FUnitOfMeasurement = cPascal;
    const FSymbol            = '%spsi';
    const FName              = '%spound per square inch';
    const FPluralName        = '%spounds per square inch';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TPoundPerSquareInchUnit = specialize TFactoredUnit<TPoundPerSquareInchRec>;

const
  psi        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 54; FValue: 6894.75729316836); {$ELSE} (6894.75729316836); {$ENDIF}

var
  PoundPerSquareInchUnit : TPoundPerSquareInchUnit;

const
  kpsi       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 54; FValue: 6894.75729316836 * 1E+03); {$ELSE} (6894.75729316836 * 1E+03); {$ENDIF}

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
  TJoulePerCubicMeterUnit = specialize TUnit<TJoulePerCubicMeterRec>;

var
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
  TKilogramPerMeterPerSquareSecondUnit = specialize TUnit<TKilogramPerMeterPerSquareSecondRec>;

var
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
  TJouleUnit = specialize TUnit<TJouleRec>;

var
  J, JouleUnit : TJouleUnit;

const
  TJ         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 55; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GJ         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 55; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MJ         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 55; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kJ         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 55; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TWattHour }

type
  TWattHourRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sW.h';
    const FName              = '%swatt hour';
    const FPluralName        = '%swatt hours';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TWattHourUnit = specialize TFactoredUnit<TWattHourRec>;

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
  TWattSecondUnit = specialize TUnit<TWattSecondRec>;

var
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
  TWattPerHertzUnit = specialize TUnit<TWattPerHertzRec>;

var
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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TElectronvoltUnit = specialize TFactoredUnit<TElectronvoltRec>;

const
  eV         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019); {$ELSE} (1.602176634E-019); {$ENDIF}

var
  ElectronvoltUnit : TElectronvoltUnit;

const
  TeV        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+12); {$ELSE} (1.602176634E-019 * 1E+12); {$ENDIF}
  GeV        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+09); {$ELSE} (1.602176634E-019 * 1E+09); {$ENDIF}
  MeV        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+06); {$ELSE} (1.602176634E-019 * 1E+06); {$ENDIF}
  keV        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+03); {$ELSE} (1.602176634E-019 * 1E+03); {$ENDIF}

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
  TNewtonMeterUnit = specialize TUnit<TNewtonMeterRec>;

var
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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TPoundForceInchUnit = specialize TFactoredUnit<TPoundForceInchRec>;

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TRydbergUnit = specialize TFactoredUnit<TRydbergRec>;

const
  Ry         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 55; FValue: 2.1798723611035E-18); {$ELSE} (2.1798723611035E-18); {$ENDIF}

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TCalorieUnit = specialize TFactoredUnit<TCalorieRec>;

const
  cal        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 55; FValue: 4.184); {$ELSE} (4.184); {$ENDIF}

var
  CalorieUnit : TCalorieUnit;

const
  Mcal       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 55; FValue: 4.184 * 1E+06); {$ELSE} (4.184 * 1E+06); {$ENDIF}
  kcal       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 55; FValue: 4.184 * 1E+03); {$ELSE} (4.184 * 1E+03); {$ENDIF}

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
  TKilogramSquareMeterPerSquareSecondUnit = specialize TUnit<TKilogramSquareMeterPerSquareSecondRec>;

var
  KilogramSquareMeterPerSquareSecondUnit : TKilogramSquareMeterPerSquareSecondUnit;

{ TJoulePerRadian }

type
  TJoulePerRadianRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sJ/rad';
    const FName              = '%sjoule per radian';
    const FPluralName        = '%sjoules per radian';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TJoulePerRadianUnit = specialize TUnit<TJoulePerRadianRec>;

var
  JoulePerRadianUnit : TJoulePerRadianUnit;

{ TJoulePerDegree }

type
  TJoulePerDegreeRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sJ/deg';
    const FName              = '%sjoule per degree';
    const FPluralName        = '%sjoules per degree';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TJoulePerDegreeUnit = specialize TFactoredUnit<TJoulePerDegreeRec>;

var
  JoulePerDegreeUnit : TJoulePerDegreeUnit;

{ TNewtonMeterPerRadian }

type
  TNewtonMeterPerRadianRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sN.%sm/rad';
    const FName              = '%snewton %smeter per radian';
    const FPluralName        = '%snewton %smeters per radian';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TNewtonMeterPerRadianUnit = specialize TUnit<TNewtonMeterPerRadianRec>;

var
  NewtonMeterPerRadianUnit : TNewtonMeterPerRadianUnit;

{ TNewtonMeterPerDegree }

type
  TNewtonMeterPerDegreeRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sN.%sm/deg';
    const FName              = '%snewton %smeter per degree';
    const FPluralName        = '%snewton %smeters per degree';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TNewtonMeterPerDegreeUnit = specialize TFactoredUnit<TNewtonMeterPerDegreeRec>;

var
  NewtonMeterPerDegreeUnit : TNewtonMeterPerDegreeUnit;

{ TKilogramSquareMeterPerSquareSecondPerRadian }

type
  TKilogramSquareMeterPerSquareSecondPerRadianRec = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sg.%sm2/%ss2/rad';
    const FName              = '%sgram square %smeter per square %ssecond per radian';
    const FPluralName        = '%sgram square %smeters per square %ssecond per radian';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -2);
  end;
  TKilogramSquareMeterPerSquareSecondPerRadianUnit = specialize TUnit<TKilogramSquareMeterPerSquareSecondPerRadianRec>;

var
  KilogramSquareMeterPerSquareSecondPerRadianUnit : TKilogramSquareMeterPerSquareSecondPerRadianUnit;

{ TWatt }

const
  cWatt = 56;

type
  TWattRec = record
    const FUnitOfMeasurement = cWatt;
    const FSymbol            = '%sW';
    const FName              = '%swatt';
    const FPluralName        = '%swatts';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TWattUnit = specialize TUnit<TWattRec>;

var
  W, WattUnit : TWattUnit;

const
  TW         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 56; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GW         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 56; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MW         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 56; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kW         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 56; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  milliW     : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 56; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

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
  TKilogramSquareMeterPerCubicSecondUnit = specialize TUnit<TKilogramSquareMeterPerCubicSecondRec>;

var
  KilogramSquareMeterPerCubicSecondUnit : TKilogramSquareMeterPerCubicSecondUnit;

{ TCoulomb }

const
  cCoulomb = 57;

type
  TCoulombRec = record
    const FUnitOfMeasurement = cCoulomb;
    const FSymbol            = '%sC';
    const FName              = '%scoulomb';
    const FPluralName        = '%scoulombs';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TCoulombUnit = specialize TUnit<TCoulombRec>;

var
  C, CoulombUnit : TCoulombUnit;

const
  kC         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 57; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hC         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 57; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daC        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 57; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}
  dC         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 57; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cC         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 57; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mC         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 57; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miC        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 57; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nC         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 57; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pC         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 57; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TAmpereHour }

type
  TAmpereHourRec = record
    const FUnitOfMeasurement = cCoulomb;
    const FSymbol            = '%sA.h';
    const FName              = '%sampere hour';
    const FPluralName        = '%sampere hours';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TAmpereHourUnit = specialize TFactoredUnit<TAmpereHourRec>;

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
  TAmpereSecondUnit = specialize TUnit<TAmpereSecondRec>;

var
  AmpereSecondUnit : TAmpereSecondUnit;

{ TSquareCoulomb }

const
  cSquareCoulomb = 58;

type
  TSquareCoulombRec = record
    const FUnitOfMeasurement = cSquareCoulomb;
    const FSymbol            = '%sC2';
    const FName              = 'square %scoulomb';
    const FPluralName        = 'square %scoulombs';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareCoulombUnit = specialize TUnit<TSquareCoulombRec>;

var
  C2, SquareCoulombUnit : TSquareCoulombUnit;

const
  kC2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 58; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hC2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 58; FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daC2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 58; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  dC2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 58; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cC2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 58; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  mC2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 58; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  miC2       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 58; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  nC2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 58; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  pC2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 58; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

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
  TSquareAmpereSquareSecondUnit = specialize TUnit<TSquareAmpereSquareSecondRec>;

var
  SquareAmpereSquareSecondUnit : TSquareAmpereSquareSecondUnit;

{ TCoulombMeter }

const
  cCoulombMeter = 59;

type
  TCoulombMeterRec = record
    const FUnitOfMeasurement = cCoulombMeter;
    const FSymbol            = '%sC.%sm';
    const FName              = '%scoulomb %smeter';
    const FPluralName        = '%scoulomb %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TCoulombMeterUnit = specialize TUnit<TCoulombMeterRec>;

var
  CoulombMeterUnit : TCoulombMeterUnit;

{ TVolt }

const
  cVolt = 60;

type
  TVoltRec = record
    const FUnitOfMeasurement = cVolt;
    const FSymbol            = '%sV';
    const FName              = '%svolt';
    const FPluralName        = '%svolts';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TVoltUnit = specialize TUnit<TVoltRec>;

var
  V, VoltUnit : TVoltUnit;

const
  kV         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 60; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mV         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 60; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

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
  TJoulePerCoulombUnit = specialize TUnit<TJoulePerCoulombRec>;

var
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
  TKilogramSquareMeterPerAmperePerCubicSecondUnit = specialize TUnit<TKilogramSquareMeterPerAmperePerCubicSecondRec>;

var
  KilogramSquareMeterPerAmperePerCubicSecondUnit : TKilogramSquareMeterPerAmperePerCubicSecondUnit;

{ TSquareVolt }

const
  cSquareVolt = 61;

type
  TSquareVoltRec = record
    const FUnitOfMeasurement = cSquareVolt;
    const FSymbol            = '%sV2';
    const FName              = 'square %svolt';
    const FPluralName        = 'square %svolts';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareVoltUnit = specialize TUnit<TSquareVoltRec>;

var
  V2, SquareVoltUnit : TSquareVoltUnit;

const
  kV2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 61; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  mV2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 61; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}

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
  TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondUnit = specialize TUnit<TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondRec>;

var
  SquareKilogramQuarticMeterPerSquareAmperePerSexticSecondUnit : TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondUnit;

{ TFarad }

const
  cFarad = 62;

type
  TFaradRec = record
    const FUnitOfMeasurement = cFarad;
    const FSymbol            = '%sF';
    const FName              = '%sfarad';
    const FPluralName        = '%sfarads';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TFaradUnit = specialize TUnit<TFaradRec>;

var
  F, FaradUnit : TFaradUnit;

const
  mF         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 62; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miF        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 62; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nF         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 62; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pF         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 62; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

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
  TCoulombPerVoltUnit = specialize TUnit<TCoulombPerVoltRec>;

var
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
  TSquareAmpereQuarticSecondPerKilogramPerSquareMeterUnit = specialize TUnit<TSquareAmpereQuarticSecondPerKilogramPerSquareMeterRec>;

var
  SquareAmpereQuarticSecondPerKilogramPerSquareMeterUnit : TSquareAmpereQuarticSecondPerKilogramPerSquareMeterUnit;

{ TOhm }

const
  cOhm = 63;

type
  TOhmRec = record
    const FUnitOfMeasurement = cOhm;
    const FSymbol            = '%sΩ';
    const FName              = '%sohm';
    const FPluralName        = '%sohms';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TOhmUnit = specialize TUnit<TOhmRec>;

var
  ohm, OhmUnit : TOhmUnit;

const
  Gohm       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 63; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  megaohm    : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 63; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kohm       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 63; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mohm       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 63; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miohm      : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 63; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nohm       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 63; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

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
  TKilogramSquareMeterPerSquareAmperePerCubicSecondUnit = specialize TUnit<TKilogramSquareMeterPerSquareAmperePerCubicSecondRec>;

var
  KilogramSquareMeterPerSquareAmperePerCubicSecondUnit : TKilogramSquareMeterPerSquareAmperePerCubicSecondUnit;

{ TSiemens }

const
  cSiemens = 64;

type
  TSiemensRec = record
    const FUnitOfMeasurement = cSiemens;
    const FSymbol            = '%sS';
    const FName              = '%ssiemens';
    const FPluralName        = '%ssiemens';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TSiemensUnit = specialize TUnit<TSiemensRec>;

var
  siemens, SiemensUnit : TSiemensUnit;

const
  millisiemens : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 64; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  microsiemens : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 64; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
   nanosiemens : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 64; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

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
  TSquareAmpereCubicSecondPerKilogramPerSquareMeterUnit = specialize TUnit<TSquareAmpereCubicSecondPerKilogramPerSquareMeterRec>;

var
  SquareAmpereCubicSecondPerKilogramPerSquareMeterUnit : TSquareAmpereCubicSecondPerKilogramPerSquareMeterUnit;

{ TSiemensPerMeter }

const
  cSiemensPerMeter = 65;

type
  TSiemensPerMeterRec = record
    const FUnitOfMeasurement = cSiemensPerMeter;
    const FSymbol            = '%sS/%sm';
    const FName              = '%ssiemens per %smeter';
    const FPluralName        = '%ssiemens per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TSiemensPerMeterUnit = specialize TUnit<TSiemensPerMeterRec>;

var
  SiemensPerMeterUnit : TSiemensPerMeterUnit;

{ TTesla }

const
  cTesla = 66;

type
  TTeslaRec = record
    const FUnitOfMeasurement = cTesla;
    const FSymbol            = '%sT';
    const FName              = '%stesla';
    const FPluralName        = '%steslas';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TTeslaUnit = specialize TUnit<TTeslaRec>;

var
  T, TeslaUnit : TTeslaUnit;

const
  mT         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 66; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miT        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 66; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nT         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 66; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

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
  TWeberPerSquareMeterUnit = specialize TUnit<TWeberPerSquareMeterRec>;

var
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
  TKilogramPerAmperePerSquareSecondUnit = specialize TUnit<TKilogramPerAmperePerSquareSecondRec>;

var
  KilogramPerAmperePerSquareSecondUnit : TKilogramPerAmperePerSquareSecondUnit;

{ TWeber }

const
  cWeber = 67;

type
  TWeberRec = record
    const FUnitOfMeasurement = cWeber;
    const FSymbol            = '%sWb';
    const FName              = '%sweber';
    const FPluralName        = '%swebers';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TWeberUnit = specialize TUnit<TWeberRec>;

var
  Wb, WeberUnit : TWeberUnit;

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
  TKilogramSquareMeterPerAmperePerSquareSecondUnit = specialize TUnit<TKilogramSquareMeterPerAmperePerSquareSecondRec>;

var
  KilogramSquareMeterPerAmperePerSquareSecondUnit : TKilogramSquareMeterPerAmperePerSquareSecondUnit;

{ THenry }

const
  cHenry = 68;

type
  THenryRec = record
    const FUnitOfMeasurement = cHenry;
    const FSymbol            = '%sH';
    const FName              = '%shenry';
    const FPluralName        = '%shenries';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  THenryUnit = specialize TUnit<THenryRec>;

var
  H, HenryUnit : THenryUnit;

const
  mH         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 68; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miH        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 68; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nH         : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 68; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

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
  TKilogramSquareMeterPerSquareAmperePerSquareSecondUnit = specialize TUnit<TKilogramSquareMeterPerSquareAmperePerSquareSecondRec>;

var
  KilogramSquareMeterPerSquareAmperePerSquareSecondUnit : TKilogramSquareMeterPerSquareAmperePerSquareSecondUnit;

{ TReciprocalHenry }

const
  cReciprocalHenry = 69;

type
  TReciprocalHenryRec = record
    const FUnitOfMeasurement = cReciprocalHenry;
    const FSymbol            = '1/%sH';
    const FName              = 'reciprocal %shenry';
    const FPluralName        = 'reciprocal %shenries';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalHenryUnit = specialize TUnit<TReciprocalHenryRec>;

var
  ReciprocalHenryUnit : TReciprocalHenryUnit;

{ TLumen }

const
  cLumen = 70;

type
  TLumenRec = record
    const FUnitOfMeasurement = cLumen;
    const FSymbol            = '%slm';
    const FName              = '%slumen';
    const FPluralName        = '%slumens';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TLumenUnit = specialize TUnit<TLumenRec>;

var
  lm, LumenUnit : TLumenUnit;

{ TCandelaSteradian }

type
  TCandelaSteradianRec = record
    const FUnitOfMeasurement = cLumen;
    const FSymbol            = '%scd.%ssr';
    const FName              = '%scandela %ssteradian';
    const FPluralName        = '%scandela %ssteradians';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TCandelaSteradianUnit = specialize TUnit<TCandelaSteradianRec>;

var
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
  TLumenSecondUnit = specialize TUnit<TLumenSecondRec>;

var
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
  TLumenSecondPerCubicMeterUnit = specialize TUnit<TLumenSecondPerCubicMeterRec>;

var
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
  TLuxUnit = specialize TUnit<TLuxRec>;

var
  lx, LuxUnit : TLuxUnit;

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
  TCandelaSteradianPerSquareMeterUnit = specialize TUnit<TCandelaSteradianPerSquareMeterRec>;

var
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
  TLuxSecondUnit = specialize TUnit<TLuxSecondRec>;

var
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
  TBequerelUnit = specialize TUnit<TBequerelRec>;

var
  Bq, BequerelUnit : TBequerelUnit;

const
  kBq        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 25; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mBq        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 25; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miBq       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 25; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nBq        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 25; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pBq        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 25; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

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
  TKatalUnit = specialize TUnit<TKatalRec>;

var
  kat, KatalUnit : TKatalUnit;

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
  TMolePerSecondUnit = specialize TUnit<TMolePerSecondRec>;

var
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
  TNewtonPerCubicMeterUnit = specialize TUnit<TNewtonPerCubicMeterRec>;

var
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
  TPascalPerMeterUnit = specialize TUnit<TPascalPerMeterRec>;

var
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
  TKilogramPerSquareMeterPerSquareSecondUnit = specialize TUnit<TKilogramPerSquareMeterPerSquareSecondRec>;

var
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
  TNewtonPerMeterUnit = specialize TUnit<TNewtonPerMeterRec>;

var
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
  TJoulePerSquareMeterUnit = specialize TUnit<TJoulePerSquareMeterRec>;

var
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
  TWattPerSquareMeterPerHertzUnit = specialize TUnit<TWattPerSquareMeterPerHertzRec>;

var
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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TPoundForcePerInchUnit = specialize TFactoredUnit<TPoundForcePerInchRec>;

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
  TKilogramPerSquareSecondUnit = specialize TUnit<TKilogramPerSquareSecondRec>;

var
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
  TCubicMeterPerSecondUnit = specialize TUnit<TCubicMeterPerSecondRec>;

var
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
  TPoiseuilleUnit = specialize TUnit<TPoiseuilleRec>;

var
  Pl, PoiseuilleUnit : TPoiseuilleUnit;

const
  cPl        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 79; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mPl        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 79; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miPl       : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 79; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}

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
  TPascalSecondUnit = specialize TUnit<TPascalSecondRec>;

var
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
  TKilogramPerMeterPerSecondUnit = specialize TUnit<TKilogramPerMeterPerSecondRec>;

var
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
  TSquareMeterPerSecondUnit = specialize TUnit<TSquareMeterPerSecondRec>;

var
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
  TKilogramPerQuarticMeterUnit = specialize TUnit<TKilogramPerQuarticMeterRec>;

var
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
  TQuarticMeterSecondUnit = specialize TUnit<TQuarticMeterSecondRec>;

var
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
  TKilogramPerQuarticMeterPerSecondUnit = specialize TUnit<TKilogramPerQuarticMeterPerSecondRec>;

var
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
  TCubicMeterPerKilogramUnit = specialize TUnit<TCubicMeterPerKilogramRec>;

var
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
  TKilogramSquareSecondUnit = specialize TUnit<TKilogramSquareSecondRec>;

var
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
  TCubicMeterPerSquareSecondUnit = specialize TUnit<TCubicMeterPerSquareSecondRec>;

var
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
  TNewtonSquareMeterUnit = specialize TUnit<TNewtonSquareMeterRec>;

var
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
  TKilogramCubicMeterPerSquareSecondUnit = specialize TUnit<TKilogramCubicMeterPerSquareSecondRec>;

var
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
  TNewtonCubicMeterUnit = specialize TUnit<TNewtonCubicMeterRec>;

var
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
  TKilogramQuarticMeterPerSquareSecondUnit = specialize TUnit<TKilogramQuarticMeterPerSquareSecondRec>;

var
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
  TNewtonPerSquareKilogramUnit = specialize TUnit<TNewtonPerSquareKilogramRec>;

var
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
  TMeterPerKilogramPerSquareSecondUnit = specialize TUnit<TMeterPerKilogramPerSquareSecondRec>;

var
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
  TSquareKilogramPerMeterUnit = specialize TUnit<TSquareKilogramPerMeterRec>;

var
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
  TSquareKilogramPerSquareMeterUnit = specialize TUnit<TSquareKilogramPerSquareMeterRec>;

var
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
  TSquareMeterPerSquareKilogramUnit = specialize TUnit<TSquareMeterPerSquareKilogramRec>;

var
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
  TNewtonSquareMeterPerSquareKilogramUnit = specialize TUnit<TNewtonSquareMeterPerSquareKilogramRec>;

var
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
  TCubicMeterPerKilogramPerSquareSecondUnit = specialize TUnit<TCubicMeterPerKilogramPerSquareSecondRec>;

var
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
  TReciprocalKelvinUnit = specialize TUnit<TReciprocalKelvinRec>;

var
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
  TKilogramKelvinUnit = specialize TUnit<TKilogramKelvinRec>;

var
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
  TJoulePerKelvinUnit = specialize TUnit<TJoulePerKelvinRec>;

var
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
  TKilogramSquareMeterPerSquareSecondPerKelvinUnit = specialize TUnit<TKilogramSquareMeterPerSquareSecondPerKelvinRec>;

var
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
  TJoulePerKilogramPerKelvinUnit = specialize TUnit<TJoulePerKilogramPerKelvinRec>;

var
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
  TSquareMeterPerSquareSecondPerKelvinUnit = specialize TUnit<TSquareMeterPerSquareSecondPerKelvinRec>;

var
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
  TMeterKelvinUnit = specialize TUnit<TMeterKelvinRec>;

var
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
  TKelvinPerMeterUnit = specialize TUnit<TKelvinPerMeterRec>;

var
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
  TWattPerMeterUnit = specialize TUnit<TWattPerMeterRec>;

var
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
  TKilogramMeterPerCubicSecondUnit = specialize TUnit<TKilogramMeterPerCubicSecondRec>;

var
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
  TWattPerSquareMeterUnit = specialize TUnit<TWattPerSquareMeterRec>;

var
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
  TKilogramPerCubicSecondUnit = specialize TUnit<TKilogramPerCubicSecondRec>;

var
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
  TWattPerCubicMeterUnit = specialize TUnit<TWattPerCubicMeterRec>;

var
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
  TWattPerKelvinUnit = specialize TUnit<TWattPerKelvinRec>;

var
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
  TKilogramSquareMeterPerCubicSecondPerKelvinUnit = specialize TUnit<TKilogramSquareMeterPerCubicSecondPerKelvinRec>;

var
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
  TWattPerMeterPerKelvinUnit = specialize TUnit<TWattPerMeterPerKelvinRec>;

var
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
  TKilogramMeterPerCubicSecondPerKelvinUnit = specialize TUnit<TKilogramMeterPerCubicSecondPerKelvinRec>;

var
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
  TKelvinPerWattUnit = specialize TUnit<TKelvinPerWattRec>;

var
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
  TMeterPerWattUnit = specialize TUnit<TMeterPerWattRec>;

var
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
  TMeterKelvinPerWattUnit = specialize TUnit<TMeterKelvinPerWattRec>;

var
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
  TSquareMeterKelvinUnit = specialize TUnit<TSquareMeterKelvinRec>;

var
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
  TWattPerSquareMeterPerKelvinUnit = specialize TUnit<TWattPerSquareMeterPerKelvinRec>;

var
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
  TKilogramPerCubicSecondPerKelvinUnit = specialize TUnit<TKilogramPerCubicSecondPerKelvinRec>;

var
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
  TSquareMeterQuarticKelvinUnit = specialize TUnit<TSquareMeterQuarticKelvinRec>;

var
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
  TWattPerQuarticKelvinUnit = specialize TUnit<TWattPerQuarticKelvinRec>;

var
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
  TWattPerSquareMeterPerQuarticKelvinUnit = specialize TUnit<TWattPerSquareMeterPerQuarticKelvinRec>;

var
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
  TJoulePerMoleUnit = specialize TUnit<TJoulePerMoleRec>;

var
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
  TMoleKelvinUnit = specialize TUnit<TMoleKelvinRec>;

var
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
  TJoulePerMolePerKelvinUnit = specialize TUnit<TJoulePerMolePerKelvinRec>;

var
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
  TOhmMeterUnit = specialize TUnit<TOhmMeterRec>;

var
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
  TVoltPerMeterUnit = specialize TUnit<TVoltPerMeterRec>;

var
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
  TNewtonPerCoulombUnit = specialize TUnit<TNewtonPerCoulombRec>;

var
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
  TCoulombPerMeterUnit = specialize TUnit<TCoulombPerMeterRec>;

var
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
  TSquareCoulombPerMeterUnit = specialize TUnit<TSquareCoulombPerMeterRec>;

var
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
  TCoulombPerSquareMeterUnit = specialize TUnit<TCoulombPerSquareMeterRec>;

var
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
  TSquareMeterPerSquareCoulombUnit = specialize TUnit<TSquareMeterPerSquareCoulombRec>;

var
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
  TNewtonPerSquareCoulombUnit = specialize TUnit<TNewtonPerSquareCoulombRec>;

var
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
  TNewtonSquareMeterPerSquareCoulombUnit = specialize TUnit<TNewtonSquareMeterPerSquareCoulombRec>;

var
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
  TVoltMeterUnit = specialize TUnit<TVoltMeterRec>;

var
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
  TNewtonSquareMeterPerCoulombUnit = specialize TUnit<TNewtonSquareMeterPerCoulombRec>;

var
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
  TVoltMeterPerSecondUnit = specialize TUnit<TVoltMeterPerSecondRec>;

var
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
  TFaradPerMeterUnit = specialize TUnit<TFaradPerMeterRec>;

var
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
  TAmperePerMeterUnit = specialize TUnit<TAmperePerMeterRec>;

var
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
  TMeterPerAmpereUnit = specialize TUnit<TMeterPerAmpereRec>;

var
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
  TTeslaMeterUnit = specialize TUnit<TTeslaMeterRec>;

var
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
  TNewtonPerAmpereUnit = specialize TUnit<TNewtonPerAmpereRec>;

var
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
  TTeslaPerAmpereUnit = specialize TUnit<TTeslaPerAmpereRec>;

var
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
  THenryPerMeterUnit = specialize TUnit<THenryPerMeterRec>;

var
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
  TTeslaMeterPerAmpereUnit = specialize TUnit<TTeslaMeterPerAmpereRec>;

var
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
  TNewtonPerSquareAmpereUnit = specialize TUnit<TNewtonPerSquareAmpereRec>;

var
  NewtonPerSquareAmpereUnit : TNewtonPerSquareAmpereUnit;

{ TRadianPerMeter }

type
  TRadianPerMeterRec = record
    const FUnitOfMeasurement = cReciprocalMeter;
    const FSymbol            = 'rad/%sm';
    const FName              = 'radian per %smeter';
    const FPluralName        = 'radians per %smeter';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TRadianPerMeterUnit = specialize TUnit<TRadianPerMeterRec>;

var
  RadianPerMeterUnit : TRadianPerMeterUnit;

{ TSquareKilogramPerSquareSecond }

const
  cSquareKilogramPerSquareSecond = 132;

type
  TSquareKilogramPerSquareSecondRec = record
    const FUnitOfMeasurement = cSquareKilogramPerSquareSecond;
    const FSymbol            = '%sg2/%ss2';
    const FName              = 'square %sgram per square %ssecond';
    const FPluralName        = 'square %sgrams per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareKilogramPerSquareSecondUnit = specialize TUnit<TSquareKilogramPerSquareSecondRec>;

var
  SquareKilogramPerSquareSecondUnit : TSquareKilogramPerSquareSecondUnit;

{ TSquareSecondPerSquareMeter }

const
  cSquareSecondPerSquareMeter = 133;

type
  TSquareSecondPerSquareMeterRec = record
    const FUnitOfMeasurement = cSquareSecondPerSquareMeter;
    const FSymbol            = '%ss2/%sm2';
    const FName              = 'square %ssecond per square %smeter';
    const FPluralName        = 'square %sseconds per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareSecondPerSquareMeterUnit = specialize TUnit<TSquareSecondPerSquareMeterRec>;

var
  SquareSecondPerSquareMeterUnit : TSquareSecondPerSquareMeterUnit;

{ TSquareJoule }

const
  cSquareJoule = 134;

type
  TSquareJouleRec = record
    const FUnitOfMeasurement = cSquareJoule;
    const FSymbol            = '%sJ2';
    const FName              = 'square %sjoule';
    const FPluralName        = 'square %sjoules';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareJouleUnit = specialize TUnit<TSquareJouleRec>;

var
  J2, SquareJouleUnit : TSquareJouleUnit;

const
  TJ2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 134; FValue: 1E+24); {$ELSE} (1E+24); {$ENDIF}
  GJ2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 134; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MJ2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 134; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kJ2        : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: 134; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}

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
  TJouleSecondUnit = specialize TUnit<TJouleSecondRec>;

var
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
  TJoulePerHertzUnit = specialize TUnit<TJoulePerHertzRec>;

var
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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TElectronvoltSecondUnit = specialize TFactoredUnit<TElectronvoltSecondRec>;

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
    class function GetValue(const AValue: double): double; static;
    class function PutValue(const AValue: double): double; static;
  end;
  TElectronvoltMeterPerSpeedOfLightUnit = specialize TFactoredUnit<TElectronvoltMeterPerSpeedOfLightRec>;

var
  ElectronvoltMeterPerSpeedOfLightUnit : TElectronvoltMeterPerSpeedOfLightUnit;

{ TSquareJouleSquareSecond }

const
  cSquareJouleSquareSecond = 135;

type
  TSquareJouleSquareSecondRec = record
    const FUnitOfMeasurement = cSquareJouleSquareSecond;
    const FSymbol            = '%sJ2.%ss2';
    const FName              = 'square %sjoule square %ssecond';
    const FPluralName        = 'square %sjoule square %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 2);
  end;
  TSquareJouleSquareSecondUnit = specialize TUnit<TSquareJouleSquareSecondRec>;

var
  SquareJouleSquareSecondUnit : TSquareJouleSquareSecondUnit;

{ TCoulombPerKilogram }

const
  cCoulombPerKilogram = 136;

type
  TCoulombPerKilogramRec = record
    const FUnitOfMeasurement = cCoulombPerKilogram;
    const FSymbol            = '%sC/%sg';
    const FName              = '%scoulomb per %sgram';
    const FPluralName        = '%scoulombs per %sgram';
    const FPrefixes          : TPrefixes  = (pNone, pKilo);
    const FExponents         : TExponents = (1, -1);
  end;
  TCoulombPerKilogramUnit = specialize TUnit<TCoulombPerKilogramRec>;

var
  CoulombPerKilogramUnit : TCoulombPerKilogramUnit;

{ TSquareMeterAmpere }

const
  cSquareMeterAmpere = 137;

type
  TSquareMeterAmpereRec = record
    const FUnitOfMeasurement = cSquareMeterAmpere;
    const FSymbol            = '%sm2.%sA';
    const FName              = 'square %smeter %sampere';
    const FPluralName        = 'square %smeter %samperes';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 1);
  end;
  TSquareMeterAmpereUnit = specialize TUnit<TSquareMeterAmpereRec>;

var
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
  TJoulePerTeslaUnit = specialize TUnit<TJoulePerTeslaRec>;

var
  JoulePerTeslaUnit : TJoulePerTeslaUnit;

{ TLumenPerWatt }

const
  cLumenPerWatt = 138;

type
  TLumenPerWattRec = record
    const FUnitOfMeasurement = cLumenPerWatt;
    const FSymbol            = '%slm/%sW';
    const FName              = '%slumen per %swatt';
    const FPluralName        = '%slumens per %swatt';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TLumenPerWattUnit = specialize TUnit<TLumenPerWattRec>;

var
  LumenPerWattUnit : TLumenPerWattUnit;

{ TReciprocalMole }

const
  cReciprocalMole = 139;

type
  TReciprocalMoleRec = record
    const FUnitOfMeasurement = cReciprocalMole;
    const FSymbol            = '1/%smol';
    const FName              = 'reciprocal %smole';
    const FPluralName        = 'reciprocal %smoles';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalMoleUnit = specialize TUnit<TReciprocalMoleRec>;

var
  ReciprocalMoleUnit : TReciprocalMoleUnit;

{ TAmperePerSquareMeter }

const
  cAmperePerSquareMeter = 140;

type
  TAmperePerSquareMeterRec = record
    const FUnitOfMeasurement = cAmperePerSquareMeter;
    const FSymbol            = '%sA/%sm2';
    const FName              = '%sampere per square %smeter';
    const FPluralName        = '%samperes per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TAmperePerSquareMeterUnit = specialize TUnit<TAmperePerSquareMeterRec>;

var
  AmperePerSquareMeterUnit : TAmperePerSquareMeterUnit;

{ TMolePerCubicMeter }

const
  cMolePerCubicMeter = 141;

type
  TMolePerCubicMeterRec = record
    const FUnitOfMeasurement = cMolePerCubicMeter;
    const FSymbol            = '%smol/%sm3';
    const FName              = '%smole per cubic %smeter';
    const FPluralName        = '%smoles per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TMolePerCubicMeterUnit = specialize TUnit<TMolePerCubicMeterRec>;

var
  MolePerCubicMeterUnit : TMolePerCubicMeterUnit;

{ TCandelaPerSquareMeter }

const
  cCandelaPerSquareMeter = 142;

type
  TCandelaPerSquareMeterRec = record
    const FUnitOfMeasurement = cCandelaPerSquareMeter;
    const FSymbol            = '%scd/%sm2';
    const FName              = '%scandela per square %smeter';
    const FPluralName        = '%scandelas per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TCandelaPerSquareMeterUnit = specialize TUnit<TCandelaPerSquareMeterRec>;

var
  CandelaPerSquareMeterUnit : TCandelaPerSquareMeterUnit;

{ TCoulombPerCubicMeter }

const
  cCoulombPerCubicMeter = 143;

type
  TCoulombPerCubicMeterRec = record
    const FUnitOfMeasurement = cCoulombPerCubicMeter;
    const FSymbol            = '%sC/%sm3';
    const FName              = '%scoulomb per cubic %smeter';
    const FPluralName        = '%scoulombs per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TCoulombPerCubicMeterUnit = specialize TUnit<TCoulombPerCubicMeterRec>;

var
  CoulombPerCubicMeterUnit : TCoulombPerCubicMeterUnit;

{ TGrayPerSecond }

const
  cGrayPerSecond = 144;

type
  TGrayPerSecondRec = record
    const FUnitOfMeasurement = cGrayPerSecond;
    const FSymbol            = '%sGy/%ss';
    const FName              = '%sgray per %ssecond';
    const FPluralName        = '%sgrays per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TGrayPerSecondUnit = specialize TUnit<TGrayPerSecondRec>;

var
  GrayPerSecondUnit : TGrayPerSecondUnit;

{ TSteradianHertz }

const
  cSteradianHertz = 145;

type
  TSteradianHertzRec = record
    const FUnitOfMeasurement = cSteradianHertz;
    const FSymbol            = 'sr.%sHz';
    const FName              = 'steradian %shertz';
    const FPluralName        = 'steradian %shertz';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TSteradianHertzUnit = specialize TUnit<TSteradianHertzRec>;

var
  SteradianHertzUnit : TSteradianHertzUnit;

{ TMeterSteradian }

const
  cMeterSteradian = 146;

type
  TMeterSteradianRec = record
    const FUnitOfMeasurement = cMeterSteradian;
    const FSymbol            = '%sm.sr';
    const FName              = '%smeter steradian';
    const FPluralName        = '%smeter steradians';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TMeterSteradianUnit = specialize TUnit<TMeterSteradianRec>;

var
  MeterSteradianUnit : TMeterSteradianUnit;

{ TSquareMeterSteradian }

const
  cSquareMeterSteradian = 147;

type
  TSquareMeterSteradianRec = record
    const FUnitOfMeasurement = cSquareMeterSteradian;
    const FSymbol            = '%sm2.sr';
    const FName              = 'square %smeter steradian';
    const FPluralName        = 'square %smeter steradians';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareMeterSteradianUnit = specialize TUnit<TSquareMeterSteradianRec>;

var
  SquareMeterSteradianUnit : TSquareMeterSteradianUnit;

{ TCubicMeterSteradian }

const
  cCubicMeterSteradian = 148;

type
  TCubicMeterSteradianRec = record
    const FUnitOfMeasurement = cCubicMeterSteradian;
    const FSymbol            = '%sm3.sr';
    const FName              = 'cubic %smeter steradian';
    const FPluralName        = 'cubic %smeter steradians';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (3);
  end;
  TCubicMeterSteradianUnit = specialize TUnit<TCubicMeterSteradianRec>;

var
  CubicMeterSteradianUnit : TCubicMeterSteradianUnit;

{ TSquareMeterSteradianHertz }

const
  cSquareMeterSteradianHertz = 149;

type
  TSquareMeterSteradianHertzRec = record
    const FUnitOfMeasurement = cSquareMeterSteradianHertz;
    const FSymbol            = '%sm2.sr.%shertz';
    const FName              = 'square %smeter steradian %shertz';
    const FPluralName        = 'square %smeter steradian %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 1);
  end;
  TSquareMeterSteradianHertzUnit = specialize TUnit<TSquareMeterSteradianHertzRec>;

var
  SquareMeterSteradianHertzUnit : TSquareMeterSteradianHertzUnit;

{ TWattPerSteradian }

const
  cWattPerSteradian = 150;

type
  TWattPerSteradianRec = record
    const FUnitOfMeasurement = cWattPerSteradian;
    const FSymbol            = '%sW/sr';
    const FName              = '%swatt per steradian';
    const FPluralName        = '%swatts per steradian';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TWattPerSteradianUnit = specialize TUnit<TWattPerSteradianRec>;

var
  WattPerSteradianUnit : TWattPerSteradianUnit;

{ TWattPerSteradianPerHertz }

const
  cWattPerSteradianPerHertz = 151;

type
  TWattPerSteradianPerHertzRec = record
    const FUnitOfMeasurement = cWattPerSteradianPerHertz;
    const FSymbol            = '%sW/sr/%sHz';
    const FName              = '%swatt per steradian per %shertz';
    const FPluralName        = '%swatts per steradian per %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TWattPerSteradianPerHertzUnit = specialize TUnit<TWattPerSteradianPerHertzRec>;

var
  WattPerSteradianPerHertzUnit : TWattPerSteradianPerHertzUnit;

{ TWattPerMeterPerSteradian }

const
  cWattPerMeterPerSteradian = 152;

type
  TWattPerMeterPerSteradianRec = record
    const FUnitOfMeasurement = cWattPerMeterPerSteradian;
    const FSymbol            = '%sW/sr/%sm';
    const FName              = '%swatt per steradian per %smeter';
    const FPluralName        = '%swatts per steradian per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TWattPerMeterPerSteradianUnit = specialize TUnit<TWattPerMeterPerSteradianRec>;

var
  WattPerMeterPerSteradianUnit : TWattPerMeterPerSteradianUnit;

{ TWattPerSquareMeterPerSteradian }

const
  cWattPerSquareMeterPerSteradian = 153;

type
  TWattPerSquareMeterPerSteradianRec = record
    const FUnitOfMeasurement = cWattPerSquareMeterPerSteradian;
    const FSymbol            = '%sW/%sm2/sr';
    const FName              = '%swatt per square %smeter per steradian';
    const FPluralName        = '%swatts per square %smeter per steradian';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TWattPerSquareMeterPerSteradianUnit = specialize TUnit<TWattPerSquareMeterPerSteradianRec>;

var
  WattPerSquareMeterPerSteradianUnit : TWattPerSquareMeterPerSteradianUnit;

{ TWattPerCubicMeterPerSteradian }

const
  cWattPerCubicMeterPerSteradian = 154;

type
  TWattPerCubicMeterPerSteradianRec = record
    const FUnitOfMeasurement = cWattPerCubicMeterPerSteradian;
    const FSymbol            = '%sW/%sm3/sr';
    const FName              = '%swatt per cubic %smeter per steradian';
    const FPluralName        = '%swatts per cubic %smeter per steradian';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TWattPerCubicMeterPerSteradianUnit = specialize TUnit<TWattPerCubicMeterPerSteradianRec>;

var
  WattPerCubicMeterPerSteradianUnit : TWattPerCubicMeterPerSteradianUnit;

{ TWattPerSquareMeterPerSteradianPerHertz }

const
  cWattPerSquareMeterPerSteradianPerHertz = 155;

type
  TWattPerSquareMeterPerSteradianPerHertzRec = record
    const FUnitOfMeasurement = cWattPerSquareMeterPerSteradianPerHertz;
    const FSymbol            = '%sW/%sm2/sr/%sHz';
    const FName              = '%swatt per square %smeter per steradian per %shertz';
    const FPluralName        = '%swatts per square %smeter per steradian per %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -2, -1);
  end;
  TWattPerSquareMeterPerSteradianPerHertzUnit = specialize TUnit<TWattPerSquareMeterPerSteradianPerHertzRec>;

var
  WattPerSquareMeterPerSteradianPerHertzUnit : TWattPerSquareMeterPerSteradianPerHertzUnit;

{ TKatalPerCubicMeter }

const
  cKatalPerCubicMeter = 156;

type
  TKatalPerCubicMeterRec = record
    const FUnitOfMeasurement = cKatalPerCubicMeter;
    const FSymbol            = '%skat/%sm3';
    const FName              = '%skatal per cubic %smeter';
    const FPluralName        = '%skatals per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TKatalPerCubicMeterUnit = specialize TUnit<TKatalPerCubicMeterRec>;

var
  KatalPerCubicMeterUnit : TKatalPerCubicMeterUnit;

{ TCoulombPerMole }

const
  cCoulombPerMole = 157;

type
  TCoulombPerMoleRec = record
    const FUnitOfMeasurement = cCoulombPerMole;
    const FSymbol            = '%sC/%smol';
    const FName              = '%scoulomb per %smole';
    const FPluralName        = '%scoulombs per %smole';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TCoulombPerMoleUnit = specialize TUnit<TCoulombPerMoleRec>;

var
  CoulombPerMoleUnit : TCoulombPerMoleUnit;

const

  { Mul Table }

  MulTable : array[0..157, 0..157] of longint = (
    (  0 ,  1 ,  2 ,  3 ,  4 ,  5 ,  6 ,  7 ,  8 ,  9 , 10 , 11 , 12 , 13 , 14 , 15 , 16 , 17 , 18 , 19 , 20 , 21 , 22 , 23 , 24 , 25 , 26 , 27 , 28 , 29 , 30 , 31 , 32 , 33 , 34 , 35 , 36 , 37 , 38 , 39 , 40 , 41 , 42 , 43 , 44 , 45 , 46 , 47 , 48 , 49 , 50 , 51 , 52 , 53 , 54 , 55 , 56 , 57 , 58 , 59 , 60 , 61 , 62 , 63 , 64 , 65 , 66 , 67 , 68 , 69 , 70 , 71 , 72 , 73 , 74 , 75 , 76 , 77 , 78 , 79 , 80 , 81 , 82 , 83 , 84 , 85 , 86 , 87 , 88 , 89 , 90 , 91 , 92 , 93 , 94 , 95 , 96 , 97 , 98 , 99 ,100 ,101 ,102 ,103 ,104 ,105 ,106 ,107 ,108 ,109 ,110 ,111 ,112 ,113 ,114 ,115 ,116 ,117 ,118 ,119 ,120 ,121 ,122 ,123 ,124 ,125 ,126 ,127 ,128 ,129 ,130 ,131 ,132 ,133 ,134 ,135 ,136 ,137 ,138 ,139 ,140 ,141 ,142 ,143 ,144 ,145 ,146 ,147 ,148 ,149 ,150 ,151 ,152 ,153 ,154 ,155 ,156 ,157),
    (  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 , -1 ,147 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 ,145 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 ,153 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  2 , -1 ,  3 ,  4 ,  5 ,  6 ,  7 , -1 , 35 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 25 ,145 ,  8 , 28 , 29 , 30 , 31 , 32 , 80 , -1 , -1 , 15 , 36 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , 38 , -1 , 79 , 47 , 55 , -1 , -1 , -1 , 67 , -1 , -1 , 68 , 62 ,126 , -1 , -1 , -1 , 64 , 71 , -1 , -1 , 74 , -1 , 23 , -1 , 37 , 11 , 49 , 10 , -1 , -1 , 81 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , 77 , 54 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 ,116 , -1 ,124 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 , -1 , 34 ,  1 , -1 , -1 , -1 ,147 ,151 , -1 , -1 ,155 , -1 , -1 ,141 , -1),
    (  3 , -1 ,  4 ,  5 ,  6 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 ,  0 ,  1 , 35 ,  8 , 28 , 29 , 30 , 31 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , 39 , 49 , 46 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 ,108 , -1 , -1 , 38 , 37 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 16 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  4 , -1 ,  5 ,  6 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 ,  2 , -1 , -1 , 35 ,  8 , 28 , 29 , 30 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , 15 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  5 , -1 ,  6 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 ,  3 , -1 , -1 , -1 , 35 ,  8 , 28 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  6 , -1 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  5 ,  4 , -1 , -1 , -1 , -1 , 35 ,  8 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  6 ,  5 , -1 , -1 , -1 , -1 , -1 , 35 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  8 ,146 , 35 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , 11 , 12 , 13 , 14 , -1 , 36 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , 28 , 29 , -1 , 80 , 34 ,144 , -1 , -1 , -1 , 86 , -1 , 46 , 38 , 47 , -1 ,  9 ,  0 , 40 , 41 , 43 , 44 , -1 , -1 ,  2 , 15 , 49 , 50 , 55 , -1 , 77 , 87 , -1 , 59 , -1 , -1 ,124 , -1 , -1 ,116 , -1 , 64 ,129 , -1 , -1 , -1 , -1 , -1 , 74 , -1 , -1 , -1 , 54 , 52 , -1 , 37 , 78 , 51 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , 16 , 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , 56 ,100 ,101 , -1 ,103 ,107 , -1 , -1 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , 57 , 58 ,118 , -1 , -1 , -1 , -1 , -1 , 62 , 17 , -1 , 67 ,131 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 ,120 , -1 , -1 ,147 ,148 , -1 , -1 , -1 , -1 ,150 ,152 ,153 , -1 , -1 , -1),
    (  9 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 40 , 41 , 42 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 10 ,147 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , 12 , 13 , 14 , -1 , -1 , 46 , -1 ,137 , -1 , -1 , -1 , -1 ,110 , -1 , -1 , 80 , 34 , -1 , 78 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 ,135 , -1 ,  8 ,  9 ,  0 , 41 , 43 , -1 , -1 , 35 , 36 , 15 , 49 , 87 ,134 , 52 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , 71 , -1 , 77 , 55 , -1 , 38 , -1 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , 16 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , 98 , -1 , 56 ,100 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , 59 , -1 , 57 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , 39 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , 24 ,118 , -1 ,149 ,148 , -1 , -1 , -1 , -1 , -1 , -1 ,150 ,152 ,151 , -1 , -1),
    ( 11 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , 13 , 14 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 , -1 , 10 , -1 ,  8 ,  0 , 41 , -1 , -1 , -1 , 46 , 36 , 15 , 88 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 71 , -1 , -1 , -1 , 52 , 87 , -1 , 47 , -1 , 49 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , 75 , -1),
    ( 12 , -1 , 82 , -1 , -1 , -1 , -1 , -1 , 13 , -1 , 14 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , 10 ,  8 ,  0 , -1 , -1 , -1 , -1 , 46 , 36 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 88 , -1 , -1 , -1 , 15 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 13 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 14 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , 11 , 10 ,  8 , -1 , -1 , 82 , -1 , -1 , 46 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , 36 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 14 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 13 , -1 , 12 , 11 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , 46 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 15 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , 36 , -1 , 46 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , -1 , -1 , 37 , 77 ,155 , 38 , 52 ,100 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , 50 , 51 , 81 , -1 , -1 , -1 , 90 , 91 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , 47 , -1 , -1 , -1 , 11 , -1 , 87 , -1 ,135 , 29 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , 90 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , 10 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 17 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 ,127 , -1 ,140 , -1 , -1 , -1 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , 60 , -1 , -1 , 77 , 55 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 ,100 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 ,  8 , 52 , 66 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 18 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , 20 , 21 , 22 , -1 ,114 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , 55 , 34 , -1 , -1 , -1 , -1 , -1 , 56 ,100 , -1 ,107 , -1 , 10 ,101 , -1 , -1 , -1 , -1 , -1 ,113 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 20 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 21 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 21 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 20 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,110 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 21 , -1 , -1 , -1 , -1 , -1 , -1 ,112 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,114 , -1 , -1 , -1 , -1 , -1 , 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,141 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57),
    ( 24 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,142 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 25 ,145 ,  0 ,  2 ,  3 ,  4 ,  5 ,  6 , 28 , -1 , 80 , 78 , -1 , -1 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 75 , -1 , 26 , -1 , -1 , 29 , 30 , 31 , 32 , 33 , -1 ,144 ,  8 , 38 , 77 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , 55 , 41 , 79 , -1 , -1 ,100 , -1 ,102 , 56 , -1 , 17 , -1 , -1 , -1 , -1 , 64 , -1 , 69 , -1 , -1 , 60 , 63 , -1 , -1 , 70 , -1 , -1 , 73 , -1 , -1 ,101 , 86 , 54 , 34 , 83 , 12 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 ,127 , -1 ,140 , -1 , -1 , -1 ,125 , -1 , 65 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,156 , -1 , -1 , -1 , 27 , -1 ,149 , -1 , -1 , -1 ,150 , -1 , -1 , -1 ,153 , -1 , -1),
    ( 26 , 27 , 25 ,  0 ,  2 ,  3 ,  4 ,  5 , 29 , -1 , 34 , 86 , -1 , -1 , -1 , 77 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 30 , 31 , 32 , 33 , -1 , -1 , -1 , 28 , 52 ,101 ,100 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 56 , -1 , 54 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 ,144 , -1 , -1 , -1 , 93 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , 43 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 27 , -1 ,145 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 ,152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 28 , -1 ,  8 , 35 , -1 , -1 , -1 , -1 , 80 , -1 , 78 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , 30 , -1 , 34 ,144 , -1 , -1 , -1 , -1 , -1 , 10 , 47 , 52 , 55 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , 87 ,  0 , 37 , 79 , -1 , 56 , -1 ,101 , -1 , -1 , -1 , -1 ,137 ,125 , -1 , -1 ,123 , -1 , 69 ,117 ,124 ,116 , -1 , -1 , -1 , 73 , -1 , -1 , -1 ,102 ,100 , -1 , 77 , 86 , -1 , 13 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 , 60 , -1 , 63 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 , -1 , -1),
    ( 29 , -1 , 28 ,  8 , 35 , -1 , -1 , -1 , 34 , -1 , 86 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 30 , 31 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , 55 ,100 , 56 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , 87 , -1 , 25 , 77 , 54 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 ,122 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 30 , -1 , 29 , 28 ,  8 , 35 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 31 , 32 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 ,101 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 31 , -1 , 30 , 29 , 28 ,  8 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 32 , 33 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 32 , -1 , 31 , 30 , 29 , 28 ,  8 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 33 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 33 , -1 , 32 , 31 , 30 , 29 , 28 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 34 , -1 , 80 , 10 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , 87 , 56 , -1 ,134 , -1 , 29 , -1 , 26 , -1 , -1 , 88 , -1 , 28 , 52 , 77 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , 76 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 ,123 , 53 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , 28 , -1 , 10 , 80 , 34 ,144 , -1 , -1 , 78 , -1 , -1 , 36 , 46 , -1 , -1 ,  2 , -1 , 48 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , 47 , -1 , 37 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 38 , 12 , 15 , 11 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 52 , 77 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , -1 , -1 , 86 ,146 , -1 , -1 , -1 ,148 , -1 , -1 ,151 , -1 ,155 , -1 , -1 , -1),
    ( 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , 52 , -1 , 47 , 55 , 56 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , 49 , 50 , 51 , -1 , -1 , -1 , 16 , 90 , 91 , 39 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , 88 ,135 , -1 , 34 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 37 , -1 , 15 , -1 , 85 , -1 , -1 , -1 , 38 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 ,101 ,153 , 52 ,100 , -1 , -1 , -1 , -1 , 56 , 36 , -1 ,132 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , 83 , -1 , 39 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , 55 , -1 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , 30 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 38 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 ,100 ,152 , 55 , 56 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , 39 , -1 , -1 , 37 , -1 , 79 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 ,132 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 40 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  9 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , 42 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 41 , -1 , 48 , -1 , -1 , -1 , -1 , -1 ,  0 , 40 ,  8 , 10 , 11 , 12 , 13 , 49 , 90 ,127 , -1 , 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , 26 , -1 , -1 , -1 , -1 , 29 ,  2 , 15 , 79 , 37 , -1 , 42 , 43 , -1 , 44 , 45 , -1 , 36 , 38 , -1 , 50 , 51 , 81 , 77 , -1 , 76 , 52 ,100 ,118 ,119 , 57 ,117 , -1 ,126 , -1 , 65 , -1 , -1 ,129 ,131 , -1 , -1 , -1 , -1 , -1 , 72 , -1 , -1 , 54 , 80 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , 34 , 55 , 87 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 ,101 ,102 , -1 ,104 ,109 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , -1 ,120 , -1 ,143 , -1 , -1 , -1 , 60 , -1 , -1 ,140 , -1 , 66 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 30 , -1 ,  1 ,146 ,147 , -1 ,152 , -1 ,153 ,154 , -1 , -1 , -1 , -1),
    ( 42 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 40 , 41 ,  9 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 43 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , 41 , 42 ,  0 ,  8 , 10 , 11 , 12 , 50 , 91 ,140 , -1 , -1 , -1 , -1 , -1 , -1 ,142 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , 48 , 49 , -1 , 79 ,132 , -1 , 44 , -1 , 45 , -1 , -1 , 15 , 37 , -1 , 51 , 81 , -1 , 54 , -1 , -1 , 77 ,101 ,120 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 ,130 , -1 , 73 , 74 , -1 , -1 , -1 , -1 , -1 , 76 , 28 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , 29 , 52 , 55 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , 99 , -1 ,102 , -1 , -1 ,109 , -1 , -1 , -1 , -1 , 94 , -1 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 ,122 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , 39 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 ,146 ,145 ,153 ,155 ,154 , -1 , -1 , -1 , -1 , -1),
    ( 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 41 ,  0 ,  8 , 10 , 11 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,141 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , 45 , -1 , -1 , -1 , -1 , 49 , 79 , -1 , 81 , -1 , -1 , 76 , -1 , -1 , 54 ,102 ,143 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 72 , -1 , -1 , -1 ,156 , -1 , -1 , 25 , 83 , -1 , -1 , 35 , -1 , -1 , -1 , 26 , 77 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , 43 , 41 ,  0 ,  8 , 10 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , 83 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , 54 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , 55 ,151 , -1 , 87 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , 15 , 49 , 50 , -1 , -1 , -1 , -1 , 16 , 90 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , 39 , -1 , -1 , -1 , 91 , -1 , -1 , 13 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 47 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 56 ,150 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , 38 , -1 , 37 , 79 , -1 , -1 ,135 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , 35 , -1 , -1 , 82 , -1 , -1 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , -1 ,  0 , 25 , 26 , -1 , -1 , -1 , 28 ,  3 , -1 , 49 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 ,133 , -1 , -1 , -1 , 37 , -1 , -1 , 38 , 52 , -1 , -1 , -1 ,129 , -1 , -1 ,131 ,126 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , 72 , -1 , -1 , -1 , 79 , 10 , 50 ,  8 , -1 , -1 , -1 , -1 , -1 , 80 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , 54 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , 66 , -1 , -1 , -1 , -1 , -1 , 63 , 67 , 60 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 ,143 , -1 , -1 , -1 , 29 , -1 , -1 , -1 , -1 ,146 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1),
    ( 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , 36 , 46 , -1 , -1 , -1 , 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 54 , -1 , 37 , 77 ,101 , -1 , -1 , -1 , 52 , -1 , 16 , -1 , -1 , -1 , -1 , 50 , -1 , 51 , 81 , -1 , -1 , -1 , -1 , 91 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , 38 , -1 , -1 , -1 , 10 , -1 , 55 , 39 , -1 , 26 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , 15 , 36 , 46 , -1 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , 79 , 54 ,102 , -1 , -1 , -1 , 77 , -1 , 90 , -1 , -1 , -1 , -1 , 51 , -1 , 81 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , 37 , -1 , -1 , -1 ,  8 , -1 , 52 , -1 , 39 , -1 , -1 , -1 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , 49 , 15 , 36 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , 54 , -1 , 91 , -1 , -1 , -1 , -1 , 81 , -1 , -1 , -1 , -1 , 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , 79 , -1 , -1 , -1 ,  0 , -1 , 77 ,132 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 52 , -1 , 38 , 36 , -1 , -1 , -1 , -1 , 55 , -1 , 87 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , 39 , -1 , -1 , -1 , -1 , 77 , -1 , 54 , 76 , -1 , -1 , -1 , 37 ,132 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , 61 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 53 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 54 , -1 , 79 , 49 , -1 , -1 , -1 , -1 , 77 , -1 , 52 , 55 , 87 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , 37 ,132 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 ,100 , -1 , -1 , -1 , 34 , 90 , -1 , 53 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , 72 , -1 , -1 , -1 , -1 , -1 , -1 ,154 ,155 , -1 ,151 ,152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 55 ,151 , 47 , 46 , -1 , -1 , -1 , -1 , 87 , -1 , 88 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , 77 , 54 , 76 ,135 , -1 , 38 , -1 ,132 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , 71 ,113 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 56 ,150 , 55 , 47 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , 53 , -1 , -1 , -1 ,100 , -1 ,101 ,102 , -1 , -1 ,134 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 ,  8 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , 37 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 ,120 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , 55 , -1 , -1 , 67 , -1 , -1 , 37 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 ,119 , -1 , -1 , -1 ,117 ,124 , 87 , -1 , -1 , -1 , 35 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,157 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , 47 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , 52 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 ,118 ,120 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 58 , -1 ,119 , -1 , 60 , -1 , 88 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 60 , -1 , 67 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , 87 , 61 , -1 , 57 , -1 , 17 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , 77 , -1 , -1 , -1 , -1 , -1 ,118 ,100 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 ,101 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113),
    ( 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , 55 , -1 , 56 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , 57 , 55 , -1 ,  2 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 ,118 , -1 , -1 , -1 , -1 , 41 ,  8 , 59 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 63 , -1 , 68 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , 67 , 47 , -1 , -1 , -1 ,  2 , -1 ,  0 , 41 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , 38 , 66 , -1 , -1 , -1 , -1 , -1 , 48 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 64 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , 58 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , 17 , 56 , -1 ,  0 , -1 , -1 ,120 , 57 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 ,127 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 65 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 ,100 , -1 , 41 , -1 , -1 ,143 ,118 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,140 , -1 , -1 , -1 , -1 , -1 , 25 , 17 , -1 , -1 , -1 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , 38 , -1 , -1 , -1 , -1 ,120 ,143 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , 60 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , 55 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 , -1 ,124 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , 57 ,118 , -1 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , 88 , -1 , -1 , 77 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , -1 , -1 ,116 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 ,  3 , -1 ,  2 , 48 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 69 , -1 , 64 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 ,140 , 17 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , -1 , -1 , -1 , -1 ,127 , 43 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 70 , -1 , 71 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 71 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 74 , 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 74 , -1 , -1 , 71 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 73 , -1 , 74 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 74 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 71 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 75 , -1 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,156 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17),
    ( 76 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , 54 , -1 , 77 , 52 , 55 , 87 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 ,101 , -1 , 47 , -1 , 29 , 91 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , 31 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 ,153 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 77 ,155 , 37 , 15 , -1 , 85 , -1 , -1 , 52 , -1 , 55 , 87 , 88 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , 76 , -1 , -1 , 39 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , 86 , 16 , -1 , -1 ,134 , 31 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , 74 , -1 , -1 , -1 , -1 , -1 , -1 ,153 , -1 ,151 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 78 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , 87 , 88 , -1 , -1 , 80 , -1 , 28 , 25 , -1 , -1 , -1 , 10 , 47 , 38 , 37 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 ,100 , -1 , -1 , 55 , -1 , 79 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 75 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 79 , -1 , 49 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , 38 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 ,102 ,154 , 77 ,101 , -1 , -1 , -1 , -1 ,100 , 15 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , 83 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , 52 , -1 , -1 , -1 , 80 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 80 ,149 , 10 , -1 , -1 , -1 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 ,144 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , 55 , 87 , -1 , -1 , 28 , -1 , 25 , -1 , -1 , -1 , 88 ,  8 , 38 , 37 , 79 , -1 , -1 ,100 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 ,101 , 56 , -1 , 52 , -1 , -1 , 14 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , 63 ,116 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1),
    ( 81 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , -1 , 50 , 49 , 15 , 36 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 83 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , 54 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 82 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , -1 , 13 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , 14 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 83 , -1 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 37 , 38 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , 76 , -1 , 15 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 13 , -1 , -1 , 10 ,  8 ,  0 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , 86 , -1 , 80 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , 36 , 38 , 52 ,100 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 86 , -1 , 78 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , 34 , -1 , 29 , 26 , -1 , -1 , -1 , 80 , 55 , 52 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , 54 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , 55 , -1 , 52 , 77 , 54 , -1 , -1 , 47 , 39 , -1 ,132 ,134 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , 55 , 52 , 77 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 ,134 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , 29 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , 30 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 31 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , 77 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 32 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , 39 , -1 , -1 , 77 , -1 , -1 ,  8 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 90 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , 54 , -1 , -1 ,  0 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 93 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , 34 , 29 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 31 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , 55 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 19 , 20 , 21 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 ,  8 , 41 ,104 ,109 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 ,115 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , 39 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , 87 , 52 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 97 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , 86 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , 99 , -1 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , 87 , 86 , -1 , 20 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , 11 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , 52 , 29 , 20 , -1 , -1 , -1 , -1 ,100 ,101 , -1 ,105 , -1 ,  8 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (100 ,152 , 52 , 38 , 36 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , 53 , -1 , -1 ,101 , -1 ,102 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 99 ,  0 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (101 ,153 , 77 , 37 , 15 , -1 , 85 , -1 ,100 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,112 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , 53 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , 32 , -1 , -1 , -1 , -1 ,109 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , 99 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (102 ,154 , 54 , 79 , 49 , -1 , -1 , -1 ,101 , -1 ,100 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 ,152 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (103 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 ,109 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 ,109 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 ,101 , -1 , -1 , -1 , -1 , -1 , 41 , 94 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , 99 , -1 , -1 ,  0 , 41 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , 38 , -1 , 35 ,  8 , -1 , -1 , -1 ,128 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,105 ,  0 , 41 , 43 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 , -1 ,  1 , -1 , -1 , -1 , -1 , -1),
    (107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , 35 , -1 , -1 , -1 , 19 , 99 , -1 ,  8 ,  0 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , 11 ,  8 , -1 ,103 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (109 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 ,102 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (110 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (111 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (112 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (113 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 , -1),
    (114 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 ,  8 ,  0 , -1 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , 47 ,129 , -1 , -1 , -1 , -1 , -1 ,  2 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (117 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , 60 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , 55 , -1 , -1 ,118 , -1 ,127 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , 54 , -1 , -1 , -1 , 61 , -1 ,120 ,101 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , -1 , -1 ,102 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , 58 , 52 , -1 , -1 ,129 , -1 , -1 , 79 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , 77 , -1 , -1 , -1 , -1 , -1 , 60 , 55 , 56 , -1 , -1 ,  2 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 ,  8 , 77 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , 57 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , 77 , -1 , -1 , 66 , -1 , -1 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , 54 , -1 , -1 , -1 , -1 , -1 ,117 , 52 ,100 , -1 , -1 , 48 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 ,130 , -1 ,123 , 61 ,122 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (122 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , 52 , 60 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (123 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 ,124 , 87 , -1 , -1 , -1 ,  8 , -1 , 28 , 25 , -1 , -1 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , 55 ,117 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 ,117 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , 88 , -1 , -1 , 59 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , 55 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , 57 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , -1 ,100 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (125 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 , 61 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , 64 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 ,118 , 52 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 ,120 , -1 , -1 , -1 , -1 , 43 ,  0 , 57 , 17 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (127 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 ,117 , -1 , -1 , 54 , 52 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 ,  0 , 77 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , 66 , -1 ,124 , 35 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 ,  2 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , 60 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , 47 , -1 , -1 , -1 , -1 ,118 ,120 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , 79 , -1 , -1 , -1 , -1 , 61 , -1 , 77 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , 87 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , 63 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , 63 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (132 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 48 , 41 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , 49 ,132 , 51 , 15 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 81 , 50 , 35 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 ,  8 , 36 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (134 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 ,118 ,120 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , 25 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , -1 , 69 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 ,127 ,140 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , 11 , 87 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 72 , 71 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 74 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (139 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113 , -1 ,157 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (140 , -1 ,120 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , 17 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , 76 , 77 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 ,102 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , 41 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (141 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,156 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143),
    (142 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 24 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 ,118 , 57 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 ,127 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , 77 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (144 , -1 , 34 , 80 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , 30 , -1 , -1 , -1 , -1 , -1 , -1 , 29 ,100 ,101 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (145 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 ,152 , -1 ,154 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (146 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,147 , -1 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 ,152 ,153 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (147 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 ,152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,147 , -1 ,146 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (149 , -1 ,147 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,148 , -1 ,151 , -1 , -1 , -1 , -1 , -1 ,145 , -1 , -1 , -1 , -1 ,146 , -1 , -1 , -1 , -1 , -1 ,152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (150 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 , -1 ,153 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 , -1 ,153 , -1 ,154 , -1 , -1 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (153 , -1 ,155 , -1 , -1 , -1 , -1 , -1 ,152 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 , -1 ,152 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 , -1 , -1 ,152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (156 , -1 ,141 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (157 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1)
  );

  { Div Table }

  DivTable : array[0..157, 0..157] of longint = (
    (  0 , -1 , 25 , 26 , -1 , -1 , -1 , -1 , 41 , 40 , 43 , 44 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 ,139 , -1 ,  2 ,  3 , -1 , 48 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 ,  9 ,  8 , -1 , 10 , 11 , 12 , -1 , -1 , 28 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , 63 ,116 , -1 , -1 , 69 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , 91 , -1 , 19 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 ,105 ,107 ,103 ,100 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , -1 , -1 ,123 ,128 ,127 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  1 ,  0 ,145 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 , -1 ,147 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , 41 , 43 , 44 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1),
    (  2 , -1 ,  0 , 25 , 26 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 ,  4 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , 82 , -1 , -1 ,  8 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , 62 , 68 , -1 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 ,118 , -1 , -1 , -1 , -1 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  3 , -1 ,  2 ,  0 , 25 , 26 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 ,  5 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  4 , -1 ,  3 ,  2 ,  0 , 25 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  5 ,  6 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  5 , -1 ,  4 ,  3 ,  2 ,  0 , 25 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  6 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  6 , -1 ,  5 ,  4 ,  3 ,  2 ,  0 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  7 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  7 , -1 ,  6 ,  5 ,  4 ,  3 ,  2 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  8 , -1 , 28 , 29 , 30 , 31 , 32 , 33 ,  0 ,  9 , 41 , 43 , 44 , 45 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 ,  2 ,  3 ,  4 ,  5 ,  6 ,  7 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , 11 , 12 , 13 , -1 , -1 , 80 , -1 , 84 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 ,123 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , 50 , 89 ,133 , -1 , -1 , 85 , 92 , -1 , 90 , -1 , 98 , -1 , -1 , -1 , 94 ,108 , -1 , -1 , -1 ,107 , -1 , -1 , 56 ,103 , 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 ,121 , -1 ,119 , -1 , 62 , -1 , -1 , -1 , -1 , 17 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (  9 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 40 ,  0 , 42 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 10 , -1 , 80 , 34 ,144 , -1 , -1 , -1 ,  8 , -1 ,  0 , 41 , 43 , 44 , 45 , -1 , 92 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 ,  3 , 28 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , 12 , 13 , 14 , -1 , -1 , 78 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 ,  2 , -1 , -1 , -1 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 11 , -1 , 78 , 86 , -1 , -1 , -1 , -1 , 10 , -1 ,  8 ,  0 , 41 , 43 , 44 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , 13 , 14 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , 35 , -1 , -1 , -1 , 15 , 93 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 12 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , 10 ,  8 ,  0 , 41 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , 84 , -1 , -1 , -1 , -1 , 13 , -1 , 14 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , 25 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 13 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , 11 , 10 ,  8 ,  0 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 14 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 14 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 13 , -1 , 12 , 11 , 10 ,  8 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 15 , -1 , 37 , 77 ,101 , -1 , -1 , -1 , 49 , -1 , 50 , 51 , 81 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 41 ,  2 , 48 , -1 , -1 , 36 , -1 , 46 , -1 , -1 , 43 , -1 , 38 ,  8 , 10 , 11 , -1 , -1 , -1 ,133 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , 35 , -1 , 12 , 83 , 82 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 95 , 94 , -1 , -1 , -1 , -1 , -1 ,  4 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 ,119 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 16 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , 90 , -1 , 91 , -1 , -1 , -1 , -1 , 15 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , 36 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 ,  8 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , 64 , -1 , -1 , -1 , 60 ,124 , -1 , 69 , -1 , 67 , -1 , -1 , -1 , -1 , -1 ,157 , -1 , -1 ,143 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , 80 , -1 , -1 , -1 , 65 ,126 ,125 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , 43 , -1 , -1 , 10 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 75),
    ( 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , 64 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 20 , -1 , -1 , -1 , 41 ,  8 ,107 , -1 , -1 , -1 , -1 , 56 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 ,139 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,114 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 20 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 ,  0 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 21 , -1 , -1 , -1 , 99 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 21 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 20 , 19 ,  0 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 21 , 20 , 19 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,110 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 23 , -1 , 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,141 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,114 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 24 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,142 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 25 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,  2 , -1 , 41 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , 80 , 78 , -1 , -1 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 ,123 ,136 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 ,139 , -1 , -1 , 44 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , 66 , -1 , -1 , 75 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 ,  0 , -1 , -1 , 41 , 48 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , 34 , 86 , -1 , -1 , -1 , 30 , 89 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , 49 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 27 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 ,  1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 28 , -1 , 29 , 30 , 31 , 32 , 33 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , 35 , -1 ,  0 ,  2 ,  3 ,  4 ,  5 ,  6 , 48 , 26 , -1 , -1 , -1 , -1 , -1 , 80 , -1 , 78 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 29 , -1 , 30 , 31 , 32 , 33 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 ,  8 , -1 , 25 ,  0 ,  2 ,  3 ,  4 ,  5 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , 86 , -1 , -1 , -1 , -1 ,144 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , 43 , -1 , -1 , 15 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , 99 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 30 , -1 , 31 , 32 , 33 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , 28 , -1 , 26 , 25 ,  0 ,  2 ,  3 ,  4 , -1 , -1 , -1 , 89 , -1 , -1 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 31 , -1 , 32 , 33 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 30 , 29 , -1 , -1 , 26 , 25 ,  0 ,  2 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 32 , -1 , 33 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 31 , 30 , -1 , -1 , -1 , 26 , 25 ,  0 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 33 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 32 , 31 , -1 , -1 , -1 , -1 , 26 , 25 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 34 , -1 ,144 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , 97 , -1 , -1 , -1 , -1 , -1 , 80 , 10 , -1 , 28 ,  8 , 35 , -1 , -1 , -1 ,  0 , 30 , 89 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , 54 , -1 , 41 , -1 , -1 , 36 , -1 , -1 ,132 , 49 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , -1 , -1 , -1 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 35 , -1 ,  8 , 28 , 29 , 30 , 31 , 32 ,  2 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 ,  4 ,  5 ,  6 ,  7 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 ,128 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 36 , -1 , 38 , 52 ,100 , -1 , -1 , -1 , 15 , -1 , 49 , 50 , 51 , 81 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , 37 ,  0 , 35 ,  2 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , 41 , 48 , 47 , 10 , 11 , 12 ,  3 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 13 , -1 , -1 , 91 , 29 , -1 ,133 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 37 , -1 , 77 ,101 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , 83 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 ,  0 , 41 , -1 , -1 , 38 , -1 , 47 , -1 , -1 , -1 , 43 , 52 , 28 , 80 , 78 , 48 , -1 , 35 , -1 ,133 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , 51 ,  8 , 50 , -1 , -1 , 12 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 38 , -1 , 52 ,100 , -1 , -1 , -1 , -1 , 37 , -1 , 79 , -1 , -1 , 83 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , -1 , -1 , 15 , -1 , 85 , -1 , -1 , -1 , -1 , 77 , 25 ,  8 ,  0 , -1 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , 41 , 55 , 80 , 78 , -1 ,  2 ,106 , -1 , 48 , -1 ,129 , -1 , 66 , -1 , -1 , -1 ,119 , -1 , -1 , 59 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , 50 , 10 , 49 , -1 , -1 , 13 , -1 , 30 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 39 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , -1 , -1 , 55 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 16 , -1 , 52 , 47 , 38 ,  0 , -1 , -1 , -1 ,135 , -1 , -1 , 77 , 37 , -1 , 87 , 88 , -1 , 36 ,  3 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 90 , 49 , 50 , -1 , 86 , -1 , -1 , -1 , -1 , 96 , 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 ,134 ,133 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 40 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 42 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,  9 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , 42 , 44 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 40 ,  0 ,  9 ,  8 , 10 , 11 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , 65 , -1 , 63 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 99 , -1 , -1 , -1 , -1 , 94 , -1 ,106 , -1 , -1 ,105 ,104 ,101 ,109 , -1 ,107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 , 69 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 42 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , 40 ,  0 ,  9 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 42 , 41 , 40 ,  0 ,  8 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 ,109 ,102 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , 69 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , 42 , 41 ,  0 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,141 , -1 ,139 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , 43 , 41 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 46 , -1 , 47 , 55 , 56 , -1 , -1 , -1 , 36 , -1 , 15 , 49 , 50 , 51 , 81 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , 38 ,  8 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 ,  2 , -1 , 11 , 12 , 13 , -1 , -1 , -1 ,  3 ,  4 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 14 , -1 , -1 , 90 , 34 , -1 , -1 ,133 , -1 , 84 , -1 , -1 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 47 , -1 , 55 , 56 , -1 , -1 , -1 , -1 , 38 , -1 , 37 , 79 , -1 , -1 , 83 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , 28 , 10 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 ,  0 , 87 , 78 , -1 , -1 , 35 , -1 , -1 ,  2 ,  3 , 67 , 63 ,129 , -1 , -1 , -1 , 58 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , 49 , 11 , 15 , -1 , 76 , 14 , -1 ,144 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 48 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , 35 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 ,131 , 68 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , 63 , -1 ,120 , -1 , -1 , 64 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 49 , -1 , 79 , 54 ,102 , -1 , -1 , -1 , 50 , -1 , 51 , 81 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , 48 , -1 , -1 , -1 , 15 , -1 , 36 , 46 , -1 , 44 , -1 , 37 ,  0 ,  8 , 10 ,133 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , 52 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 50 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , 51 , -1 , 81 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , 49 , -1 , 15 , 36 , 46 , 45 , -1 , 79 , 41 ,  0 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 ,133 , -1 , 48 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 83 , 45 , -1 , -1 , -1 , -1 , 50 , -1 , 49 , 15 , 36 , -1 , -1 , -1 , 43 , 41 ,  0 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 52 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , 54 , 76 , -1 , -1 , -1 , 29 , 89 ,129 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , 36 , -1 , 37 , 15 , -1 , 85 , -1 , -1 , 49 ,101 , 26 , 28 , 25 , -1 , -1 , 55 , -1 , 87 , 88 , -1 , -1 , -1 , 56 , 34 , 86 , -1 ,  0 , -1 , 10 , 41 , 48 ,117 ,122 , -1 ,118 ,126 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 ,  8 , -1 , 80 , 79 , -1 , -1 , -1 , -1 , 31 , 50 , 43 , 44 , 16 , -1 , 93 , -1 , 91 , -1 , -1 , 99 , -1 , -1 , 96 ,  2 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , 60 , -1 ,124 , -1 , 58 , -1 ,120 , -1 , 61 , 67 , -1 , 17 , -1 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,132 , -1 , -1 , 56 ,100 , 26 , -1 , -1 , -1 ,134 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , 52 ,  0 , 87 , 77 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 54 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 49 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , 52 , 55 , 87 , -1 , -1 ,101 , 26 , 29 , 34 , 43 , -1 ,  0 , 44 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , 41 , 83 , 25 , -1 , 86 , -1 , 78 , -1 , -1 , 81 , 45 , -1 , 91 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,141 , -1 , -1 , -1 ,120 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 ,113 , -1 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 55 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , 52 , -1 , 77 , 54 , 76 , -1 , -1 , 34 , -1 , 67 , 68 , 96 , -1 , -1 , -1 ,113 , -1 , 47 , 46 , -1 , 38 , 36 , -1 , -1 , -1 , -1 , 15 ,100 , 29 , 80 , 28 , -1 , -1 , 87 , -1 , 88 , -1 , -1 , 26 , 25 , -1 , 86 , -1 , -1 ,  8 , -1 , 11 ,  0 ,  2 , 60 , -1 ,117 , 57 , 62 , 61 , -1 , -1 , -1 ,137 , 17 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , 10 , 79 , 78 , 37 , -1 , -1 , -1 , -1 , -1 , 49 , 41 , 43 , -1 , 93 , -1 , -1 , 90 , -1 , 97 , 19 , 95 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 23 ,115 ,114 , -1 , 59 ,124 ,123 , -1 , -1 , -1 ,119 ,118 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 ,101 ,102 , -1 , -1 , -1 ,144 , -1 , 60 , 63 ,103 , -1 , -1 ,111 , -1 , -1 , 55 , 47 , -1 , 52 , 38 , 36 , -1 , -1 , -1 , 37 , -1 , 30 , 34 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , 28 , -1 , 78 , 25 ,  0 , -1 , -1 , -1 , 17 , 64 , -1 , 18 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113 , -1 , 80 , 54 , 86 , 77 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 ,  8 , 10 , 11 , 19 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , 22 , -1 , 75 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 ,127 ,118 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 57 , -1 , 17 , -1 , -1 , -1 , -1 , -1 ,118 , -1 ,120 ,143 , -1 , -1 , -1 ,136 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 ,157 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , 41 , 62 , -1 , 60 , -1 , 67 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , 10 , -1 , -1 , -1 ,126 , -1 ,124 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 23),
    ( 58 , -1 , -1 , 18 , -1 , -1 , -1 , -1 ,119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , 57 ,  0 ,118 , -1 , -1 , 55 , -1 , 47 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 ,118 ,120 ,143 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 ,  0 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , 11 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , 48 , -1 , -1 , -1 , -1 , -1 , 12 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 ,  0 , -1 , -1 , 17 , -1 , -1 , 80 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 ,  8 ,123 , -1 , -1 , -1 , 59 ,118 , 41 , 48 , -1 ,116 ,100 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 ,121 , -1 , -1 , 63 , -1 , -1 , -1 , 60 ,  0 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 ,124 , -1 , -1 , -1 , 53 , 87 , 52 ,117 ,129 , -1 , -1 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 62 , -1 , 64 , 69 , -1 , -1 , -1 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 ,  2 , 35 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 ,121 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 ,128 , -1 , -1 , -1 , 37 , 35 , 48 , -1 , -1 , -1 , -1 ,117 , -1 , 80 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 64 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 ,  0 ,  8 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 ,  0 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , 67 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 ,  0 , 43 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , 48 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , 54 , 41 , 17 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 67 , -1 , 60 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , 63 , -1 , -1 ,  2 , -1 , -1 , 57 , -1 , -1 , 10 ,  0 , 17 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , 35 ,116 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , 52 ,  8 ,137 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 68 , -1 , 63 , -1 , -1 , -1 , -1 , -1 ,131 , -1 ,130 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 ,129 ,128 , 10 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 69 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , 62 , -1 , 65 ,126 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , 25 , 28 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 70 , 24 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , 71 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 25 , 78 , 10 , 80 , -1 , -1 , -1 , 72 , -1 , 74 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 ,147 , -1 , -1 , -1 , -1 ,142 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 71 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 74 , 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 ,  0 , 11 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 74 , -1 , -1 , 71 , -1 , -1 , -1 , 73 , -1 , -1 , -1 , -1 , -1 ,138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 ,  0 , 48 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 73 ,142 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 74 , -1 , -1 , 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 70 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 28 ,  0 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 74 , -1 , 73 , -1 , -1 , -1 , -1 , -1 , 72 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 71 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 ,  8 ,  2 ,  0 , -1 , -1 ,138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,156 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 ,141 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1),
    ( 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , 77 , 52 , 55 , -1 , -1 ,102 , -1 , 26 , 29 , 44 , -1 , 41 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 43 , -1 , -1 , 83 , 34 , -1 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 77 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , 76 , -1 , -1 , -1 , -1 , 26 , -1 , 66 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , 15 , -1 , 79 , 49 , -1 , -1 , -1 , -1 , 50 ,102 , -1 , 25 , -1 , -1 , -1 , 52 , -1 , 55 , 87 , 88 , -1 , -1 ,100 , 29 , 34 , 86 , 41 , -1 ,  8 , 43 , -1 , -1 , -1 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , 17 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 ,  0 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , 44 , 45 , 90 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 ,  2 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 ,117 ,122 , 60 , -1 ,119 , -1 ,143 , -1 , -1 ,129 , -1 ,127 , 18 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 78 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , 80 , -1 , 28 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , 35 , 34 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 ,  8 , -1 , -1 , -1 , 37 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 79 , -1 , 54 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 83 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , 41 , 43 , -1 , -1 , 37 , -1 , 38 , 47 , -1 , -1 , 44 , 77 , 25 , 28 , 80 , -1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , 48 , 81 ,  0 , 51 , 78 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 , -1 ,100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 80 , -1 , 34 ,144 , -1 , -1 , -1 , -1 , 28 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 ,  8 , 35 , -1 , -1 , -1 , -1 ,  2 , 29 , -1 , -1 , -1 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , 84 ,  0 , -1 , -1 , -1 , 79 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 81 , -1 , 83 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , -1 , 50 , 49 , 15 , -1 , -1 , -1 , 44 , 43 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 ,  0 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 82 , -1 , 12 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 ,  2 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 13 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 83 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 81 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , 25 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 84 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 85 , -1 , -1 , 15 , 37 , 77 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  4 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  5 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  6 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 86 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , 29 , 26 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , 11 , -1 , 80 , 10 , -1 , -1 , -1 , -1 ,  8 ,144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , 25 , -1 , 28 , -1 , -1 , -1 , 77 , -1 ,  0 , -1 , -1 , 46 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , 98 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 87 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , 52 , 77 , 54 , 76 , -1 , 86 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , 46 , -1 , -1 , -1 , -1 , 36 , 56 , 34 , 78 , 80 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , 29 , 28 , -1 , -1 , -1 , -1 , 10 , -1 , 12 ,  8 , 35 ,124 ,123 , 60 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 13 , 11 , 37 , -1 , 38 , -1 ,102 , -1 ,132 , -1 , 15 ,  0 , 41 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , 98 , -1 , 96 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 58 , 57 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , 84 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , 55 , 52 , 77 , 54 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , 86 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , 80 , -1 , -1 , -1 , -1 , 11 , -1 , 13 , 10 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 14 , 12 , 38 , -1 , 47 , -1 ,101 , -1 , -1 , -1 , 36 ,  8 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 82 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , 54 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 90 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 91 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , 15 , 36 , 46 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 ,  0 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 91 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , 90 , -1 , 16 , -1 , -1 , 81 , -1 , -1 , 49 , 15 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 85 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , 76 , -1 , -1 , -1 , -1 , 41 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,133 ,132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 93 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 92 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , 52 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 ,133 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 ,104 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 95 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , 49 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 96 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 ,  0 , 15 , -1 , -1 , -1 , -1 , -1 ,  2 , 35 , -1 , -1 , -1 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,108 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    ( 99 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 19 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 ,  0 ,105 ,107 , -1 , -1 , -1 ,100 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (100 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 ,102 , -1 , -1 , -1 , -1 , 30 , -1 ,117 , -1 ,104 , -1 , -1 , -1 , -1 , -1 , 52 , 38 , -1 , 77 , 37 , 15 , -1 , 85 , -1 , 79 , -1 , -1 , 29 , 26 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,144 , -1 , -1 , 25 , -1 , 80 , -1 , 41 , -1 , -1 , -1 ,127 , 65 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , 28 , 76 , 34 , 54 , -1 , -1 , -1 , -1 , 32 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,109 ,103 ,  0 ,  8 , 10 , 99 , 19 , -1 , -1 , -1 , -1 , 98 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 ,125 , -1 , -1 , -1 ,140 ,120 , -1 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , -1 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,109 , -1 , -1 , -1 , -1 , -1 , 77 , 37 , -1 , 54 , 79 , 49 , -1 , -1 , -1 , -1 , -1 , -1 , 26 , -1 , -1 , -1 ,100 , -1 , 56 , -1 , -1 , -1 , -1 , -1 , 30 ,144 , -1 , -1 , -1 , 28 , -1 , 43 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , 25 , -1 , 29 , 76 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , 41 ,  0 ,  8 , -1 , 99 , -1 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 , -1 ,125 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , 79 , -1 , 76 , -1 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 ,100 , 56 , -1 , -1 , -1 , -1 , -1 , 30 ,144 , -1 , -1 , 25 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , -1 , 26 , -1 , -1 , -1 , 86 , -1 , -1 , 83 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,109 , 43 , 41 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , 99 , -1 , -1 , -1 ,156 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113 , -1),
    (103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 ,109 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,111 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , 25 , 37 , -1 , -1 , -1 ,108 , -1 ,  0 ,  8 , -1 , -1 , -1 ,101 , 10 , -1 , 21 , -1 , -1 , -1 , 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (104 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,109 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,100 , -1 , -1 , 79 , -1 , -1 , 94 , -1 ,108 , 41 ,  0 , -1 , -1 , -1 ,102 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 ,  0 , 99 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (107 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,105 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 , 19 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (108 , -1 , -1 , 97 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (109 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,104 , -1 ,103 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 , 43 , 41 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (110 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (111 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (112 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,101 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 22 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (113 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,139 , -1 , -1 , -1 , -1 ,157 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60),
    (114 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , -1 , -1 , 19 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (115 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,113 , -1 ,139 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 94 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 96 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (116 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , 63 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 ,106 , -1 ,  8 , -1 , -1 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 61 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , 38 , -1 ,  2 , -1 , -1 , -1 , -1 , 60 , -1 , 78 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (117 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 ,124 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , 41 , -1 , -1 ,127 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 ,  0 , -1 , -1 ,123 , -1 , 57 ,120 , 43 , -1 , -1 , 63 ,101 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (118 , -1 ,127 , -1 , -1 , -1 , -1 , -1 ,120 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , 59 , -1 , -1 , -1 , -1 , 17 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , 43 ,126 , -1 ,117 , -1 ,129 , 67 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 ,  0 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , 60 ,  2 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , 49 , -1 , -1 , -1 , 35 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (119 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 69 , -1 , 64 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 , -1 , 62 , -1 , -1 ,126 , -1 ,118 , 41 ,120 , -1 , -1 , 52 , -1 , 38 , 47 , -1 , -1 , -1 , 36 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 ,  0 , 59 , -1 , -1 , -1 , -1 , -1 , 55 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (120 , -1 ,140 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , 57 , 59 , -1 , -1 , -1 ,127 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 44 , -1 , -1 , -1 , -1 , 66 ,129 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,126 , 41 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 ,117 , 48 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , -1 ,  2 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 ,  0 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , 29 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , 63 , 68 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , 52 , 10 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , 86 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (124 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , 60 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , -1 ,116 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 ,123 , -1 , -1 ,  8 , -1 , -1 , -1 , -1 , -1 , 78 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 66 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , 10 , -1 , -1 , -1 , -1 , -1 , 57 ,  0 ,  2 , -1 , -1 , 56 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,124 , -1 , -1 , 60 , 67 , -1 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , 86 , 29 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , -1 , -1 , -1 , -1 ,137 , 17 , 25 ,  0 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,122 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (126 , -1 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 62 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , 48 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , -1 ,120 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 , -1 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , -1 ,117 , 60 , -1 , -1 , -1 ,129 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 64 , 25 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , 69 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , 44 , -1 , -1 ,  8 , -1 , -1 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (129 , -1 ,117 , -1 , -1 , -1 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 67 , -1 , -1 , -1 , -1 , -1 , -1 , 60 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 ,118 , -1 , -1 ,  8 , 41 ,127 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,128 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 ,  2 , 63 , -1 ,116 , -1 , -1 , -1 , -1 ,133 , -1 , 68 , 77 ,  0 , -1 , 17 , -1 ,125 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (131 , -1 , -1 ,122 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 68 , -1 , -1 , -1 , -1 , -1 , -1 , 63 ,121 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 48 , -1 , -1 ,128 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 49 ,  3 ,133 , -1 , -1 , -1 , -1 , 66 , -1 ,  8 ,  0 , -1 ,123 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (132 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 16 , -1 , -1 , 90 , -1 , -1 , -1 , -1 , 91 , -1 , 54 , 37 , 79 , 43 , -1 , -1 , -1 , 39 , -1 ,135 , 76 , -1 , -1 , 52 , 55 , 87 , 49 ,133 , 36 , 50 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , 15 , -1 , 38 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , 51 , 81 , -1 , 29 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 53 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (133 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  3 , -1 , -1 , -1 , -1 , 48 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,130 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,131 , -1 , -1 , -1 , 62 ,126 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (134 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 53 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,135 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 , -1 , -1 , -1 , 34 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 56 , -1 , -1 , -1 , -1 , 87 , 10 , -1 , 55 , 47 , -1 , 61 , -1 , -1 , 58 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 , 77 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , 26 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (135 , -1 , -1 ,134 , -1 , -1 , -1 , -1 , -1 , -1 , 39 , -1 ,132 , -1 , -1 , 88 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 87 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , 55 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 36 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 12 , -1 ,  3 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 17 ,127 ,140 , -1 , -1 , -1 , -1 , 10 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 59 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 80 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,118 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 78 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 11 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 ,  0 , -1 , -1 , 12 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (138 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (139 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (140 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 , -1 ,143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,127 , -1 , 17 , -1 ,137 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,117 , 69 , -1 , -1 , 66 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 65 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 45 , -1 , -1 ,  0 , -1 , -1 , 28 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (141 , -1 ,156 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 23 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  2 , -1),
    (142 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 24 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (143 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,120 , -1 ,118 , 57 , 59 , -1 , -1 ,140 , -1 , -1 ,136 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , 45 , -1 , -1 , -1 , -1 , -1 , 66 , 65 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 43 , -1 , 41 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 51 , -1 , -1 , -1 , 48 ,157 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,141),
    (144 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 30 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 34 , 80 , -1 , 29 , 28 ,  8 , 35 , -1 , -1 , 25 , 31 , -1 , -1 , 89 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 93 , 26 , -1 , -1 , -1 ,102 , -1 , -1 , -1 , -1 , 38 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 84 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (145 , 25 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1 , -1 , -1 , 43 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (146 ,  8 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 , -1 , -1 , -1 , -1 , -1 ,147 , -1 ,148 , -1 , -1 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 35 ,  0 , 41 , 43 , 48 ,106 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (147 , 10 ,149 , -1 , -1 , -1 , -1 , -1 ,146 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  8 ,  0 , 41 ,  2 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (148 , 11 , -1 , -1 , -1 , -1 , -1 , -1 ,147 , -1 ,146 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 ,  8 ,  0 , 35 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (149 , 80 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,147 , -1 , -1 ,146 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 10 , 28 , 25 , -1 ,  0 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1),
    (150 , 56 , -1 , -1 , -1 , -1 , -1 , -1 ,152 , -1 ,153 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , 47 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,146 ,147 ,148 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 55 ,100 ,101 ,102 , 77 ,  0 , 25 ,  8 , 10 , 11 , 80 , -1 , -1),
    (151 , 55 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 46 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,152 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 ,145 , -1 , -1 , -1 , -1 ,146 , -1 ,148 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,147 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 47 , 52 , 77 , 54 , 37 ,  2 ,  0 , 35 , -1 , -1 , 10 , -1 , -1),
    (152 ,100 , -1 , -1 , -1 , -1 , -1 , -1 ,153 , -1 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 38 ,155 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 , -1 ,149 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 ,146 ,147 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 52 ,101 ,102 , -1 , 54 , 41 , -1 ,  0 ,  8 , 10 , 28 , -1 , -1),
    (153 ,101 , -1 , -1 , -1 , -1 , -1 , -1 ,154 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,155 , -1 , 37 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 ,152 , -1 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,149 ,145 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 ,146 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 77 ,102 , -1 , -1 , 76 , 43 , -1 , 41 ,  0 ,  8 , 25 , -1 , -1),
    (154 ,102 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 79 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,153 , -1 ,152 ,150 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,145 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 54 , -1 , -1 , -1 , -1 , 44 , -1 , 43 , 41 ,  0 , -1 , -1 , -1),
    (155 , 77 ,153 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 27 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 15 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,154 , -1 ,145 , -1 , -1 , -1 , -1 , -1 ,151 , -1 , -1 , -1 , -1 ,152 , -1 , -1 , -1 , -1 , -1 ,146 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,147 ,  1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 37 , 54 , 76 , -1 , -1 , -1 , 43 , 48 ,  2 , 35 ,  0 , -1 , -1),
    (156 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,141 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 75 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 44 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 25 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0 , -1),
    (157 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,139 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , 57 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 , -1 ,  0)
  );

const
  PowerTable : array[0..157] of
    record  Square, Cubic, Quartic, Quintic, Sextic: longint; end = (
    (Square:   0; Cubic:   0; Quartic:   0; Quintic:   0; Sextic:   0),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:   3; Cubic:   4; Quartic:   5; Quintic:   6; Sextic:   7),
    (Square:   5; Cubic:   7; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:   7; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  10; Cubic:  11; Quartic:  12; Quintic:  13; Sextic:  14),
    (Square:   8; Cubic:  -1; Quartic:  10; Quintic:  -1; Sextic:  11),
    (Square:  12; Cubic:  14; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  14; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  16; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  18; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  20; Cubic:  21; Quartic:  22; Quintic:  -1; Sextic:  -1),
    (Square:  22; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  26; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  34; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 132; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  39; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  41; Cubic:  42; Quartic:  43; Quintic:  -1; Sextic:  44),
    (Square:  43; Cubic:  44; Quartic:  45; Quintic:  -1; Sextic:  -1),
    (Square:  44; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  45; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 135; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 133; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  91; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  53; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square: 134; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  58; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  61; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1)
  );

const
  RootTable : array[0..157] of
    record  Square, Cubic, Quartic, Quintic, Sextic: longint; end = (
    (Square:   0; Cubic:   0; Quartic:   0; Quintic:   0; Sextic:   0),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:   2; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:   2; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:   3; Cubic:  -1; Quartic:   2; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:   2; Sextic:  -1),
    (Square:   4; Cubic:   3; Quartic:  -1; Quintic:  -1; Sextic:   2),
    (Square:   9; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:   8; Cubic:  -1; Quartic:   9; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:   8; Quartic:  -1; Quintic:  -1; Sextic:   9),
    (Square:  10; Cubic:  -1; Quartic:   8; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:   8; Sextic:  -1),
    (Square:  11; Cubic:  10; Quartic:  -1; Quintic:  -1; Sextic:   8),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  15; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  17; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  19; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  19; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  20; Cubic:  -1; Quartic:  19; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  25; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  28; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  38; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  40; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  40; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  41; Cubic:  -1; Quartic:  40; Quintic:  -1; Sextic:  -1),
    (Square:  42; Cubic:  41; Quartic:  -1; Quintic:  -1; Sextic:  40),
    (Square:  43; Cubic:  -1; Quartic:  41; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  52; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  57; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  60; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  49; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  37; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  48; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  55; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  47; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1),
    (Square:  -1; Cubic:  -1; Quartic:  -1; Quintic:  -1; Sextic:  -1)
  );

{ Power functions }

function SquarePower(const AQuantity: TAScalar): TAScalar;
function CubicPower(const AQuantity: TAScalar): TAScalar;
function QuarticPower(const AQuantity: TAScalar): TAScalar;
function QuinticPower(const AQuantity: TAScalar): TAScalar;
function SexticPower(const AQuantity: TAScalar): TAScalar;
function SquareRoot(const AQuantity: TAScalar): TAScalar;
function CubicRoot(const AQuantity: TAScalar): TAScalar;
function QuarticRoot(const AQuantity: TAScalar): TAScalar;
function QuinticRoot(const AQuantity: TAScalar): TAScalar;
function SexticRoot(const AQuantity: TAScalar): TAScalar;

{ Trigonometric functions }

function Cos(const AQuantity: TAScalar): double;
function Sin(const AQuantity: TAScalar): double;
function Tan(const AQuantity: TAScalar): double;
function Cotan(const AQuantity: TAScalar): double;
function Secant(const AQuantity: TAScalar): double;
function Cosecant(const AQuantity: TAScalar): double;

function ArcCos(const AQuantity: double): TAScalar;
function ArcSin(const AQuantity: double): TAScalar;
function ArcTan(const AQuantity: double): TAScalar;
function ArcTan2(const x, y: double): TAScalar;

{ Math functions }

function Min(const ALeft, ARight: TAScalar): TAScalar;
function Max(const ALeft, ARight: TAScalar): TAScalar;
function Exp(const AQuantity: TAScalar): TAScalar;

function Log10(const AQuantity : TAScalar) : double;
function Log2(const AQuantity : TAScalar) : double;
function LogN(ABase: longint; const AQuantity: TAScalar): double;
function LogN(const ABase, AQuantity: TAScalar): double;

function Power(const ABase: TAScalar; AExponent: double): double;

{ Helper functions }

function LessThanOrEqualToZero(const AQuantity: TAScalar): boolean;
function LessThanZero(const AQuantity: TAScalar): boolean;
function EqualToZero(const AQuantity: TAScalar): boolean;
function NotEqualToZero(const AQuantity: TAScalar): boolean;
function GreaterThanOrEqualToZero(const AQuantity: TAScalar): boolean;
function GreaterThanZero(const AQuantity: TAScalar): boolean;
function SameValue(const ALeft, ARight: TAScalar): boolean;

{ Constants }

const
  AvogadroConstant               : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cReciprocalMole;                     FValue:       6.02214076E+23); {$ELSE} (      6.02214076E+23); {$ENDIF}
  BohrMagneton                   : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cSquareMeterAmpere;                  FValue:     9.2740100657E-24); {$ELSE} (    9.2740100657E-24); {$ENDIF}
  BohrRadius                     : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeter;                              FValue:    5.29177210903E-11); {$ELSE} (   5.29177210903E-11); {$ENDIF}
  BoltzmannConstant              : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cJoulePerKelvin;                     FValue:         1.380649E-23); {$ELSE} (        1.380649E-23); {$ENDIF}
  ComptonWaveLength              : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeter;                              FValue:    2.42631023867E-12); {$ELSE} (   2.42631023867E-12); {$ENDIF}
  CoulombConstant                : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cNewtonSquareMeterPerSquareCoulomb;  FValue:      8.9875517923E+9); {$ELSE} (     8.9875517923E+9); {$ENDIF}
  DeuteronMass                   : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:     3.3435837768E-27); {$ELSE} (    3.3435837768E-27); {$ENDIF}
  ElectricPermittivity           : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cFaradPerMeter;                      FValue:     8.8541878128E-12); {$ELSE} (    8.8541878128E-12); {$ENDIF}
  ElectronMass                   : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:     9.1093837015E-31); {$ELSE} (    9.1093837015E-31); {$ENDIF}
  ElectronCharge                 : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cCoulomb;                            FValue:      1.602176634E-19); {$ELSE} (     1.602176634E-19); {$ENDIF}
  MagneticPermeability           : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cHenryPerMeter;                      FValue:     1.25663706212E-6); {$ELSE} (    1.25663706212E-6); {$ENDIF}
  MolarGasConstant               : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cJoulePerMolePerKelvin;              FValue:          8.314462618); {$ELSE} (         8.314462618); {$ENDIF}
  NeutronMass                    : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:    1.67492750056E-27); {$ELSE} (   1.67492750056E-27); {$ENDIF}
  NewtonianConstantOfGravitation : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cNewtonSquareMeterPerSquareKilogram; FValue:          6.67430E-11); {$ELSE} (         6.67430E-11); {$ENDIF}
  PlanckConstant                 : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogramSquareMeterPerSecond;       FValue:       6.62607015E-34); {$ELSE} (      6.62607015E-34); {$ENDIF}
  ProtonMass                     : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:    1.67262192595E-27); {$ELSE} (   1.67262192595E-27); {$ENDIF}
  RydbergConstant                : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cReciprocalMeter;                    FValue:      10973731.568157); {$ELSE} (     10973731.568157); {$ENDIF}
  SpeedOfLight                   : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeterPerSecond;                     FValue:            299792458); {$ELSE} (           299792458); {$ENDIF}
  SquaredSpeedOfLight            : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cSquareMeterPerSquareSecond;         FValue: 8.98755178736818E+16); {$ELSE} (8.98755178736818E+16); {$ENDIF}
  StandardAccelerationOfGravity  : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cMeterPerSquareSecond;               FValue:              9.80665); {$ELSE} (             9.80665); {$ENDIF}
  ReducedPlanckConstant          : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogramSquareMeterPerSecond;       FValue:  6.62607015E-34/2/pi); {$ELSE} ( 6.62607015E-34/2/pi); {$ENDIF}
  UnifiedAtomicMassUnit          : TAScalar = {$IFDEF USEADIM} (FUnitOfMeasurement: cKilogram;                           FValue:    1.66053906892E-27); {$ELSE} (   1.66053906892E-27); {$ENDIF}

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

implementation

uses Math;

{ TAScalar }

{$IFDEF USEADIM}
class operator TAScalar.:=(const ASelf: double): TAScalar;
begin
  result.FUnitOfMeasurement := cScalar;
  result.FValue := ASelf;
end;

class operator TAScalar.+(const ASelf: TAScalar): TAScalar;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := ASelf.FValue;
end;

class operator TAScalar.-(const ASelf: TAScalar): TAScalar;
begin
  result.FUnitOfMeasurement := ASelf.FUnitOfMeasurement;
  result.FValue := -ASelf.FValue;
end;

class operator TAScalar.+(const ALeft, ARight: TAScalar): TAScalar;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Summing operator (+) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue + ARight.FValue;
end;

class operator TAScalar.-(const ALeft, ARight: TAScalar): TAScalar;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Subtracting operator (-) has detected wrong unit of measurements.');

  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue := ALeft.FValue - ARight.FValue;
end;

class operator TAScalar.*(const ALeft, ARight: TAScalar): TAScalar;
begin
  result.FUnitOfMeasurement := MulTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue * ARight.FValue;
end;

class operator TAScalar./(const ALeft, ARight: TAScalar): TAScalar;
begin
  result.FUnitOfMeasurement := DivTable[ALeft.FUnitOfMeasurement, ARight.FUnitOfMeasurement];
  result.FValue := ALeft.FValue / ARight.FValue;
end;

class operator TAScalar.*(const ALeft: double; const ARight: TAScalar): TAScalar;
begin
  result.FUnitOfMeasurement := ARight.FUnitOfMeasurement;
  result.FValue:= ALeft * ARight.FValue;
end;

class operator TAScalar./(const ALeft: double; const ARight: TAScalar): TAScalar;
begin
  result.FUnitOfMeasurement := DivTable[cScalar, ARight.FUnitOfMeasurement];
  result.FValue:= ALeft / ARight.FValue;
end;

class operator TAScalar.*(const ALeft: TAScalar; const ARight: double): TAScalar;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue:= ALeft.FValue * ARight;
end;

class operator TAScalar./(const ALeft: TAScalar; const ARight: double): TAScalar;
begin
  result.FUnitOfMeasurement := ALeft.FUnitOfMeasurement;
  result.FValue:= ALeft.FValue / ARight;
end;

class operator TAScalar.=(const ALeft, ARight: TAScalar): boolean; inline;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Equal operator (=) has detected wrong unit of measurements.');

  result := ALeft.FValue = ARight.FValue;
end;

class operator TAScalar.<(const ALeft, ARight: TAScalar): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('LessThan operator (<) has detected wrong unit of measurements.');

  result := ALeft.FValue < ARight.FValue;
end;

class operator TAScalar.>(const ALeft, ARight: TAScalar): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('GreaterThan operator (>) has detected wrong unit of measurements.');

  result := ALeft.FValue > ARight.FValue;
end;

class operator TAScalar.<=(const ALeft, ARight: TAScalar): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('LessThanOrEqual operator (<=) has detected wrong unit of measurements.');

  result := ALeft.FValue <= ARight.FValue;
end;

class operator TAScalar.>=(const ALeft, ARight: TAScalar): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('GreaterThanOrEqual operator (>=) has detected wrong unit of measurements.');

  result := ALeft.FValue >= ARight.FValue;
end;

class operator TAScalar.<>(const ALeft, ARight: TAScalar): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('NotEqual operator (<>) has detected wrong unit of measurements.');

  result := ALeft.FValue <> ARight.FValue;
end;
{$ENDIF}

{ TUnit }

class operator TUnit.*(const AQuantity: double; const ASelf: TUnit): TAScalar; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := U.FUnitOfMeasurement;
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

class operator TUnit./(const AQuantity: double; const ASelf: TUnit): TAScalar; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := AQuantity;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

{$IFDEF USEADIM}
class operator TUnit.*(const AQuantity: TAScalar; const ASelf: TUnit): TAScalar; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;

class operator TUnit./(const AQuantity: TAScalar; const ASelf: TUnit): TAScalar; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AQuantity.FValue;
end;
{$ENDIF}

function TUnit.GetName(const Prefixes: TPrefixes): string;
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

function TUnit.GetPluralName(const Prefixes: TPrefixes): string;
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

function TUnit.GetSymbol(const Prefixes: TPrefixes): string;
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

function TUnit.GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
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
      result := AQuantity * IntPower(10, Exponent)
    else
      result := AQuantity;

  end else
    if PrefixCount = 0 then
      result := AQuantity
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

procedure TUnit.Check(var AQuantity: TAScalar);
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TUnit.ToFloat(const AQuantity: TAScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnit.ToFloat(const AQuantity: TAScalar; const APrefixes: TPrefixes): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnit.ToString(const AQuantity: TAScalar): string;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(AQuantity.FValue) + ' ' + GetSymbol(U.FPrefixes);
{$ELSE}
  result := FloatToStr(AQuantity) + ' ' + GetSymbol(U.FPrefixes);
{$ENDIF}
end;

function TUnit.ToString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
     result := FloatToStr(FactoredValue) + ' ' + GetSymbol(U.FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TUnit.ToString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(U.FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TUnit.ToString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF USEADIM}
  if (AQuantity.FUnitOfMeasurement  <> U.FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> U.FUnitOfMeasurement) then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

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

function TUnit.ToVerboseString(const AQuantity: TAScalar): string;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

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

function TUnit.ToVerboseString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

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

function TUnit.ToVerboseString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
{$ENDIF}

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

function TUnit.ToVerboseString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF USEADIM}
  if (AQuantity.FUnitOfMeasurement  <> U.FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> U.FUnitOfMeasurement) then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(AQuantity.FValue, APrefixes);
  FactoredTol   := GetValue(ATolerance.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);
{$ENDIF}

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

{ TFactoredUnit }

class operator TFactoredUnit.*(const AQuantity: double; const ASelf: TFactoredUnit): TAScalar; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := U.FUnitOfMeasurement;
  result.FValue := U.PutValue(AQuantity);
{$ELSE}
  result := U.PutValue(AQuantity);
{$ENDIF}
end;

class operator TFactoredUnit./(const AQuantity: double; const ASelf: TFactoredUnit): TAScalar; inline;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := U.PutValue(AQuantity);
{$ELSE}
  result := U.PutValue(AQuantity);
{$ENDIF}
end;

{$IFDEF USEADIM}
class operator TFactoredUnit.*(const AQuantity: TAScalar; const ASelf: TFactoredUnit): TAScalar; inline;
begin
  result.FUnitOfMeasurement := MulTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := U.PutValue(AQuantity.FValue);
end;

class operator TFactoredUnit./(const AQuantity: TAScalar; const ASelf: TFactoredUnit): TAScalar; inline;
begin
  result.FUnitOfMeasurement := DivTable[AQuantity.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := U.PutValue(AQuantity.FValue);
end;
{$ENDIF}

function TFactoredUnit.GetName(const Prefixes: TPrefixes): string;
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

function TFactoredUnit.GetPluralName(const Prefixes: TPrefixes): string;
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

function TFactoredUnit.GetSymbol(const Prefixes: TPrefixes): string;
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

function TFactoredUnit.GetValue(const AQuantity: double; const APrefixes: TPrefixes): double;
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
      result := AQuantity * IntPower(10, Exponent)
    else
      result := AQuantity;

  end else
    if PrefixCount = 0 then
      result := AQuantity
    else
      raise Exception.Create('Wrong number of prefixes.');
end;

procedure TFactoredUnit.Check(var AQuantity: TAScalar);
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Check routine has detected wrong units of measurements.');
{$ENDIF}
end;

function TFactoredUnit.ToFloat(const AQuantity: TAScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := U.GetValue(AQuantity.FValue);
{$ELSE}
  result := U.GetValue(AQuantity);
{$ENDIF}
end;

function TFactoredUnit.ToFloat(const AQuantity: TAScalar; const APrefixes: TPrefixes): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToFloat routine has detected wrong units of measurements.');

  result := GetValue(U.GetValue(AQuantity.FValue), APrefixes);
{$ELSE}
  result := GetValue(U.GetValue(AQuantity), APrefixes);
{$ENDIF}
end;

function TFactoredUnit.ToString(const AQuantity: TAScalar): string;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  result := FloatToStr(U.GetValue(AQuantity.FValue)) + ' ' + GetSymbol(U.FPrefixes);
{$ELSE}
  result := FloatToStr(U.GetValue(AQuantity)) + ' ' + GetSymbol(U.FPrefixes);
{$ENDIF}
end;

function TFactoredUnit.ToString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(U.GetValue(AQuantity.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(U.GetValue(AQuantity), APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(U.FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnit.ToString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

    FactoredValue := GetValue(U.GetValue(AQuantity.FValue), APrefixes);
{$ELSE}
    FactoredValue := GetValue(U.GetValue(AQuantity), APrefixes);
{$ENDIF}

  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(U.FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(APrefixes);
end;

function TFactoredUnit.ToString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF USEADIM}
  if (AQuantity.FUnitOfMeasurement  <> U.FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> U.FUnitOfMeasurement) then
    raise Exception.Create('ToString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(U.GetValue(AQuantity.FValue), APrefixes);
  FactoredTol   := GetValue(U.GetValue(ATolerance.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(U.GetValue(AQuantity), APrefixes);
  FactoredTol   := GetValue(U.GetValue(ATolerance), APrefixes);
{$ENDIF}

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

function TFactoredUnit.ToVerboseString(const AQuantity: TAScalar): string;
var
  FactoredValue: double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := U.GetValue(AQuantity.FValue);
{$ELSE}
  FactoredValue := U.GetValue(AQuantity);
{$ENDIF}

  if (FactoredValue > -1) and (FactoredValue < 1) then
    result := FloatToStr(FactoredValue) + ' ' + GetName(U.FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetPluralName(U.FPrefixes);
end;

function TFactoredUnit.ToVerboseString(const AQuantity: TAScalar; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(U.GetValue(AQuantity.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(U.GetValue(AQuantity), APrefixes);
{$ENDIF}

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

function TFactoredUnit.ToVerboseString(const AQuantity: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(U.GetValue(AQuantity.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(U.GetValue(AQuantity), APrefixes);
{$ENDIF}

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

function TFactoredUnit.ToVerboseString(const AQuantity, ATolerance: TAScalar; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
{$IFDEF USEADIM}
  if (AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement) or (ATolerance.FUnitOfMeasurement <> U.FUnitOfMeasurement) then
    raise Exception.Create('ToVerboseString routine has detected wrong units of measurements.');

  FactoredValue := GetValue(U.GetValue(AQuantity.FValue), APrefixes);
  FactoredTol   := GetValue(U.GetValue(ATolerance.FValue), APrefixes);
{$ELSE}
  FactoredValue := GetValue(U.GetValue(AQuantity), APrefixes);
  FactoredTol   := GetValue(U.GetValue(ATolerance), APrefixes);
{$ENDIF}

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

class  function TDegreeRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (Pi/180);
end;

class  function TDegreeRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (Pi/180);
end;

class  function TSquareDegreeRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (Pi*Pi/32400);
end;

class  function TSquareDegreeRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (Pi*Pi/32400);
end;

class  function TDayRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (86400);
end;

class  function TDayRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (86400);
end;

class  function THourRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (3600);
end;

class  function THourRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (3600);
end;

class  function TMinuteRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (60);
end;

class  function TMinuteRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (60);
end;

class  function TSquareDayRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (7464960000);
end;

class  function TSquareDayRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (7464960000);
end;

class  function TSquareHourRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (12960000);
end;

class  function TSquareHourRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (12960000);
end;

class  function TSquareMinuteRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (3600);
end;

class  function TSquareMinuteRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (3600);
end;

class  function TAstronomicalRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (149597870691);
end;

class  function TAstronomicalRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (149597870691);
end;

class  function TInchRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (0.0254);
end;

class  function TInchRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (0.0254);
end;

class  function TFootRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (0.3048);
end;

class  function TFootRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (0.3048);
end;

class  function TYardRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (0.9144);
end;

class  function TYardRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (0.9144);
end;

class  function TMileRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (1609.344);
end;

class  function TMileRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (1609.344);
end;

class  function TNauticalMileRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (1852);
end;

class  function TNauticalMileRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (1852);
end;

class  function TAngstromRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (1E-10);
end;

class  function TAngstromRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (1E-10);
end;

class  function TSquareInchRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (0.00064516);
end;

class  function TSquareInchRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (0.00064516);
end;

class  function TSquareFootRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (0.09290304);
end;

class  function TSquareFootRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (0.09290304);
end;

class  function TSquareYardRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (0.83612736);
end;

class  function TSquareYardRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (0.83612736);
end;

class  function TSquareMileRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (2589988.110336);
end;

class  function TSquareMileRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (2589988.110336);
end;

class  function TCubicInchRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (0.000016387064);
end;

class  function TCubicInchRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (0.000016387064);
end;

class  function TCubicFootRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (0.028316846592);
end;

class  function TCubicFootRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (0.028316846592);
end;

class  function TCubicYardRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (0.764554857984);
end;

class  function TCubicYardRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (0.764554857984);
end;

class  function TLitreRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (1E-03);
end;

class  function TLitreRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (1E-03);
end;

class  function TGallonRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (0.0037854119678);
end;

class  function TGallonRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (0.0037854119678);
end;

class  function TTonneRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (1E+03);
end;

class  function TTonneRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (1E+03);
end;

class  function TPoundRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (0.45359237);
end;

class  function TPoundRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (0.45359237);
end;

class  function TOunceRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (0.028349523125);
end;

class  function TOunceRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (0.028349523125);
end;

class  function TStoneRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (6.35029318);
end;

class  function TStoneRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (6.35029318);
end;

class  function TTonRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (907.18474);
end;

class  function TTonRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (907.18474);
end;

class  function TElectronvoltPerSquareSpeedOfLightRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (1.7826619216279E-36);
end;

class  function TElectronvoltPerSquareSpeedOfLightRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (1.7826619216279E-36);
end;

class function TDegreeCelsiusRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue + 273.15;
end;

class function TDegreeCelsiusRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue - 273.15;
end;

class function TDegreeFahrenheitRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := 5/9 * (AValue - 32) + 273.15;
end;

class function TDegreeFahrenheitRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := 9/5 * AValue - 459.67;
end;

class  function TMeterPerHourRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (1/3600);
end;

class  function TMeterPerHourRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (1/3600);
end;

class  function TMilePerHourRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (0.44704);
end;

class  function TMilePerHourRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (0.44704);
end;

class  function TNauticalMilePerHourRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (463/900);
end;

class  function TNauticalMilePerHourRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (463/900);
end;

class  function TMeterPerHourPerSecondRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (1/3600);
end;

class  function TMeterPerHourPerSecondRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (1/3600);
end;

class  function TPoundPerCubicInchRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (27679.9047102031);
end;

class  function TPoundPerCubicInchRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (27679.9047102031);
end;

class  function TPoundForceRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (4.4482216152605);
end;

class  function TPoundForceRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (4.4482216152605);
end;

class  function TBarRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (1E+05);
end;

class  function TBarRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (1E+05);
end;

class  function TPoundPerSquareInchRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (6894.75729316836);
end;

class  function TPoundPerSquareInchRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (6894.75729316836);
end;

class  function TWattHourRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (3600);
end;

class  function TWattHourRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (3600);
end;

class  function TElectronvoltRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (1.602176634E-019);
end;

class  function TElectronvoltRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (1.602176634E-019);
end;

class  function TPoundForceInchRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (0.112984829027617);
end;

class  function TPoundForceInchRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (0.112984829027617);
end;

class  function TRydbergRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (2.1798723611035E-18);
end;

class  function TRydbergRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (2.1798723611035E-18);
end;

class  function TCalorieRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (4.184);
end;

class  function TCalorieRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (4.184);
end;

class  function TJoulePerDegreeRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (180/Pi);
end;

class  function TJoulePerDegreeRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (180/Pi);
end;

class  function TNewtonMeterPerDegreeRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (180/Pi);
end;

class  function TNewtonMeterPerDegreeRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (180/Pi);
end;

class  function TAmpereHourRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (3600);
end;

class  function TAmpereHourRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (3600);
end;

class  function TPoundForcePerInchRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (175.126835246476);
end;

class  function TPoundForcePerInchRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (175.126835246476);
end;

class  function TElectronvoltSecondRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (1.60217742320523E-019);
end;

class  function TElectronvoltSecondRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (1.60217742320523E-019);
end;

class  function TElectronvoltMeterPerSpeedOfLightRec.PutValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue * (1.7826619216279E-36);
end;

class  function TElectronvoltMeterPerSpeedOfLightRec.GetValue(const AValue: double): double;
begin
{$IFDEF USEADIM}
{$ENDIF}
  result := AValue / (1.7826619216279E-36);
end;

{ Power functions }

function SquarePower(const AQuantity: TAScalar): TAScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Square;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AQuantity.FValue, 2);
{$ELSE}
  result := IntPower(AQuantity, 2);
{$ENDIF}
end;

function CubicPower(const AQuantity: TAScalar): TAScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Cubic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AQuantity.FValue, 3);
{$ELSE}
  result := IntPower(AQuantity, 3);
{$ENDIF}
end;

function QuarticPower(const AQuantity: TAScalar): TAScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Quartic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AQuantity.FValue, 4);
{$ELSE}
  result := IntPower(AQuantity, 4);
{$ENDIF}
end;

function QuinticPower(const AQuantity: TAScalar): TAScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Quintic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AQuantity.FValue, 5);
{$ELSE}
  result := IntPower(AQuantity, 5);
{$ENDIF}
end;

function SexticPower(const AQuantity: TAScalar): TAScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := PowerTable[AQuantity.FUnitOfMeasurement].Sextic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
   result.FValue := IntPower(AQuantity.FValue, 6);
{$ELSE}
  result := IntPower(AQuantity, 6);
{$ENDIF}
end;

function SquareRoot(const AQuantity: TAScalar): TAScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Square;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/2);
{$ELSE};
  result := Power(AQuantity, 1/2);
{$ENDIF}
end;

function CubicRoot(const AQuantity: TAScalar): TAScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Cubic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/3);
{$ELSE}
  result := Power(AQuantity, 1/3);
{$ENDIF}
end;

function QuarticRoot(const AQuantity: TAScalar): TAScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Quartic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/4);
{$ELSE}
  result := Power(AQuantity, 1/4);
{$ENDIF}
end;

function QuinticRoot(const AQuantity: TAScalar): TAScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Quintic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/5);
{$ELSE}
  result := Power(AQuantity, 1/5);
{$ENDIF}
end;

function SexticRoot(const AQuantity: TAScalar): TAScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := RootTable[AQuantity.FUnitOfMeasurement].Sextic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AQuantity.FValue, 1/6);
{$ELSE}
  result := Power(AQuantity, 1/6);
{$ENDIF}
end;

{ Trigonometric functions }

function Cos(const AQuantity: TAScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Cos routine has detected wrong units of measurements.');

  result := System.Cos(AQuantity.FValue);
{$ELSE}
  result := System.Cos(AQuantity);
{$ENDIF}
end;

function Sin(const AQuantity: TAScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Sin routine has detected wrong units of measurements.');

  result := System.Sin(AQuantity.FValue);
{$ELSE}
  result := System.Sin(AQuantity);
{$ENDIF}
end;

function Tan(const AQuantity: TAScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Tan routine has detected wrong units of measurements.');

  result := Math.Tan(AQuantity.FValue);
{$ELSE}
  result := Math.Tan(AQuantity);
{$ENDIF}
end;

function Cotan(const AQuantity: TAScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Cotan routine has detected wrong units of measurements.');

  result := Math.Cotan(AQuantity.FValue);
{$ELSE}
  result := Math.Cotan(AQuantity);
{$ENDIF}
end;

function Secant(const AQuantity: TAScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Setan routine has detected wrong units of measurements.');

  result := Math.Secant(AQuantity.FValue);
{$ELSE}
  result := Math.Secant(AQuantity);
{$ENDIF}
end;

function Cosecant(const AQuantity: TAScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Cosecant routine has detected wrong units of measurements.');

  result := Math.Cosecant(AQuantity.FValue);
{$ELSE}
  result := Math.Cosecant(AQuantity);
{$ENDIF}
end;

function ArcCos(const AQuantity: double): TAScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcCos(AQuantity);
{$ELSE}
  result := Math.ArcCos(AQuantity);
{$ENDIF}
end;

function ArcSin(const AQuantity: double): TAScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcSin(AQuantity);
{$ELSE}
  result := Math.ArcSin(AQuantity);
{$ENDIF}
end;

function ArcTan(const AQuantity: double): TAScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := System.ArcTan(AQuantity);
{$ELSE}
  result := System.ArcTan(AQuantity);
{$ENDIF}
end;

function ArcTan2(const x, y: double): TAScalar;
begin
{$IFDEF USEADIM}
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcTan2(x, y);
{$ELSE}
  result := Math.ArcTan2(x, y);
{$ENDIF}
end;

{ Math functions }

function Min(const ALeft, ARight: TAScalar): TAScalar;
begin
{$IFDEF USEADIM}
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Min routine has detected wrong units of measurements.');

  result.FUnitOfMeasurement := ARight.FUnitOfMeasurement;
  result.FValue := Math.Min(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.Min(ALeft, ARight);
{$ENDIF}
end;

function Max(const ALeft, ARight: TAScalar): TAScalar;
begin
{$IFDEF USEADIM}
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Max routine has detected wrong units of measurements.');

  result.FUnitOfMeasurement := ARight.FUnitOfMeasurement;
  result.FValue := Math.Max(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.Max(ALeft, ARight);
{$ENDIF}
end;

function Exp(const AQuantity: TAScalar): TAScalar;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Exp routine has detected wrong units of measurements.');

  result.FUnitOfMeasurement := cScalar;
  result.FValue := System.Exp(AQuantity.FValue);
{$ELSE}
  result := System.Exp(AQuantity);
{$ENDIF}
end;

function Log10(const AQuantity : TAScalar) : double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Log10 routine has detected wrong units of measurements.');

  result := Math.Log10(AQuantity.FValue);
{$ELSE}
  result := Math.Log10(AQuantity);
{$ENDIF}
end;

function Log2(const AQuantity : TAScalar) : double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Log2 routine has detected wrong units of measurements.');

  result := Math.Log2(AQuantity.FValue);
{$ELSE}
  result := Math.Log2(AQuantity);
{$ENDIF}
end;

function LogN(ABase: longint; const AQuantity: TAScalar): double;
begin
{$IFDEF USEADIM}
  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  result := Math.LogN(ABase, AQuantity.FValue);
{$ELSE}
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function LogN(const ABase, AQuantity: TAScalar): double;
begin
{$IFDEF USEADIM}
  if ABase.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  if AQuantity.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('LogN routine has detected wrong units of measurements.');

  result := Math.LogN(ABase.FValue, AQuantity.FValue);
{$ELSE}
  result := Math.LogN(ABase, AQuantity);
{$ENDIF}
end;

function Power(const ABase: TAScalar; AExponent: double): double;
begin
{$IFDEF USEADIM}
  if ABase.FUnitOfMeasurement <> cScalar then
    raise Exception.Create('Power routine has detected wrong units of measurements.');

   result := Math.Power(ABase.FValue, AExponent);
{$ELSE}
  result := Math.Power(ABase, AExponent);
{$ENDIF}
end;

{ Helper functions }

function LessThanOrEqualToZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue <= 0;
{$ELSE}
  result := AQuantity <= 0;
{$ENDIF}
end;

function LessThanZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue < 0;
{$ELSE}
  result := AQuantity < 0;
{$ENDIF}
end;

function EqualToZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue = 0;
{$ELSE}
  result := AQuantity = 0;
{$ENDIF}
end;

function NotEqualToZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue <> 0;
{$ELSE}
  result := AQuantity <> 0;
{$ENDIF}
end;

function GreaterThanOrEqualToZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue >= 0;
{$ELSE}
  result := AQuantity >= 0;
{$ENDIF}
end;

function GreaterThanZero(const AQuantity: TAScalar): boolean;
begin
{$IFDEF USEADIM}
  result := AQuantity.FValue > 0;
{$ELSE}
  result := AQuantity > 0;
{$ENDIF}
end;

function SameValue(const ALeft, ARight: TAScalar): boolean;
begin
{$IFDEF USEADIM}
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('SameValue routine has detected wrong units of measurements.');

  result := Math.SameValue(ALeft.FValue, ARight.FValue);
{$ELSE}
  result := Math.SameValue(ALeft, ARight);
{$ENDIF}
end;

end.
