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
  ADimRT library built on 19/10/2024.

  Number of base units: 160
  Number of factored units: 120
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

  generic TUnit<U> = record
    type TSelf = specialize TUnit<U>;
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
    class operator *(const AValue: TQuantity; const ASelf: TSelf): TQuantity; inline;
    class operator /(const AValue: TQuantity; const ASelf: TSelf): TQuantity; inline;
  {$ENDIF}
  end;

  { TFactoredUnit }

  generic TFactoredUnit<U> = record
    type TSelf = specialize TFactoredUnit<U>;
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
    class operator *(const AValue: TQuantity; const ASelf: TSelf): TQuantity; inline;
    class operator /(const AValue: TQuantity; const ASelf: TSelf): TQuantity; inline;
  {$ENDIF}
  end;

{ TScalar }

const
  cScalar = 0;

type
  TScalar = record
    const FUnitOfMeasurement = cScalar;
    const FSymbol            = '';
    const FName              = '';
    const FPluralName        = '';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
  end;
  TScalarUnit = specialize TUnit<TScalar>;

{ TRadian }

type
  TRadian = record
    const FUnitOfMeasurement = cScalar;
    const FSymbol            = 'rad';
    const FName              = 'radian';
    const FPluralName        = 'radians';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
  end;
  TRadianUnit = specialize TUnit<TRadian>;

var
  rad        : TRadianUnit;

{ TDegree }

type
  TDegree = record
    const FUnitOfMeasurement = cScalar;
    const FSymbol            = 'deg';
    const FName              = 'degree';
    const FPluralName        = 'degrees';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TDegreeUnit = specialize TUnit<TDegree>;

const
  deg        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 0; FValue: Pi/180); {$ELSE} (Pi/180); {$ENDIF}

{ TSteradian }

type
  TSteradian = record
    const FUnitOfMeasurement = cScalar;
    const FSymbol            = 'sr';
    const FName              = 'steradian';
    const FPluralName        = 'steradians';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
  end;
  TSteradianUnit = specialize TUnit<TSteradian>;

var
  sr         : TSteradianUnit;

{ TSquareDegree }

type
  TSquareDegree = record
    const FUnitOfMeasurement = cScalar;
    const FSymbol            = 'deg2';
    const FName              = 'square degree';
    const FPluralName        = 'square degrees';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TSquareDegreeUnit = specialize TUnit<TSquareDegree>;

const
  deg2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 0; FValue: Pi*Pi/32400); {$ELSE} (Pi*Pi/32400); {$ENDIF}

{ TSecond }

const
  cSecond = 1;

type
  TSecond = record
    const FUnitOfMeasurement = cSecond;
    const FSymbol            = '%ss';
    const FName              = '%ssecond';
    const FPluralName        = '%sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TSecondUnit = specialize TUnit<TSecond>;

var
  s          : TSecondUnit;

const
  ds         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 1E-01); {$ELSE} (1E-01); {$ENDIF}
  cs         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  ms         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  mis        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  ns         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  ps         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TDay }

type
  TDay = record
    const FUnitOfMeasurement = cSecond;
    const FSymbol            = 'd';
    const FName              = 'day';
    const FPluralName        = 'days';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TDayUnit = specialize TUnit<TDay>;

const
  day        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 86400); {$ELSE} (86400); {$ENDIF}

{ THour }

type
  THour = record
    const FUnitOfMeasurement = cSecond;
    const FSymbol            = 'h';
    const FName              = 'hour';
    const FPluralName        = 'hours';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  THourUnit = specialize TUnit<THour>;

const
  hr         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 3600); {$ELSE} (3600); {$ENDIF}

{ TMinute }

type
  TMinute = record
    const FUnitOfMeasurement = cSecond;
    const FSymbol            = 'min';
    const FName              = 'minute';
    const FPluralName        = 'minutes';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TMinuteUnit = specialize TUnit<TMinute>;

const
  minute     : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 1; FValue: 60); {$ELSE} (60); {$ENDIF}

{ TSquareSecond }

const
  cSquareSecond = 2;

type
  TSquareSecond = record
    const FUnitOfMeasurement = cSquareSecond;
    const FSymbol            = '%ss2';
    const FName              = 'square %ssecond';
    const FPluralName        = 'square %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareSecondUnit = specialize TUnit<TSquareSecond>;

var
  s2         : TSquareSecondUnit;

const
  ds2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  cs2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 1E-04); {$ELSE} (1E-04); {$ENDIF}
  ms2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  mis2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}
  ns2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 1E-18); {$ELSE} (1E-18); {$ENDIF}
  ps2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 1E-24); {$ELSE} (1E-24); {$ENDIF}

{ TSquareDay }

type
  TSquareDay = record
    const FUnitOfMeasurement = cSquareSecond;
    const FSymbol            = 'd2';
    const FName              = 'square day';
    const FPluralName        = 'square days';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TSquareDayUnit = specialize TUnit<TSquareDay>;

const
  day2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 7464960000); {$ELSE} (7464960000); {$ENDIF}

{ TSquareHour }

type
  TSquareHour = record
    const FUnitOfMeasurement = cSquareSecond;
    const FSymbol            = 'h2';
    const FName              = 'square hour';
    const FPluralName        = 'square hours';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TSquareHourUnit = specialize TUnit<TSquareHour>;

const
  hr2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 12960000); {$ELSE} (12960000); {$ENDIF}

{ TSquareMinute }

type
  TSquareMinute = record
    const FUnitOfMeasurement = cSquareSecond;
    const FSymbol            = 'min2';
    const FName              = 'square minute';
    const FPluralName        = 'square minutes';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TSquareMinuteUnit = specialize TUnit<TSquareMinute>;

const
  minute2    : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 2; FValue: 3600); {$ELSE} (3600); {$ENDIF}

{ TCubicSecond }

const
  cCubicSecond = 3;

type
  TCubicSecond = record
    const FUnitOfMeasurement = cCubicSecond;
    const FSymbol            = '%ss3';
    const FName              = 'cubic %ssecond';
    const FPluralName        = 'cubic %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (3);
  end;
  TCubicSecondUnit = specialize TUnit<TCubicSecond>;

var
  s3         : TCubicSecondUnit;

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
  TQuarticSecond = record
    const FUnitOfMeasurement = cQuarticSecond;
    const FSymbol            = '%ss4';
    const FName              = 'quartic %ssecond';
    const FPluralName        = 'quartic %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (4);
  end;
  TQuarticSecondUnit = specialize TUnit<TQuarticSecond>;

var
  s4         : TQuarticSecondUnit;

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
  TQuinticSecond = record
    const FUnitOfMeasurement = cQuinticSecond;
    const FSymbol            = '%ss5';
    const FName              = 'quintic %ssecond';
    const FPluralName        = 'quintic %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (5);
  end;
  TQuinticSecondUnit = specialize TUnit<TQuinticSecond>;

var
  s5         : TQuinticSecondUnit;

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
  TSexticSecond = record
    const FUnitOfMeasurement = cSexticSecond;
    const FSymbol            = '%ss6';
    const FName              = 'sextic %ssecond';
    const FPluralName        = 'sextic %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (6);
  end;
  TSexticSecondUnit = specialize TUnit<TSexticSecond>;

var
  s6         : TSexticSecondUnit;

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
  TMeter = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = '%sm';
    const FName              = '%smeter';
    const FPluralName        = '%smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TMeterUnit = specialize TUnit<TMeter>;

var
  m          : TMeterUnit;

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
  TAstronomical = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = 'au';
    const FName              = 'astronomical unit';
    const FPluralName        = 'astronomical units';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TAstronomicalUnit = specialize TUnit<TAstronomical>;

const
  au         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 149597870691); {$ELSE} (149597870691); {$ENDIF}

{ TInch }

type
  TInch = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = 'in';
    const FName              = 'inch';
    const FPluralName        = 'inches';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TInchUnit = specialize TUnit<TInch>;

const
  inch       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 0.0254); {$ELSE} (0.0254); {$ENDIF}

{ TFoot }

type
  TFoot = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = 'ft';
    const FName              = 'foot';
    const FPluralName        = 'feet';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TFootUnit = specialize TUnit<TFoot>;

const
  ft         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 0.3048); {$ELSE} (0.3048); {$ENDIF}

{ TYard }

type
  TYard = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = 'yd';
    const FName              = 'yard';
    const FPluralName        = 'yards';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TYardUnit = specialize TUnit<TYard>;

const
  yd         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 0.9144); {$ELSE} (0.9144); {$ENDIF}

{ TMile }

type
  TMile = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = 'mi';
    const FName              = 'mile';
    const FPluralName        = 'miles';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TMileUnit = specialize TUnit<TMile>;

const
  mi         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 1609.344); {$ELSE} (1609.344); {$ENDIF}

{ TNauticalMile }

type
  TNauticalMile = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = 'nmi';
    const FName              = 'nautical mile';
    const FPluralName        = 'nautical miles';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TNauticalMileUnit = specialize TUnit<TNauticalMile>;

const
  nmi        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 1852); {$ELSE} (1852); {$ENDIF}

{ TAngstrom }

type
  TAngstrom = record
    const FUnitOfMeasurement = cMeter;
    const FSymbol            = '%sÅ';
    const FName              = '%sangstrom';
    const FPluralName        = '%sangstroms';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TAngstromUnit = specialize TUnit<TAngstrom>;

const
  angstrom   : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 7; FValue: 1E-10); {$ELSE} (1E-10); {$ENDIF}

{ TSquareRootMeter }

const
  cSquareRootMeter = 8;

type
  TSquareRootMeter = record
    const FUnitOfMeasurement = cSquareRootMeter;
    const FSymbol            = '√%sm';
    const FName              = 'square root %smeter';
    const FPluralName        = 'square root %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TSquareRootMeterUnit = specialize TUnit<TSquareRootMeter>;

{ TSquareMeter }

const
  cSquareMeter = 9;

type
  TSquareMeter = record
    const FUnitOfMeasurement = cSquareMeter;
    const FSymbol            = '%sm2';
    const FName              = 'square %smeter';
    const FPluralName        = 'square %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareMeterUnit = specialize TUnit<TSquareMeter>;

var
  m2         : TSquareMeterUnit;

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
  TSquareInch = record
    const FUnitOfMeasurement = cSquareMeter;
    const FSymbol            = 'in2';
    const FName              = 'square inch';
    const FPluralName        = 'square inches';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TSquareInchUnit = specialize TUnit<TSquareInch>;

const
  inch2      : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 0.00064516); {$ELSE} (0.00064516); {$ENDIF}

{ TSquareFoot }

type
  TSquareFoot = record
    const FUnitOfMeasurement = cSquareMeter;
    const FSymbol            = 'ft2';
    const FName              = 'square foot';
    const FPluralName        = 'square feet';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TSquareFootUnit = specialize TUnit<TSquareFoot>;

const
  ft2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 0.09290304); {$ELSE} (0.09290304); {$ENDIF}

{ TSquareYard }

type
  TSquareYard = record
    const FUnitOfMeasurement = cSquareMeter;
    const FSymbol            = 'yd2';
    const FName              = 'square yard';
    const FPluralName        = 'square yards';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TSquareYardUnit = specialize TUnit<TSquareYard>;

const
  yd2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 0.83612736); {$ELSE} (0.83612736); {$ENDIF}

{ TSquareMile }

type
  TSquareMile = record
    const FUnitOfMeasurement = cSquareMeter;
    const FSymbol            = 'mi2';
    const FName              = 'square mile';
    const FPluralName        = 'square miles';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TSquareMileUnit = specialize TUnit<TSquareMile>;

const
  mi2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 9; FValue: 2589988.110336); {$ELSE} (2589988.110336); {$ENDIF}

{ TCubicMeter }

const
  cCubicMeter = 10;

type
  TCubicMeter = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = '%sm3';
    const FName              = 'cubic %smeter';
    const FPluralName        = 'cubic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (3);
  end;
  TCubicMeterUnit = specialize TUnit<TCubicMeter>;

var
  m3         : TCubicMeterUnit;

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
  TCubicInch = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = 'in3';
    const FName              = 'cubic inch';
    const FPluralName        = 'cubic inches';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TCubicInchUnit = specialize TUnit<TCubicInch>;

const
  inch3      : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 0.000016387064); {$ELSE} (0.000016387064); {$ENDIF}

{ TCubicFoot }

type
  TCubicFoot = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = 'ft3';
    const FName              = 'cubic foot';
    const FPluralName        = 'cubic feet';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TCubicFootUnit = specialize TUnit<TCubicFoot>;

const
  ft3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 0.028316846592); {$ELSE} (0.028316846592); {$ENDIF}

{ TCubicYard }

type
  TCubicYard = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = 'yd3';
    const FName              = 'cubic yard';
    const FPluralName        = 'cubic yards';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TCubicYardUnit = specialize TUnit<TCubicYard>;

const
  yd3        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 0.764554857984); {$ELSE} (0.764554857984); {$ENDIF}

{ TLitre }

type
  TLitre = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = '%sL';
    const FName              = '%slitre';
    const FPluralName        = '%slitres';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TLitreUnit = specialize TUnit<TLitre>;

const
  L          : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

const
  dL         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E-03 * 1E-01); {$ELSE} (1E-03 * 1E-01); {$ENDIF}
  cL         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E-03 * 1E-02); {$ELSE} (1E-03 * 1E-02); {$ENDIF}
  mL         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 1E-03 * 1E-03); {$ELSE} (1E-03 * 1E-03); {$ENDIF}

{ TGallon }

type
  TGallon = record
    const FUnitOfMeasurement = cCubicMeter;
    const FSymbol            = 'gal';
    const FName              = 'gallon';
    const FPluralName        = 'gallons';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TGallonUnit = specialize TUnit<TGallon>;

const
  gal        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 10; FValue: 0.0037854119678); {$ELSE} (0.0037854119678); {$ENDIF}

{ TQuarticMeter }

const
  cQuarticMeter = 11;

type
  TQuarticMeter = record
    const FUnitOfMeasurement = cQuarticMeter;
    const FSymbol            = '%sm4';
    const FName              = 'quartic %smeter';
    const FPluralName        = 'quartic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (4);
  end;
  TQuarticMeterUnit = specialize TUnit<TQuarticMeter>;

var
  m4         : TQuarticMeterUnit;

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
  TQuinticMeter = record
    const FUnitOfMeasurement = cQuinticMeter;
    const FSymbol            = '%sm5';
    const FName              = 'quintic %smeter';
    const FPluralName        = 'quintic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (5);
  end;
  TQuinticMeterUnit = specialize TUnit<TQuinticMeter>;

var
  m5         : TQuinticMeterUnit;

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
  TSexticMeter = record
    const FUnitOfMeasurement = cSexticMeter;
    const FSymbol            = '%sm6';
    const FName              = 'sextic %smeter';
    const FPluralName        = 'sextic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (6);
  end;
  TSexticMeterUnit = specialize TUnit<TSexticMeter>;

var
  m6         : TSexticMeterUnit;

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
  TKilogram = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = '%sg';
    const FName              = '%sgram';
    const FPluralName        = '%sgrams';
    const FPrefixes          : TPrefixes  = (pKilo);
    const FExponents         : TExponents = (1);
  end;
  TKilogramUnit = specialize TUnit<TKilogram>;

var
  kg         : TKilogramUnit;

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
  TTonne = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = '%st';
    const FName              = '%stonne';
    const FPluralName        = '%stonnes';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TTonneUnit = specialize TUnit<TTonne>;

const
  tonne      : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

const
  gigatonne  : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E+03 * 1E+09); {$ELSE} (1E+03 * 1E+09); {$ENDIF}
  megatonne  : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E+03 * 1E+06); {$ELSE} (1E+03 * 1E+06); {$ENDIF}
  kilotonne  : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 1E+03 * 1E+03); {$ELSE} (1E+03 * 1E+03); {$ENDIF}

{ TPound }

type
  TPound = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = 'lb';
    const FName              = 'pound';
    const FPluralName        = 'pounds';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TPoundUnit = specialize TUnit<TPound>;

const
  lb         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 0.45359237); {$ELSE} (0.45359237); {$ENDIF}

{ TOunce }

type
  TOunce = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = 'oz';
    const FName              = 'ounce';
    const FPluralName        = 'ounces';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TOunceUnit = specialize TUnit<TOunce>;

const
  oz         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 0.028349523125); {$ELSE} (0.028349523125); {$ENDIF}

{ TStone }

type
  TStone = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = 'st';
    const FName              = 'stone';
    const FPluralName        = 'stones';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TStoneUnit = specialize TUnit<TStone>;

const
  st         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 6.35029318); {$ELSE} (6.35029318); {$ENDIF}

{ TTon }

type
  TTon = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = 'ton';
    const FName              = 'ton';
    const FPluralName        = 'tons';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TTonUnit = specialize TUnit<TTon>;

const
  ton        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 14; FValue: 907.18474); {$ELSE} (907.18474); {$ENDIF}

{ TElectronvoltPerSquareSpeedOfLight }

type
  TElectronvoltPerSquareSpeedOfLight = record
    const FUnitOfMeasurement = cKilogram;
    const FSymbol            = '%seV/c2';
    const FName              = '%selectronvolt per squared speed of light';
    const FPluralName        = '%selectronvolts per squared speed of light';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TElectronvoltPerSquareSpeedOfLightUnit = specialize TUnit<TElectronvoltPerSquareSpeedOfLight>;

{ TSquareKilogram }

const
  cSquareKilogram = 15;

type
  TSquareKilogram = record
    const FUnitOfMeasurement = cSquareKilogram;
    const FSymbol            = '%sg2';
    const FName              = 'square %sgram';
    const FPluralName        = 'square %sgrams';
    const FPrefixes          : TPrefixes  = (pKilo);
    const FExponents         : TExponents = (2);
  end;
  TSquareKilogramUnit = specialize TUnit<TSquareKilogram>;

var
  kg2        : TSquareKilogramUnit;

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
  TAmpere = record
    const FUnitOfMeasurement = cAmpere;
    const FSymbol            = '%sA';
    const FName              = '%sampere';
    const FPluralName        = '%samperes';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TAmpereUnit = specialize TUnit<TAmpere>;

var
  A          : TAmpereUnit;

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
  TSquareAmpere = record
    const FUnitOfMeasurement = cSquareAmpere;
    const FSymbol            = '%sA2';
    const FName              = 'square %sampere';
    const FPluralName        = 'square %samperes';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareAmpereUnit = specialize TUnit<TSquareAmpere>;

var
  A2         : TSquareAmpereUnit;

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
  TKelvin = record
    const FUnitOfMeasurement = cKelvin;
    const FSymbol            = '%sK';
    const FName              = '%skelvin';
    const FPluralName        = '%skelvins';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TKelvinUnit = specialize TUnit<TKelvin>;

var
  K          : TKelvinUnit;

{ TDegreeCelsius }

type
  TDegreeCelsius = record
    const FUnitOfMeasurement = cKelvin;
    const FSymbol            = 'ºC';
    const FName              = 'degree Celsius';
    const FPluralName        = 'degrees Celsius';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TDegreeCelsiusUnit = specialize TUnit<TDegreeCelsius>;

var
  degC       : TDegreeCelsiusUnit;

{ TDegreeFahrenheit }

type
  TDegreeFahrenheit = record
    const FUnitOfMeasurement = cKelvin;
    const FSymbol            = 'ºF';
    const FName              = 'degree Fahrenheit';
    const FPluralName        = 'degrees Fahrenheit';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TDegreeFahrenheitUnit = specialize TUnit<TDegreeFahrenheit>;

var
  degF       : TDegreeFahrenheitUnit;

{ TSquareKelvin }

const
  cSquareKelvin = 19;

type
  TSquareKelvin = record
    const FUnitOfMeasurement = cSquareKelvin;
    const FSymbol            = '%sK2';
    const FName              = 'square %skelvin';
    const FPluralName        = 'square %skelvins';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareKelvinUnit = specialize TUnit<TSquareKelvin>;

var
  K2         : TSquareKelvinUnit;

{ TCubicKelvin }

const
  cCubicKelvin = 20;

type
  TCubicKelvin = record
    const FUnitOfMeasurement = cCubicKelvin;
    const FSymbol            = '%sK3';
    const FName              = 'cubic %skelvin';
    const FPluralName        = 'cubic %skelvins';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (3);
  end;
  TCubicKelvinUnit = specialize TUnit<TCubicKelvin>;

var
  K3         : TCubicKelvinUnit;

{ TQuarticKelvin }

const
  cQuarticKelvin = 21;

type
  TQuarticKelvin = record
    const FUnitOfMeasurement = cQuarticKelvin;
    const FSymbol            = '%sK4';
    const FName              = 'quartic %skelvin';
    const FPluralName        = 'quartic %skelvins';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (4);
  end;
  TQuarticKelvinUnit = specialize TUnit<TQuarticKelvin>;

var
  K4         : TQuarticKelvinUnit;

{ TMole }

const
  cMole = 22;

type
  TMole = record
    const FUnitOfMeasurement = cMole;
    const FSymbol            = '%smol';
    const FName              = '%smole';
    const FPluralName        = '%smoles';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TMoleUnit = specialize TUnit<TMole>;

var
  mol        : TMoleUnit;

const
  kmol       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 22; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hmol       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 22; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  damol      : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 22; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}

{ TCandela }

const
  cCandela = 23;

type
  TCandela = record
    const FUnitOfMeasurement = cCandela;
    const FSymbol            = '%scd';
    const FName              = '%scandela';
    const FPluralName        = '%scandelas';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TCandelaUnit = specialize TUnit<TCandela>;

var
  cd         : TCandelaUnit;

{ THertz }

const
  cHertz = 24;

type
  THertz = record
    const FUnitOfMeasurement = cHertz;
    const FSymbol            = '%sHz';
    const FName              = '%shertz';
    const FPluralName        = '%shertz';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  THertzUnit = specialize TUnit<THertz>;

var
  Hz         : THertzUnit;

const
  THz        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GHz        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MHz        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kHz        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TReciprocalSecond }

type
  TReciprocalSecond = record
    const FUnitOfMeasurement = cHertz;
    const FSymbol            = '1/%ss';
    const FName              = 'reciprocal %ssecond';
    const FPluralName        = 'reciprocal %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalSecondUnit = specialize TUnit<TReciprocalSecond>;

{ TRadianPerSecond }

type
  TRadianPerSecond = record
    const FUnitOfMeasurement = cHertz;
    const FSymbol            = 'rad/%ss';
    const FName              = 'radian per %ssecond';
    const FPluralName        = 'radians per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TRadianPerSecondUnit = specialize TUnit<TRadianPerSecond>;

{ TSquareHertz }

const
  cSquareHertz = 25;

type
  TSquareHertz = record
    const FUnitOfMeasurement = cSquareHertz;
    const FSymbol            = '%sHz2';
    const FName              = 'square %shertz';
    const FPluralName        = 'square %shertz';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareHertzUnit = specialize TUnit<TSquareHertz>;

var
  Hz2        : TSquareHertzUnit;

const
  THz2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 25; FValue: 1E+24); {$ELSE} (1E+24); {$ENDIF}
  GHz2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 25; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MHz2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 25; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kHz2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 25; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}

{ TReciprocalSquareSecond }

type
  TReciprocalSquareSecond = record
    const FUnitOfMeasurement = cSquareHertz;
    const FSymbol            = '1/%ss2';
    const FName              = 'reciprocal square %ssecond';
    const FPluralName        = 'reciprocal square %sseconds';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-2);
  end;
  TReciprocalSquareSecondUnit = specialize TUnit<TReciprocalSquareSecond>;

{ TRadianPerSquareSecond }

type
  TRadianPerSquareSecond = record
    const FUnitOfMeasurement = cSquareHertz;
    const FSymbol            = 'rad/%ss2';
    const FName              = 'radian per square %ssecond';
    const FPluralName        = 'radians per square %ssecond';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-2);
  end;
  TRadianPerSquareSecondUnit = specialize TUnit<TRadianPerSquareSecond>;

{ TSteradianPerSquareSecond }

const
  cSteradianPerSquareSecond = 26;

type
  TSteradianPerSquareSecond = record
    const FUnitOfMeasurement = cSteradianPerSquareSecond;
    const FSymbol            = 'sr/%ss2';
    const FName              = 'steradian per square %ssecond';
    const FPluralName        = 'steradians per square %ssecond';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-2);
  end;
  TSteradianPerSquareSecondUnit = specialize TUnit<TSteradianPerSquareSecond>;

{ TMeterPerSecond }

const
  cMeterPerSecond = 27;

type
  TMeterPerSecond = record
    const FUnitOfMeasurement = cMeterPerSecond;
    const FSymbol            = '%sm/%ss';
    const FName              = '%smeter per %ssecond';
    const FPluralName        = '%smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TMeterPerSecondUnit = specialize TUnit<TMeterPerSecond>;

{ TMeterPerHour }

type
  TMeterPerHour = record
    const FUnitOfMeasurement = cMeterPerSecond;
    const FSymbol            = '%sm/h';
    const FName              = '%smeter per hour';
    const FPluralName        = '%smeters per hour';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TMeterPerHourUnit = specialize TUnit<TMeterPerHour>;

{ TMilePerHour }

type
  TMilePerHour = record
    const FUnitOfMeasurement = cMeterPerSecond;
    const FSymbol            = 'mi/h';
    const FName              = 'mile per hour';
    const FPluralName        = 'miles per hour';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TMilePerHourUnit = specialize TUnit<TMilePerHour>;

{ TNauticalMilePerHour }

type
  TNauticalMilePerHour = record
    const FUnitOfMeasurement = cMeterPerSecond;
    const FSymbol            = 'nmi/h';
    const FName              = 'nautical mile per hour';
    const FPluralName        = 'nautical miles per hour';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TNauticalMilePerHourUnit = specialize TUnit<TNauticalMilePerHour>;

{ TMeterPerSquareSecond }

const
  cMeterPerSquareSecond = 28;

type
  TMeterPerSquareSecond = record
    const FUnitOfMeasurement = cMeterPerSquareSecond;
    const FSymbol            = '%sm/%ss2';
    const FName              = '%smeter per %ssecond squared';
    const FPluralName        = '%smeters per %ssecond squared';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TMeterPerSquareSecondUnit = specialize TUnit<TMeterPerSquareSecond>;

{ TMeterPerSecondPerSecond }

type
  TMeterPerSecondPerSecond = record
    const FUnitOfMeasurement = cMeterPerSquareSecond;
    const FSymbol            = '%sm/%ss/%ss';
    const FName              = '%smeter per %ssecond per %ssecond';
    const FPluralName        = '%smeters per %ssecond per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -1, -1);
  end;
  TMeterPerSecondPerSecondUnit = specialize TUnit<TMeterPerSecondPerSecond>;

{ TMeterPerHourPerSecond }

type
  TMeterPerHourPerSecond = record
    const FUnitOfMeasurement = cMeterPerSquareSecond;
    const FSymbol            = '%sm/h/%ss';
    const FName              = '%smeter per hour per %ssecond';
    const FPluralName        = '%smeters per hour per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TMeterPerHourPerSecondUnit = specialize TUnit<TMeterPerHourPerSecond>;

{ TMeterPerCubicSecond }

const
  cMeterPerCubicSecond = 29;

type
  TMeterPerCubicSecond = record
    const FUnitOfMeasurement = cMeterPerCubicSecond;
    const FSymbol            = '%sm/%ss3';
    const FName              = '%smeter per cubic %ssecond';
    const FPluralName        = '%smeters per cubic %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TMeterPerCubicSecondUnit = specialize TUnit<TMeterPerCubicSecond>;

{ TMeterPerQuarticSecond }

const
  cMeterPerQuarticSecond = 30;

type
  TMeterPerQuarticSecond = record
    const FUnitOfMeasurement = cMeterPerQuarticSecond;
    const FSymbol            = '%sm/%ss4';
    const FName              = '%smeter per quartic %ssecond';
    const FPluralName        = '%smeters per quartic %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -4);
  end;
  TMeterPerQuarticSecondUnit = specialize TUnit<TMeterPerQuarticSecond>;

{ TMeterPerQuinticSecond }

const
  cMeterPerQuinticSecond = 31;

type
  TMeterPerQuinticSecond = record
    const FUnitOfMeasurement = cMeterPerQuinticSecond;
    const FSymbol            = '%sm/%ss5';
    const FName              = '%smeter per quintic %ssecond';
    const FPluralName        = '%smeters per quintic %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -5);
  end;
  TMeterPerQuinticSecondUnit = specialize TUnit<TMeterPerQuinticSecond>;

{ TMeterPerSexticSecond }

const
  cMeterPerSexticSecond = 32;

type
  TMeterPerSexticSecond = record
    const FUnitOfMeasurement = cMeterPerSexticSecond;
    const FSymbol            = '%sm/%ss6';
    const FName              = '%smeter per sextic %ssecond';
    const FPluralName        = '%smeters per sextic %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -6);
  end;
  TMeterPerSexticSecondUnit = specialize TUnit<TMeterPerSexticSecond>;

{ TSquareMeterPerSquareSecond }

const
  cSquareMeterPerSquareSecond = 33;

type
  TSquareMeterPerSquareSecond = record
    const FUnitOfMeasurement = cSquareMeterPerSquareSecond;
    const FSymbol            = '%sm2/%ss2';
    const FName              = 'square %smeter per square %ssecond';
    const FPluralName        = 'square %smeters per square %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareMeterPerSquareSecondUnit = specialize TUnit<TSquareMeterPerSquareSecond>;

{ TJoulePerKilogram }

type
  TJoulePerKilogram = record
    const FUnitOfMeasurement = cSquareMeterPerSquareSecond;
    const FSymbol            = '%sJ/%sg';
    const FName              = '%sjoule per %sgram';
    const FPluralName        = '%sjoules per %sgram';
    const FPrefixes          : TPrefixes  = (pNone, pKilo);
    const FExponents         : TExponents = (1, -1);
  end;
  TJoulePerKilogramUnit = specialize TUnit<TJoulePerKilogram>;

{ TGray }

type
  TGray = record
    const FUnitOfMeasurement = cSquareMeterPerSquareSecond;
    const FSymbol            = '%sGy';
    const FName              = '%sgray';
    const FPluralName        = '%sgrays';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TGrayUnit = specialize TUnit<TGray>;

var
  Gy         : TGrayUnit;

const
  kGy        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mGy        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miGy       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nGy        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TSievert }

type
  TSievert = record
    const FUnitOfMeasurement = cSquareMeterPerSquareSecond;
    const FSymbol            = '%sSv';
    const FName              = '%ssievert';
    const FPluralName        = '%ssieverts';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TSievertUnit = specialize TUnit<TSievert>;

var
  Sv         : TSievertUnit;

const
  kSv        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mSv        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miSv       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nSv        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 33; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TMeterSecond }

const
  cMeterSecond = 34;

type
  TMeterSecond = record
    const FUnitOfMeasurement = cMeterSecond;
    const FSymbol            = '%sm.%ss';
    const FName              = '%smeter %ssecond';
    const FPluralName        = '%smeter %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TMeterSecondUnit = specialize TUnit<TMeterSecond>;

{ TKilogramMeter }

const
  cKilogramMeter = 35;

type
  TKilogramMeter = record
    const FUnitOfMeasurement = cKilogramMeter;
    const FSymbol            = '%sg.%sm';
    const FName              = '%sgram %smeter';
    const FPluralName        = '%sgram %smeters';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TKilogramMeterUnit = specialize TUnit<TKilogramMeter>;

{ TKilogramPerSecond }

const
  cKilogramPerSecond = 36;

type
  TKilogramPerSecond = record
    const FUnitOfMeasurement = cKilogramPerSecond;
    const FSymbol            = '%sg/%ss';
    const FName              = '%sgram per %ssecond';
    const FPluralName        = '%sgrams per %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TKilogramPerSecondUnit = specialize TUnit<TKilogramPerSecond>;

{ TJoulePerSquareMeterPerHertz }

type
  TJoulePerSquareMeterPerHertz = record
    const FUnitOfMeasurement = cKilogramPerSecond;
    const FSymbol            = '%sJ/%sm2/%sHz';
    const FName              = '%sjoule per square %smeter per %shertz';
    const FPluralName        = '%sjoules per square %smeter per %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -2, -1);
  end;
  TJoulePerSquareMeterPerHertzUnit = specialize TUnit<TJoulePerSquareMeterPerHertz>;

{ TKilogramMeterPerSecond }

const
  cKilogramMeterPerSecond = 37;

type
  TKilogramMeterPerSecond = record
    const FUnitOfMeasurement = cKilogramMeterPerSecond;
    const FSymbol            = '%sg.%sm/%ss';
    const FName              = '%sgram %smeter per %ssecond';
    const FPluralName        = '%sgram %smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -1);
  end;
  TKilogramMeterPerSecondUnit = specialize TUnit<TKilogramMeterPerSecond>;

{ TNewtonSecond }

type
  TNewtonSecond = record
    const FUnitOfMeasurement = cKilogramMeterPerSecond;
    const FSymbol            = '%sN.%ss';
    const FName              = '%snewton %ssecond';
    const FPluralName        = '%snewton %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TNewtonSecondUnit = specialize TUnit<TNewtonSecond>;

{ TSquareKilogramSquareMeterPerSquareSecond }

const
  cSquareKilogramSquareMeterPerSquareSecond = 38;

type
  TSquareKilogramSquareMeterPerSquareSecond = record
    const FUnitOfMeasurement = cSquareKilogramSquareMeterPerSquareSecond;
    const FSymbol            = '%sg2.%sm2/%ss2';
    const FName              = 'square%sgram square%smeter per square%ssecond';
    const FPluralName        = 'square%sgram square%smeters per square%ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (2, 2, -2);
  end;
  TSquareKilogramSquareMeterPerSquareSecondUnit = specialize TUnit<TSquareKilogramSquareMeterPerSquareSecond>;

{ TReciprocalSquareRootMeter }

const
  cReciprocalSquareRootMeter = 39;

type
  TReciprocalSquareRootMeter = record
    const FUnitOfMeasurement = cReciprocalSquareRootMeter;
    const FSymbol            = '1/√%sm';
    const FName              = 'reciprocal square root %smeter';
    const FPluralName        = 'reciprocal square root %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalSquareRootMeterUnit = specialize TUnit<TReciprocalSquareRootMeter>;

{ TReciprocalMeter }

const
  cReciprocalMeter = 40;

type
  TReciprocalMeter = record
    const FUnitOfMeasurement = cReciprocalMeter;
    const FSymbol            = '1/%sm';
    const FName              = 'reciprocal %smeter';
    const FPluralName        = 'reciprocal %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalMeterUnit = specialize TUnit<TReciprocalMeter>;

{ TDioptre }

type
  TDioptre = record
    const FUnitOfMeasurement = cReciprocalMeter;
    const FSymbol            = 'dpt';
    const FName              = '%sdioptre';
    const FPluralName        = '%sdioptres';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
  end;
  TDioptreUnit = specialize TUnit<TDioptre>;

{ TReciprocalSquareRootCubicMeter }

const
  cReciprocalSquareRootCubicMeter = 41;

type
  TReciprocalSquareRootCubicMeter = record
    const FUnitOfMeasurement = cReciprocalSquareRootCubicMeter;
    const FSymbol            = '1/√%sm3';
    const FName              = 'reciprocal square root cubic %smeter';
    const FPluralName        = 'reciprocal square root cubic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-3);
  end;
  TReciprocalSquareRootCubicMeterUnit = specialize TUnit<TReciprocalSquareRootCubicMeter>;

{ TReciprocalSquareMeter }

const
  cReciprocalSquareMeter = 42;

type
  TReciprocalSquareMeter = record
    const FUnitOfMeasurement = cReciprocalSquareMeter;
    const FSymbol            = '1/%sm2';
    const FName              = 'reciprocal square %smeter';
    const FPluralName        = 'reciprocal square %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-2);
  end;
  TReciprocalSquareMeterUnit = specialize TUnit<TReciprocalSquareMeter>;

{ TReciprocalCubicMeter }

const
  cReciprocalCubicMeter = 43;

type
  TReciprocalCubicMeter = record
    const FUnitOfMeasurement = cReciprocalCubicMeter;
    const FSymbol            = '1/%sm3';
    const FName              = 'reciprocal cubic %smeter';
    const FPluralName        = 'reciprocal cubic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-3);
  end;
  TReciprocalCubicMeterUnit = specialize TUnit<TReciprocalCubicMeter>;

{ TReciprocalQuarticMeter }

const
  cReciprocalQuarticMeter = 44;

type
  TReciprocalQuarticMeter = record
    const FUnitOfMeasurement = cReciprocalQuarticMeter;
    const FSymbol            = '1/%sm4';
    const FName              = 'reciprocal quartic %smeter';
    const FPluralName        = 'reciprocal quartic %smeters';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-4);
  end;
  TReciprocalQuarticMeterUnit = specialize TUnit<TReciprocalQuarticMeter>;

{ TKilogramSquareMeter }

const
  cKilogramSquareMeter = 45;

type
  TKilogramSquareMeter = record
    const FUnitOfMeasurement = cKilogramSquareMeter;
    const FSymbol            = '%sg.%sm2';
    const FName              = '%sgram square %smeter';
    const FPluralName        = '%sgram square %smeters';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, 2);
  end;
  TKilogramSquareMeterUnit = specialize TUnit<TKilogramSquareMeter>;

{ TKilogramSquareMeterPerSecond }

const
  cKilogramSquareMeterPerSecond = 46;

type
  TKilogramSquareMeterPerSecond = record
    const FUnitOfMeasurement = cKilogramSquareMeterPerSecond;
    const FSymbol            = '%sg.%sm2/%ss';
    const FName              = '%sgram square %smeter per %ssecond';
    const FPluralName        = '%sgram square %smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -1);
  end;
  TKilogramSquareMeterPerSecondUnit = specialize TUnit<TKilogramSquareMeterPerSecond>;

{ TNewtonMeterSecond }

type
  TNewtonMeterSecond = record
    const FUnitOfMeasurement = cKilogramSquareMeterPerSecond;
    const FSymbol            = '%sN.%sm.%ss';
    const FName              = '%snewton %smeter %ssecond';
    const FPluralName        = '%snewton %smeter %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 1, 1);
  end;
  TNewtonMeterSecondUnit = specialize TUnit<TNewtonMeterSecond>;

{ TSecondPerMeter }

const
  cSecondPerMeter = 47;

type
  TSecondPerMeter = record
    const FUnitOfMeasurement = cSecondPerMeter;
    const FSymbol            = '%ss/%sm';
    const FName              = '%ssecond per %smeter';
    const FPluralName        = '%sseconds per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TSecondPerMeterUnit = specialize TUnit<TSecondPerMeter>;

{ TKilogramPerMeter }

const
  cKilogramPerMeter = 48;

type
  TKilogramPerMeter = record
    const FUnitOfMeasurement = cKilogramPerMeter;
    const FSymbol            = '%sg/%sm';
    const FName              = '%sgram per %smeter';
    const FPluralName        = '%sgrams per %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TKilogramPerMeterUnit = specialize TUnit<TKilogramPerMeter>;

{ TKilogramPerSquareMeter }

const
  cKilogramPerSquareMeter = 49;

type
  TKilogramPerSquareMeter = record
    const FUnitOfMeasurement = cKilogramPerSquareMeter;
    const FSymbol            = '%sg/%sm2';
    const FName              = '%sgram per square %smeter';
    const FPluralName        = '%sgrams per square %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TKilogramPerSquareMeterUnit = specialize TUnit<TKilogramPerSquareMeter>;

{ TKilogramPerCubicMeter }

const
  cKilogramPerCubicMeter = 50;

type
  TKilogramPerCubicMeter = record
    const FUnitOfMeasurement = cKilogramPerCubicMeter;
    const FSymbol            = '%sg/%sm3';
    const FName              = '%sgram per cubic %smeter';
    const FPluralName        = '%sgrams per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TKilogramPerCubicMeterUnit = specialize TUnit<TKilogramPerCubicMeter>;

{ TPoundPerCubicInch }

type
  TPoundPerCubicInch = record
    const FUnitOfMeasurement = cKilogramPerCubicMeter;
    const FSymbol            = 'lb/in3';
    const FName              = 'pound per cubic inch';
    const FPluralName        = 'pounds per cubic inch';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TPoundPerCubicInchUnit = specialize TUnit<TPoundPerCubicInch>;

{ TNewton }

const
  cNewton = 51;

type
  TNewton = record
    const FUnitOfMeasurement = cNewton;
    const FSymbol            = '%sN';
    const FName              = '%snewton';
    const FPluralName        = '%snewtons';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TNewtonUnit = specialize TUnit<TNewton>;

var
  N          : TNewtonUnit;

const
  GN         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 51; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MN         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 51; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kN         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 51; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  hN         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 51; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}
  daN        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 51; FValue: 1E+01); {$ELSE} (1E+01); {$ENDIF}

{ TPoundForce }

type
  TPoundForce = record
    const FUnitOfMeasurement = cNewton;
    const FSymbol            = 'lbf';
    const FName              = 'pound-force';
    const FPluralName        = 'pounds-force';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TPoundForceUnit = specialize TUnit<TPoundForce>;

const
  lbf        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 51; FValue: 4.4482216152605); {$ELSE} (4.4482216152605); {$ENDIF}

{ TKilogramMeterPerSquareSecond }

type
  TKilogramMeterPerSquareSecond = record
    const FUnitOfMeasurement = cNewton;
    const FSymbol            = '%sg.%sm/%ss2';
    const FName              = '%sgram %smeter per square %ssecond';
    const FPluralName        = '%sgram %smeters per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -2);
  end;
  TKilogramMeterPerSquareSecondUnit = specialize TUnit<TKilogramMeterPerSquareSecond>;

{ TNewtonRadian }

const
  cNewtonRadian = 52;

type
  TNewtonRadian = record
    const FUnitOfMeasurement = cNewtonRadian;
    const FSymbol            = '%sN.%srad';
    const FName              = '%snewton %sradian';
    const FPluralName        = '%snewton %sradians';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TNewtonRadianUnit = specialize TUnit<TNewtonRadian>;

{ TSquareNewton }

const
  cSquareNewton = 53;

type
  TSquareNewton = record
    const FUnitOfMeasurement = cSquareNewton;
    const FSymbol            = '%sN2';
    const FName              = 'square %snewton';
    const FPluralName        = 'square %snewtons';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareNewtonUnit = specialize TUnit<TSquareNewton>;

var
  N2         : TSquareNewtonUnit;

const
  GN2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 53; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MN2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 53; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kN2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 53; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  hN2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 53; FValue: 1E+04); {$ELSE} (1E+04); {$ENDIF}
  daN2       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 53; FValue: 1E+02); {$ELSE} (1E+02); {$ENDIF}

{ TSquareKilogramSquareMeterPerQuarticSecond }

type
  TSquareKilogramSquareMeterPerQuarticSecond = record
    const FUnitOfMeasurement = cSquareNewton;
    const FSymbol            = '%sg2.%sm2/%ss4';
    const FName              = 'square %sgram square %smeter per quartic %ssecond';
    const FPluralName        = 'square %sgram square %smeters per quartic %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (2, 2, -4);
  end;
  TSquareKilogramSquareMeterPerQuarticSecondUnit = specialize TUnit<TSquareKilogramSquareMeterPerQuarticSecond>;

{ TPascal }

const
  cPascal = 54;

type
  TPascal = record
    const FUnitOfMeasurement = cPascal;
    const FSymbol            = '%sPa';
    const FName              = '%spascal';
    const FPluralName        = '%spascals';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TPascalUnit = specialize TUnit<TPascal>;

var
  Pa         : TPascalUnit;

const
  TPa        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GPa        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MPa        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kPa        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TNewtonPerSquareMeter }

type
  TNewtonPerSquareMeter = record
    const FUnitOfMeasurement = cPascal;
    const FSymbol            = '%sN/%sm2';
    const FName              = '%snewton per square %smeter';
    const FPluralName        = '%snewtons per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TNewtonPerSquareMeterUnit = specialize TUnit<TNewtonPerSquareMeter>;

{ TBar }

type
  TBar = record
    const FUnitOfMeasurement = cPascal;
    const FSymbol            = '%sbar';
    const FName              = '%sbar';
    const FPluralName        = '%sbars';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TBarUnit = specialize TUnit<TBar>;

const
  bar        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 1E+05); {$ELSE} (1E+05); {$ENDIF}

const
  kbar       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 1E+05 * 1E+03); {$ELSE} (1E+05 * 1E+03); {$ENDIF}
  mbar       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 1E+05 * 1E-03); {$ELSE} (1E+05 * 1E-03); {$ENDIF}

{ TPoundPerSquareInch }

type
  TPoundPerSquareInch = record
    const FUnitOfMeasurement = cPascal;
    const FSymbol            = '%spsi';
    const FName              = '%spound per square inch';
    const FPluralName        = '%spounds per square inch';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TPoundPerSquareInchUnit = specialize TUnit<TPoundPerSquareInch>;

const
  psi        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 6894.75729316836); {$ELSE} (6894.75729316836); {$ENDIF}

const
  kpsi       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 54; FValue: 6894.75729316836 * 1E+03); {$ELSE} (6894.75729316836 * 1E+03); {$ENDIF}

{ TJoulePerCubicMeter }

type
  TJoulePerCubicMeter = record
    const FUnitOfMeasurement = cPascal;
    const FSymbol            = '%sJ/%sm3';
    const FName              = '%sjoule per cubic %smeter';
    const FPluralName        = '%sjoules per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TJoulePerCubicMeterUnit = specialize TUnit<TJoulePerCubicMeter>;

{ TKilogramPerMeterPerSquareSecond }

type
  TKilogramPerMeterPerSquareSecond = record
    const FUnitOfMeasurement = cPascal;
    const FSymbol            = '%sg/%sm/%ss2';
    const FName              = '%sgram per %smeter per square %ssecond';
    const FPluralName        = '%sgrams per %smeter per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, -1, -2);
  end;
  TKilogramPerMeterPerSquareSecondUnit = specialize TUnit<TKilogramPerMeterPerSquareSecond>;

{ TJoule }

const
  cJoule = 55;

type
  TJoule = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sJ';
    const FName              = '%sjoule';
    const FPluralName        = '%sjoules';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TJouleUnit = specialize TUnit<TJoule>;

var
  J          : TJouleUnit;

const
  TJ         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GJ         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MJ         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kJ         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}

{ TWattHour }

type
  TWattHour = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sW.h';
    const FName              = '%swatt hour';
    const FPluralName        = '%swatt hours';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TWattHourUnit = specialize TUnit<TWattHour>;

{ TWattSecond }

type
  TWattSecond = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sW.%ss';
    const FName              = '%swatt %ssecond';
    const FPluralName        = '%swatt %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TWattSecondUnit = specialize TUnit<TWattSecond>;

{ TWattPerHertz }

type
  TWattPerHertz = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sW/%shz';
    const FName              = '%swatt per %shertz';
    const FPluralName        = '%swatts per %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TWattPerHertzUnit = specialize TUnit<TWattPerHertz>;

{ TElectronvolt }

type
  TElectronvolt = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%seV';
    const FName              = '%selectronvolt';
    const FPluralName        = '%selectronvolts';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TElectronvoltUnit = specialize TUnit<TElectronvolt>;

const
  eV         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019); {$ELSE} (1.602176634E-019); {$ENDIF}

const
  TeV        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+12); {$ELSE} (1.602176634E-019 * 1E+12); {$ENDIF}
  GeV        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+09); {$ELSE} (1.602176634E-019 * 1E+09); {$ENDIF}
  MeV        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+06); {$ELSE} (1.602176634E-019 * 1E+06); {$ENDIF}
  keV        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 1.602176634E-019 * 1E+03); {$ELSE} (1.602176634E-019 * 1E+03); {$ENDIF}

{ TNewtonMeter }

type
  TNewtonMeter = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sN.%sm';
    const FName              = '%snewton %smeter';
    const FPluralName        = '%snewton %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TNewtonMeterUnit = specialize TUnit<TNewtonMeter>;

{ TPoundForceInch }

type
  TPoundForceInch = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = 'lbf.in';
    const FName              = 'pound-force inch';
    const FPluralName        = 'pound-force inches';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TPoundForceInchUnit = specialize TUnit<TPoundForceInch>;

{ TRydberg }

type
  TRydberg = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sRy';
    const FName              = '%srydberg';
    const FPluralName        = '%srydbergs';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TRydbergUnit = specialize TUnit<TRydberg>;

const
  Ry         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 2.1798723611035E-18); {$ELSE} (2.1798723611035E-18); {$ENDIF}

{ TCalorie }

type
  TCalorie = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%scal';
    const FName              = '%scalorie';
    const FPluralName        = '%scalories';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TCalorieUnit = specialize TUnit<TCalorie>;

const
  cal        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 4.184); {$ELSE} (4.184); {$ENDIF}

const
  Mcal       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 4.184 * 1E+06); {$ELSE} (4.184 * 1E+06); {$ENDIF}
  kcal       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 55; FValue: 4.184 * 1E+03); {$ELSE} (4.184 * 1E+03); {$ENDIF}

{ TKilogramSquareMeterPerSquareSecond }

type
  TKilogramSquareMeterPerSquareSecond = record
    const FUnitOfMeasurement = cJoule;
    const FSymbol            = '%sg.%sm2/%ss2';
    const FName              = '%sgram square %smeter per square %ssecond';
    const FPluralName        = '%sgram square %smeters per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -2);
  end;
  TKilogramSquareMeterPerSquareSecondUnit = specialize TUnit<TKilogramSquareMeterPerSquareSecond>;

{ TJoulePerRadian }

const
  cJoulePerRadian = 56;

type
  TJoulePerRadian = record
    const FUnitOfMeasurement = cJoulePerRadian;
    const FSymbol            = '%sJ/rad';
    const FName              = '%sjoule per radian';
    const FPluralName        = '%sjoules per radian';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TJoulePerRadianUnit = specialize TUnit<TJoulePerRadian>;

{ TJoulePerDegree }

type
  TJoulePerDegree = record
    const FUnitOfMeasurement = cJoulePerRadian;
    const FSymbol            = '%sJ/deg';
    const FName              = '%sjoule per degree';
    const FPluralName        = '%sjoules per degree';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TJoulePerDegreeUnit = specialize TUnit<TJoulePerDegree>;

{ TNewtonMeterPerRadian }

type
  TNewtonMeterPerRadian = record
    const FUnitOfMeasurement = cJoulePerRadian;
    const FSymbol            = '%sN.%sm/rad';
    const FName              = '%snewton %smeter per radian';
    const FPluralName        = '%snewton %smeters per radian';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TNewtonMeterPerRadianUnit = specialize TUnit<TNewtonMeterPerRadian>;

{ TNewtonMeterPerDegree }

type
  TNewtonMeterPerDegree = record
    const FUnitOfMeasurement = cJoulePerRadian;
    const FSymbol            = '%sN.%sm/deg';
    const FName              = '%snewton %smeter per degree';
    const FPluralName        = '%snewton %smeters per degree';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TNewtonMeterPerDegreeUnit = specialize TUnit<TNewtonMeterPerDegree>;

{ TKilogramSquareMeterPerSquareSecondPerRadian }

type
  TKilogramSquareMeterPerSquareSecondPerRadian = record
    const FUnitOfMeasurement = cJoulePerRadian;
    const FSymbol            = '%sg.%sm2/%ss2/rad';
    const FName              = '%sgram square %smeter per square %ssecond per radian';
    const FPluralName        = '%sgram square %smeters per square %ssecond per radian';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -2);
  end;
  TKilogramSquareMeterPerSquareSecondPerRadianUnit = specialize TUnit<TKilogramSquareMeterPerSquareSecondPerRadian>;

{ TWatt }

const
  cWatt = 57;

type
  TWatt = record
    const FUnitOfMeasurement = cWatt;
    const FSymbol            = '%sW';
    const FName              = '%swatt';
    const FPluralName        = '%swatts';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TWattUnit = specialize TUnit<TWatt>;

var
  W          : TWattUnit;

const
  TW         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 57; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  GW         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 57; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  MW         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 57; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kW         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 57; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  milliW     : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 57; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

{ TKilogramSquareMeterPerCubicSecond }

type
  TKilogramSquareMeterPerCubicSecond = record
    const FUnitOfMeasurement = cWatt;
    const FSymbol            = '%sg.%sm2/%ss3';
    const FName              = '%sgram square %smeter per cubic %ssecond';
    const FPluralName        = '%sgram square %smeters per cubic %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -3);
  end;
  TKilogramSquareMeterPerCubicSecondUnit = specialize TUnit<TKilogramSquareMeterPerCubicSecond>;

{ TCoulomb }

const
  cCoulomb = 58;

type
  TCoulomb = record
    const FUnitOfMeasurement = cCoulomb;
    const FSymbol            = '%sC';
    const FName              = '%scoulomb';
    const FPluralName        = '%scoulombs';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TCoulombUnit = specialize TUnit<TCoulomb>;

var
  C          : TCoulombUnit;

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
  TAmpereHour = record
    const FUnitOfMeasurement = cCoulomb;
    const FSymbol            = '%sA.h';
    const FName              = '%sampere hour';
    const FPluralName        = '%sampere hours';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TAmpereHourUnit = specialize TUnit<TAmpereHour>;

{ TAmpereSecond }

type
  TAmpereSecond = record
    const FUnitOfMeasurement = cCoulomb;
    const FSymbol            = '%sA.%ss';
    const FName              = '%sampere %ssecond';
    const FPluralName        = '%sampere %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TAmpereSecondUnit = specialize TUnit<TAmpereSecond>;

{ TSquareCoulomb }

const
  cSquareCoulomb = 59;

type
  TSquareCoulomb = record
    const FUnitOfMeasurement = cSquareCoulomb;
    const FSymbol            = '%sC2';
    const FName              = 'square %scoulomb';
    const FPluralName        = 'square %scoulombs';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareCoulombUnit = specialize TUnit<TSquareCoulomb>;

var
  C2         : TSquareCoulombUnit;

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
  TSquareAmpereSquareSecond = record
    const FUnitOfMeasurement = cSquareCoulomb;
    const FSymbol            = '%sA2.%ss2';
    const FName              = 'square %sampere square %ssecond';
    const FPluralName        = 'square %sampere square %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 2);
  end;
  TSquareAmpereSquareSecondUnit = specialize TUnit<TSquareAmpereSquareSecond>;

{ TCoulombMeter }

const
  cCoulombMeter = 60;

type
  TCoulombMeter = record
    const FUnitOfMeasurement = cCoulombMeter;
    const FSymbol            = '%sC.%sm';
    const FName              = '%scoulomb %smeter';
    const FPluralName        = '%scoulomb %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TCoulombMeterUnit = specialize TUnit<TCoulombMeter>;

{ TVolt }

const
  cVolt = 61;

type
  TVolt = record
    const FUnitOfMeasurement = cVolt;
    const FSymbol            = '%sV';
    const FName              = '%svolt';
    const FPluralName        = '%svolts';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TVoltUnit = specialize TUnit<TVolt>;

var
  V          : TVoltUnit;

const
  kV         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 61; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mV         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 61; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}

{ TJoulePerCoulomb }

type
  TJoulePerCoulomb = record
    const FUnitOfMeasurement = cVolt;
    const FSymbol            = '%sJ/%sC';
    const FName              = '%sJoule per %scoulomb';
    const FPluralName        = '%sJoules per %scoulomb';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TJoulePerCoulombUnit = specialize TUnit<TJoulePerCoulomb>;

{ TKilogramSquareMeterPerAmperePerCubicSecond }

type
  TKilogramSquareMeterPerAmperePerCubicSecond = record
    const FUnitOfMeasurement = cVolt;
    const FSymbol            = '%sg.%sm2/%sA/%ss3';
    const FName              = '%sgram square %smeter per %sampere per cubic %ssecond';
    const FPluralName        = '%sgram square %smeters per %sampere per cubic %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -1, -3);
  end;
  TKilogramSquareMeterPerAmperePerCubicSecondUnit = specialize TUnit<TKilogramSquareMeterPerAmperePerCubicSecond>;

{ TSquareVolt }

const
  cSquareVolt = 62;

type
  TSquareVolt = record
    const FUnitOfMeasurement = cSquareVolt;
    const FSymbol            = '%sV2';
    const FName              = 'square %svolt';
    const FPluralName        = 'square %svolts';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareVoltUnit = specialize TUnit<TSquareVolt>;

var
  V2         : TSquareVoltUnit;

const
  kV2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 62; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  mV2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 62; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}

{ TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecond }

type
  TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecond = record
    const FUnitOfMeasurement = cSquareVolt;
    const FSymbol            = '%sg2.%sm3/%sA2/%ss6';
    const FName              = 'square %sgram quartic %smeter per square %sampere per sextic %ssecond';
    const FPluralName        = 'square %sgram quartic %smeters per square %sampere per sextic %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (2, 3, -2, -6);
  end;
  TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecondUnit = specialize TUnit<TSquareKilogramQuarticMeterPerSquareAmperePerSexticSecond>;

{ TFarad }

const
  cFarad = 63;

type
  TFarad = record
    const FUnitOfMeasurement = cFarad;
    const FSymbol            = '%sF';
    const FName              = '%sfarad';
    const FPluralName        = '%sfarads';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TFaradUnit = specialize TUnit<TFarad>;

var
  F          : TFaradUnit;

const
  mF         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 63; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miF        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 63; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nF         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 63; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pF         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 63; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TCoulombPerVolt }

type
  TCoulombPerVolt = record
    const FUnitOfMeasurement = cFarad;
    const FSymbol            = '%sC/%sV';
    const FName              = '%scoulomb per %svolt';
    const FPluralName        = '%scoulombs per %svolt';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TCoulombPerVoltUnit = specialize TUnit<TCoulombPerVolt>;

{ TSquareAmpereQuarticSecondPerKilogramPerSquareMeter }

type
  TSquareAmpereQuarticSecondPerKilogramPerSquareMeter = record
    const FUnitOfMeasurement = cFarad;
    const FSymbol            = '%sA2.%ss4/%sg/%sm2';
    const FName              = 'square %sampere quartic %ssecond per %sgram per square %smeter';
    const FPluralName        = 'square %sampere quartic %sseconds per %sgram per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pKilo, pNone);
    const FExponents         : TExponents = (2, 4, -1, -2);
  end;
  TSquareAmpereQuarticSecondPerKilogramPerSquareMeterUnit = specialize TUnit<TSquareAmpereQuarticSecondPerKilogramPerSquareMeter>;

{ TOhm }

const
  cOhm = 64;

type
  TOhm = record
    const FUnitOfMeasurement = cOhm;
    const FSymbol            = '%sΩ';
    const FName              = '%sohm';
    const FPluralName        = '%sohms';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TOhmUnit = specialize TUnit<TOhm>;

var
  ohm        : TOhmUnit;

const
  Gohm       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 64; FValue: 1E+09); {$ELSE} (1E+09); {$ENDIF}
  megaohm    : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 64; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}
  kohm       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 64; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mohm       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 64; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miohm      : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 64; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nohm       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 64; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TKilogramSquareMeterPerSquareAmperePerCubicSecond }

type
  TKilogramSquareMeterPerSquareAmperePerCubicSecond = record
    const FUnitOfMeasurement = cOhm;
    const FSymbol            = '%sg.%sm2/%sA/%ss3';
    const FName              = '%sgram square %smeter per square %sampere per cubic %ssecond';
    const FPluralName        = '%sgram square %smeters per square %sampere per cubic %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -1, -3);
  end;
  TKilogramSquareMeterPerSquareAmperePerCubicSecondUnit = specialize TUnit<TKilogramSquareMeterPerSquareAmperePerCubicSecond>;

{ TSiemens }

const
  cSiemens = 65;

type
  TSiemens = record
    const FUnitOfMeasurement = cSiemens;
    const FSymbol            = '%sS';
    const FName              = '%ssiemens';
    const FPluralName        = '%ssiemens';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TSiemensUnit = specialize TUnit<TSiemens>;

var
  siemens    : TSiemensUnit;

const
  millisiemens : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 65; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  microsiemens : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 65; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
   nanosiemens : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 65; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TSquareAmpereCubicSecondPerKilogramPerSquareMeter }

type
  TSquareAmpereCubicSecondPerKilogramPerSquareMeter = record
    const FUnitOfMeasurement = cSiemens;
    const FSymbol            = '%sA2.%ss3/%sg/%sm2';
    const FName              = 'square %sampere cubic %ssecond per %sgram per square %smeter';
    const FPluralName        = 'square %sampere cubic %sseconds per %sgram per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pKilo, pNone);
    const FExponents         : TExponents = (2, 3, -1, -2);
  end;
  TSquareAmpereCubicSecondPerKilogramPerSquareMeterUnit = specialize TUnit<TSquareAmpereCubicSecondPerKilogramPerSquareMeter>;

{ TSiemensPerMeter }

const
  cSiemensPerMeter = 66;

type
  TSiemensPerMeter = record
    const FUnitOfMeasurement = cSiemensPerMeter;
    const FSymbol            = '%sS/%sm';
    const FName              = '%ssiemens per %smeter';
    const FPluralName        = '%ssiemens per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TSiemensPerMeterUnit = specialize TUnit<TSiemensPerMeter>;

{ TTesla }

const
  cTesla = 67;

type
  TTesla = record
    const FUnitOfMeasurement = cTesla;
    const FSymbol            = '%sT';
    const FName              = '%stesla';
    const FPluralName        = '%steslas';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TTeslaUnit = specialize TUnit<TTesla>;

var
  T          : TTeslaUnit;

const
  mT         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 67; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miT        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 67; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nT         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 67; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TWeberPerSquareMeter }

type
  TWeberPerSquareMeter = record
    const FUnitOfMeasurement = cTesla;
    const FSymbol            = '%sWb/%m2';
    const FName              = '%sweber per square %smeter';
    const FPluralName        = '%swebers per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TWeberPerSquareMeterUnit = specialize TUnit<TWeberPerSquareMeter>;

{ TKilogramPerAmperePerSquareSecond }

type
  TKilogramPerAmperePerSquareSecond = record
    const FUnitOfMeasurement = cTesla;
    const FSymbol            = '%sg/%sA/%ss2';
    const FName              = '%sgram per %sampere per square %ssecond';
    const FPluralName        = '%sgrams per %sampere per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, -1, -2);
  end;
  TKilogramPerAmperePerSquareSecondUnit = specialize TUnit<TKilogramPerAmperePerSquareSecond>;

{ TWeber }

const
  cWeber = 68;

type
  TWeber = record
    const FUnitOfMeasurement = cWeber;
    const FSymbol            = '%sWb';
    const FName              = '%sweber';
    const FPluralName        = '%swebers';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TWeberUnit = specialize TUnit<TWeber>;

var
  Wb         : TWeberUnit;

{ TKilogramSquareMeterPerAmperePerSquareSecond }

type
  TKilogramSquareMeterPerAmperePerSquareSecond = record
    const FUnitOfMeasurement = cWeber;
    const FSymbol            = '%sg.%sm2/%sA/%ss2';
    const FName              = '%sgram square %smeter per %sampere per square %ssecond';
    const FPluralName        = '%sgram square %smeters per %sampere per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -1, -2);
  end;
  TKilogramSquareMeterPerAmperePerSquareSecondUnit = specialize TUnit<TKilogramSquareMeterPerAmperePerSquareSecond>;

{ THenry }

const
  cHenry = 69;

type
  THenry = record
    const FUnitOfMeasurement = cHenry;
    const FSymbol            = '%sH';
    const FName              = '%shenry';
    const FPluralName        = '%shenries';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  THenryUnit = specialize TUnit<THenry>;

var
  H          : THenryUnit;

const
  mH         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 69; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miH        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 69; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nH         : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 69; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}

{ TKilogramSquareMeterPerSquareAmperePerSquareSecond }

type
  TKilogramSquareMeterPerSquareAmperePerSquareSecond = record
    const FUnitOfMeasurement = cHenry;
    const FSymbol            = '%sg.%sm2/%sA2/%ss2';
    const FName              = '%sgram square %smeter per square %sampere per square %ssecond';
    const FPluralName        = '%sgram square %smeters per square %sampere per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -2, -2);
  end;
  TKilogramSquareMeterPerSquareAmperePerSquareSecondUnit = specialize TUnit<TKilogramSquareMeterPerSquareAmperePerSquareSecond>;

{ TReciprocalHenry }

const
  cReciprocalHenry = 70;

type
  TReciprocalHenry = record
    const FUnitOfMeasurement = cReciprocalHenry;
    const FSymbol            = '1/%sH';
    const FName              = 'reciprocal %shenry';
    const FPluralName        = 'reciprocal %shenries';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalHenryUnit = specialize TUnit<TReciprocalHenry>;

{ TLumen }

const
  cLumen = 71;

type
  TLumen = record
    const FUnitOfMeasurement = cLumen;
    const FSymbol            = '%slm';
    const FName              = '%slumen';
    const FPluralName        = '%slumens';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TLumenUnit = specialize TUnit<TLumen>;

var
  lm         : TLumenUnit;

{ TCandelaSteradian }

type
  TCandelaSteradian = record
    const FUnitOfMeasurement = cLumen;
    const FSymbol            = '%scd.%ssr';
    const FName              = '%scandela %ssteradian';
    const FPluralName        = '%scandela %ssteradians';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TCandelaSteradianUnit = specialize TUnit<TCandelaSteradian>;

{ TLumenSecond }

const
  cLumenSecond = 72;

type
  TLumenSecond = record
    const FUnitOfMeasurement = cLumenSecond;
    const FSymbol            = '%slm.%ss';
    const FName              = '%slumen %ssecond';
    const FPluralName        = '%slumen %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TLumenSecondUnit = specialize TUnit<TLumenSecond>;

{ TLumenSecondPerCubicMeter }

const
  cLumenSecondPerCubicMeter = 73;

type
  TLumenSecondPerCubicMeter = record
    const FUnitOfMeasurement = cLumenSecondPerCubicMeter;
    const FSymbol            = '%slm.%ss/%sm3';
    const FName              = '%slumen %ssecond per cubic meter';
    const FPluralName        = '%slumen %sseconds per cubic meter';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -3);
  end;
  TLumenSecondPerCubicMeterUnit = specialize TUnit<TLumenSecondPerCubicMeter>;

{ TLux }

const
  cLux = 74;

type
  TLux = record
    const FUnitOfMeasurement = cLux;
    const FSymbol            = '%slx';
    const FName              = '%slux';
    const FPluralName        = '%slux';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TLuxUnit = specialize TUnit<TLux>;

var
  lx         : TLuxUnit;

{ TCandelaSteradianPerSquareMeter }

type
  TCandelaSteradianPerSquareMeter = record
    const FUnitOfMeasurement = cLux;
    const FSymbol            = '%scd.%ssr/%sm2';
    const FName              = '%scandela %ssteradian per square %smeter';
    const FPluralName        = '%scandela %ssteradians per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -2);
  end;
  TCandelaSteradianPerSquareMeterUnit = specialize TUnit<TCandelaSteradianPerSquareMeter>;

{ TLuxSecond }

const
  cLuxSecond = 75;

type
  TLuxSecond = record
    const FUnitOfMeasurement = cLuxSecond;
    const FSymbol            = '%slx.%ss';
    const FName              = '%slux %ssecond';
    const FPluralName        = '%slux %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TLuxSecondUnit = specialize TUnit<TLuxSecond>;

{ TBequerel }

type
  TBequerel = record
    const FUnitOfMeasurement = cHertz;
    const FSymbol            = '%sBq';
    const FName              = '%sbequerel';
    const FPluralName        = '%sbequerels';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TBequerelUnit = specialize TUnit<TBequerel>;

var
  Bq         : TBequerelUnit;

const
  kBq        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E+03); {$ELSE} (1E+03); {$ENDIF}
  mBq        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miBq       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}
  nBq        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E-09); {$ELSE} (1E-09); {$ENDIF}
  pBq        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 24; FValue: 1E-12); {$ELSE} (1E-12); {$ENDIF}

{ TKatal }

const
  cKatal = 76;

type
  TKatal = record
    const FUnitOfMeasurement = cKatal;
    const FSymbol            = '%skat';
    const FName              = '%skatal';
    const FPluralName        = '%skatals';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TKatalUnit = specialize TUnit<TKatal>;

var
  kat        : TKatalUnit;

{ TMolePerSecond }

type
  TMolePerSecond = record
    const FUnitOfMeasurement = cKatal;
    const FSymbol            = '%smol/%ss';
    const FName              = '%smole per %ssecond';
    const FPluralName        = '%smoles per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TMolePerSecondUnit = specialize TUnit<TMolePerSecond>;

{ TNewtonPerCubicMeter }

const
  cNewtonPerCubicMeter = 77;

type
  TNewtonPerCubicMeter = record
    const FUnitOfMeasurement = cNewtonPerCubicMeter;
    const FSymbol            = '%sN/%sm3';
    const FName              = '%snewton per cubic %smeter';
    const FPluralName        = '%snewtons per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TNewtonPerCubicMeterUnit = specialize TUnit<TNewtonPerCubicMeter>;

{ TPascalPerMeter }

type
  TPascalPerMeter = record
    const FUnitOfMeasurement = cNewtonPerCubicMeter;
    const FSymbol            = '%sPa/%sm';
    const FName              = '%spascal per %smeter';
    const FPluralName        = '%spascals per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TPascalPerMeterUnit = specialize TUnit<TPascalPerMeter>;

{ TKilogramPerSquareMeterPerSquareSecond }

type
  TKilogramPerSquareMeterPerSquareSecond = record
    const FUnitOfMeasurement = cNewtonPerCubicMeter;
    const FSymbol            = '%sg/%sm2/%ss2';
    const FName              = '%sgram per square %smeter per square %ssecond';
    const FPluralName        = '%sgrams per square %smeter per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, -2, -2);
  end;
  TKilogramPerSquareMeterPerSquareSecondUnit = specialize TUnit<TKilogramPerSquareMeterPerSquareSecond>;

{ TNewtonPerMeter }

const
  cNewtonPerMeter = 78;

type
  TNewtonPerMeter = record
    const FUnitOfMeasurement = cNewtonPerMeter;
    const FSymbol            = '%sN/%sm';
    const FName              = '%snewton per %smeter';
    const FPluralName        = '%snewtons per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TNewtonPerMeterUnit = specialize TUnit<TNewtonPerMeter>;

{ TJoulePerSquareMeter }

type
  TJoulePerSquareMeter = record
    const FUnitOfMeasurement = cNewtonPerMeter;
    const FSymbol            = '%sJ/%sm2';
    const FName              = '%sjoule per square %smeter';
    const FPluralName        = '%sjoules per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TJoulePerSquareMeterUnit = specialize TUnit<TJoulePerSquareMeter>;

{ TWattPerSquareMeterPerHertz }

type
  TWattPerSquareMeterPerHertz = record
    const FUnitOfMeasurement = cNewtonPerMeter;
    const FSymbol            = '%sW/%sm2/%sHz';
    const FName              = '%swatt per square %smeter per %shertz';
    const FPluralName        = '%swatts per square %smeter per %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -2, -1);
  end;
  TWattPerSquareMeterPerHertzUnit = specialize TUnit<TWattPerSquareMeterPerHertz>;

{ TPoundForcePerInch }

type
  TPoundForcePerInch = record
    const FUnitOfMeasurement = cNewtonPerMeter;
    const FSymbol            = 'lbf/in';
    const FName              = 'pound-force per inch';
    const FPluralName        = 'pounds-force per inch';
    const FPrefixes          : TPrefixes  = ();
    const FExponents         : TExponents = ();
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TPoundForcePerInchUnit = specialize TUnit<TPoundForcePerInch>;

{ TKilogramPerSquareSecond }

type
  TKilogramPerSquareSecond = record
    const FUnitOfMeasurement = cNewtonPerMeter;
    const FSymbol            = '%sg/%ss2';
    const FName              = '%sgram per square %ssecond';
    const FPluralName        = '%sgrams per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TKilogramPerSquareSecondUnit = specialize TUnit<TKilogramPerSquareSecond>;

{ TCubicMeterPerSecond }

const
  cCubicMeterPerSecond = 79;

type
  TCubicMeterPerSecond = record
    const FUnitOfMeasurement = cCubicMeterPerSecond;
    const FSymbol            = '%sm3/%ss';
    const FName              = 'cubic %smeter per %ssecond';
    const FPluralName        = 'cubic %smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (3, -1);
  end;
  TCubicMeterPerSecondUnit = specialize TUnit<TCubicMeterPerSecond>;

{ TPoiseuille }

const
  cPoiseuille = 80;

type
  TPoiseuille = record
    const FUnitOfMeasurement = cPoiseuille;
    const FSymbol            = '%sPl';
    const FName              = '%spoiseuille';
    const FPluralName        = '%spoiseuilles';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TPoiseuilleUnit = specialize TUnit<TPoiseuille>;

var
  Pl         : TPoiseuilleUnit;

const
  cPl        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 80; FValue: 1E-02); {$ELSE} (1E-02); {$ENDIF}
  mPl        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 80; FValue: 1E-03); {$ELSE} (1E-03); {$ENDIF}
  miPl       : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 80; FValue: 1E-06); {$ELSE} (1E-06); {$ENDIF}

{ TPascalSecond }

type
  TPascalSecond = record
    const FUnitOfMeasurement = cPoiseuille;
    const FSymbol            = '%sPa.%ss';
    const FName              = '%spascal %ssecond';
    const FPluralName        = '%spascal %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TPascalSecondUnit = specialize TUnit<TPascalSecond>;

{ TKilogramPerMeterPerSecond }

type
  TKilogramPerMeterPerSecond = record
    const FUnitOfMeasurement = cPoiseuille;
    const FSymbol            = '%sg/%sm/%ss';
    const FName              = '%sgram per %smeter per %ssecond';
    const FPluralName        = '%sgrams per %smeter per %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, -1, -1);
  end;
  TKilogramPerMeterPerSecondUnit = specialize TUnit<TKilogramPerMeterPerSecond>;

{ TSquareMeterPerSecond }

const
  cSquareMeterPerSecond = 81;

type
  TSquareMeterPerSecond = record
    const FUnitOfMeasurement = cSquareMeterPerSecond;
    const FSymbol            = '%sm2/%ss';
    const FName              = 'square %smeter per %ssecond';
    const FPluralName        = 'square %smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, -1);
  end;
  TSquareMeterPerSecondUnit = specialize TUnit<TSquareMeterPerSecond>;

{ TKilogramPerQuarticMeter }

const
  cKilogramPerQuarticMeter = 82;

type
  TKilogramPerQuarticMeter = record
    const FUnitOfMeasurement = cKilogramPerQuarticMeter;
    const FSymbol            = '%sg/%sm4';
    const FName              = '%sgram per quartic %smeter';
    const FPluralName        = '%sgrams per quartic %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -4);
  end;
  TKilogramPerQuarticMeterUnit = specialize TUnit<TKilogramPerQuarticMeter>;

{ TQuarticMeterSecond }

const
  cQuarticMeterSecond = 83;

type
  TQuarticMeterSecond = record
    const FUnitOfMeasurement = cQuarticMeterSecond;
    const FSymbol            = '%sm4.%ss';
    const FName              = 'quartic %smeter %ssecond';
    const FPluralName        = 'quartic %smeter %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (4, 1);
  end;
  TQuarticMeterSecondUnit = specialize TUnit<TQuarticMeterSecond>;

{ TKilogramPerQuarticMeterPerSecond }

const
  cKilogramPerQuarticMeterPerSecond = 84;

type
  TKilogramPerQuarticMeterPerSecond = record
    const FUnitOfMeasurement = cKilogramPerQuarticMeterPerSecond;
    const FSymbol            = '%sg/%sm4/%ss';
    const FName              = '%sgram per quartic %smeter per %ssecond';
    const FPluralName        = '%sgrams per quartic %smeter per %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, -4, -1);
  end;
  TKilogramPerQuarticMeterPerSecondUnit = specialize TUnit<TKilogramPerQuarticMeterPerSecond>;

{ TCubicMeterPerKilogram }

const
  cCubicMeterPerKilogram = 85;

type
  TCubicMeterPerKilogram = record
    const FUnitOfMeasurement = cCubicMeterPerKilogram;
    const FSymbol            = '%sm3/%sg';
    const FName              = 'cubic %smeter per %sgram';
    const FPluralName        = 'cubic %smeters per %sgram';
    const FPrefixes          : TPrefixes  = (pNone, pKilo);
    const FExponents         : TExponents = (3, -1);
  end;
  TCubicMeterPerKilogramUnit = specialize TUnit<TCubicMeterPerKilogram>;

{ TKilogramSquareSecond }

const
  cKilogramSquareSecond = 86;

type
  TKilogramSquareSecond = record
    const FUnitOfMeasurement = cKilogramSquareSecond;
    const FSymbol            = '%sg.%ss2';
    const FName              = '%sgram square %ssecond';
    const FPluralName        = '%sgram square %sseconds';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, 2);
  end;
  TKilogramSquareSecondUnit = specialize TUnit<TKilogramSquareSecond>;

{ TCubicMeterPerSquareSecond }

const
  cCubicMeterPerSquareSecond = 87;

type
  TCubicMeterPerSquareSecond = record
    const FUnitOfMeasurement = cCubicMeterPerSquareSecond;
    const FSymbol            = '%sm3/%ss2';
    const FName              = 'cubic %smeter per square %ssecond';
    const FPluralName        = 'cubic %smeters per square %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (3, -2);
  end;
  TCubicMeterPerSquareSecondUnit = specialize TUnit<TCubicMeterPerSquareSecond>;

{ TNewtonSquareMeter }

const
  cNewtonSquareMeter = 88;

type
  TNewtonSquareMeter = record
    const FUnitOfMeasurement = cNewtonSquareMeter;
    const FSymbol            = '%sN.%sm2';
    const FName              = '%snewton square %smeter';
    const FPluralName        = '%snewton square %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 2);
  end;
  TNewtonSquareMeterUnit = specialize TUnit<TNewtonSquareMeter>;

{ TKilogramCubicMeterPerSquareSecond }

type
  TKilogramCubicMeterPerSquareSecond = record
    const FUnitOfMeasurement = cNewtonSquareMeter;
    const FSymbol            = '%sg.%sm3/%ss2';
    const FName              = '%sgram cubic %smeter per square %ssecond';
    const FPluralName        = '%sgram cubic %smeters per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 3, -2);
  end;
  TKilogramCubicMeterPerSquareSecondUnit = specialize TUnit<TKilogramCubicMeterPerSquareSecond>;

{ TNewtonCubicMeter }

const
  cNewtonCubicMeter = 89;

type
  TNewtonCubicMeter = record
    const FUnitOfMeasurement = cNewtonCubicMeter;
    const FSymbol            = '%sN.%sm3';
    const FName              = '%snewton cubic %smeter';
    const FPluralName        = '%snewton cubic %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 3);
  end;
  TNewtonCubicMeterUnit = specialize TUnit<TNewtonCubicMeter>;

{ TKilogramQuarticMeterPerSquareSecond }

type
  TKilogramQuarticMeterPerSquareSecond = record
    const FUnitOfMeasurement = cNewtonCubicMeter;
    const FSymbol            = '%sg.%sm4/%ss2';
    const FName              = '%sgram quartic %smeter per square %ssecond';
    const FPluralName        = '%sgram quartic %smeters per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 4, -2);
  end;
  TKilogramQuarticMeterPerSquareSecondUnit = specialize TUnit<TKilogramQuarticMeterPerSquareSecond>;

{ TNewtonPerSquareKilogram }

const
  cNewtonPerSquareKilogram = 90;

type
  TNewtonPerSquareKilogram = record
    const FUnitOfMeasurement = cNewtonPerSquareKilogram;
    const FSymbol            = '%sN/%sg2';
    const FName              = '%snewton per square %sgram';
    const FPluralName        = '%snewtons per square %sgram';
    const FPrefixes          : TPrefixes  = (pNone, pKilo);
    const FExponents         : TExponents = (1, -2);
  end;
  TNewtonPerSquareKilogramUnit = specialize TUnit<TNewtonPerSquareKilogram>;

{ TMeterPerKilogramPerSquareSecond }

type
  TMeterPerKilogramPerSquareSecond = record
    const FUnitOfMeasurement = cNewtonPerSquareKilogram;
    const FSymbol            = '%sm/%sg/%ss2';
    const FName              = '%smeter per %sgram per square %ssecond';
    const FPluralName        = '%smeters per %sgram per square %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pKilo, pNone);
    const FExponents         : TExponents = (1, -1, -2);
  end;
  TMeterPerKilogramPerSquareSecondUnit = specialize TUnit<TMeterPerKilogramPerSquareSecond>;

{ TSquareKilogramPerMeter }

const
  cSquareKilogramPerMeter = 91;

type
  TSquareKilogramPerMeter = record
    const FUnitOfMeasurement = cSquareKilogramPerMeter;
    const FSymbol            = '%sg2/%sm';
    const FName              = 'square %sgram per %smeter';
    const FPluralName        = 'square %sgrams per %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (2, -1);
  end;
  TSquareKilogramPerMeterUnit = specialize TUnit<TSquareKilogramPerMeter>;

{ TSquareKilogramPerSquareMeter }

const
  cSquareKilogramPerSquareMeter = 92;

type
  TSquareKilogramPerSquareMeter = record
    const FUnitOfMeasurement = cSquareKilogramPerSquareMeter;
    const FSymbol            = '%sg2/%sm2';
    const FName              = 'square %sgram per square %smeter';
    const FPluralName        = 'square %sgrams per square %smeter';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareKilogramPerSquareMeterUnit = specialize TUnit<TSquareKilogramPerSquareMeter>;

{ TSquareMeterPerSquareKilogram }

const
  cSquareMeterPerSquareKilogram = 93;

type
  TSquareMeterPerSquareKilogram = record
    const FUnitOfMeasurement = cSquareMeterPerSquareKilogram;
    const FSymbol            = '%sm2/%sg2';
    const FName              = 'square %smeter per square %sgram';
    const FPluralName        = 'square %smeters per square %sgram';
    const FPrefixes          : TPrefixes  = (pNone, pKilo);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareMeterPerSquareKilogramUnit = specialize TUnit<TSquareMeterPerSquareKilogram>;

{ TNewtonSquareMeterPerSquareKilogram }

const
  cNewtonSquareMeterPerSquareKilogram = 94;

type
  TNewtonSquareMeterPerSquareKilogram = record
    const FUnitOfMeasurement = cNewtonSquareMeterPerSquareKilogram;
    const FSymbol            = '%sN.%sm2/%sg2';
    const FName              = '%snewton square %smeter per square %sgram';
    const FPluralName        = '%snewton square %smeters per square %sgram';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pKilo);
    const FExponents         : TExponents = (1, 2, -2);
  end;
  TNewtonSquareMeterPerSquareKilogramUnit = specialize TUnit<TNewtonSquareMeterPerSquareKilogram>;

{ TCubicMeterPerKilogramPerSquareSecond }

type
  TCubicMeterPerKilogramPerSquareSecond = record
    const FUnitOfMeasurement = cNewtonSquareMeterPerSquareKilogram;
    const FSymbol            = '%sm3/%sg/%ss2';
    const FName              = 'cubic %smeter per %sgram per square %ssecond';
    const FPluralName        = 'cubic %smeters per %sgram per square %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pKilo, pNone);
    const FExponents         : TExponents = (3, -1, -2);
  end;
  TCubicMeterPerKilogramPerSquareSecondUnit = specialize TUnit<TCubicMeterPerKilogramPerSquareSecond>;

{ TReciprocalKelvin }

const
  cReciprocalKelvin = 95;

type
  TReciprocalKelvin = record
    const FUnitOfMeasurement = cReciprocalKelvin;
    const FSymbol            = '1/%sK';
    const FName              = 'reciprocal %skelvin';
    const FPluralName        = 'reciprocal %skelvin';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalKelvinUnit = specialize TUnit<TReciprocalKelvin>;

{ TKilogramKelvin }

const
  cKilogramKelvin = 96;

type
  TKilogramKelvin = record
    const FUnitOfMeasurement = cKilogramKelvin;
    const FSymbol            = '%sg.%sK';
    const FName              = '%sgram %skelvin';
    const FPluralName        = '%sgram %skelvins';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TKilogramKelvinUnit = specialize TUnit<TKilogramKelvin>;

{ TJoulePerKelvin }

const
  cJoulePerKelvin = 97;

type
  TJoulePerKelvin = record
    const FUnitOfMeasurement = cJoulePerKelvin;
    const FSymbol            = '%sJ/%sK';
    const FName              = '%sjoule per %skelvin';
    const FPluralName        = '%sjoules per %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TJoulePerKelvinUnit = specialize TUnit<TJoulePerKelvin>;

{ TKilogramSquareMeterPerSquareSecondPerKelvin }

type
  TKilogramSquareMeterPerSquareSecondPerKelvin = record
    const FUnitOfMeasurement = cJoulePerKelvin;
    const FSymbol            = '%sg.%sm2/%ss2/%sK';
    const FName              = '%sgram square %smeter per square %ssecond per %skelvin';
    const FPluralName        = '%sgram square %smeters per square %ssecond per %skelvin';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -2, -1);
  end;
  TKilogramSquareMeterPerSquareSecondPerKelvinUnit = specialize TUnit<TKilogramSquareMeterPerSquareSecondPerKelvin>;

{ TJoulePerKilogramPerKelvin }

const
  cJoulePerKilogramPerKelvin = 98;

type
  TJoulePerKilogramPerKelvin = record
    const FUnitOfMeasurement = cJoulePerKilogramPerKelvin;
    const FSymbol            = '%sJ/%sg/%sK';
    const FName              = '%sjoule per %sgram per %skelvin';
    const FPluralName        = '%sjoules per %sgram per %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pKilo, pNone);
    const FExponents         : TExponents = (1, -1, -1);
  end;
  TJoulePerKilogramPerKelvinUnit = specialize TUnit<TJoulePerKilogramPerKelvin>;

{ TSquareMeterPerSquareSecondPerKelvin }

type
  TSquareMeterPerSquareSecondPerKelvin = record
    const FUnitOfMeasurement = cJoulePerKilogramPerKelvin;
    const FSymbol            = '%sm2/%ss2/%sK';
    const FName              = 'square %smeter per square %ssecond per %skelvin';
    const FPluralName        = 'square %smeters per square %ssecond per %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (2, -2, -1);
  end;
  TSquareMeterPerSquareSecondPerKelvinUnit = specialize TUnit<TSquareMeterPerSquareSecondPerKelvin>;

{ TMeterKelvin }

const
  cMeterKelvin = 99;

type
  TMeterKelvin = record
    const FUnitOfMeasurement = cMeterKelvin;
    const FSymbol            = '%sm.%sK';
    const FName              = '%smeter %skelvin';
    const FPluralName        = '%smeter %skelvins';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TMeterKelvinUnit = specialize TUnit<TMeterKelvin>;

{ TKelvinPerMeter }

const
  cKelvinPerMeter = 100;

type
  TKelvinPerMeter = record
    const FUnitOfMeasurement = cKelvinPerMeter;
    const FSymbol            = '%sK/%sm';
    const FName              = '%skelvin per %smeter';
    const FPluralName        = '%skelvins per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TKelvinPerMeterUnit = specialize TUnit<TKelvinPerMeter>;

{ TWattPerMeter }

const
  cWattPerMeter = 101;

type
  TWattPerMeter = record
    const FUnitOfMeasurement = cWattPerMeter;
    const FSymbol            = '%sW/%sm';
    const FName              = '%swatt per %smeter';
    const FPluralName        = '%swatts per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TWattPerMeterUnit = specialize TUnit<TWattPerMeter>;

{ TKilogramMeterPerCubicSecond }

type
  TKilogramMeterPerCubicSecond = record
    const FUnitOfMeasurement = cWattPerMeter;
    const FSymbol            = '%sg.%sm/%ss3';
    const FName              = '%sgram %smeter per cubic %ssecond';
    const FPluralName        = '%sgram %smeters per cubic %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -3);
  end;
  TKilogramMeterPerCubicSecondUnit = specialize TUnit<TKilogramMeterPerCubicSecond>;

{ TWattPerSquareMeter }

const
  cWattPerSquareMeter = 102;

type
  TWattPerSquareMeter = record
    const FUnitOfMeasurement = cWattPerSquareMeter;
    const FSymbol            = '%sW/%sm2';
    const FName              = '%swatt per square %smeter';
    const FPluralName        = '%swatts per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TWattPerSquareMeterUnit = specialize TUnit<TWattPerSquareMeter>;

{ TKilogramPerCubicSecond }

type
  TKilogramPerCubicSecond = record
    const FUnitOfMeasurement = cWattPerSquareMeter;
    const FSymbol            = '%sg/%ss3';
    const FName              = '%sgram per cubic %ssecond';
    const FPluralName        = '%sgrams per cubic %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TKilogramPerCubicSecondUnit = specialize TUnit<TKilogramPerCubicSecond>;

{ TWattPerCubicMeter }

const
  cWattPerCubicMeter = 103;

type
  TWattPerCubicMeter = record
    const FUnitOfMeasurement = cWattPerCubicMeter;
    const FSymbol            = '%sW/%sm3';
    const FName              = '%swatt per cubic %smeter';
    const FPluralName        = '%swatts per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TWattPerCubicMeterUnit = specialize TUnit<TWattPerCubicMeter>;

{ TWattPerKelvin }

const
  cWattPerKelvin = 104;

type
  TWattPerKelvin = record
    const FUnitOfMeasurement = cWattPerKelvin;
    const FSymbol            = '%sW/%sK';
    const FName              = '%swatt per %skelvin';
    const FPluralName        = '%swatts per %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TWattPerKelvinUnit = specialize TUnit<TWattPerKelvin>;

{ TKilogramSquareMeterPerCubicSecondPerKelvin }

type
  TKilogramSquareMeterPerCubicSecondPerKelvin = record
    const FUnitOfMeasurement = cWattPerKelvin;
    const FSymbol            = '%sg.%sm2/%ss3/%sK';
    const FName              = '%sgram square %smeter per cubic %ssecond per %skelvin';
    const FPluralName        = '%sgram square %smeters per cubic %ssecond per %skelvin';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -3, -1);
  end;
  TKilogramSquareMeterPerCubicSecondPerKelvinUnit = specialize TUnit<TKilogramSquareMeterPerCubicSecondPerKelvin>;

{ TWattPerMeterPerKelvin }

const
  cWattPerMeterPerKelvin = 105;

type
  TWattPerMeterPerKelvin = record
    const FUnitOfMeasurement = cWattPerMeterPerKelvin;
    const FSymbol            = '%sW/%sm/%sK';
    const FName              = '%swatt per %smeter per %skelvin';
    const FPluralName        = '%swatts per %smeter per %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -1, -1);
  end;
  TWattPerMeterPerKelvinUnit = specialize TUnit<TWattPerMeterPerKelvin>;

{ TKilogramMeterPerCubicSecondPerKelvin }

type
  TKilogramMeterPerCubicSecondPerKelvin = record
    const FUnitOfMeasurement = cWattPerMeterPerKelvin;
    const FSymbol            = '%sg.%sm/%ss3/%sK';
    const FName              = '%sgram %smeter per cubic %ssecond per %skelvin';
    const FPluralName        = '%sgram %smeters per cubic %ssecond per %skelvin';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -3, -1);
  end;
  TKilogramMeterPerCubicSecondPerKelvinUnit = specialize TUnit<TKilogramMeterPerCubicSecondPerKelvin>;

{ TKelvinPerWatt }

const
  cKelvinPerWatt = 106;

type
  TKelvinPerWatt = record
    const FUnitOfMeasurement = cKelvinPerWatt;
    const FSymbol            = '%sK/%sW';
    const FName              = '%skelvin per %swatt';
    const FPluralName        = '%skelvins per %swatt';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TKelvinPerWattUnit = specialize TUnit<TKelvinPerWatt>;

{ TMeterPerWatt }

const
  cMeterPerWatt = 107;

type
  TMeterPerWatt = record
    const FUnitOfMeasurement = cMeterPerWatt;
    const FSymbol            = '%sm/%sW';
    const FName              = '%smeter per %swatt';
    const FPluralName        = '%smeters per %swatts';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TMeterPerWattUnit = specialize TUnit<TMeterPerWatt>;

{ TMeterKelvinPerWatt }

const
  cMeterKelvinPerWatt = 108;

type
  TMeterKelvinPerWatt = record
    const FUnitOfMeasurement = cMeterKelvinPerWatt;
    const FSymbol            = '%sK.%sm/%sW';
    const FName              = '%skelvin %smeter per %swatt';
    const FPluralName        = '%skelvin %smeters per %swatt';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -1);
  end;
  TMeterKelvinPerWattUnit = specialize TUnit<TMeterKelvinPerWatt>;

{ TSquareMeterKelvin }

const
  cSquareMeterKelvin = 109;

type
  TSquareMeterKelvin = record
    const FUnitOfMeasurement = cSquareMeterKelvin;
    const FSymbol            = '%sm2.%sK';
    const FName              = 'square %smeter %skelvin';
    const FPluralName        = 'square %smeter %skelvins';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 1);
  end;
  TSquareMeterKelvinUnit = specialize TUnit<TSquareMeterKelvin>;

{ TWattPerSquareMeterPerKelvin }

const
  cWattPerSquareMeterPerKelvin = 110;

type
  TWattPerSquareMeterPerKelvin = record
    const FUnitOfMeasurement = cWattPerSquareMeterPerKelvin;
    const FSymbol            = '%sW/%sm2/%sK';
    const FName              = '%swatt per square %smeter per %skelvin';
    const FPluralName        = '%swatts per square %smeter per %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -2, -1);
  end;
  TWattPerSquareMeterPerKelvinUnit = specialize TUnit<TWattPerSquareMeterPerKelvin>;

{ TKilogramPerCubicSecondPerKelvin }

type
  TKilogramPerCubicSecondPerKelvin = record
    const FUnitOfMeasurement = cWattPerSquareMeterPerKelvin;
    const FSymbol            = '%sg/%ss3/%sK';
    const FName              = '%sgram per cubic %ssecond per %skelvin';
    const FPluralName        = '%sgrams per cubic %ssecond per %skelvin';
    const FPrefixes          : TPrefixes  = (pKilo, pNone, pNone);
    const FExponents         : TExponents = (1, -3, -1);
  end;
  TKilogramPerCubicSecondPerKelvinUnit = specialize TUnit<TKilogramPerCubicSecondPerKelvin>;

{ TSquareMeterQuarticKelvin }

const
  cSquareMeterQuarticKelvin = 111;

type
  TSquareMeterQuarticKelvin = record
    const FUnitOfMeasurement = cSquareMeterQuarticKelvin;
    const FSymbol            = '%sm2.%sK4';
    const FName              = 'square %smeter quartic %skelvin';
    const FPluralName        = 'square %smeter quartic %skelvins';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 4);
  end;
  TSquareMeterQuarticKelvinUnit = specialize TUnit<TSquareMeterQuarticKelvin>;

{ TWattPerQuarticKelvin }

const
  cWattPerQuarticKelvin = 112;

type
  TWattPerQuarticKelvin = record
    const FUnitOfMeasurement = cWattPerQuarticKelvin;
    const FSymbol            = '%sW/%sK4';
    const FName              = '%swatt per quartic %skelvin';
    const FPluralName        = '%swatts per quartic %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -4);
  end;
  TWattPerQuarticKelvinUnit = specialize TUnit<TWattPerQuarticKelvin>;

{ TWattPerSquareMeterPerQuarticKelvin }

const
  cWattPerSquareMeterPerQuarticKelvin = 113;

type
  TWattPerSquareMeterPerQuarticKelvin = record
    const FUnitOfMeasurement = cWattPerSquareMeterPerQuarticKelvin;
    const FSymbol            = '%sW/%sm2/%sK4';
    const FName              = '%swatt per square %smeter per quartic %skelvin';
    const FPluralName        = '%swatts per square %smeter per quartic %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -2, -4);
  end;
  TWattPerSquareMeterPerQuarticKelvinUnit = specialize TUnit<TWattPerSquareMeterPerQuarticKelvin>;

{ TJoulePerMole }

const
  cJoulePerMole = 114;

type
  TJoulePerMole = record
    const FUnitOfMeasurement = cJoulePerMole;
    const FSymbol            = '%sJ/%smol';
    const FName              = '%sjoule per %smole';
    const FPluralName        = '%sjoules per %smole';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TJoulePerMoleUnit = specialize TUnit<TJoulePerMole>;

{ TMoleKelvin }

const
  cMoleKelvin = 115;

type
  TMoleKelvin = record
    const FUnitOfMeasurement = cMoleKelvin;
    const FSymbol            = '%smol.%sK';
    const FName              = '%smole %skelvin';
    const FPluralName        = '%smole %skelvins';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TMoleKelvinUnit = specialize TUnit<TMoleKelvin>;

{ TJoulePerMolePerKelvin }

const
  cJoulePerMolePerKelvin = 116;

type
  TJoulePerMolePerKelvin = record
    const FUnitOfMeasurement = cJoulePerMolePerKelvin;
    const FSymbol            = '%sJ/%smol/%sK';
    const FName              = '%sjoule per %smole per %skelvin';
    const FPluralName        = '%sjoules per %smole per %skelvin';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -1, -1);
  end;
  TJoulePerMolePerKelvinUnit = specialize TUnit<TJoulePerMolePerKelvin>;

{ TOhmMeter }

const
  cOhmMeter = 117;

type
  TOhmMeter = record
    const FUnitOfMeasurement = cOhmMeter;
    const FSymbol            = '%sΩ.%sm';
    const FName              = '%sohm %smeter';
    const FPluralName        = '%sohm %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TOhmMeterUnit = specialize TUnit<TOhmMeter>;

{ TVoltPerMeter }

const
  cVoltPerMeter = 118;

type
  TVoltPerMeter = record
    const FUnitOfMeasurement = cVoltPerMeter;
    const FSymbol            = '%sV/%sm';
    const FName              = '%svolt per %smeter';
    const FPluralName        = '%svolts per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TVoltPerMeterUnit = specialize TUnit<TVoltPerMeter>;

{ TNewtonPerCoulomb }

type
  TNewtonPerCoulomb = record
    const FUnitOfMeasurement = cVoltPerMeter;
    const FSymbol            = '%sN/%sC';
    const FName              = '%snewton per %scoulomb';
    const FPluralName        = '%snewtons per %scoulomb';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TNewtonPerCoulombUnit = specialize TUnit<TNewtonPerCoulomb>;

{ TCoulombPerMeter }

const
  cCoulombPerMeter = 119;

type
  TCoulombPerMeter = record
    const FUnitOfMeasurement = cCoulombPerMeter;
    const FSymbol            = '%sC/%sm';
    const FName              = '%scoulomb per %smeter';
    const FPluralName        = '%scoulombs per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TCoulombPerMeterUnit = specialize TUnit<TCoulombPerMeter>;

{ TSquareCoulombPerMeter }

const
  cSquareCoulombPerMeter = 120;

type
  TSquareCoulombPerMeter = record
    const FUnitOfMeasurement = cSquareCoulombPerMeter;
    const FSymbol            = '%sC2/%sm';
    const FName              = 'square %scoulomb per %smeter';
    const FPluralName        = 'square %scoulombs per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, -1);
  end;
  TSquareCoulombPerMeterUnit = specialize TUnit<TSquareCoulombPerMeter>;

{ TCoulombPerSquareMeter }

const
  cCoulombPerSquareMeter = 121;

type
  TCoulombPerSquareMeter = record
    const FUnitOfMeasurement = cCoulombPerSquareMeter;
    const FSymbol            = '%sC/%sm2';
    const FName              = '%scoulomb per square %smeter';
    const FPluralName        = '%scoulombs per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TCoulombPerSquareMeterUnit = specialize TUnit<TCoulombPerSquareMeter>;

{ TSquareMeterPerSquareCoulomb }

const
  cSquareMeterPerSquareCoulomb = 122;

type
  TSquareMeterPerSquareCoulomb = record
    const FUnitOfMeasurement = cSquareMeterPerSquareCoulomb;
    const FSymbol            = '%sm2/%sC2';
    const FName              = 'square %smeter per square %scoulomb';
    const FPluralName        = 'square %smeters per square %scoulomb';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareMeterPerSquareCoulombUnit = specialize TUnit<TSquareMeterPerSquareCoulomb>;

{ TNewtonPerSquareCoulomb }

const
  cNewtonPerSquareCoulomb = 123;

type
  TNewtonPerSquareCoulomb = record
    const FUnitOfMeasurement = cNewtonPerSquareCoulomb;
    const FSymbol            = '%sN/%sC2';
    const FName              = '%snewton per square %scoulomb';
    const FPluralName        = '%snewtons per square %scoulomb';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TNewtonPerSquareCoulombUnit = specialize TUnit<TNewtonPerSquareCoulomb>;

{ TNewtonSquareMeterPerSquareCoulomb }

const
  cNewtonSquareMeterPerSquareCoulomb = 124;

type
  TNewtonSquareMeterPerSquareCoulomb = record
    const FUnitOfMeasurement = cNewtonSquareMeterPerSquareCoulomb;
    const FSymbol            = '%sN.%sm2/%sC2';
    const FName              = '%snewton square %smeter per square %scoulomb';
    const FPluralName        = '%snewton square %smeters per square %scoulomb';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -2);
  end;
  TNewtonSquareMeterPerSquareCoulombUnit = specialize TUnit<TNewtonSquareMeterPerSquareCoulomb>;

{ TVoltMeter }

const
  cVoltMeter = 125;

type
  TVoltMeter = record
    const FUnitOfMeasurement = cVoltMeter;
    const FSymbol            = '%sV.%sm';
    const FName              = '%svolt %smeter';
    const FPluralName        = '%svolt %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TVoltMeterUnit = specialize TUnit<TVoltMeter>;

{ TNewtonSquareMeterPerCoulomb }

type
  TNewtonSquareMeterPerCoulomb = record
    const FUnitOfMeasurement = cVoltMeter;
    const FSymbol            = '%sN.%sm2/%sC';
    const FName              = '%snewton square %smeter per %scoulomb';
    const FPluralName        = '%snewton square %smeters per %scoulomb';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 2, -1);
  end;
  TNewtonSquareMeterPerCoulombUnit = specialize TUnit<TNewtonSquareMeterPerCoulomb>;

{ TVoltMeterPerSecond }

const
  cVoltMeterPerSecond = 126;

type
  TVoltMeterPerSecond = record
    const FUnitOfMeasurement = cVoltMeterPerSecond;
    const FSymbol            = '%sV.%sm/%ss';
    const FName              = '%svolt %smeter per %ssecond';
    const FPluralName        = '%svolt %smeters per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -1);
  end;
  TVoltMeterPerSecondUnit = specialize TUnit<TVoltMeterPerSecond>;

{ TFaradPerMeter }

const
  cFaradPerMeter = 127;

type
  TFaradPerMeter = record
    const FUnitOfMeasurement = cFaradPerMeter;
    const FSymbol            = '%sF/%sm';
    const FName              = '%sfarad per %smeter';
    const FPluralName        = '%sfarads per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TFaradPerMeterUnit = specialize TUnit<TFaradPerMeter>;

{ TAmperePerMeter }

const
  cAmperePerMeter = 128;

type
  TAmperePerMeter = record
    const FUnitOfMeasurement = cAmperePerMeter;
    const FSymbol            = '%sA/%sm';
    const FName              = '%sampere per %smeter';
    const FPluralName        = '%samperes per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TAmperePerMeterUnit = specialize TUnit<TAmperePerMeter>;

{ TMeterPerAmpere }

const
  cMeterPerAmpere = 129;

type
  TMeterPerAmpere = record
    const FUnitOfMeasurement = cMeterPerAmpere;
    const FSymbol            = '%sm/%sA';
    const FName              = '%smeter per %sampere';
    const FPluralName        = '%smeters per %sampere';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TMeterPerAmpereUnit = specialize TUnit<TMeterPerAmpere>;

{ TTeslaMeter }

const
  cTeslaMeter = 130;

type
  TTeslaMeter = record
    const FUnitOfMeasurement = cTeslaMeter;
    const FSymbol            = '%sT.%sm';
    const FName              = '%stesla %smeter';
    const FPluralName        = '%stesla %smeters';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TTeslaMeterUnit = specialize TUnit<TTeslaMeter>;

{ TNewtonPerAmpere }

type
  TNewtonPerAmpere = record
    const FUnitOfMeasurement = cTeslaMeter;
    const FSymbol            = '%sN/%sA';
    const FName              = '%snewton per %sampere';
    const FPluralName        = '%snewtons per %sampere';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TNewtonPerAmpereUnit = specialize TUnit<TNewtonPerAmpere>;

{ TTeslaPerAmpere }

const
  cTeslaPerAmpere = 131;

type
  TTeslaPerAmpere = record
    const FUnitOfMeasurement = cTeslaPerAmpere;
    const FSymbol            = '%sT/%sA';
    const FName              = '%stesla per %sampere';
    const FPluralName        = '%steslas per %sampere';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TTeslaPerAmpereUnit = specialize TUnit<TTeslaPerAmpere>;

{ THenryPerMeter }

const
  cHenryPerMeter = 132;

type
  THenryPerMeter = record
    const FUnitOfMeasurement = cHenryPerMeter;
    const FSymbol            = '%sH/%sm';
    const FName              = '%shenry per %smeter';
    const FPluralName        = '%shenries per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  THenryPerMeterUnit = specialize TUnit<THenryPerMeter>;

{ TTeslaMeterPerAmpere }

type
  TTeslaMeterPerAmpere = record
    const FUnitOfMeasurement = cHenryPerMeter;
    const FSymbol            = '%sT.%sm/%sA';
    const FName              = '%stesla %smeter per %sampere';
    const FPluralName        = '%stesla %smeters per %sampere';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, 1, -1);
  end;
  TTeslaMeterPerAmpereUnit = specialize TUnit<TTeslaMeterPerAmpere>;

{ TNewtonPerSquareAmpere }

type
  TNewtonPerSquareAmpere = record
    const FUnitOfMeasurement = cHenryPerMeter;
    const FSymbol            = '%sN/%sA2';
    const FName              = '%snewton per square %sampere';
    const FPluralName        = '%snewtons per square %sampere';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TNewtonPerSquareAmpereUnit = specialize TUnit<TNewtonPerSquareAmpere>;

{ TRadianPerMeter }

const
  cRadianPerMeter = 133;

type
  TRadianPerMeter = record
    const FUnitOfMeasurement = cRadianPerMeter;
    const FSymbol            = 'rad/%sm';
    const FName              = 'radian per %smeter';
    const FPluralName        = 'radians per %smeter';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TRadianPerMeterUnit = specialize TUnit<TRadianPerMeter>;

{ TSquareKilogramPerSquareSecond }

const
  cSquareKilogramPerSquareSecond = 134;

type
  TSquareKilogramPerSquareSecond = record
    const FUnitOfMeasurement = cSquareKilogramPerSquareSecond;
    const FSymbol            = '%sg2/%ss2';
    const FName              = 'square %sgram per square %ssecond';
    const FPluralName        = 'square %sgrams per square %ssecond';
    const FPrefixes          : TPrefixes  = (pKilo, pNone);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareKilogramPerSquareSecondUnit = specialize TUnit<TSquareKilogramPerSquareSecond>;

{ TSquareSecondPerSquareMeter }

const
  cSquareSecondPerSquareMeter = 135;

type
  TSquareSecondPerSquareMeter = record
    const FUnitOfMeasurement = cSquareSecondPerSquareMeter;
    const FSymbol            = '%ss2/%sm2';
    const FName              = 'square %ssecond per square %smeter';
    const FPluralName        = 'square %sseconds per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, -2);
  end;
  TSquareSecondPerSquareMeterUnit = specialize TUnit<TSquareSecondPerSquareMeter>;

{ TSquareJoule }

const
  cSquareJoule = 136;

type
  TSquareJoule = record
    const FUnitOfMeasurement = cSquareJoule;
    const FSymbol            = '%sJ2';
    const FName              = 'square %sjoule';
    const FPluralName        = 'square %sjoules';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareJouleUnit = specialize TUnit<TSquareJoule>;

var
  J2         : TSquareJouleUnit;

const
  TJ2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 136; FValue: 1E+24); {$ELSE} (1E+24); {$ENDIF}
  GJ2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 136; FValue: 1E+18); {$ELSE} (1E+18); {$ENDIF}
  MJ2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 136; FValue: 1E+12); {$ELSE} (1E+12); {$ENDIF}
  kJ2        : TQuantity = {$IFOPT D+} (FUnitOfMeasurement: 136; FValue: 1E+06); {$ELSE} (1E+06); {$ENDIF}

{ TJouleSecond }

type
  TJouleSecond = record
    const FUnitOfMeasurement = cKilogramSquareMeterPerSecond;
    const FSymbol            = '%sJ.%ss';
    const FName              = '%sjoule %ssecond';
    const FPluralName        = '%sjoule %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
  end;
  TJouleSecondUnit = specialize TUnit<TJouleSecond>;

{ TJoulePerHertz }

type
  TJoulePerHertz = record
    const FUnitOfMeasurement = cKilogramSquareMeterPerSecond;
    const FSymbol            = '%sJ/%sHz';
    const FName              = '%sjoule per %shertz';
    const FPluralName        = '%sjoules per %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TJoulePerHertzUnit = specialize TUnit<TJoulePerHertz>;

{ TElectronvoltSecond }

type
  TElectronvoltSecond = record
    const FUnitOfMeasurement = cKilogramSquareMeterPerSecond;
    const FSymbol            = '%seV.%ss';
    const FName              = '%selectronvolt %ssecond';
    const FPluralName        = '%selectronvolt %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TElectronvoltSecondUnit = specialize TUnit<TElectronvoltSecond>;

{ TElectronvoltMeterPerSpeedOfLight }

type
  TElectronvoltMeterPerSpeedOfLight = record
    const FUnitOfMeasurement = cKilogramSquareMeterPerSecond;
    const FSymbol            = '%seV.%sm/c';
    const FName              = '%selectronvolt %smeter per speed of  light';
    const FPluralName        = '%selectronvolt %smeters per speed of  light';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, 1);
    function GetValue(const AQuantity: TQuantity): double;
    function GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
  end;
  TElectronvoltMeterPerSpeedOfLightUnit = specialize TUnit<TElectronvoltMeterPerSpeedOfLight>;

{ TSquareJouleSquareSecond }

const
  cSquareJouleSquareSecond = 137;

type
  TSquareJouleSquareSecond = record
    const FUnitOfMeasurement = cSquareJouleSquareSecond;
    const FSymbol            = '%sJ2.%ss2';
    const FName              = 'square %sjoule square %ssecond';
    const FPluralName        = 'square %sjoule square %sseconds';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 2);
  end;
  TSquareJouleSquareSecondUnit = specialize TUnit<TSquareJouleSquareSecond>;

{ TCoulombPerKilogram }

const
  cCoulombPerKilogram = 138;

type
  TCoulombPerKilogram = record
    const FUnitOfMeasurement = cCoulombPerKilogram;
    const FSymbol            = '%sC/%sg';
    const FName              = '%scoulomb per %sgram';
    const FPluralName        = '%scoulombs per %sgram';
    const FPrefixes          : TPrefixes  = (pNone, pKilo);
    const FExponents         : TExponents = (1, -1);
  end;
  TCoulombPerKilogramUnit = specialize TUnit<TCoulombPerKilogram>;

{ TSquareMeterAmpere }

const
  cSquareMeterAmpere = 139;

type
  TSquareMeterAmpere = record
    const FUnitOfMeasurement = cSquareMeterAmpere;
    const FSymbol            = '%sm2.%sA';
    const FName              = 'square %smeter %sampere';
    const FPluralName        = 'square %smeter %samperes';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 1);
  end;
  TSquareMeterAmpereUnit = specialize TUnit<TSquareMeterAmpere>;

{ TJoulePerTesla }

type
  TJoulePerTesla = record
    const FUnitOfMeasurement = cSquareMeterAmpere;
    const FSymbol            = '%sJ/%sT';
    const FName              = '%sjoule per %stesla';
    const FPluralName        = '%sjoules per %stesla';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TJoulePerTeslaUnit = specialize TUnit<TJoulePerTesla>;

{ TLumenPerWatt }

const
  cLumenPerWatt = 140;

type
  TLumenPerWatt = record
    const FUnitOfMeasurement = cLumenPerWatt;
    const FSymbol            = '%slm/%sW';
    const FName              = '%slumen per %swatt';
    const FPluralName        = '%slumens per %swatt';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TLumenPerWattUnit = specialize TUnit<TLumenPerWatt>;

{ TReciprocalMole }

const
  cReciprocalMole = 141;

type
  TReciprocalMole = record
    const FUnitOfMeasurement = cReciprocalMole;
    const FSymbol            = '1/%smol';
    const FName              = 'reciprocal %smole';
    const FPluralName        = 'reciprocal %smoles';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (-1);
  end;
  TReciprocalMoleUnit = specialize TUnit<TReciprocalMole>;

{ TAmperePerSquareMeter }

const
  cAmperePerSquareMeter = 142;

type
  TAmperePerSquareMeter = record
    const FUnitOfMeasurement = cAmperePerSquareMeter;
    const FSymbol            = '%sA/%sm2';
    const FName              = '%sampere per square %smeter';
    const FPluralName        = '%samperes per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TAmperePerSquareMeterUnit = specialize TUnit<TAmperePerSquareMeter>;

{ TMolePerCubicMeter }

const
  cMolePerCubicMeter = 143;

type
  TMolePerCubicMeter = record
    const FUnitOfMeasurement = cMolePerCubicMeter;
    const FSymbol            = '%smol/%sm3';
    const FName              = '%smole per cubic %smeter';
    const FPluralName        = '%smoles per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TMolePerCubicMeterUnit = specialize TUnit<TMolePerCubicMeter>;

{ TCandelaPerSquareMeter }

const
  cCandelaPerSquareMeter = 144;

type
  TCandelaPerSquareMeter = record
    const FUnitOfMeasurement = cCandelaPerSquareMeter;
    const FSymbol            = '%scd/%sm2';
    const FName              = '%scandela per square %smeter';
    const FPluralName        = '%scandelas per square %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TCandelaPerSquareMeterUnit = specialize TUnit<TCandelaPerSquareMeter>;

{ TCoulombPerCubicMeter }

const
  cCoulombPerCubicMeter = 145;

type
  TCoulombPerCubicMeter = record
    const FUnitOfMeasurement = cCoulombPerCubicMeter;
    const FSymbol            = '%sC/%sm3';
    const FName              = '%scoulomb per cubic %smeter';
    const FPluralName        = '%scoulombs per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TCoulombPerCubicMeterUnit = specialize TUnit<TCoulombPerCubicMeter>;

{ TGrayPerSecond }

const
  cGrayPerSecond = 146;

type
  TGrayPerSecond = record
    const FUnitOfMeasurement = cGrayPerSecond;
    const FSymbol            = '%sGy/%ss';
    const FName              = '%sgray per %ssecond';
    const FPluralName        = '%sgrays per %ssecond';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TGrayPerSecondUnit = specialize TUnit<TGrayPerSecond>;

{ TSteradianHertz }

const
  cSteradianHertz = 147;

type
  TSteradianHertz = record
    const FUnitOfMeasurement = cSteradianHertz;
    const FSymbol            = 'sr.%sHz';
    const FName              = 'steradian %shertz';
    const FPluralName        = 'steradian %shertz';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TSteradianHertzUnit = specialize TUnit<TSteradianHertz>;

{ TMeterSteradian }

const
  cMeterSteradian = 148;

type
  TMeterSteradian = record
    const FUnitOfMeasurement = cMeterSteradian;
    const FSymbol            = '%sm.sr';
    const FName              = '%smeter steradian';
    const FPluralName        = '%smeter steradians';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TMeterSteradianUnit = specialize TUnit<TMeterSteradian>;

{ TSquareMeterSteradian }

const
  cSquareMeterSteradian = 149;

type
  TSquareMeterSteradian = record
    const FUnitOfMeasurement = cSquareMeterSteradian;
    const FSymbol            = '%sm2.sr';
    const FName              = 'square %smeter steradian';
    const FPluralName        = 'square %smeter steradians';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (2);
  end;
  TSquareMeterSteradianUnit = specialize TUnit<TSquareMeterSteradian>;

{ TCubicMeterSteradian }

const
  cCubicMeterSteradian = 150;

type
  TCubicMeterSteradian = record
    const FUnitOfMeasurement = cCubicMeterSteradian;
    const FSymbol            = '%sm3.sr';
    const FName              = 'cubic %smeter steradian';
    const FPluralName        = 'cubic %smeter steradians';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (3);
  end;
  TCubicMeterSteradianUnit = specialize TUnit<TCubicMeterSteradian>;

{ TSquareMeterSteradianHertz }

const
  cSquareMeterSteradianHertz = 151;

type
  TSquareMeterSteradianHertz = record
    const FUnitOfMeasurement = cSquareMeterSteradianHertz;
    const FSymbol            = '%sm2.sr.%shertz';
    const FName              = 'square %smeter steradian %shertz';
    const FPluralName        = 'square %smeter steradian %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (2, 1);
  end;
  TSquareMeterSteradianHertzUnit = specialize TUnit<TSquareMeterSteradianHertz>;

{ TWattPerSteradian }

const
  cWattPerSteradian = 152;

type
  TWattPerSteradian = record
    const FUnitOfMeasurement = cWattPerSteradian;
    const FSymbol            = '%sW/sr';
    const FName              = '%swatt per steradian';
    const FPluralName        = '%swatts per steradian';
    const FPrefixes          : TPrefixes  = (pNone);
    const FExponents         : TExponents = (1);
  end;
  TWattPerSteradianUnit = specialize TUnit<TWattPerSteradian>;

{ TWattPerSteradianPerHertz }

const
  cWattPerSteradianPerHertz = 153;

type
  TWattPerSteradianPerHertz = record
    const FUnitOfMeasurement = cWattPerSteradianPerHertz;
    const FSymbol            = '%sW/sr/%sHz';
    const FName              = '%swatt per steradian per %shertz';
    const FPluralName        = '%swatts per steradian per %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TWattPerSteradianPerHertzUnit = specialize TUnit<TWattPerSteradianPerHertz>;

{ TWattPerMeterPerSteradian }

const
  cWattPerMeterPerSteradian = 154;

type
  TWattPerMeterPerSteradian = record
    const FUnitOfMeasurement = cWattPerMeterPerSteradian;
    const FSymbol            = '%sW/sr/%sm';
    const FName              = '%swatt per steradian per %smeter';
    const FPluralName        = '%swatts per steradian per %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TWattPerMeterPerSteradianUnit = specialize TUnit<TWattPerMeterPerSteradian>;

{ TWattPerSquareMeterPerSteradian }

const
  cWattPerSquareMeterPerSteradian = 155;

type
  TWattPerSquareMeterPerSteradian = record
    const FUnitOfMeasurement = cWattPerSquareMeterPerSteradian;
    const FSymbol            = '%sW/%sm2/sr';
    const FName              = '%swatt per square %smeter per steradian';
    const FPluralName        = '%swatts per square %smeter per steradian';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -2);
  end;
  TWattPerSquareMeterPerSteradianUnit = specialize TUnit<TWattPerSquareMeterPerSteradian>;

{ TWattPerCubicMeterPerSteradian }

const
  cWattPerCubicMeterPerSteradian = 156;

type
  TWattPerCubicMeterPerSteradian = record
    const FUnitOfMeasurement = cWattPerCubicMeterPerSteradian;
    const FSymbol            = '%sW/%sm3/sr';
    const FName              = '%swatt per cubic %smeter per steradian';
    const FPluralName        = '%swatts per cubic %smeter per steradian';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TWattPerCubicMeterPerSteradianUnit = specialize TUnit<TWattPerCubicMeterPerSteradian>;

{ TWattPerSquareMeterPerSteradianPerHertz }

const
  cWattPerSquareMeterPerSteradianPerHertz = 157;

type
  TWattPerSquareMeterPerSteradianPerHertz = record
    const FUnitOfMeasurement = cWattPerSquareMeterPerSteradianPerHertz;
    const FSymbol            = '%sW/%sm2/sr/%sHz';
    const FName              = '%swatt per square %smeter per steradian per %shertz';
    const FPluralName        = '%swatts per square %smeter per steradian per %shertz';
    const FPrefixes          : TPrefixes  = (pNone, pNone, pNone);
    const FExponents         : TExponents = (1, -2, -1);
  end;
  TWattPerSquareMeterPerSteradianPerHertzUnit = specialize TUnit<TWattPerSquareMeterPerSteradianPerHertz>;

{ TKatalPerCubicMeter }

const
  cKatalPerCubicMeter = 158;

type
  TKatalPerCubicMeter = record
    const FUnitOfMeasurement = cKatalPerCubicMeter;
    const FSymbol            = '%skat/%sm3';
    const FName              = '%skatal per cubic %smeter';
    const FPluralName        = '%skatals per cubic %smeter';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -3);
  end;
  TKatalPerCubicMeterUnit = specialize TUnit<TKatalPerCubicMeter>;

{ TCoulombPerMole }

const
  cCoulombPerMole = 159;

type
  TCoulombPerMole = record
    const FUnitOfMeasurement = cCoulombPerMole;
    const FSymbol            = '%sC/%smol';
    const FName              = '%scoulomb per %smole';
    const FPluralName        = '%scoulombs per %smole';
    const FPrefixes          : TPrefixes  = (pNone, pNone);
    const FExponents         : TExponents = (1, -1);
  end;
  TCoulombPerMoleUnit = specialize TUnit<TCoulombPerMole>;

const

  { Mul Table }

  MulTable : array[0..159, 0..159] of longint = (
    (cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, cMeter, cScalar, cSquareMeter, cCubicMeter, cQuarticMeter, cQuinticMeter, cSexticMeter, cKilogram, cSquareKilogram, cAmpere, cSquareAmpere, cKelvin, cSquareKelvin, cCubicKelvin, cQuarticKelvin, cMole, cCandela, cHertz, cSquareHertz, cSquareHertz, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, cSquareMeterPerSquareSecond, cMeterSecond, cKilogramMeter, cKilogramPerSecond, cKilogramMeterPerSecond, cSquareKilogramSquareMeterPerSquareSecond, cScalar, cReciprocalMeter, cScalar, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, cKilogramSquareMeter, cKilogramSquareMeterPerSecond, cSecondPerMeter, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cNewton, cNewton, cSquareNewton, cPascal, cJoule, cJoule, cWatt, cCoulomb, cSquareCoulomb, cCoulombMeter, cVolt, cSquareVolt, cFarad, cOhm, cSiemens, cSiemensPerMeter, cTesla, cWeber, cHenry, cReciprocalHenry, cCandela, cLumenSecond, cLumenSecondPerCubicMeter, cLux, cLuxSecond, cKatal, cNewtonPerCubicMeter, cNewtonPerMeter, cCubicMeterPerSecond, cPoiseuille, cSquareMeterPerSecond, cKilogramPerQuarticMeter, cQuarticMeterSecond, cKilogramPerQuarticMeterPerSecond, cCubicMeterPerKilogram, cKilogramSquareSecond, cCubicMeterPerSquareSecond, cNewtonSquareMeter, cNewtonCubicMeter, cNewtonPerSquareKilogram, cSquareKilogramPerMeter, cSquareKilogramPerSquareMeter, cSquareMeterPerSquareKilogram, cNewtonSquareMeterPerSquareKilogram, cReciprocalKelvin, cKilogramKelvin, cJoulePerKelvin, cJoulePerKilogramPerKelvin, cMeterKelvin, cKelvinPerMeter, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, cWattPerKelvin, cWattPerMeterPerKelvin, cKelvinPerWatt, cMeterPerWatt, cMeterKelvinPerWatt, cSquareMeterKelvin, cWattPerSquareMeterPerKelvin, cSquareMeterQuarticKelvin, cWattPerQuarticKelvin, cWattPerSquareMeterPerQuarticKelvin, cJoulePerMole, cMoleKelvin, cJoulePerMolePerKelvin, cOhmMeter, cVoltPerMeter, cCoulombPerMeter, cSquareCoulombPerMeter, cCoulombPerSquareMeter, cSquareMeterPerSquareCoulomb, cNewtonPerSquareCoulomb, cNewtonSquareMeterPerSquareCoulomb, cVoltMeter, cVoltMeterPerSecond, cFaradPerMeter, cAmperePerMeter, cMeterPerAmpere, cTeslaMeter, cTeslaPerAmpere, cHenryPerMeter, cReciprocalMeter, cSquareKilogramPerSquareSecond, cSquareSecondPerSquareMeter, cSquareJoule, cSquareJouleSquareSecond, cCoulombPerKilogram, cSquareMeterAmpere, cLumenPerWatt, cReciprocalMole, cAmperePerSquareMeter, cMolePerCubicMeter, cLux, cCoulombPerCubicMeter, cGrayPerSecond, cHertz, cMeter, cSquareMeter, cCubicMeter, cSquareMeterPerSecond, cWatt, cJoule, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, cNewtonPerMeter, cKatalPerCubicMeter, cCoulombPerMole),
    (cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, -1, cMeterSecond, cSecond, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, -1, cLumenSecond, cScalar, cHertz, cHertz, cMeter, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cSquareMeterPerSecond, -1, -1, cKilogram, cKilogramMeter, -1, cSecond, cSecondPerMeter, cSecond, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, cKilogramMeterPerSecond, cKilogramMeterPerSecond, -1, cPoiseuille, cKilogramSquareMeterPerSecond, cKilogramSquareMeterPerSecond, cJoule, -1, -1, -1, cWeber, -1, -1, cHenry, cFarad, cFaradPerMeter, -1, -1, -1, cSiemens, cLumenSecond, -1, -1, cLuxSecond, -1, cMole, -1, cKilogramPerSecond, cCubicMeter, cKilogramPerMeter, cSquareMeter, -1, -1, cKilogramPerQuarticMeter, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, cNewtonPerMeter, cPascal, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, cOhmMeter, -1, cVoltMeter, -1, cCoulombPerMeter, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, cLuxSecond, -1, cSquareMeterPerSquareSecond, cScalar, cMeterSecond, -1, -1, cSquareMeter, cJoule, cKilogramSquareMeterPerSecond, cNewton, cNewtonPerMeter, cPascal, cKilogramPerSecond, cMolePerCubicMeter, -1),
    (cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, cSecond, cScalar, cScalar, cMeterSecond, cMeter, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cSquareMeter, -1, -1, -1, -1, -1, cSquareSecond, -1, cSquareSecond, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cKilogramMeter, cSquareKilogramSquareMeterPerSquareSecond, cKilogramPerMeter, cKilogramSquareMeter, cKilogramSquareMeter, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, cSquareMeterKelvin, -1, -1, cKilogramMeterPerSecond, cKilogramPerSecond, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, cSecond, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, cKilogramMeterPerSecond, cKilogramPerSecond, cPoiseuille, cKilogram, -1, -1),
    (cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, -1, -1, -1, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cSecond, cSecond, -1, cMeterSecond, cMeter, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, -1, -1, -1, cKilogramSquareSecond, -1, -1, cCubicSecond, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cKilogram, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, cSquareSecond, -1, -1, -1, -1, cKilogramSquareMeter, -1, cKilogramMeter, cKilogram, cKilogramPerMeter, -1, -1, -1),
    (cQuarticSecond, cQuinticSecond, cSexticSecond, -1, -1, -1, -1, -1, cQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, cSquareSecond, cSquareSecond, -1, -1, cMeterSecond, cMeter, cMeterPerSecond, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cQuarticSecond, -1, cQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1),
    (cQuinticSecond, cSexticSecond, -1, -1, -1, -1, -1, -1, cQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticSecond, cCubicSecond, cCubicSecond, -1, -1, -1, cMeterSecond, cMeter, cMeterPerSecond, -1, -1, -1, -1, -1, -1, cQuinticSecond, -1, cQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticSecond, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1),
    (cSexticSecond, -1, -1, -1, -1, -1, -1, -1, cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticSecond, cQuarticSecond, cQuarticSecond, -1, -1, -1, -1, cMeterSecond, cMeter, -1, -1, -1, -1, -1, -1, cSexticSecond, -1, cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeter, cMeterSecond, -1, -1, -1, -1, -1, cSquareMeter, cMeter, cCubicMeter, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, cKilogramMeter, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerSquareSecond, cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, cCubicMeterPerSquareSecond, -1, cKilogramSquareMeter, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, cMeter, cScalar, cMeter, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, -1, -1, cSecond, cKilogram, cKilogramPerMeter, cKilogramPerSquareMeter, cJoule, cJoule, -1, cNewtonPerMeter, cNewtonSquareMeter, cNewtonSquareMeter, -1, cCoulombMeter, -1, -1, cVoltMeter, -1, -1, cOhmMeter, -1, cSiemens, cTeslaMeter, -1, -1, -1, -1, -1, cLuxSecond, -1, -1, -1, cPascal, cNewton, -1, cKilogramPerSecond, cCubicMeterPerSecond, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, cSquareKilogram, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, cKelvin, cWatt, cWattPerMeter, cWattPerSquareMeter, -1, cWattPerKelvin, cMeterKelvinPerWatt, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, cVolt, cCoulomb, cSquareCoulomb, cCoulombPerMeter, -1, -1, -1, -1, -1, cFarad, cAmpere, -1, cWeber, cHenryPerMeter, cHenry, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, cCoulombPerSquareMeter, -1, cMeterPerSecond, cSquareMeter, cCubicMeter, cQuarticMeter, cCubicMeterPerSecond, -1, cNewtonSquareMeter, cWatt, cWattPerMeter, cWattPerSquareMeter, cNewton, -1, -1),
    (cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, cMeter, cScalar, cSquareMeter, cCubicMeter, cQuarticMeter, cQuinticMeter, cSexticMeter, cKilogram, cSquareKilogram, cAmpere, cSquareAmpere, cKelvin, cSquareKelvin, cCubicKelvin, cQuarticKelvin, cMole, cCandela, cHertz, cSquareHertz, cSquareHertz, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, cSquareMeterPerSquareSecond, cMeterSecond, cKilogramMeter, cKilogramPerSecond, cKilogramMeterPerSecond, cSquareKilogramSquareMeterPerSquareSecond, cScalar, cReciprocalMeter, cScalar, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, cKilogramSquareMeter, cKilogramSquareMeterPerSecond, cSecondPerMeter, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cNewton, cNewton, cSquareNewton, cPascal, cJoule, cJoule, cWatt, cCoulomb, cSquareCoulomb, cCoulombMeter, cVolt, cSquareVolt, cFarad, cOhm, cSiemens, cSiemensPerMeter, cTesla, cWeber, cHenry, cReciprocalHenry, cCandela, cLumenSecond, cLumenSecondPerCubicMeter, cLux, cLuxSecond, cKatal, cNewtonPerCubicMeter, cNewtonPerMeter, cCubicMeterPerSecond, cPoiseuille, cSquareMeterPerSecond, cKilogramPerQuarticMeter, cQuarticMeterSecond, cKilogramPerQuarticMeterPerSecond, cCubicMeterPerKilogram, cKilogramSquareSecond, cCubicMeterPerSquareSecond, cNewtonSquareMeter, cNewtonCubicMeter, cNewtonPerSquareKilogram, cSquareKilogramPerMeter, cSquareKilogramPerSquareMeter, cSquareMeterPerSquareKilogram, cNewtonSquareMeterPerSquareKilogram, cReciprocalKelvin, cKilogramKelvin, cJoulePerKelvin, cJoulePerKilogramPerKelvin, cMeterKelvin, cKelvinPerMeter, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, cWattPerKelvin, cWattPerMeterPerKelvin, cKelvinPerWatt, cMeterPerWatt, cMeterKelvinPerWatt, cSquareMeterKelvin, cWattPerSquareMeterPerKelvin, cSquareMeterQuarticKelvin, cWattPerQuarticKelvin, cWattPerSquareMeterPerQuarticKelvin, cJoulePerMole, cMoleKelvin, cJoulePerMolePerKelvin, cOhmMeter, cVoltPerMeter, cCoulombPerMeter, cSquareCoulombPerMeter, cCoulombPerSquareMeter, cSquareMeterPerSquareCoulomb, cNewtonPerSquareCoulomb, cNewtonSquareMeterPerSquareCoulomb, cVoltMeter, cVoltMeterPerSecond, cFaradPerMeter, cAmperePerMeter, cMeterPerAmpere, cTeslaMeter, cTeslaPerAmpere, cHenryPerMeter, cReciprocalMeter, cSquareKilogramPerSquareSecond, cSquareSecondPerSquareMeter, cSquareJoule, cSquareJouleSquareSecond, cCoulombPerKilogram, cSquareMeterAmpere, cLumenPerWatt, cReciprocalMole, cAmperePerSquareMeter, cMolePerCubicMeter, cLux, cCoulombPerCubicMeter, cGrayPerSecond, cHertz, cMeter, cSquareMeter, cCubicMeter, cSquareMeterPerSecond, cWatt, cJoule, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, cNewtonPerMeter, cKatalPerCubicMeter, cCoulombPerMole),
    (cSquareMeter, -1, -1, -1, -1, -1, -1, cCubicMeter, cSquareMeter, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, -1, cKilogramSquareMeter, -1, cSquareMeterAmpere, -1, -1, -1, -1, cSquareMeterQuarticKelvin, -1, -1, cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, cSquareJouleSquareSecond, cSquareMeter, cMeter, cSquareMeter, cScalar, cReciprocalMeter, cReciprocalSquareMeter, -1, -1, cMeterSecond, cKilogramMeter, cKilogram, cKilogramPerMeter, cNewtonSquareMeter, cNewtonSquareMeter, cSquareJoule, cNewton, cNewtonCubicMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, cCandela, cLumenSecond, -1, cNewtonPerMeter, cJoule, -1, cKilogramMeterPerSecond, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, cSquareKilogram, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, cMeterKelvin, -1, cWatt, cWattPerMeter, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, cCoulombMeter, -1, cCoulomb, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, cMeter, cSquareKilogramSquareMeterPerSquareSecond, cSquareSecond, -1, -1, -1, -1, -1, -1, cAmpere, -1, cCandela, cCoulombPerMeter, -1, cSquareMeterPerSecond, cCubicMeter, cQuarticMeter, cQuinticMeter, -1, -1, cNewtonCubicMeter, -1, cWatt, cWattPerMeter, cJoule, -1, -1),
    (cCubicMeter, -1, -1, -1, -1, -1, -1, cQuarticMeter, cCubicMeter, cQuinticMeter, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cCubicMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, cCubicMeter, cSquareMeter, cCubicMeter, cMeter, cScalar, cReciprocalMeter, -1, -1, -1, cKilogramSquareMeter, cKilogramMeter, cKilogram, cNewtonCubicMeter, cNewtonCubicMeter, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecond, -1, -1, -1, cNewton, cNewtonSquareMeter, -1, cKilogramSquareMeterPerSecond, -1, cKilogramPerMeter, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, -1, cCoulomb, -1, cCubicMeterPerSecond, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, -1, -1, -1, -1, cWatt, cNewtonSquareMeter, cKatal, -1),
    (cQuarticMeter, cQuarticMeterSecond, -1, -1, -1, -1, -1, cQuinticMeter, cQuarticMeter, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, cCubicMeter, cQuarticMeter, cSquareMeter, cMeter, cScalar, -1, -1, -1, -1, cKilogramSquareMeter, cKilogramMeter, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cNewtonCubicMeter, -1, -1, -1, cKilogram, -1, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, cCoulombMeter, -1, -1, cQuinticMeter, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1),
    (cQuinticMeter, -1, -1, -1, -1, -1, -1, cSexticMeter, cQuinticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, cQuarticMeter, cQuinticMeter, cCubicMeter, cSquareMeter, cMeter, -1, -1, cQuarticMeterSecond, -1, -1, cKilogramSquareMeter, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, cKilogramMeter, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSexticMeter, -1, -1, -1, -1, -1, -1, -1, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSexticMeter, cQuinticMeter, cSexticMeter, cQuarticMeter, cCubicMeter, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, cKilogramSquareMeter, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogram, -1, cKilogramSquareSecond, -1, -1, -1, -1, cKilogramMeter, cKilogram, cKilogramSquareMeter, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, cKilogramKelvin, -1, -1, -1, -1, -1, cKilogramPerSecond, cNewtonPerMeter, cNewtonPerMeter, cKilogramMeterPerSecond, cNewton, cWattPerMeter, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, cKilogram, cKilogramPerMeter, cKilogram, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, -1, -1, cSquareKilogramPerMeter, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, cCubicMeter, -1, cNewtonSquareMeter, -1, cSquareJouleSquareSecond, cMeterPerSquareSecond, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, -1, -1, cWatt, cKilogramPerSecond, cKilogramMeter, cKilogramSquareMeter, -1, cKilogramSquareMeterPerSecond, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1),
    (cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, cSquareKilogram, cSquareKilogramPerMeter, cSquareKilogram, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, -1, cSquareMeter, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cAmpere, cCoulomb, -1, -1, -1, -1, -1, -1, cAmpere, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, cAmpere, cAmperePerMeter, cAmpere, cAmperePerSquareMeter, -1, -1, -1, -1, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, cVolt, -1, -1, cNewtonPerMeter, cJoule, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, cWattPerMeter, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, cMeter, cNewton, cTesla, cTeslaMeter, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareAmpere, -1, cSquareCoulomb, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKelvin, -1, -1, -1, -1, -1, -1, cMeterKelvin, cKelvin, -1, -1, -1, -1, -1, cKilogramKelvin, -1, -1, -1, cSquareKelvin, cCubicKelvin, cQuarticKelvin, -1, cMoleKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, cKelvinPerMeter, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, cJoule, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, cWatt, cWattPerMeter, -1, cMeterKelvinPerWatt, -1, cSquareMeter, cWattPerSquareMeter, -1, -1, -1, -1, -1, cJoulePerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareKelvin, -1, -1, -1, -1, -1, -1, -1, cSquareKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicKelvin, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKelvin, -1, cSquareKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCubicKelvin, -1, -1, -1, -1, -1, -1, -1, cCubicKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicKelvin, -1, cCubicKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, cSquareMeterQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicKelvin, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterQuarticKelvin, -1, -1, -1, -1, -1, cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1),
    (cMole, -1, -1, -1, -1, -1, -1, -1, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMoleKelvin, -1, -1, -1, -1, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, -1, cMole, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb),
    (cCandela, cLumenSecond, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, cCandela, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cHertz, cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cMeterPerSecond, cHertz, cSquareMeterPerSecond, cCubicMeterPerSecond, -1, -1, -1, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, cSquareHertz, -1, -1, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, cGrayPerSecond, cMeter, cKilogramMeterPerSecond, cNewtonPerMeter, cNewton, -1, cHertz, -1, cHertz, -1, -1, -1, cKilogramSquareMeterPerSecond, cJoule, cReciprocalMeter, cPoiseuille, -1, -1, cWattPerMeter, cWattPerMeter, -1, cWattPerCubicMeter, cWatt, cWatt, -1, cAmpere, -1, -1, -1, -1, cSiemens, -1, cReciprocalHenry, -1, -1, cVolt, cOhm, -1, -1, cCandela, -1, -1, cLux, -1, -1, cWattPerSquareMeter, cCubicMeterPerSquareSecond, cPascal, cSquareMeterPerSquareSecond, cKilogramPerQuarticMeterPerSecond, cQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cAmperePerMeter, -1, cAmperePerSquareMeter, -1, -1, -1, cVoltMeterPerSecond, -1, cSiemensPerMeter, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatalPerCubicMeter, -1, -1, -1, cSquareHertz, cMeterPerSecond, cSquareMeterPerSecond, cCubicMeterPerSecond, cSquareMeterPerSquareSecond, -1, cWatt, -1, -1, -1, cWattPerSquareMeter, -1, -1),
    (cSquareHertz, cHertz, cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cMeterPerSquareSecond, cSquareHertz, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, cNewtonPerMeter, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, -1, -1, cMeterPerSecond, cNewton, cWattPerSquareMeter, cWattPerMeter, cSquareNewton, cSquareHertz, -1, cSquareHertz, -1, -1, -1, cJoule, cWatt, -1, cPascal, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, cGrayPerSecond, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, cReciprocalSquareMeter, -1, cSquareJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareHertz, cHertz, cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cMeterPerSquareSecond, cSquareHertz, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, cNewtonPerMeter, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, -1, -1, cMeterPerSecond, cNewton, cWattPerSquareMeter, cWattPerMeter, cSquareNewton, cSquareHertz, -1, cSquareHertz, -1, -1, -1, cJoule, cWatt, -1, cPascal, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, cGrayPerSecond, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, cReciprocalSquareMeter, -1, cSquareJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerSecond, cMeter, cMeterSecond, -1, -1, -1, -1, cSquareMeterPerSecond, cMeterPerSecond, cCubicMeterPerSecond, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerCubicSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, -1, -1, cSquareMeter, cKilogramSquareMeterPerSecond, cNewton, cJoule, -1, cMeterPerSecond, cHertz, cMeterPerSecond, -1, -1, -1, -1, cNewtonSquareMeter, cScalar, cKilogramPerSecond, cPoiseuille, -1, cWatt, cWatt, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, cSquareMeterAmpere, cVoltMeterPerSecond, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cReciprocalHenry, cVoltPerMeter, cVoltMeter, cOhmMeter, -1, -1, -1, cLux, -1, -1, -1, cWattPerCubicMeter, cWattPerMeter, -1, cNewtonPerMeter, cCubicMeterPerSquareSecond, -1, cQuinticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, cAmperePerMeter, -1, -1, -1, -1, -1, cSiemens, -1, -1, cVolt, -1, cOhm, cHertz, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, cMeterPerSquareSecond, cSquareMeterPerSecond, cCubicMeterPerSecond, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1),
    (cMeterPerSquareSecond, cMeterPerSecond, cMeter, cMeterSecond, -1, -1, -1, cSquareMeterPerSquareSecond, cMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuarticSecond, cGrayPerSecond, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, cJoule, cWattPerMeter, cWatt, -1, cMeterPerSquareSecond, cSquareHertz, cMeterPerSquareSecond, -1, -1, -1, cNewtonSquareMeter, -1, cHertz, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, cKilogramMeter, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, cNewtonPerSquareCoulomb, -1, cSquareHertz, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerCubicSecond, cMeterPerSquareSecond, cMeterPerSecond, cMeter, cMeterSecond, -1, -1, cGrayPerSecond, cMeterPerCubicSecond, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cWatt, -1, -1, -1, cMeterPerCubicSecond, -1, cMeterPerCubicSecond, -1, -1, -1, -1, -1, cSquareHertz, cWattPerSquareMeter, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuarticSecond, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerQuarticSecond, cMeterPerCubicSecond, cMeterPerSquareSecond, cMeterPerSecond, cMeter, cMeterSecond, -1, -1, cMeterPerQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, cMeterPerSexticSecond, cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, -1, -1, cMeterPerQuarticSecond, -1, cMeterPerQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerQuinticSecond, cMeterPerQuarticSecond, cMeterPerCubicSecond, cMeterPerSquareSecond, cMeterPerSecond, cMeter, cMeterSecond, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerSexticSecond, cMeterPerQuinticSecond, cMeterPerQuarticSecond, cMeterPerCubicSecond, cMeterPerSquareSecond, cMeterPerSecond, cMeter, -1, cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSexticSecond, -1, cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSquareSecond, cSquareMeterPerSecond, cSquareMeter, -1, -1, -1, -1, cCubicMeterPerSquareSecond, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, cJoule, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cNewtonSquareMeter, cWatt, -1, cSquareJoule, cSquareMeterPerSquareSecond, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, cSquareHertz, -1, -1, cNewtonCubicMeter, -1, cMeterPerSecond, cNewton, cNewtonPerMeter, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, cNewtonPerCubicMeter, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, cNewtonSquareMeterPerSquareCoulomb, cMeterPerSquareSecond, cSquareNewton, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterSecond, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, cQuarticMeterSecond, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, cMeter, cMeterPerSecond, cMeterPerSecond, cSquareMeter, cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, cCubicMeterPerSecond, -1, -1, cKilogramMeter, cKilogramSquareMeter, -1, cMeterSecond, cSecond, cMeterSecond, cSecondPerMeter, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, cKilogramSquareMeterPerSecond, cKilogramSquareMeterPerSecond, -1, cKilogramPerSecond, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, cKilogramMeterPerSecond, cQuarticMeter, cKilogram, cCubicMeter, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cNewton, cNewtonPerMeter, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, -1, -1, cCubicMeterPerSquareSecond, cMeter, -1, -1, cQuarticMeterSecond, cCubicMeter, cNewtonSquareMeter, -1, cJoule, cNewton, cNewtonPerMeter, cKilogramMeterPerSecond, -1, -1),
    (cKilogramMeter, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, cNewton, cNewton, cKilogramSquareMeterPerSecond, cJoule, cWatt, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, cKilogramMeter, cKilogram, cKilogramMeter, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogramPerCubicMeter, -1, -1, -1, cSquareKilogram, cSquareKilogramPerMeter, cSquareKilogramPerSquareMeter, cSquareKilogramSquareMeterPerSquareSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, cNewtonCubicMeter, cSquareJouleSquareSecond, -1, cSquareMeterPerSquareSecond, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, cKilogramKelvin, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, -1, -1, cKilogramMeterPerSecond, cKilogramPerSecond, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, cWattPerSquareMeter, cWattPerSquareMeter, cNewton, cWattPerMeter, -1, -1, -1, -1, cWatt, cKilogramMeter, -1, cSquareKilogramPerSquareSecond, -1, -1, cKilogramPerSecond, cPoiseuille, cKilogramPerSecond, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, cSquareKilogramSquareMeterPerSquareSecond, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cJoule, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, cMeterPerCubicSecond, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, cJoule, cSquareNewton, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, cWattPerMeter, cWattPerMeter, cJoule, cWatt, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, cKilogramMeterPerSecond, cKilogramPerSecond, cKilogramMeterPerSecond, cPoiseuille, -1, -1, -1, -1, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, cSquareKilogramPerSquareSecond, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, cKilogramSquareMeterPerSecond, -1, -1, cNewtonSquareMeter, -1, -1, cSquareNewton, -1, -1, -1, -1, -1),
    (cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, cSquareNewton, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareKilogramSquareMeterPerSquareSecond, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, cMeter, cScalar, cSquareMeter, cCubicMeter, cQuarticMeter, cQuinticMeter, cSexticMeter, cKilogram, cSquareKilogram, cAmpere, cSquareAmpere, cKelvin, cSquareKelvin, cCubicKelvin, cQuarticKelvin, cMole, cCandela, cHertz, cSquareHertz, cSquareHertz, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, cSquareMeterPerSquareSecond, cMeterSecond, cKilogramMeter, cKilogramPerSecond, cKilogramMeterPerSecond, cSquareKilogramSquareMeterPerSquareSecond, cScalar, cReciprocalMeter, cScalar, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, cKilogramSquareMeter, cKilogramSquareMeterPerSecond, cSecondPerMeter, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cNewton, cNewton, cSquareNewton, cPascal, cJoule, cJoule, cWatt, cCoulomb, cSquareCoulomb, cCoulombMeter, cVolt, cSquareVolt, cFarad, cOhm, cSiemens, cSiemensPerMeter, cTesla, cWeber, cHenry, cReciprocalHenry, cCandela, cLumenSecond, cLumenSecondPerCubicMeter, cLux, cLuxSecond, cKatal, cNewtonPerCubicMeter, cNewtonPerMeter, cCubicMeterPerSecond, cPoiseuille, cSquareMeterPerSecond, cKilogramPerQuarticMeter, cQuarticMeterSecond, cKilogramPerQuarticMeterPerSecond, cCubicMeterPerKilogram, cKilogramSquareSecond, cCubicMeterPerSquareSecond, cNewtonSquareMeter, cNewtonCubicMeter, cNewtonPerSquareKilogram, cSquareKilogramPerMeter, cSquareKilogramPerSquareMeter, cSquareMeterPerSquareKilogram, cNewtonSquareMeterPerSquareKilogram, cReciprocalKelvin, cKilogramKelvin, cJoulePerKelvin, cJoulePerKilogramPerKelvin, cMeterKelvin, cKelvinPerMeter, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, cWattPerKelvin, cWattPerMeterPerKelvin, cKelvinPerWatt, cMeterPerWatt, cMeterKelvinPerWatt, cSquareMeterKelvin, cWattPerSquareMeterPerKelvin, cSquareMeterQuarticKelvin, cWattPerQuarticKelvin, cWattPerSquareMeterPerQuarticKelvin, cJoulePerMole, cMoleKelvin, cJoulePerMolePerKelvin, cOhmMeter, cVoltPerMeter, cCoulombPerMeter, cSquareCoulombPerMeter, cCoulombPerSquareMeter, cSquareMeterPerSquareCoulomb, cNewtonPerSquareCoulomb, cNewtonSquareMeterPerSquareCoulomb, cVoltMeter, cVoltMeterPerSecond, cFaradPerMeter, cAmperePerMeter, cMeterPerAmpere, cTeslaMeter, cTeslaPerAmpere, cHenryPerMeter, cReciprocalMeter, cSquareKilogramPerSquareSecond, cSquareSecondPerSquareMeter, cSquareJoule, cSquareJouleSquareSecond, cCoulombPerKilogram, cSquareMeterAmpere, cLumenPerWatt, cReciprocalMole, cAmperePerSquareMeter, cMolePerCubicMeter, cLux, cCoulombPerCubicMeter, cGrayPerSecond, cHertz, cMeter, cSquareMeter, cCubicMeter, cSquareMeterPerSecond, cWatt, cJoule, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, cNewtonPerMeter, cKatalPerCubicMeter, cCoulombPerMole),
    (cReciprocalMeter, cSecondPerMeter, -1, -1, -1, -1, -1, cScalar, cReciprocalMeter, cMeter, cSquareMeter, cCubicMeter, cQuarticMeter, cQuinticMeter, cKilogramPerMeter, cSquareKilogramPerMeter, cAmperePerMeter, -1, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, cSquareHertz, -1, -1, -1, -1, cMeterPerSquareSecond, cSecond, cKilogram, cPoiseuille, cKilogramPerSecond, -1, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, cKilogramMeter, cKilogramMeterPerSecond, -1, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, cNewtonPerMeter, cNewtonPerMeter, -1, cNewtonPerCubicMeter, cNewton, cNewton, cWattPerMeter, cCoulombPerMeter, cSquareCoulombPerMeter, cCoulomb, cVoltPerMeter, -1, cFaradPerMeter, -1, cSiemensPerMeter, -1, -1, cTeslaMeter, cHenryPerMeter, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, cPascal, cSquareMeterPerSecond, -1, cMeterPerSecond, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cJoule, cNewtonSquareMeter, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, cWattPerSquareMeter, cWattPerCubicMeter, -1, cWattPerMeterPerKelvin, cWattPerSquareMeterPerKelvin, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, cCoulombPerSquareMeter, -1, cCoulombPerCubicMeter, -1, -1, -1, cVolt, -1, -1, cAmperePerSquareMeter, -1, cTesla, -1, cTeslaPerAmpere, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, -1, cScalar, cMeter, cSquareMeter, cMeterPerSecond, cWattPerMeter, cNewton, cWattPerSquareMeter, cWattPerCubicMeter, -1, cPascal, -1, -1),
    (cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, cMeter, cScalar, cSquareMeter, cCubicMeter, cQuarticMeter, cQuinticMeter, cSexticMeter, cKilogram, cSquareKilogram, cAmpere, cSquareAmpere, cKelvin, cSquareKelvin, cCubicKelvin, cQuarticKelvin, cMole, cCandela, cHertz, cSquareHertz, cSquareHertz, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, cSquareMeterPerSquareSecond, cMeterSecond, cKilogramMeter, cKilogramPerSecond, cKilogramMeterPerSecond, cSquareKilogramSquareMeterPerSquareSecond, cScalar, cReciprocalMeter, cScalar, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, cKilogramSquareMeter, cKilogramSquareMeterPerSecond, cSecondPerMeter, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cNewton, cNewton, cSquareNewton, cPascal, cJoule, cJoule, cWatt, cCoulomb, cSquareCoulomb, cCoulombMeter, cVolt, cSquareVolt, cFarad, cOhm, cSiemens, cSiemensPerMeter, cTesla, cWeber, cHenry, cReciprocalHenry, cCandela, cLumenSecond, cLumenSecondPerCubicMeter, cLux, cLuxSecond, cKatal, cNewtonPerCubicMeter, cNewtonPerMeter, cCubicMeterPerSecond, cPoiseuille, cSquareMeterPerSecond, cKilogramPerQuarticMeter, cQuarticMeterSecond, cKilogramPerQuarticMeterPerSecond, cCubicMeterPerKilogram, cKilogramSquareSecond, cCubicMeterPerSquareSecond, cNewtonSquareMeter, cNewtonCubicMeter, cNewtonPerSquareKilogram, cSquareKilogramPerMeter, cSquareKilogramPerSquareMeter, cSquareMeterPerSquareKilogram, cNewtonSquareMeterPerSquareKilogram, cReciprocalKelvin, cKilogramKelvin, cJoulePerKelvin, cJoulePerKilogramPerKelvin, cMeterKelvin, cKelvinPerMeter, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, cWattPerKelvin, cWattPerMeterPerKelvin, cKelvinPerWatt, cMeterPerWatt, cMeterKelvinPerWatt, cSquareMeterKelvin, cWattPerSquareMeterPerKelvin, cSquareMeterQuarticKelvin, cWattPerQuarticKelvin, cWattPerSquareMeterPerQuarticKelvin, cJoulePerMole, cMoleKelvin, cJoulePerMolePerKelvin, cOhmMeter, cVoltPerMeter, cCoulombPerMeter, cSquareCoulombPerMeter, cCoulombPerSquareMeter, cSquareMeterPerSquareCoulomb, cNewtonPerSquareCoulomb, cNewtonSquareMeterPerSquareCoulomb, cVoltMeter, cVoltMeterPerSecond, cFaradPerMeter, cAmperePerMeter, cMeterPerAmpere, cTeslaMeter, cTeslaPerAmpere, cHenryPerMeter, cReciprocalMeter, cSquareKilogramPerSquareSecond, cSquareSecondPerSquareMeter, cSquareJoule, cSquareJouleSquareSecond, cCoulombPerKilogram, cSquareMeterAmpere, cLumenPerWatt, cReciprocalMole, cAmperePerSquareMeter, cMolePerCubicMeter, cLux, cCoulombPerCubicMeter, cGrayPerSecond, cHertz, cMeter, cSquareMeter, cCubicMeter, cSquareMeterPerSecond, cWatt, cJoule, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, cNewtonPerMeter, cKatalPerCubicMeter, cCoulombPerMole),
    (cReciprocalSquareMeter, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, cReciprocalMeter, cReciprocalSquareMeter, cScalar, cMeter, cSquareMeter, cCubicMeter, cQuarticMeter, cKilogramPerSquareMeter, cSquareKilogramPerSquareMeter, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareHertz, cSecondPerMeter, cKilogramPerMeter, -1, cPoiseuille, cSquareKilogramPerSquareSecond, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalSquareMeter, cReciprocalQuarticMeter, -1, -1, cKilogram, cKilogramPerSecond, -1, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, cPascal, cPascal, -1, -1, cNewtonPerMeter, cNewtonPerMeter, cWattPerSquareMeter, cCoulombPerSquareMeter, -1, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cTesla, cTeslaPerAmpere, -1, cLux, cLuxSecond, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, cMeterPerSecond, -1, cHertz, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cNewton, cJoule, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, cKelvinPerMeter, -1, cWattPerCubicMeter, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, cReciprocalKelvin, -1, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, cNewtonPerSquareCoulomb, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, cSquareNewton, cSquareKilogramSquareMeterPerSquareSecond, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cScalar, cMeter, cHertz, cWattPerSquareMeter, cNewtonPerMeter, cWattPerCubicMeter, -1, -1, cNewtonPerCubicMeter, -1, -1),
    (cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalMeter, cScalar, cMeter, cSquareMeter, cCubicMeter, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, cReciprocalCubicMeter, cReciprocalQuarticMeter, cReciprocalCubicMeter, -1, -1, -1, cKilogramPerMeter, cPoiseuille, -1, cKilogramPerQuarticMeter, -1, -1, cNewtonPerCubicMeter, cNewtonPerCubicMeter, -1, -1, cPascal, cPascal, cWattPerCubicMeter, cCoulombPerCubicMeter, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, cKatalPerCubicMeter, -1, -1, cHertz, cKilogramPerQuarticMeterPerSecond, -1, -1, cMeterSecond, -1, -1, -1, cSquareHertz, cNewtonPerMeter, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cReciprocalMeter, cScalar, -1, cWattPerCubicMeter, cPascal, -1, -1, -1, -1, -1, -1),
    (cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, cReciprocalQuarticMeter, cReciprocalSquareMeter, cReciprocalMeter, cScalar, cMeter, cSquareMeter, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, cKilogramPerQuarticMeterPerSecond, -1, -1, cReciprocalQuarticMeter, -1, cReciprocalQuarticMeter, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, cNewtonPerCubicMeter, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, -1, -1, -1, cPascal, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, cReciprocalSquareMeter, cReciprocalMeter, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1),
    (cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cJoule, cJoule, -1, cNewtonSquareMeter, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, cKilogramSquareMeter, cKilogramMeter, cKilogramSquareMeter, cKilogram, cKilogramPerMeter, cKilogramPerSquareMeter, -1, -1, -1, -1, cSquareKilogram, cSquareKilogramPerMeter, -1, -1, -1, -1, cSquareJouleSquareSecond, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, cQuinticMeter, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, cSquareJouleSquareSecond, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1),
    (cKilogramSquareMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cWatt, cWatt, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, cKilogramSquareMeterPerSecond, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, cKilogramPerSecond, cPoiseuille, -1, -1, cSquareJouleSquareSecond, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, cNewtonCubicMeter, cSquareJoule, -1, -1, cSquareNewton, -1, -1, -1, -1),
    (cSecondPerMeter, -1, -1, -1, -1, -1, -1, cSecond, cSecondPerMeter, cMeterSecond, -1, -1, cQuarticMeterSecond, -1, -1, -1, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, -1, cScalar, cHertz, cSquareHertz, -1, -1, -1, cMeterPerSecond, cSquareSecond, -1, cKilogramPerMeter, cKilogram, -1, cSecondPerMeter, -1, cSecondPerMeter, -1, -1, -1, -1, cKilogramMeter, cSquareSecondPerSquareMeter, -1, -1, -1, cKilogramPerSecond, cKilogramPerSecond, -1, -1, cKilogramMeterPerSecond, cKilogramMeterPerSecond, cNewton, -1, -1, -1, cTeslaMeter, -1, -1, cHenryPerMeter, cFaradPerMeter, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, cPoiseuille, cSquareMeter, cKilogramPerSquareMeter, cMeter, -1, -1, -1, -1, -1, cSquareMeterPerSecond, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, cTesla, -1, -1, -1, -1, -1, cOhm, cWeber, cVolt, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, cCoulombPerCubicMeter, -1, cLumenSecondPerCubicMeter, -1, cMeterPerSquareSecond, cReciprocalMeter, cSecond, cMeterSecond, -1, cMeter, cNewton, cKilogramMeterPerSecond, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, cPoiseuille, -1, -1),
    (cKilogramPerMeter, -1, -1, -1, -1, -1, -1, cKilogram, cKilogramPerMeter, cKilogramMeter, cKilogramSquareMeter, -1, -1, -1, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, cPascal, cPascal, cKilogramPerSecond, cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, cNewton, -1, cSquareKilogram, -1, -1, -1, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogramPerMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, cSquareKilogramPerSquareSecond, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, cKilogramMeterPerSecond, -1, -1, -1, cSquareMeter, -1, cJoule, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareHertz, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, cPoiseuille, cKilogram, cKilogramMeter, cKilogramSquareMeter, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogram, cKilogramMeter, cKilogramSquareMeter, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, cNewtonPerCubicMeter, cPoiseuille, cPascal, cWattPerCubicMeter, -1, -1, -1, cNewtonPerMeter, -1, cSquareKilogramPerMeter, -1, -1, -1, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerSquareMeter, cKilogramPerQuarticMeter, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, cKilogramPerSecond, -1, -1, -1, cMeter, -1, cNewton, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, cKilogramPerMeter, cKilogram, cKilogramMeter, cKilogramPerSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1),
    (cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerMeter, cKilogram, cKilogramMeter, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, cPascal, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, cKilogramPerCubicMeter, -1, -1, -1, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, -1, cPoiseuille, -1, -1, -1, cScalar, -1, cNewtonPerMeter, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1, cKilogramPerSquareMeter, cKilogramPerMeter, cKilogram, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewton, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, -1, cJoule, cNewton, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, cNewton, cNewtonPerMeter, cNewton, cPascal, cNewtonPerCubicMeter, -1, -1, -1, cKilogramPerSecond, cSquareKilogramPerSquareSecond, -1, -1, cSquareNewton, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cSquareVolt, -1, -1, -1, -1, cWeber, -1, -1, -1, cNewtonPerMeter, -1, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewton, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, -1, cJoule, cNewton, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, cNewton, cNewtonPerMeter, cNewton, cPascal, cNewtonPerCubicMeter, -1, -1, -1, cKilogramPerSecond, cSquareKilogramPerSquareSecond, -1, -1, cSquareNewton, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cSquareVolt, -1, -1, -1, -1, cWeber, -1, -1, -1, cNewtonPerMeter, -1, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareNewton, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, cSquareNewton, cSquareJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cPascal, cPoiseuille, cKilogramPerMeter, -1, -1, -1, -1, cNewtonPerMeter, cPascal, cNewton, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, cSquareKilogramPerSquareSecond, -1, -1, -1, cPascal, cNewtonPerCubicMeter, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, cWattPerMeter, -1, -1, -1, cSquareMeterPerSquareSecond, cSquareKilogramPerMeter, -1, cSquareNewton, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, cNewtonPerCubicMeter, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, cNewtonPerMeter, cNewton, cJoule, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoule, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, cNewtonSquareMeter, cJoule, cNewtonCubicMeter, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cNewton, cJoule, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, cSquareJouleSquareSecond, -1, cKilogramMeterPerSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, cSquareJoule, cSquareJoule, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, cNewton, -1, cKilogram, -1, -1, -1, -1, cLumenSecond, cJoulePerMole, -1, -1, -1, -1, -1, cWatt, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, cSquareJoule, -1, -1, -1, cSquareNewton, -1, -1),
    (cJoule, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, cNewtonSquareMeter, cJoule, cNewtonCubicMeter, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cNewton, cJoule, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, cSquareJouleSquareSecond, -1, cKilogramMeterPerSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, cSquareJoule, cSquareJoule, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, cNewton, -1, cKilogram, -1, -1, -1, -1, cLumenSecond, cJoulePerMole, -1, -1, -1, -1, -1, cWatt, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, cSquareJoule, -1, -1, -1, cSquareNewton, -1, -1),
    (cWatt, cJoule, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cSquareNewton, -1, -1, cWatt, cWattPerMeter, cWatt, cWattPerSquareMeter, cWattPerCubicMeter, -1, -1, cSquareJoule, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, cMeter, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, cWattPerMeter, -1, cKilogramPerSecond, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCoulomb, -1, -1, -1, -1, -1, -1, cCoulombMeter, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, cCoulombPerMeter, cCoulomb, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, cJoule, -1, -1, cWeber, -1, -1, cKilogramPerSecond, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, cSquareCoulombPerMeter, -1, -1, -1, cVoltPerMeter, cVoltMeter, cNewtonSquareMeter, -1, -1, -1, cMeterSecond, cKilogramMeterPerSecond, -1, -1, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMole, -1, -1, -1, -1, -1, cAmpere, cCoulombMeter, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, cSquareCoulombPerMeter, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, cNewton, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, cKilogram, cKilogramMeter, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, cCoulomb, cCoulombMeter, cCoulombPerMeter, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cSquareCoulomb, -1, cSquareCoulombPerMeter, -1, cVolt, -1, cNewtonCubicMeter, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cVolt, cWeber, -1, -1, -1, -1, -1, cVoltMeter, cVolt, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, cVoltPerMeter, cVolt, -1, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, cNewtonSquareMeter, cSquareVolt, -1, cCoulomb, -1, cAmpere, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, cCoulombPerMeter, cWattPerMeter, cOhmMeter, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, cWattPerSquareMeter, -1, -1, cPascal, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole),
    (cSquareVolt, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1, -1, cJoule, -1, cWatt, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cFarad, -1, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, cReciprocalHenry, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, cFaradPerMeter, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, cSquareCoulombPerMeter, -1, -1, cSquareCoulomb, cSquareCoulomb, -1, -1, -1, -1, cCoulomb, cJoule, -1, cSecond, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, cCoulombPerMeter, -1, -1, -1, -1, cReciprocalMeter, cMeter, cCoulombMeter, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1),
    (cOhm, cHenry, -1, -1, -1, -1, -1, cOhmMeter, cOhm, -1, -1, -1, -1, -1, -1, -1, cVolt, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, cOhm, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, cWeber, cKilogramSquareMeterPerSecond, -1, -1, -1, cSecond, -1, cScalar, cReciprocalMeter, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, cKilogramMeterPerSecond, cTesla, -1, -1, -1, -1, -1, cSecondPerMeter, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1),
    (cSiemens, cFarad, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, cSiemens, cSiemensPerMeter, cSiemens, -1, -1, -1, -1, cSquareCoulomb, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, cAmpere, cWatt, -1, cScalar, -1, -1, cCoulombPerSquareMeter, cCoulomb, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, cAmperePerMeter, -1, -1, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, cSecondPerMeter, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1),
    (cSiemensPerMeter, cFaradPerMeter, -1, -1, -1, -1, -1, cSiemens, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, cSiemensPerMeter, -1, cSiemensPerMeter, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, cWattPerMeter, -1, cReciprocalMeter, -1, -1, cCoulombPerCubicMeter, cCoulombPerMeter, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cAmperePerSquareMeter, -1, -1, -1, -1, -1, cHertz, cAmpere, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cTesla, -1, -1, -1, -1, -1, -1, cTeslaMeter, cTesla, cWeber, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, cVolt, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, cJoule, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, cTeslaMeter, cWeber, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWeber, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, cVoltMeter, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, cTeslaMeter, cWeber, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, cCoulomb, cCoulombPerMeter, -1, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, cNewton, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, cSquareMeterPerSecond, cNewtonCubicMeter, -1, -1, cNewtonPerMeter, -1, -1, cPoiseuille, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cHenry, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, cWeber, cJoule, -1, -1, -1, -1, -1, -1, cOhm, -1, -1, cOhmMeter, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, cHenryPerMeter, cHenry, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, cSquareSecond, -1, cSecond, cSecondPerMeter, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalHenry, cSiemens, cFarad, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, cReciprocalHenry, -1, cReciprocalHenry, -1, -1, -1, cSquareCoulomb, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, cAmperePerSquareMeter, cAmpere, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, cAmperePerMeter, cReciprocalSquareMeter, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1),
    (cCandela, cLumenSecond, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, cCandela, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cLumenSecond, -1, -1, -1, -1, -1, -1, -1, cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecond, -1, cLumenSecond, cLuxSecond, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, cLuxSecond, cLumenSecondPerCubicMeter, -1, cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLuxSecond, -1, cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cLux, cLuxSecond, -1, -1, -1, -1, -1, -1, cLux, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLux, -1, cLux, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cLuxSecond, -1, -1, -1, -1, -1, -1, -1, cLuxSecond, cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLuxSecond, cLumenSecondPerCubicMeter, cLuxSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLux, -1, cLumenSecond, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKatal, cMole, -1, -1, -1, -1, -1, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, cKatal, -1, cKatalPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere),
    (cNewtonPerCubicMeter, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, cPascal, cNewtonPerCubicMeter, cNewtonPerMeter, cNewton, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, cNewtonPerCubicMeter, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, cWattPerSquareMeter, -1, cKilogramSquareMeterPerSecond, -1, cMeterPerSquareSecond, cSquareKilogramPerSquareMeter, -1, -1, cSquareNewton, -1, -1, -1, -1, cMeterPerQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cNewtonPerMeter, cNewton, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonPerMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, -1, cNewton, cNewtonPerMeter, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, cNewtonPerMeter, cPascal, cNewtonPerMeter, cNewtonPerCubicMeter, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, cCubicMeterPerSquareSecond, cSquareKilogram, -1, -1, cSquareJoule, cMeterPerQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, cPascal, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, cNewton, cJoule, cNewtonSquareMeter, cWatt, -1, cSquareNewton, -1, -1, -1, -1, -1, -1),
    (cCubicMeterPerSecond, cCubicMeter, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, cNewtonSquareMeter, cNewtonCubicMeter, -1, cCubicMeterPerSecond, cSquareMeterPerSecond, cCubicMeterPerSecond, cMeterPerSecond, cHertz, -1, -1, -1, cSquareMeter, cKilogramSquareMeterPerSecond, cKilogramMeterPerSecond, cKilogramPerSecond, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, cWattPerMeter, -1, -1, cJoule, -1, cPoiseuille, -1, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, cSquareMeterPerSecond, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, cAmpere, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cPoiseuille, cKilogramPerMeter, -1, -1, -1, -1, -1, cKilogramPerSecond, cPoiseuille, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cWattPerCubicMeter, cWattPerCubicMeter, cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, -1, cWattPerMeter, cKilogram, -1, -1, cSquareKilogramPerSquareSecond, -1, cPoiseuille, -1, cPoiseuille, -1, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, cNewton, -1, -1, -1, cSquareMeterPerSecond, -1, cWatt, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cKilogramPerSecond, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, cNewton, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSecond, cSquareMeter, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cSquareMeterPerSecond, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cGrayPerSecond, cGrayPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, cJoule, cNewtonSquareMeter, -1, cSquareMeterPerSecond, cMeterPerSecond, cSquareMeterPerSecond, cHertz, -1, -1, -1, cNewtonCubicMeter, cMeter, cKilogramMeterPerSecond, cKilogramPerSecond, cPoiseuille, -1, -1, -1, cWattPerMeter, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, cWattPerSquareMeter, cWatt, -1, cNewton, -1, -1, cSexticMeter, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, cOhm, cOhmMeter, cMeterPerSecond, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, cSquareMeterPerSquareSecond, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1),
    (cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, cKilogramPerSquareMeter, cKilogramPerMeter, cKilogram, cKilogramMeter, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, cKilogramPerQuarticMeter, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, cReciprocalMeter, -1, cPascal, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, cKilogramPerCubicMeter, cKilogramPerSquareMeter, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuarticMeterSecond, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, -1, cQuinticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, cQuarticMeterSecond, -1, cMeterSecond, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, cSexticMeter, -1, -1, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, -1, -1, cSexticMeter, -1, -1, -1, cNewtonCubicMeter, cNewtonSquareMeter, -1, -1, -1),
    (cKilogramPerQuarticMeterPerSecond, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, cPoiseuille, cKilogramPerSecond, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, -1, cNewtonPerCubicMeter, -1, cKilogram, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, cCubicMeterPerSecond, -1, -1, cCubicMeterPerKilogram, -1, cCubicMeterPerKilogram, -1, -1, -1, cQuinticMeter, -1, -1, cSquareMeter, cMeter, cScalar, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, cSquareMeterPerSecond, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, cCubicMeterPerSquareSecond, -1, -1),
    (cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, cKilogram, -1, cKilogramMeter, cKilogramMeterPerSecond, cNewton, cWattPerMeter, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, -1),
    (cCubicMeterPerSquareSecond, cCubicMeterPerSecond, cCubicMeter, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, cCubicMeterPerSquareSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, cMeterPerSquareSecond, cSquareHertz, -1, -1, -1, cSquareMeterPerSecond, cJoule, cNewton, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, cPascal, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cSquareMeterPerSquareSecond, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJouleSquareSecond, -1, -1, -1, cNewtonSquareMeter, cJoule, cNewtonSquareMeter, cNewton, cNewtonPerMeter, cPascal, -1, -1, cKilogramSquareMeterPerSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareKilogramPerSquareSecond, cSquareJoule, cSquareJoule, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, cJoule, -1, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, cNewtonSquareMeter, cNewtonCubicMeter, cJoule, cNewton, cNewtonPerMeter, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, cSquareJoule, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, -1),
    (cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, cMeterPerSquareSecond, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cMeterPerCubicSecond, cGrayPerSecond, -1, cNewtonPerSquareKilogram, -1, cNewtonPerSquareKilogram, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuarticSecond, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, -1, -1, -1, cNewtonPerMeter, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, cMeterPerQuarticSecond, -1, -1),
    (cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, cSquareKilogram, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, cSquareKilogramPerSquareMeter, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, cNewtonPerMeter, -1, -1, cMeter, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, cSquareKilogramPerSquareMeter, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, -1, -1, -1, -1, cPascal, -1, -1, cScalar, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, cSquareMeterPerSquareKilogram, -1, cSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, cNewtonSquareMeterPerSquareKilogram, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonSquareMeterPerSquareKilogram, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, cNewtonSquareMeterPerSquareKilogram, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cMeterPerSquareSecond, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuarticSecond, -1, -1, cGrayPerSecond, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, cJoule, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cKelvin, cSquareKelvin, cCubicKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, cJoulePerKelvin, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, -1, -1, cMeter, cReciprocalMeter, cWattPerMeterPerKelvin, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterKelvin, -1, -1, cWattPerKelvin, cJoulePerKelvin, cWattPerMeterPerKelvin, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1),
    (cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramKelvin, -1, cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, -1, cSquareKilogramSquareMeterPerSquareSecond, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, cNewtonSquareMeter, cNewton, -1, -1, -1, -1, -1, cSecond, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoulePerKilogramPerKelvin, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, cJoulePerKilogramPerKelvin, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, cCubicMeterPerSquareSecond, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, cKelvin, cMeterKelvin, cKelvinPerMeter, -1, -1, -1, -1, -1, cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, cNewtonSquareMeter, cCubicMeterPerSquareSecond, -1, cSquareKelvin, -1, -1, -1, -1, cWatt, -1, -1, -1, cCubicMeter, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKelvinPerMeter, -1, -1, -1, -1, -1, -1, cKelvin, cKelvinPerMeter, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramKelvin, -1, -1, -1, cKelvinPerMeter, -1, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, cNewton, cMeterPerSquareSecond, cSquareKelvin, -1, -1, -1, -1, cWattPerMeter, cWattPerSquareMeter, -1, cKelvinPerWatt, -1, cMeter, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerMeter, cNewton, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, cWatt, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, cSquareNewton, -1, cWattPerMeter, cWattPerSquareMeter, cWattPerMeter, cWattPerCubicMeter, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, cScalar, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, -1, cWattPerSquareMeter, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerSquareMeter, cNewtonPerMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, cWattPerMeter, cWattPerSquareMeter, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, -1, -1, -1, cWattPerSquareMeter, cWattPerCubicMeter, cWattPerSquareMeter, -1, -1, -1, -1, cSquareNewton, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cKelvinPerMeter, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerCubicMeter, cPascal, cPoiseuille, cKilogramPerMeter, -1, -1, -1, cWattPerSquareMeter, cWattPerCubicMeter, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, cWattPerCubicMeter, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerKelvin, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, cWattPerMeterPerKelvin, cWattPerKelvin, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, cScalar, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, cWattPerKelvin, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, cWattPerMeterPerKelvin, cWattPerSquareMeterPerKelvin, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, cWattPerSquareMeter, -1, -1, -1, -1, -1, cReciprocalMeter, cReciprocalKelvin, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKelvinPerWatt, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, -1, -1, cKelvinPerMeter, -1, -1, cScalar, cReciprocalMeter, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, cKelvin, -1, cKelvinPerMeter, -1, -1, -1, -1, -1),
    (cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, cSquareSecond, -1, cMeterPerWatt, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, cSecond, cKilogramMeterPerSecond, -1, cMeterSecond, cMeterSecond, cMeter, -1, -1, -1, cMeterPerAmpere, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, cScalar, cReciprocalMeter, cReciprocalSquareMeter, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, cMeterSecond, cScalar, cReciprocalMeter, cReciprocalSquareMeter, cSecondPerMeter, -1, -1),
    (cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, cKelvinPerWatt, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, cMeterSecond, -1, -1, -1, cKelvin, cKelvinPerMeter, -1, cMeter, cScalar, -1, -1, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, cKelvin, cKelvinPerMeter, -1, -1, -1, -1),
    (cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterKelvin, -1, cSquareMeterKelvin, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, cCubicMeter, cMeter, -1, cWattPerKelvin, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, cWattPerMeterPerKelvin, cJoulePerKelvin, -1, -1),
    (cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, cWattPerSquareMeterPerKelvin, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, cWattPerCubicMeter, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, cSquareMeterQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterQuarticKelvin, -1, cSquareMeterQuarticKelvin, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, cWattPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerQuarticKelvin, -1, cWattPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerQuarticKelvin, -1, cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoulePerMole, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, cJoulePerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1),
    (cMoleKelvin, -1, -1, -1, -1, -1, -1, -1, cMoleKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMoleKelvin, -1, cMoleKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cOhmMeter, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, cOhm, cOhmMeter, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, cMeter, cScalar, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, cKilogramSquareMeterPerSecond, cTeslaMeter, -1, -1, -1, -1, -1, cSecond, cVolt, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, cTesla, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1),
    (cVoltPerMeter, cTeslaMeter, -1, -1, -1, -1, -1, cVolt, cVoltPerMeter, cVoltMeter, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, cVoltPerMeter, -1, cVoltPerMeter, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, cJoule, -1, -1, cCoulombPerMeter, -1, cAmperePerMeter, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, cPascal, -1, -1, -1, cSquareVolt, -1, cCoulombPerSquareMeter, cWattPerSquareMeter, cOhm, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, cWattPerCubicMeter, -1, -1, cNewtonPerCubicMeter, -1, -1, cVolt, cVoltMeter, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCoulombPerMeter, -1, -1, -1, -1, -1, -1, cCoulomb, cCoulombPerMeter, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, cCoulombPerSquareMeter, cCoulombPerMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, cSquareCoulomb, cNewton, -1, -1, cTeslaMeter, -1, -1, cPoiseuille, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, cNewtonPerMeter, -1, -1, -1, -1, -1, cVolt, cJoule, cWatt, -1, -1, cSecond, cKilogramPerSecond, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, cCoulomb, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, cSquareCoulomb, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, cMeter, cNewtonPerMeter, cJoule, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, cCoulombPerSquareMeter, cCoulomb, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, cCoulombPerCubicMeter, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, cNewtonPerMeter, -1, -1, cTesla, -1, -1, -1, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, cPascal, -1, -1, -1, -1, -1, cVoltPerMeter, cNewton, cWattPerMeter, -1, -1, cSecondPerMeter, cPoiseuille, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, cCoulombPerMeter, cCoulomb, cCoulombMeter, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, cHenry, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, cOhmMeter, -1, cSquareMeterPerSquareCoulomb, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, cHenryPerMeter, cTeslaPerAmpere, -1, cNewtonSquareMeterPerSquareCoulomb, cNewtonSquareMeterPerSquareCoulomb, cSquareVolt, cNewtonPerSquareCoulomb, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonPerSquareCoulomb, -1, cHenryPerMeter, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, cNewton, cVolt, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonSquareMeterPerSquareCoulomb, cOhmMeter, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cNewtonSquareMeterPerSquareCoulomb, cNewtonPerSquareCoulomb, -1, -1, -1, -1, cOhm, -1, -1, -1, cSquareVolt, cSquareVolt, -1, -1, -1, -1, -1, cVoltMeter, cNewtonSquareMeter, -1, -1, -1, cMeter, -1, cMeterPerSecond, cHertz, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, cJoule, cVoltPerMeter, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cVoltMeter, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, cVolt, cVoltMeter, cVoltPerMeter, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cNewtonCubicMeter, -1, -1, cCoulombMeter, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, cJoule, -1, cNewton, -1, -1, -1, -1, -1, cCoulomb, cWatt, -1, -1, -1, -1, cVolt, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, cWattPerMeter, -1, -1, cNewtonPerMeter, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cVoltMeterPerSecond, cVoltMeter, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, cWattPerMeter, -1, -1, -1, -1, -1, cAmpere, -1, -1, cSquareVolt, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cFaradPerMeter, -1, -1, -1, -1, -1, -1, cFarad, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, cSiemens, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, cSquareCoulombPerMeter, -1, -1, -1, -1, cCoulombPerMeter, cNewton, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, cCoulombPerSquareMeter, -1, -1, -1, -1, cReciprocalSquareMeter, cScalar, cCoulomb, cAmpere, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, cFarad, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1),
    (cAmperePerMeter, cCoulombPerMeter, -1, -1, -1, -1, -1, cAmpere, cAmperePerMeter, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, cAmperePerMeter, cAmperePerSquareMeter, cAmperePerMeter, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, cVoltPerMeter, -1, -1, cPascal, cNewton, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, cScalar, cNewtonPerMeter, -1, cTesla, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, cWeber, -1, cTesla, -1, -1, cVoltMeter, cMeterSecond, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, cSecond, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, cScalar, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, cVolt, cVoltPerMeter, -1, cTeslaMeter, -1, -1),
    (cTeslaMeter, -1, -1, -1, -1, -1, -1, cWeber, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, cVolt, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, cTeslaMeter, cTesla, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, cCoulombPerMeter, cCoulombPerSquareMeter, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, -1, cPoiseuille, -1, -1, -1, -1, cSquareVolt, -1, cNewtonPerMeter, cHenry, -1, -1, -1, cTesla, -1, -1, -1, -1, cMeterPerSecond, cNewtonSquareMeter, -1, -1, cPascal, -1, -1, -1, -1, cVoltPerMeter, cWeber, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, cHenryPerMeter, cTeslaPerAmpere, cHenry, -1, -1, -1, -1, -1, -1, cTesla, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, cOhm, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, cHenry, -1, cOhm, -1, -1, -1, -1, -1, -1, -1, -1),
    (cHenryPerMeter, -1, -1, -1, -1, -1, -1, cHenry, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, cNewton, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, cNewtonPerSquareCoulomb, cOhm, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, cHenryPerMeter, cTeslaPerAmpere, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, cTesla, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalMeter, cSecondPerMeter, -1, -1, -1, -1, -1, cScalar, cReciprocalMeter, cMeter, cSquareMeter, cCubicMeter, cQuarticMeter, cQuinticMeter, cKilogramPerMeter, cSquareKilogramPerMeter, cAmperePerMeter, -1, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, cSquareHertz, -1, -1, -1, -1, cMeterPerSquareSecond, cSecond, cKilogram, cPoiseuille, cKilogramPerSecond, -1, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, cKilogramMeter, cKilogramMeterPerSecond, -1, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, cNewtonPerMeter, cNewtonPerMeter, -1, cNewtonPerCubicMeter, cNewton, cNewton, cWattPerMeter, cCoulombPerMeter, cSquareCoulombPerMeter, cCoulomb, cVoltPerMeter, -1, cFaradPerMeter, -1, cSiemensPerMeter, -1, -1, cTeslaMeter, cHenryPerMeter, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, cPascal, cSquareMeterPerSecond, -1, cMeterPerSecond, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cJoule, cNewtonSquareMeter, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, cWattPerSquareMeter, cWattPerCubicMeter, -1, cWattPerMeterPerKelvin, cWattPerSquareMeterPerKelvin, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, cCoulombPerSquareMeter, -1, cCoulombPerCubicMeter, -1, -1, -1, cVolt, -1, -1, cAmperePerSquareMeter, -1, cTesla, -1, cTeslaPerAmpere, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, -1, cScalar, cMeter, cSquareMeter, cMeterPerSecond, cWattPerMeter, cNewton, cWattPerSquareMeter, cWattPerCubicMeter, -1, cPascal, -1, -1),
    (cSquareKilogramPerSquareSecond, -1, cSquareKilogram, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cReciprocalSquareMeter, cSecondPerMeter, cReciprocalMeter, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, cSquareKilogram, cSquareSecondPerSquareMeter, -1, cSquareSecondPerSquareMeter, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, cKilogramPerMeter, cKilogramPerMeter, cSquareKilogramPerSquareSecond, cKilogramPerCubicMeter, cKilogram, cKilogram, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, cKilogramPerSquareMeter, cMeterSecond, -1, cSecond, -1, -1, -1, -1, -1, cMeter, cKilogramMeter, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, cSquareSecond, -1, cSecond, cKilogramPerSecond, cKilogram, cPoiseuille, -1, -1, cKilogramPerSquareMeter, -1, -1),
    (cSquareJoule, -1, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, cSquareJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, -1, cSquareJoule, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, cSquareJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJouleSquareSecond, -1, cSquareJouleSquareSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, cAmpere, -1, -1, cCoulombPerKilogram, -1, cCoulombPerKilogram, -1, -1, -1, -1, cSquareMeterAmpere, -1, cCoulombPerMeter, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, cHertz, cSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, cReciprocalHenry, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, cSquareMeterAmpere, cAmpere, cAmperePerMeter, cAmperePerSquareMeter, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, cCubicMeter, cNewtonSquareMeter, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, cLumenSecond, cLumenSecond, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, cLumenSecond, -1, cLux, -1, cLuxSecond, -1, -1),
    (cReciprocalMole, -1, -1, -1, -1, -1, -1, -1, cReciprocalMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMole, -1, cReciprocalMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, cJoulePerMole, -1, cCoulombPerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, -1, -1, -1, -1, -1),
    (cAmperePerSquareMeter, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, cAmperePerMeter, cAmperePerSquareMeter, cAmpere, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, -1, -1, -1, cAmperePerSquareMeter, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, cNewtonPerMeter, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, cReciprocalMeter, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatalPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, cKatalPerCubicMeter, -1, -1, cMole, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter),
    (cLux, cLuxSecond, -1, -1, -1, -1, -1, -1, cLux, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLux, -1, cLux, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, cCoulombPerCubicMeter, cCoulombPerMeter, cCoulomb, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, -1, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, cAmperePerMeter, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, cCoulombPerMeter, cCoulomb, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cGrayPerSecond, cSquareMeterPerSquareSecond, cSquareMeterPerSecond, cSquareMeter, -1, -1, -1, -1, cGrayPerSecond, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, cGrayPerSecond, cMeterPerCubicSecond, cGrayPerSecond, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cHertz, cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cMeterPerSecond, cHertz, cSquareMeterPerSecond, cCubicMeterPerSecond, -1, -1, -1, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, cSquareHertz, -1, -1, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, cGrayPerSecond, cMeter, cKilogramMeterPerSecond, cNewtonPerMeter, cNewton, -1, cHertz, -1, cHertz, -1, -1, -1, cKilogramSquareMeterPerSecond, cJoule, cReciprocalMeter, cPoiseuille, -1, -1, cWattPerMeter, cWattPerMeter, -1, cWattPerCubicMeter, cWatt, cWatt, -1, cAmpere, -1, -1, -1, -1, cSiemens, -1, cReciprocalHenry, -1, -1, cVolt, cOhm, -1, -1, cCandela, -1, -1, cLux, -1, -1, cWattPerSquareMeter, cCubicMeterPerSquareSecond, cPascal, cSquareMeterPerSquareSecond, cKilogramPerQuarticMeterPerSecond, cQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cAmperePerMeter, -1, cAmperePerSquareMeter, -1, -1, -1, cVoltMeterPerSecond, -1, cSiemensPerMeter, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatalPerCubicMeter, -1, -1, -1, cSquareHertz, cMeterPerSecond, cSquareMeterPerSecond, cCubicMeterPerSecond, cSquareMeterPerSquareSecond, -1, cWatt, -1, -1, -1, cWattPerSquareMeter, -1, -1),
    (cMeter, cMeterSecond, -1, -1, -1, -1, -1, cSquareMeter, cMeter, cCubicMeter, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, cKilogramMeter, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerSquareSecond, cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, cCubicMeterPerSquareSecond, -1, cKilogramSquareMeter, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, cMeter, cScalar, cMeter, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, -1, -1, cSecond, cKilogram, cKilogramPerMeter, cKilogramPerSquareMeter, cJoule, cJoule, -1, cNewtonPerMeter, cNewtonSquareMeter, cNewtonSquareMeter, -1, cCoulombMeter, -1, -1, cVoltMeter, -1, -1, cOhmMeter, -1, cSiemens, cTeslaMeter, -1, -1, -1, -1, -1, cLuxSecond, -1, -1, -1, cPascal, cNewton, -1, cKilogramPerSecond, cCubicMeterPerSecond, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, cSquareKilogram, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, cKelvin, cWatt, cWattPerMeter, cWattPerSquareMeter, -1, cWattPerKelvin, cMeterKelvinPerWatt, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, cVolt, cCoulomb, cSquareCoulomb, cCoulombPerMeter, -1, -1, -1, -1, -1, cFarad, cAmpere, -1, cWeber, cHenryPerMeter, cHenry, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, cCoulombPerSquareMeter, -1, cMeterPerSecond, cSquareMeter, cCubicMeter, cQuarticMeter, cCubicMeterPerSecond, -1, cNewtonSquareMeter, cWatt, cWattPerMeter, cWattPerSquareMeter, cNewton, -1, -1),
    (cSquareMeter, -1, -1, -1, -1, -1, -1, cCubicMeter, cSquareMeter, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, -1, cKilogramSquareMeter, -1, cSquareMeterAmpere, -1, -1, -1, -1, cSquareMeterQuarticKelvin, -1, -1, cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, cSquareJouleSquareSecond, cSquareMeter, cMeter, cSquareMeter, cScalar, cReciprocalMeter, cReciprocalSquareMeter, -1, -1, cMeterSecond, cKilogramMeter, cKilogram, cKilogramPerMeter, cNewtonSquareMeter, cNewtonSquareMeter, cSquareJoule, cNewton, cNewtonCubicMeter, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, cCandela, cLumenSecond, -1, cNewtonPerMeter, cJoule, -1, cKilogramMeterPerSecond, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, cSquareKilogram, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, cMeterKelvin, -1, cWatt, cWattPerMeter, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, cCoulombMeter, -1, cCoulomb, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, cMeter, cSquareKilogramSquareMeterPerSquareSecond, cSquareSecond, -1, -1, -1, -1, -1, -1, cAmpere, -1, cCandela, cCoulombPerMeter, -1, cSquareMeterPerSecond, cCubicMeter, cQuarticMeter, cQuinticMeter, -1, -1, cNewtonCubicMeter, -1, cWatt, cWattPerMeter, cJoule, -1, -1),
    (cCubicMeter, -1, -1, -1, -1, -1, -1, cQuarticMeter, cCubicMeter, cQuinticMeter, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cCubicMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, cCubicMeter, cSquareMeter, cCubicMeter, cMeter, cScalar, cReciprocalMeter, -1, -1, -1, cKilogramSquareMeter, cKilogramMeter, cKilogram, cNewtonCubicMeter, cNewtonCubicMeter, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecond, -1, -1, -1, cNewton, cNewtonSquareMeter, -1, cKilogramSquareMeterPerSecond, -1, cKilogramPerMeter, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, -1, cCoulomb, -1, cCubicMeterPerSecond, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, -1, -1, -1, -1, cWatt, cNewtonSquareMeter, cKatal, -1),
    (cSquareMeterPerSecond, cSquareMeter, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cSquareMeterPerSecond, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cGrayPerSecond, cGrayPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, cJoule, cNewtonSquareMeter, -1, cSquareMeterPerSecond, cMeterPerSecond, cSquareMeterPerSecond, cHertz, -1, -1, -1, cNewtonCubicMeter, cMeter, cKilogramMeterPerSecond, cKilogramPerSecond, cPoiseuille, -1, -1, -1, cWattPerMeter, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, cWattPerSquareMeter, cWatt, -1, cNewton, -1, -1, cSexticMeter, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, cOhm, cOhmMeter, cMeterPerSecond, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, cSquareMeterPerSquareSecond, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1),
    (cWatt, cJoule, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cSquareNewton, -1, -1, cWatt, cWattPerMeter, cWatt, cWattPerSquareMeter, cWattPerCubicMeter, -1, -1, cSquareJoule, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, cMeter, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, cWattPerMeter, -1, cKilogramPerSecond, -1, -1, -1, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoule, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, cNewtonSquareMeter, cJoule, cNewtonCubicMeter, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cNewton, cJoule, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, cSquareJouleSquareSecond, -1, cKilogramMeterPerSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, cSquareJoule, cSquareJoule, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, cNewton, -1, cKilogram, -1, -1, -1, -1, cLumenSecond, cJoulePerMole, -1, -1, -1, -1, -1, cWatt, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, cSquareJoule, -1, -1, -1, cSquareNewton, -1, -1),
    (cWattPerMeter, cNewton, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, cWatt, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, cSquareNewton, -1, cWattPerMeter, cWattPerSquareMeter, cWattPerMeter, cWattPerCubicMeter, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, cScalar, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, -1, cWattPerSquareMeter, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerSquareMeter, cNewtonPerMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, cWattPerMeter, cWattPerSquareMeter, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, -1, -1, -1, -1, cWattPerSquareMeter, cWattPerCubicMeter, cWattPerSquareMeter, -1, -1, -1, -1, cSquareNewton, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cKelvinPerMeter, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerCubicMeter, cPascal, cPoiseuille, cKilogramPerMeter, -1, -1, -1, cWattPerSquareMeter, cWattPerCubicMeter, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, cWattPerCubicMeter, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonPerMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, -1, cNewton, cNewtonPerMeter, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, cNewtonPerMeter, cPascal, cNewtonPerMeter, cNewtonPerCubicMeter, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, cCubicMeterPerSquareSecond, cSquareKilogram, -1, -1, cSquareJoule, cMeterPerQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, cPascal, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, cNewton, cJoule, cNewtonSquareMeter, cWatt, -1, cSquareNewton, -1, -1, -1, -1, -1, -1),
    (cKatalPerCubicMeter, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, cKatalPerCubicMeter, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatalPerCubicMeter, -1, cKatalPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCoulombPerMole, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMole, -1, cCoulombPerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1)
  );

  { Div Table }

  DivTable : array[0..159, 0..159] of longint = (
    (cScalar, cHertz, cSquareHertz, -1, -1, -1, -1, cReciprocalMeter, cScalar, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, cReciprocalMole, -1, cSecond, cSquareSecond, cSquareSecond, cSecondPerMeter, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, cScalar, cMeter, cScalar, cSquareMeter, cCubicMeter, cQuarticMeter, -1, -1, cMeterPerSecond, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, cOhm, cOhmMeter, -1, -1, cReciprocalHenry, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareKilogram, cSquareKilogramPerSquareMeter, -1, cKelvin, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, cKelvinPerWatt, cMeterKelvinPerWatt, cWattPerKelvin, cWattPerMeter, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, cNewtonSquareMeterPerSquareCoulomb, cMeterPerAmpere, cAmperePerMeter, -1, -1, -1, cMeter, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, cMole, -1, -1, -1, -1, -1, cSecond, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1),
    (cSecond, cScalar, cHertz, cSquareHertz, -1, -1, -1, cSecondPerMeter, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cCubicSecond, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, -1, -1, -1, cSecond, cMeterSecond, cSecond, -1, -1, cQuarticMeterSecond, -1, -1, cMeter, -1, -1, -1, cMeterPerWatt, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, cFarad, cHenry, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, cCoulombPerMeter, -1, -1, -1, cMeterSecond, -1, cSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cSecondPerMeter, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareSecond, cSecond, cScalar, cHertz, cSquareHertz, -1, -1, -1, cSquareSecond, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, cQuarticSecond, cQuarticSecond, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, cMeterPerWatt, -1, cSquareSecond, -1, cSquareSecond, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCubicSecond, cSquareSecond, cSecond, cScalar, cHertz, cSquareHertz, -1, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticSecond, cQuinticSecond, cQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, cCubicSecond, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuarticSecond, cCubicSecond, cSquareSecond, cSecond, cScalar, cHertz, cSquareHertz, -1, cQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticSecond, cSexticSecond, cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticSecond, -1, cQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuinticSecond, cQuarticSecond, cCubicSecond, cSquareSecond, cSecond, cScalar, cHertz, -1, cQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticSecond, -1, cQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSexticSecond, cQuinticSecond, cQuarticSecond, cCubicSecond, cSquareSecond, cSecond, cScalar, -1, cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSexticSecond, -1, cSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeter, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, cScalar, cMeter, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, -1, cHertz, -1, -1, -1, -1, cMeter, cSquareMeter, cMeter, cCubicMeter, cQuarticMeter, cQuinticMeter, -1, -1, cSquareMeterPerSecond, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, cKilogramPerSquareMeter, cNewtonPerSquareKilogram, cSquareSecondPerSquareMeter, -1, -1, cKilogramSquareSecond, cSquareMeterPerSquareKilogram, -1, cSquareKilogramPerMeter, -1, cMeterKelvin, -1, -1, -1, cReciprocalKelvin, cSquareMeterKelvin, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, cWatt, cWattPerKelvin, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, cSquareMeterPerSquareCoulomb, -1, cSquareCoulombPerMeter, -1, cFarad, -1, -1, -1, -1, cAmpere, -1, -1, -1, cSquareMeter, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, cScalar, cReciprocalMeter, cReciprocalSquareMeter, cSecondPerMeter, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1),
    (cScalar, cHertz, cSquareHertz, -1, -1, -1, -1, cReciprocalMeter, cScalar, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, cReciprocalMole, -1, cSecond, cSquareSecond, cSquareSecond, cSecondPerMeter, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, cScalar, cMeter, cScalar, cSquareMeter, cCubicMeter, cQuarticMeter, -1, -1, cMeterPerSecond, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, cOhm, cOhmMeter, -1, -1, cReciprocalHenry, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareKilogram, cSquareKilogramPerSquareMeter, -1, cKelvin, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, cKelvinPerWatt, cMeterKelvinPerWatt, cWattPerKelvin, cWattPerMeter, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, cNewtonSquareMeterPerSquareCoulomb, cMeterPerAmpere, cAmperePerMeter, -1, -1, -1, cMeter, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, cMole, -1, -1, -1, -1, -1, cSecond, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1),
    (cSquareMeter, cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, cMeter, cSquareMeter, cScalar, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, cSquareMeterPerSquareKilogram, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, cSquareSecond, cMeterPerSecond, -1, -1, -1, -1, cSquareMeter, cCubicMeter, cSquareMeter, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, -1, cCubicMeterPerSecond, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, cSecond, -1, -1, -1, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, cMeter, cScalar, cReciprocalMeter, cSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCubicMeter, cCubicMeterPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, cSquareMeter, cCubicMeter, cMeter, cScalar, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, -1, -1, -1, -1, cCubicMeter, cQuarticMeter, cCubicMeter, cQuinticMeter, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, cMeterSecond, -1, -1, -1, cKilogram, cNewtonSquareMeterPerSquareKilogram, cSquareSecond, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, cQuarticMeter, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, cMeter, cScalar, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuarticMeter, -1, -1, -1, -1, -1, -1, cCubicMeter, cQuarticMeter, cSquareMeter, cMeter, cScalar, cReciprocalMeter, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cCubicMeterPerKilogram, -1, -1, -1, cQuarticMeter, cQuinticMeter, cQuarticMeter, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, cHertz, -1, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, cCubicMeter, cSquareMeter, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuinticMeter, -1, -1, -1, -1, -1, -1, cQuarticMeter, cQuinticMeter, cCubicMeter, cSquareMeter, cMeter, cScalar, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, cSexticMeter, cQuinticMeter, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, cCubicMeter, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSexticMeter, -1, -1, -1, -1, -1, -1, cQuinticMeter, cSexticMeter, cQuarticMeter, cCubicMeter, cSquareMeter, cMeter, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSexticMeter, -1, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, cSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, cQuarticMeter, cCubicMeter, cQuarticMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogram, cKilogramPerSecond, cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, cKilogramPerMeter, cKilogram, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, cReciprocalMeter, cSecond, cSecondPerMeter, -1, cKilogram, cKilogramMeter, cKilogram, cKilogramSquareMeter, -1, -1, cReciprocalSquareMeter, -1, cKilogramMeterPerSecond, cMeter, cSquareMeter, cCubicMeter, -1, -1, -1, -1, cSquareSecondPerSquareMeter, cSquareSecondPerSquareMeter, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, -1, cMeterSecond, -1, cQuarticMeter, cKilogramPerQuarticMeterPerSecond, cQuarticMeterSecond, -1, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramKelvin, cReciprocalKelvin, -1, -1, -1, -1, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, cSquareCoulombPerMeter, cKilogramMeter, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogramPerCubicMeter, -1, -1, cSquareSecondPerSquareMeter, -1, cCubicSecond, -1, cSquareSecond, -1, -1),
    (cSquareKilogram, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, cSquareKilogramPerMeter, cSquareKilogram, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, cKilogram, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, -1, -1, cSquareSecondPerSquareMeter, cSquareKilogram, -1, cSquareKilogram, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, cKilogramMeter, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, cMeter, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1),
    (cAmpere, -1, -1, -1, -1, -1, -1, cAmperePerMeter, cAmpere, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, cCoulomb, -1, -1, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, cAmpere, -1, cAmpere, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, cSiemens, -1, -1, -1, cVolt, cVoltMeter, -1, cReciprocalHenry, -1, cWeber, -1, -1, -1, -1, -1, cCoulombPerMole, -1, -1, cCoulombPerCubicMeter, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, cSquareMeterPerSecond, -1, -1, -1, cSiemensPerMeter, cFaradPerMeter, cVoltMeterPerSecond, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, cReciprocalSquareMeter, -1, -1, cSquareMeter, -1, -1, cCubicMeterPerSecond, -1, cCoulomb, cAmperePerMeter, cAmperePerSquareMeter, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cKatal),
    (cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, cAmpere, cScalar, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, cSquareCoulomb, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, cReciprocalHenry, cSiemens, -1, cSquareHertz, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, cReciprocalHenry, -1, -1, -1, -1, -1, -1),
    (cKelvin, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, cMeterKelvin, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKelvin, -1, -1, -1, cReciprocalMeter, cMeter, cMeterKelvinPerWatt, -1, -1, -1, -1, cWatt, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, cReciprocalMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, cMoleKelvin, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, cKelvinPerWatt, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1),
    (cSquareKelvin, -1, -1, -1, -1, -1, -1, -1, cSquareKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, cScalar, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKelvin, -1, cSquareKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicKelvin, -1, -1, -1, cKelvinPerMeter, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCubicKelvin, -1, -1, -1, -1, -1, -1, -1, cCubicKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKelvin, cKelvin, cScalar, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicKelvin, -1, cCubicKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicKelvin, cSquareKelvin, cKelvin, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, cQuarticKelvin, cSquareMeterQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMole, cKatal, -1, -1, -1, -1, -1, -1, cMole, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, -1, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMoleKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCandela, -1, -1, -1, -1, -1, -1, -1, cCandela, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cHertz, cCubicMeterPerSecond, cSquareMeter, cSquareMeterPerSecond, -1, -1, -1, cLumenSecondPerCubicMeter, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, cSquareMeter, -1, -1, cLumenSecond, -1, cLux, -1, cLuxSecond, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1),
    (cHertz, cSquareHertz, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cSecond, cSecond, cReciprocalMeter, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, cMeterPerSecond, cHertz, cSquareMeterPerSecond, cCubicMeterPerSecond, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, cNewtonSquareMeterPerSquareCoulomb, cCoulombPerKilogram, -1, -1, cOhm, -1, -1, -1, -1, -1, cReciprocalMole, -1, -1, cReciprocalCubicMeter, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, cGrayPerSecond, -1, -1, cTesla, -1, -1, cKatal, -1, -1, -1, -1, cSquareSecondPerSquareMeter, cScalar, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareHertz, -1, -1, -1, -1, -1, -1, -1, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, cScalar, cScalar, -1, cReciprocalMeter, cSecondPerMeter, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, cSquareHertz, cMeterPerSquareSecond, cSquareHertz, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, cMeterPerCubicSecond, cNewtonPerSquareKilogram, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, cKilogramPerMeter, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareHertz, -1, -1, -1, -1, -1, -1, -1, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, cScalar, cScalar, -1, cReciprocalMeter, cSecondPerMeter, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, cSquareHertz, cMeterPerSquareSecond, cSquareHertz, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, cMeterPerCubicSecond, cNewtonPerSquareKilogram, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, cKilogramPerMeter, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, cHertz, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, cMeterSecond, cMeterSecond, cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSecondPerMeter, cSquareHertz, -1, -1, -1, -1, cMeterPerSecond, cSquareMeterPerSecond, cMeterPerSecond, cCubicMeterPerSecond, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, cSquareMeterPerSecond, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, cHertz, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, -1, cSquareHertz, cMeterPerSquareSecond, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, cMeter, cMeter, cHertz, cScalar, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cReciprocalMeter, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, cMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, cGrayPerSecond, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, cReciprocalSquareMeter, -1, -1, cKilogram, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, cKelvinPerMeter, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, cMeterPerSecond, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, -1, -1, -1, cMeterPerCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cMeterPerSecond, cMeterPerSecond, cSquareHertz, cHertz, cScalar, cSecond, cSquareSecond, cCubicSecond, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, cMeterPerCubicSecond, cGrayPerSecond, cMeterPerCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, -1, -1, -1, -1, cMeterPerQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cMeterPerSquareSecond, cMeterPerSquareSecond, -1, cSquareHertz, cHertz, cScalar, cSecond, cSquareSecond, -1, -1, -1, -1, -1, -1, cMeterPerQuarticSecond, -1, cMeterPerQuarticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1),
    (cMeterPerQuinticSecond, cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuarticSecond, cMeterPerCubicSecond, cMeterPerCubicSecond, -1, -1, cSquareHertz, cHertz, cScalar, cSecond, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuarticSecond, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1),
    (cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, cMeterPerQuarticSecond, cMeterPerQuarticSecond, -1, -1, -1, cSquareHertz, cHertz, cScalar, -1, -1, -1, -1, -1, -1, cMeterPerSexticSecond, -1, cMeterPerSexticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, cSquareMeterPerSecond, cSquareMeter, cSquareMeter, cMeterPerSecond, cMeter, cMeterSecond, -1, -1, -1, cScalar, cMeterPerCubicSecond, cNewtonPerSquareKilogram, -1, -1, -1, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, cPascal, -1, cReciprocalMeter, -1, -1, cKilogramMeter, -1, -1, cSquareKilogramPerSquareSecond, cKilogramPerMeter, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, cSquareMeterPerSquareKilogram, -1, -1, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, cSecond, cSquareMeterPerSecond, cMeterPerSquareSecond, cSquareHertz, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterSecond, cMeter, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cSecond, cMeterSecond, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, -1, -1, cScalar, -1, -1, -1, -1, cMeterSecond, -1, cMeterSecond, -1, cQuarticMeterSecond, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, cMeterPerWatt, -1, cMeterPerAmpere, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, cSecondPerMeter, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1),
    (cKilogramMeter, cKilogramMeterPerSecond, cNewton, cWattPerMeter, -1, -1, -1, cKilogram, cKilogramMeter, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, cKilogramPerSecond, cScalar, cMeterSecond, cSecond, -1, cKilogramMeter, cKilogramSquareMeter, cKilogramMeter, -1, -1, -1, cReciprocalMeter, cSecondPerMeter, cKilogramSquareMeterPerSecond, cSquareMeter, cCubicMeter, cQuarticMeter, cSquareSecond, cSquareSecond, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, -1, -1, cSquareKilogramPerSquareMeter, cMeterPerSquareSecond, -1, cSquareSecondPerSquareMeter, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, cKilogramSquareMeter, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, cKilogramPerMeter, cKilogramPerSquareMeter, -1, -1, -1, cCubicSecond, -1, -1, -1, -1, -1),
    (cKilogramPerSecond, cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, -1, cPoiseuille, cKilogramPerSecond, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, -1, -1, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, cPascal, -1, cScalar, cReciprocalMeter, -1, cKilogramPerSecond, cKilogramMeterPerSecond, cKilogramPerSecond, cKilogramSquareMeterPerSecond, -1, -1, -1, cReciprocalSquareMeter, cNewton, cMeterPerSecond, cSquareMeterPerSecond, cCubicMeterPerSecond, cSecondPerMeter, cSecondPerMeter, -1, cMeterSecond, -1, -1, cSquareSecondPerSquareMeter, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, cKilogramPerCubicMeter, cMeter, cKilogramPerSquareMeter, -1, -1, cQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, -1, cKilogramMeterPerSecond, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, cPoiseuille, -1, -1, cKilogramPerSquareMeter, cSquareSecondPerSquareMeter, -1, -1, cSquareSecond, -1, cSecond, -1, -1),
    (cKilogramMeterPerSecond, cNewton, cWattPerMeter, -1, -1, -1, -1, cKilogramPerSecond, cKilogramMeterPerSecond, cPoiseuille, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, -1, -1, cKilogram, -1, cKilogramSquareSecond, -1, -1, -1, -1, cNewtonPerMeter, cHertz, cMeter, cScalar, -1, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, cKilogramMeterPerSecond, -1, -1, -1, -1, cReciprocalMeter, cJoule, cSquareMeterPerSecond, cCubicMeterPerSecond, -1, cSecond, cSecond, cMeterPerWatt, -1, cSecondPerMeter, cSecondPerMeter, -1, cTeslaMeter, -1, cTesla, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, cCoulombMeter, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, cKilogramPerSquareMeter, cSquareMeter, cKilogramPerMeter, -1, -1, cQuinticMeter, -1, cMeterPerCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, cOhm, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, -1, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cKilogramPerSecond, cPoiseuille, -1, cKilogramPerMeter, -1, cSecondPerMeter, cSquareSecond, -1, -1, cMeterSecond, -1, -1),
    (cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareNewton, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, cJoule, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, cNewton, cKilogramSquareMeterPerSecond, cKilogramMeterPerSecond, cScalar, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareKilogramSquareMeterPerSquareSecond, cSquareJouleSquareSecond, -1, -1, cNewtonPerMeter, cKilogramPerSecond, -1, cNewtonSquareMeter, cNewtonCubicMeter, -1, cKilogramMeter, cKilogramMeter, cSquareSecond, -1, cKilogram, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, cKilogramPerMeter, cKilogramPerSquareMeter, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, cJoulePerKelvin, cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, cSquareJoule, cSquareSecondPerSquareMeter, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, cKilogram, -1, -1, -1, cKilogramSquareMeter, -1, -1),
    (cScalar, cHertz, cSquareHertz, -1, -1, -1, -1, cReciprocalMeter, cScalar, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, cReciprocalMole, -1, cSecond, cSquareSecond, cSquareSecond, cSecondPerMeter, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, cScalar, cMeter, cScalar, cSquareMeter, cCubicMeter, cQuarticMeter, -1, -1, cMeterPerSecond, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, cOhm, cOhmMeter, -1, -1, cReciprocalHenry, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareKilogram, cSquareKilogramPerSquareMeter, -1, cKelvin, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, cKelvinPerWatt, cMeterKelvinPerWatt, cWattPerKelvin, cWattPerMeter, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, cNewtonSquareMeterPerSquareCoulomb, cMeterPerAmpere, cAmperePerMeter, -1, -1, -1, cMeter, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, cMole, -1, -1, -1, -1, -1, cSecond, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1),
    (cReciprocalMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cReciprocalMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cScalar, cReciprocalMeter, cMeter, cSquareMeter, cCubicMeter, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, cSiemensPerMeter, -1, cOhm, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, -1, cReciprocalKelvin, -1, cMeterPerWatt, -1, -1, cKelvinPerWatt, cWattPerMeterPerKelvin, cWattPerSquareMeter, cWattPerSquareMeterPerKelvin, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, cReciprocalHenry, cScalar, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, cSecondPerMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1),
    (cScalar, cHertz, cSquareHertz, -1, -1, -1, -1, cReciprocalMeter, cScalar, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, cReciprocalMole, -1, cSecond, cSquareSecond, cSquareSecond, cSecondPerMeter, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, cScalar, cMeter, cScalar, cSquareMeter, cCubicMeter, cQuarticMeter, -1, -1, cMeterPerSecond, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, cOhm, cOhmMeter, -1, -1, cReciprocalHenry, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareKilogram, cSquareKilogramPerSquareMeter, -1, cKelvin, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, cKelvinPerWatt, cMeterKelvinPerWatt, cWattPerKelvin, cWattPerMeter, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, cNewtonSquareMeterPerSquareCoulomb, cMeterPerAmpere, cAmperePerMeter, -1, -1, -1, cMeter, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, cMole, -1, -1, -1, -1, -1, cSecond, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1),
    (cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, cReciprocalSquareMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cReciprocalMeter, cReciprocalSquareMeter, cScalar, cMeter, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, cWattPerSquareMeterPerKelvin, cWattPerCubicMeter, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, -1, cReciprocalHenry, -1, cReciprocalMeter, -1, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1),
    (cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, cReciprocalQuarticMeter, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalMeter, cScalar, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, cReciprocalMole, -1, -1, -1, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalQuarticMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, cReciprocalSquareMeter, cReciprocalMeter, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramSquareMeter, cKilogramSquareMeterPerSecond, cJoule, cWatt, -1, -1, -1, cKilogramMeter, cKilogramSquareMeter, cKilogram, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, cKilogramMeterPerSecond, cMeter, -1, cMeterSecond, -1, cKilogramSquareMeter, -1, cKilogramSquareMeter, -1, -1, -1, cScalar, cSecond, -1, cCubicMeter, cQuarticMeter, cQuinticMeter, -1, -1, -1, -1, cSquareSecond, cSquareSecond, cCubicSecond, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSexticMeter, -1, -1, cSquareKilogramPerMeter, cSquareMeterPerSquareSecond, -1, -1, cSquareSecondPerSquareMeter, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cKilogram, cKilogramPerMeter, -1, cCubicSecond, cSquareSecond, -1, -1, -1, -1, -1, -1),
    (cKilogramSquareMeterPerSecond, cJoule, cWatt, -1, -1, -1, -1, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, cKilogramPerSecond, cPoiseuille, -1, -1, cKilogramPerQuarticMeterPerSecond, cSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, cKilogramMeter, -1, -1, -1, -1, -1, -1, cNewton, cMeterPerSecond, cSquareMeter, cMeter, -1, cKilogramSquareMeterPerSecond, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, cHertz, cScalar, cNewtonSquareMeter, cCubicMeterPerSecond, -1, -1, cMeterSecond, cMeterSecond, -1, -1, cSecond, cSecond, cSquareSecond, cWeber, cOhm, cTeslaMeter, -1, -1, -1, cSquareCoulomb, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, cKilogramPerMeter, cCubicMeter, cKilogram, -1, cNewtonPerCubicMeter, cSexticMeter, -1, cGrayPerSecond, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, cKilogramSquareMeter, cKilogramMeterPerSecond, cKilogramPerSecond, cPoiseuille, cKilogram, cSquareSecond, cSecond, -1, -1, -1, -1, -1, -1),
    (cSecondPerMeter, cReciprocalMeter, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, cSecondPerMeter, cSecond, cSecondPerMeter, cMeterSecond, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, cHenryPerMeter, cHenry, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, cOhm, -1, cCoulombPerSquareMeter, -1, -1, cSiemens, cSecond, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1),
    (cKilogramPerMeter, cPoiseuille, cPascal, cWattPerCubicMeter, -1, -1, -1, cKilogramPerSquareMeter, cKilogramPerMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cSecondPerMeter, -1, -1, cKilogramPerMeter, cKilogram, cKilogramPerMeter, cKilogramMeter, cKilogramSquareMeter, -1, cReciprocalCubicMeter, -1, cKilogramPerSecond, cScalar, cMeter, cSquareMeter, cSquareSecondPerSquareMeter, cSquareSecondPerSquareMeter, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, cKilogram, -1, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, cCubicSecond, -1, -1, -1),
    (cKilogramPerSquareMeter, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, cKilogramPerCubicMeter, cKilogramPerSquareMeter, cKilogramPerQuarticMeter, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, cKilogramPerSquareMeter, cKilogramPerMeter, cKilogramPerSquareMeter, cKilogram, cKilogramMeter, cKilogramSquareMeter, cReciprocalQuarticMeter, -1, cPoiseuille, cReciprocalMeter, cScalar, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cSquareSecondPerSquareMeter, -1, cSecondPerMeter, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1),
    (cKilogramPerCubicMeter, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, cReciprocalQuarticMeter, -1, -1, -1, cKilogramPerCubicMeter, cKilogramPerSquareMeter, cKilogramPerCubicMeter, cKilogramPerMeter, cKilogram, cKilogramMeter, -1, -1, -1, cReciprocalSquareMeter, cReciprocalMeter, cScalar, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewton, cWattPerMeter, -1, -1, -1, -1, -1, cNewtonPerMeter, cNewton, cPascal, cNewtonPerCubicMeter, -1, -1, -1, cMeterPerSquareSecond, cNewtonPerSquareKilogram, cTeslaMeter, cHenryPerMeter, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, cKilogramMeter, cKilogramMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, -1, cKilogramPerMeter, cWattPerSquareMeter, cSquareHertz, cMeterPerSecond, cHertz, -1, cNewton, cJoule, cNewton, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, cWatt, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, cScalar, cScalar, -1, cSquareMeter, cReciprocalMeter, cReciprocalMeter, cSecondPerMeter, cVoltPerMeter, cNewtonPerSquareCoulomb, -1, cCoulombPerMeter, cFaradPerMeter, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, cMeter, -1, cSquareMeterPerSecond, cPoiseuille, -1, -1, -1, -1, cMeterPerQuarticSecond, cKilogramPerSquareMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cSquareKilogram, -1, cNewtonSquareMeterPerSquareKilogram, -1, cSquareKilogramPerSquareMeter, -1, -1, cKelvinPerMeter, -1, -1, cJoulePerKelvin, cSecond, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, cVolt, -1, cVoltMeter, -1, cSquareCoulomb, -1, cCoulombPerSquareMeter, -1, cSquareVolt, cWeber, -1, cAmpere, -1, cSquareAmpere, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, cPoiseuille, cSecondPerMeter, cReciprocalMeter, cSecond, cMeterSecond, -1, cMeter, -1, -1),
    (cNewton, cWattPerMeter, -1, -1, -1, -1, -1, cNewtonPerMeter, cNewton, cPascal, cNewtonPerCubicMeter, -1, -1, -1, cMeterPerSquareSecond, cNewtonPerSquareKilogram, cTeslaMeter, cHenryPerMeter, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, cKilogramMeter, cKilogramMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, -1, cKilogramPerMeter, cWattPerSquareMeter, cSquareHertz, cMeterPerSecond, cHertz, -1, cNewton, cJoule, cNewton, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, -1, cWatt, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, -1, cScalar, cScalar, -1, cSquareMeter, cReciprocalMeter, cReciprocalMeter, cSecondPerMeter, cVoltPerMeter, cNewtonPerSquareCoulomb, -1, cCoulombPerMeter, cFaradPerMeter, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, cMeter, -1, cSquareMeterPerSecond, cPoiseuille, -1, -1, -1, -1, cMeterPerQuarticSecond, cKilogramPerSquareMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cSquareKilogram, -1, cNewtonSquareMeterPerSquareKilogram, -1, cSquareKilogramPerSquareMeter, -1, -1, cKelvinPerMeter, -1, -1, cJoulePerKelvin, cSecond, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, cVolt, -1, cVoltMeter, -1, cSquareCoulomb, -1, cCoulombPerSquareMeter, -1, cSquareVolt, cWeber, -1, cAmpere, -1, cSquareAmpere, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, cPoiseuille, cSecondPerMeter, cReciprocalMeter, cSecond, cMeterSecond, -1, cMeter, -1, -1),
    (cSquareNewton, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, cWatt, cWattPerMeter, cSquareHertz, cSquareNewton, -1, cSquareNewton, cSquareJoule, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, cNewton, cNewton, cScalar, cNewtonSquareMeter, cNewtonPerMeter, cNewtonPerMeter, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, cNewtonPerMeter, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, cJoule, -1, -1),
    (cPascal, cWattPerCubicMeter, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, cKilogramPerMeter, cKilogramPerMeter, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, -1, cPascal, cNewtonPerMeter, cPascal, cNewton, cJoule, cNewtonSquareMeter, -1, -1, cWattPerSquareMeter, cSquareHertz, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, cReciprocalSquareMeter, cReciprocalSquareMeter, -1, cScalar, cReciprocalCubicMeter, cReciprocalCubicMeter, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, cReciprocalMeter, cKilogramPerQuarticMeterPerSecond, cHertz, -1, cCubicMeterPerSquareSecond, -1, cCubicMeterPerSecond, -1, -1, cKilogramPerQuarticMeter, cReciprocalQuarticMeter, -1, cSquareKilogramPerSquareMeter, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, cTesla, -1, cAmperePerSquareMeter, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, cJoulePerMole, -1, cVolt, -1, cPoiseuille, cNewtonPerCubicMeter, -1, -1, -1, -1, cReciprocalCubicMeter, -1, cSecondPerMeter, cSecond, cReciprocalMeter, -1, -1),
    (cJoule, cWatt, -1, -1, -1, -1, -1, cNewton, cJoule, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, -1, -1, cSquareMeterPerSquareSecond, -1, cWeber, cHenry, cJoulePerKelvin, -1, -1, -1, cJoulePerMole, -1, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, cKilogramSquareMeter, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, -1, cKilogram, cWattPerMeter, cMeterPerSquareSecond, cSquareMeterPerSecond, cMeterPerSecond, -1, cJoule, cNewtonSquareMeter, cJoule, cNewtonCubicMeter, -1, -1, cSquareHertz, cHertz, -1, cCubicMeterPerSquareSecond, -1, -1, cMeter, cMeter, -1, cCubicMeter, cScalar, cScalar, cSecond, cVolt, -1, cVoltPerMeter, cCoulomb, cFarad, cSquareVolt, -1, -1, -1, cSquareMeterAmpere, cAmpere, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, cSquareMeter, cPoiseuille, cCubicMeterPerSecond, cKilogramPerSecond, -1, -1, -1, -1, -1, cKilogramPerMeter, cReciprocalMeter, cReciprocalSquareMeter, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, cSquareKilogramPerMeter, -1, cJoulePerKilogramPerKelvin, cKelvin, cKilogramKelvin, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, cJoulePerMolePerKelvin, cMoleKelvin, -1, cCoulombMeter, cVoltMeter, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, cSquareCoulombPerMeter, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cNewton, cNewtonPerMeter, cPascal, cKilogramPerSecond, cSecond, cScalar, cMeterSecond, -1, -1, cSquareMeter, -1, -1),
    (cJoule, cWatt, -1, -1, -1, -1, -1, cNewton, cJoule, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, -1, -1, cSquareMeterPerSquareSecond, -1, cWeber, cHenry, cJoulePerKelvin, -1, -1, -1, cJoulePerMole, -1, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, cKilogramSquareMeter, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, -1, cKilogram, cWattPerMeter, cMeterPerSquareSecond, cSquareMeterPerSecond, cMeterPerSecond, -1, cJoule, cNewtonSquareMeter, cJoule, cNewtonCubicMeter, -1, -1, cSquareHertz, cHertz, -1, cCubicMeterPerSquareSecond, -1, -1, cMeter, cMeter, -1, cCubicMeter, cScalar, cScalar, cSecond, cVolt, -1, cVoltPerMeter, cCoulomb, cFarad, cSquareVolt, -1, -1, -1, cSquareMeterAmpere, cAmpere, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, cSquareMeter, cPoiseuille, cCubicMeterPerSecond, cKilogramPerSecond, -1, -1, -1, -1, -1, cKilogramPerMeter, cReciprocalMeter, cReciprocalSquareMeter, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, cSquareKilogramPerMeter, -1, cJoulePerKilogramPerKelvin, cKelvin, cKilogramKelvin, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, cJoulePerMolePerKelvin, cMoleKelvin, -1, cCoulombMeter, cVoltMeter, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, cSquareCoulombPerMeter, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cNewton, cNewtonPerMeter, cPascal, cKilogramPerSecond, cSecond, cScalar, cMeterSecond, -1, -1, cSquareMeter, -1, -1),
    (cWatt, -1, -1, -1, -1, -1, -1, cWattPerMeter, cWatt, cWattPerSquareMeter, cWattPerCubicMeter, -1, -1, -1, cGrayPerSecond, -1, cVolt, cOhm, cWattPerKelvin, -1, -1, cWattPerQuarticKelvin, -1, -1, cJoule, cKilogramSquareMeterPerSecond, cKilogramSquareMeterPerSecond, cNewton, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, cKilogramPerSecond, -1, cMeterPerCubicSecond, cSquareMeterPerSquareSecond, cMeterPerSquareSecond, -1, cWatt, -1, cWatt, -1, -1, -1, -1, cSquareHertz, -1, -1, -1, -1, cMeterPerSecond, cMeterPerSecond, -1, cCubicMeterPerSecond, cHertz, cHertz, cScalar, -1, -1, -1, cAmpere, cSiemens, -1, cSquareAmpere, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, cSquareMeterPerSecond, cPascal, cCubicMeterPerSquareSecond, cNewtonPerMeter, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, cMeter, cSquareMeter, cCubicMeter, cKelvin, cMeterKelvin, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, cKatal, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, cAmperePerMeter, cCoulombPerMeter, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, cJoule, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, cNewtonPerMeter, cScalar, cHertz, cMeter, cSquareMeter, cCubicMeter, cSquareMeterPerSecond, -1, -1),
    (cCoulomb, cAmpere, -1, -1, -1, -1, -1, cCoulombPerMeter, cCoulomb, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, cCoulombPerKilogram, -1, cSecond, -1, -1, -1, -1, -1, cCoulombPerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, cCoulomb, cCoulombMeter, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, cReciprocalMeter, cFarad, -1, cVolt, -1, cWeber, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, cSquareMeter, -1, -1, -1, cFaradPerMeter, -1, cVoltMeter, cMeterSecond, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, cKilogram, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, cCoulombPerMeter, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMole),
    (cSquareCoulomb, -1, cSquareAmpere, -1, -1, -1, -1, cSquareCoulombPerMeter, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, cSquareCoulomb, -1, -1, -1, cReciprocalHenry, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, cFarad, -1, cCoulomb, cScalar, cCoulombPerMeter, -1, -1, cJoule, -1, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, cMeter, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1),
    (cCoulombMeter, -1, -1, -1, -1, -1, -1, cCoulomb, cCoulombMeter, cCoulombPerMeter, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, cCoulombPerKilogram, -1, -1, -1, cCoulombMeter, -1, cCoulombMeter, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, cScalar, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, cCubicMeter, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cSecondPerMeter, -1, -1, -1, -1, -1, cQuarticMeter, -1, -1, cCoulomb, cCoulombPerMeter, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cVolt, -1, -1, -1, -1, -1, -1, cVoltPerMeter, cVolt, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, cVoltMeter, cVolt, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, cScalar, -1, -1, cAmpere, -1, -1, cSquareMeterPerSecond, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, cMeter, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, cCoulombMeter, cCoulombPerMeter, cReciprocalMeter, cSecondPerMeter, -1, cOhmMeter, cWattPerMeter, cMeterPerSecond, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, cVoltPerMeter, -1, -1, cTesla, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1),
    (cSquareVolt, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, cNewtonSquareMeterPerSquareCoulomb, cSquareMeterPerSquareCoulomb, -1, -1, -1, cOhm, -1, -1, -1, cVolt, cScalar, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, cVoltMeter, -1, -1, -1, cSquareNewton, cNewtonSquareMeter, cNewton, cVoltPerMeter, cTeslaMeter, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, cOhmMeter, -1, -1, -1, -1, -1),
    (cFarad, cSiemens, cReciprocalHenry, -1, -1, -1, -1, cFaradPerMeter, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, cFarad, -1, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, cSecond, cMeterSecond, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cOhm, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, cSquareMeterPerSquareCoulomb, -1, -1, cOhm, cOhmMeter, cOhm, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cMeterPerAmpere, -1, -1, -1, cKilogramPerSecond, cMeterSecond, cSecondPerMeter, -1, -1, -1, -1, cVoltPerMeter, -1, cSquareMeterPerSecond, cMeterPerSecond, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSiemens, cReciprocalHenry, -1, -1, -1, -1, -1, cSiemensPerMeter, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, cScalar, cMeter, -1, -1, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, cSiemens, cSiemensPerMeter, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cScalar, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cTesla, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, cTeslaMeter, cTesla, cWeber, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, cScalar, cReciprocalSquareMeter, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, cSecondPerMeter, -1, -1, cOhm, -1, -1, -1, -1, -1, -1, cHenryPerMeter, cPascal, cReciprocalMeter, cAmpere, cAmperePerMeter, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWeber, cVolt, -1, -1, -1, -1, -1, cTeslaMeter, cWeber, cTesla, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, cWeber, -1, cWeber, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, cMeterPerAmpere, cMeterPerAmpere, -1, -1, -1, -1, -1, cOhm, -1, -1, cSecond, -1, -1, cCoulomb, -1, -1, cSquareMeter, cScalar, cAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, cMeterSecond, cOhmMeter, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, cNewton, cMeter, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cHenry, cOhm, -1, -1, -1, -1, -1, cHenryPerMeter, cHenry, cTeslaPerAmpere, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, cHenry, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, cKilogram, -1, -1, -1, -1, -1, -1, cTeslaMeter, cMeterPerAmpere, cSquareMeter, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, cFarad, cFarad, cSiemensPerMeter, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, cReciprocalHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareHertz, -1, cHertz, cMeterPerSecond, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCandela, -1, -1, -1, -1, -1, -1, -1, cCandela, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCandela, -1, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cHertz, cCubicMeterPerSecond, cSquareMeter, cSquareMeterPerSecond, -1, -1, -1, cLumenSecondPerCubicMeter, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, cSquareMeter, -1, -1, cLumenSecond, -1, cLux, -1, cLuxSecond, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1),
    (cLumenSecond, cCandela, -1, -1, -1, -1, -1, -1, cLumenSecond, cLuxSecond, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecond, -1, cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, cScalar, cCubicMeter, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, cLuxSecond, cLumenSecondPerCubicMeter, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1),
    (cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, cLuxSecond, cLumenSecondPerCubicMeter, -1, cLumenSecond, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, cScalar, cSecondPerMeter, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, cPascal, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cLux, -1, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cLuxSecond, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLux, -1, cLux, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cMeterPerSecond, cScalar, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, cScalar, -1, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1),
    (cLuxSecond, cLux, -1, -1, -1, -1, -1, cLumenSecondPerCubicMeter, cLuxSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLuxSecond, -1, cLuxSecond, cLumenSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cMeter, cSecond, cScalar, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, cSecond, -1, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1),
    (cKatal, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, cKatalPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatal, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, cMole, -1, -1, cKatalPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1),
    (cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, cKilogramPerSquareMeter, -1, cKilogramPerCubicMeter, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, cPascal, cNewtonPerCubicMeter, cNewtonPerMeter, cNewton, cJoule, -1, -1, cWattPerCubicMeter, -1, cSquareHertz, cMeterPerSquareSecond, cReciprocalCubicMeter, cReciprocalCubicMeter, -1, cReciprocalMeter, cReciprocalQuarticMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cReciprocalSquareMeter, -1, -1, cKilogramPerQuarticMeterPerSecond, cSquareMeterPerSquareSecond, -1, cSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, cReciprocalQuarticMeter, -1, -1, cSecondPerMeter, cReciprocalSquareMeter, -1, -1),
    (cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, -1, -1, cPascal, cNewtonPerMeter, cNewtonPerCubicMeter, -1, -1, -1, -1, cSquareHertz, -1, cTesla, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, cKilogram, cKilogram, cPoiseuille, cKilogramPerMeter, -1, -1, -1, -1, cKilogramPerSquareMeter, cWattPerCubicMeter, -1, cHertz, -1, -1, cNewtonPerMeter, cNewton, cNewtonPerMeter, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, cWattPerMeter, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, cReciprocalMeter, cReciprocalMeter, -1, cMeter, cReciprocalSquareMeter, cReciprocalSquareMeter, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, cAmpere, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, cScalar, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, cSquareKilogramPerMeter, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, cSecond, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, cVoltPerMeter, cNewtonPerSquareCoulomb, cVolt, -1, cSquareCoulombPerMeter, -1, cCoulombPerCubicMeter, -1, -1, cTeslaMeter, -1, cAmperePerMeter, cSquareAmpere, -1, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, cVoltMeter, -1, cKilogramPerSecond, cPascal, cNewtonPerCubicMeter, -1, -1, -1, cReciprocalSquareMeter, cSecondPerMeter, cSecond, cMeterSecond, cScalar, -1, -1),
    (cCubicMeterPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, cSquareMeterPerSecond, cCubicMeterPerSecond, cMeterPerSecond, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, cMeterSecond, cSquareMeterPerSquareSecond, -1, cCubicMeterPerKilogram, -1, -1, cCubicMeterPerSecond, -1, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, cMeter, -1, -1, -1, cKilogramPerSecond, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, cSquareMeterPerSecond, cMeterPerSecond, cHertz, cMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cPoiseuille, cPascal, cWattPerCubicMeter, -1, -1, -1, -1, -1, cPoiseuille, -1, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, cNewtonPerCubicMeter, -1, cReciprocalMeter, cReciprocalSquareMeter, -1, cPoiseuille, cKilogramPerSecond, cPoiseuille, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, -1, cReciprocalCubicMeter, cNewtonPerMeter, cHertz, cMeterPerSecond, cSquareMeterPerSecond, -1, -1, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, cSecondPerMeter, cKilogramPerQuarticMeter, cScalar, cKilogramPerCubicMeter, cCubicMeterPerSecond, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, cKilogramPerSecond, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, cKilogramPerMeter, -1, -1, cKilogramPerQuarticMeterPerSecond, cKilogramPerCubicMeter, -1, -1, cSquareSecondPerSquareMeter, -1, cSquareSecond, cSecondPerMeter, -1, -1),
    (cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, -1, cMeterPerSecond, cSquareMeterPerSecond, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, -1, cMeter, cMeterSecond, -1, -1, -1, -1, cSecond, cMeterPerSquareSecond, -1, -1, -1, -1, cSquareMeterPerSecond, cCubicMeterPerSecond, cSquareMeterPerSecond, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cCubicMeterPerKilogram, cScalar, -1, -1, -1, cPoiseuille, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cSquareMeter, cMeterPerSecond, cHertz, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramPerQuarticMeter, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, cKilogramPerSquareMeter, cKilogramPerMeter, cKilogram, -1, -1, -1, cReciprocalCubicMeter, cReciprocalSquareMeter, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, cScalar, -1, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cQuarticMeterSecond, cQuarticMeter, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, cMeterSecond, cSecond, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, cQuarticMeterSecond, -1, cQuarticMeterSecond, -1, -1, -1, -1, -1, cQuinticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalQuarticMeter, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, cKilogramPerQuarticMeterPerSecond, -1, cPoiseuille, cKilogramPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, cHertz, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCubicMeterPerKilogram, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareKilogram, -1, -1, -1, cCubicMeterPerKilogram, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramSquareSecond, -1, cKilogram, cKilogramPerSecond, cNewtonPerMeter, cWattPerSquareMeter, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, -1, cKilogramSquareSecond, -1, cKilogramSquareSecond, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticSecond, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticSecond, -1, cQuarticSecond, -1, -1),
    (cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, cMeterPerSquareSecond, cSquareHertz, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cCubicMeter, cCubicMeter, cSquareMeterPerSecond, cSquareMeter, -1, -1, -1, -1, cMeter, cGrayPerSecond, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, cCubicMeterPerSquareSecond, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, cHertz, -1, cMeterPerSecond, -1, -1, -1, cNewtonPerMeter, -1, cScalar, -1, -1, cKilogramSquareMeter, -1, -1, -1, cKilogram, -1, -1, -1, cMeterKelvin, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, cCubicMeterPerSecond, cSquareMeterPerSquareSecond, cMeterPerSquareSecond, cSquareHertz, cMeterPerSecond, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1),
    (cNewtonSquareMeter, -1, -1, -1, -1, -1, -1, cJoule, cNewtonSquareMeter, cNewton, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, -1, cCubicMeterPerSquareSecond, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, -1, -1, -1, -1, cKilogramMeter, cWatt, cSquareMeterPerSquareSecond, cCubicMeterPerSecond, cSquareMeterPerSecond, -1, cNewtonSquareMeter, cNewtonCubicMeter, cNewtonSquareMeter, -1, -1, -1, cMeterPerSquareSecond, cMeterPerSecond, -1, -1, -1, -1, cSquareMeter, cSquareMeter, -1, cQuarticMeter, cMeter, cMeter, cMeterSecond, cVoltMeter, cNewtonSquareMeterPerSquareCoulomb, cVolt, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuinticMeter, cCubicMeter, cKilogramPerSecond, -1, cKilogramMeterPerSecond, -1, cWattPerCubicMeter, -1, cSquareKilogramPerSquareSecond, -1, cKilogram, cScalar, cReciprocalMeter, -1, -1, -1, -1, cSquareKilogram, -1, -1, cMeterKelvin, -1, cJoulePerKelvin, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, cCoulomb, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, cNewtonCubicMeter, cCubicMeterPerKilogram, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, cNewton, cNewtonPerMeter, cKilogramMeterPerSecond, cMeterSecond, cMeter, -1, -1, cQuarticMeterSecond, cCubicMeter, -1, -1),
    (cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, cNewtonCubicMeter, cJoule, cNewton, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, -1, cCubicMeterPerSquareSecond, -1, cCubicMeterPerSecond, -1, cNewtonCubicMeter, -1, cNewtonCubicMeter, -1, -1, -1, cSquareMeterPerSquareSecond, cSquareMeterPerSecond, -1, -1, -1, -1, cCubicMeter, cCubicMeter, -1, cQuinticMeter, cSquareMeter, cSquareMeter, -1, -1, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cSexticMeter, cQuarticMeter, cKilogramMeterPerSecond, -1, cKilogramSquareMeterPerSecond, -1, cWattPerSquareMeter, -1, -1, -1, cKilogramMeter, cMeter, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, cJoule, cNewton, cKilogramSquareMeterPerSecond, -1, cSquareMeter, -1, cQuarticMeterSecond, -1, cQuarticMeter, -1, -1),
    (cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, cNewtonPerSquareKilogram, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, cPascal, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareKilogramPerMeter, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, cSquareKilogramPerMeter, -1, -1, -1, -1, -1, cKilogramPerMeter, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, cSquareKilogramPerMeter, cSquareKilogram, cSquareKilogramPerMeter, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, cKilogram, cKilogramMeter, cKilogramSquareMeter, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, -1, -1, -1, -1, cScalar, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, cSquareKilogramPerSquareMeter, cSquareKilogramPerMeter, cSquareKilogramPerSquareMeter, cSquareKilogram, -1, -1, cKilogramPerQuarticMeter, -1, -1, cKilogramPerMeter, cKilogram, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, cNewtonPerCubicMeter, -1, -1, -1, -1, cReciprocalMeter, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerMeter, cSquareSecondPerSquareMeter, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareKilogram, -1, cSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareKilogram, cSquareMeterPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareHertz, -1, -1, -1, -1, cSquareMeter, -1, -1, cNewton, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, cReciprocalKelvin, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, cWattPerMeterPerKelvin, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cKilogramKelvin, -1, -1, -1, -1, -1, -1, -1, cKilogramKelvin, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, cKilogramKelvin, -1, cKilogramKelvin, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, cKilogramPerMeter, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoulePerKelvin, cWattPerKelvin, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, cJoulePerKelvin, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, cScalar, cKilogram, -1, -1, -1, -1, -1, cSecond, cMeterSecond, -1, -1, -1, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, cSquareMeterKelvin, -1, -1),
    (cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterKelvin, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterKelvin, -1, -1, -1, -1, -1, -1, cKelvin, cMeterKelvin, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, cKelvinPerMeter, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1),
    (cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, cKelvin, cKelvinPerMeter, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cScalar, cKelvinPerWatt, cMeterKelvinPerWatt, -1, -1, -1, cWattPerMeter, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, cMeterKelvinPerWatt, -1, -1, -1, -1),
    (cWattPerMeter, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, cWattPerMeter, cWattPerCubicMeter, -1, -1, -1, -1, cMeterPerCubicSecond, -1, cVoltPerMeter, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, cNewton, cKilogramMeterPerSecond, cKilogramMeterPerSecond, cNewtonPerMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, cPoiseuille, -1, -1, cMeterPerSquareSecond, cSquareHertz, -1, cWattPerMeter, cWatt, cWattPerMeter, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, cHertz, cHertz, -1, cSquareMeterPerSecond, -1, -1, cReciprocalMeter, -1, -1, -1, cAmperePerMeter, cSiemensPerMeter, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cMeterPerSecond, cNewtonPerCubicMeter, cSquareMeterPerSquareSecond, cPascal, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, cWattPerKelvin, cScalar, cMeter, cSquareMeter, cKelvinPerMeter, cKelvin, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, -1, cVoltMeterPerSecond, -1, -1, -1, cAmperePerSquareMeter, cCoulombPerSquareMeter, -1, cVolt, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, cKilogramPerMeter, cNewton, cWattPerSquareMeter, cWattPerCubicMeter, -1, cPascal, cReciprocalMeter, -1, cScalar, cMeter, cSquareMeter, cMeterPerSecond, -1, -1),
    (cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, cNewtonPerMeter, cKilogramPerSecond, cKilogramPerSecond, cPascal, cPoiseuille, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, cSquareHertz, -1, -1, cWattPerSquareMeter, cWattPerMeter, cWattPerSquareMeter, cWatt, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cGrayPerSecond, -1, -1, -1, -1, cMeterPerSecond, -1, -1, cReciprocalSquareMeter, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, cHertz, -1, cMeterPerSquareSecond, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, cReciprocalMeter, cScalar, cMeter, -1, cKelvinPerMeter, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, cVoltPerMeter, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, cVoltMeterPerSecond, cKilogramPerSquareMeter, cNewtonPerMeter, cWattPerCubicMeter, -1, -1, cNewtonPerCubicMeter, cReciprocalSquareMeter, -1, cReciprocalMeter, cScalar, cMeter, cHertz, -1, -1),
    (cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cPoiseuille, cPoiseuille, cNewtonPerCubicMeter, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, cWattPerSquareMeter, cWattPerCubicMeter, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cGrayPerSecond, -1, -1, -1, cHertz, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, -1, cSquareHertz, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, cReciprocalSquareMeter, cReciprocalMeter, cScalar, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, cKatalPerCubicMeter, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, cKilogramPerCubicMeter, cPascal, -1, -1, -1, -1, cReciprocalCubicMeter, -1, cReciprocalSquareMeter, cReciprocalMeter, cScalar, -1, cJoulePerMole, -1),
    (cWattPerKelvin, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, cWattPerKelvin, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerQuarticKelvin, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, cWattPerKelvin, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWatt, -1, cHertz, cKilogramPerSecond, -1, -1, -1, cSquareMeterKelvin, -1, cScalar, cMeter, -1, -1, -1, cWattPerSquareMeter, cSquareMeter, -1, cCubicKelvin, -1, -1, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, cWattPerMeterPerKelvin, cWattPerSquareMeterPerKelvin, -1, -1, cReciprocalKelvin, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1),
    (cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, cWattPerKelvin, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeter, -1, -1, cPoiseuille, -1, -1, cReciprocalKelvin, -1, cSquareMeterKelvin, cReciprocalMeter, cScalar, -1, -1, -1, cWattPerCubicMeter, cMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, cSquareMeterKelvin, -1, -1, -1),
    (cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, cMeterKelvinPerWatt, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, cScalar, cKelvinPerMeter, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvinPerWatt, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeter, cKelvin, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterKelvin, -1, cJoulePerKilogramPerKelvin, -1, -1, -1, -1, -1, cSquareMeterKelvin, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterKelvin, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, -1, cSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, cWattPerMeterPerKelvin, cWattPerSquareMeterPerKelvin, cWattPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, cReciprocalSquareMeter, cReciprocalMeter, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, -1, -1, -1),
    (cSquareMeterQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, cSquareMeterQuarticKelvin, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterQuarticKelvin, -1, cSquareMeterQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, cWattPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerQuarticKelvin, -1, cWattPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerQuarticKelvin, -1, cWattPerSquareMeterPerQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, -1, -1, -1),
    (cJoulePerMole, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, cJoulePerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMole, cReciprocalMole, -1, -1, -1, -1, cCoulombPerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMole, -1, -1, -1, -1, -1, cVolt),
    (cMoleKelvin, -1, -1, -1, -1, -1, -1, -1, cMoleKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMoleKelvin, -1, cMoleKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMolePerKelvin, -1, cJoulePerMolePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, cReciprocalMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalKelvin, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cOhmMeter, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, cOhm, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenry, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, cOhmMeter, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, cMeterPerWatt, -1, cMeter, -1, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, cSecond, -1, -1, -1, -1, cVolt, -1, cCubicMeterPerSecond, cSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhm, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, cVolt, cVoltPerMeter, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, cReciprocalMeter, -1, -1, cAmperePerMeter, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, cScalar, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cCoulomb, cCoulombPerSquareMeter, cReciprocalSquareMeter, -1, -1, cOhm, cWattPerSquareMeter, cHertz, -1, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1),
    (cCoulombPerMeter, cAmperePerMeter, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, cCoulombPerMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, cCoulombPerMeter, cCoulomb, cCoulombPerMeter, cCoulombMeter, -1, -1, -1, -1, cAmpere, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, cReciprocalSquareMeter, cFaradPerMeter, -1, cVoltPerMeter, -1, cTeslaMeter, cWeber, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, cScalar, -1, cMeter, -1, -1, -1, -1, -1, cVolt, cSecond, -1, cSiemens, -1, -1, cCoulomb, -1, -1, -1, -1, cKilogramPerMeter, -1, -1, -1, cMeterSecond, -1, -1, cSquareMeter, -1, -1, cCoulombPerSquareMeter, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cSquareCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, cSiemens, -1, cSquareCoulombPerMeter, cSquareCoulomb, cSquareCoulombPerMeter, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, cFarad, cFarad, -1, -1, cFaradPerMeter, cFaradPerMeter, -1, cCoulombPerMeter, cReciprocalMeter, cCoulombPerSquareMeter, -1, -1, cNewton, -1, cKilogramMeterPerSecond, cKilogramSquareMeterPerSecond, -1, -1, -1, cKilogramMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, cScalar, cCoulombMeter, -1, -1, -1, -1, -1, cJoule, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1),
    (cCoulombPerSquareMeter, cAmperePerSquareMeter, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, cCoulombPerMeter, cCoulombPerSquareMeter, cCoulomb, cCoulombMeter, -1, -1, -1, cAmperePerMeter, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cReciprocalCubicMeter, -1, -1, -1, -1, cTesla, cTeslaMeter, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, cReciprocalMeter, -1, cScalar, -1, -1, -1, -1, -1, cVoltPerMeter, cSecondPerMeter, -1, cSiemensPerMeter, -1, -1, cCoulombPerMeter, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, cSecond, -1, -1, cMeter, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, cHenryPerMeter, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, cNewtonPerSquareCoulomb, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cScalar, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, cMeterPerSquareSecond, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, cOhm, cHenry, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, cNewton, cSquareMeter, cScalar, -1, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cVoltMeter, cVoltMeterPerSecond, -1, -1, -1, -1, -1, cVolt, cVoltMeter, cVoltPerMeter, -1, -1, -1, -1, -1, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, cNewtonSquareMeterPerSquareCoulomb, -1, -1, cMeter, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmpere, cSquareMeter, -1, -1, -1, -1, -1, cCoulomb, cScalar, cSecond, -1, -1, cWatt, cSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, cVoltPerMeter, -1, cTeslaMeter, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1),
    (cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, cVolt, cWeber, -1, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, cVoltMeterPerSecond, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, -1, -1, -1, -1, cSquareMeterAmpere, cAmpere, cHertz, cScalar, -1, -1, -1, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, cVoltPerMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cFaradPerMeter, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, cFaradPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFaradPerMeter, cFarad, cFaradPerMeter, -1, -1, -1, -1, -1, cSiemens, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, cSecondPerMeter, cSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cAmperePerMeter, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, cAmpere, cAmperePerMeter, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, cVoltPerMeter, cVolt, -1, -1, -1, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemens, cHertz, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, cScalar, -1, cReciprocalHenry, -1, -1, cAmpere, -1, -1, -1, -1, cPoiseuille, cReciprocalCubicMeter, -1, -1, cMeter, -1, -1, cSquareMeterPerSecond, -1, cCoulombPerMeter, cAmperePerSquareMeter, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cTeslaMeter, cVoltPerMeter, -1, -1, -1, -1, -1, cTesla, cTeslaMeter, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaMeter, cWeber, cTeslaMeter, -1, -1, -1, -1, -1, cVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, cCoulombPerMeter, -1, -1, cMeter, cReciprocalMeter, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, cSecond, cOhm, -1, cOhmMeter, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, cHenry, cNewtonPerMeter, cScalar, -1, cAmpere, cWeber, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1),
    (cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, cHenryPerMeter, cTeslaPerAmpere, cHenry, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cReciprocalMeter, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cHenryPerMeter, -1, cNewtonPerSquareCoulomb, -1, -1, -1, -1, cTeslaPerAmpere, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, cHenry, cHenryPerMeter, -1, -1, -1, -1, -1, cOhm, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, cMeterPerAmpere, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerMeter, cSquareSecond, cSquareSecondPerSquareMeter, -1, -1, -1, -1, cTesla, -1, cMeter, cScalar, cHenry, -1, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalMeter, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cReciprocalMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cScalar, cReciprocalMeter, cMeter, cSquareMeter, cCubicMeter, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonPerSquareCoulomb, cSiemensPerMeter, -1, cOhm, -1, -1, -1, cHenryPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, cKilogramPerQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, -1, cReciprocalKelvin, -1, cMeterPerWatt, -1, -1, cKelvinPerWatt, cWattPerMeterPerKelvin, cWattPerSquareMeter, cWattPerSquareMeterPerKelvin, -1, cMeterKelvinPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cFarad, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, cReciprocalHenry, cScalar, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, cSecondPerMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1),
    (cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramPerSquareSecond, -1, -1, -1, -1, -1, cNewtonPerMeter, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, cSquareKilogram, -1, cSquareKilogramPerMeter, -1, -1, -1, -1, cSquareKilogramPerSquareMeter, -1, cPascal, cKilogramPerSecond, cPoiseuille, cReciprocalSquareMeter, cSquareKilogramPerSquareSecond, -1, cSquareKilogramPerSquareSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareJouleSquareSecond, cNewtonPerCubicMeter, -1, -1, cNewton, cJoule, cNewtonSquareMeter, cKilogramPerMeter, cKilogramPerMeter, cSquareSecondPerSquareMeter, cKilogramMeter, cKilogramPerSquareMeter, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, cKilogram, -1, cKilogramMeterPerSecond, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, cKilogramPerQuarticMeter, -1, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cSquareNewton, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramPerSquareMeter, -1, -1, -1, cKilogram, -1, -1),
    (cSquareSecondPerSquareMeter, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareSecondPerSquareMeter, -1, cSquareSecondPerSquareMeter, cSquareSecond, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHenryPerMeter, -1, -1, -1, cFarad, cFaradPerMeter, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareJoule, -1, -1, -1, -1, -1, -1, -1, cSquareJoule, cSquareNewton, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareJouleSquareSecond, cSquareJouleSquareSecond, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cSquareJoule, -1, cSquareJoule, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, cNewtonSquareMeter, cNewtonSquareMeter, cSquareMeter, -1, cJoule, cJoule, cKilogramSquareMeterPerSecond, -1, cSquareVolt, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewton, cNewtonPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cSquareHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareNewton, -1, -1, cKilogramSquareMeterPerSecond, cJoule, -1, -1, -1, cNewtonCubicMeter, -1, -1),
    (cSquareJouleSquareSecond, -1, cSquareJoule, -1, -1, -1, -1, -1, cSquareJouleSquareSecond, cSquareKilogramSquareMeterPerSquareSecond, -1, cSquareKilogramPerSquareSecond, -1, -1, cNewtonCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, cSquareMeter, cSquareJouleSquareSecond, -1, cSquareJouleSquareSecond, -1, -1, -1, cJoule, cKilogramSquareMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeter, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramMeter, cKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, -1, cSquareSecond, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareKilogramSquareMeterPerSquareSecond, -1, -1, -1, cKilogramSquareMeter, -1, -1, -1, -1, -1, -1),
    (cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, cAmpere, cAmperePerMeter, cAmperePerSquareMeter, -1, -1, -1, -1, cSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, cSquareMeterAmpere, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, -1, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cScalar, -1, -1, cQuarticMeter, -1, -1, -1, -1, -1, -1, cAmpere, cAmperePerMeter, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1),
    (cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cReciprocalMole, -1, -1, -1, -1, -1, -1, -1, cReciprocalMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMole, -1, cReciprocalMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cAmperePerSquareMeter, cAmperePerMeter, cAmperePerSquareMeter, cAmpere, -1, cSquareMeterAmpere, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, cReciprocalHenry, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, cReciprocalMeter, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, cReciprocalQuarticMeter, -1, -1, cScalar, -1, -1, cMeterPerSecond, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMolePerCubicMeter, cKatalPerCubicMeter, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, cMolePerCubicMeter, -1, cMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1),
    (cLux, -1, -1, -1, -1, -1, -1, -1, cLux, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, cLuxSecond, -1, -1, cLumenSecondPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLux, -1, cLux, cCandela, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cMeterPerSecond, cScalar, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, cScalar, -1, -1, cLuxSecond, -1, -1, -1, -1, -1, -1, -1, cLumenPerWatt, -1, -1, -1, -1),
    (cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, cCoulombPerSquareMeter, cCoulombPerCubicMeter, cCoulombPerMeter, cCoulomb, cCoulombMeter, -1, -1, cAmperePerSquareMeter, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, cReciprocalQuarticMeter, -1, -1, -1, -1, -1, cTesla, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalSquareMeter, -1, cReciprocalMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, cKilogramPerCubicMeter, -1, -1, -1, cSecondPerMeter, cCoulombPerMole, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter),
    (cGrayPerSecond, -1, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareSecond, cSquareMeterPerSecond, cSquareMeterPerSecond, cMeterPerSquareSecond, cMeterPerSecond, cMeter, cMeterSecond, -1, -1, cHertz, cMeterPerQuarticSecond, -1, -1, cNewtonPerSquareKilogram, -1, cGrayPerSecond, -1, cGrayPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareKilogram, cSquareHertz, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, cKilogramMeterPerSecond, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cSquareMeterPerSquareSecond, cMeterPerCubicSecond, -1, -1, cSquareHertz, -1, -1, -1, -1, cCubicMeterPerKilogram, -1, -1, -1),
    (cHertz, cSquareHertz, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, cSecond, cSecond, cReciprocalMeter, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, cMeterPerSecond, cHertz, cSquareMeterPerSecond, cCubicMeterPerSecond, -1, -1, -1, cMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalHenry, -1, cNewtonSquareMeterPerSquareCoulomb, cCoulombPerKilogram, -1, -1, cOhm, -1, -1, -1, -1, -1, cReciprocalMole, -1, -1, cReciprocalCubicMeter, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSiemensPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, cGrayPerSecond, -1, -1, cTesla, -1, -1, cKatal, -1, -1, -1, -1, cSquareSecondPerSquareMeter, cScalar, -1, -1, -1, cReciprocalSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1),
    (cMeter, cMeterPerSecond, cMeterPerSquareSecond, cMeterPerCubicSecond, cMeterPerQuarticSecond, cMeterPerQuinticSecond, cMeterPerSexticSecond, cScalar, cMeter, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, cSecond, cSquareSecond, cCubicSecond, cQuarticSecond, cQuinticSecond, cSexticSecond, -1, cHertz, -1, -1, -1, -1, cMeter, cSquareMeter, cMeter, cCubicMeter, cQuarticMeter, cQuinticMeter, -1, -1, cSquareMeterPerSecond, -1, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, cMeterPerWatt, -1, -1, -1, -1, -1, cNewtonSquareMeterPerSquareCoulomb, -1, cOhmMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, -1, -1, cKilogramPerSquareMeter, cNewtonPerSquareKilogram, cSquareSecondPerSquareMeter, -1, -1, cKilogramSquareSecond, cSquareMeterPerSquareKilogram, -1, cSquareKilogramPerMeter, -1, cMeterKelvin, -1, -1, -1, cReciprocalKelvin, cSquareMeterKelvin, -1, -1, -1, cMeterKelvinPerWatt, -1, -1, cWatt, cWattPerKelvin, cKelvinPerMeter, -1, -1, -1, -1, -1, -1, -1, cSiemens, -1, -1, cSquareMeterPerSquareCoulomb, -1, cSquareCoulombPerMeter, -1, cFarad, -1, -1, -1, -1, cAmpere, -1, -1, -1, cSquareMeter, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, cScalar, cReciprocalMeter, cReciprocalSquareMeter, cSecondPerMeter, cMeterPerWatt, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeter, cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, cMeter, cSquareMeter, cScalar, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, -1, cSquareMeterPerSquareKilogram, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, cSquareSecond, cMeterPerSecond, -1, -1, -1, -1, cSquareMeter, cCubicMeter, cSquareMeter, cQuarticMeter, cQuinticMeter, cSexticMeter, -1, -1, cCubicMeterPerSecond, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, -1, cSecond, -1, -1, -1, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, -1, cSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicSecond, -1, cMeter, cScalar, cReciprocalMeter, cSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cCubicMeter, cCubicMeterPerSecond, cCubicMeterPerSquareSecond, -1, -1, -1, -1, cSquareMeter, cCubicMeter, cMeter, cScalar, cReciprocalMeter, cReciprocalSquareMeter, cReciprocalCubicMeter, cCubicMeterPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, -1, -1, -1, -1, cCubicMeter, cQuarticMeter, cCubicMeter, cQuinticMeter, cSexticMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecond, -1, cMeterSecond, -1, -1, -1, cKilogram, cNewtonSquareMeterPerSquareKilogram, cSquareSecond, -1, -1, -1, -1, -1, -1, cKilogramSquareSecond, -1, -1, -1, -1, cSquareMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterAmpere, -1, -1, -1, cQuarticMeter, -1, -1, -1, -1, -1, cMeterPerAmpere, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, cMeter, cScalar, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1),
    (cSquareMeterPerSecond, cSquareMeterPerSquareSecond, cGrayPerSecond, -1, -1, -1, -1, cMeterPerSecond, cSquareMeterPerSecond, cHertz, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, -1, -1, cMeter, cMeterSecond, -1, -1, -1, -1, cSecond, cMeterPerSquareSecond, -1, -1, -1, -1, cSquareMeterPerSecond, cCubicMeterPerSecond, cSquareMeterPerSecond, -1, -1, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMeter, cCubicMeterPerKilogram, cScalar, -1, -1, -1, cPoiseuille, -1, cSecondPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, -1, -1, -1, -1, cWeber, -1, -1, -1, -1, -1, -1, -1, cSquareSecond, cSquareMeter, cMeterPerSecond, cHertz, -1, cScalar, -1, -1, -1, -1, -1, -1, -1, -1),
    (cWatt, -1, -1, -1, -1, -1, -1, cWattPerMeter, cWatt, cWattPerSquareMeter, cWattPerCubicMeter, -1, -1, -1, cGrayPerSecond, -1, cVolt, cOhm, cWattPerKelvin, -1, -1, cWattPerQuarticKelvin, -1, -1, cJoule, cKilogramSquareMeterPerSecond, cKilogramSquareMeterPerSecond, cNewton, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, cKilogramPerSecond, -1, cMeterPerCubicSecond, cSquareMeterPerSquareSecond, cMeterPerSquareSecond, -1, cWatt, -1, cWatt, -1, -1, -1, -1, cSquareHertz, -1, -1, -1, -1, cMeterPerSecond, cMeterPerSecond, -1, cCubicMeterPerSecond, cHertz, cHertz, cScalar, -1, -1, -1, cAmpere, cSiemens, -1, cSquareAmpere, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cJoulePerMole, -1, cSquareMeterPerSecond, cPascal, cCubicMeterPerSquareSecond, cNewtonPerMeter, -1, -1, -1, -1, -1, cPoiseuille, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, -1, cMeter, cSquareMeter, cCubicMeter, cKelvin, cMeterKelvin, -1, -1, -1, -1, -1, -1, cQuarticKelvin, -1, cKatal, -1, -1, -1, -1, cVoltMeterPerSecond, -1, -1, -1, -1, -1, cAmperePerMeter, cCoulombPerMeter, -1, cVoltMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKilogram, cJoule, cWattPerMeter, cWattPerSquareMeter, cWattPerCubicMeter, cNewtonPerMeter, cScalar, cHertz, cMeter, cSquareMeter, cCubicMeter, cSquareMeterPerSecond, -1, -1),
    (cJoule, cWatt, -1, -1, -1, -1, -1, cNewton, cJoule, cNewtonPerMeter, cPascal, cNewtonPerCubicMeter, -1, -1, cSquareMeterPerSquareSecond, -1, cWeber, cHenry, cJoulePerKelvin, -1, -1, -1, cJoulePerMole, -1, cKilogramSquareMeterPerSecond, cKilogramSquareMeter, cKilogramSquareMeter, cKilogramMeterPerSecond, cKilogramMeter, -1, -1, -1, -1, cKilogram, cWattPerMeter, cMeterPerSquareSecond, cSquareMeterPerSecond, cMeterPerSecond, -1, cJoule, cNewtonSquareMeter, cJoule, cNewtonCubicMeter, -1, -1, cSquareHertz, cHertz, -1, cCubicMeterPerSquareSecond, -1, -1, cMeter, cMeter, -1, cCubicMeter, cScalar, cScalar, cSecond, cVolt, -1, cVoltPerMeter, cCoulomb, cFarad, cSquareVolt, -1, -1, -1, cSquareMeterAmpere, cAmpere, cSquareAmpere, -1, -1, -1, -1, -1, -1, -1, cQuarticMeter, cSquareMeter, cPoiseuille, cCubicMeterPerSecond, cKilogramPerSecond, -1, -1, -1, -1, -1, cKilogramPerMeter, cReciprocalMeter, cReciprocalSquareMeter, -1, cNewtonSquareMeterPerSquareKilogram, -1, -1, cSquareKilogramPerMeter, -1, cJoulePerKilogramPerKelvin, cKelvin, cKilogramKelvin, -1, -1, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMole, cJoulePerMolePerKelvin, cMoleKelvin, -1, cCoulombMeter, cVoltMeter, cNewtonSquareMeterPerSquareCoulomb, -1, -1, -1, cSquareCoulombPerMeter, cCoulombPerMeter, -1, -1, -1, -1, -1, -1, -1, cNewtonSquareMeter, -1, -1, -1, -1, -1, cTesla, -1, -1, -1, -1, -1, -1, -1, cKilogramSquareMeterPerSecond, cNewton, cNewtonPerMeter, cPascal, cKilogramPerSecond, cSecond, cScalar, cMeterSecond, -1, -1, cSquareMeter, -1, -1),
    (cWattPerMeter, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, cWattPerMeter, cWattPerCubicMeter, -1, -1, -1, -1, cMeterPerCubicSecond, -1, cVoltPerMeter, -1, cWattPerMeterPerKelvin, -1, -1, -1, -1, -1, cNewton, cKilogramMeterPerSecond, cKilogramMeterPerSecond, cNewtonPerMeter, cKilogramPerSecond, cKilogram, -1, cKilogramSquareSecond, -1, cPoiseuille, -1, -1, cMeterPerSquareSecond, cSquareHertz, -1, cWattPerMeter, cWatt, cWattPerMeter, -1, -1, -1, -1, -1, -1, cGrayPerSecond, -1, -1, cHertz, cHertz, -1, cSquareMeterPerSecond, -1, -1, cReciprocalMeter, -1, -1, -1, cAmperePerMeter, cSiemensPerMeter, -1, -1, -1, cSquareVolt, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCubicMeterPerSecond, cMeterPerSecond, cNewtonPerCubicMeter, cSquareMeterPerSquareSecond, cPascal, -1, -1, -1, -1, cMeterPerQuinticSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, cWattPerKelvin, cScalar, cMeter, cSquareMeter, cKelvinPerMeter, cKelvin, -1, -1, -1, -1, cMeterKelvin, -1, -1, -1, -1, -1, -1, -1, cAmpere, -1, -1, cVoltMeterPerSecond, -1, -1, -1, cAmperePerSquareMeter, cCoulombPerSquareMeter, -1, cVolt, -1, -1, -1, -1, cWatt, -1, -1, -1, -1, -1, -1, -1, -1, cVoltMeter, -1, -1, -1, cKilogramPerMeter, cNewton, cWattPerSquareMeter, cWattPerCubicMeter, -1, cPascal, cReciprocalMeter, -1, cScalar, cMeter, cSquareMeter, cMeterPerSecond, -1, -1),
    (cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, -1, -1, -1, -1, -1, cNewtonPerMeter, cKilogramPerSecond, cKilogramPerSecond, cPascal, cPoiseuille, cKilogramPerMeter, -1, -1, -1, -1, -1, -1, cSquareHertz, -1, -1, cWattPerSquareMeter, cWattPerMeter, cWattPerSquareMeter, cWatt, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cGrayPerSecond, -1, -1, -1, -1, cMeterPerSecond, -1, -1, cReciprocalSquareMeter, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeterPerSecond, cHertz, -1, cMeterPerSquareSecond, cNewtonPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerMeterPerKelvin, cReciprocalMeter, cScalar, cMeter, -1, cKelvinPerMeter, -1, -1, -1, -1, cKelvin, -1, -1, -1, -1, -1, -1, -1, cAmperePerMeter, -1, -1, -1, -1, -1, -1, -1, cCoulombPerCubicMeter, -1, cVoltPerMeter, -1, -1, -1, -1, cWattPerMeter, -1, -1, -1, -1, -1, -1, -1, -1, cVolt, -1, -1, cVoltMeterPerSecond, cKilogramPerSquareMeter, cNewtonPerMeter, cWattPerCubicMeter, -1, -1, cNewtonPerCubicMeter, cReciprocalSquareMeter, -1, cReciprocalMeter, cScalar, cMeter, cHertz, -1, -1),
    (cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cPascal, cPoiseuille, cPoiseuille, cNewtonPerCubicMeter, -1, cKilogramPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerCubicMeter, cWattPerSquareMeter, cWattPerCubicMeter, cWattPerMeter, cWatt, -1, -1, -1, -1, -1, cMeterPerCubicSecond, cGrayPerSecond, -1, -1, -1, cHertz, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMeterPerSecond, -1, -1, cSquareHertz, -1, -1, -1, cCubicMeterPerSquareSecond, -1, -1, cKilogramPerQuarticMeterPerSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeterPerKelvin, cReciprocalSquareMeter, cReciprocalMeter, cScalar, -1, -1, -1, -1, -1, -1, cKelvinPerMeter, -1, -1, -1, cKatalPerCubicMeter, -1, -1, -1, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cWattPerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cVoltPerMeter, -1, -1, -1, cKilogramPerCubicMeter, cPascal, -1, -1, -1, -1, cReciprocalCubicMeter, -1, cReciprocalSquareMeter, cReciprocalMeter, cScalar, -1, cJoulePerMole, -1),
    (cNewtonPerMeter, cWattPerSquareMeter, -1, -1, -1, -1, -1, cPascal, cNewtonPerMeter, cNewtonPerCubicMeter, -1, -1, -1, -1, cSquareHertz, -1, cTesla, cTeslaPerAmpere, -1, -1, -1, -1, -1, -1, cKilogramPerSecond, cKilogram, cKilogram, cPoiseuille, cKilogramPerMeter, -1, -1, -1, -1, cKilogramPerSquareMeter, cWattPerCubicMeter, -1, cHertz, -1, -1, cNewtonPerMeter, cNewton, cNewtonPerMeter, cJoule, cNewtonSquareMeter, cNewtonCubicMeter, -1, -1, cWattPerMeter, cMeterPerSquareSecond, cSquareMeterPerSquareSecond, cCubicMeterPerSquareSecond, cReciprocalMeter, cReciprocalMeter, -1, cMeter, cReciprocalSquareMeter, cReciprocalSquareMeter, -1, -1, -1, -1, cCoulombPerSquareMeter, -1, -1, -1, -1, -1, cAmpere, cAmperePerSquareMeter, -1, -1, -1, -1, -1, -1, -1, -1, cSquareMeter, cScalar, -1, cMeterPerSecond, -1, -1, -1, -1, -1, -1, cKilogramPerCubicMeter, cReciprocalCubicMeter, cReciprocalQuarticMeter, cSquareKilogramPerMeter, cNewtonPerSquareKilogram, -1, -1, -1, -1, -1, -1, -1, -1, -1, cSecondPerMeter, cSecond, cMeterSecond, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMeter, cVoltPerMeter, cNewtonPerSquareCoulomb, cVolt, -1, cSquareCoulombPerMeter, -1, cCoulombPerCubicMeter, -1, -1, cTeslaMeter, -1, cAmperePerMeter, cSquareAmpere, -1, cNewton, -1, -1, -1, -1, -1, -1, -1, -1, cWeber, -1, -1, cVoltMeter, -1, cKilogramPerSecond, cPascal, cNewtonPerCubicMeter, -1, -1, -1, cReciprocalSquareMeter, cSecondPerMeter, cSecond, cMeterSecond, cScalar, -1, -1),
    (cKatalPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, cKatalPerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cKatalPerCubicMeter, -1, cKatalPerCubicMeter, -1, cKatal, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cHertz, -1, -1, -1, cMolePerCubicMeter, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar, -1),
    (cCoulombPerMole, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulombPerMole, -1, cCoulombPerMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cReciprocalMole, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cCoulomb, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, cScalar)
  );

const
  PowerTable : array[0..159] of
    record  Square, Cubic, Quartic, Quintic, Sextic: longint; end = (
    (Square: 0; Cubic: 0; Quartic: 0; Quintic: 0; Sextic: 0),
    (Square: 9; Cubic: 13; Quartic: 14; Quintic: 15; Sextic: 16),
    (Square: 14; Cubic: 16; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 16; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 26; Cubic: 31; Quartic: 37; Quintic: 38; Sextic: 39),
    (Square: 0; Cubic: 0; Quartic: 0; Quintic: 0; Sextic: 0),
    (Square: 37; Cubic: 39; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 39; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 47; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 49; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 53; Cubic: 54; Quartic: 55; Quintic: -1; Sextic: -1),
    (Square: 55; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 61; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 76; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 249; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 86; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 0; Cubic: 0; Quartic: 0; Quintic: 0; Sextic: 0),
    (Square: 91; Cubic: 92; Quartic: 93; Quintic: -1; Sextic: -1),
    (Square: 0; Cubic: 0; Quartic: 0; Quintic: 0; Sextic: 0),
    (Square: 93; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 256; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 250; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 194; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 106; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 106; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 251; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 251; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 134; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 140; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
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
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 91; Cubic: 92; Quartic: 93; Quintic: -1; Sextic: -1),
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
    (Square: 61; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 26; Cubic: 31; Quartic: 37; Quintic: 38; Sextic: 39),
    (Square: 37; Cubic: 39; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 39; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 251; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1)
  );

const
  RootTable : array[0..159] of
    record  Square, Cubic, Quartic, Quintic, Sextic: longint; end = (
    (Square: 0; Cubic: 0; Quartic: 0; Quintic: 0; Sextic: 0),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 5; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: 5; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 9; Cubic: -1; Quartic: 5; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: 5; Sextic: -1),
    (Square: 13; Cubic: 9; Quartic: -1; Quintic: -1; Sextic: 5),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 0; Cubic: 0; Quartic: 0; Quintic: 0; Sextic: 0),
    (Square: 17; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: 17; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 26; Cubic: -1; Quartic: 17; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: 17; Sextic: -1),
    (Square: 31; Cubic: 26; Quartic: -1; Quintic: -1; Sextic: 17),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 40; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 48; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 50; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: 50; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 53; Cubic: -1; Quartic: 50; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 58; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 58; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 65; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 84; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 0; Cubic: 0; Quartic: 0; Quintic: 0; Sextic: 0),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 0; Cubic: 0; Quartic: 0; Quintic: 0; Sextic: 0),
    (Square: 88; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: 88; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 91; Cubic: -1; Quartic: 88; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 102; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 131; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 137; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
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
    (Square: 98; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
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
    (Square: 82; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 97; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 114; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: 95; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
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
    (Square: 17; Cubic: -1; Quartic: -1; Quintic: -1; Sextic: -1),
    (Square: -1; Cubic: 17; Quartic: -1; Quintic: -1; Sextic: -1),
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

function SquarePower(const AValue: TQuantity): TQuantity;
function CubicPower(const AValue: TQuantity): TQuantity;
function QuarticPower(const AValue: TQuantity): TQuantity;
function QuinticPower(const AValue: TQuantity): TQuantity;
function SexticPower(const AValue: TQuantity): TQuantity;
function SquareRoot(const AValue: TQuantity): TQuantity;
function CubicRoot(const AValue: TQuantity): TQuantity;
function QuarticRoot(const AValue: TQuantity): TQuantity;
function QuinticRoot(const AValue: TQuantity): TQuantity;
function SexticRoot(const AValue: TQuantity): TQuantity;

{ Trigonometric functions }

function Cos(const AQuantity: TQuantity): double;
function Sin(const AQuantity: TQuantity): double;
function Tan(const AQuantity: TQuantity): double;
function Cotan(const AQuantity: TQuantity): double;
function Secant(const AQuantity: TQuantity): double;
function Cosecant(const AQuantity: TQuantity): double;

function ArcCos(const AQuantity: double): TQuantity;
function ArcSin(const AQuantity: double): TQuantity;
function ArcTan(const AQuantity: double): TQuantity;
function ArcTan2(const x, y: double): TQuantity;

{ Override trigonometric functions }

{$IFOPT D+}
function Cos(const AQuantity: double): double;
function Sin(const AQuantity: double): double;
function Tan(const AQuantity: double): double;
function Cotan(const AQuantity: double): double;
function Secant(const AQuantity: double): double;
function Cosecant(const AQuantity: double): double;
{$ENDIF}

{ Math functions }

generic function Min<TQuantity>(const AValue1, AValue2: TQuantity): TQuantity;
generic function Max<TQuantity>(const AValue1, AValue2: TQuantity): TQuantity;

{ Useful routines }

function GetSymbol(const ASymbol: string; const Prefixes: TPrefixes): string;
function GetName(const AName: string; const Prefixes: TPrefixes): string;

{ Helper functions }

function SameValue(const ALeft, ARight: TQuantity): boolean;
function Min(const ALeft, ARight: TQuantity): TQuantity;
function Max(const ALeft, ARight: TQuantity): TQuantity;
function Exp(const AQuantity: TQuantity): TQuantity;

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

function GetSymbol(const ASymbol: string; const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := ASymbol;
    1:  result := Format(ASymbol, [
          PrefixTable[Prefixes[0]].Symbol]);
    2:  result := Format(ASymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol]);
    3:  result := Format(ASymbol, [
          PrefixTable[Prefixes[0]].Symbol,
          PrefixTable[Prefixes[1]].Symbol,
          PrefixTable[Prefixes[2]].Symbol]);
  else raise Exception.Create('Wrong number of prefixes.');
  end;
end;

function GetName(const AName: string; const Prefixes: TPrefixes): string;
var
  PrefixCount: longint;
begin
  PrefixCount := Length(Prefixes);
  case PrefixCount of
    0:  result := AName;
    1:  result := Format(AName, [
          PrefixTable[Prefixes[0]].Name]);
    2:  result := Format(AName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name]);
    3:  result := Format(AName, [
          PrefixTable[Prefixes[0]].Name,
          PrefixTable[Prefixes[1]].Name,
          PrefixTable[Prefixes[2]].Name]);
   else raise Exception.Create('Wrong number of prefixes.');
   end;
end;

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

{ TUnit }

class operator TUnit.*(const AValue: double; const ASelf: TUnit): TQuantity; inline;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := AValue;
{$ELSE}
  result := AValue;
{$ENDIF}
end;

class operator TUnit./(const AValue: double; const ASelf: TUnit): TQuantity; inline;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement];
  result.FValue := 1/AValue;
{$ELSE}
  result := 1/AValue;
{$ENDIF}
end;

{$IFOPT D+}
class operator TUnit.*(const AValue: TQuantity; const ASelf: TUnit): TQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AValue.FValue;
end;

class operator TUnit./(const AValue: TQuantity; const ASelf: TUnit): TQuantity; inline;
begin
  result.FUnitOfMeasurement := DivTable[AValue.FUnitOfMeasurement, U.FUnitOfMeasurement];
  result.FValue := AValue.FValue;
end;
{$ENDIF}

function TUnit.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := AQuantity.FValue;
{$ELSE}
  result := AQuantity;
{$ENDIF}
end;

function TUnit.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := GetValue(AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue(AQuantity, APrefixes);
{$ENDIF}
end;

function TUnit.ToString(const AValue: TQuantity): string;
begin
{$IFOPT D+}
  if AValue.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := FloatToStr(AValue.FValue) + ' ' + GetSymbol(U.FSymbol, U.FPrefixes);
{$ELSE}
  result := FloatToStr(AValue) + ' ' + GetSymbol(U.FSymbol, U.FPrefixes);
{$ENDIF}
end;

function TUnit.ToString(const AValue: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFOPT D+}
  if AValue.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  FactoredValue := GetValue(AValue.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AValue, APrefixes);
{$ENDIF}
  if Length(APrefixes) = 0 then
     result := FloatToStr(FactoredValue) + ' ' + GetSymbol(U.FSymbol, U.FPrefixes)
  else
    result := FloatToStr(FactoredValue) + ' ' + GetSymbol(U.FSymbol, APrefixes);
end;

function TUnit.ToString(const AValue: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFOPT D+}
  if AValue.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  FactoredValue := GetValue(AValue.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AValue, APrefixes);
{$ENDIF}
  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(U.FSymbol, U.FPrefixes)
  else
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(U.FSymbol, APrefixes);
end;

function TUnit.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(U.FSymbol, U.FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +');
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(U.FSymbol, APrefixes);
  end;
end;

function TUnit.ToVerboseString(const AValue: TQuantity): string;
begin
{$IFOPT D+}
  if AValue.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');

  if (AValue.FValue > -1) and (AValue.FValue < 1) then
    result := FloatToStr(AValue.FValue) + ' ' + GetName(U.FName, U.FPrefixes)
  else
    result := FloatToStr(AValue.FValue) + ' ' + GetName(U.FPluralName, U.FPrefixes);
{$ELSE}
  if (AValue > -1) and (AValue < 1) then
    result := FloatToStr(AValue) + ' ' + GetName(U.FName, U.FPrefixes)
  else
    result := FloatToStr(AValue) + ' ' + GetName(U.FPluralName, U.FPrefixes);
{$ENDIF}
end;

function TUnit.ToVerboseString(const AValue: TQuantity; const APrefixes: TPrefixes): string;
begin
{$IFOPT D+}
  if AValue.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');

  if Length(APrefixes) = 0 then
  begin
    if (AValue.FValue > -1) and (AValue.FValue < 1) then
      result := FloatToStr(AValue.FValue) + ' ' + GetName(U.FName, U.FPRefixes)
    else
      result := FloatToStr(AValue.FValue) + ' ' + GetName(U.PluralName, U.FPRefixes);
  end else
  begin
    if (AValue.FValue > -1) and (AValue.FValue < 1) then
      result := FloatToStr(AValue.FValue) + ' ' + GetName(U.FName, APRefixes)
    else
      result := FloatToStr(AValue.FValue) + ' ' + GetName(U.PluralName, APRefixes);
  end;
{$ELSE}
  if Length(APrefixes) = 0 then
  begin
    if (AValue > -1) and (AValue < 1) then
      result := FloatToStr(AValue) + ' ' + GetName(U.FName, U.FPRefixes)
    else
      result := FloatToStr(AValue) + ' ' + GetName(U.PluralName, U.FPRefixes);
  end else
  begin
    if (AValue > -1) and (AValue < 1) then
      result := FloatToStr(AValue) + ' ' + GetName(U.FName, APRefixes)
    else
      result := FloatToStr(AValue) + ' ' + GetName(U.PluralName, APRefixes);
  end;
{$ENDIF}
end;

function TUnit.ToVerboseString(const AValue: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
begin
{$IFOPT D+}
  if AValue.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');

  if Length(APrefixes) = 0 then
  begin
    if (AValue.FValue > -1) and (AValue.FValue < 1) then
      result := FloatToStrF(AValue.FValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.FName, U.FPRefixes)
    else
      result := FloatToStrF(AValue.FValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.PluralName, U.FPRefixes);
  end else
  begin
    if (AValue.FValue > -1) and (AValue.FValue < 1) then
      result := FloatToStrF(AValue.FValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.FName, APRefixes)
    else
      result := FloatToStrF(AValue.FValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.PluralName, APRefixes);
  end;
{$ELSE}
  if Length(APrefixes) = 0 then
  begin
    if (AValue > -1) and (AValue < 1) then
      result := FloatToStrF(AValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.FName, U.FPRefixes)
    else
      result := FloatToStrF(AValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.PluralName, U.FPRefixes);
  end else
  begin
    if (AValue > -1) and (AValue < 1) then
      result := FloatToStrF(AValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.FName, APRefixes)
    else
      result := FloatToStrF(AValue, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.PluralName, APRefixes);
  end;
{$ENDIF}
end;

function TUnit.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(U.PluralName, U.FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol,   ffGeneral, APrecision, ADigits) + ' ' + GetName(U.PluralName, APrefixes);
  end;
end;

{ TFactoredUnit }

function TFactoredUnit.ToFloat(const AQuantity: TQuantity): double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := AQuantity.FValue / U.FFactor;
{$ELSE}
  result := AQuantity / U.FFactor;
{$ENDIF}
end;

function TFactoredUnit.ToFloat(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFOPT D+}
  if AQuantity.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := GetValue(AQuantity.FValue / U.FFactor, APrefixes);
{$ELSE}
  result := GetValue(AQuantity / U.FFactor, APrefixes);
{$ENDIF}
end;

class operator TFactoredUnit.*(const AValue: double; const ASelf: TFactoredUnit): TQuantity; inline;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := MulTable[cScalar, U.FUnitOfMeasurement] * U.FFactor;
  result.FValue := AValue * U.FFactor;
{$ELSE}
  result := AValue * U.FFactor;
{$ENDIF}
end;

class operator TFactoredUnit./(const AValue: double; const ASelf: TFactoredUnit): TQuantity; inline;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := DivTable[cScalar, U.FUnitOfMeasurement] / U.FFactor;
  result.FValue := 1 / (AValue * U.FFactor);
{$ELSE}
  result := 1 / (AValue * U.FFactor);
{$ENDIF}
end;

{$IFOPT D+}
class operator TFactoredUnit.*(const AValue: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
begin
  result.FUnitOfMeasurement := MulTable[AValue.FUnitOfMeasurement, U.FUnitOfMeasurement] * U.FFactor;
  result.FValue := AValue.FValue * U.FFactor;
end;

class operator TFactoredUnit./(const AValue: TQuantity; const ASelf: TFactoredUnit): TQuantity; inline;
begin
  result.FUnitOfMeasurement := DivTable[AValue.FUnitOfMeasurement, U.FUnitOfMeasurement] / U.FFactor;
  result.FValue := AValue.FValue / U.FFactor;
end
{$ENDIF}

function TFactoredUnit.ToString(const AValue: TQuantity): string;
begin
{$IFOPT D+}
  if AValue.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := FloatToStr(AValue.FValue / U.FFactor) + ' ' + GetSymbol(U.FSymbol, U.FPrefixes);
{$ELSE}
  result := FloatToStr(AValue / U.FFactor) + ' ' + GetSymbol(U.FSymbol, U.FPrefixes);
{$ENDIF}
end;

function TFactoredUnit.ToString(const AValue: TQuantity; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFOPT D+}
  if AValue.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  FactoredValue := GetValue(AValue.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AValue, APrefixes);
{$ENDIF}
  if Length(APrefixes) = 0 then
    result := FloatToStr(FactoredValue / U.FFactor) + ' ' + GetSymbol(U.FSymbol, U.FPrefixes)
  else');
    result := FloatToStr(FactoredValue / U.FFactor) + ' ' + GetSymbol(U.FSymbol, APrefixes);
end;

function TFactoredUnit.ToString(const AValue: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredValue: double;
begin
{$IFOPT D+}
  if AValue.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  FactoredValue := GetValue(AValue.FValue, APrefixes);
{$ELSE}
  FactoredValue := GetValue(AValue, APrefixes);
{$ENDIF}
  if Length(APrefixes) = 0 then
    result := FloatToStrF(FactoredValue / U.FFactor, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(U.FSymbol, U.FPrefixes)
  else', []));
    result := FloatToStrF(FactoredValue / U.FFactor, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(U.FSymbol, APrefixes);
end;

function TFactoredUnit.ToString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue / U.FFactor, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol   / U.FFactor, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(U.FSymbol, U.FPrefixes)
  end else
  begin
    result := FloatToStrF(FactoredValue / U.FFactor, ffGeneral, APrecision, ADigits) + ' ± ' +');
              FloatToStrF(FactoredTol   / U.FFactor, ffGeneral, APrecision, ADigits) + ' ' + GetSymbol(U.FSymbol, APrefixes);
  end;
end;

function TFactoredUnit.ToVerboseString(const AValue: TQuantity): string;
begin
{$IFOPT D+}
  if AValue.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');

  if (AValue.FValue > -1) and (AValue.FValue < 1) then
    result := FloatToStr(AValue.FValue / U.FFactor) + ' ' + GetName(U.FName, U.FPrefixes)
  else
    result := FloatToStr(AValue.FValue / U.FFactor) + ' ' + GetName(U.FPluralName, U.FPrefixes);
{$ELSE}
  if (AValue > -1) and (AValue < 1) then
    result := FloatToStr(AValue / U.FFactor) + ' ' + GetName(U.FName, U.FPrefixes)
  else', []));
    result := FloatToStr(AValue / U.FFactor) + ' ' + GetName(U.FPluralName, U.FPrefixes);
{$ENDIF}
end;

function TFactoredUnit.ToVerboseString(const AValue: TQuantity; const APrefixes: TPrefixes): string;
begin
{$IFOPT D+}
  if AValue.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');

  if Length(APrefixes) = 0 then
  begin
    if (AValue.FValue > -1) and (AValue.FValue < 1) then
      result := FloatToStr(AValue.FValue / U.FFactor) + ' ' + GetName(U.FName, U.FPRefixes)
    else
      result := FloatToStr(AValue.FValue / U.FFactor) + ' ' + GetName(U.PluralName, U.FPRefixes);
  end else
  begin
    if (AValue.FValue > -1) and (AValue.FValue < 1) then
      result := FloatToStr(AValue.FValue / U.FFactor) + ' ' + GetName(U.FName, APRefixes)
    else
      result := FloatToStr(AValue.FValue / U.FFactor) + ' ' + GetName(U.PluralName, APRefixes);
  end;
{$ELSE}
  if Length(APrefixes) = 0 then
  begin
    if (AValue > -1) and (AValue < 1) then
      result := FloatToStr(AValue / U.FFactor) + ' ' + GetName(U.FName, U.FPRefixes)
    else
      result := FloatToStr(AValue / U.FFactor) + ' ' + GetName(U.PluralName, U.FPRefixes);
  end else
  begin
    if (AValue > -1) and (AValue < 1) then
      result := FloatToStr(AValue / U.FFactor) + ' ' + GetName(U.FName, APRefixes)
    else
      result := FloatToStr(AValue / U.FFactor) + ' ' + GetName(U.PluralName, APRefixes);
  end;
{$ENDIF}
end;

function TFactoredUnit.ToVerboseString(const AValue: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
begin
{$IFOPT D+}
  if AValue.FUnitOfMeasurement <> U.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');

  if Length(APrefixes) = 0 then
  begin
    if (AValue.FValue > -1) and (AValue.FValue < 1) then
      result := FloatToStrF(AValue.FValue / U.FFactor, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.FName, U.FPRefixes)
    else
      result := FloatToStrF(AValue.FValue / U.FFactor, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.PluralName, U.FPRefixes);
  end else
  begin
    if (AValue.FValue > -1) and (AValue.FValue < 1) then
      result := FloatToStrF(AValue.FValue / U.FFactor, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.FName, APRefixes)
    else
      result := FloatToStrF(AValue.FValue / U.FFactor, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.PluralName, APRefixes);
  end;
{$ELSE}
  if Length(APrefixes) = 0 then
  begin
    if (AValue > -1) and (AValue < 1) then
      result := FloatToStrF(AValue / U.FFactor, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.FName, U.FPRefixes)
    else
      result := FloatToStrF(AValue / U.FFactor, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.PluralName, U.FPRefixes);
  end else
  begin
    if (AValue > -1) and (AValue < 1) then
      result := FloatToStrF(AValue / U.FFactor, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.FName, APRefixes)
    else
      result := FloatToStrF(AValue / U.FFactor, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.PluralName, APRefixes);
  end;
{$ENDIF}
end;

function TFactoredUnit.ToVerboseString(const AQuantity, ATolerance: TQuantity; APrecision, ADigits: longint; const APrefixes: TPrefixes): string;
var
  FactoredTol: double;
  FactoredValue: double;
begin
  FactoredValue := GetValue(AQuantity, APrefixes);
  FactoredTol   := GetValue(ATolerance, APrefixes);

  if Length(APrefixes) = 0 then
  begin
    result := FloatToStrF(FactoredValue / U.FFactor, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol   / U.FFactor, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.PluralName, U.FPrefixes);
  end else
  begin
    result := FloatToStrF(FactoredValue / U.FFactor, ffGeneral, APrecision, ADigits) + ' ± ' +
              FloatToStrF(FactoredTol   / U.FFactor, ffGeneral, APrecision, ADigits) + ' ' + GetName(U.PluralName, APrefixes);
  end;
end;

{ Power functions }

function SquarePower(const AValue: TQuantity): TQuantity;
begin'
{$IFOPT D+}
  result.FUnitOfMeasurement := PowerTable[result.FUnitOfMeasurement].Square;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AValue.FValue, 2);
{$ELSE}
  result := IntPower(AValue, 2);
{$ENDIF}
end;

function CubicPower(const AValue: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := PowerTable[result.FUnitOfMeasurement].Cubic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AValue.FValue, 3);
{$ELSE}
  result := IntPower(AValue, 3);
{$ENDIF}
end;

function QuarticPower(const AValue: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := PowerTable[result.FUnitOfMeasurement].Quartic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AValue.FValue, 4);
{$ELSE}
  result := IntPower(AValue, 4);
{$ENDIF}
end;

function QuinticPower(const AValue: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := PowerTable[result.FUnitOfMeasurement].Quintic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := IntPower(AValue.FValue, 5);
{$ELSE}
  result := IntPower(AValue, 5);
{$ENDIF}
end;

function SexticPower(const AValue: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := PowerTable[result.FUnitOfMeasurement].Sextic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
   result.FValue := IntPower(AValue.FValue, 6);
{$ELSE}
  result := IntPower(AValue, 6);
{$ENDIF}
end;

function SquareRoot(const AValue: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := RootTable[result.FUnitOfMeasurement].Square;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AValue.FValue, 1/2);
{$ELSE};
  result := Power(AValue, 1/2);
{$ENDIF}
end;

function CubicRoot(const AValue: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := RootTable[result.FUnitOfMeasurement].Cubic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AValue.FValue, 1/3);
{$ELSE}
  result := Power(AValue, 1/3);
{$ENDIF}
end;

function QuarticRoot(const AValue: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := RootTable[result.FUnitOfMeasurement].Quartic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AValue.FValue, 1/4);
{$ELSE}
  result := Power(AValue, 1/4);
{$ENDIF}
end;

function QuinticRoot(const AValue: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := RootTable[result.FUnitOfMeasurement].Quintic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AValue.FValue, 1/5);
{$ELSE}
  result := Power(AValue, 1/5);
{$ENDIF}
end;

function SexticRoot(const AValue: TQuantity): TQuantity;
begin
{$IFOPT D+}
  result.FUnitOfMeasurement := RootTable[result.FUnitOfMeasurement].Sextic;
  if result.FUnitOfMeasurement = -1 then
    raise Exception.Create('Wrong units of measurements');
  result.FValue := Power(AValue.FValue, 1/6);
{$ELSE}
  result := Power(AValue, 1/6);
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

function ArcCos(const AQuantity: double): TQuantity;
begin
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcCos(AQuantity);
end;

function ArcSin(const AQuantity: double): TQuantity;
begin
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcSin(AQuantity);
end;

function ArcTan(const AQuantity: double): TQuantity;
begin
  result.FUnitOfMeasurement := cScalar;
  result.FValue := System.ArcTan(AQuantity);
end;

function ArcTan2(const x, y: double): TQuantity;
begin
  result.FUnitOfMeasurement := cScalar;
  result.FValue := Math.ArcTan2(x, y);
end;

{ Override trigonometric functions }

{$IFOPT D+}
function Cos(const AQuantity: double): double;
begin
  result := System.Cos(AQuantity);
end;

function Sin(const AQuantity: double): double;
begin
  result := System.Sin(AQuantity);
end;

function Tan(const AQuantity: double): double;
begin
  result := Math.Tan(AQuantity);
end;

function Cotan(const AQuantity: double): double;
begin
  result := Math.Cotan(AQuantity);
end;

function Secant(const AQuantity: double): double;
begin
  result := Math.Secant(AQuantity);
end;

function Cosecant(const AQuantity: double): double;
begin
  result := Math.Cosecant(AQuantity);
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

{ Helper functions }

function SameValue(const ALeft, ARight: TQuantity): boolean;
begin
  if ALeft.FUnitOfMeasurement <> ARight.FUnitOfMeasurement then
    raise Exception.Create('Wrong units of measurements');
  result := Math.SameValue(ALeft.FValue, ARight.FValue);
end;

end.

function TDegreeCelsius.GetValue(const AQuantity: TQuantity): double;
begin
{$IFOPT D+}
  result := GetValue( AQuantity.FValue );
{$ELSE}
  result := GetValue( AQuantity );
{$ENDIF}
end;

function TDegreeCelsius.GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFOPT D+}
  result := GetValue( AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue( AQuantity, APrefixes);
{$ENDIF}
end;

function TDegreeFahrenheit.GetValue(const AQuantity: TQuantity): double;
begin
{$IFOPT D+}
  result := GetValue( AQuantity.FValue );
{$ELSE}
  result := GetValue( AQuantity );
{$ENDIF}
end;

function TDegreeFahrenheit.GetValue(const AQuantity: TQuantity; const APrefixes: TPrefixes): double;
begin
{$IFOPT D+}
  result := GetValue( AQuantity.FValue, APrefixes);
{$ELSE}
  result := GetValue( AQuantity, APrefixes);
{$ENDIF}
end;

{ Helpers }

{ Power functions }

end.
